Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99DE6D26D9C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 21:14:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veJoe-0001uT-G6; Fri, 09 Jan 2026 16:14:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veJoc-0001tu-Ls
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 16:14:38 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veJob-000418-0X
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 16:14:38 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-81e821c3d4eso724077b3a.3
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 13:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767993275; x=1768598075; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kFfjbnzcqfzDnfrydYgIypR+TY6GhAm9CcxDTB8Z708=;
 b=f4c0SiVMhv313dDpoBqNW6Swt2i3Uw27yn5qGc4Ue2Ugl4XrEq8AInCTVwy3YRDPe6
 THNfWEC4NnQqopsGgSXAwK2huRncSHbPxy2vPYkcFZz5GLp6+1LYrWpvvKDsNJoKOS56
 YEpxQ96znC7CafNZcRrHFZFEpXiWEn8GcvC0MsDhrleaeFxy6Hw8c3ZHgSua8Y4nhJY0
 4WP5HyVs4qy7TnTpfHsDD4C4zhujAknQ6jQLYcxMYZVA7NtOo6UyQ6e9X+ybWw3fbCCG
 wbbGi2wgHRElsNLj8BboRnHSK9RxTaFMYFk4y6y+fZETN5cH2WHwdmWJVbBGBapue+1S
 D57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767993275; x=1768598075;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kFfjbnzcqfzDnfrydYgIypR+TY6GhAm9CcxDTB8Z708=;
 b=Aop4fH+mIv97KsWkfy2kUI3SkQY8a+u5vKO/o6TzIbdm4UBf/OwueebhDoaFOeipBS
 tgbFTneblvF+wZRpUVRXIlYyICmGxYAMv9mWKkrBHMtWjTTKcB9FmYNXIgno87ZpV5tr
 DuaCJwYMVOaBQAYxBO4lt2YHGFQCoW3tVRRXMTRPxwcet7zE1+iNlHrWsFJuFrc8F3LW
 Tr0Jm9whVeExaH1RQXzT/R5a0AgKrIISscbcxaLQIFrAGuyJa09NmkTRQ9FxMI7x/ySB
 0bigb76Iz/89xXGiwFBNwDHnDYbV1D+Rx1qkKLy65w1e/nz4NmRklt6BVN0VO2kBohem
 10Dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXojF1ZJC/7hdTHYHVjq7rdk3nSdskADOcRh9e8eD7C4Ec/F+oxZCscf4Ho8h8NDA/iUA1+jxWNStIh@nongnu.org
X-Gm-Message-State: AOJu0Yzkqn6+g5QbwJj4L4MyufhImQpYJnU+vTebQl7OiF9t4caw6vnY
 sxr28tdVd3YlAg5yxJssoH/1wQ/fcK9CSVRuhAr+DJFfik8jw+qnwyKHq0p4nvC0A0Q=
X-Gm-Gg: AY/fxX62dslWizaALrj9kMS3P4MissHw1TokgQE8VpBbpmZQCRWEfVa8QNMkuWgG7qY
 e+sONQ1Kj6nxvXGiXgmpD7YbPW2oP+L7OyrppXT0gj87xJpI9FnBnvB0nyZglbnu4cORJi+jDoA
 anwftXuLiRDanYNwT54uVXu9Oz6Z4hns6nsV33/IJI6q04FAAouVUAoQKKoQBmxV4rsjJFuVy9Q
 0j6lLzQZWDb/eGrPMewxRlmTMhGLQCI0bIR6QdRtYqZ4GfQFyWcz1MfjkcZ34YKP0+PKrNU6TEN
 NWDdhje/YePENs5kElLORSW97qX2cWcHk58IeVu+D94gjHW/Xa/Z1bX9iu3mQQedCt+pH96om0X
 8WEr5VdhZjlKUnpkK1T4JY9vDPYDkQlNEtzsrZ4fFqFeiSNWax+Tyj6G3FQsjGbf82kIx1lvXcv
 HDX31YdkVLdeG8MGdIMeIpByViQQ==
X-Google-Smtp-Source: AGHT+IGELSrzOHMLBh/pGWMygupSzk//P8Uc9ZhZLhWYZJiBQRT3HV7uKCfarOhEfu8pEmoj2wUsQw==
X-Received: by 2002:a05:6a00:7615:b0:81c:6ca8:7ff8 with SMTP id
 d2e1a72fcca58-81c6ca8839fmr7463696b3a.61.1767993275262; 
 Fri, 09 Jan 2026 13:14:35 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-819bafe9b8dsm11145811b3a.22.2026.01.09.13.14.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 13:14:34 -0800 (PST)
Message-ID: <56b2b756-3112-46d4-939d-f5007639be94@linaro.org>
Date: Sat, 10 Jan 2026 08:14:27 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/29] target/arm/gdbstub: make compilation unit common
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-4-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260109053158.2800705-4-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 1/9/26 16:31, Pierrick Bouvier wrote:
> @@ -24,3 +24,25 @@ void arm_cpu_lpa2_finalize(ARMCPU *cpu, Error **errp)
>   {
>       g_assert_not_reached();
>   }
> +
> +
> +int aarch64_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)

Watch the extra newline.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

