Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB8FC87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 21:01:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhDur-0002DQ-MV; Wed, 30 Jul 2025 17:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhDaZ-0008Vo-2b
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 16:39:51 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhDaU-0007uO-N9
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 16:39:50 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-24049d1643aso2171215ad.3
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 13:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753907985; x=1754512785; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MveHeWPbl1cK/yYhThcUWupCyeGutMqwJDp8kMUgRWU=;
 b=ASpEZzuXRkaY328ZNi4xXLSECLhHAAnm9Qf/zjOzznXJlIvr7zH0pJed3WLSvouHLA
 PkIAG3sH43SADIMCEzw+fmTwMYtXLQ3M722Q+recUBUrFHPtP8NiCTU+MRQjVObvsCyp
 lIhRnm3fRhXbjBRRBQNzlnQboHHyKf4zwnPnhqP1Xi56emd6BX5O+xYPZ6clDY7hE4p3
 buVS3rFInY9tbkQQ8qSxq4wyFvWlMzh7eV3lHcuAxOehW4swvA4XHceTy5MWqghepY5x
 Pkr5QFpptXn9l2mFnY+u4zz+mCBfHQxSYrtx8XDPmjR+hVZPC8hQKN5WflU7f1Y5cwRJ
 fU1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753907985; x=1754512785;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MveHeWPbl1cK/yYhThcUWupCyeGutMqwJDp8kMUgRWU=;
 b=X/UMYFlzEJHp/8LlsidTifntNO8vxcKRnI8+3ZheKBAnU746CVagdJ+vqs1ldJPD6N
 SkH/Idwb+Nk/SXyTV4prQkwYPq5ALEPZ3+n84w2OuHUvVFiALYpJeCGKu45QVO39i9bK
 ZZF2vvQUjOKkBA4baJ1YdkkAOpZHD9kMapDxV/70csr2AWcj9sR0s/mMU0X/O0ZsW1pG
 AxIBFX2RfVdQkfTVy3BX2d7KAENhL31NGWjnEA78/yk5FKJNyHLZNVeauf9AyggDf0mj
 apqjgPCk3YTYl1L1izjFhJIPqfBV77tYHFIWx7/Ixmq3WydIP7n1hAJb+4fcm6vD4x9h
 Ky4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUKozr/eHL3suQS2XoZUaFFqdKotVtbw5F955/Rlwh2JTNZeeGKMLVeI7ZJPhUGZMggT2ga6+/7GcX@nongnu.org
X-Gm-Message-State: AOJu0YzfjZGdgajgQSDUtGQzU04zBdpZ6p55zwZ1q8AbEkLwQvJdOway
 nXnd8fCQNPsKYWm3pu4oUjilYYcQ73ePIbaYbsZJZ0oLEPRhocdsFS74lstdmAOc//s=
X-Gm-Gg: ASbGncsqf2q9KRTvRc6XXkV3x4HZcdH0+MvIGMy/aoaDTN19ikZAnDSh65Ho55tkuvL
 5KJrc2Kxd5w1k1pXDeibyeIqo+ot03t8cgnMQXGrFiz1/iswliNv7o+7bibJ/EGjgF+zU6AasL0
 kvdkjKJXhG0H1061AQINuuanHGdYaKTpZQHMlilKXJ1VAznoGimTILsC4pIs0lNHtdloC/QT2Vo
 Rt7DVOn2GFwAsuAHfy4sej7wLIht149tURulPBdMz4phIh7B3/0mHt/Um87rVi7h+9Efc3PdcE2
 dBwWFDm9kywQ682+WTzLrHhsVJ+QS7LOmxvk7ytst4xaAoNCsn0lkpvdUUT8UTq8tOFltyXw5lA
 sGRyT9S4jr6B6dhVEzzP5Ya6sfEoBL9jBF3VqRZcSNY7Zpg==
X-Google-Smtp-Source: AGHT+IFzr8KA7LGQn8XZxmJf0e2X7hSzRp8SNFYGTzyA2vSlV2TdZVOChemx/WMBH8rW9kci3glaxQ==
X-Received: by 2002:a17:903:1c2:b0:235:ed02:288b with SMTP id
 d9443c01a7336-24096b1c3d7mr69851405ad.30.1753907985270; 
 Wed, 30 Jul 2025 13:39:45 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1ef65d2sm158325ad.31.2025.07.30.13.39.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 13:39:44 -0700 (PDT)
Message-ID: <64038dbc-fb0d-4cf7-9242-4073149a5b19@linaro.org>
Date: Wed, 30 Jul 2025 13:39:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/82] target/arm: Enable TCR2_ELx.PIE
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-12-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

On 7/27/25 1:01 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/helper.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


