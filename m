Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 747CDCCD199
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 18:26:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v96C0-0000bQ-Jc; Wed, 15 Oct 2025 14:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v96By-0000b3-Kl
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 14:25:42 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v96Br-0001sc-K1
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 14:25:40 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-b555ab7fabaso6361307a12.0
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 11:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760552730; x=1761157530; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pqRX1/mNRbGNWkSsEhoDQSnoITXrE4aMBRb+YJ5wKnk=;
 b=ftXY8WvalhNXZp1eK5KYhAg0nErI5JEuTVle1OzatZXaM5cXG8Rh0LzqpntV/cp3QW
 biAU0NUIvc3n7R1OvVlK4awD+T6f8SKr/vD6LpdnJiNqXUHBYXJzHh9aOUjWre+XP5hj
 T9F8g94DiGnyEhQkmEiZ2c3bSxpK7GqVoCJB3g07qwPRNtr6a65GWJBeDr7V7gSCAqNq
 kOj+4A/n8uKp/xGH5t2FW+wBuiPJ2YV5LDDZv7va8AFPRvIz8zmML6fVyeN3foCtC9rk
 27ARzPsc4nAU2U1ijQqWfw6VoID+C0nlLRoq2Tf9InElH3HBn0SOr3/ZY0Ag4nRQI/VW
 xJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760552730; x=1761157530;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pqRX1/mNRbGNWkSsEhoDQSnoITXrE4aMBRb+YJ5wKnk=;
 b=kyBfEmZ3L+xFhqLttVhRh/4S3CXfKb4QT4ghedZthrx7WM7hjjdIia7TEKwem+qJwQ
 Uc/ZROJT1EDj/09pD7Tl34+GqMoSDUqrdTCNfcHKZOIXGk5OrSG7ABbMLiI0IJgkHAEI
 nbS63pd0KXb51g9XXFpOiqw0qHTJ3qoVpxrFCmowsNV8aiUEZ5SYEziP0gYkdpKHSCVR
 CQOa1SEBId3pMcpu5c5ciZlDZgYTnx3E3YEvSznubUVor43nUJWGicm8f32/o9ZpLv8P
 fNtZhOyrj24Fs2hiNIEI2qoa4MhfTJqfvJbroTDl7lbQaijMm2/BxBfi61Y2Vg25bdd3
 MmFQ==
X-Gm-Message-State: AOJu0YwHIkkfByb9tr1zmWUBg2XUixWOsCq+DlTkzoxmY9QqIKEsLXS2
 tSupPbHroG2NHMZPDmLTOglt5UMxTz9ploWqr6lrxmPWM7l/3Q2XzIkdmpaWuF9gvqEacvkdEPB
 5IU619jk=
X-Gm-Gg: ASbGncuzKXRbTsfyEFjlfE42Thv4i3hf7uK2iIopidp6FwDbUYjLWhVC+9e7nCDyeuE
 0lt75U/vI4ght7K45sCKDYitkYgxBfWS5jQ+wnNw9j5EVuLBy9yo2UoRJ8MOrFG2daVJdxI/nHC
 W7I1mx+ekIKjNLGr3uw8eUJcTpeoYQer7JHsQeaJA41JauMRZqfoZ3wbIU1v84PCy91gBv3YpmZ
 UGv7ZnpvOZ0WjJGwWMB8zt1+ymvxCXOE5th09VqHohDJwM4EQBKlawckwQV9kkwvnG41fIoLjKx
 zCWM3ytvJZadJ0JPxRTo2y2v/e+41RaIZjNyHukBd0CEGJDWg9003VfRhIf0CqGwkz9W7y3IP5B
 K2HGPAMjdtsO6Jq8y5wQccN9CBVpE42zqz1ZyngsZ/e81GxGqnhAD4R/aUw9DsMfqM2rK+3Jtfi
 +VZ4XB
X-Google-Smtp-Source: AGHT+IH3I2wtz1Di3kOMCaQRCx92Hi2lbVIs3LmZxGtajP5cm7zJRusj4cK2tNdGSgk4Vu1V4BQZ5g==
X-Received: by 2002:a17:903:2ac3:b0:281:613:844b with SMTP id
 d9443c01a7336-29027418ecdmr368686965ad.52.1760552729696; 
 Wed, 15 Oct 2025 11:25:29 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29099afdc02sm2989075ad.110.2025.10.15.11.25.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 11:25:29 -0700 (PDT)
Message-ID: <c4a7bd02-2e69-4537-a618-be0afa2d4e9e@linaro.org>
Date: Wed, 15 Oct 2025 11:25:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] target/microblaze: Convert CPUMBState::res_addr
 field to uint32_t type
To: qemu-devel@nongnu.org
References: <20251015180115.97493-1-philmd@linaro.org>
 <20251015180115.97493-8-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251015180115.97493-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

On 10/15/25 11:01, Philippe Mathieu-Daudé wrote:
> CPUMBState::@res_addr field is used as u32 since commit
> cfeea807e5a ("target-microblaze: Tighten up TCGv_i32 vs
> TCGv type usage"). Convert it as such, bumping the migration
> version. Use the RES_ADDR_NONE definition when appropriate.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Anton Johansson<anjo@rev.ng>
> Reviewed-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   target/microblaze/cpu.h       |  2 +-
>   target/microblaze/machine.c   |  6 +++---
>   target/microblaze/translate.c | 17 +++++++++--------
>   3 files changed, 13 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

