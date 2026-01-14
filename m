Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E402D31A0E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 04:54:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfsnX-0003zo-5T; Tue, 13 Jan 2026 23:47:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1vfsnK-0003mX-Op
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:47:47 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1vfsnI-0003km-Ap
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:47:45 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2a09d981507so3502585ad.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 20:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768366062; x=1768970862; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/h9Z+G9EziJ27dTxeY3yWmObXR1T/veTvJS5uPKvEJ0=;
 b=kw2MR3V+U7b7ww5N6SBDKHz8YGDRwd+jEuuJQ0LnRr3ut3dh+UiV4wBwfRytCYyEAX
 CZX4IGKhKzK5W5sUxrnosllgO75IQnixzC0R3ALLzm8xGS7ARv5Vww0fvEXBVYHgTisR
 HWeJhRhv6V18rnhp09jh0P6YNPDNadS569v6WgScpaULuZHdW70m8a5U+gM81gLjgC5+
 X9TMgTGsnNkQoUsWFEPWwvHcF4/hyfq0rIfRJOB69/3oIo50qzDdtC+08Pkxp4ihZgES
 Nv24YP9QP0hYGXt8Bm2HWGPhBwOLlJy/AKuff3i06umntKCwBWTu3Jm3EAu96V/YC0qZ
 Selw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768366062; x=1768970862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/h9Z+G9EziJ27dTxeY3yWmObXR1T/veTvJS5uPKvEJ0=;
 b=JHHPv5slhE7n6IShSgyxj/fVX/uqv+JqSLHDFESdr+dOg1tnhNVaaYIpqlTyb6xPm6
 89hpMKIhzzQ4ivqSLvRN3ELNUfDkbnmOySiwzRp1oNHxjyM4pyv1znWkxI0p5xM6Wq1k
 1IKe3tLj5Q8w60aLBnFVzvpj9tb5Qmoxs9XNSemLYdnJR0zkGL2avUNbAEZpg8Kfj5B9
 OJSVzfK7v6xZ1tPFOe1cWi4/VodSyg1Yt2ft6SWPs0wJ69DvYmQ//SCHbGxHMnzK0YhD
 ouTuKX5XcrKMu9Rl+eHl+ppqYw4jeOwL16MJHzojOFNVneFbjtLfecWNjm4I9VeFt+Ei
 BoKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWz1PMCucO9LRevasoDvunBj+Hz+ZLI1+UlZc+5sXI10okXX2CooUtGgIxFUcNT8W9qHnHoNw/rWstd@nongnu.org
X-Gm-Message-State: AOJu0Yw84ous/EqA8xqcvpoMu1z4wljvisEuL+soO4IrJOkCmwFb1gpr
 CmyCcKSezbk8ZFqAyJfI5+zl79ZVc/P02RLye6Utj2gic6FkqUd9CIBu
X-Gm-Gg: AY/fxX6JB2CCEoz0jFJovVhol5ITKOEROwYPMbHDKrvso4QsuWZYBXF9GzL7g1K6uOF
 JV+eVSs7FLgkI2X1I+bxUeb83Cj0Au04Rw2a8sF9xg2mDl5YYasmbb7LMw+gFvsjhIJ6nil/QXo
 cgXakbGZfqCku9DQd1hoalYE42SHLcKKXbakH+EYmLfQ7dlE2iYbilktgtA9Gi4u/2JzQ6Jh0+P
 CVTZKNYthTFi3iHC6OKLsPGtnKFyBBRhSLBjvp4auEDNA6TaDIT02JGXUA77g6rOpYVfElnOltx
 xx3ADqgAm3VP+k9wS99cSZz2kFQjE1Ze8cX0hpJnCtwp5q4090157zldLHCTGW/Hhy4+JrTe2az
 zCU+RIOjistrQW3OLFaLjGu7JwpS05RS1H1UyLvF1yN3F22szX/zzBYeJX4DOMeZNcXsxGdySnf
 f818+u/4WFRwIyQzGUIx3fYfOaNKC3K5Trz/OzYqHHYOaOJkfHZCULQ8/b4Lc=
X-Received: by 2002:a17:903:22c8:b0:2a1:3ad6:fab3 with SMTP id
 d9443c01a7336-2a58b49d64bmr46915815ad.1.1768366062327; 
 Tue, 13 Jan 2026 20:47:42 -0800 (PST)
