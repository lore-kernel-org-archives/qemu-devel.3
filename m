Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1905CD4F4A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 17:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP24h-0005Ua-TR; Mon, 18 May 2026 13:48:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wP24X-0005S9-9l
 for qemu-devel@nongnu.org; Mon, 18 May 2026 13:48:10 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wP24T-0003lg-OS
 for qemu-devel@nongnu.org; Mon, 18 May 2026 13:48:07 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2baef9f5ecdso21124105ad.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 10:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779126472; x=1779731272; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VZ9qc1RIQLlOewW2FMtXm1vHM1G9rLij/r0/5a06Pgk=;
 b=pu6cKtp6XbmvfkMNykO4JfGLn41ZggSgrMTR9VcviHE7JHosZmicQBOZHqkqc07G4C
 En3hqaIhPyS/c8mL/BizpztLzrqKNo/ujGCsNXX++XSvz7a26cNNRqGw0jCGN8EaLlTO
 Os52CoWQmUhhpI6BKLF8qtYG8EgCiWKlGvuytdSG+qrqRYUO71zs/hRGe79XqwS6tJ15
 GphjiyiYdE0yYzZDboLGccZJUhl++AUB2G/VQLG+pvr7rV2QiSjf1Mf7mSaZ56ThQorg
 nQtYqksW5Xbckiq67dRUhZyFAm5fB8MV4x9Kr6h2vNjGhvISmKTdC3unB7mgXva6O2YK
 6XoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779126472; x=1779731272;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VZ9qc1RIQLlOewW2FMtXm1vHM1G9rLij/r0/5a06Pgk=;
 b=dPDlGbXRE1IUWpsJ5nKT17JpNxz62r2uF8qrZ3U/Og+tVwWIN7ctaGR7cg8rW6XrCL
 hRuHaiE0Ar/FdMPPvbBYc8tiz0HFqedbZ/g8Kh8ztpGgrYImbJ9L/dFjMFkTJc34wr7L
 V+4ssfDxKb5DJUxNfeCBEhYQNydii7uluD7vrhyIGDS2jWakSB/jlkKkWT/kHAQGsY9J
 akDzuuy3SYSRJZ6mxceMi56yBqwDKnP/5voHlofUybd2z7YClklHtaH8nJ+PopwSBPgQ
 W3ERiYkwcESZTnZvklHSyF2L9hcc5PHoW0I6DAA6WuN/W2jcz1dAl/VQeAwS8SbJXq72
 UjXQ==
X-Gm-Message-State: AOJu0Yw9BKKqeLOTk5dA3ufJo1twyTda09+65umExwCcULES+8F/Js+R
 RUnCbLZbfR3gy1mHQsGMKoR+RpgcOl6Bd6PnMngHx6jZGk1Duo4mZjZgnly26CQdZ+y9pFgGvYx
 qzhHp5Z4=
X-Gm-Gg: Acq92OEGwcHAn6FOdFhg+XuNep1ZoXODbbBi/ybbTnDZmmi9BUwHIju06FucTWfczyv
 Ktzhi1gylHHpfCgYwMrvfOFQLJiL3OR9h1lRkA/JQ2XHzxuw8TmPGEmBHkK+Rpheis5naVcrDUK
 JRJQGI+DWhcnfKs96jPaPXOtRHaTg/S1LFjwMAOYo18bNGzYymnOmuYwURzNxXfeIg4pGC3A3fL
 neAndEh57Pi1NA8gIRhc8Yea+nPOVfrh+IBFoyBVHy/V6ungK3gApTWmEKD2Bc5zGX/6xwtewEd
 AzpmyaIaUD0oFz3iRss68UDs8j2V10qD5tPNtIDdBn8M8fzZdKYI8wqeKNtRM5HflIIW6yi91jB
 00pMO8MkqaxKIblaYbM5WygD9cdm4bvLLe9+Jx5kEZnNSnNAXNoC8Q/qvgFVoINOy0I1dQYSJkM
 FJmGq1aXaIOe5rkCboP8uugY56Qv9N
X-Received: by 2002:a17:903:8c4:b0:2bd:8fc0:1198 with SMTP id
 d9443c01a7336-2bd8fc01303mr152835705ad.5.1779126471566; 
 Mon, 18 May 2026 10:47:51 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5d12e38dsm157334905ad.77.2026.05.18.10.47.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 10:47:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 0/4] target/arm: Implement FEAT_CMPBR
Date: Mon, 18 May 2026 10:47:46 -0700
Message-ID: <20260518174750.660258-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

v1: https://lore.kernel.org/qemu-devel/20250803014019.416797-1-richard.henderson@linaro.org/

Changes for v2:
  - v9.6 to be included in Arm ARM.
  - Reorg CB_cond to avoid argument ordering error (paolo).


r~


Richard Henderson (4):
  target/arm: Add feature predicate for FEAT_CMPBR
  target/arm: Implement CB, CBB, CBH
  target/arm: Implement CB (immediate)
  target/arm: Enable FEAT_CMPBR for -cpu max

 target/arm/cpu-features.h      |  5 ++
 linux-user/aarch64/elfload.c   |  1 +
 target/arm/tcg/cpu64.c         |  2 +-
 target/arm/tcg/translate-a64.c | 83 ++++++++++++++++++++++++++++++++++
 docs/system/arm/emulation.rst  |  1 +
 target/arm/tcg/a64.decode      | 11 +++++
 6 files changed, 102 insertions(+), 1 deletion(-)

-- 
2.43.0


