Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13018C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:18:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8RAa-00039Y-Bn; Fri, 25 Apr 2025 18:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R7r-0005oo-67
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:02:29 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R7n-0001PR-UU
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:02:25 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-b06e9bcc986so2225853a12.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618542; x=1746223342; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c7nKQ2YkM0Lpy1XEsivIBsnUnrv96r1Hsq5GljE/l0I=;
 b=EYyYfzISs2oJyp8csH3huepzM3TReMBy/5BWD1Qlv6/3Iic7xg61XL2fQ8D0k1vqCB
 EMezQ12AnPbN4Mdq2spzt79PSOOb+xuMlx6EHQKadg1f5S402uxVziyhdbhFdpl5/0KK
 zQ27FXVp1FhQsQbTrwfM7jFuQ0EqakUZ+hgc6YD0N09FF5hkXXWwqfgmFlIpQu3h4CVQ
 B6L6D6+NaDY0obLuihck/ZMFNcFkTlu4KaGXgfTVaAKw2QVVVSjtDRsRxIaSB9R7GVHH
 eEdLulRxcjjjSpPPt73ocewXwzV96UkAyh7C6JcxzZxjuhfUbPekPTlXcywaW978MA6M
 8ykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618542; x=1746223342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c7nKQ2YkM0Lpy1XEsivIBsnUnrv96r1Hsq5GljE/l0I=;
 b=hUxLgeRVqMgGqRF/o9gI13yGPfh37rjIpfL2plg6iN+lH3VNXR6bbBAvYvevOLO813
 MDshEEAbr2J0acy9ZsPQ2XsJHEj8A1OTgXP/s2dquMPpOs9jMDqQ8RfASMrjLxJJmczJ
 XRPGoH4to4RZi3xiG0DejYfy5tspSzTLyONiRre9q9ckiQhLcltHuaWFoRbTgv4L0MMk
 M53pvDAea0eoBztXddnyqzAEeRL0BU8eMhXrXxUBqJ3pTWlJWzG5GxKzNFspFxuUpuKs
 3kl7ojAXeg7CGIiC/p8QzbkHNiALzIGmnC6Aec5cXiXMa/dBBKpemHBZGZPra1eNIYW0
 zerw==
X-Gm-Message-State: AOJu0YzqRiIL0Bo1WiM8s8NMMPm0wGgoj5s6TnlZXF+qyofFvUrnk82A
 FRgabdDhwOgLbnQYecQvGBTLmsOFQ4WYfJyFgeqWVMWNWjmYR49qoujnUHV6KSaSXXgA+DdcedW
 n
X-Gm-Gg: ASbGncvGA6zOQ1XQEgwDwHd5oNkGkLLFBezV1mNsUuznTVTIt3utALKeImOtU+Gqgnn
 yX19vW85vuuqu1kv93ICd0WIEnQFEsfiz3XrH4fihqpHGCh2S5YkX9LpbgIXnDti2e6mPgr4LsJ
 k9OXyxnHBo5ROiAQsUoD6lFsQQG6fddgjYc6ppLoayRH9x35JSxxLenTlVqX7DkULtygou1twgT
 upOZOk0MOYN6ZBH3g9wJ9QFb3OfLtf1BzsAXnujs1JK4dT7yiLUqi5gNSSYVC6sy89ntLWZGYkM
 +dEtpaL86UpnNBwsXUTRyifin+yGULT4ispu1umtLkwvcW8eaXVRDb06iSVlD0f1P2DqCrMRKjV
 C6n9IhUDrBQ==
X-Google-Smtp-Source: AGHT+IETHZe3DVSeXStk2aB/yyzQvkborwkZjY6cTFPmnpge5Kq9RNEHuVaKTz3+nYN49+L9YjOX0g==
X-Received: by 2002:a17:90b:1f83:b0:2ff:7031:e380 with SMTP id
 98e67ed59e1d1-30a01327529mr1716104a91.10.1745618541991; 
 Fri, 25 Apr 2025 15:02:21 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309f7765c88sm2212961a91.28.2025.04.25.15.02.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:02:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 116/159] tcg: Sink def, nb_iargs,
 nb_oargs loads in liveness_pass_1
Date: Fri, 25 Apr 2025 14:54:10 -0700
Message-ID: <20250425215454.886111-117-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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
to keep them up-to-date.  Note that def had *not* been kept
up-to-date; thankfully only def->flags had been used and
those bits were constant between opcode changes.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index e2ca02eddf..2849bba480 100644
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


