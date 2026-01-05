Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7017C2A062
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 03:44:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcbVW-000098-Eh; Sun, 04 Jan 2026 22:43:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1vcbVT-00008x-8r
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 22:43:47 -0500
Received: from out30-99.freemail.mail.aliyun.com ([115.124.30.99])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1vcbVQ-0008E5-VD
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 22:43:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1767584610; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=yq4wR2fouXiMtE2X2nojr7DcT14jzVmMmAGrQMRisTM=;
 b=YPhPtdkOt+pqvmwKrGRqxvcWW20BmIYxJeJDtQGt5BSgL0LzMRffElOf6n+U1bgmlu63elAUXk494St/8XPqixDiT6iDPmoEkOZMgeS8kBttUXI1c274s8bwU27mO8I+I52OmhScHBO9RJnC3khf7J1hx5sXkyYudMDv5C4R19U=
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0WwIvBMD_1767584590 cluster:ay36) by smtp.aliyun-inc.com;
 Mon, 05 Jan 2026 11:43:29 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	berrange@redhat.com,
	philmd@linaro.org
Subject: [PATCH] monitor: disable "info kvm" if !KVM
Date: Mon,  5 Jan 2026 11:43:09 +0800
Message-ID: <20260105034309.11308-1-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.99;
 envelope-from=guobin@linux.alibaba.com; helo=out30-99.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
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

Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
---
 hmp-commands-info.hx | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 41674dcbe1..1927649493 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -294,6 +294,7 @@ SRST
     being coalesced.
 ERST
 
+#if defined(CONFIG_KVM)
     {
         .name       = "kvm",
         .args_type  = "",
@@ -301,6 +302,7 @@ ERST
         .help       = "show KVM information",
         .cmd        = hmp_info_kvm,
     },
+#endif
 
 SRST
   ``info kvm``
-- 
2.50.1 (Apple Git-155)


