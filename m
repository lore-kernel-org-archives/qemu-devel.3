Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E16ACC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:43:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGprg-0008Rv-Vh; Tue, 13 Oct 2026 23:41:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGprd-0008Fj-Qk
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:41:13 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGprc-0001ig-Aq
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:41:13 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-3ac7842c17dso6645a91.3
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 20:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791949271; x=1792554071; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fOHoME6l4K2XXJPVCYX52/ZRB/Esyz7w42E/rsYmQJw=;
 b=iKO/M5ysHrsh/9v3qIHspCXXfgxzt0frk/eJtUMfuP5xlPQVwj71maqFkYySgWgtsA
 jTn8j5Si6ryyVwXjL7ep8EjRs4FQLkEW3Hd3NDuU06q8QExPkdj6EI5qxKX8OS9Q+ra+
 8oO+kRqHUNOw+GKiX3Zx+2U+Ows57xeq0igGiewW0crfYCWai7Y7hD4818TdCl/YdWGS
 9PcKzdA7pBMP/xaJN3GvqsmEPKGUNLnya0ambvACuvyPYwjQq1jWLiFuB6mUephtiKjF
 27VJU2T+u2IgO7RsKBB4oTkbzh5CSj2/PAYZyLLFx8CclOcZug94WG8agCfd1SspUEc/
 JYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791949271; x=1792554071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fOHoME6l4K2XXJPVCYX52/ZRB/Esyz7w42E/rsYmQJw=;
 b=vFDqe6cwFJ51ClvG0bFuLsmM/TsJfFBW0T0dZz1s25QG5JHV1QK2vJi4F6SiaGaVk3
 VcHfRDiJYLu6VYeoRfA6qnLQPSR/abBZWCGa7xeCVduJelLo2l3Q56FL0sAJ0rIn3CJQ
 Jxehna8gz6Xuqk7mB4b6NuqMqqZhmTxh7jDRNd7nZ+xm/jRQVtRRR+WkMPg51oCcm2OR
 8UWPTTFiZdqoQtLkqAoMJluN0lCgRguLbE17UDiYioSrn1Z1MxEbpLiX4XntXuZmEwgn
 CwEIikdZgefsjnWWNVrBwUqSDBplpQQ5gNl7C/wCZJaRg+BUurbtmpIAAcg0SoVUyQSU
 3yPA==
X-Gm-Message-State: AFq9FYILU3fWaeSNU3ipVDy5tJIdEXweQyIyY29WQIbCH35d3ZiuUpxj
 vfsRJYdv2lL4wOVeEwIIZKXCNsQg+FfJR1b1k3oRPurOsDr2s8pe5Yz/bO1Yxw==
X-Gm-Gg: AYBFou0kAbWe1xqqusik76L4OMgXzgZGbItUyNWame8hiZQFUkQb7YAskzWteuUhdjw
 DctyNHu6m8sNWBoqjbLg3gxeGcGWJMHqaYAANK4CcJigyFGfOKfhDwO1d8aAUYORZECxaosqR2q
 X6cCKMDJjhdD7vs/2nlsww9c4QdUdqU4/4kwAZE8kvQqy3olEJ892MPCwBJtjCRZF7blOjdTc3j
 U1xHcxp9LaN24YBLItS6F8iKBNx1F7Nmml78mT/4g+cQnW3P+ocMZiNwFaAP7v3IRg8Xlf9jwXm
 BmjhxAb4b2Ob7Vx8zXdpHkh5JX3zxJOlE+XyJmOM7EiklxxoalnvM/JpNtW/fAHSnzxokWp0C2o
 GRi/g1jm0SKHTrAbaWP7kO70cb9NcxIMe2v5S6QZPvE1PhM5/O5AgqgGyO+JHbFta1T+oTdOeZK
 0lq1pOloaqU9avlA6NnticE8LkTWv+0CFwk4dlJlD79GRL+dwZHYFYmUoadC45DvRLgh4Ym+86E
 YzJxuX+khqUdCpd
X-Received: by 2002:a17:90b:2e8c:b0:3ab:1e1c:837b with SMTP id
 98e67ed59e1d1-3ab3a9183b3mr12696240a91.63.1791949270839; 
 Tue, 13 Oct 2026 20:41:10 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac61170b7bsm2321457a91.16.2026.10.13.20.41.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 20:41:10 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Max Chou <max.chou@sifive.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PULL 35/52] target/riscv/cpu: List one implied-ext rule per line
