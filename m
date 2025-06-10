Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2869C5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 17:00:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP27t-0003Pi-UR; Tue, 10 Jun 2025 12:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP15M-0004Sn-QZ
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:40:26 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP15J-0006C0-Pp
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:40:24 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AEXe7s031147;
 Tue, 10 Jun 2025 15:40:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=dImXolpWbJtPiSZFmHlkZlCp8b/agnfa37fqDv+cfFc=; b=
 lKIaT4xtbsLF1yuiUQz45A425FtVVGZ1X2WJhaz2jnN+tkxGSO+XtXwP+nPhPg61
 gHkRMTdarpetEc5i0amgA2fx3lx//LFb91yyJkox+zUT+0BtTpjz5Bsc2tg01gkM
 qLMNlEUfhyAuPJcaerhTFg3GZaIvTEevP/Fv8UoRazzieR56aAOlfpPxYES1thBR
 Di8XkmG+IYvu6q8ISdzWMwj7GJibSE2EhWM5ECpRwSlqvA9whzLFDePreTGaV25G
 kwTPja2JwhvCCd4Zma9r3Ghh5kKxXWTQ0XbwDfqWqmaOlJHo413C9c0KjP+83O+W
 MMKIQ+GZi29nKEPecUz5TA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474dywvgs3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 15:40:18 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55AFAkHl003301; Tue, 10 Jun 2025 15:40:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 474bv8wb7p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 15:40:17 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55AFdrfd028825;
 Tue, 10 Jun 2025 15:40:16 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 474bv8wak1-17; Tue, 10 Jun 2025 15:40:16 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V5 16/38] vfio/pci: vfio_notifier_cleanup
Date: Tue, 10 Jun 2025 08:39:29 -0700
Message-Id: <1749569991-25171-17-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_07,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506100125
X-Authority-Analysis: v=2.4 cv=fdaty1QF c=1 sm=1 tr=0 ts=684851e3 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=28Sen26mfX-obivxnQMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14714
X-Proofpoint-ORIG-GUID: AuTk0hEJqYIvpY2dKASU1f0tYkCH9yGc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDEyNiBTYWx0ZWRfX8ZYZTXmi9Ar3
 h9KtX+nhDE4qTkWeK1se9+CihxCP7QndFZTOeLBqyMIvHZH2+6ATqmTl+nmPYweThXtFz4wE9RK
 mw4nTv5Xkwb0B9JMlqo3cXZfd69bw0GrLAqGxwpUFlLiIW9hc6yChisSAMYGy2gUaitlNJSQcU5
 o60ScJnziJMQscX86XoUoM/I4zMP3udawv/FMAIk62CXi0U/A7hPB9m5eWIt0YadgEj/FtIBGCc
 ferlMh58aHpSNiYjCKyO26nC5kzLWIdhrK6eMcVT6t4HS47pyyXB+WHhC/NrwcqhgCJ+u3POb3u
 nr9OmXuha4JTGwcYd1oaXAlXhbxByG4UTkBisr5tPW5fOeT2U8ZUZZunytti3cSIJBm22egMGl1
 ZWnY9UMVYrefeZ3XoK0D2RdbS5QfUNkwItbjU56HQb1/aUiGTQVCvb/MJycuUNeD6nRFYOO5
X-Proofpoint-GUID: AuTk0hEJqYIvpY2dKASU1f0tYkCH9yGc
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Move event_notifier_cleanup calls to a helper vfio_notifier_cleanup.
This version is trivial, and does not yet use the vdev and nr parameters.
No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index ebc1a4b..508701c 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -68,6 +68,12 @@ static bool vfio_notifier_init(VFIOPCIDevice *vdev, EventNotifier *e,
     return !ret;
 }
 
+static void vfio_notifier_cleanup(VFIOPCIDevice *vdev, EventNotifier *e,
+                                  const char *name, int nr)
+{
+    event_notifier_cleanup(e);
+}
+
 /*
  * Disabling BAR mmaping can be slow, but toggling it around INTx can
  * also be a huge overhead.  We try to get the best of both worlds by
@@ -180,7 +186,7 @@ fail_vfio:
     kvm_irqchip_remove_irqfd_notifier_gsi(kvm_state, &vdev->intx.interrupt,
                                           vdev->intx.route.irq);
 fail_irqfd:
-    event_notifier_cleanup(&vdev->intx.unmask);
+    vfio_notifier_cleanup(vdev, &vdev->intx.unmask, "intx-unmask", 0);
 fail:
     qemu_set_fd_handler(irq_fd, vfio_intx_interrupt, NULL, vdev);
     vfio_device_irq_unmask(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
@@ -212,7 +218,7 @@ static void vfio_intx_disable_kvm(VFIOPCIDevice *vdev)
     }
 
     /* We only need to close the eventfd for VFIO to cleanup the kernel side */
