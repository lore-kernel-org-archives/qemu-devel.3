Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D11C83F26
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 21:12:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugV8A-0005E5-92; Mon, 28 Jul 2025 17:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ugV4x-0003oH-2Y
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 17:08:19 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ugV4u-0001p6-PU
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 17:08:14 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-748feca4a61so2988696b3a.3
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 14:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753736891; x=1754341691; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N2KO9SrSdATz9cAYBMGwMU629nJlpzz5B0m2CFj0NKA=;
 b=sbVZPdt+NHuupk9f/w/UdDlWFyQ6jNqYdQoKxiHYIJCU1GrZtioaCFPxXi5ynYERTx
 UgKLiDE27pQuNlokSz1uMgbLsK9f0kUP41c1qG4Qp9x+040OcKlyffYq0UheXfKUMt68
 g2Kk/ITXNQM+HcZ0sUA1zwkwZT3g9MuWeKI8/E70mURFcsZil9acC770XX4NUp4aesn9
 bDBvvETmifDo83E01C6yKyV6KR+vIakukTvZkNhGV58UbiHVh8loIDQE9P9OPVtmPx6T
 3GT11pJ7bepGNJB8NsU0XCqMghhNHiSsN1RpZ/iRWbi3MlfW5/rV2/YfHGqOn5NjhlrK
 8mfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753736891; x=1754341691;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N2KO9SrSdATz9cAYBMGwMU629nJlpzz5B0m2CFj0NKA=;
 b=fNxveqMGOVDDBQN2zoHLfE+YG/jUVZYsw9B/2eqIxatvGP7kmmn/7trtmBtOuxc1bW
 TWXMikz8CkMbEoiYMfmsoCffpjeESB4Zg5q1bKi+ioNRb9qgqerft86fuhJ30usH/wmG
 8gLBcKpR3/I68HU7MJ3D4b4q0xm0Nx9tUtK9VxYzjKI3Pes10Lyqx1g+YAp46oC5W8lF
 IGD9Q4+BZE+0K0lCvYiFFHAyyeVXDjTpfllHwZkGD/EkVgGQkJt72IueLw2lSmVPq1G/
 Nr4h3G/ERz/kj5XDYJ+ExSnVb+nsrJzZ+jZVtZHrO9M9yGN+SJqORltpBYDbgLEbB7tg
 rlZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXv9AkmgcBv1yMdSpP6BTy0qVH7ZsDjKWBNpDQ8FbFABRO9gESqVX+RaODUwZndlbuojORxCg/PSNVg@nongnu.org
X-Gm-Message-State: AOJu0Yy11ciaM4d2Kgx64sidgqhj7AWw8KjvN8twmgli1AnnUxf5uRTR
 CDSKkXOrAafCZayEDljTtQ9GYNIfINTtBsERD8rgqHlBjC1EPx/yVFBCV19CN+e4c3k=
X-Gm-Gg: ASbGnct5XeT50KD5kdQiwjooGUd2OAWJN5Rx5jKBV3L2SF5YeWsSwc1ghG5nE2meKSh
 B3w0rdJTuM1Gs+7jqEt8UJXSQRHLqLLeOm/4+wlY5XKwZzN/s3PRrSnZSuMJE+YWpvn+j9QIYqQ
 jgVkOOuK3SkBW5OrprtnDUdJIaswjwldaMzGnOIwg312KMfh57VC1MACpsEf77aIIhjlEGLDOVV
 05peXy+WmQ4QZVvJZ7QC7T5ro5KwmAnNQjgiODB7Zj4TYRhLIrTvdhZuuy7BU/p4SO27mI85sx7
 GlYlKyqiGFDHZlHIEfpE/Fm0VhLlQpWMRnk8DWIHZVeXfps+Jq3vmxdQOqqogAupkRNhNXeqHsM
 o9qL2WfzVwlBPzQoznQNSrGYyM+6snYQWJnaK9YEbcHVN6LqJmCD9Z4uV5csoVTBsqrocP9lOyR
 oLQQ==
X-Google-Smtp-Source: AGHT+IHQVMdeL7TdaLy065/m41y0Gjgi8QKUd6cU+ygOThgq2rs7fKI5JEg7tzAfq/biiAyVwOlL1g==
X-Received: by 2002:a05:6a00:4fcb:b0:748:3a1a:ba72 with SMTP id
 d2e1a72fcca58-76335c89fb6mr19097806b3a.20.1753736891309; 
 Mon, 28 Jul 2025 14:08:11 -0700 (PDT)
Received: from [192.168.4.112] (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76419d84234sm6188885b3a.57.2025.07.28.14.08.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jul 2025 14:08:10 -0700 (PDT)
Message-ID: <fd0ea0ad-f5cd-40e8-9199-b06b7b180f7c@linaro.org>
Date: Mon, 28 Jul 2025 11:08:06 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] target/arm/sme: Reset SVE state in aarch64_set_svcr()
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250728181650.165114-1-richard.henderson@linaro.org>
 <20250728181650.165114-5-richard.henderson@linaro.org>
 <8c4c3ba5-8fce-4d2e-b36a-5bd3d2ee2305@tls.msk.ru>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <8c4c3ba5-8fce-4d2e-b36a-5bd3d2ee2305@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 7/28/25 09:43, Michael Tokarev wrote:
> On 28.07.2025 21:16, Richard Henderson wrote:
>> Move arm_reset_sve_state() calls to aarch64_set_svcr().
>> (cherry picked from commit 7f2a01e7368f960fadea38f437d0f6de7f249686)
> 
>> +/* ResetSVEState */
>> +static void arm_reset_sve_state(CPUARMState *env)
>> +{
>> +    memset(env->vfp.zregs, 0, sizeof(env->vfp.zregs));
>> +    /* Recall that FFR is stored as pregs[16]. */
>> +    memset(env->vfp.pregs, 0, sizeof(env->vfp.pregs));
>> +    vfp_set_fpcr(env, 0x0800009f);
>> +}
> 
>> -/* ResetSVEState */
>> -void arm_reset_sve_state(CPUARMState *env)
>> -{
>> -    memset(env->vfp.zregs, 0, sizeof(env->vfp.zregs));
>> -    /* Recall that FFR is stored as pregs[16]. */
>> -    memset(env->vfp.pregs, 0, sizeof(env->vfp.pregs));
>> -    vfp_set_fpsr(env, 0x0800009f);
>> -}
> 
> It's a fun one.  Please note vfp_set_fpsr vs vfp_set_fpcr.
> 
> cf. 1edc3d43f20df0d04f8d00b906ba19fed37512a5 which has been
> back-ported to 7.2 already :)
> 
> Unfortunately the order of these commits is different than
> the one on master.
> 
> /mjt

Oh, whoops!  Thanks for the catch!


r~

