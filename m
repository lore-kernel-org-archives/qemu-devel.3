Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BD26C7115D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 21:12:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSMYf-0002H2-3W; Thu, 19 Jun 2025 17:12:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uSMYc-0002Gq-0c
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 17:12:26 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uSMYZ-0008Lp-Gj
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 17:12:24 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-23508d30142so16037315ad.0
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 14:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750367542; x=1750972342; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rCQUK+3NPdVQlCKPZXchZGW+PZbQBkRdbf+BwnqW8xI=;
 b=A6CQ+kFpCrsl1sbusQghVJ89sGohghlfNuw06OnpBhSklgtRMxJmsrQhOdtx2s31qi
 0mp+rFGPl9FazoEec6XbHhFdrPzZDhm4CBW/kOOV834s52CgfoIZNj3uzoN5Vat2vD3w
 ai7t0ECm3wbFvBcm2aqKfKir5P4kO6YMcYKwJjB2Q7/bDM7vvnfnygMYmY7NCUc1/hrp
 fVBcFKuOomHlnuXDkyaIP4ZLAjzX05o624VDfMy5Ux0eRtWfLte6rqe9El06pHqTaBIy
 ebl0kkl/kNleCM9GPjMcJW1kpeqtmfkiljKUL28WgrS+90whyTF/iO52TM6vAMGi/rZo
 U1Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750367542; x=1750972342;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rCQUK+3NPdVQlCKPZXchZGW+PZbQBkRdbf+BwnqW8xI=;
 b=PsQYZdGuUTTEhrBKwnsLnb4rxb74eAi8dG2no1F5Bq/lnmiv1l/HzEZ5GhIpj/57N7
 oEPwtatNzm+z6WbZYQN3ddi9X3gr3dBgRgMoy2DS3QarZC5EVnoUPadXz4Re3fNjmocN
 oHKUPDfwOifoZH3b5aNFRPh0mU7O1ZbhkavxIVUWBmu5jZC6TSYP5l+TR41shc6AQTfY
 bqhJB6urb/XjeUz2S7EztrBe5lsKdRLgTnr+NuVNqQVmni38HNw3ZQzX/4cnmov/NAnM
 ugyDIlR3MF7VK5Msy1njv3tou6XoSmbrwXVcDsxJD8/JlNwlghf6LKhBqlK/w2GOTinp
 4/FQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLc6roD/RjdJc/Oq3bFqtj5aUxKaqHW5ZyQERtC65ry92Xi9KWIwHDZzUPbwQRr/JH40wdH2mnR5PR@nongnu.org
X-Gm-Message-State: AOJu0YyeqLuIrXhp53SaY2SELeuiyZh+WAa1o6Lrmjs2w/sXwlNDPsy6
 j7IkihlJS6zaChsDs5DOv5nahOu2SwitT4L2OvFTh25DsjOowrtFiDzOXjdOnkMPZs0oaktF27M
 Vu8jrSc0=
X-Gm-Gg: ASbGncsTyONpKtuFrereNjFx+V9Dq4DDw0P2C2M9QnlyJV85h4Pe51edwN1LCsw2M4m
 as/+7OXMHGxSzmAYkJSNf0oTcKZj5TPjgIUEtNeRmf4xo9z2pfe8x83IY/bbo1O+bl0/pfzU12l
 dSiOIXXv5pqDGZKxntqhHdy7KStJmNCRKbatMIC+XVNLNkwf4pfTH+0BKKbfCQ/Im2vs3UAkw4X
 iW4ai8fe84dXi+zAXojyuZK+qdDsSmMp3FxSyJNeL7gXxTij9ya164aRe6hVMQjnPzzWPly1+Jh
 6Hf+GW6EAsXokPvDzBAu8j4Cf6YotcUwBYHBfbzxen/nDFk2vyp92mrgTLcdR1x3O1DrMaTU4S5
 Ig01vWBJFVtRlrTZwPiaiGCjnAEPy
X-Google-Smtp-Source: AGHT+IGb2KX9OVSAuS9GZMJJn61ByZO4YCTf+KFDF6yzWj+38NRNOgpeIPJByC9xknapLVUNIFKkxA==
X-Received: by 2002:a17:903:320b:b0:234:8eeb:d809 with SMTP id
 d9443c01a7336-237d9b42e77mr4183175ad.43.1750367541963; 
 Thu, 19 Jun 2025 14:12:21 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d8650f51sm2357215ad.148.2025.06.19.14.12.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Jun 2025 14:12:21 -0700 (PDT)
Message-ID: <754676e6-0af6-47b4-8cc8-9fa6400771a3@linaro.org>
Date: Thu, 19 Jun 2025 14:12:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/20] target/arm: Unify gen_exception_internal()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250619131319.47301-1-philmd@linaro.org>
 <20250619131319.47301-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250619131319.47301-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/19/25 06:13, Philippe Mathieu-Daudé wrote:
> Same code, use the generic variant.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/tcg/translate.h     | 1 +
>   target/arm/tcg/translate-a64.c | 6 ------
>   target/arm/tcg/translate.c     | 2 +-
>   3 files changed, 2 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