-    event_notifier_cleanup(&vdev->intx.unmask);
+    vfio_notifier_cleanup(vdev, &vdev->intx.unmask, "intx-unmask", 0);
 
     /* QEMU starts listening for interrupt events. */
     qemu_set_fd_handler(event_notifier_get_fd(&vdev->intx.interrupt),
@@ -311,7 +317,7 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
     if (!vfio_device_irq_set_signaling(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX, 0,
                                 VFIO_IRQ_SET_ACTION_TRIGGER, fd, errp)) {
         qemu_set_fd_handler(fd, NULL, NULL, vdev);
-        event_notifier_cleanup(&vdev->intx.interrupt);
+        vfio_notifier_cleanup(vdev, &vdev->intx.interrupt, "intx-interrupt", 0);
         return false;
     }
 
@@ -338,7 +344,7 @@ static void vfio_intx_disable(VFIOPCIDevice *vdev)
 
     fd = event_notifier_get_fd(&vdev->intx.interrupt);
     qemu_set_fd_handler(fd, NULL, NULL, vdev);
-    event_notifier_cleanup(&vdev->intx.interrupt);
+    vfio_notifier_cleanup(vdev, &vdev->intx.interrupt, "intx-interrupt", 0);
 
     vdev->interrupt = VFIO_INT_NONE;
 
@@ -501,7 +507,7 @@ static void vfio_connect_kvm_msi_virq(VFIOMSIVector *vector, int nr)
     return;
 
 fail_kvm:
-    event_notifier_cleanup(&vector->kvm_interrupt);
+    vfio_notifier_cleanup(vector->vdev, &vector->kvm_interrupt, name, nr);
 fail_notifier:
     kvm_irqchip_release_virq(kvm_state, vector->virq);
     vector->virq = -1;
@@ -514,7 +520,7 @@ static void vfio_remove_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
                                           vector->virq);
     kvm_irqchip_release_virq(kvm_state, vector->virq);
     vector->virq = -1;
-    event_notifier_cleanup(&vector->kvm_interrupt);
+    vfio_notifier_cleanup(vdev, &vector->kvm_interrupt, "kvm_interrupt", nr);
 }
 
 static void vfio_update_kvm_msi_virq(VFIOMSIVector *vector, MSIMessage msg,
@@ -837,7 +843,7 @@ static void vfio_msi_disable_common(VFIOPCIDevice *vdev)
             }
             qemu_set_fd_handler(event_notifier_get_fd(&vector->interrupt),
                                 NULL, NULL, NULL);
-            event_notifier_cleanup(&vector->interrupt);
+            vfio_notifier_cleanup(vdev, &vector->interrupt, "interrupt", i);
         }
     }
 
@@ -2955,7 +2961,7 @@ static void vfio_register_err_notifier(VFIOPCIDevice *vdev)
                                        VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
         error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
         qemu_set_fd_handler(fd, NULL, NULL, vdev);
-        event_notifier_cleanup(&vdev->err_notifier);
+        vfio_notifier_cleanup(vdev, &vdev->err_notifier, "err_notifier", 0);
         vdev->pci_aer = false;
     }
 }
@@ -2974,7 +2980,7 @@ static void vfio_unregister_err_notifier(VFIOPCIDevice *vdev)
     }
     qemu_set_fd_handler(event_notifier_get_fd(&vdev->err_notifier),
                         NULL, NULL, vdev);
-    event_notifier_cleanup(&vdev->err_notifier);
+    vfio_notifier_cleanup(vdev, &vdev->err_notifier, "err_notifier", 0);
 }
 
 static void vfio_req_notifier_handler(void *opaque)
@@ -3022,7 +3028,7 @@ static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
                                        VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
         error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
         qemu_set_fd_handler(fd, NULL, NULL, vdev);
-        event_notifier_cleanup(&vdev->req_notifier);
+        vfio_notifier_cleanup(vdev, &vdev->req_notifier, "req_notifier", 0);
     } else {
         vdev->req_enabled = true;
     }
@@ -3042,7 +3048,7 @@ static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
     }
     qemu_set_fd_handler(event_notifier_get_fd(&vdev->req_notifier),
                         NULL, NULL, vdev);
-    event_notifier_cleanup(&vdev->req_notifier);
+    vfio_notifier_cleanup(vdev, &vdev->req_notifier, "req_notifier", 0);
 
     vdev->req_enabled = false;
 }
-- 
1.8.3.1


