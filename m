Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91855CA0EFC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 14:27:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up6Fx-0004TS-Nx; Thu, 21 Aug 2025 10:27:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1up6Fm-0004Rm-Rr
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 10:27:00 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1up6Fk-0006bf-0R
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 10:26:58 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LEBt0W019360;
 Thu, 21 Aug 2025 14:26:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=corp-2025-04-25; bh=BfO97+SjLNV5yIjbTFiraK/a36I/H
 SbfhmgM+yH4jec=; b=XnlzwB1qWT2VloAyMauRB0hEFnSnRfMJH+xL4RemzgQJu
 LgNsPkX/CtBZp9cFR5wFrPer7bQbah81BXArXB5ozH/nMEEkDUE88OtwlUV0s3t2
 NQzmT+ZI5lSpuwAWl97hZjPZXnPlkne71EGqsuaoNmOfOe7bHW3ywKwVXjIH/opJ
 VF+yNjwi/lA/mDO8HW2XWsGZW/zshc/6kkZYJhk6TJjfJfBExJFRdCv8tK6Biscz
 rch8E6lCQi8Yx/HZzyHTj0KAq966lhKGlwophGZT6JqJ+JezM/FkJlVsxJLU5y71
 yvUO7gw27KTbry0tZFZYfLumCf6g8Q5L67RZEiHLg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0tr3jwp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Aug 2025 14:26:43 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 57LCn22m026402; Thu, 21 Aug 2025 14:26:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 48n3sxm979-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Aug 2025 14:26:42 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57LEPuvK037230;
 Thu, 21 Aug 2025 14:26:42 GMT
Received: from jonah-amd-ol9-bm.osdevelopmeniad.oraclevcn.com
 (jonah-amd-ol9-bm.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.252.67])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 48n3sxm96t-1; Thu, 21 Aug 2025 14:26:42 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, eperezma@redhat.com, leiyang@redhat.com,
 dwmw2@infradead.org, jonah.palmer@oracle.com
Subject: [PATCH] net/hub: make net_hub_port_cleanup idempotent
Date: Thu, 21 Aug 2025 14:26:41 +0000
Message-ID: <20250821142641.359132-1-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 suspectscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508210116
X-Proofpoint-GUID: i4V5HvB6KQAq6RCHgVhlDRdIMCnZi69t
X-Authority-Analysis: v=2.4 cv=FY1uBJ+6 c=1 sm=1 tr=0 ts=68a72ca4 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=2OwXVqhp2XgA:10 a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8 a=E34_ZZ7pgZ2hWXAKS8kA:9
 a=1CNFftbPRP8L7MoqJWF3:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: i4V5HvB6KQAq6RCHgVhlDRdIMCnZi69t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfXzEzTd+l3m4A0
 Ha/Lph7Kgp11IEJzll0EYW/2IzylkXfrO3uvc5wpEl9JPTqqSM4jodXd4mMaWgg/3vInP5w7CZc
 Rzh/lPjGl1UBw7sMIIgR5NIVasVjjljW3atpkFMad2H6tlgm4lofcFjFQp8436pRd0kTfOd73X9
 MVP/uPiTlH1jxD73MHuRUN22sJ/cj/b+SPqkD4IYW33nVxdTWsaw1XsZ70Pu8WfPKiT1nKW8klE
 wcF58UZ7MRGltmI8E8xuQx0oIcnRTjLmzc+XFrUjj0E5xBOyth2kLxWFqN8y4gEPhcjA/LqZd7x
 TP/m2zSR6o69OlPB7+Z2U9mBALrw2cuMJVteOeCWgPMXIakK0lOxqRkCrd6hSEOFAfouveH0xqm
 xspsxM9qXXTgQSwv9+Uzd58ADLhAww==
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Makes the net_hub_port_cleanup function idempotent to avoid double
removals by guarding its QLIST_REMOVE with a flag.

When using a Xen networking device with hubport backends, e.g.:

-accel kvm,xen-version=0x40011
-netdev hubport,...
-device xen-net-device,...

the shutdown order starts with net_cleanup, which walks the list and
deletes netdevs (including hubports). Then Xen's xen_device_unrealize is
called, which eventually leads to a second net_hub_port_cleanup call,
resulting in a segfault.

Fixes: e7891c57 ("net: move backend cleanup to NIC cleanup")
Reported-by: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 net/hub.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/hub.c b/net/hub.c
index e3b58b1c4f8e..ee5881f6d5cb 100644
--- a/net/hub.c
+++ b/net/hub.c
@@ -34,6 +34,7 @@ typedef struct NetHubPort {
     QLIST_ENTRY(NetHubPort) next;
     NetHub *hub;
     int id;
+    bool listed;
 } NetHubPort;
 
 struct NetHub {
@@ -129,7 +130,10 @@ static void net_hub_port_cleanup(NetClientState *nc)
 {
     NetHubPort *port = DO_UPCAST(NetHubPort, nc, nc);
 
-    QLIST_REMOVE(port, next);
+    if (port->listed) {
+        QLIST_REMOVE(port, next);
+        port->listed = false;
+    }
 }
 
 static NetClientInfo net_hub_port_info = {
@@ -159,8 +163,10 @@ static NetHubPort *net_hub_port_new(NetHub *hub, const char *name,
     port = DO_UPCAST(NetHubPort, nc, nc);
     port->id = id;
     port->hub = hub;
+    port->listed = false;
 
     QLIST_INSERT_HEAD(&hub->ports, port, next);
+    port->listed = true;
 
     return port;
 }
-- 
2.47.3