Received: from lima-default (123.253.188.110.qld.leaptel.network.
 [123.253.188.110]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c49037sm216111905ad.36.2026.01.13.20.47.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 20:47:41 -0800 (PST)
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
Subject: [RFC PATCH 04/25] target/riscv/debug: Fix icount trigger privilege
 check
Date: Wed, 14 Jan 2026 14:46:37 +1000
Message-ID: <20260114044701.1173347-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114044701.1173347-1-npiggin@gmail.com>
References: <20260114044701.1173347-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62b.google.com
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

The check_itrigger_priv() did not check privilege bits properly. Move
all priv checks into functions and have the icount check follow the same
form as the others.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/riscv/debug.c | 82 ++++++++++++++++++++------------------------
 1 file changed, 37 insertions(+), 45 deletions(-)

diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index c92bd9860e..2effbb49af 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -306,48 +306,50 @@ static void do_trigger_action(CPURISCVState *env, target_ulong trigger_index)
  * Check the privilege level of specific trigger matches CPU's current privilege
  * level.
  */
+static bool type2_priv_match(CPURISCVState *env, target_ulong tdata1)
+{
+    /* type 2 trigger cannot be fired in VU/VS mode */
+    if (env->virt_enabled) {
+        return false;
+    }
+    /* check U/S/M bit against current privilege level */
+    return (((tdata1 >> 3) & 0b1011) & BIT(env->priv));
+}
+
+static bool type6_priv_match(CPURISCVState *env, target_ulong tdata1)
+{
+    if (env->virt_enabled) {
+        /* check VU/VS bit against current privilege level */
+        return (((tdata1 >> 23) & 0b11) & BIT(env->priv));
+    } else {
+        /* check U/S/M bit against current privilege level */
+        return (((tdata1 >> 3) & 0b1011) & BIT(env->priv));
+    }
+}
+
+static bool icount_priv_match(CPURISCVState *env, target_ulong tdata1)
+{
+    if (env->virt_enabled) {
+        /* check VU/VS bit against current privilege level */
+        return (((tdata1 >> 25) & 0b11) & BIT(env->priv));
+    } else {
+        /* check U/S/M bit against current privilege level */
+        return (((tdata1 >> 6) & 0b1011) & BIT(env->priv));
+    }
+}
+
 static bool trigger_priv_match(CPURISCVState *env, trigger_type_t type,
                                int trigger_index)
 {
-    target_ulong ctrl = env->tdata1[trigger_index];
+    target_ulong tdata1 = env->tdata1[trigger_index];
 
     switch (type) {
     case TRIGGER_TYPE_AD_MATCH:
-        /* type 2 trigger cannot be fired in VU/VS mode */
-        if (env->virt_enabled) {
-            return false;
-        }
-        /* check U/S/M bit against current privilege level */
-        if ((ctrl >> 3) & BIT(env->priv)) {
-            return true;
-        }
-        break;
+        return type2_priv_match(env, tdata1);
     case TRIGGER_TYPE_AD_MATCH6:
-        if (env->virt_enabled) {
-            /* check VU/VS bit against current privilege level */
-            if ((ctrl >> 23) & BIT(env->priv)) {
-                return true;
-            }
-        } else {
-            /* check U/S/M bit against current privilege level */
-            if ((ctrl >> 3) & BIT(env->priv)) {
-                return true;
-            }
-        }
-        break;
+        return type6_priv_match(env, tdata1);
     case TRIGGER_TYPE_INST_CNT:
-        if (env->virt_enabled) {
-            /* check VU/VS bit against current privilege level */
-            if ((ctrl >> 25) & BIT(env->priv)) {
-                return true;
-            }
-        } else {
-            /* check U/S/M bit against current privilege level */
-            if ((ctrl >> 6) & BIT(env->priv)) {
-                return true;
-            }
-        }
-        break;
+        return icount_priv_match(env, tdata1);
     case TRIGGER_TYPE_INT:
     case TRIGGER_TYPE_EXCP:
     case TRIGGER_TYPE_EXT_SRC:
@@ -665,17 +667,7 @@ itrigger_set_count(CPURISCVState *env, int index, int value)
 
 static bool check_itrigger_priv(CPURISCVState *env, int index)
 {
-    target_ulong tdata1 = env->tdata1[index];
-    if (env->virt_enabled) {
-        /* check VU/VS bit against current privilege level */
-        return (get_field(tdata1, ITRIGGER_VS) == env->priv) ||
-               (get_field(tdata1, ITRIGGER_VU) == env->priv);
-    } else {
-        /* check U/S/M bit against current privilege level */
-        return (get_field(tdata1, ITRIGGER_M) == env->priv) ||
-               (get_field(tdata1, ITRIGGER_S) == env->priv) ||
-               (get_field(tdata1, ITRIGGER_U) == env->priv);
-    }
+    return icount_priv_match(env, index);
 }
 
 bool riscv_itrigger_enabled(CPURISCVState *env)
-- 
2.51.0


