Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 106F5F55132
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 07:20:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vz8Qj-0000Be-4O; Sun, 08 Mar 2026 03:20:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vz8Qc-0008Oq-Tm
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:19:54 -0400
Received: from mail-dy1-x1343.google.com ([2607:f8b0:4864:20::1343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vz8Qb-00023E-GD
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:19:54 -0400
Received: by mail-dy1-x1343.google.com with SMTP id
 5a478bee46e88-2b4520f6b32so12156008eec.0
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 23:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772954392; x=1773559192; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MZ70pDkBubnfAy6PbUsKzZ+QirfaHkd5aNPfsmS2uPM=;
 b=E3FjLXyavPZBtw4OQLpiUCx6U2KojuU3CuuainUOODTnP8hGOUQHib00TwN6uVauuT
 qYno1PYhLsJhKI9bGCFk1VP27n4Dpv/g8tshIEaLNH1srNo+Za2yPzPzdIXuFxR52Ft3
 z5XM9IrUU+RFH/71gKZqJXNOuZSN6iFrQgf5ECaRITyAEpFsrtNz+YUDEmbvvHG7xHrg
 IJ9dyhop6jFQmeM4LEF/GWxNZtbs9ejShRFVITNIgMrPcoP7a1oYLBIyykb1/6p10EFo
 RtiAKG8CUQBMsalJmIwOFynsLfGQUGRDkEWgYAdjs9PhxVvpiuDBwUB0CL1OwGsG97vn
 I5kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772954392; x=1773559192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MZ70pDkBubnfAy6PbUsKzZ+QirfaHkd5aNPfsmS2uPM=;
 b=bVGyiB9CUoQeNCSe1wfRhnQC1zvna+Q/ij8qDiS1p0k93ivSFwteuVKbywC3nsw3IU
 0YogDUdUjHnhtqwDZspOS+KdeDE1FVFwpOHGNnkeDiWhXVWDGcHg/BHEYvU/4UFnsomI
 uLqSgKG0Wtonmvw9nYjgOvdx1z1tx3vtFzqiEZDIYrxbf39MTZABaDpCMszvM398ReFH
 e56gHEE4I75P4uqPRzu3/IL172Sr0zAVMDOjOei0V/BLN8+bnwu7EH14pABh9rwtPKaL
 /0IQiAx0p3Z8RvuGOTEiEfbBlf5OxXWyHMUVPpCYkkESR+Fu7I5r5lJCt7l/n9lPQblg
 AgFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWogCEmUZ+qWdlELU+4fMPJrCd9ZKEdLpqbbYL/y18S0vPXcFFx8VnfegZxrxJ1W7sLpOUL3TMxgSZ0@nongnu.org
X-Gm-Message-State: AOJu0Yx1xBfF14Gfrjjc3XSZsYeVMg1n40Q9MM0ml7xrQlh4mnbyWdJM
 /i97IZLIDOYAG6/lEZVuBHI2IfJhO03pxJEXF8qEILev+0sd3aEsrhKu
X-Gm-Gg: ATEYQzxrSqvt4FJx8Ru2G0aRkMK0gQ5fr+MbUoKu/MlYuMrHtfkBwRqWOeBzoWSAYSZ
 YWQ8UNjW5N7EQY/MMQ0GuZcVSvoXYjGjddvHeDIfFagVGiEo4YVWIhX+iUw5L+Y361rsvzd3qZg
 32MGvXIhXABF0W6Jn3qTm0S6aTLRB2CBJYn4ifgAKs2ur9odkTlG8dd5Idj9DV4Fxgvr4J1ZRz3
 mqDtcfs1/8XJqETuyxNR+KICWJTCqs8RhPjyjKbV+HaL6ZNkE530gTQy6GHZhybKqg1m0F0OXik
 op6hedLnvHlp9WQ0kH4q4cmbsgnp5zawcr2Z2LxIfMOB32Q4qfF7/D5UGNfNPOJb/NADI7iGLJg
 TPWHY0t1w707LWg043NUzDeK+j1FrI7Z/Nfw3jOGHoKZGFyEieKh6DfDdaAKag4pVGpGjWs9vhZ
 Ghcnsxm7lUi9V5k7wtGtomFl8n17TCGiCNcFoyp2PAv/W2alKq/Dgpl8UfwNHN6j+yAaqGcDLDu
 NBDow865TOYA6bzMkRYh+rUguY=
X-Received: by 2002:a05:7300:3b24:b0:2be:2a16:4a54 with SMTP id
 5a478bee46e88-2be4e03edd3mr2825263eec.25.1772954391584; 
 Sat, 07 Mar 2026 23:19:51 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f984ceasm6014081eec.32.2026.03.07.23.19.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Mar 2026 23:19:51 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Cc: tangtao1634@phytium.com.cn, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Subject: [PATCH v1 14/28] target/riscv: stop consuming itrigger counts in
 Debug Mode
Date: Sun,  8 Mar 2026 15:17:17 +0800
Message-ID: <378f3cac42ed118add63c496d52ea54b426ff284.1772936778.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772936778.git.chao.liu.zevorn@gmail.com>
References: <cover.1772936778.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1343;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1343.google.com
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

Do not decrement instruction-count triggers while the hart is
already in Debug Mode, and store the decremented count before
testing whether it reached zero.

This matches the architectural rule that triggers do not fire in
Debug Mode and avoids losing a count update when the trigger
transitions to its firing state.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 target/riscv/debug.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 4dbcf289f2..ae9b1cd42a 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -837,6 +837,11 @@ bool riscv_itrigger_enabled(CPURISCVState *env)
 void helper_itrigger_match(CPURISCVState *env)
 {
     int count;
+
+    if (env->debug_mode) {
+        return;
+    }
+
     for (int i = 0; i < RV_MAX_TRIGGERS; i++) {
         if (get_trigger_type(env, i) != TRIGGER_TYPE_INST_CNT) {
             continue;
@@ -848,7 +853,9 @@ void helper_itrigger_match(CPURISCVState *env)
         if (!count) {
             continue;
         }
-        itrigger_set_count(env, i, count--);
+
+        count--;
+        itrigger_set_count(env, i, count);
         if (!count) {
             env->itrigger_enabled = riscv_itrigger_enabled(env);
             do_trigger_action(env, i);
-- 
2.53.0


