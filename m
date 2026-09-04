Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ECAAC79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 05:24:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2MLP-0005QJ-AX; Fri, 04 Sep 2026 01:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MLL-0005Pe-SI
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:20:03 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MLK-000125-5p
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:20:03 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-cc1a4c62804so630756a12.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 22:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788499199; x=1789103999; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZdJY5rmNfeWnTZyHQ8pDn4ZCh0IJHklHS198JgYTqwI=;
 b=K7xqOVRFSRQ0lyMe2HKhyyrPNaiF/av09spE6x9wk86qC6oxAm50Kh1KDgSdOlQnXV
 XJ0qVv7EheTZjXKuMcIuF//LG8FHPBufvBcFswoKJ5fVzPI4Duk077g7Xao448s3icBP
 xGeJpScD43Gr3izUza8tRnGp4Hs9dxoiBjcrgA1HVCvh1g8dbuM0OHGcxhbO3RmTtLwO
 PvJuiPN8W6E0KVlEHXWjZPewymiipt3ImoshiMH/lwu7OpChLVUEcEPYCxncfq8r6kiK
 FiOAtd3ReiW/qQWLu9AHq4DsbH+k2TGcV0UAmA5UKTLyZ7ZCegUId5Tbx0pCKvEFqqLc
 c9pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788499199; x=1789103999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZdJY5rmNfeWnTZyHQ8pDn4ZCh0IJHklHS198JgYTqwI=;
 b=odEg0uzwQKas8vugX1ur00MMxtt5HIeHnGZ0H2aB8U2/ESsEyPM1cV/MP2zU3erZXu
 2ZtH6EfWFpPxSqIYWGpvhYFpXzykS0QvpBw0ukFn/TIFQtOJj1jLzQ9A5rzcIbZePLjo
 UpyTHB3iDPvzTIvtbVxigb6p22su8d6UpbZJ3ouSJTGjlgCMj7BMzAzb4jDIytJlb6Fi
 wzYPPJIW5QvOGW93JW5hkakHjhHpZb9ZwKwkvCM8/yWHN8+oXHC8U5h3erduJLSF+nI6
 JZsCTE3MM9ajvzTXqCONUs7YSCDNndsuT0tZH/mfRvsYf18exUONyogFHBn5kOGWyv/U
 bUgw==
X-Gm-Message-State: AFuF++n3ZzMSNeePWq7Tgg+12B/u9dw2mJDD9OvdSpxqSBhTLnA+W37K
 l3YnIfA134nvO1+3tStuR9/M06OIB+f/faGrSydx3Ibi30EDmOsnbjwpi6HQvQ==
X-Gm-Gg: AYBFou0sb36cxRezaVKWsQyavdLmC6vC7oNrEX4t/czEbh/kvw6JgwedPGDHdAvMbNX
 OYccgTBVPwRQfeyBhtGoPBkLmxcFl/p2ZSpOuMflZOqcNFfuSCU14hLLrS/ptIF8DxPmLYINiCB
 k14QC5U0PfTOR/oVcYD04Dd2qIg0GQLGUdpLxhVtYB88Luc4JrwKNtAJzqUymqd828GMtaIknIz
 4JrKpUkNXPSpwZy5Y3gTkljMgX0YzNQMXKvoM96oxTzqQOwWVULNhdJ2YYjhlyeBdeyBGc2dpy6
 rTzeI7WB+fQIhinaQNiH4zBxUXvp+4SjWcXkNliRxRXOqlSjqwbaPnvDuWcS0DjrnPpIxUnydX5
 ddgcQ6tLGFUHzbV2VUvCcYrF1M9Q1wLLfybuAYLfoHDwMuwFhE1KEWorKyv2vmLdBiiukqDBkiR
 Tv6VyJfyxSqP31ibTgNVjMH9wtvySSREoQsGtjk9EqNC9ISU8aT/nHe3Ep+zPVqSCtHVKeny2o+
 GyPcw==
X-Received: by 2002:a05:6a20:4306:b0:3d0:9590:7148 with SMTP id
 adf61e73a8af0-3da3a11f7a1mr4779589637.17.1788499199338; 
 Thu, 03 Sep 2026 22:19:59 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc455445e34sm402147a12.15.2026.09.03.22.19.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 22:19:58 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 02/47] target/riscv/tcg/debug.c: add Debug 1.0 'pending' bit
Date: Fri,  4 Sep 2026 15:18:58 +1000
Message-ID: <20260904051943.799041-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904051943.799041-1-alistair.francis@wdc.com>
References: <20260904051943.799041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

We need to set the 'pending' bit when 'count' reaches 0, clearing it right
after the trigger fires.

This is 1.0 exclusive behavior so no changes are needed when running Debug
0.13.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260805182506.2943757-3-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/debug.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/target/riscv/tcg/debug.c b/target/riscv/tcg/debug.c
index 5ab29f6945..d40db381e6 100644
--- a/target/riscv/tcg/debug.c
+++ b/target/riscv/tcg/debug.c
@@ -77,6 +77,11 @@ static int access_size[SIZE_NUM] = {
     [6 ... 15] = -1,
 };
 
+static bool debug_trigger_version_1_0(CPURISCVState *env)
+{
+    return riscv_cpu_cfg(env)->ext_sdtrig;
+}
+
 static inline target_ulong extract_trigger_type(CPURISCVState *env,
                                                 target_ulong tdata1)
 {
@@ -684,6 +689,17 @@ itrigger_set_count(CPURISCVState *env, int index, int value)
                                    ITRIGGER_COUNT, value);
 }
 
+static inline void
+itrigger_set_pending(CPURISCVState *env, int index, int val)
+{
+    if (!debug_trigger_version_1_0(env)) {
+        return;
+    }
+
+    env->tdata1[index] = set_field(env->tdata1[index],
+                                   ITRIGGER_PENDING, val);
+}
+
 static bool check_itrigger_priv(CPURISCVState *env, int index)
 {
     target_ulong tdata1 = env->tdata1[index];
@@ -735,8 +751,25 @@ void helper_itrigger_match(CPURISCVState *env)
         }
         itrigger_set_count(env, i, count--);
         if (!count) {
+            /*
+             * From the 1.0 spec: "When pending is set, the trigger
+             * fires just before any further instructions are executed
+             * in a mode where the trigger is enabled. As the trigger
+             * fires, pending is cleared."
+             *
+             * And: "This bit becomes set when count is decremented
+             * from 1 to 0. It is cleared when the trigger fires,
+             * which will happen just before executing the next
+             * instruction in one of the enabled modes".
+             *
+             * Note that itrigger_set_pending() is a no-op if we're
+             * running debug 0.13.
+             */
+            itrigger_set_pending(env, i, 1);
+
             env->itrigger_enabled = riscv_itrigger_enabled(env);
             do_trigger_action(env, i);
+            itrigger_set_pending(env, i, 0);
         }
     }
 }
-- 
2.55.0


