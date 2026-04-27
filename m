Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C707FF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 14:48:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHNFt-0000cj-8N; Mon, 27 Apr 2026 10:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wHNFr-0000cY-E6
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 10:48:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wHNFp-0006Ov-Om
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 10:48:11 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63REl9bD2759019; Mon, 27 Apr 2026 14:48:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=Wbm9LDXAHQQvQKBXhuN9AQj/hnNB
 mHIVoSwTMHLCPu4=; b=mQ2aaUdrw6tmMBVQ66AggxBPvYk6iSs1cJlvYxJjm3pb
 QqQ3Ldwm/0B8g6F6Wai4VXTtzqrLDOV0KGOWIotDWfTCfJaHclcUsnSaDJbV8Dy7
 IfTdhcjLnRqnLtdo6o090oCz8fdSeRqGde/VUBFbHWjNUuv23JyKMTc8Nk3RjMGt
 Z5W18BBKjtUwoeeMn/ti87I+GaZWMpdFUmQ7V+BTuHiuZEcIDKdLqUakUYQQVO5M
 FcgDkI/oxOOsH/5gU9w9f7DZ5MtNYTbF5pISl1tVi4k9Acs5AT41rQsBFUTyPAky
 uz1qSi4XzL9aOTad7QxQZDD52wqCHHKjYuinga6vQw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drnb50xj9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Apr 2026 14:48:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63REcvKp029263;
 Mon, 27 Apr 2026 14:48:04 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8avnpa2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Apr 2026 14:48:04 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63REm3GH9503414
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Apr 2026 14:48:03 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4DD9C58056;
 Mon, 27 Apr 2026 14:48:03 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2834A58052;
 Mon, 27 Apr 2026 14:48:03 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.atx-us.ibm.com (unknown [9.16.62.165])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 27 Apr 2026 14:48:03 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mst@redhat.com, sgarzare@redhat.com, jasowang@redhat.com,
 qemu-devel@nongnu.org
Cc: mjrosato@linux.ibm.com, Konstantin Shkolnyy <kshk@linux.ibm.com>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v3] vdpa: Allow VDPA to work on big-endian machine
Date: Mon, 27 Apr 2026 09:47:46 -0500
Message-Id: <20260427144746.1498-1-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AqDeGu9P c=1 sm=1 tr=0 ts=69ef7726 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=wOKiVAmTcRLR3a3dhvcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDE1OCBTYWx0ZWRfX5gtHp7dTuSEg
 7JhuhL31O7iLLomhBGLIqpIhH6Yl5dr4kctYMaaCdz6wDBdwKJZeDYc9/MPyKzkGtV+K6vGge3b
 QA3g1ZJPKYwuRDCp1xVQed55Eur4TRQ5JBwfQ/GlLsfJRxjo9Tf5z3K0WEuY7blMtD3tEyEXd4w
 cjtamt82W4CWtnv/M5WckPpMN29LxZ8OIWh3xNoCv0irxdHLe0z13L4UWcoudEPM57YRwzS+RcE
 SzOnsuv7/bJ3QgmylhG4IcK1U4Z8WYhioIt2YKrAZnAJr+oCKtaqGFzcNDJnBQtAp5jih27eGA7
 caPmhga3gIrerT3T8XZO4gCjLsXEgkxJv+ikR8/u+NRFVTqepX7LUKlGCtG7y/pDZuivu55iM4o
 mUgrO12Ukjgf8ZHAAICFUKGhzx6trHeany6mU+wtv9pbN0MOVz9Wl8YEs3ZYnHzImFydiSHFpCL
 jkS+9uL82m+FuxxpLWg==
X-Proofpoint-GUID: Cixd1whsQ1v7HyBucQyjg8R-IJ2LZXlX
X-Proofpoint-ORIG-GUID: Cixd1whsQ1v7HyBucQyjg8R-IJ2LZXlX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1011
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270158
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kshk@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
This patch was reviewed several months ago but was never applied. Resending...
Changes in v3:
 - Add Reviewed-by: Akihiko Odaki.
---
 net/vhost-vdpa.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 3df6091274..f1523697e2 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -1200,9 +1200,10 @@ static int vhost_vdpa_net_load_single_vlan(VhostVDPAState *s,
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


