Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2258E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 18:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL4n4-00010w-2G; Tue, 10 Dec 2024 13:16:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL4n0-0000yQ-V8
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 13:16:56 -0500
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL4my-0003ED-Qn
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 13:16:54 -0500
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-29fe7ff65e6so667863fac.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 10:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733854611; x=1734459411; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r6HTMDmQSuBMQxe3w/4oXBcBJvahHmuwjAuIZ04ZE5o=;
 b=V55h1h+vbQB7SCrShmFJdUcblV+almyIeP8qnnpZHACTl53BNCjQwXtVfDemJsSTpD
 T139oIdzQ09tPqBW9NAuSzEod2EmH6gqIpga8vz5BFc0Wz+vESM8n+IVLwdD3JnMiF/V
 5o/C0YF/loAeVBVZrfnruh0CKaS3yva/WKpfWPzw78vwxueWiiRKh45mD1gpQB5m9a8f
 b6KwJCk518hCegjxztfyKEdv2SS/ZAzjs0vn3CpyFCyf2WCjmZqsUoMSgcRgRjIA5TqO
 m2xyDAEON83OwEmwxm4JluWFxGNPYdZTA3jplVMHEnjsFv2eh2OyhealSsNzdxlVZG4y
 x5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733854611; x=1734459411;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r6HTMDmQSuBMQxe3w/4oXBcBJvahHmuwjAuIZ04ZE5o=;
 b=MG0RgSrHrXBcigjmXuC7OLNhbk4wm5ZznO57RRdgy30TMjiX5Zf9msJ8IAaWpUW8SI
 xQCighnwFlCW+G3qtqIEe7LHK/NLe576klkA3rVatE7rLdl3/61VjUYt42AAufD+5YsQ
 znCiCMGP/RQLreVaVQzrsew6wTUIBh4qsqrV3HPqo3r6JwCZORwewZiyyT5xjmMfTM6A
 NCwtq+NT/g9AJtab0NGRoLz4zQcbfRnMDUhhKOiOE/PU+HhXz/S59ms1ql7tZisFMHbO
 7WMDcve4z0xvEMcAH4tI0jeZfxNGhdtUJnKMrYHJvh3L2LgSpPCZG9AtsEMEEyB//O/V
 oMGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3sXskIkj+j887MPns4NtwRIW5xtgZ0OjKEkMiVV15j/27WxLYvoSQ12xQXrZcBkK/9ir6HvVn8Whd@nongnu.org
X-Gm-Message-State: AOJu0YxFhdV8+RuQ3/x01opKUzXzk4TprxcNWZHWcwXUP/2o/Wtd2Mp0
 dpjf93xP51o1JafgEKzrI4suGmbYgRDm+qvJmY6y2Q2fnP9s37n0kxh4SQuarjg=
X-Gm-Gg: ASbGncuvRHHMK9YiQV8ZKqtDw1k/9yDxc8lTFT4NJCXLhmiZOKIg+6JVaBB0hkAm39p
 QhfnCBp0Ko20kjCTcLUaTCu5TFW/ihDSzGMEct3EZOD921uRPMiMHCYSi21k56RdIEC9AK5owCd
 lF54ca5TbvV2c7TIefNZsJQedJT/ijigAmr/Log74AX/GCBYVMQIBahhqfrDiHIMqj6LJqsstBN
 zLaJ9mPabipol6KNxSoHJ4+CcmRFID4vr/RPrkMs0p3iUQhTzBkY9SPKowezSCsKZ8w3uk=
X-Google-Smtp-Source: AGHT+IGszrUioFZmJvmFHzQt8jv6rLdEYUw0uYWFDwlr7LDY1RNKOIYFgma3Y7VvTTwesjByp2zzFQ==
X-Received: by 2002:a05:6870:55cd:b0:29e:76d1:db3b with SMTP id
 586e51a60fabf-2a012bd91bemr97016fac.5.1733854611162; 
 Tue, 10 Dec 2024 10:16:51 -0800 (PST)
Received: from [172.20.4.119] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f2c9294f8fsm646356eaf.37.2024.12.10.10.16.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Dec 2024 10:16:50 -0800 (PST)
Message-ID: <33c1426c-778b-42c8-baac-94eb17fe0f09@linaro.org>
Date: Tue, 10 Dec 2024 12:16:48 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] target/arm: Move AArch64 EL3 TLBI insns
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20241210160452.2427965-1-peter.maydell@linaro.org>
 <20241210160452.2427965-6-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241210160452.2427965-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2c.google.com
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

On 12/10/24 10:04, Peter Maydell wrote:
> Move the AArch64 EL3 TLBI insns from el3_cp_reginfo[] across
> to tlb-insns.c.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/cpregs.h        |  4 +++
>   target/arm/helper.c        | 56 +++-----------------------------------
>   target/arm/tcg/tlb-insns.c | 54 ++++++++++++++++++++++++++++++++++++
>   3 files changed, 62 insertions(+), 52 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

