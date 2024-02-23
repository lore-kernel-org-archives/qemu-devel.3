Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61070C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 16:03:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdY0w-0005oO-N5; Fri, 23 Feb 2024 11:03:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXjw-0006Q0-3m; Fri, 23 Feb 2024 10:45:32 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXjt-0006eK-Qy; Fri, 23 Feb 2024 10:45:31 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1dc13fb0133so7532105ad.3; 
 Fri, 23 Feb 2024 07:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708703128; x=1709307928; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G9dQsFszCC0E9Sl3E2+C8E6JRrg7A7/jy0wn4Bw7w60=;
 b=Py7uAfkwxjj9ANNJU35xPGtFR2/d40JOY/Gi8hQCa1sbYvQ+rZsovBGogVx7XU8oUl
 9CZ5Q1yUtU9IfRXFLGxNIRcXV3DbV24oFaFYU/HzM80Va92TOokwfz8lHhDMLcII53Kw
 twhMyxlBnkOWDt/nyPbLYB0xW4zoDsHvjQZp8VxYMc4qzGU0YX94cFyf5Xvu3Gt/hNpB
 FBxl4jJR8nakI36lJbC8O2fBQgvDJMi6tOCsEUF9QMkjP7q15spG+npjPE5qCHWfZ6Os
 OHhnllL2IuMFjfpInbFibACFvpcT6yd+OSmmpw6Pa5+8VWCfJmxdIFA2NS/57MEx19qQ
 xSvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708703128; x=1709307928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G9dQsFszCC0E9Sl3E2+C8E6JRrg7A7/jy0wn4Bw7w60=;
 b=SA1aLBKu/cP2ljjuzhBzBMH5tggAvG8MkNx1c42vxUvSqQl1rVyN2z5YfEgBA4c8CH
 r9m/hLP1ssViIjoL6T7ESnrpNMwnU4l+x3XU7jcgE4H1dOWrCVdn87HsL1VHXmgxtdo+
 MOTGQnXVQAki8PwHHzyWrMXlyjhwisr6gZtZejHijXCAUxFTA/w7xRTDBfFJJ8CX81cF
 VFonaM5FBm2fbLEFVarqiqVTQuG8YxVSN/nFS/TqciuQDDMSGsHfb6RMjsvZwc5LcUR7
 Z4ZQXfZUGrzoaz0NJ+bcgLJaRVYlO9CdhNsaSPlE9RTUn0XpGuSJImE39j75iwIPEsgc
 Tovw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpmGgbJs9xP450q/Vp7U2n1MOffichFUeWLy6Ra355GwNnMD9x7KYH0ZvwJQ+lGzwuVTgt53vEA/WjK6oFy88/Zs8S
X-Gm-Message-State: AOJu0Yz/KOavTeXfmMb11LvfeCYvhwASYDh334JxMkeYXyqribOdRnMY
 GcitiTCNjrzYP2uuVZD8omelyjSh1WHp+043stzZ88auipOaP8tnKqrVqcyk
X-Google-Smtp-Source: AGHT+IHFB8kUF2f3GYHigcdvDgVYXZAwq86SRr/f/U76rurBg6hClCgFXfzzBpht+IHZq6YZMCEc5A==
X-Received: by 2002:a17:902:d4c8:b0:1db:a94f:903d with SMTP id
 o8-20020a170902d4c800b001dba94f903dmr230284plg.36.1708703127756; 
 Fri, 23 Feb 2024 07:45:27 -0800 (PST)
Received: from wheely.local0.net (220-235-194-103.tpgi.com.au.
 [220.235.194.103]) by smtp.gmail.com with ESMTPSA id
 h18-20020a170902f2d200b001d913992d8csm11808208plc.242.2024.02.23.07.45.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 07:45:27 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 35/47] target/ppc: Improve timebase register defines naming
Date: Sat, 24 Feb 2024 01:41:54 +1000
Message-ID: <20240223154211.1001692-36-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240223154211.1001692-1-npiggin@gmail.com>
References: <20240223154211.1001692-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The timebase in ppc started out with the mftb instruction which is like
mfspr but addressed timebase registers (TBRs) rather than SPRs. These
instructions could be used to read TB and TBU at 268 and 269. Timebase
could be written via the TBL and TBU SPRs at 284 and 285.

The ISA changed around v2.03 to bring TB and TBU reads into the SPR
space at 268 and 269 (access via mftb TBR-space is still supported
but will be phased out). Later, VTB was added which is an entirely
different register.

The SPR number defines in QEMU are understandably inconsistently named.
Change SPR 268, 269, 284, 285 to TBL, TBU, WR_TBL, WR_TBU, respectively.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu.h         |  8 ++++----
 target/ppc/helper_regs.c | 10 +++++-----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index a44de22ca4..16baea609c 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1750,8 +1750,8 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_USPRG5            (0x105)
 #define SPR_USPRG6            (0x106)
 #define SPR_USPRG7            (0x107)
-#define SPR_VTBL              (0x10C)
-#define SPR_VTBU              (0x10D)
+#define SPR_TBL               (0x10C)
+#define SPR_TBU               (0x10D)
 #define SPR_SPRG0             (0x110)
 #define SPR_SPRG1             (0x111)
 #define SPR_SPRG2             (0x112)
@@ -1764,8 +1764,8 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_SPRG7             (0x117)
 #define SPR_ASR               (0x118)
 #define SPR_EAR               (0x11A)
-#define SPR_TBL               (0x11C)
-#define SPR_TBU               (0x11D)
+#define SPR_WR_TBL            (0x11C)
+#define SPR_WR_TBU            (0x11D)
 #define SPR_TBU40             (0x11E)
 #define SPR_SVR               (0x11E)
 #define SPR_BOOKE_PIR         (0x11E)
diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
index 8f5bd1536e..94c9a5a5c1 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -461,22 +461,22 @@ void register_generic_sprs(PowerPCCPU *cpu)
 
     /* Time base */
 #if defined(TARGET_PPC64)
-    spr_register(env, SPR_VTBL,  "TB",
+    spr_register(env, SPR_TBL, "TB",
 #else
-    spr_register(env, SPR_VTBL,  "TBL",
+    spr_register(env, SPR_TBL, "TBL",
 #endif
                  &spr_read_tbl, SPR_NOACCESS,
                  &spr_read_tbl, SPR_NOACCESS,
                  0x00000000);
-    spr_register(env, SPR_TBL,   "TBL",
+    spr_register(env, SPR_WR_TBL, "TBL",
                  &spr_read_tbl, SPR_NOACCESS,
                  &spr_read_tbl, &spr_write_tbl,
                  0x00000000);
-    spr_register(env, SPR_VTBU,  "TBU",
+    spr_register(env, SPR_TBU, "TBU",
                  &spr_read_tbu, SPR_NOACCESS,
                  &spr_read_tbu, SPR_NOACCESS,
                  0x00000000);
-    spr_register(env, SPR_TBU,   "TBU",
+    spr_register(env, SPR_WR_TBU, "TBU",
                  &spr_read_tbu, SPR_NOACCESS,
                  &spr_read_tbu, &spr_write_tbu,
                  0x00000000);
-- 
2.42.0


