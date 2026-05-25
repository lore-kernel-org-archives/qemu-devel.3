Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E806CCD5BAB
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 02:43:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRLHD-0004IB-P9; Sun, 24 May 2026 22:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1wRLHB-0004Ht-Te
 for qemu-devel@nongnu.org; Sun, 24 May 2026 22:42:45 -0400
Received: from mail-dl1-x1244.google.com ([2607:f8b0:4864:20::1244])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1wRLHA-0002MR-BL
 for qemu-devel@nongnu.org; Sun, 24 May 2026 22:42:45 -0400
Received: by mail-dl1-x1244.google.com with SMTP id
 a92af1059eb24-135e88b8e55so6941171c88.0
 for <qemu-devel@nongnu.org>; Sun, 24 May 2026 19:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779676962; x=1780281762; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5C8ZLi+jzOwclay2/HrAK2Y78iK5fLfoChmN3/la8PM=;
 b=lHI3A0F0iyEhWUqjPWOXpYnnC+/ABQiPJEO5qMSbO7LfhhvFVActEm61fvBY3N3JvG
 +lYeKiUH0pNTJ9BTJgOErURkRAI26xvm9gdG86oot+ecLatWwsyz6F+2ItBykVPyZhv8
 o11yL3DfPd//Fg/kcfoaS0mFEQblG/oXCfkCE2o+cm14+uuEAa25bINaNg75sz6sxUqM
 ZqzwHmf71Ue+UdQSFN9mkZnVppxc812lBqz77CrDOcaii9B+Zn6rEcWksOV6UPEf2NwX
 M76JDj3OMsZBW9wmNVUbp1NqtMDg1YLhDHA4zklAebPtdX4V2HDAaAAFENt15YdIPnDv
 EjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779676962; x=1780281762;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5C8ZLi+jzOwclay2/HrAK2Y78iK5fLfoChmN3/la8PM=;
 b=JEgikeDAsYERKsFD+UdiEaYQyd+q6/+xDegp0qvSU61UCUUwc5uQj+FUIxsKBIU9hZ
 Hl3eEbjuR4iHnqtzopIJpb77KqhHQj4r/xTZXhGuu/YuLzn2xsvONFm5X0T+v0ibX+fO
 sJ1LroNrzaJxRbyx5x3Kd4kI1tzJZfRMSKIW93KH4EP5TdBRPbZwZylyulcqmBe0Pu1J
 n30AxXpS5tpDmwEWM0GpoKEpOO4UhkNabSHR4pke1Vx2bQoDWZxJ/8D7ybcgLlJTvnj7
 eJATPqyXIrdn+TUFOT9xvO+tQbEdhLmRGp/lQ9Q679zi0Uk0Q+pZwNN1xxn/bbjM4nuK
 n9Ew==
X-Gm-Message-State: AOJu0YwCe+jqW2jBbBCgmi4q71FgudzN8oz1NPkHOvrsCJVqqwfZZ7e0
 uIXOrEVKMmEfigwoauvdVBKhYL9EOzWfA6g/Gq/T+Xf/Qr6jLTY3SGoium0BGOQNNbM+Lg==
X-Gm-Gg: Acq92OGtEF6JtS22OVnJhanpCpxWCXEWhVlykQ0PuW51hg/7TqQbWzAhb5EPOnyZTtC
 N3sIs315dwBpSCeJ2eCnVVrBOprHGvgttX2uRQVpPjNFWUuCjxnXl08HS+C/+gu7ngwH8CuZD1N
 tigbuezGAfbFm1QjmIjj+slm/LwzwEsKfI3kYf0FCJOHowOq69H9UrnU4xZ4N2VbfzEm/EYs8RV
 zVMM63LpCLz8mqFpbGqj9wSQbcVYpKa2r9EmHZeKb648sBoPYYDABg8K3sORxB3RpaNpkvSfvlE
 C5KyMsZ27E1Nu50Y5XDCN+5Wqz4LrZukX+jQr3UdvfKgFrN7rgL/lwf8XN4MrX8LbYooVV53PCE
 pKPbMPn6gDDOgSYPLj63pUqRTtoCzYbpYcjRh4Kt9v+0bl5PXWKNl0vyN0yUfecFgSjYfmKSkDz
 ga+ywAhtADf+eQCkaujvbrQuRXdHrMkl2mrXYsO3OgtpUG+GRQ7BjUg1CBv4xc5ToQU1EeKAeW6
 zxFoSAFaBfiHBOVEMNSwTcAwbl5
X-Received: by 2002:a05:7022:671f:b0:12d:d972:b96e with SMTP id
 a92af1059eb24-1365fb3f882mr4251601c88.20.1779676961879; 
 Sun, 24 May 2026 19:42:41 -0700 (PDT)
Received: from openkylin-pc.lan
 (ec2-3-101-81-203.us-west-1.compute.amazonaws.com. [3.101.81.203])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1366aba39d7sm5037078c88.14.2026.05.24.19.42.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2026 19:42:41 -0700 (PDT)
From: Zephyr Li <fritchleybohrer@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, daniel.barboza@oss.qualcomm.com
Subject: [PATCH] target/riscv: Do not hide Sstc CSRs from gdbstub
Date: Mon, 25 May 2026 10:42:20 +0800
Message-ID: <20260525024220.39027-1-fritchleybohrer@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1244;
 envelope-from=fritchleybohrer@gmail.com; helo=mail-dl1-x1244.google.com
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

The Sstc predicate currently checks both ext_sstc and rdtime_fn. This
causes the gdbstub CSR XML generation to skip Sstc CSRs when rdtime_fn
has not been initialized yet, even if the CPU supports Sstc.

As a result, GDB reports $stimecmp as void with a CPU that exposes the
sstc extension.

Only use ext_sstc for the early existence check, and keep the rdtime_fn
check for non-debugger accesses.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3496
Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
---

Testing:
    Start QEMU with:
        qemu-system-riscv64 -M virt,aclint=on -cpu max,sstc=true -s -S -nographic

    Before:
        (gdb) p $stimecmp
        $1 = void

    After:
        (gdb) p $stimecmp
        $1 = 0

 target/riscv/csr.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index da366cf562..c17df147f7 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -586,7 +586,7 @@ static RISCVException sstc(CPURISCVState *env, int csrno)
 {
     bool hmode_check = false;
 
-    if (!riscv_cpu_cfg(env)->ext_sstc || !env->rdtime_fn) {
+    if (!riscv_cpu_cfg(env)->ext_sstc) {
         return RISCV_EXCP_ILLEGAL_INST;
     }
 
@@ -603,6 +603,10 @@ static RISCVException sstc(CPURISCVState *env, int csrno)
         return RISCV_EXCP_NONE;
     }
 
+    if (!env->rdtime_fn) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
     if (env->priv == PRV_M) {
         return RISCV_EXCP_NONE;
     }
-- 
2.43.0


