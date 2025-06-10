Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B016C61DB2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 22:35:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP7XZ-0002PJ-ET; Tue, 10 Jun 2025 18:33:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1uP7XW-0002On-VE
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 18:33:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1uP7XT-0007r4-QP
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 18:33:54 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AFegla031658;
 Tue, 10 Jun 2025 22:33:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=G3UxT6V9myzdMfm0e
 ODX612pEQxfDu7vgDQlNmzskjQ=; b=gMPW90DxKz0B+wI+HCUFw+93fMckoE1dH
 1EQfReX2zX8Ef5upe60duCiNXJtWG/D6tO3xOzs5hLLfCuxDuJeOrVoL1D4EzqLx
 Zc3ggAs4c0G3obAaVas8JhC/Qv+BfsfK/uHvVlmQ16/MMaQo/D/AhN3bOcPugA/k
 xD7PEtWxcxXvjN0AUDWNZUh4Qs8o2ZyijR/Rw0kez8lfaFsuqypke4pCqM6PGAot
 H3IKnskMr8uh1sk28W1/eIrVJKLpQeJimfkv1lDCgoWgyUjhcGGamSry+RHccas9
 PajnLc25Yh2IPt8SlkGlG5r3aGmvpzTXT7Wr/v3igRcPf43apL0CQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474x4m69u5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Jun 2025 22:33:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55AKJDRs021839;
 Tue, 10 Jun 2025 22:33:47 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47504yvvaw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Jun 2025 22:33:47 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55AMXjrj21496388
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 22:33:46 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D073458069;
 Tue, 10 Jun 2025 22:33:45 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 79C7258068;
 Tue, 10 Jun 2025 22:33:45 +0000 (GMT)
Received: from IBM-GLTZVH3.ibm.com (unknown [9.61.254.209])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Jun 2025 22:33:45 +0000 (GMT)
From: Jaehoon Kim <jhkim@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: jjherne@linux.ibm.com, steven.sistare@oracle.com, peterx@redhat.com,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com,
 Jaehoon Kim <jhkim@linux.ibm.com>
Subject: [PATCH v3 2/2] migration: Support fd-based socket address in
 cpr_transfer_input
Date: Tue, 10 Jun 2025 17:33:42 -0500
Message-ID: <20250610223342.553744-2-jhkim@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250610223342.553744-1-jhkim@linux.ibm.com>
References: <20250610223342.553744-1-jhkim@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Y4X4sgeN c=1 sm=1 tr=0 ts=6848b2cb cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=6c5nva-bPeITNSsYfMAA:9
X-Proofpoint-GUID: D1rznAWvPxBJmAV8QHPSCHFPWW2sO0zY
X-Proofpoint-ORIG-GUID: D1rznAWvPxBJmAV8QHPSCHFPWW2sO0zY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDE4NCBTYWx0ZWRfXxPd+LHGWpTMf
 0R2YQ5M/T//NT4HmhRCYU90/WCGHx36QGxt+BXm4srfzTCN4e2ENlsZ+dfVLoOJQo5NxwTAtY4h
 r0+gDOOBXFnLTacX9YJOqQmUJTRPxcXc74S0s8+WRb7WVV2wiJHbIw1HvhqpeFtVu9NhqnXf3LZ
 rLwALEfn8rxf6uYiWFycGT87LMSw0EQmUzsOuW6hj1jqOaf3FhMrUS9KwbUBaAimbBUOwvuVrhv
 1Q4u0+i2Kv6BbpcDcOnzXlnVFEQoVY/FEuxJOp+wIDGT4XZVCatRVDGV94IK/GXlQh23P2wJAmC
 KbQ99a/fF2RoHnno+JMU9asfH6yXxObKgibUfJcYD6E0Xe0AlPBQL62Gy1EcwgONmYB+PK1WW4T
 MN4hwN9WX7IUVoKCtbbsH3wuConKqSHTWc9+rTgKLLIsium5+5KVPoFQQpAjAyVSdQnR/DjU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_10,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 spamscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0
 impostorscore=0 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506100184
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jhkim@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


