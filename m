Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97453F51415
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 07:12:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyPLG-0003A1-VB; Fri, 06 Mar 2026 02:11:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vyPLE-00038U-MQ
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 02:11:20 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vyPLB-0007gx-7W
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 02:11:20 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-8297c035d28so851615b3a.0
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 23:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1772781076; x=1773385876; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9W26TJswWcNU4/2b2//AYfKIC4DULXqjlOY61SCME94=;
 b=lTw63FHAi+CImhqJ/tADDZQWTfhzIsY34G+fevOkCzY/v8Mmd6mn4/FwzaR+jbYNKx
 SZNGKzGnZ0Qjm3Hq9nqGeEs3kiLDfa/7YJFKJAkxWjIvk0P3FP3dknVGql3G56sFLOnR
 3Nc/X049nV7x3TBYaVEiGd4WTSCYQXnii6ksTBWkngk5b78Sa0sep/aseGWLcz0CxeAp
 MTBytvKJeZIUjeAHpxMF1nmDjb1kekP22iTnTA/U5J9q5XhddV3F7ve5IwaUqyhSlG7r
 oWy0vWWkwOZrHfNjZjT38oZ7MxxLyPq3FTxqrZTyyF7oqI8s1eZfT6GEUaHagX8r9zay
 kTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772781076; x=1773385876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9W26TJswWcNU4/2b2//AYfKIC4DULXqjlOY61SCME94=;
 b=fgb3CdU7Wv8BH80ECJMjr0HHFYmhjjn01WgWABSUStWtQlH9jtULqTKXTtylXF3sXW
 mbl38gy+U+OwddFAQa6scKnr6nO/dW5Mjv8Ly4tZz/BB4CjFqxV/jSpqcKVl8A3POCDQ
 SRHaR6cwBwPU3NIc1F1/YbdOeggnGiAQl2hpiAT/xklNIDptzZMAxZblYtPeglVEKhOK
 LmIi4bmszMcCnzT02vcusX63x1TS8KPvMx9Dniqft7F4yQ+W4sO0nYjUjMx+deQxEHZW
 mHizpsX6Z/kkN/XJliCn3PL80FUvENAqq+YqNTE8OW5Uu5ig4IJDhp6AaTuXMVigvnzV
 ZIOg==
X-Gm-Message-State: AOJu0YznlP2wfro5/JkWWLuwKB6Mgd+kZy96ll/86bLZRVi9HlHwIYie
 wI91qIEC9XJ7W1yGBQC+3bV9KXebzcWqQriT9IhTkcHOWx/ZFpsR+fP6iqzApOLL/nYM3W26/S5
 h25AOSdebjH9RdrlF+r40CpP+VwwCsXoLGl+8hfp1zyz5/XhLnkNsdoZcZXgdWTdQ9X1so5y21w
 rodbLelpDAWK7tMnnJCxh5v4/f3rv0HD1LIPCaLpNlnRkC
X-Gm-Gg: ATEYQzzS3VtBoJjTDYWsqzQZ2CAOWxzMi3kf8WJP+emo+9KaqnUP85Q3UCjkRKQyBfV
 cnns1+3fm0q65P1fqi86BntiuslMxN08gJk9IQIxxgm4tS9RrP/0rIVLThS0RNjPjgJ5WCYSBaq
 oAc9LKZnTEGgpdnQW8EIgsNOLhnd5FptWD+AcoOiNNiExKeidoVSAs6fl/xb+B4IR5I2LryZa8H
 AaCTcY2MK5raDKsrQ1aV5d45oJAD7DE7y9+QV2khXLv/WtgLFQs9tdlgPnVfurBhqGfUcV4m9/b
 f8z16WXwL9TZm8S9aBsg0L4nOgR4+ghcOCbfiAeuyfn+ReedfUD9EU68Q3bgK0HYBlEo63p0gwS
 XvC5YH6dym/SJ3xiteC7htpGhRq1kPjK+YaffgnlUtOsSjZq7SPTF+dvIcVtOYL1I0lvZFSl4bv
 jHRaLwWY3niFHOdA449w8Tlf/OTAPpf05oOkwt4Q9ci1+Rlpi5xNplDMxQVXUpjtr35LHQVMjWa
 uVb1zghWGMMjECGfSwKCgirULk=
X-Received: by 2002:a05:6a00:6c93:b0:829:8fe7:7ac1 with SMTP id
 d2e1a72fcca58-829a30e02e4mr1045792b3a.66.1772781075514; 
 Thu, 05 Mar 2026 23:11:15 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-829a4636c74sm956093b3a.12.2026.03.05.23.11.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 23:11:15 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Nutty Liu <nutty.liu@hotmail.com>
Subject: [PATCH v5 2/9] target/riscv: Add the Zvfbfa extension implied rule
Date: Fri,  6 Mar 2026 15:10:57 +0800
Message-ID: <20260306071105.3328365-3-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306071105.3328365-1-max.chou@sifive.com>
References: <20260306071105.3328365-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x42f.google.com
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

According to the Zvfbfa isa spec:
The Zvfbfa extension requires the Zve32f and Zfbfmin extensions.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 2ddc26c837..376517755e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2619,6 +2619,15 @@ static RISCVCPUImpliedExtsRule SSCTR_IMPLIED = {
     },
 };
 
+static RISCVCPUImpliedExtsRule ZVFBFA_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zvfbfa),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zve32f), CPU_CFG_OFFSET(ext_zfbfmin),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
 RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] = {
     &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
     &RVM_IMPLIED, &RVV_IMPLIED, NULL
@@ -2632,8 +2641,8 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
     &ZHINX_IMPLIED, &ZHINXMIN_IMPLIED, &ZICNTR_IMPLIED,
     &ZIHPM_IMPLIED, &ZK_IMPLIED, &ZKN_IMPLIED,
     &ZKS_IMPLIED, &ZVBB_IMPLIED, &ZVE32F_IMPLIED,
-    &ZVE32X_IMPLIED, &ZVE64D_IMPLIED, &ZVE64F_IMPLIED,
-    &ZVE64X_IMPLIED, &ZVFBFMIN_IMPLIED, &ZVFBFWMA_IMPLIED,
+    &ZVE32X_IMPLIED, &ZVE64D_IMPLIED, &ZVE64F_IMPLIED, &ZVE64X_IMPLIED,
+    &ZVFBFA_IMPLIED, &ZVFBFMIN_IMPLIED, &ZVFBFWMA_IMPLIED,
     &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVKN_IMPLIED,
     &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
     &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SSCFG_IMPLIED,
-- 
2.52.0


