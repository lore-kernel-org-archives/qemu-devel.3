Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF95C531DC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 11:43:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdpw3-0004Pp-CD; Tue, 13 Aug 2024 07:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sdpvb-0002x1-CY; Tue, 13 Aug 2024 07:43:04 -0400
Received: from out30-100.freemail.mail.aliyun.com ([115.124.30.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sdpvY-0003gn-Rp; Tue, 13 Aug 2024 07:43:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1723549376; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=QF8w0EuuEt8vPs/L1xgYqK4lMhxVSFP0lyikbUU8wuM=;
 b=FzHoDT+oXt9fXw0AEwVQLfpcGzJk+sTPlDeopCa+cE3kBZtf4zB07XF7hiXXbbw9JvBDDzw/MT8rmPmLSoGqfa8WotsmtNqrXvfAG/lxaaYMCD1Ayp9pHUPkq3KAfMQqDJskt/y3PSyI4Je1G6+WMdcFcBdWX8SaOshP/AfPKHk=
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WCovgB8_1723549374) by smtp.aliyun-inc.com;
 Tue, 13 Aug 2024 19:42:55 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 zhiwei_liu@linux.alibaba.com, richard.henderson@linaro.org,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Subject: [PATCH v1 15/15] tcg/riscv: Enable vector TCG host-native
Date: Tue, 13 Aug 2024 19:34:36 +0800
Message-Id: <20240813113436.831-16-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20240813113436.831-1-zhiwei_liu@linux.alibaba.com>
References: <20240813113436.831-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.100;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-100.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>

Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 tcg/riscv/tcg-target.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index eb5129a976..fe6c50e49e 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -143,9 +143,13 @@ typedef enum {
 #define TCG_TARGET_HAS_tst              0
 
 /* vector instructions */
-#define TCG_TARGET_HAS_v64              0
-#define TCG_TARGET_HAS_v128             0
-#define TCG_TARGET_HAS_v256             0
+extern int riscv_vlen;
+#define have_rvv    ((cpuinfo & CPUINFO_ZVE64X) && \
+                     (riscv_vlen >= 64))
+
+#define TCG_TARGET_HAS_v64              have_rvv
+#define TCG_TARGET_HAS_v128             have_rvv
+#define TCG_TARGET_HAS_v256             have_rvv
 #define TCG_TARGET_HAS_andc_vec         0
 #define TCG_TARGET_HAS_orc_vec          0
 #define TCG_TARGET_HAS_nand_vec         0
-- 
2.43.0


