Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C6D3CAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 18:52:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4OOi-0002tZ-5Q; Thu, 02 Oct 2025 14:51:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4OOe-0002rN-3s
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 14:51:20 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4OOR-0002pm-UF
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 14:51:18 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-b523fb676efso1221812a12.3
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 11:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759431060; x=1760035860; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VmNib9EeX4PyZSsSsBWFiciPyLily6/1sfNGlhuz4Sk=;
 b=CxVh+HDQjUnHEqqDMWVn3Fo2AU0RWxMLOkonPz/D7vuV4QK1nH37QaEuxQAarwFUyq
 uyCStYIGPf0oumQZRpeBo5BOfgKdgo4SblySJ+SGLUs3G9zpb1eA7PAq048f3jqmmlym
 nqwsRzXfmmtfvVRnulYa0ZjfjVTZ+sFo7Ke0dB5J2mPN3hQOSQFD2PjjHrQzbIQa61Ue
 m645X6DVf640oG5ph8K9gK6bI32Kp4mw2R5qzaZ7y2jZPYGLZdGFJRiYMBrnK28HTAK4
 39EhBI4OVqv72YcKoJDCU7wj/y8QzLXDF7k1PXnDBzdOFfN6eqjPg+S51NQddwRn146p
 2U4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759431060; x=1760035860;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VmNib9EeX4PyZSsSsBWFiciPyLily6/1sfNGlhuz4Sk=;
 b=Ob+FiRS1i73xuJku/+o3mOCghdy7rWV8ngb4wkV3RConynmkae/rcmWO431AY8MsEg
 /+VXbWLKEZ0X5ewRZvo1HL6FG8dvuaRJrjZJZ3ZQjmRkrlxQYWpcLalkfe7qucCjtiwQ
 o2owVDotZZcEeWackIg19eNjcmhEcqR0fgvWXSvq31O8iztu8+MzqgsOOAXfCpBA5Y/g
 AAzebT2DSPOGcz/DDSLyZ5R5Qhs0lc2qhWuiLnBec4S44EEeCpDWeituHxuR9wyDFjk5
 KOJj1vKrVWVKfatN0WIHFAl2AeP/HiR+krKoqoRGpfCPXLmKdyBpzuZayLWB+o59xJAo
 1/8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuauIGWIX/DCoCt6KIlO5kWLbE5QSqqrG8ks0Hdzy+Wn4Oo5Br6FZnnN/49Rm6y7wHOYF2VhPVDrij@nongnu.org
X-Gm-Message-State: AOJu0YwIe/jh0rYSWRO9PnUgFYVmeQZor69pS3bxGB2O30QYnq0A/Gd3
 mv9rQptM26boQ/Aws+r1F96WMU/9C4cqhN+5fpUnVeIhcL3RucATBRFZtZoqkVpmfeQ=
X-Gm-Gg: ASbGncvIstv8RuYseSej44D/HYWLZZki4Xgv8oflGaiURhOzTluKeTj/lFJwHNKRKEQ
 wQM0yFlSCx68GeFhvk4FWJHLFki7DAWGhOdjVHB+8vvZgdwc1fvvLWVXQdM9runVaqHm55qxqYE
 iYZ4h++PBZYAJPEdH37UakwXTzT8TQBFboM3al43JlTg51ttlbTGeAo8evSktNKHazG2Ak7MVfj
 3Te4Zqcsy2Pv3wj50ax06wmGXHU3LM5ltSAMR02qaJJhhABOgxYqvBehqX08gPRH2jhE1OaNfvb
 JjJKPbxJ9pAESg/yXmxSApDEZE5Hkk7JEE8yIH2fiyguXX7f7P6U8v6VjmdHL9ajjN6yUFvF7Aj
 I6eXsEjenEaRkTTCSSSOyhFHs5gk3NTkcnyBPxnJEbVS6ps/fBCU33sJnOra4WYk=
X-Google-Smtp-Source: AGHT+IHLELYniSAM7Tfau0ZUR5epOVz/DJAMojd7Nopg5l/LVdGFdEDAtg6bqwV7D/sqbkinIDLCpg==
X-Received: by 2002:a17:903:2c7:b0:269:96ee:17d3 with SMTP id
 d9443c01a7336-28e9a6fd7c4mr2536935ad.51.1759431060375; 
 Thu, 02 Oct 2025 11:51:00 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d1b88fcsm27978945ad.84.2025.10.02.11.50.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 11:51:00 -0700 (PDT)
Message-ID: <481ff726-7970-4e75-a6d5-8430ed004943@linaro.org>
Date: Thu, 2 Oct 2025 11:50:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/33] target/riscv: Bugfix
 riscv_pmu_ctr_get_fixed_counters_val()
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, richard.henderson@linaro.org,
 alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-5-anjo@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251001073306.28573-5-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On 10/1/25 12:32 AM, Anton Johansson wrote:
>  From my understanding the upper_half argument only indicates whether the
> upper or lower 32 bits should be returned, and upper_half will only ever
> be set when MXLEN == 32.  However, the function also uses upper_half to
> determine whether the inhibit flags are located in mcyclecfgh or
> mcyclecfg, but this misses the case where MXLEN == 32, upper_half == false
> for TARGET_RISCV32 where we would also need to read the upper half field.
> 
> Minor simplifications are also made along with some formatting fixes.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/csr.c | 22 ++++++++++------------
>   1 file changed, 10 insertions(+), 12 deletions(-)

Looks good.
write_mhpmcounterh is indeed available only for riscv32.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

