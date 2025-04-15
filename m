Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE3D0C369BA
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 20:03:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4mGU-0001ET-Ju; Tue, 15 Apr 2025 15:48:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4mAo-00071T-3k
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:42:23 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4mAA-0007BE-4P
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:42:14 -0400
Received: by mail-oi1-f180.google.com with SMTP id
 5614622812f47-3feb0db95e6so3810949b6e.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744746064; x=1745350864; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+auAC/0fVNtyUj9IXA1C/8l+Sur9fbt7QCSiCH6lOqc=;
 b=l/qDztFpY7X3orh+3+YB6laVBDVxwaejsKVw32Jwc1sO3134e1YCxtmg9/kuxQCtbp
 OBsi2HxhsWBh7CU2klPfHnypdJAbMqAOzljrccqttHPr4bffA5lh1Sla4xDv07UE5fE1
 R/FjNnd1Nw2JHmToQnmLLauC0n3p2JqSnV09GWSG5m1RBqzlQmBN35twiJqlB043TkrY
 22qWXCpu2/FepaoCpXoDfzQ7jRNR/bT5upS6hu3Crnt6X1oqzcBe9Grmzf2wyUrbc5pk
 1qWJNPQ7VG1RO0O1dwCmysZrcU64g/Jcd4XAYaSeF7hryydaJY7so/FiVtMMPT2gUWcI
 0vew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744746064; x=1745350864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+auAC/0fVNtyUj9IXA1C/8l+Sur9fbt7QCSiCH6lOqc=;
 b=NIxBvTJ2+8wNWvsEYAYqDRfSSEPmzguHWsoK03G6rbQ94sG5upuaS5Xe0GCeZgmHOD
 LOSbt3jiiJorN9+z9XLzubkXJqqd31uic3WIHD6CGo+tZMTjAjj6NkQcncq5btpxr6p0
 YRkDGPxCQjNJ1mYZO4FpERgMRlOyvfootlwsxldllK+m5zkGiq3N9/G5YimU6rakLbNo
 tY7335fJu9IgVu5T/AdF/TB4bBaWHsGzCEWa9Rz21kwY/rGiFlrHjGNyetmbvqLx6/gK
 /MAgD9o1QuI8xDBaj+ioBx3ADWFf8CjsfcVklld4cdK8Us8eWmIUp17juUeYWlLcWk07
 MnhQ==
X-Gm-Message-State: AOJu0YwikC/zUO/sHKZZnFaLFL38BetsVcIFwV6YIVIehbGof/ICjhoe
 MmBMrJ5YumK6rp9mI8X6MPt5kfJNsSpdGDQZwD/ZwGk3TPdbbk9sGMi8t6Wywdef96yvO0+j5hs
 u
X-Gm-Gg: ASbGncuyJ1wqtKrVCmcFl8ffGimnR9veB7YgIMOcO6LIf7gzqWCtgV/sUkZhMM3Vnwc
 yQyRyEhSbbvri1TKCg7MNCOZo3qep/zXNSS/H6PvlW65SbLi3i41hbxZcwrjztmCSIbmgmOOAZz
 saCdjGyqTzI0TTeLWbZFa3TIB6EJ8R3mGgkFrrUZ+ZXV96nLuqCfoaEEi/H9u3NWewPp2a+ySxh
 EpdGjVoufkuvf8ax7Y+C2T3M62ZrQdxd95jzlwohzIUnBzNaR8tf/PJQl3uEMe6jlfPKdjdYCbG
 mnjdfdeiNTsKqDA5UqZnjkDtyRlny32x8y5oFEy1mJpuTPq2DPY45tRIbYewmYg0g1VB08ZrgAo
 =
X-Google-Smtp-Source: AGHT+IEIXzOcghfrkHJ5KFWIoUnlAl3ZFVd6HUUb+32SPwAbSxc7/aS0XIVFeQDml65fXbgz4mlx8Q==
X-Received: by 2002:a17:903:228e:b0:223:66a1:4503 with SMTP id
 d9443c01a7336-22c31a6e008mr5350015ad.30.1744745570468; 
 Tue, 15 Apr 2025 12:32:50 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7ccbd5esm122062355ad.248.2025.04.15.12.32.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:32:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 112/163] tcg: Sink def, nb_iargs,
 nb_oargs loads in liveness_pass_1
Date: Tue, 15 Apr 2025 12:24:23 -0700
Message-ID: <20250415192515.232910-113-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.167.180;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-f180.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index 9da6c8bb4d..381e76cfc8 100644
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