Date: Wed, 14 Oct 2026 13:38:50 +1000
Message-ID: <20261014033907.3332383-36-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014033907.3332383-1-alistair.francis@wdc.com>
References: <20261014033907.3332383-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

From: Max Chou <max.chou@sifive.com>

Every entry added to riscv_multi_ext_implied_rules currently has to
reflow whatever line it lands on, since entries are packed several
per line. List one rule per line instead so future additions are a
pure append.

Suggested-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Message-ID: <20260927082534.3228237-3-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 58 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 44 insertions(+), 14 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index b8cedbf7e9..f145f8fd0b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2928,20 +2928,50 @@ RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] = {
 };
 
 RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
-    &ZCB_IMPLIED, &ZCD_IMPLIED, &ZCE_IMPLIED,
-    &ZCF_IMPLIED, &ZCMP_IMPLIED, &ZCMT_IMPLIED,
-    &ZDINX_IMPLIED, &ZFA_IMPLIED, &ZFBFMIN_IMPLIED,
-    &ZFH_IMPLIED, &ZFHMIN_IMPLIED, &ZFINX_IMPLIED,
-    &ZHINX_IMPLIED, &ZHINXMIN_IMPLIED, &ZICNTR_IMPLIED,
-    &ZIHPM_IMPLIED, &ZK_IMPLIED, &ZKN_IMPLIED,
-    &ZKS_IMPLIED, &ZVBB_IMPLIED, &ZVE32F_IMPLIED,
-    &ZVE32X_IMPLIED, &ZVE64D_IMPLIED, &ZVE64F_IMPLIED, &ZVE64X_IMPLIED,
-    &ZVFBFA_IMPLIED, &ZVFBFMIN_IMPLIED, &ZVFBFWMA_IMPLIED,
-    &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVKN_IMPLIED,
-    &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
-    &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SHA_IMPLIED,
-    &SSCFG_IMPLIED, &SUPM_IMPLIED, &SSPM_IMPLIED, &SMCTR_IMPLIED,
-    &SSCTR_IMPLIED, &SSSTATEEN_IMPLIED,
+    &ZCB_IMPLIED,
+    &ZCD_IMPLIED,
+    &ZCE_IMPLIED,
+    &ZCF_IMPLIED,
+    &ZCMP_IMPLIED,
+    &ZCMT_IMPLIED,
+    &ZDINX_IMPLIED,
+    &ZFA_IMPLIED,
+    &ZFBFMIN_IMPLIED,
+    &ZFH_IMPLIED,
+    &ZFHMIN_IMPLIED,
+    &ZFINX_IMPLIED,
+    &ZHINX_IMPLIED,
+    &ZHINXMIN_IMPLIED,
+    &ZICNTR_IMPLIED,
+    &ZIHPM_IMPLIED,
+    &ZK_IMPLIED,
+    &ZKN_IMPLIED,
+    &ZKS_IMPLIED,
+    &ZVBB_IMPLIED,
+    &ZVE32F_IMPLIED,
+    &ZVE32X_IMPLIED,
+    &ZVE64D_IMPLIED,
+    &ZVE64F_IMPLIED,
+    &ZVE64X_IMPLIED,
+    &ZVFBFA_IMPLIED,
+    &ZVFBFMIN_IMPLIED,
+    &ZVFBFWMA_IMPLIED,
+    &ZVFH_IMPLIED,
+    &ZVFHMIN_IMPLIED,
+    &ZVKN_IMPLIED,
+    &ZVKNC_IMPLIED,
+    &ZVKNG_IMPLIED,
+    &ZVKNHB_IMPLIED,
+    &ZVKS_IMPLIED,
+    &ZVKSC_IMPLIED,
+    &ZVKSG_IMPLIED,
+    &SHA_IMPLIED,
+    &SSCFG_IMPLIED,
+    &SUPM_IMPLIED,
+    &SSPM_IMPLIED,
+    &SMCTR_IMPLIED,
+    &SSCTR_IMPLIED,
+    &SSSTATEEN_IMPLIED,
     NULL
 };
 
-- 
2.55.0


