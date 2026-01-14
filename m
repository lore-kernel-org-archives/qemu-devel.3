Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 050C6D31A09
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 04:49:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfsoU-0006mZ-4f; Tue, 13 Jan 2026 23:48:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1vfsoS-0006h1-Cr
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:48:56 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1vfsoQ-00045q-S4
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:48:56 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-29f1bc40b35so90133555ad.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 20:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768366133; x=1768970933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VK4aPl7fMVwdbjFxbfeAzb4k8GM5T4FA88o6ceW+Ta4=;
 b=RUgr9q9erCxD0UbrXj0Rh4ut7fHeOjn2gPJrqUQjGpWlAR0eskFw2VI7QdnibI/3Bp
 4w3hjPZcHchxvaA+O81WncYnKy5prK2fCVIboijRv3xZI5k83CMOPK7fM9QqniLFz8km
 rqZboIfX5rw8pxYP2X4vY3vrtlgbmJjvo253z0b4GJ3Bi3elLqIVt3r2cP/gZvgjNiod
 g+Nu4qNgDa8MapNkL2KFeQJORy2tR47NLwXlvAqAG1BaScaYzD15WqRuqIixAKqN5SZ3
 u+Ipm/m68yZ6Izvk9flXXbfP5DxYK2bGmES512CP+vhjS10YTQBoGbdxT+Pd5rMNA/Sg
 lNmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768366133; x=1768970933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VK4aPl7fMVwdbjFxbfeAzb4k8GM5T4FA88o6ceW+Ta4=;
 b=AxiyoHVUlvwnnqpAkHaXQpeobZUfBlAvKxvBGCEXkju9iVGbEHznLbeg8cPOOrK8Kq
 Aa8uZ3O+QeIHffumNPpyrNfna8+3moqd8BdmVva0/r6y6kzyF3HZKJ0+4ir6pzrEeF5k
 Oc2PCEEUK7Kehff5Ma1bUMnfM1Rb2HgY8wmAlI7SGqgttmJex7KGc/z8A22j4OCU8FDP
 +TT3cA+fAisS8mLUKpFJdKgvu+SmokXmX5IjusZ3YF+JbQDLzLned7niyROoDIHx94Nd
 gY6PyNWHSTcIUv8EfZ8h7gsAxXJzKfBDd8tGs0HOs9iSX6egedqefhpYWV50MUkdCcnj
 yPlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaRqDgHtKRDREasTa+blIcULE205qNyMVXzmFQGlpixDuf5hg5uRcZkyAdb9AT238dOf25X4S1Q+yq@nongnu.org
X-Gm-Message-State: AOJu0YwXi6o8FvZ+vQphqTdMKtVwwij+rRs5oDx5KFtqj2DOxoB7TPiA
 HaIxRkHys6rd2YdftNt7uMsAQBN7hznlE6Ur5HF/mnEgpmSkBBe25xtR
X-Gm-Gg: AY/fxX5f/rlbH+oY99T0vJFmN5oSmqi6ErFsfsNMtCiOZatezXE0OhhDxlwMzeeuzSa
 VYGZiA7P2lVK6xrZ691cNkw2a/jCNA6ErGB7nz0WFmgoKi8ak0c1+CmsBH7hlG21N3n8xmN6GkD
 +NA/0XUCTx9vm5b33DuRldm8Qf15mXnIY7LdxUe5hujyyC1x7TH3NsZg3F0vGM3lcMzaTbtmd2k
 ovh+M5LeH5nF3onO5A9HgKQNAhdlqZxTACzJffl6GyWPIQc4ikfjNfeIFCOoKh9PJ9vuLhTQ0cl
 Hhyc9Zej1+mm+7KzJC9JaGJraNxVtQidjbn9NfyZ5GrfxqXvAQ0FtU2D5nnLV0l6r+wvFyCAD5N
 IqAEpfNd1I1UrCiL8b27iGw0rfKzr0iO/L55ooEHD0btCd6Gne6uEXhJiv2cZ50xsXOrMnD7PKj
 M2/FRaG6jsHnf64eIfaJJYQ0M0VM9+YAT/uvPqFSRdi7SKKmglUwj6CDaByvoQp+2YWJijuA==
X-Received: by 2002:a17:902:f601:b0:2a5:8c1c:743d with SMTP id
 d9443c01a7336-2a599e5b738mr15465045ad.50.1768366133645; 
 Tue, 13 Jan 2026 20:48:53 -0800 (PST)
Received: from lima-default (123.253.188.110.qld.leaptel.network.
 [123.253.188.110]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c49037sm216111905ad.36.2026.01.13.20.48.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 20:48:53 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, bin.meng@windriver.com,
 vivahavey@gmail.com, Alvin Chang <alvinga@andestech.com>,
 Yu-Ming Chang <yumin686@andestech.com>, Joel Stanley <joel@jms.id.au>
Subject: [RFC PATCH 18/25] target/riscv/debug: Reset trigger type to
 unavailable
Date: Wed, 14 Jan 2026 14:46:51 +1000
Message-ID: <20260114044701.1173347-19-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114044701.1173347-1-npiggin@gmail.com>
References: <20260114044701.1173347-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x634.google.com
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

Reset triggers to type 15 (unavailable). The reset value for tdata1 type
field is implementation specific, legal values are permitted.
Unavailable is a legal value, and some implementations may not support
type2 triggers so use that instead.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/riscv/debug.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 605ed95b14..96b00193e2 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -1043,10 +1043,10 @@ void riscv_cpu_debug_post_load(CPURISCVState *env)
 
 void riscv_trigger_reset_hold(CPURISCVState *env)
 {
-    target_ulong tdata1 = build_tdata1(env, TRIGGER_TYPE_AD_MATCH, 0, 0);
+    target_ulong tdata1 = build_tdata1(env, TRIGGER_TYPE_UNAVAIL, 0, 0);
     int i;
 
-    /* init to type 2 triggers */
+    /* init to type 15 (unavailable) triggers */
     for (i = 0; i < RV_MAX_TRIGGERS; i++) {
         int trigger_type = get_trigger_type(env, i);
 
@@ -1061,19 +1061,6 @@ void riscv_trigger_reset_hold(CPURISCVState *env)
             break;
         }
 
-        /*
-         * type = TRIGGER_TYPE_AD_MATCH
-         * dmode = 0 (both debug and M-mode can write tdata)
-         * maskmax = 0 (unimplemented, always 0)
-         * sizehi = 0 (match against any size, RV64 only)
-         * hit = 0 (unimplemented, always 0)
-         * select = 0 (always 0, perform match on address)
-         * timing = 0 (always 0, trigger before instruction)
-         * sizelo = 0 (match against any size)
-         * action = 0 (always 0, raise a breakpoint exception)
-         * chain = 0 (unimplemented, always 0)
-         * match = 0 (always 0, when any compare value equals tdata2)
-         */
         env->tdata1[i] = tdata1;
         env->tdata2[i] = 0;
         env->tdata3[i] = 0;
-- 
2.51.0


