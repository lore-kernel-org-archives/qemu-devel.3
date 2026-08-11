Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F7DC5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 14:47:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtnkV-0002SC-57; Tue, 11 Aug 2026 10:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wtnkT-0002QN-Ks; Tue, 11 Aug 2026 10:46:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wtnkS-0003ef-8L; Tue, 11 Aug 2026 10:46:37 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67BDX9Zs451224; Tue, 11 Aug 2026 14:46:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=tcNZj1bG9vMNlzOiY
 6bmH5RG6FJOa4C4t9+tswaVSt0=; b=Fl1xEfcBIQ0ESSOvgLdA0Z1hEJzRlJmn0
 Jl77QgO8IH1mfvA+uaUm9nTwJEVWX82dGehaZHcbsvQbdXDOvGJ5/fOezdcoeM3s
 s85thSqA+mBNcWgU5dtv3cgqMoRndpLLGMhlkHI0suBWt/GMBQ96NYWBXtEhNhZC
 b9aNZmfyi8SvuqfMeJvDw2QRRkEMv4IMqXTn1ASZZpwjDIQIRUHyh+SOAUC4TIzq
 YNL08c24rEMGyZ0c/0WLLYwK9qQ1pv21JTt5RIhdhxTTRlWk80A4p43ZzgQ2jykg
 lmTBp5lyekRr/GLZZa736Ufife7DjhbrPfiKTSpQ4enMH7frPtLMg==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp2vtrq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Aug 2026 14:46:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BEfmPt019509;
 Tue, 11 Aug 2026 14:46:34 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5w1f27-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Aug 2026 14:46:34 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67BEkWNr7734016
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Aug 2026 14:46:33 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A885F5805E;
 Tue, 11 Aug 2026 14:46:32 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1A05B5805D;
 Tue, 11 Aug 2026 14:46:32 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.86.140])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 11 Aug 2026 14:46:31 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com,
 mjrosato@linux.ibm.com
Cc: farman@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v2 1/8] pc-bios/s390-ccw: Check if a PCI function is already
 enabled before trying to enable it
Date: Tue, 11 Aug 2026 10:46:22 -0400
Message-ID: <20260811144629.866641-2-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260811144629.866641-1-jrossi@linux.ibm.com>
References: <20260811144629.866641-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7b35ca cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=rOHUGBc37_MNbdIC:21 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=NApzFvG8OdL9Xanj_wQA:9 a=O8hF6Hzn-FEA:10
X-Proofpoint-GUID: dvsqYDH0762iRg0-QbeUGm9NL_WRL51k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEyMSBTYWx0ZWRfX9xXWjiApO7vy
 emX9YjZXM729wPrq8BgtqU9gk4ghSbvFLB85OIpOw1wZWaEB0AsFCn9ZntaY4MMJiJg+05ybbGX
 NhhdyfbMD5rNTGNXfq3zMb0FqVvYPXMldmsz6CRrE9hfSYn7bLAl235LYRfgxQfHeHUtszjfN0o
 4vBS8qwBYzfjs0JaVFT+MT9q+TPr9d+cVfFoYmwy3HF1KqxTPllIsvi7jTiY0i8NQqZY+Jmhtxp
 NbGyhHSzdljAZ3yyzHukp2ZSuGdcVgqmzYm31plpuywSZEXXwsuy0CHjXXNEyvyzY1L2c+gFWAr
 yvsjPzKt2q0EYtP3htwxdA0Lrj9mgwMxjkGQX0hFmYqjny6gg2mgrEiYd/NQHPLavIZi5PfTMWL
 9SZX3xdEh4K6MdszhyxVCmKuWO+bDwaRV3ZG+GdFFbIfzpFJsDQUgH69OtmvQQEYC3TkPUQo+sK
 Slpi3z6XgntNn83V1ag==
X-Proofpoint-ORIG-GUID: dvsqYDH0762iRg0-QbeUGm9NL_WRL51k
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEyMSBTYWx0ZWRfXzqxKpTSL0nj5
 Se84yleqqmVJaKxuraIs1ToFJ9YnQVYUakPLajlY5wkV6nY+lOFkRetwoPBX+Sng8sbMl+0Xrsn
 KlEnLPXo5YU8OOlYYkYiVghKMPQk8pQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110121
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

From: Jared Rossi <jrossi@linux.ibm.com>

Enabling a PCI function that is already configured will result in an error.
Simply check if the device has already been enabled, and if so, return
without doing anything further; otherwise, enable it as usual.

Also, because enable_pci_function() prints its own message, let's remove
the duplicate message emitted during the virtio PCI setup steps.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 pc-bios/s390-ccw/clp.c        | 4 ++++
 pc-bios/s390-ccw/virtio-pci.c | 1 -
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/pc-bios/s390-ccw/clp.c b/pc-bios/s390-ccw/clp.c
index ca9565d8de..7917f13345 100644
--- a/pc-bios/s390-ccw/clp.c
+++ b/pc-bios/s390-ccw/clp.c
@@ -82,6 +82,10 @@ int enable_pci_function(uint32_t *fhandle)
 {
     ClpReqRspSetPci rrb;
 
+    if (*fhandle & CLP_FHLIST_MASK_CONFIG) {
+        return 0;   /* already enabled */
+    }
+
     rrb.request.hdr.len = sizeof(ClpReqSetPci);
     rrb.request.hdr.cmd = 0x05;
     rrb.request.fh = *fhandle;
diff --git a/pc-bios/s390-ccw/virtio-pci.c b/pc-bios/s390-ccw/virtio-pci.c
index f501252c81..231ab6e04d 100644
--- a/pc-bios/s390-ccw/virtio-pci.c
+++ b/pc-bios/s390-ccw/virtio-pci.c
@@ -452,7 +452,6 @@ int virtio_pci_setup_device(void)
     VDev *vdev = virtio_get_device();
 
     if (enable_pci_function(&vdev->pci_fh)) {
-        puts("Failed to enable PCI function");
         return -ENODEV;
     }
 
-- 
2.54.0


