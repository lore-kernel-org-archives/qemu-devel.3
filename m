Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 866CECA5FDD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 05:29:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCVpM-0000GA-TU; Fri, 02 Oct 2026 01:29:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xCVok-0008OS-S5; Fri, 02 Oct 2026 01:28:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xCVoj-00082Z-34; Fri, 02 Oct 2026 01:28:22 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6922ZScb1680352; Fri, 2 Oct 2026 05:28:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=JT40iS79Lu/ZoEx09
 4ResrwlVg2k3uwBm9aqvdugAUQ=; b=i2DD6iWrpMlPayoSiENhE7glpBsYQmGod
 xm0dSzjTTKCPTbQMKS/U1q/ZbOyX+gO9iQJeVDW9SdJITIG/u/3axbUYVtJHnUgo
 rwuLi40HP50CNadzbEMWXm2XOMmR8+GDfW3tmvzvbb2I0YGVpv6fIHUSPLr9NxNb
 L4X9Zd7DUEM6xxkClRNLxjpXjKleACasjNYUojCtFsISMxBC1bucRvIFVh5wjfJ/
 rFpb8tKlbBbo0AQh071Lgg6cjL3Vb2d5GigtEbN+egsY3Oej965hKHchYwYKWOTw
 bIKqPExLeeyAKKI5SwJrILzriTBzzLkDFiGK2ToBFfnghpvY73qnA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5qrqm0x-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 02 Oct 2026 05:28:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6922KATR587032; Fri, 2 Oct 2026 05:28:13 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0q4pjyyt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Oct 2026 05:28:13 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6925SCms27722366
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 2 Oct 2026 05:28:12 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 23F975805A;
 Fri,  2 Oct 2026 05:28:12 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 189E758056;
 Fri,  2 Oct 2026 05:28:03 +0000 (GMT)
Received: from li-bd0dea4c-2912-11b2-a85c-e84940f94d2e.ibmuc.com (unknown
 [9.43.111.176]) by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  2 Oct 2026 05:28:02 +0000 (GMT)
From: uverma@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, aik@amd.com,
 nnmlinux@linux.ibm.com, avnish@linux.ibm.com
Cc: pbonzini@redhat.com, th.huth@posteo.eu, sbhat@linux.ibm.com,
 harshpb@linux.ibm.com, amachhiw@linux.ibm.com, rathc@linux.ibm.com,
 balaton@eik.bme.hu, philmd@linaro.org, npiggin@gmail.com,
 marcandre.lureau@redhat.com, fam@euphon.net, alex.bennee@linaro.org,
 richard.henderson@linaro.org, Utkarsh Verma <uverma@linux.ibm.com>
Subject: [RFC PATCH v2 6/8] spapr_vscsi: add VOF disk nodes to the device tree
Date: Fri,  2 Oct 2026 10:55:45 +0530
Message-ID: <20261002052605.605858-7-uverma@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002052605.605858-1-uverma@linux.ibm.com>
References: <20261002052605.605858-1-uverma@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDAyMCBTYWx0ZWRfX3bEqjour4qgz
 uBHGsm/O8KbOfW5tWry5qZh8OGErhPyKJ4k7Q1I21r6zOlK4PcL0iBbnrEQvho8TONv6aiKFJ0D
 VJyUIaC9Fh+WcZDKWFYbl4z5Bs92PD6v4S/xvmxk6/OYHnoAXWdaFyQTbYt24kkIvzUTM676tjp
 GQu/kqT7UEfGEA13VNz+OmjYzO5j3PRk+FuFK1kzn+zrfuCP9dVOptGo198WwSF4Rr+ywHgz5mA
 /hPxO5mFaprlSV3YnY1mza4sPbgfFbBg5ADRMTHjpm+OdkVSU8v9jek7KzeySQsOl+xwmGCiphq
 JqREQznqfCT5N+ZQpI6jlOG/mlY3UwyqwuZzj8D01QwGZ9DyD3FydYcGIItr9RwLTY5Zt9Hv5nR
 nkOz/1TWnTHGHBbwDgkuHMHrdTV4FOFAF1O1Ri8sZgdBspPzTeDUweafLVVVgq25DNHXnwh/uJK
 TLwX3ETroJZWIpHkyHQ==
X-Authority-Analysis: v=2.4 cv=SPbXx+vH c=1 sm=1 tr=0 ts=6abf40ee cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=gihry9JuEvR3qkE0AycA:9
X-Proofpoint-ORIG-GUID: mIlqppF98i2ca4OMeFKVkdC2KSnDuGAB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDAyMCBTYWx0ZWRfX4K3ZhYuh1j6o
 sKjF3bYWVYAze2RBSIBTUzhWbAhK44x289vZnX3Fwu7+/ehLdqzrOKE6kmh6rqX0dI8kZ3fDQ0/
 8oPArVIA0x5Z0LCSKs7pGifF36GR0lo=
X-Proofpoint-GUID: ogfiHKEjdJNNssuDVojUuFznpKOK8Ea2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_01,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610020020
Received-SPF: pass client-ip=148.163.156.1; envelope-from=uverma@linux.ibm.com;
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

From: Utkarsh Verma <uverma@linux.ibm.com>

In VOF mode, add a single generic "disk" child node under the vSCSI
FDT node instead of one node per attached LUN, matching the Open
Firmware behaviour.

The node carries device_type = "block" and a name property. The
path_offset() wildcard fallback introduced alongside this change
resolves any "disk@<srp-lun>" open request to this shared node,
from which vof_do_open() extracts the LUN from the path string
at runtime.

AI-used-for: code
Signed-off-by: Utkarsh Verma <uverma@linux.ibm.com>
---
Changelog:
v2:
- Replaced one FDT child node per attached LUN ("disk@<srp-lun>" with
  reg + device_type) with a single generic "disk" wildcard node shared
  by all LUNs, matching the Open Firmware behaviour.
---
 hw/scsi/spapr_vscsi.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index b4c8f94d22..a799181d0f 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -1255,6 +1255,29 @@ static int spapr_vscsi_devnode(SpaprVioDevice *dev, void *fdt, int node_off)
         return ret;
     }
 
+    /*
+     * In VOF mode add a generic "disk" wildcard child node without appending
+     * srp-lun to it's path name, matching the actual Open Firmware behaviour.
+     * Its phandle and device_type covers any disk@<srp-lun> path.
+     */
+    SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
+    if (spapr->vof) {
+        int disk_off = fdt_add_subnode(fdt, node_off, "disk");
+        if (disk_off < 0) {
+            return disk_off;
+        }
+
+        ret = fdt_setprop_string(fdt, disk_off, "name", "disk");
+        if (ret < 0) {
+            return ret;
+        }
+
+        ret = fdt_setprop_string(fdt, disk_off, "device_type", "block");
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
     return 0;
 }
 
-- 
2.55.0


