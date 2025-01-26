Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92D9FC02181
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 13:11:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tc2PS-0002sT-SF; Sun, 26 Jan 2025 08:10:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc2PJ-0002sD-Hw
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 08:10:33 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc2PG-0002Ah-QZ
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 08:10:32 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-218c8aca5f1so85424575ad.0
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 05:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737897029; x=1738501829; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1z1aHP+At77emV5+nuxb026apf9cE/XcUtUXabkA+SM=;
 b=XmQ1qYWYDU1E1T9p5fHpjCwY7B9NNA81QrtlYcyF7lGybzgE8pHzK21NTjdqYcuFGv
 OzMRvffbUzQb20noobJmvrpxBvd/GqMFDROpcXC8ms+uOyZPxAIfy6ZGLLwHpSIEimQS
 bLNvGuec22+TijjfDufKJNn4OdRKKstEYplaZEPsN6QBgGCwMGKuGHvyambqq1/u5+Jf
 TmBHRJ3Tsj0vXyvaTD6MQVSz28jjCZzPuXCjCM85M6ecWsSOvP9RdljaWjvu6d69hzBU
 98yLGxMZ9puQwFZfBsaNiQGHgWt/UEFY1uXQie+s1Z2YeEZYX1FLnocKHihvA77btaaL
 hDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737897029; x=1738501829;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1z1aHP+At77emV5+nuxb026apf9cE/XcUtUXabkA+SM=;
 b=MGm7f+7RCQjgyV6LE7sZw/eLb2EnIF//oSq/Ho6rLKpBVDFSqkpoDgorhP/d5w+vmz
 UzBqRalbzN9a+PNF+T6thI72J7IyBf7B0VX04QK0C2+i/Hzij5uZp/QjlO4sP4B/9ZQQ
 aHRdyhaRkoBF9BRTJxFNyCm7L4wSzsnyeoey9gcNuY48ZLckeP46RPDG+ik1VgojmP5N
 G61eHEcqPH5lc3BsU0PSwYFpjs0aFAQMpx32ouuEyOBtb26ffuRRw98zTXpl95FzXbz1
 LOMZn3dzSWjWhk09SaESHgeRIDifDWDe7xrvoulfvU4hJ89vg+m58rMBc/Jc9bThl+vw
 G3tw==
X-Gm-Message-State: AOJu0YyVwtcZwNMoM9ttWwNVyjHV3AUwJ620T0WDvqu87c/Gf95E8U64
 R4WcOIGHMyILsQkFCajh5fhGQbE1C2eNnUeSPhYCdqHi8zJP3isYq3IeqMo+FZR/OX360VMK9kW
 k
X-Gm-Gg: ASbGncukMQj3ni4LpYdcZ4CX/kdery4ZmdkKg2vQJqOpdiKr1/5EVnwDmZCfY++qfuZ
 oSqZkjPo0KQncaqrR4R0FHkijvc3H9S4D2FnEe4iYlLNJ6hZtr9zIhJFvQ82ger+xVyL8MLZJGS
 SomAGPhnb/4LtSkZTWzbXCLwbxs+GTAGo1FJaA0GzSxQhwV/boVHaQ0faZerDkSnKhkqWoYh1dy
 c0o2nNbrjUKIPwIU21tRi5jqnuz40KTFqV74iDUAEvJSBhDoE9KH+MzSVcUsbrbrp2hEd+GlY7p
 Cs7SiC2CJXSOlW5XpWLlB2E=
X-Google-Smtp-Source: AGHT+IHHGMpHXVKA9lh7iRe7Gah1XwuWHN70316udNEG+A7c2M7onUsikTcHgMc7pqsNAhXUTGPeSA==
X-Received: by 2002:a17:902:ea03:b0:219:d28a:ca23 with SMTP id
 d9443c01a7336-21c355eea74mr568445925ad.36.1737897029016; 
 Sun, 26 Jan 2025 05:10:29 -0800 (PST)
Received: from [192.168.163.227] ([50.225.135.10])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3fa8420sm46007745ad.102.2025.01.26.05.10.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 05:10:28 -0800 (PST)
Message-ID: <d46d0d01-4e55-4502-ba6b-a459d6650c1c@linaro.org>
Date: Sun, 26 Jan 2025 05:10:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 59/76] target/arm: Handle FPCR.AH in negation steps in SVE
 FCADD
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-60-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-60-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/24/25 08:28, Peter Maydell wrote:
> +            if (neg_real && !(fpcr_ah && float16_is_any_nan(e1))) {
> +                e1 ^= neg_real;
> +            }
> +            if (neg_imag && !(fpcr_ah && float16_is_any_nan(e3))) {
> +                e3 ^= neg_imag;
> +            }

Drop the neg_real/neg_imag check?
Or do you imagine the is_any_nan check to be more expensive?


r~

