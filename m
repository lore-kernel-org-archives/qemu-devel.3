Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 806D9C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 22:03:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiKnz-0006le-B2; Wed, 12 Feb 2025 17:02:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiKnw-0006kO-Tl
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 17:02:01 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiKnv-0004Rm-7M
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 17:02:00 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2fa1a3c88c5so379561a91.3
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 14:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739397717; x=1740002517; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FRdibRr3bWgokhcsRDmew5ps8NNqBgIggeIaYEH1m2c=;
 b=lmMrFAzg6zgicUah8USLbf/sNq/IATuDu132P1VpsuzokONhZTMHg4BIi6nThobDI5
 fnWJXLuY6yUk1BSfNkxUsJYqxpKVvifmMV10c8yfSJLArd5U7elCP6LyE2obRg+KXKrA
 Ng+gMPcdRs6lbUfJ1hYzfyGBWhqqaxp+YJUWaUwgwc9xGVJLa0jjzhBed5aBjfLmsTWu
 fEf7mtEjceyjGrgdKnHYad9yL5J9vGwnQRIE89ZJMYCQ9+08qyJ7Tf2vawgPe2Kcfsd5
 f68GYQqjz2ILNoG4A/noKKZ+bfW3ClotMyNgQaR3ms1pCtYN+auJWxQZIJ2ISzHcpOdH
 3MUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739397717; x=1740002517;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FRdibRr3bWgokhcsRDmew5ps8NNqBgIggeIaYEH1m2c=;
 b=ITU61/bv2mpt00LFwSAFXcwGXBXW1zdRxYkzNNVb7BAjkHjbUnEnKMt6gzsVlukfiC
 4BqzIf9q+keGFlitXCDBWxccee39joqdzodgSSqSH8nQu+2xguDshoYBDyhi6JQRZRMP
 9K6/Edr1cjbUHdhqvsqlFHOqhq5GI9k+IklxWvXLEjIO0yQB21vr7xQ/MJL5uEjd9jEN
 OmfRffQWIOkHYdra/deqYa5BWOZyAp+mWvK8UqNQ0rjMQBfPo1/+Mb3govx2jfL0nGa4
 sZg1RcHYRFgldq4ehBVUGHNuMFHSEOmralAnMvSLR2BWjfvx/Caag9IKkytYjPHJZbeb
 FwdA==
X-Gm-Message-State: AOJu0Yzgy/rLw6Bl3cyr6B0u4Z6eyPnI8OVcKhj5n66ttuyFPzmasyGe
 3KSSElsBmhjX5ngHEfxUnDD3OK+6Qdqr0e+TzZgdUV8wQUqBpX8mptLxgaBdiyocWTw15BSh/bo
 C
X-Gm-Gg: ASbGncsfkEwX9dJn8iumJj8RqQX+ljDTiWRUagsZhQn+Kt+stg51j9lqOjhokMuAKtJ
 7+kSRrGCGP3Gfvvd4KWLAN8dmaMSAEPpad5oeBq6G6lvldAANYzvESW4OGd5cRfKNRQwEiReyQx
 rTC+iXLI41p3CrDZcGwKlDS7Fe6dAIZd8pCmjfGJiB5yx94nzlTlGgGYjq0zVXobuHuqYi2GqgR
 hflJ5ywrn9wZzQHLgwRUCCF//v4GOqUz0UEtNnhDbe+k4KEai6d+W36UkCgOhf6TwxS0nwS9OVn
 1g0uIyKx+9UgPl8rIJu/rOoS3WDQfQfLDzwQLPt6pCH7/bI=
X-Google-Smtp-Source: AGHT+IEU4v/elpIKtwSbGCYXuyo0KFg1lUWuU7v2aEYUy/CCW4XUxO6m4GChxw7H5s8piLEMKZ40Sg==
X-Received: by 2002:a17:90b:3583:b0:2ee:d824:b559 with SMTP id
 98e67ed59e1d1-2fbf9106ac7mr6055690a91.28.1739397716809; 
 Wed, 12 Feb 2025 14:01:56 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fbf98b4c52sm1964837a91.4.2025.02.12.14.01.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2025 14:01:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com,
	philmd@linaro.org
Subject: [PATCH 0/9] target/microblaze: Always use TARGET_LONG_BITS == 32
Date: Wed, 12 Feb 2025 14:01:46 -0800
Message-ID: <20250212220155.1147144-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

Use out-of-line helpers to implement extended address memory ops.
With this, we can reduce TARGET_LONG_BITS to the more natural 32
for this 32-bit cpu.


r~


Richard Henderson (9):
  target/microblaze: Split out mb_unaligned_access_internal
  target/microblaze: Split out mb_transaction_failed_internal
  target/microblaze: Implement extended address load/store out of line
  target/microblaze: Use uint64_t for CPUMBState.ear
  target/microblaze: Use TCGv_i64 for compute_ldst_addr_ea
  target/microblaze: Fix printf format in mmu_translate
  target/microblaze: Use TARGET_LONG_BITS == 32 for system mode
  target/microblaze: Drop DisasContext.r0
  target/microblaze: Simplify compute_ldst_addr_type{a,b}

 target/microblaze/cpu.h                  |   5 +-
 target/microblaze/helper.h               |  16 ++-
 target/microblaze/helper.c               |  25 ++--
 target/microblaze/mmu.c                  |   3 +-
 target/microblaze/op_helper.c            | 157 +++++++++++++++++++----
 target/microblaze/translate.c            | 118 +++++++++--------
 configs/targets/microblaze-softmmu.mak   |   4 +-
 configs/targets/microblazeel-softmmu.mak |   4 +-
 8 files changed, 228 insertions(+), 104 deletions(-)

-- 
2.43.0


