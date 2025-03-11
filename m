Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92143C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 19:14:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts52m-0006ru-7I; Tue, 11 Mar 2025 15:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ts52j-0006r3-EO
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:13:34 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ts52h-0001Yi-9G
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:13:33 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2254e0b4b79so24961295ad.2
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 12:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741720409; x=1742325209; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=u2LwWHyQsCKNhWwzar0qYiqPOk3OJrxoP1WWazrRC2s=;
 b=fWPYd+7d2lCOlPbn5Nsvcsum95caI2ddVgk7J75InxAn76G9cmDViU/a0cmHG0uA5g
 EWiqHchcDYlLgGrRHCVVKpkz+i+eYmvxs0+U1XF3E2xqR5ZZROg6S3+h4g/Ic3fIyy9O
 L5jXcgSDtyx8wffSYHywIkXAugWjnJWMbTOQ2MInoYtX///MULf+A4HCQ5K5fQtmuaZO
 va2bhVLMPGwqdBEUq53P4SGxgj99vp7CXS6vnMJbFP8jT+bg3oOM5Lj0OL4TdatedzkA
 tuTxMbPMKE3jEoI1JJ2KM669INzDWAsI/ZR1rNMPGXUXin3PNhIBmHDyLZULox4GV8Hs
 bZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741720409; x=1742325209;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u2LwWHyQsCKNhWwzar0qYiqPOk3OJrxoP1WWazrRC2s=;
 b=HgQeyn/f9p0xj3UrC6G1JQQAL0Iso/bsReopNV8l0/GbPfjcDu1JgPv8YXmOTCAZ4f
 bY7AbInSwUuxCLqCLdMbN/W76n75DTGM8MvhioIVPYjtO9dNY2n62XKsRpZxZoM+44Iv
 5F9+W1kJhG8PgIyDYvRw0aIrhP67PfPYHyaIVp4LCrKmBtCafBF4pCqJh4+Ph7c9/89E
 1D20SNGd+UjB3vL0pJDfStkChm2YFniJi4L2BGikMS/DL7x/M6jyw3xW7lVAGuKQgeYi
 ulFTzE15Sn9uqjhZCii+J7uqwMyD/h2OdZ38nI6ZjWu2/ycO5pAPGl50r1OycXWQWm5J
 LqvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPkHke+BQ1JNE4th4yPeDwn4YBkxFKZlGVO/PK1dbNbdq8NlFHJczGsElSuGTyf+yZXU/NPF9oZATm@nongnu.org
X-Gm-Message-State: AOJu0YyDzwjENF3unZnPGdMVjvGzDzYj5fUfXbeFZa0+YouEOjHrCY0l
 hmBTAKqJkpPXOJchczcTQAnzZfe4MQU224U3SyoJyAiL6VdtFGolPIOKXWq1+Rs=
X-Gm-Gg: ASbGncutTLghQPyzQixz5NLy9vdi6uRAI1S6mtTA9GDWCc4vXwkACcuxTiaCWGX95LI
 7xMVzqgnqtA/wQMBwNZnGqbrqovKthUVs+tmMxtOJObwyIsyTwIMT0o3FoaUyZCQMOfgQdBNnFT
 navq0/g2KcfelbIp3yOXd3m2NMfSEbG9o/b8R2dMTNNqUJJy6WLnpNHsB0OHDwHnLDISkhF3Tw1
 7AD9yVL4zGCPW23RNVpEjlo84xlkXnDU5sKxJ3gRmWEHGQDPZIGTimEeyUiY86Z5OQj3WRky4XN
 XshLiM/3a7UIwmgqyx9Ex0501VQi8G24drGiZ1GWwmApI8lellQXbepT/T235TbcQ6/rdA6wIsC
 NZ8wArYfK
X-Google-Smtp-Source: AGHT+IHOEFfMDwUK2KS/q3zrSFayXaPNYjuIKZ6Aru8dnmx8Jlcn1uFum3pYGc81STVHjIMyLpbzDw==
X-Received: by 2002:a05:6a21:6186:b0:1f5:8655:3287 with SMTP id
 adf61e73a8af0-1f5865535a2mr12430020637.40.1741720408521; 
 Tue, 11 Mar 2025 12:13:28 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af281075ecfsm9891467a12.5.2025.03.11.12.13.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 12:13:28 -0700 (PDT)
Message-ID: <58f9ab85-430b-4ea2-a380-590d9b24b117@linaro.org>
Date: Tue, 11 Mar 2025 12:13:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/16] exec/tswap: implement {ld,st}.*_p as functions
 instead of macros
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20250311040838.3937136-1-pierrick.bouvier@linaro.org>
 <20250311040838.3937136-3-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250311040838.3937136-3-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 3/10/25 21:08, Pierrick Bouvier wrote:
> Defining functions allows to use them from common code, by not depending
> on TARGET_BIG_ENDIAN.
> Remove previous macros from exec/cpu-all.h.
> By moving them out of cpu-all.h, we'll be able to break dependency on
> cpu.h for memory related functions coming in next commits.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   include/exec/cpu-all.h | 25 ---------------
>   include/exec/tswap.h   | 70 ++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 70 insertions(+), 25 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

