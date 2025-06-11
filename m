Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 371FEC71135
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 20:57:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPSUj-0000Pu-4o; Wed, 11 Jun 2025 16:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1uPSUg-0000Pb-Ij
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 16:56:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1uPSUe-0002VW-CL
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 16:56:22 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55BFFGhf018219;
 Wed, 11 Jun 2025 20:56:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=EwhT7yFCHYOSgNhdI
 0I49iMI9qQt6+N8eYJhE0kPcOA=; b=mm5wchDDjzjhGuBAJmekVMoxKuAEdW7ys
 R1EQnLCYUhrkQN9HB3ZY2r7pYUhigzr3VXli/N41oOfvyBIoJNMINZkorLIfDten
 6CIvNxMMn5F5cWN9UF2gqG8e73jsOTLrc6xmubMVQ51jO+h5w3PuAd2VWBZR/qWk
 MAYZGE+zysROKEAG1hSHzHxmrf66IHHrhA3c+5U744gea3YXO0vsKIpbRWGjEkbf
 Xm+ssd018i/54Ol73axWZ3u834gF945ttHNllQXLb8Fd8EHRNlh4A0g/y5kHaXv6
 iAa3ti1/vRDK7q9dW6uaX8T6LPsZtRj1NzYTRtf+iojeGwP2gmgQA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474x4mc21m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Jun 2025 20:56:16 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55BK3wTx015191;
 Wed, 11 Jun 2025 20:56:15 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 474yrthr72-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Jun 2025 20:56:15 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55BKuFuQ27329104
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Jun 2025 20:56:15 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F0DB158052;
 Wed, 11 Jun 2025 20:56:14 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BF22C5805A;
 Wed, 11 Jun 2025 20:56:14 +0000 (GMT)
Received: from IBM-GLTZVH3.ibm.com (unknown [9.61.250.224])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 11 Jun 2025 20:56:14 +0000 (GMT)
From: Jaehoon Kim <jhkim@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: jjherne@linux.ibm.com, steven.sistare@oracle.com, peterx@redhat.com,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com,
 Jaehoon Kim <jhkim@linux.ibm.com>
Subject: [PATCH v4 2/2] migration: Support fd-based socket address in
 cpr_transfer_input
Date: Wed, 11 Jun 2025 15:56:10 -0500
Message-ID: <20250611205610.147008-3-jhkim@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250611205610.147008-1-jhkim@linux.ibm.com>
References: <20250611205610.147008-1-jhkim@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Y4X4sgeN c=1 sm=1 tr=0 ts=6849ed70 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=yPCof4ZbAAAA:8 a=6c5nva-bPeITNSsYfMAA:9
X-Proofpoint-GUID: 3W1XFt0u23ahLTPSEd2vmreS-mS4U-VM
X-Proofpoint-ORIG-GUID: 3W1XFt0u23ahLTPSEd2vmreS-mS4U-VM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDE3NiBTYWx0ZWRfXzO3byzQl2gVw
 NM2t3USDRm928BvKvXHFF0IUKbcUTOXVXh9Idi27TNxZ6ayZkel0Ry8wvCnUgMmekMz65hebA/u
 64iV0EEpzE0Qsvs4fx6gBGv5zSUdijlT0K5/FYDODlSqMvrRH3Hj4i2skbNVAeEswvf8wG2VMfi
 V2PDHKuKgsFWszgP0tOt58UE9Cs4AfbYRbtqUvAQmrTXGzFMjYVERwPY4JKLbo6u3bS6axHPeWP
 jK2Ij/n6Pf+W1bTwy0FEB/Sh8rkwNs7S65ak1fL3ksa+KIj8pcuUjoyXQHNe/HQFST99wr93wG3
 Bt+H0ZjEtYMTMvaFpbYJxugmE5KhiKnVWr6Jr4JZM+bbICe2msNJ87NqWy4gcwkMCEm3ngPmOQ8
 1xtfP3R6P6Ysnmv1pR2e8VoaC+6XBdm4J2jQKm97EC0UeqOchLlShBdrDMACBR189L/QYPBV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_09,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 spamscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0
 impostorscore=0 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506110176
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jhkim@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Extend cpr_transfer_input to handle SOCKET_ADDRESS_TYPE_FD alongside
SOCKET_ADDRESS_TYPE_UNIX. This change supports the use of pre-listened
socket file descriptors for cpr migration channels.

This change is particularly useful in qtest environments, where the
socket may be created externally and passed via fd.

Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
---
 migration/cpr-transfer.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/migration/cpr-transfer.c b/migration/cpr-transfer.c
index e1f140359c..00371d17c3 100644
--- a/migration/cpr-transfer.c
+++ b/migration/cpr-transfer.c
@@ -46,7 +46,8 @@ QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp)
     MigrationAddress *addr = channel->addr;
 
     if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET &&
-        addr->u.socket.type == SOCKET_ADDRESS_TYPE_UNIX) {
+        (addr->u.socket.type == SOCKET_ADDRESS_TYPE_UNIX ||
+            addr->u.socket.type == SOCKET_ADDRESS_TYPE_FD)) {
 
         g_autoptr(QIOChannelSocket) sioc = NULL;
         SocketAddress *saddr = &addr->u.socket;
@@ -60,7 +61,9 @@ QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp)
 
         sioc = qio_net_listener_wait_client(listener);
         ioc = QIO_CHANNEL(sioc);
-        trace_cpr_transfer_input(addr->u.socket.u.q_unix.path);
+        trace_cpr_transfer_input(
+            addr->u.socket.type == SOCKET_ADDRESS_TYPE_UNIX ?
+            addr->u.socket.u.q_unix.path : addr->u.socket.u.fd.str);
         qio_channel_set_name(ioc, "cpr-in");
         return qemu_file_new_input(ioc);
 
-- 
2.49.0


