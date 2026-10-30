Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E3E606A321
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 14:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=x6z.top header.i=@x6z.top header.a=rsa-sha256 header.s=lark2301040359 header.b=0Uqom+d9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMnwZ-0000Za-2d; Fri, 30 Oct 2026 10:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lbyxiaolizi@x6z.top>)
 id 1xMns0-0006jm-Cd
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:46:19 -0400
Received: from va-2-56.ptr.blmpb.com ([209.127.231.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lbyxiaolizi@x6z.top>)
 id 1xMnry-0005VR-Eq
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:46:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=lark2301040359; d=x6z.top; t=1793371570; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=yikwJlNDN0MtQgZCJkH7Hrxos/vTznhKt27RQPDbvsQ=;
 b=0Uqom+d9GU9/uUu0sUNsIlO/UjRwU1iYxK4+dTvEVMTQ/vHwoQ+PrRalWzKM7QnnPfyjfw
 UT9S6gBuhw6wu63+zXxmK8iScVTNTjG9H484BA0I+oaM/ahOiCip7ONEov+7DBK1d4oJUe
 TybIuxekpdRflF9RzYy+ykhIzNM3dMXlGMeE9AazVKEwaPKoD40qOhAYEKMN2BDSZJawRZ
 H+9lqsK0vuEG9yvoj5g703Zo3p0tcMzXwWNc62OcDnKc+yV4+uhC83aUtenTmsidF3IHy9
 D3hXYIgJrq5VWjDOPvP61I339L/fVE4WVNHQj8vv5+NUO6snC2LXDwxxAlIDug==
From: "lbyxiaolizi" <lbyxiaolizi@x6z.top>
Content-Type: text/plain; charset=UTF-8
X-Mailer: git-send-email 2.56.0
X-Original-From: lbyxiaolizi <lbyxiaolizi@x6z.top>
Cc: "lbyxiaolizi" <lbyxiaolizi@x6z.top>, "Michael S. Tsirkin" <mst@redhat.com>
Content-Transfer-Encoding: 7bit
In-Reply-To: <cover.1793370600.git.lbyxiaolizi@x6z.top>
Message-Id: <8b598f85933be087e0b815830ca94e82fc661c9c.1793370600.git.lbyxiaolizi@x6z.top>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Received: from localhost.localdomain ([120.236.174.193]) by smtp.larksuite.com
 with ESMTPS; Fri, 30 Oct 2026 14:46:09 +0000
References: <cover.1793370600.git.lbyxiaolizi@x6z.top>
X-Lms-Return-Path: <lba+26ae4adb1+2a15df+nongnu.org+lbyxiaolizi@x6z.top>
To: <qemu-devel@nongnu.org>
Subject: [PATCH 6/9] hw/pci/pcie_sriov: clamp NumVFs to TotalVFs in
 register_vfs
Date: Fri, 30 Oct 2026 22:45:44 +0800
Received-SPF: pass client-ip=209.127.231.56; envelope-from=lbyxiaolizi@x6z.top;
 helo=va-2-56.ptr.blmpb.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.5, MSGID_FROM_MTA_HEADER=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_PDS_OTHER_BAD_TLD=0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 30 Oct 2026 10:50:50 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FROM_SUSPICIOUS_NTLD,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,
	SPF_HELO_PASS,SPF_PASS,T_PDS_OTHER_BAD_TLD,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

At runtime, consume_config() clears PCI_SRIOV_CTRL_VFE from wmask when
NumVFs > TotalVFs, preventing the guest from enabling more VFs than the
total_vfs-sized dev->exp.sriov_pf.vf[] array holds.

On migration load, get_pci_config_device() validates the incoming
config space against the post-reset wmask where both VFE and NumVFs are
writable, and pcie_sriov_pf_post_load() -> consume_config() ->
register_vfs() then loops up to NumVFs without checking TotalVFs. Clamp
num_vfs to total_vfs in register_vfs() and write the clamped value back
to config space.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4777
Signed-off-by: lbyxiaolizi <lbyxiaolizi@x6z.top>
---
 hw/pci/pcie_sriov.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 6a748c3..cb79430 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -35,11 +35,18 @@ static void unparent_vfs(PCIDevice *dev, uint16_t total_vfs)
 static void register_vfs(PCIDevice *dev)
 {
     uint16_t num_vfs;
+    uint16_t total_vfs;
     uint16_t i;
     uint16_t sriov_cap = dev->exp.sriov_cap;
 
     assert(sriov_cap > 0);
     num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
+    total_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_TOTAL_VF);
+
+    if (num_vfs > total_vfs) {
+        num_vfs = total_vfs;
+        pci_set_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF, num_vfs);
+    }
 
     trace_sriov_register_vfs(dev->name, PCI_SLOT(dev->devfn),
                              PCI_FUNC(dev->devfn), num_vfs);

