Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF3BD65C57
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 07:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBUdK-000424-LU; Thu, 14 Nov 2024 02:51:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r@drigo.nl>) id 1tBUdI-00041t-Hy
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 02:51:16 -0500
Received: from smtp-8fa9.mail.infomaniak.ch ([2001:1600:7:10::8fa9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r@drigo.nl>) id 1tBUdF-0006sb-OJ
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 02:51:16 -0500
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Xpslm2dKGzXtK;
 Thu, 14 Nov 2024 08:51:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=drigo.nl;
 s=20241108; t=1731570660;
 bh=n0iFUy/NdvkPBD+EsAMfR1bi4Xv41RHEHyWU8FzvQdM=;
 h=From:To:Cc:Subject:Date:From;
 b=LcolhpcA6fusY5IaRihFOu/gnWyVXiPKeh9yVu6SpC+zBRMweyTtmM+Ch0HdB1QzZ
 DvRVptQGUM2IoOs8CdcqWJlOQGR3MjtnCBr3dRngJZip08xqhQ0Jsp5m5aNsl+FdGK
 eZR2vHTBOsLqblUst/iXoWKztg44AkJLfJ09Fzqw1utgQzeFSvE/De3+gcJ2O4/69G
 U+zjmx2S8/MeiZ/4G+gxW/KnuTDyBdUHpy59SCxbMLgdWZNAaoeUj5tGrH0AkopY/E
 zWBIt2sPniLU/YkWk9YqX+iBJYyOZ0cD23U6SyzLxWTJwQ0v+y9jHP7vXOsD7KQVSb
 na0x1rpOD4IhQ==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4Xpsll2TrpzsT0; Thu, 14 Nov 2024 08:50:59 +0100 (CET)
From: Rodrigo Dias Correa <r@drigo.nl>
To: qemu-devel@nongnu.org
Cc: jiri@resnulli.us,
	jasowang@redhat.com,
	jtomko@redhat.com
Subject: [PATCH v2] hw/net/rocker/rocker_of_dpa.c: Remove superfluous error
 check
Date: Thu, 14 Nov 2024 08:50:51 +0100
Message-Id: <20241114075051.404284-1-r@drigo.nl>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
Received-SPF: pass client-ip=2001:1600:7:10::8fa9; envelope-from=r@drigo.nl;
 helo=smtp-8fa9.mail.infomaniak.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Ján Tomko <jtomko@redhat.com>
---
 hw/net/rocker/rocker_of_dpa.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

changelog:
  v2: fixed misaligned line

diff --git a/hw/net/rocker/rocker_of_dpa.c b/hw/net/rocker/rocker_of_dpa.c
index 5e16056be6..3378f63110 100644
--- a/hw/net/rocker/rocker_of_dpa.c
+++ b/hw/net/rocker/rocker_of_dpa.c
@@ -1635,8 +1635,8 @@ static int of_dpa_cmd_add_multicast_routing(OfDpaFlow *flow,
     return ROCKER_OK;
 }
 
-static int of_dpa_cmd_add_acl_ip(OfDpaFlowKey *key, OfDpaFlowKey *mask,
-                                 RockerTlv **flow_tlvs)
+static void of_dpa_cmd_add_acl_ip(OfDpaFlowKey *key, OfDpaFlowKey *mask,
+                                  RockerTlv **flow_tlvs)
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


