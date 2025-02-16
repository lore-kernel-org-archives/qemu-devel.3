Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B34C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:24:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnuG-00045C-BK; Sun, 16 Feb 2025 18:18:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjntQ-00030W-R1
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:45 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjntL-000657-Fa
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:44 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-220d601886fso48364065ad.1
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747858; x=1740352658; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NLEWRgNJjSKS+qFBrKiQh4Pg9wICWUywDwjjDa7Dnr0=;
 b=rh48NUbFP2fZdi0mgtzgj9BLtqLZB6ti1EzSWpNyRdEVAx0D7IwPeoCrBu44k0Du5+
 k8DopBWlV5bFr8L8i8+0os+sjjjIA+4Bqjx2t2jznQgVbq3NN4oOXfy1J6kqW0BhHlDh
 4iuKzSOjzwhnBG2V/2eSq2a2hlMjLulx4K4eINgiFDRZXDb2szDEMZHwQnbXuYTSL1hU
 ggxlaZEZc/yY3oVIimqz+xZqrDLBUH3fT9qm0GydgHbnDqN0j3LMB4+KsJ27ix+jIJd9
 a1q8TF6bezKLZpWkaqFbpkUrUFEjpRWq24DfLKH2Mqbg4CDz1Lre8cnuB8LX8j2lImTK
 QTSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747858; x=1740352658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NLEWRgNJjSKS+qFBrKiQh4Pg9wICWUywDwjjDa7Dnr0=;
 b=PAAUIey6pbyWDDeKIGN8G3lxa7QCzRT24IvNiCXJYYTKAVesC6mf7dT767b8L4QtOJ
 2rZyIJg9gujgTFfrZ7k3OE8hL0BhCtg+VBenh28hAWfPF/3qkIQdc3NwRRED5kXtNdKt
 4DeO7HYnZGh10MQCOCe79urFt4Wp2c/L1aJFxK1dg77rt+T7vmxwWfZ71GnzJfsi7dzS
 I8BVBvnxJduI2iYO9rJUwb72UTD79mcnejxA8is4TZ9NGZXm6ovg1PAh4oWjn45JPosc
 FU0qNS6yvnSxxzcIcE0ug7fZQEYrq+agmtBMejnnAkDOPgKw3geYBivG1pKvO5nZJHP9
 C1og==
X-Gm-Message-State: AOJu0YyDgWADAxn/GLrF9Pp0dKpoOAeDijNzhUzP8YArqYa1p9TsibiW
 Uc6A6iQAjf0tpE/LPdhvdWnvJei8s2ImJfXy5kfIFm7NAFyyu97V9XCixVOlQpvZvFPsPQdvBm+
 E
X-Gm-Gg: ASbGncsJDILdmZe+Vd+OdBpCeFpZcV1SGCAo31Azltdk0tVpMrtTLX07thbP8Xuz3JE
 cBj5CulMv9P5iTLZNcvTQFCWL9sRV+sUQlK+TKU/3P2DqYJQhVYkqo+Eh2BYs+U+jQuixdJ7Jso
 no0xCsnRiyQNGAyskuqVJNmc22fMKlMwO7vB828s2i9wwVa5iBB5zClLc3gsIcG7JNgBbHrd9CE
 KMAtj0+mNM+J4kA7ZfODtY7Ks8S3DUnMudVKgXEw2RraxHAaXw+QMOQglyFYrfrrJKGM0pv3Nsb
 /C2i4AWXGBbVlNmgn4gJm0rrwOPGwRSxzho3OHqo+E7h/9U=
X-Google-Smtp-Source: AGHT+IH/5zwKJbs43vPOdJD1lhGi9f54OUMl2C9B+mi2WB4vmDvMeNW42AberDeGC+JYsoMoNmTpLQ==
X-Received: by 2002:a17:903:2f8f:b0:21f:515:d61 with SMTP id
 d9443c01a7336-22104028a15mr126446875ad.21.1739747857658; 
 Sun, 16 Feb 2025 15:17:37 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2213394d6c8sm5449885ad.181.2025.02.16.15.17.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:17:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 111/162] tcg: Sink def, nb_iargs,
 nb_oargs loads in liveness_pass_1
Date: Sun, 16 Feb 2025 15:09:20 -0800
Message-ID: <20250216231012.2808572-112-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Sink the sets of the def, nb_iargs, nb_oargs variables to
the default and do_not_remove labels.  They're not really
needed beforehand, and it avoids preceding code from having
to keep them up-to-date.  Note that def was *not* kept
up-to-date; thankfully only def->flags had been used and
those bits were constant between opcode changes.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 74911962a4..019bf2d48f 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -4071,8 +4071,6 @@ liveness_pass_1(TCGContext *s)
         case INDEX_op_sub2_i64:
             opc_new = INDEX_op_sub;
         do_addsub2:
-            nb_iargs = 4;
-            nb_oargs = 2;
             /* Test if the high part of the operation is dead, but not
                the low part.  The result can be optimized to a simple
                add or sub.  This happens often for x86_64 guest when the
@@ -4087,8 +4085,6 @@ liveness_pass_1(TCGContext *s)
                 op->args[1] = op->args[2];
                 op->args[2] = op->args[4];
                 /* Fall through and mark the single-word operation live.  */
-                nb_iargs = 2;
-                nb_oargs = 1;
             }
             goto do_not_remove;
 
@@ -4100,8 +4096,6 @@ liveness_pass_1(TCGContext *s)
             opc_new = INDEX_op_mul;
             opc_new2 = INDEX_op_muluh;
         do_mul2:
-            nb_iargs = 2;
-            nb_oargs = 2;
             if (arg_temp(op->args[1])->state == TS_DEAD) {
                 if (arg_temp(op->args[0])->state == TS_DEAD) {
                     /* Both parts of the operation are dead.  */
@@ -4122,19 +4116,15 @@ liveness_pass_1(TCGContext *s)
                 goto do_not_remove;
             }
             /* Mark the single-word operation live.  */
-            nb_oargs = 1;
             goto do_not_remove;
 
         default:
-            /* XXX: optimize by hardcoding common cases (e.g. triadic ops) */
-            nb_iargs = def->nb_iargs;
-            nb_oargs = def->nb_oargs;
-
             /* Test if the operation can be removed because all
                its outputs are dead. We assume that nb_oargs == 0
                implies side effects */
-            if (!(def->flags & TCG_OPF_SIDE_EFFECTS) && nb_oargs != 0) {
-                for (int i = 0; i < nb_oargs; i++) {
+            def = &tcg_op_defs[opc];
+            if (!(def->flags & TCG_OPF_SIDE_EFFECTS) && def->nb_oargs != 0) {
+                for (int i = def->nb_oargs - 1; i >= 0; i--) {
                     if (arg_temp(op->args[i])->state != TS_DEAD) {
                         goto do_not_remove;
                     }
@@ -4148,6 +4138,10 @@ liveness_pass_1(TCGContext *s)
             break;
 
         do_not_remove:
+            def = &tcg_op_defs[opc];
+            nb_iargs = def->nb_iargs;
+            nb_oargs = def->nb_oargs;
+
             for (int i = 0; i < nb_oargs; i++) {
                 ts = arg_temp(op->args[i]);
 
-- 
2.43.0


