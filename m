Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE75CCFA13
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 20:03:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIu52-0000lk-Cn; Fri, 01 May 2026 16:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oelghoul@linux.ibm.com>)
 id 1wIu4w-0000kX-Fd; Fri, 01 May 2026 16:03:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oelghoul@linux.ibm.com>)
 id 1wIu4u-0001Eb-U3; Fri, 01 May 2026 16:03:14 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 641GKXLn3403831; Fri, 1 May 2026 20:03:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=MmAIrOmBi+O9AQ6ZS
 5atURf23x4XcDe8K9D0teZNruQ=; b=lB78hm0OYR/ddkY6t28Qb9G7ThrYBkt/Z
 EFVlLFDtgkpwnJI52N7cBc5bUsQvkpAlHa0I2dl5NhKU6gLdSik+teLcWe0waE+5
 6G9QaaIqwl2PKBCQGhrOg+HDjI9vhs3TybL3TDkvVTR1Ecf/8UeWjJT7TmoUQmYR
 kTflfKFr3JeuRC4kUPiv3/mUevLPbP7sPpqS3bZftfEgaeAHqgLoBgbmjWN+zyny
 YewZBYItxy0wkglrEr3/eR5RSvSdY+X0wAwGY+/gSn0VK+lzloiR45noWmU6jUyJ
 t1JG3qkW/Ox64wL8NQheEiYERPhGBwhSN/5CqgTkVXfY+fca6GkLw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drm1ec7ru-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 May 2026 20:03:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 641Js0Po003852;
 Fri, 1 May 2026 20:03:07 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8xkgxjw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 May 2026 20:03:07 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 641K34ba29032896
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 1 May 2026 20:03:04 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6352658055;
 Fri,  1 May 2026 20:03:04 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 421D158043;
 Fri,  1 May 2026 20:03:03 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.247.25])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  1 May 2026 20:03:03 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: oelghoul@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 cohuck@redhat.com, mst@redhat.com, pbonzini@redhat.com, clg@redhat.com
Subject: [RFC PATCH v1 2/5] hw/s390x: Clarified FMB format for emulated and
 passthrough devices
Date: Fri,  1 May 2026 16:00:23 -0400
Message-ID: <20260501200026.22784-3-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260501200026.22784-1-oelghoul@linux.ibm.com>
References: <20260501200026.22784-1-oelghoul@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iKmMe7lmwB7SjmWYCxL8p4SSFByjXCjO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAxMDE5NSBTYWx0ZWRfXx8IrxA9ZhwlS
 Su2yf8IcoK1fBR6wF0QfoOX5SdcYLuKCRQPdfD8zM6onj7uImpuhFE+wD0isgbQ8+zGpaxCW3aa
 sw2kE2X3yVrWuq90T53p/sIDOEXhtgQU4Vf9wuG/5U23mlmCohtv9UO2qe8q20Fe90TyxpkU8f8
 qowWjR0S9JbySEOii+u9dGH8Y2fZXk0gyfnm3Fm1hMw9pqDxGdYHwzNcVfrP1g+uQct2rPON9lq
 AKAGcl7H2/ESXxYoI3QXV//i2WojvkxXEDd4qJ6bsmfQcjuKaRmHA1VsjRK8Tg6gVPm9eX7jOEg
 QnZqSgQ6uRiQJsIDdWdlOz+ito8FcRHERewRPSM0ZafJ4b8wxcRlDJSiGgDj9eHkDc3DYUzACn0
 th3Hohw0XcRmbD4nIjf2+0f/pEEKirjOEq1DjWV3oOskcNPfwWDbC9Ugnxjn86Q6JFxnnfiohxc
 BQrQ30vXRw1gHLbBnYA==
X-Authority-Analysis: v=2.4 cv=VZLH+lp9 c=1 sm=1 tr=0 ts=69f506fc cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=f_7aZsy8-PDlq5a6mJoA:9
X-Proofpoint-GUID: iKmMe7lmwB7SjmWYCxL8p4SSFByjXCjO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-01_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605010195
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=oelghoul@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

Renamed the default FMB format macro and added a comment explaining that
it will be overwritten in the case of PCI passthrough devices when paired
with a compatible kernel.

Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c         | 8 +++++++-
 include/hw/s390x/s390-pci-bus.h | 2 +-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 4de7b587e8..128814f4c5 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1486,7 +1486,13 @@ static void s390_pci_device_realize(DeviceState *dev, Error **errp)
     }
 
     zpci->state = ZPCI_FS_RESERVED;
-    zpci->fmb.format = ZPCI_FMB_FORMAT;
+
+    /*
+     * For emulated devices, we use FMB format-0. For PCI passthrough
+     * devices paired with a compatible kernel, this will get overwritten
+     * by the VFIO-provided FMB.
+     */
+    zpci->fmb.format = ZPCI_FMB_DEFAULT_FORMAT;
 }
 
 static void s390_pci_device_reset(DeviceState *dev)
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index 9228523ce8..feaf6d4863 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -308,7 +308,7 @@ typedef struct ZpciFmbFmt0 {
 #define ZPCI_FMB_CNT_RPCIT 3
 #define ZPCI_FMB_CNT_MAX   4
 
-#define ZPCI_FMB_FORMAT    0
+#define ZPCI_FMB_DEFAULT_FORMAT     0
 
 typedef struct ZpciFmb {
     uint32_t format;
-- 
2.52.0


