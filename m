Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F873C71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 13:37:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRA1Z-0003pn-1m; Mon, 16 Jun 2025 09:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1uRA1W-0003o5-EX
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 09:37:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1uRA1R-00085l-CA
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 09:37:18 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55G4Tb2B015293;
 Mon, 16 Jun 2025 13:37:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=aKTZpJ9cRHBDV1VEOR1X3Fw9DCwD
 zYKT1B1um9+1GhY=; b=bD86/HnTH07kAm61Cqizh4waN9/883xtFjVxL0beIFIm
 8fF3IdXbIpAYuDKoHV2ldMzTTzQCT8lNmgQFRqO07S+DpjpIE52fORR+F6pYZgRh
 dDlM0S9az+OrCSTtBRY5m2Hyi3EcBwkoFYhT8nx9EcQzs5XgLr6ymfK2QWzFVEOg
 Z/y1ePQd/sj04pEEGDW4PX+KOwzo4txFOrmVgNJYPn+L68tfNEMqzOtrL61WTByf
 KsyfADSAEtxA+sOMbJXvdfEGiMvFwizWvFjQyU4a7lF3a6FuUtwtkDBmHk1NjwIf
 n5sV+kqr+Lx7e5eJu+O1U86EYHVneBtlStZST96ybg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790s4a3jd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Jun 2025 13:37:07 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55GDKgwK002474;
 Mon, 16 Jun 2025 13:37:07 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790s4a3ja-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Jun 2025 13:37:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55GCTZXv000875;
 Mon, 16 Jun 2025 13:37:06 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 479mdnxae8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Jun 2025 13:37:06 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55GDb4Vm42664396
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Jun 2025 13:37:04 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6C1B358059;
 Mon, 16 Jun 2025 13:37:04 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3169558057;
 Mon, 16 Jun 2025 13:37:04 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.241.22])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 16 Jun 2025 13:37:04 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: jasowang@redhat.com, akihiko.odaki@daynix.com, yin31149@gmail.com
Cc: qemu-devel@nongnu.org, mjrosato@linux.ibm.com,
 Konstantin Shkolnyy <kshk@linux.ibm.com>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH v2] vdpa: Allow VDPA to work on big-endian machine
Date: Mon, 16 Jun 2025 08:36:47 -0500
Message-Id: <20250616133647.1662767-1-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDA4MyBTYWx0ZWRfXwULRtAEBNYSY
 bmVnD+QBpmoDf3yrhNmPuHxmlhV4ws2WdMTX/2VHynuZ6EPaimlxOu70SpF+6gsz3OwIjlfgmhM
 vOr5jEjzsjVbJI2XHlUW0SCA8rHdHaj8L/uELoVyNHCbrnPcgE3umLLh2VoAJVPNDPYoo+LHOu8
 fokhdasu6V57TRh/XeIOagvLvnWciKyVDbwFoAPDtoDW/jDjDBf6SdMqvsEAVc1SNJLqDpxAByN
 chPXbc16BhRPzTuwUnz26lhedxkBZDTUbkQMhpzEpVTZ+beuUy03pP1Pi93oeyvWh1fD1t7Rhl6
 iPVsH/SrGK6MQbYIRnzjSJ1z9pcJFdqVvUwpgKyG3j7g79VY40ri6vsEQZwJwEa/YXjARRHB0ct
 Uj8z8BNlGqE+j057iZO39yStjaBVFBH3TFGi7k5kiZTwqc0Ym2CqroIFrzScQn7KhejU7ZHv
X-Proofpoint-ORIG-GUID: --L4gECb9rv9doc0M7U1izUtzrh5mXoO
X-Authority-Analysis: v=2.4 cv=Qc9mvtbv c=1 sm=1 tr=0 ts=68501e03 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=wOKiVAmTcRLR3a3dhvcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: UNF2gYg8mUtuOwZm95si9xwmNSre677-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_05,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 spamscore=0 impostorscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0 mlxlogscore=909
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506160083
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kshk@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

After commit 0caed25cd171 vhost_vdpa_net_load_vlan() started seeing
VIRTIO_NET_F_CTRL_VLAN flag and making 4096 calls to the kernel with
VIRTIO_NET_CTRL_VLAN_ADD command. However, it forgot to convert the
16-bit VLAN IDs to LE format. On BE machine, the kernel calls failed
when they saw "VLAN IDs" greater than 4095, and QEMU then said:
"unable to start vhost net: 5: falling back on userspace virtio", and
VDPA became disabled.

Convert the VLAN ID to LE before putting it into virtio queue.

Fixes: 8f7e9967484d ("vdpa: Restore vlan filtering state")
Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
---
Changes in v2:
 - Replace __le16 with uint16_t.
 - Add "Fixes:" tag.

 net/vhost-vdpa.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 58d738945d..bd5c37305d 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -1173,9 +1173,10 @@ static int vhost_vdpa_net_load_single_vlan(VhostVDPAState *s,
                                            struct iovec *in_cursor,
                                            uint16_t vid)
 {
+    uint16_t vid_le = cpu_to_le16(vid);
     const struct iovec data = {
-        .iov_base = &vid,
-        .iov_len = sizeof(vid),
+        .iov_base = &vid_le,
+        .iov_len = sizeof(vid_le),
     };
     ssize_t r = vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
                                         VIRTIO_NET_CTRL_VLAN,
-- 
2.34.1


