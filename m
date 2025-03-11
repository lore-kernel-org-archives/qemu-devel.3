Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC66C28B30
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:07:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzJU-0004ZV-Vi; Tue, 11 Mar 2025 09:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzEg-0005Xy-7J; Tue, 11 Mar 2025 09:01:34 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzEe-0000HU-Du; Tue, 11 Mar 2025 09:01:29 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2ff6e91cff5so7761463a91.2; 
 Tue, 11 Mar 2025 06:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741698086; x=1742302886; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ejM9HRB5/VzpqAv8bUdwCGywl1lKQVo0Ro8YQEozmw8=;
 b=FvN5cAYD1l7yoSUIdn26m3LNP0cBeVB0jUtQ22kZYN1uE5WSdbbH8+1Y/OMlQO5xU5
 pnAQF0Z+mCEfFrRBzSODJh7OQ0wMJCMmTJ3cehQQPSMru3Wffh2dNL0kuUflXwBwcaf5
 +ZqC/lqPZ/FXBfV/9mJiNrcZ6wnaMpKQPTwnB8uf8b95EyEgbCaIoOB/nbPCS3ZGTg9k
 JFY9dRRqatDV8QW9l2wvKiZuy8Xb5Y5F7YUiPEJ8aUuS94ksTnKadiY2SFT6rYhP/4zg
 B+coMUubNuIb4KKfScIsTPyh5YlN6b/bVml9Yf7PBC4YhizRP1UHaPsCBHD6Jd+aax9l
 jLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741698086; x=1742302886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ejM9HRB5/VzpqAv8bUdwCGywl1lKQVo0Ro8YQEozmw8=;
 b=rI9yFR/FqpngZSGWDLzShBaExJmGhEXJudADGXgYg9tHHWPIlM/Lbnr428IYjEaFSB
 mAemjm5/rZkwiqKl36wPYwKqb/nIbjh9NW08yw+G1AlSzrZSgEmfVdVH32Zd3+DKwRUI
 aXivfaSVUqgSrmiotfsZP8ZgrRhcWnCjEoUUZYzDMGEYmNsvl7fAz7eKxwCKvugs1zl9
 +LeuqiPXULpY3Ha9vRabOQUcSK+EUnZhtkdqmJhXrQEGW9TBrspoYMgnYah4ghCChq3/
 gOr2QPkvbazTv338DWDAIECvnivbPD5QfDOMLeSvKI2aP9bCGE0ilV+FcD2cYyd5SFMQ
 CCpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVw+alfklO1WjA/frZiR4rdXn/VrP9PBuuntPGluQ3H9UGTimBXndY509XRVlSImapOVCAtZEcsQ==@nongnu.org
X-Gm-Message-State: AOJu0YzYVFxgzlRIv/wz4VDgWv7eIYlbP2w8UkuJmNAFin7d2Xm2jNo/
 PZPvxNZdT6I4xX4iIkyMXivUwTivx1euJ/XC4UC9LyH/afJvj9qeJ8VqjQ==
X-Gm-Gg: ASbGncvX/h4h8JVrriFnz24n38soxLxJbXIE/zRD54syYh2qF1563Zuj206LcIG6gUH
 nUI3HSiOGbG9oX1S2GFXl9nmNtmR9vs/eknVyCrQHNPWti7hXgmgFFT6aP+t65nDoEX2XUOgx9c
 eIM9GBYYQWpqZA43S7hSJTClhyXE6RsZgrIFQTV1PO45YTxXXxWTuC43N+O6feFkzl8l8acSO2E
 mbxlDyEJ9f/3RkwrROg8US5zvFHMBQvMaGX8upp6UtbaRS/XXtynDGym91Ju0k+1G4uIxchTXEq
 V3BAhmVv4eJnJwaWyXoWLMWhQ1AvOsISRTG6jNe7IuAsHYadaRA=
X-Google-Smtp-Source: AGHT+IHs6oo++CKnNNKejh7ur7cPc0n4ZdhawTJB62wb1wpJAIC4e4u8rAG9ggbqG+vPbdLBj9Y1yw==
X-Received: by 2002:a17:90b:1d04:b0:2ef:67c2:4030 with SMTP id
 98e67ed59e1d1-2ff7cf0a667mr25504343a91.27.1741698084126; 
 Tue, 11 Mar 2025 06:01:24 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.06.01.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 06:01:23 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 58/72] hw/ppc/spapr: Convert DIRTY_HPTE() macro as
 hpte_set_dirty() method
Date: Tue, 11 Mar 2025 22:57:52 +1000
Message-ID: <20250311125815.903177-59-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Convert DIRTY_HPTE() macro as hpte_set_dirty() method.

sPAPR data structures including the hash page table are big-endian
regardless of current CPU endian mode, so use the big-endian LD/ST
API to access the hash PTEs.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Message-ID: <20241220213103.6314-6-philmd@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 3568a97045..0acf3c53dc 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1425,7 +1425,11 @@ static void hpte_set_clean(SpaprMachineState *s, unsigned index)
              ldq_be_p(hpte_get_ptr(s, index)) & ~HPTE64_V_HPTE_DIRTY);
 }
 
-#define DIRTY_HPTE(_hpte)  ((*(uint64_t *)(_hpte)) |= tswap64(HPTE64_V_HPTE_DIRTY))
+static void hpte_set_dirty(SpaprMachineState *s, unsigned index)
+{
+    stq_be_p(hpte_get_ptr(s, index),
+             ldq_be_p(hpte_get_ptr(s, index)) | HPTE64_V_HPTE_DIRTY);
+}
 
 /*
  * Get the fd to access the kernel htab, re-opening it if necessary
@@ -1636,7 +1640,7 @@ int spapr_reallocate_hpt(SpaprMachineState *spapr, int shift, Error **errp)
         spapr->htab_shift = shift;
 
         for (i = 0; i < size / HASH_PTE_SIZE_64; i++) {
-            DIRTY_HPTE(hpte_get_ptr(spapr, i));
+            hpte_set_dirty(spapr, i);
         }
     }
     /* We're setting up a hash table, so that means we're not radix */
-- 
2.47.1


