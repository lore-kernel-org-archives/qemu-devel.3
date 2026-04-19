Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE41EEA71AA
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2026 21:11:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEZPq-0001We-P0; Sun, 19 Apr 2026 17:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wEZPk-0001VR-D0
 for qemu-devel@nongnu.org; Sun, 19 Apr 2026 17:10:51 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wEZPi-0008HZ-Cz
 for qemu-devel@nongnu.org; Sun, 19 Apr 2026 17:10:48 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488a4bc360bso14121095e9.0
 for <qemu-devel@nongnu.org>; Sun, 19 Apr 2026 14:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776633043; x=1777237843; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qsg8rUeDLQZVLVVnW8TfPXsM/XMptyJ8w4S6dfSGN0c=;
 b=QIXnzaz3bZi4iOXRBgGf/zPraXDeD249cZS32Cf8GfHFSXSW+NTamVVTHBEftOgGhJ
 GRB6btX9wwWteFjvD+kkis67VDg/wCc+AauFM8bDd6NkfyaC5DCzTq+3uaj1+mKc2qD6
 DhavKo6Rixh1I09n0ZyTptq5miAt/XueUNgMijCAXbsPdooAwVwH+yTiXa6BmNzbvIw6
 SNwyXgsN0HMy/Zn6BQ6TrAc+TBKKJP+vAYyr5xjyahBFggh6U0CaR8hoTalU5ill9qcH
 cx4qlrma7TcS1x+lEsDAEjBNCA0R/XQcz4/OdTMy6Wi8IKtDegpimI0qY0oLdvNX/HGT
 szKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776633043; x=1777237843;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qsg8rUeDLQZVLVVnW8TfPXsM/XMptyJ8w4S6dfSGN0c=;
 b=NSlrpXuXKFkX+Ytv094W8TVS5BiyHJ1ShXcZIlMD7PbdGQBaNoNczEj39cS5QHgAXM
 FOc/R1DhBdiBXnOeUBRSgxomDrc6mE92CkN9ooQJ/skmkvmD9W442sfiPAqMab0yLSV2
 KZLBnMQjL89j24SL1LLyU9RsKUJK4j2iXleqa75Pbvv41JRgZ9tkVbPLa4MSxvp9VmJM
 kqMAP4CyEHI7RyZ39sF0f0LMH0GyPdlHBTG7r1RtfwiaeEeXA67BwzAhPi4ocuGzpTyC
 fRamWPFLJiZKtbtHO8ak+yN9XDQs+sipuoPu4O23HgdyMflhUpcE05K8k6jEQggy2V0n
 vR5Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9O8Z3NFPj/b4spc5TtMsC3IV4lViQPZGV8mSmZonG1zSiKYB4pQUQ2SIARHUWN/TABtD9zf4iX6LW1@nongnu.org
X-Gm-Message-State: AOJu0YyHVn90Z+tZBQpMNlU7DXcDpl9uIG2GOBoyklzjMjAaI+IvH4WN
 DA+e3DlaARKaaRU4uGAzLHCAKkJ1wTOLbDLA2WKAzX6lDMrutiPQj4xdJxOtMSBSOnQ=
X-Gm-Gg: AeBDies41P1TRxicc06lESUHghU6Jc7ydYWpDD9ZhuvNFvTzovWaPdiybMaO1YGETB8
 F5fGfZvlpcINbq7SxEIeMErlXGY9zYhKyMZcpr2L+yqjJAPtxl3DIe2fPmYHSHHEt9UxtIcjfpx
 heAfvcG+2GZuZQz7HtWO9dQhGvB6OIcX7ikLdRHTQoj6ltS4XRLvRfw4EAHUEgjVqHceGpx6KxY
 F18cwKVh8Oq93kBCFvxu3zgka36ZrIzko5f5g45nsxi5DXg8EH58UiKL+yteFMB3QTrn5Dn6uBx
 3dBqPlZFXpR+ZkuTIFDJOjQ00mxFQJrGrzcj9ENwE2efcYoV0I/TFVuM1Xqpfdc3c2u47LBQnhb
 x43Yguzrkal+BQsiJ99bd4uTzKLTJWAQ7voazM1C+lLsz6E2IwTutR+CwhSRu9YuxSPq/9vjxHi
 do+qpkJJniQ82Bxzoxibtz7wn8Dl0syvN+gxiPADvE2zzjjRSWZ29I0VYblJ/08xw7/Ap88owPQ
 S8E
X-Received: by 2002:a05:600c:a30b:b0:485:17a7:b9c7 with SMTP id
 5b1f17b1804b1-488fb750a2bmr102595625e9.10.1776633043197; 
 Sun, 19 Apr 2026 14:10:43 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cb1682sm24603336f8f.1.2026.04.19.14.10.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Apr 2026 14:10:41 -0700 (PDT)
Message-ID: <e3916acc-98c6-4ace-b990-94084597563f@linaro.org>
Date: Sun, 19 Apr 2026 23:10:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0? 0/6] qom: Restrict compat properties API to
 system emulation
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, kvm@vger.kernel.org
References: <20260325151728.45378-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260325151728.45378-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 25/3/26 16:17, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (6):

>    hw/core: Move compat_props_add() to 'hw/core/boards.h'
>    qom: Declare GlobalProperty structure in 'qom/compat-properties.h'
>    qom: Declare compat properties API in 'qom/compat-properties.h'
>    qom: Restrict compat properties API to system emulation

Patches 1-5 queued, thanks.

