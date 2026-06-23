Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36531CDB46F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 14:06:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc1lg-0005sE-CM; Tue, 23 Jun 2026 10:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wc1lZ-0005rV-3x
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 10:06:18 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wc1lW-0003LA-F1
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 10:06:16 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2c7cfa17fe0so3635825ad.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 07:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782223572; x=1782828372; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=IVr+aDBAZGI4VEbeSCv6md28Y5TwOASsMRi3OnSggNA=;
 b=Is7fLvyTM6KELo+OJwIghtA36l+xpfFfVGezSIV7ixeRU9GFWsxWi0osdiRQzz8iGs
 aQzb2/88RkF+z/Z39m9P6DR3R6NonSMlqWTPgnucS6cuF9yQLKMAV21abBLw6vDVY+v9
 bcccI5kLbBJ9UQGMLVFtR47SnWRxAh2qoK3VGQdMC8jaM3Q82C75cqvae55b3t+iZmuT
 PuWZz993yLPHx6i5l9tCLhJQgDDP2gpA99KjHfEaBWA8WbFX9KzMhVSOcQSTfn+gO60v
 U05nONWU9Tp4qbe1DaWu2W1U66lulawMkJUXqvVF6BQalzlJ/BvH49ppn7a6shXzfZC4
 MBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782223572; x=1782828372;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IVr+aDBAZGI4VEbeSCv6md28Y5TwOASsMRi3OnSggNA=;
 b=jdm9Kt6k7h+5+eWr2R7sRJbV18ANi4DYI8AAHa4VPKzcm2dJpoYgTKX7m2lBDlib/9
 lo2zfFieKJdyEqdApiCycJjiCBdOGKnbQI8rO5ldau5K8YZfCwLcT5CAWjAIh2zTZDKZ
 18pQOKChn6LWXyiNoDrvnmBbtsmd0qDeYBwYRmCiGTOcrEZ+P6C4mmoAcknQ+uqjkfjU
 co6zHIwhIozyiJbJEJLEcQ2sDDrY170uYwUgx5c8LNu2UvDJe28NnNQFWo8/OjgfQrb4
 +DR4TsDhXu2fQGI0evHytkGfxShoPRnZ9uNuDn5KghTJm2hm/wwxsqn6T4YeNEMKQUmb
 xnpA==
X-Gm-Message-State: AOJu0Yxg9vVry2BmmPQ5ZmV646gKiUc+U/Z1N3YGih208vzxDMzP6gFu
 63aJw65Wui95MXYysgMZt4Lj4w//wIdBB8AhkIfKoP1JMg9+Pdmhpf5LX0zAe5O3N7shbKnEbBQ
 YwrtE
X-Gm-Gg: AfdE7cnPaUkRSBWRK97ra0si1zIdk6DmptXarX8MxilUr9tumb2QDPHH3snH3j5cUoN
 NM33vLAOiwxc19kkFvA2IMK4oTNa860A3OgW+z+Ag99dmmQbPGavmqBzat6dTj00KnGeuJJHuKS
 5RBmJRyZkPmW8bTpeRTYkhImOBPHVI7U0gKDde3EdsdPvZtCG5sV2ZMQk4JNDPA/a0f8AFmcQfQ
 MqhghvxO60CInXdRXB59JrmWGzzwOs9ATnp0d5rltROHwtsjp+ShmwjvRI66M48Lt41hRKWsY05
 geqVfgj1y4kLBxh2lDR+qXGOjH2myGtr89kCfP3lJwnYRDpHO5tkHoBt9X8kSIrEBTyEBzGsijy
 dSbL3nyF+qcMizn6MnfA/doHwTdRl6XxIsfplK5eIL7kJ+EM9Nb72ihReVh6VOc0z5EOYjjDL0N
 V+Xj/4ZLQXk34dcouJUc8jcJX7/h8taMVZueUqQhX3E3uIWdZdwQ==
X-Received: by 2002:a17:902:d485:b0:2c6:a487:f431 with SMTP id
 d9443c01a7336-2c7c99de641mr28379675ad.23.1782223571426; 
 Tue, 23 Jun 2026 07:06:11 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7439f8d11sm115628215ad.43.2026.06.23.07.06.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 07:06:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] tcg/loongarch64: Fix cmp_vec with TCG_COND_NE
Date: Tue, 23 Jun 2026 07:06:09 -0700
Message-ID: <20260623140609.645445-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

For NE we need to invert EQ, not swap operands.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3589
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.c.inc | 39 +++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index c3350c90fc..182dcfd5eb 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -2371,19 +2371,36 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
                 default:
                     g_assert_not_reached();
                 }
-                break;
-            }
-
-            insn = cmp_vec_insn[cond][lasx][vece];
-            if (insn == 0) {
-                TCGArg t;
-                t = a1, a1 = a2, a2 = t;
-                cond = tcg_swap_cond(cond);
-                insn = cmp_vec_insn[cond][lasx][vece];
-                tcg_debug_assert(insn != 0);
+            } else {
+                switch (cond) {
+                case TCG_COND_EQ:
+                case TCG_COND_LE:
+                case TCG_COND_LEU:
+                case TCG_COND_LT:
+                case TCG_COND_LTU:
+                    insn = cmp_vec_insn[cond][lasx][vece];
+                    tcg_out32(s, encode_vdvjvk_insn(insn, a0, a1, a2));
+                    break;
+                case TCG_COND_GE:
+                case TCG_COND_GEU:
+                case TCG_COND_GT:
+                case TCG_COND_GTU:
+                    insn = cmp_vec_insn[tcg_swap_cond(cond)][lasx][vece];
+                    tcg_out32(s, encode_vdvjvk_insn(insn, a0, a2, a1));
+                    break;
+                case TCG_COND_NE:
+                    /* ne -> not(eq) */
+                    insn = cmp_vec_insn[TCG_COND_EQ][lasx][vece];
+                    tcg_out32(s, encode_vdvjvk_insn(insn, a0, a1, a2));
+                    insn = lasx ? OPC_XVNOR_V : OPC_VNOR_V;
+                    tcg_out32(s, encode_vdvjvk_insn(insn, a0, a0, a0));
+                    break;
+                default:
+                    g_assert_not_reached();
+                }
             }
         }
-        goto vdvjvk;
+        break;
     case INDEX_op_add_vec:
         tcg_out_addsub_vec(s, lasx, vece, a0, a1, a2, const_args[2], true);
         break;
-- 
2.43.0


