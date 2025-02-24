Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 901F2C021BB
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 12:06:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmXDM-00066y-Qi; Mon, 24 Feb 2025 07:05:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1tmXDL-00066i-0m; Mon, 24 Feb 2025 07:05:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1tmXDJ-00031p-2S; Mon, 24 Feb 2025 07:05:34 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O2Ddvb025484;
 Mon, 24 Feb 2025 12:05:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=4DAamYja86au9HknG
 VwAnm2wevDXyikwInE3oBV18ko=; b=kQCsH3Ha0b5roOy5OYZjMPGQAgLGjl3eK
 XEjWVFOMLTzF85cbuYCtBJVVUvUwNoqlw4Xj1INXRC1ktbrQqd7ywacqbrSqYLyx
 /0T3Nv1mUuM41TDlCWaKaHd6fPGNUImpNXZk3cjxcn82XR/es9Okl8bow+6076GA
 orlgPClnxTuHg6ufV2lwrHT8LBMzaCTfZp1tchfTGOfVSdq+CPQm46mQJV9isUAX
 or3gn4+55RAhH+t3dL/qOXkZ8FJXnpFlJZBa5VgKKZ3OO7ZJM/qu7WtP9qQZnQB9
 2t7G2R1cJ9PBQfaNnWGRlkcdCYpmmwp1Z90w8dmAVx7hxafDuEbDw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 450eu9td8y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Feb 2025 12:05:30 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51O9AJfd026990;
 Mon, 24 Feb 2025 12:05:29 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44ytdk6vnc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Feb 2025 12:05:28 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 51OC5PXd9306516
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2025 12:05:25 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0F8DE20049;
 Mon, 24 Feb 2025 12:05:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E511E20040;
 Mon, 24 Feb 2025 12:05:24 +0000 (GMT)
Received: from a46lp68.lnxne.boe (unknown [9.152.108.100])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Feb 2025 12:05:24 +0000 (GMT)
From: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
To: qemu-s390x mailing list <qemu-s390x@nongnu.org>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-devel mailing list <qemu-devel@nongnu.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Shalini Chellathurai Saroja <shalini@linux.ibm.com>
Subject: [PATCH qemu v2 3/3] hw/s390x: support migration of CPI values
Date: Mon, 24 Feb 2025 13:04:49 +0100
Message-ID: <20250224120449.1764114-3-shalini@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250224120449.1764114-1-shalini@linux.ibm.com>
References: <20250224120449.1764114-1-shalini@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QkbaVZETOTr28D2f7f8Vz8dWanYJ4AE9
X-Proofpoint-ORIG-GUID: QkbaVZETOTr28D2f7f8Vz8dWanYJ4AE9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_05,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0
 suspectscore=0 bulkscore=0 clxscore=1011 phishscore=0 spamscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=855
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502240088
Received-SPF: pass client-ip=148.163.156.1; envelope-from=shalini@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Register Control-Program Identification data with the live
migration infrastructure.

Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
---
 hw/s390x/s390-virtio-ccw.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 13ea8db1b0..4d0838d037 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -260,6 +260,20 @@ static void s390_create_sclpconsole(SCLPDevice *sclp,
     qdev_realize_and_unref(dev, ev_fac_bus, &error_fatal);
 }
 
+static const VMStateDescription vmstate_control_program_id = {
+    .name = "s390_control_program_id",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT8_ARRAY(system_type, ControlProgramId, 8),
+        VMSTATE_UINT8_ARRAY(system_name, ControlProgramId, 8),
+        VMSTATE_UINT64(system_level, ControlProgramId),
+        VMSTATE_UINT8_ARRAY(sysplex_name, ControlProgramId, 8),
+        VMSTATE_UINT64(timestamp, ControlProgramId),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static void ccw_init(MachineState *machine)
 {
     MachineClass *mc = MACHINE_GET_CLASS(machine);
@@ -308,6 +322,9 @@ static void ccw_init(MachineState *machine)
     ret = css_create_css_image(VIRTUAL_CSSID, true);
     assert(ret == 0);
 
+    /* register CPI values */
+    vmstate_register_any(NULL, &vmstate_control_program_id, &ms->cpi);
+
     css_register_vmstate();
 
     /* Create VirtIO network adapters */
-- 
2.47.0


