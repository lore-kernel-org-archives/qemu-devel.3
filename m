Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E04DECA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 23:08:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usUfR-0007t8-8p; Sat, 30 Aug 2025 19:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usUfQ-0007si-0c
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 19:07:28 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usUfO-0000kL-82
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 19:07:27 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b475dfb4f42so2204713a12.0
 for <qemu-devel@nongnu.org>; Sat, 30 Aug 2025 16:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756595244; x=1757200044; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lioW5osWZzWEtN6sfhL023oB0BuO/LoWjX4o0oQTYMc=;
 b=aCf+URLSGiZ4/sio7iEzHvzkqey5hwK80QAW9QxzJqYCJ1KEGPyO0yBR9LYSzZIrTf
 /zHWpOvDfd9WkB9vyjxG8HSJcRouW2hz0nD0n2npaPRq5ho2RmFQ4lTUE/j3ueMtYhHl
 kDMYPOYaEkO6xfW35S92NN6zIh9Xw03OyITSuj2pGFq30L0no381oP4xDqmJwZenXAer
 pO/bWWDcHIulDd61Je1jJnlUxcnPFwxjLZ/dInEduQ1C4+0nySndWgJNhTiE8CHdIAVh
 1vJY5IS/hTV4q9QhAAU1sgzQ1IZ19y/7s7ERllO/mh2tPDTZaB/lI7LK4ngyUJGYeso2
 bzXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756595244; x=1757200044;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lioW5osWZzWEtN6sfhL023oB0BuO/LoWjX4o0oQTYMc=;
 b=up/p03mss9xzkhLYqY91WBSNIhlwJAj/hLk2IPARO4BwtgHERHk6Md/hsZeFkS3fcp
 lJMTXx7oEMqjZCtxRnqzSzwFsIxRBrDWEiE5QOwBzM9NP8McSTxgVoxPXR8XwK7aVILP
 pt0XfhW/jm8i9K/f/dguQJ95hvnHckSpZ9lydXZPoDns61VxNVigLjh+C3QqRJUS3lF4
 pJ6jn8qJ74w8sd1TK+PDKS2nO1e+TaDXE5/XFOOtHejJuZ02IG2QfgSLV8TXFj3zEfHA
 Cz2/Y7kC7ZRviioJL0xaomrh7JBWeM+2k4wQWpcJKTkL9X8/lNOsxFtI6NUwJtXKMHdq
 Y5aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7W5vCCpgqK1dkIlkBDXfhFAiRskpQgymOsuBesHQo6JXUor9LGHy+Phij8VS2EDXHnhuMM/ojfgGp@nongnu.org
X-Gm-Message-State: AOJu0YxgF3cibbyQaG76rarNMktbxSYhOvrwP+qocNakbzoUxBsV4EKF
 f5nWkstTReCxuzZNAn5I/YcFu8kVYXVlYeJK0LaPJUQ2OBOS6fUrJmXLejpZA1oNjUapB/ZtN70
 zYEtScmk=
X-Gm-Gg: ASbGncsctAmc3/e8VYyVzmwe4mG5aesUK4kKoBvQOiArYS7BU2tRuIMzI0t0k+KY+r3
 jk3z32Fk6zkk941mNqwazhK2gcCTTo1gOgh5Ugxjtthdn+zXe5tlobD4K6KPmuVhY3aN8pdnqUf
 U6vacY+CFVzwsS+KhGepORu4jbyqamoLDspyb+vIk9zJhPXXfbwQLouyTcyh/WdQrDLdaG8dSJI
 +ZZ4PPRqPg9UBjCRXmoMNdzGG5eHo1Dni0g2AA5lvgN6E9t4ma+O4icZExzO0NKMaYsDTOQ/hDp
 RwTu6R8UA0+2PMb9kguqRqpx0REAqNMZSonPC9JA9YafCsm/HE4jRc4eJY3r0zabGolqMf1q26M
 ZE28q+uMLoi5CktwpCQln9WEJre06N6hgwv7aqKA0SJgq20S1JS7J/zeGZOEOoZQXy+oDtw==
X-Google-Smtp-Source: AGHT+IECBPdXJgueSlDTRkjahSM+B1YEJ763wpWhDTYnNCelZ0v6UJWWCrxX5LqlAtwDe6VGNMrzRw==
X-Received: by 2002:a17:90b:1b4b:b0:324:e6ea:f959 with SMTP id
 98e67ed59e1d1-3281543747cmr4620092a91.14.1756595244519; 
 Sat, 30 Aug 2025 16:07:24 -0700 (PDT)
Received: from [10.118.1.198] (122-150-204-48.dyn.ip.vocus.au.
 [122.150.204.48]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327d932f802sm6739348a91.1.2025.08.30.16.07.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 30 Aug 2025 16:07:24 -0700 (PDT)
Message-ID: <dfaa2800-f132-4a46-9751-2d9fb38c5bef@linaro.org>
Date: Sun, 31 Aug 2025 09:07:19 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/32] target-arm queue
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20250830160828.3593075-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250830160828.3593075-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

On 8/31/25 02:08, Peter Maydell wrote:
> v2: handle bsd-user in the rename of isar_feature_aa64_atomics
> 
> -- PMM
> 
> The following changes since commit 4791f22a5f5571cb248b1eddff98630545b3fd3e:
> 
>    Merge tag 'pull-lu-20250830' ofhttps://gitlab.com/rth7680/qemu into staging (2025-08-30 08:24:48 +1000)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20250830
> 
> for you to fetch changes up to 2e27650bddd35477d994a795a3b1cb57c8ed5c76:
> 
>    hw/arm/stm32f205_soc: Don't leak TYPE_OR_IRQ objects (2025-08-30 16:38:47 +0100)
> 
> ----------------------------------------------------------------
> target-arm queue:
>   * Implement FEAT_SCTLR2
>   * Implement FEAT_TCR2
>   * Implement FEAT_CSSC
>   * Implement FEAT_LSE128
>   * Clean up of register field definitions
>   * Trap PMCR when MDCR_EL2.TPMCR is set
>   * tests/functional: update aarch64 RME test images
>   * hw/intc/arm_gicv3_kvm: preserve pending interrupts during cpr
>   * hw/arm: add static NVDIMMs in device tree
>   * hw/arm/stm32f205_soc: Don't leak TYPE_OR_IRQ objects
>   * scripts/kernel-doc: Avoid new Perl precedence warning
>   * scripts/kernel-doc: Update to kernel's new Python implementation


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

