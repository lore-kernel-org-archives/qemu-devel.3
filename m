Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78691F5140F
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 07:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyPLK-0003Bx-JO; Fri, 06 Mar 2026 02:11:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vyPLI-0003BA-PF
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 02:11:24 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vyPLH-0007jC-54
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 02:11:24 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-827270d50d4so9274935b3a.3
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 23:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1772781082; x=1773385882; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XHny1TMn5q5In1DNoCgSGzLeh6esAvW3TWT30T8JNEo=;
 b=Y2J6xUsssTE/KwerY5DUtTP2rhMsgnjQL9qIxavLHNl2SbzrHDPBpfKBqjwXB1bAYz
 DPu3GnQHKb3o/JB1avMT2sDg4pl9IFZpz4RlwYDmGv75OzvTzpV+rXykenvlCzSho5o/
 Cvra+/hBNYYpXk6cUWfHg4Rmh+gmqU8q27VoKTDuhrj3Fw518gue/Jf/SIkhd+rYu/3V
 M1+zBx4PluaZIUpXEaVSR+s0koxjEUZ0fUb5XSSc26mpGwV1NNGddqh21567+Vfpyj5I
 kgq34KNsleC3zHofxVZWg06Xl6+WlgbuBOTsQP+Z2FzzvsbU9XukFAZ4nVGzE6rPMnxF
 oRSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772781082; x=1773385882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XHny1TMn5q5In1DNoCgSGzLeh6esAvW3TWT30T8JNEo=;
 b=Vq9OYnYEQLeIxjIyaLhCvDlKYfDqfz2p+m+1Il5WfjAWmdNagnCf/NBQhV3QvShr6H
 IbKEncl2Q5yZSdElT4l4d4QvQxSkf69NAroh3/t4dE6iQ572wrPavW0VGhTqslTCnysH
 HyIPqus6f4asNqJvRXBlY5HOUdtrc03L1qAmstTBK76uodRkzF3RPCPpCvgJDW2526OB
 9i7Z+RuSJm84tZBHii7gMCOvtSmWITpwOaj6qQKiPDLYamww6RuTvTShWgKdLbaI2K7p
 cDtgNTDOb2B8tmftwrUkI3sRqDzEET8cL1FfDe42h/iod/SxPAQwozXeIIqaZaVwJwUH
 b3Lg==
X-Gm-Message-State: AOJu0Yx34hVRuCYZA990qeFRQY+Jb8eGoAhw24G5MlJW4PdujbOQ1nRL
 B0z5AfmhY16v3t/lMI1KrVGj0xx0Vydd8NNSPIi8yAmcMgtR+JJjs75//u1iZIKs2r3QHWNR+M5
 vwiD8TxYul7VCCB2KWBhp+sZk1hf62Sfm1wUX7/I7+fQzws0v2JyoQ6pLtzkAAwfQoQ+rvo+Mab
 AxTt/giKJVFA1XhXaRM+7xIdiU/f9J9EOaCAT1UvRZViUd
X-Gm-Gg: ATEYQzx6+uyShJZO8MPsPAPYAxlBs6wEO0N+8yF+cDqB1aRXd6KB2EyxU+QMOgoLqWb
 Ql3/HgCUgDDJ/T7ujMEL4nbCAf//oWCahpqttZXX7QhNK1nvdJBpdg/XsHKGTpLRc/tUoM8iof1
 u1FClnTaOrXF1AQfsfpff8NgVHAynFVURh94uCY/Aif+XHHrNPRxKILzOhm74gbjx5o1WkuOLip
 iZwJwpq6KW0YMXF6RCVIYyV3vo0EjnbkSMPQsrMQjPmF9jANjF378dhWr2XZcRHeleFWE8+GARy
 iNgCoaTMFXjSH8If4ERimKIUOtpgxYCU2pd5rgcEVWhT1Z3LeUc5yqRssLNqX/Lf+UPA9JViTtk
 OxASqdPUV0wan6PIVxoem+HdnBjzWitVZ2HcmlMRuWkoROoKekVBCb/u4/S25Yn80ffAmqdHSF3
 394/NwMqfE8rdx8lC6BpL1AKXxW9gzqgIwVT1baIjRdQ8AiWVhcV30q2wYz08Bf5u8UWZbs2U8X
 q4PuAmsPmpdkKpDy7pngwCjttA=
X-Received: by 2002:a05:6a00:1905:b0:81f:5f49:6913 with SMTP id
 d2e1a72fcca58-829a2f788dcmr1144696b3a.30.1772781080006; 
 Thu, 05 Mar 2026 23:11:20 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-829a4636c74sm956093b3a.12.2026.03.05.23.11.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 23:11:19 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v5 4/9] target/riscv: rvv: Introduce reset_ill_vtype to reset
 illegal vtype CSR
Date: Fri,  6 Mar 2026 15:10:59 +0800
Message-ID: <20260306071105.3328365-5-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306071105.3328365-1-max.chou@sifive.com>
References: <20260306071105.3328365-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Replace the same vill reset flow by reset_ill_vtype function.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/vector_helper.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 7575e24084..b7105627ed 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -49,6 +49,15 @@ static target_ulong vtype_reserved(CPURISCVState *env, target_ulong vtype)
     return reserved;
 }
 
+static inline void reset_ill_vtype(CPURISCVState *env)
+{
+    /* only set vill bit. */
+    env->vill = 1;
+    env->vtype = 0;
+    env->vl = 0;
+    env->vstart = 0;
+}
+
 target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
                             target_ulong s2, target_ulong x0)
 {
@@ -93,11 +102,7 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
     }
 
     if ((sew > cpu->cfg.elen) || vill || (vtype_reserved(env, s2) != 0)) {
-        /* only set vill bit. */
-        env->vill = 1;
-        env->vtype = 0;
-        env->vl = 0;
-        env->vstart = 0;
+        reset_ill_vtype(env);
         return 0;
     }
 
@@ -113,11 +118,7 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
     }
 
     if (cpu->cfg.rvv_vsetvl_x0_vill && x0 && (env->vl != vl)) {
-        /* only set vill bit. */
-        env->vill = 1;
-        env->vtype = 0;
-        env->vl = 0;
-        env->vstart = 0;
+        reset_ill_vtype(env);
         return 0;
     }
 
-- 
2.52.0


