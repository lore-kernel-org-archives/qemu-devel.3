Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A06C61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 18:33:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x16nk-0001es-5Y; Mon, 31 Aug 2026 14:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1x16na-0001cF-LE; Mon, 31 Aug 2026 14:32:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1x16nX-0001vz-Of; Mon, 31 Aug 2026 14:32:02 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VIVfeM2996253; Mon, 31 Aug 2026 18:31:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=0gnc7XSv29t1fDYFN
 a1GarrvAHQ66nnmaROaC/HIENY=; b=Z7E4ZESryF1X9kwH5pVYNhZXy5zMn2XP5
 S0XqDn7LJWshNlle3x3O5sh4uJVelMuCk5FK54umogKV4Dlw4GQXUitPuPRSgOGU
 n/Kw4pYT8yUBRaR931iGjUrRu8xgTw/MYTKNqbZFGAYCZGbO+NNKCOIxhbFfi19g
 by+wx3+kexNZh4gmrM5CZJmCEHz3Ujr27E3xncVehlY6iyZUs9FHnQBfv5sEoPZU
 fKpWOCNQj2UYinI2tLwORSYI19maB0h9JNeYbEgF9klNkMNE0g9XjclZ+jQ4MQTx
 DpVg1zmsAL9UbRn2yVyztY2X9HTr2TN0viZ57j7aHMmqWNDeBm3+Q==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbmuhk92p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 18:31:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VIBNij013167;
 Mon, 31 Aug 2026 18:31:57 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcbyg79c3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 18:31:57 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67VIVtaQ4719348
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Aug 2026 18:31:55 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 95FBF58054;
 Mon, 31 Aug 2026 18:31:55 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 95AE15805D;
 Mon, 31 Aug 2026 18:31:54 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.241.20])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 31 Aug 2026 18:31:54 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mjrosato@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 cohuck@redhat.com, alex@shazbot.org, clg@redhat.com, armbru@redhat.com
Subject: [PATCH v4 2/4] vfio/pci: Add an error handler callback
Date: Mon, 31 Aug 2026 11:31:49 -0700
Message-ID: <20260831183151.12626-3-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831183151.12626-1-alifm@linux.ibm.com>
References: <20260831183151.12626-1-alifm@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rlOv_LA5303Nm9JZQXioxzvoYhQM2w2_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE2MCBTYWx0ZWRfXyEsCMeCxwAdQ
 52tYTA+UeDb/cigcRkZJCRu2fgUApi9zDFtaj69JRRIm6wpMLdG8rfDiSWjJlUHHSy6wqZCEDwe
 8itOOwT4P3yAAKgm3hiYHp7ruy+u8Y8yDuLBgxdfQq5uc5XSmoASWJCNT73r6A3NO5RxSEobfMm
 UVXjuczgQjUUVms3llvpPxUjVxRa7uPTsA7BXodV36nN4AaqfIOeLH3HREedrIfAsSBVu61yTPE
 mB5PzZE3gJp017bm1m5bmFsLs73pBEl6PS5DJ/jZthASx9tUnXougk2hNZy3aBJIpEMHAydu0fM
 KdIE1HS8ApblpsQXdC6NFg06JxoKeFr9ak8OBdSb+SYk0nfybcVzj7gL1AaY8YpS7+wKw+Sxos7
 wEkZUMyFzVp8ZztyTN3ekAlCzwYx3hFBp564AKFevOoyBlgjaZCwT/0vHulT0N+fzhDziVfQyik
 0onp2mrzY2vtzAPIM2A==
X-Authority-Analysis: v=2.4 cv=Osl/DS/t c=1 sm=1 tr=0 ts=6a95c89e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=SCf8sy86YrGlchD0B1QA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE2MCBTYWx0ZWRfX4YMAkNBlh0zZ
 Ccbm64X9XJx0WRjsXGB+Dcrl5mLc7NZ9xYk00QZkWnln4LhDBrarZdARiE271Ulj1cGBmSDIkXu
 3EJlybLhc5NsUNgF4LC/avmhP7eqFYk=
X-Proofpoint-ORIG-GUID: rlOv_LA5303Nm9JZQXioxzvoYhQM2w2_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_06,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310160
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
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

Provide a vfio error handling callback, that can be used by devices to
handle PCI errors for passthrough devices.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 hw/vfio/pci.c | 27 +++++++++++++++++++++------
 hw/vfio/pci.h |  1 +
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 428ab2f069..a2f489b34d 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3244,21 +3244,36 @@ void vfio_pci_put_device(VFIOPCIDevice *vdev)
 static void vfio_err_notifier_handler(void *opaque)
 {
     VFIOPCIDevice *vdev = opaque;
+    Error *err = NULL;
 
     if (!event_notifier_test_and_clear(&vdev->err_notifier)) {
         return;
     }
 
     /*
-     * TBD. Retrieve the error details and decide what action
-     * needs to be taken. One of the actions could be to pass
-     * the error to the guest and have the guest driver recover
-     * from the error. This requires that PCIe capabilities be
-     * exposed to the guest. For now, we just terminate the
+     * We can retrieve the error details and decide what action
+     * needs to be taken in err_handler(). One of the actions could
+     * be to pass the error to the guest and have the guest driver
+     * recover from the error. This requires that PCIe capabilities be
+     * exposed to the guest.
+     *
+     * If err_handler() is not implemented/fails, we just terminate the
      * guest to contain the error.
      */
 
-    error_report("%s(%s) Unrecoverable error detected. Please collect any data possible and then kill the guest", __func__, vdev->vbasedev.name);
+    if (vdev->err_handler && vdev->err_handler(vdev, &err)) {
+        return;
+    }
+
+    if (err) {
+        error_prepend(&err, "Unrecoverable PCIe error detected for device %s",
+                      vdev->vbasedev.name);
+        error_report_err(err);
+    } else {
+        error_printf("Unrecoverable PCIe error detected for device %s",
+                     vdev->vbasedev.name);
+    }
+    error_printf("Please collect any data possible and then kill the guest");
 
     vm_stop(RUN_STATE_INTERNAL_ERROR);
 }
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index c9ab949870..c067bbbebc 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -146,6 +146,7 @@ struct VFIOPCIDevice {
     EventNotifier err_notifier;
     EventNotifier req_notifier;
     int (*resetfn)(struct VFIOPCIDevice *);
+    bool (*err_handler)(struct VFIOPCIDevice *, Error **);
     uint32_t vendor_id;
     uint32_t device_id;
     uint32_t sub_vendor_id;
-- 
2.43.0


