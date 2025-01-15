Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E839C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 14:10:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY45d-0000OQ-GV; Wed, 15 Jan 2025 09:09:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1tY3Uj-00075W-8q; Wed, 15 Jan 2025 08:31:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1tY3Uh-000516-Tc; Wed, 15 Jan 2025 08:31:41 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FBqbUr010136;
 Wed, 15 Jan 2025 13:31:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=FZMQMvsZc9j0UILCt
 c/w/QNYDtg3drTL6UoNfEZ4nJM=; b=MElpd0GOc7IIyqLy8UcPiaGyq0o6w5dbo
 FzopKzpy/1m5t4/QLzxjEdw/AIgkDmdN8X0B35cCJfXDNcZKNqkW+SOUk9TILyG6
 kQ9mji60cw3UOpjpyInU+lkqUSNjOjBpiB7PzqgffieQTVOHl9kq3yXWIZdW0QN2
 xTJTULZd8NZXNe7BJJyU38jpXX+HUvivB8vC4wa2386HTfl0SqiiI4g9u3/E+sRd
 +/tmF1kO12wchdpHcUgdUQrk8Hce2gpm0Jypzf4XqntUjRSS8MZMNOn3n6GeERnS
 EyGvv2IWWmmr4ieeJmt+/s73ZH5OMgV7c/r2CHFkq0dF3Qtkfb0/g==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4461rbjy94-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jan 2025 13:31:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50FBKKO4017003;
 Wed, 15 Jan 2025 13:31:37 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4444fk8dkg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jan 2025 13:31:37 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50FDVXk939322010
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Jan 2025 13:31:33 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BE49C20043;
 Wed, 15 Jan 2025 13:31:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A2C8D20040;
 Wed, 15 Jan 2025 13:31:33 +0000 (GMT)
Received: from a46lp68.lnxne.boe (unknown [9.152.108.100])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 15 Jan 2025 13:31:33 +0000 (GMT)
From: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
To: qemu-s390x mailing list <qemu-s390x@nongnu.org>
Cc: qemu-devel mailing list <qemu-devel@nongnu.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Shalini Chellathurai Saroja <shalini@linux.ibm.com>
Subject: [PATCH v1 3/3] hw/s390x: support migration of CPI values
Date: Wed, 15 Jan 2025 14:31:06 +0100
Message-ID: <20250115133106.3034445-3-shalini@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250115133106.3034445-1-shalini@linux.ibm.com>
References: <20250115133106.3034445-1-shalini@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: biwQ9JhAcUufSjsK8ZToKBvRos5eqyI-
X-Proofpoint-GUID: biwQ9JhAcUufSjsK8ZToKBvRos5eqyI-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_05,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=890 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501150102
Received-SPF: pass client-ip=148.163.158.5; envelope-from=shalini@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1.793, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 15 Jan 2025 09:09:45 -0500
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

This commit saves the state of CPI values in the guest and
transfers this state during live migration of the guest.

Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
---
 hw/s390x/s390-virtio-ccw.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 35fb523af9..8fe0c5c1cb 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -259,6 +259,20 @@ static void s390_create_sclpconsole(SCLPDevice *sclp,
     qdev_realize_and_unref(dev, ev_fac_bus, &error_fatal);
 }
 
+static const VMStateDescription vmstate_cpi = {
+    .name = "s390_cpi",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT8_ARRAY(system_type, Cpi, 8),
+        VMSTATE_UINT8_ARRAY(system_name, Cpi, 8),
+        VMSTATE_UINT64(system_level, Cpi),
+        VMSTATE_UINT8_ARRAY(sysplex_name, Cpi, 8),
+        VMSTATE_UINT64(timestamp, Cpi),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static void ccw_init(MachineState *machine)
 {
     MachineClass *mc = MACHINE_GET_CLASS(machine);
@@ -307,6 +321,9 @@ static void ccw_init(MachineState *machine)
     ret = css_create_css_image(VIRTUAL_CSSID, true);
     assert(ret == 0);
 
+    /* register CPI values */
+    vmstate_register_any(NULL, &vmstate_cpi, &ms->cpi);
+
     css_register_vmstate();
 
     /* Create VirtIO network adapters */
-- 
2.47.0


