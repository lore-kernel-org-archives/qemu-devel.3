Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B3CEE98FDC
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 09:44:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAlvI-0004PZ-BS; Thu, 09 Apr 2026 05:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wAlvC-0004HF-JK
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 05:43:36 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wAlv9-0002oY-GV
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 05:43:32 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-64edf260b49so1031139d50.0
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 02:43:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775727810; cv=none;
 d=google.com; s=arc-20240605;
 b=NINvLfCOjzMV2mINIp5c8SDqgdsden+C5g/r675CT55SJx7U32Hr72MR3gqLvi3mTR
 40Dq74EXHO1vYH3jJ5xlSvAsP/B/cUJJ8vBKZCNA7He1XkP/6JKq6NXVh2i5G+906SAm
 vex2S+fkXjx6oZAnGM5ZMGDaSd+ytldQDXJ10r44I/vDOrndbBtt9ZOQvdFbfMIW7pyZ
 +DjmzFEckWU90WY5FC5X8w6eAAP1Ql04++nsx8vs/jN0nmMnWy/826YlcTRdzC61Y7U2
 CKYYdVoHBfKe7hLp0liKMS6S/WcJvTOcJm0Pze1nnyMN1ObmrLDNCtUQ0Y1m7HKTje1s
 x+4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7DY5vgoK0OPxe5ysWxdHMOOyaxoUFNwyCJ8ueUu29KM=;
 fh=ZqPVTEDghJbO/O/Ejla232P63L6N6DvTIi6uVG9cmQs=;
 b=jC+4bUnypJSq14+o0frKExFqqX6kkDgXVyBi2m7C/Llsx66Rjw7v2pPWBTg0g2Uakc
 4ixFFmQ5qtiNVHnhnLpNUTstDiWzKqLP4FPyoKfXajnV/8p0PFkMWj6TSSImqxlS4A86
 0hkjTb/uJajBjapc5Q6VUgQfbwo7NpZW/X+GYQfVOkL0ycKPF1ljIYMtwio/R+Fo4v1B
 DUPF6UOUSxb5/21R7jYOH6Rs1rmPcFDipTvvIPMAdM4OLJOTHkFxVyWIx0qOIt3AUFwj
 3kETslhDzZYnucQBkBLUE7ChH3fpPYWsg2kgXlShnV6FChtjvPpQ3Acd5TLfCTxhZkYd
 bNSQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775727810; x=1776332610; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7DY5vgoK0OPxe5ysWxdHMOOyaxoUFNwyCJ8ueUu29KM=;
 b=l19sUWUiIP70LX6Q7jIhe5B0YGKWALm3Ya9u7DwqIXB9WGaB75RPVGONuiYXtFsKn/
 GXxuA5LoLXsrTS8WATbB+3w9CjLr1cbbqNJ/3aDsmuEldq8e12Q60c9DJgJrPEgNTbx+
 +SZndGgp7t6OpzdGsJsWGgGkuEsVHab+Z3RL4lD4pyJYaO10HSpYdBQvoaGjeQTNIExZ
 u5JJVgKognB6kr4GxVgy3fuGchgVTnEoBS8JcXrUyrYCf5qGoxd7+rUpq0G6RdkvnBa6
 IeohjhJTb+E3d9zDPHh6JvsNuMqKvup5N2X9upIuRiZxC9pT+TTtTaPAhFDo7h86rL/M
 9OPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775727810; x=1776332610;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7DY5vgoK0OPxe5ysWxdHMOOyaxoUFNwyCJ8ueUu29KM=;
 b=qbQkOi7U//68iOyi6Jf+QpU6c30P3o2HJevH/+UYQI14tVZyBZ29fDIvbiFzy5Q1Ne
 1+2vIyj7Km3JlrxdcXJlHIzq9SHogcf0wHYlt9902CAQ4R+oMqz56yjqHwRa5VU0Fwl7
 9r/mRNYYBiqazHUHkU5RExHK10Nn0BJHupOXE7kTj60g0TMat9BE/DXBF130cS6a+Mzr
 ijU7pu6u+lTGsvzill9GNgUo5qyk6Icg0Y+GS+2Tv7HT2U1fjPCBa9/Bw7vy5H63BcFc
 hwxYH95Qb7tDpJJuk/UlThnm9HjhaTMiwsz8McJ21gdtc66TKgSg7J9D00IgtHrFYrtm
 u+4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUemYbb/j+PUei/xSIMhedcET8wNYou8KjByWa5iV0BVNuwK4rzNdlDZLQ8REat64hajttRlu08czNq@nongnu.org
