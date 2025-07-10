Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC706C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 17:16:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZur9-0000Qt-5g; Thu, 10 Jul 2025 13:14:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uZuVq-00023l-53
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 12:52:46 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uZuVo-0004gd-JY
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 12:52:45 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-735ac221670so728258a34.0
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 09:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752166363; x=1752771163; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AOCKLzvgwyRaVbXc8OUNg3LrwEOBU5DsNKJaUBhRM1E=;
 b=cWX2BCwf6SQdF9VFTPqs754zgjHmeK/Awfmi0WVRjbMXtW8F5kcIuPxq8GwwxP43/Z
 JhnFBmRoc/ATO17lt/vGSqiWvRf+tLcvXI/OQJ87XJO7j8unnEdlenLRSu0GbRH3bsNa
 A2TuZ589LHbTv3mpvE+BT9ERp/HhLpGQcBHMb/Vv4QgxIEesehMMXfb6ptHSkC8qpBXU
 zSRPbQ/4qkHJROd+WhjWuULse1mFXqIPAWSnXWHu9NiWLVbYhe1xryJ+2uNlPw/wSqUs
 3TR+nYOECIrdTO5IDek12Rdi9PoP+/ITREVt8hOTgvQ6OSYwp9aoSIQJgdLhBCAIJSTr
 TORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752166363; x=1752771163;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AOCKLzvgwyRaVbXc8OUNg3LrwEOBU5DsNKJaUBhRM1E=;
 b=ML75r9FMSdjTcTiOoA6neDxsdu5RNOlWMRj2MXWICYNjXKCgDpDab9iOnPu7vUHf7R
 /yMNCgyjyx8VhVOYcyUjVMumO3PhHmL54g84rrtf9fl8tUuNQ7BZgnsliSL1knzMZqi5
 SM/A3T1gpoVvJ4v9e//orXFN1Z+Z+rZeOrChO5G6oVGJcm+WsOdDWG890qEA3LmaPaBN
 1F1y6xFvdvWrXf/AiC9jnq8gQQtPzgrwqsZob3I1UvH+tFp8Os+MIDrBt02XoZbcbLDM
 b78jNd3Q/NHfXN8E+8L0P2F41WNOEo9L6iFyOrpO9v0940SJwIvWOEAd83RzJgBWsDfE
 +AAg==
X-Gm-Message-State: AOJu0YyKZM23pGrQPWnaE2QSejT0vFXbzlpX3LSFtzjnpOylKD2n+aVp
 75bgPpwoYh8tiOMthn+WuYM+GsgcKnpaQQjAF4eq08KclHxMT06MJcwaAMwmCD8qzj0=
X-Gm-Gg: ASbGncugqib1wJu5Fv39bh7MyLq4hFZCeYMlejkECL8Jx9YqDxBIuvSaUtJ4fDTdjgL
 6NqBnRs43e+u7tU+SMiHcGCmfsWijNE6jWbVpS0Wp6WTLGTLRSOiYBpytvWPfqtH6T3fMxvbnBF
 cPkw4Lg/cjYYhIUspklUDMqwzal5LyfFTTfVq1GWFA9TI3Vz7M9T5ZaeBoOK3VnbNdzt3jxla7E
 GuQma/hx7MAJK3eltc9sph0ERB/u1TcQJlntRG0UZ+QKOW4P68FpfdPrL8Q1B5XpwilEzfSbP4l
 ETyq1o4c3U0O2CR4Ejvg4UGgkwH9+A068Y/e5lylA5F7IxWEPv+97cri9GkSpCNoSoDuDXw/nJQ
 doSg=
X-Google-Smtp-Source: AGHT+IEn00vcDeUbeBiunbkstGsyHzcrN40DrCEH+0KmljO8SmPVYTFG6/wg9urg61X2H9hXwBPjTA==
X-Received: by 2002:a05:6830:3101:b0:73a:8a05:cd3d with SMTP id
 46e09a7af769-73cee93825cmr2958245a34.0.1752166363158; 
 Thu, 10 Jul 2025 09:52:43 -0700 (PDT)
Received: from [172.20.0.130] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf108a6ebsm265504a34.15.2025.07.10.09.52.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jul 2025 09:52:42 -0700 (PDT)
Message-ID: <47434f4c-a47f-4995-a434-01c043a023df@linaro.org>
Date: Thu, 10 Jul 2025 10:52:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/6] target/arm: Add FEAT_TCR2
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org
References: <20250710163858.1094780-1-gustavo.romero@linaro.org>
 <20250710163858.1094780-5-gustavo.romero@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250710163858.1094780-5-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
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

On 7/10/25 10:38, Gustavo Romero wrote:
> +static CPAccessResult tcr2_el2_access(CPUARMState *env, const ARMCPRegInfo *ri,
> +                                      bool isread)
> +{
> +    if (arm_current_el(env) < 3 && !(env->cp15.scr_el3 & SCR_TCR2EN)) {
> +        return CP_ACCESS_TRAP_EL3;
> +    }

Still missing the arm_feature(env, ARM_FEATURE_EL3) I mentioned.


r~

