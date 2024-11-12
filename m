Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16DEFD41D41
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 01:27:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAffk-0001N3-Jc; Mon, 11 Nov 2024 20:26:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r@drigo.nl>) id 1tAffj-0001Mu-ID
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 20:26:23 -0500
Received: from smtp-bc08.mail.infomaniak.ch ([45.157.188.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r@drigo.nl>) id 1tAffh-0007T1-MG
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 20:26:23 -0500
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XnTJq5XbxzdgZ;
 Tue, 12 Nov 2024 02:26:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=drigo.nl;
 s=20241108; t=1731374779;
 bh=vxk8AH3+BziTGfdR2L2xcNSCPa/LHx//KA7VWVgbqnk=;
 h=From:To:Cc:Subject:Date:From;
 b=ixz6rZRo+N91Y2F5ki6XUG0PSD0aGqEAeU5SwZVxL5CP4LbdWES7uc5SX4kAb12tj
 pSY7XcKNfiyLvhxiBb1++dm9KtXq6QZDTJ+tXKHzuenOl6qepx7Z7IYhYPrjRe27un
 ZnAnTcvNzR11tdP07sbW6wM74NsvcdZKEHI2F1y++sLX09hMWOh74Hrs4fhnzVuild
 msQx5he+cDDcxCOaerTejUyYKNOTERDShkyQlsSn/R7Wk4JpNbDwlzk0lScccXBZ6o
 Hddp9Rm8L7tabQ0wspj/eL/qjL70n8PIV1aO19ANvxtwjGf14J80x9KKyFxCibGNNz
 Vp/tuwClrUeCg==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4XnTJq0qKszlJ2; Tue, 12 Nov 2024 02:26:19 +0100 (CET)
From: Rodrigo Dias Correa <r@drigo.nl>
To: qemu-devel@nongnu.org
Cc: jiri@resnulli.us,
	jasowang@redhat.com
Subject: [PATCH] hw/net/rocker/rocker_of_dpa.c: Remove superfluous error check
Date: Tue, 12 Nov 2024 02:26:12 +0100
Message-Id: <20241112012612.317020-1-r@drigo.nl>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
Received-SPF: pass client-ip=45.157.188.8; envelope-from=r@drigo.nl;
 helo=smtp-bc08.mail.infomaniak.ch
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.671,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

of_dpa_cmd_add_acl_ip() is called from a single place, and despite the
fact that it always returns ROCKER_OK, its return value is still checked
by the caller.
Change of_dpa_cmd_add_acl_ip() to return void and remove the superfluous
check from of_dpa_cmd_add_acl().
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2471

Signed-off-by: Rodrigo Dias Correa <r@drigo.nl>
---
 hw/net/rocker/rocker_of_dpa.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/hw/net/rocker/rocker_of_dpa.c b/hw/net/rocker/rocker_of_dpa.c
index 5e16056be6..6d29130ec2 100644
--- a/hw/net/rocker/rocker_of_dpa.c
+++ b/hw/net/rocker/rocker_of_dpa.c
@@ -1635,7 +1635,7 @@ static int of_dpa_cmd_add_multicast_routing(OfDpaFlow *flow,
     return ROCKER_OK;
 }
 
-static int of_dpa_cmd_add_acl_ip(OfDpaFlowKey *key, OfDpaFlowKey *mask,
+static void of_dpa_cmd_add_acl_ip(OfDpaFlowKey *key, OfDpaFlowKey *mask,
                                  RockerTlv **flow_tlvs)
 {
     key->width = FLOW_KEY_WIDTH(ip.tos);
@@ -1669,8 +1669,6 @@ static int of_dpa_cmd_add_acl_ip(OfDpaFlowKey *key, OfDpaFlowKey *mask,
         mask->ip.tos |=
             rocker_tlv_get_u8(flow_tlvs[ROCKER_TLV_OF_DPA_IP_ECN_MASK]) << 6;
     }
-
-    return ROCKER_OK;
 }
 
 static int of_dpa_cmd_add_acl(OfDpaFlow *flow, RockerTlv **flow_tlvs)
@@ -1689,7 +1687,6 @@ static int of_dpa_cmd_add_acl(OfDpaFlow *flow, RockerTlv **flow_tlvs)
         ACL_MODE_ANY_VLAN,
         ACL_MODE_ANY_TENANT,
     } mode = ACL_MODE_UNKNOWN;
-    int err = ROCKER_OK;
 
     if (!flow_tlvs[ROCKER_TLV_OF_DPA_IN_PPORT] ||
         !flow_tlvs[ROCKER_TLV_OF_DPA_ETHERTYPE]) {
@@ -1776,14 +1773,10 @@ static int of_dpa_cmd_add_acl(OfDpaFlow *flow, RockerTlv **flow_tlvs)
     switch (ntohs(key->eth.type)) {
     case 0x0800:
     case 0x86dd:
-        err = of_dpa_cmd_add_acl_ip(key, mask, flow_tlvs);
+        of_dpa_cmd_add_acl_ip(key, mask, flow_tlvs);
         break;
     }
 
-    if (err) {
-        return err;
-    }
-
     if (flow_tlvs[ROCKER_TLV_OF_DPA_GROUP_ID]) {
         action->write.group_id =
             rocker_tlv_get_le32(flow_tlvs[ROCKER_TLV_OF_DPA_GROUP_ID]);
-- 
2.34.1