X-Gm-Message-State: AOJu0Yyt/kA4n3V6MewkxXSB1i9PLayCvf4tF71aEb8BYobSNu+zlJ/Y
 ffhSWACbmxtNeqJj3wfqKB3WPpLD48uPa6C+LPA1c/NmUQrXx5yt5mPkbaqdFvOhK4Y/UnhO5Xg
 XjIPVMf3Lg1zCZVN4tEkn27TfdOeUbOtVGsKL97/ueQ==
X-Gm-Gg: AeBDietT5Blf1AtUjdhwyrSuWQlFit17+zPENS9omtdcusJTxrmfS1PyeizZJ3qRShv
 peGzMQYR05pLanHM/Pe9OyXhz6kzzr/L3vLHWRDsybFrqIBOxgLTm9JhqZMGtpdZRTEhmdqahJM
 hNYh6HYW9g+2RC8lPwsXBrCOtNz9GztQjOr5R0PwQ+7fgaS3mhwB8f7XAmfqGpATKS8gvNJ2E6D
 Z+0VPqJVWzkyjaVtIQ9YPt53OMWgDtqsJgIDYkbZMS3kfRJfSvYgOEoNdLMfq4g+cQ4ypLSVfOx
 Wv8WsNR0GOW6zSz1wWmwK6jCeuJiXHQicoT8i8hiTFL97Uxn8177IfO020/Kmp7rAPA=
X-Received: by 2002:a05:690e:1502:b0:650:26c1:ee84 with SMTP id
 956f58d0204a3-6518714b9f5mr2069174d50.11.1775727809775; Thu, 09 Apr 2026
 02:43:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260409-fix-unit-address-v1-0-946840930af2@iscas.ac.cn>
 <20260409-fix-unit-address-v1-1-946840930af2@iscas.ac.cn>
 <b7273509-0161-4b2e-bf4d-28b648f71209@linaro.org>
In-Reply-To: <b7273509-0161-4b2e-bf4d-28b648f71209@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Apr 2026 10:43:17 +0100
X-Gm-Features: AQROBzBTK_KqKGLcQvAFpVWYtJwjO6_0s710KQOQJSWNSOEWuGi3cV-mbZlTYvY
Message-ID: <CAFEAcA-z1GywU7qaoWQSDCndSzkT1ZqZiKL47Wi05d430qDyMg@mail.gmail.com>
Subject: Re: [PATCH 1/5] hw/arm: Fix unit addresses of FDT CPU nodes
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Vivian Wang <wangruikang@iscas.ac.cn>, qemu-devel@nongnu.org, 
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>, qemu-arm@nongnu.org, 
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paul Burton <paulburton@kernel.org>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Jia Liu <proljc@gmail.com>,
 Stafford Horne <shorne@gmail.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 9 Apr 2026 at 10:39, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> On 9/4/26 08:40, Vivian Wang wrote:
> > The node unit addresses should be based on the reg value (which is in
> > turn based on MPIDR), rather than some arbitrary number [1]. Also, they
> > should have been in hex, not decimal, as per de facto convention [2].
> > Fix them.
> >
>
> Maybe worth to add:
>
>      Cc: qemu-stable@nongnu.org

Why? What bug is this fixing?

-- PMM

