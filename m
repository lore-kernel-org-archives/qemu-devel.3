Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 477A5CAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 19:57:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4POV-0007gy-V1; Thu, 02 Oct 2025 15:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4POR-0007gG-Pi
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 15:55:12 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4POG-0006zY-Lq
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 15:55:11 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-33082c95fd0so1614682a91.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 12:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759434892; x=1760039692; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FVEOGoS8+SsjeG6Evv9FGmAHeFjM01wnvNq6N9HdlMk=;
 b=IVDdN6zwPbyLF6WCveVepE3d+ou3nYkGpZYDgynnWjiB0y5NHNZUivFw4RrfUhZSrM
 htde+cdepquiIj7lrOmqEJwfIwuejnTCEz7xv3NrCtGNH+kWRyi/7QkOGRZ1Em4bgZyx
 UzbDDRZM1P6kI2NBsJGeZBYOlF+L29f6+EEex+3dkS3/jDjN/JT0OL361HkKTTMA+Zpd
 3sYCI6jpwPoC5iM/dVrG5BbTVlq7ENK/+l95sO2o6685LJD4kQX65km9dWyX+X1IeksI
 xfQTP6UidmNZAyq71Lq33faNxuTH0l68bCz4D5cgykqzIAog907WpUAfc1YTkA85+jmy
 iSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759434892; x=1760039692;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FVEOGoS8+SsjeG6Evv9FGmAHeFjM01wnvNq6N9HdlMk=;
 b=LOtCQWV5QZ2xe1US+kf8fRXDJJjAAQkAW+PTVh0hgOFGT6DokFfVzSB+O/jDlE9RE2
 dz7/Fz4lihkluFOtowUcPEEWPKFQmWOLmWE+VYffknrNis4EdyRiON7jnEdFKxgoZ7AX
 zvdH97ugUEsxIoGACOv+62eG3QaPotUzjeYwRkRzgj7smKchgNIcmFHvyXnJVXhyamFg
 OwweseIOI/FTYfU/hQlfSP4vTd75mKCgJgRSuKr92BuF4MJg2vQKDbkRz3r8noCoitE4
 ly491QSoGPSxf1fnHg32Es5R4R3cT4rjcob3U4XLESUR9rTu+hmJo78LE68wlyzdwNgs
 5KNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyl8H8Pg6G35nzeCOYDow8UQZZYxWaDN4PIC2AMo3h+yd6NIeIgkdBzUbZUX5ew4FSnb/WIP4pF98l@nongnu.org
X-Gm-Message-State: AOJu0YzoET8TVVCKKODC6wLIEt8gL6varPMHILojXN2THMCLJZEn0Zv1
 84ky6O/x/cqU7dTvBSXTnJzfvCcX8M8zPlN5wdCkQOGk9ZgyqSgtsaFKNNM1/t7g+WKI3hnMKJp
 nvzH/
X-Gm-Gg: ASbGnctQaAfyT25As+G32iv1uLtaxy/NJ5o8ZL0aFgYd3OTbdhY8r0wFZyzkmsEIDEl
 5cbjHbu4KJVc76ADuWElVCyRv+C3YlgalPMz4ccaUqEAw9MLYjW1DaxT5aGNJmGpE9Qsnf/42dB
 kEmmfvvkAk7hU5NLHDm/cg8Y70hrmgFORnO1UVk8Y35bhVJ5miC9tOswNHRR+Cw2xpqn6myv+xo
 +zAy2O+akXB3rBNhStqsEHXnldB+1YVa7nGGZB5fW84ppFUZEQ3zS462mqzztLRZzoSdCRA1uS3
 CHHdg0wixpPGOxQNz0ATjJ5PPxhxJxhmrzBHuSzxQsmX0LtYdHHG6dOO/gZbhvkinCrqzuXlILj
 ZtnECI8hpr0J1KR1e8XRpFZ0OGOJWAKJqIsJJaaEqLj1F/CoxnyvCdAhu0S908evZL0quSjE+3w
 ==
X-Google-Smtp-Source: AGHT+IFxnJx3tH1ndwrc4s8OQOhNutN67Un6ZzNkwwI4Eb9vPRKNkXhhUIQMVa+ReTaV1Hsqxr/CGQ==
X-Received: by 2002:a17:90b:3509:b0:32e:3830:65d5 with SMTP id
 98e67ed59e1d1-339c279976fmr534803a91.36.1759434891807; 
 Thu, 02 Oct 2025 12:54:51 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b609f05662bsm2083607a12.39.2025.10.02.12.54.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 12:54:51 -0700 (PDT)
Message-ID: <645487b6-d98a-454b-9e73-aaca6fe9fb3b@linaro.org>
Date: Thu, 2 Oct 2025 12:54:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/33] target/riscv: Fix size of pc, load_[val|res]
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, richard.henderson@linaro.org,
 alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-12-anjo@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251001073306.28573-12-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
> Fix to 64 bits in size and as these are mapped to TCG globals, be
> careful with host endianness when allocating globals.  Casts are
> added to logging expressions to retain the correct size for
> TARGET_RISCV32.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/cpu.h        |  6 +++---
>   target/riscv/cpu.c        |  3 ++-
>   target/riscv/cpu_helper.c |  4 ++--
>   target/riscv/machine.c    |  6 +++---
>   target/riscv/translate.c  | 12 +++++++-----
>   5 files changed, 17 insertions(+), 14 deletions(-)
I guess you'll update string formats later when really getting rid of 
target_ulong. For now it's good.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

