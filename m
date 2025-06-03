Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F32CCC5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 04:02:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMIqr-0005SF-N6; Tue, 03 Jun 2025 00:02:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maqianga@uniontech.com>)
 id 1uMIAp-0007H1-Vf
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 23:18:48 -0400
Received: from smtpbgau1.qq.com ([54.206.16.166])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maqianga@uniontech.com>)
 id 1uMIAm-0000L9-Uk
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 23:18:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
 s=onoh2408; t=1748920706;
 bh=v1O64vhmZ4MOKZqkmX1O3loscXQtIWgN56wNgXiZl20=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=XxBSCuSnticTKEeuqhBn7TmQTpF86tNAy0KVEqs061+t7KfbJ460Psh74wdOUj7ba
 zmciS/e65D9ceOmpuoUwCTD7SiQtGZjsUlNJB7WdAnGE+s+/j15nUzFF5JZV1bX6z0
 PewL3kF0Y25g7QjqUmQz07GvU2B4CsZKsl1PiCME=
X-QQ-mid: zesmtpgz9t1748920703t7465afa6
X-QQ-Originating-IP: TBWjB3O1bZ8bbedfCIkVtWV2KBbHePynDczoEwt+aMs=
Received: from localhost.localdomain ( [123.114.60.34])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 03 Jun 2025 11:18:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9058257652405002513
EX-QQ-RecipientCnt: 5
From: Qiang Ma <maqianga@uniontech.com>
To: gaosong@loongson.cn,
	maobibo@loongson.cn,
	jiaxun.yang@flygoat.com
Cc: qemu-devel@nongnu.org,
	Qiang Ma <maqianga@uniontech.com>
Subject: [PATCH] hw/loongarch/virt: inform guest of kvm
Date: Tue,  3 Jun 2025 11:18:13 +0800
Message-Id: <20250603031813.31794-1-maqianga@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NIGuNFWusAfRay/tsU5b9pQuTYv/EMnmeglneiSa8FgeVuWEW25a2ApV
 v4+KiUz4AYHSyu8u/aOfkcj5BCTdVb7oQDdIiJ35hsv3j58qR745P4xZEXrb8OBDggZK4rl
 wisSgAlgRYBEEo886bbunYPNtT9HECqcKQLLbd925W8yQAqn9XYMrZoooqtLmoozVAsEOro
 Rp5YWA8InKdiOvzy1eDcjiBjmz8QahoxdH9V0kn1V3/1uIhKTbFMJTcWt6ZtijlFlysWeeX
 vanjm3sbef60sM+imh4BcZ2gVb9YYrR+lWIAZlD3TPTR+3c3ar6LvpQ6yFzqfUBZ4kPIbLb
 jbhU4IMPzMqDjwGuuL8WhCluyXWrlHxRt4rJIC14Xa6IEEowIpHxte2/lsuzgBf5c0dbjFC
 xYVqlwXsS/Cz+TOWdlsbIwJ2hM2v7ys4hcAY7p5LLCRzSVJ5wXP0Pdbcpy/HyM6WMcP+WOG
 5lFMdmCfgsjuzKo+DChMen4QkKISp8DZGzu7HFrG6NVKQYQNbB4actSCB0N0qLhM63twTeA
 R8NWTJ5QhgnBxOc9RJs8QIU8qpV/GnvRPlB3GGNHnZj4dJJxys0LOmmJTGEk4nS4JOL6eei
 L1UY+nuExsuqCB6C2CosM2do0Tq1QajKf5CVQojUl95cD+XTo2DwYF5kWQ8L0KKq7CKuddK
 Q5bOcGX0j8krPEQNrs8befuA9TYgDDPQyLHaVpP1muAElDMzQgz1kjNUcib8NcrIxyXz4CH
 WVwiHVbKUVscDkqrOJ0Ac2CC09zRncjlcETEI4BxFi6TVL/WaVG/lJzC/FiJ5C7T+R8peXW
 Ta2/Ok02NTpujQMIQyK2v7YTrE3/c4hgY15Xs+G3eBOR35ns2GEd+EBHvVJQPpVRsYqr3uH
 PgpUnuaSj7cTUP57u1X5UR+MBkqpSZu59qf7q/9Y72F7TBpIzes3U30+0ukgAPhlN4TqYV9
 MRxwrRTsg6nrlD0W1YqakZkLs3HOKdrZUSADq8di1HFl5iOq8dVKxnvnt
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0
Received-SPF: pass client-ip=54.206.16.166;
 envelope-from=maqianga@uniontech.com; helo=smtpbgau1.qq.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 03 Jun 2025 00:02:11 -0400
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

Commit bab27ea2e3 ("hw/arm/virt: smbios:
inform guest of kvm") fixes the same issue
on arm.

without this patch:
[root@localhost ~]# virt-what
qemu

with this patch:
[root@localhost ~]# virt-what
kvm

Signed-off-by: Qiang Ma <maqianga@uniontech.com>
---
 hw/loongarch/virt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 1b504047db..a3d449ca8b 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -136,6 +136,10 @@ static void virt_build_smbios(LoongArchVirtMachineState *lvms)
         return;
     }
 
+    if (kvm_enabled()) {
+        product = "KVM Virtual Machine";
+    }
+
     smbios_set_defaults("QEMU", product, mc->name);
 
     smbios_get_tables(ms, SMBIOS_ENTRY_POINT_TYPE_64,
-- 
2.20.1


