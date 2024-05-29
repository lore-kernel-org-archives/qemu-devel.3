Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8555AC25B7E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 15:45:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCLSe-0005o8-PI; Wed, 29 May 2024 11:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1sCLSc-0005mU-Kt; Wed, 29 May 2024 11:43:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1sCLSa-0006xy-TD; Wed, 29 May 2024 11:43:30 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44TFBCMG021274; Wed, 29 May 2024 15:43:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : date : from : in-reply-to : message-id :
 mime-version : references : subject : to; s=pp1;
 bh=i1ZddlVaqXoyEbUeMkXydGpQ6op+z/QE2+zEDnnUsQE=;
 b=n36Csnvo9IUKrpvcQ1B2nuQHruCpSRZXGCkfGSOiAYhPTbQRhgIlF/Yy8O+bcToaoyU4
 fTTsCKSP0Tk0p2hi9GZ4MI+h2NpdwHRNmz1FK+eOHSIMIh7CypUD06Psx1pj3JjLEfQG
 uiRWmztk2iZKXSFtDFd+d3d9R7b1tvUo4MMuA1v8Jp4GBdwgxAZhoks3nuZc+2v8LhUZ
 5cVtBbXTncLBhcej2y6MLuZ/fHmGFuzagTS/BAcFWPctVYlJ4n7TIfOiGF91voc0vZIN
 NMGTh7Z2LoT/q8B7vfl8XCqwv/OyEuOD3LayupEpIpp6rkMH/OT8ih16JVT3wZOAwksa OA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ye58prc8r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 May 2024 15:43:26 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44TFhPJ9008206;
 Wed, 29 May 2024 15:43:25 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ye58prc8n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 May 2024 15:43:25 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44TF8RoZ002783; Wed, 29 May 2024 15:43:24 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ydpb0mka3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 May 2024 15:43:24 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44TFhLvH26214894
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 May 2024 15:43:23 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9984C58068;
 Wed, 29 May 2024 15:43:21 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2C6A058064;
 Wed, 29 May 2024 15:43:21 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.67.55.69])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 29 May 2024 15:43:21 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: frankja@linux.ibm.com, nsg@linux.ibm.com, jrossi@linux.ibm.com
Subject: [PATCH 5/5] s390x: Enable and document boot device fallback on panic
Date: Wed, 29 May 2024 11:43:11 -0400
Message-Id: <20240529154311.734548-6-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240529154311.734548-1-jrossi@linux.ibm.com>
References: <20240529154311.734548-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eOcfXpobV5j-6cIv0uHD2nBi9KOCD5VL
X-Proofpoint-ORIG-GUID: -n9eJw642lP-qe813A85fO3HXd81Iz-I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_12,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0
 spamscore=0 mlxscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405290108
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Jared Rossi <jrossi@linux.ibm.com>

On a panic during IPL (i.e. a device failed to boot) check for another device
to boot from, as indicated by the presence of an unused IPLB.

If an IPLB is successfully loaded, then jump to the start of BIOS, restarting
IPL using the updated IPLB.  Otherwise enter disabled wait.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 docs/system/bootindex.rst         | 7 ++++---
 docs/system/s390x/bootdevices.rst | 9 ++++++---
 pc-bios/s390-ccw/s390-ccw.h       | 6 ++++++
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/docs/system/bootindex.rst b/docs/system/bootindex.rst
index 8b057f812f..de597561bd 100644
--- a/docs/system/bootindex.rst
+++ b/docs/system/bootindex.rst
@@ -50,9 +50,10 @@ Limitations
 
 Some firmware has limitations on which devices can be considered for
 booting.  For instance, the PC BIOS boot specification allows only one
-disk to be bootable.  If boot from disk fails for some reason, the BIOS
-won't retry booting from other disk.  It can still try to boot from
-floppy or net, though.
+disk to be bootable, except for on s390x machines. If boot from disk fails for
+some reason, the BIOS won't retry booting from other disk.  It can still try to
+boot from floppy or net, though.  In the case of s390x, the BIOS will try up to
+8 total devices, any number of which may be disks.
 
 Sometimes, firmware cannot map the device path QEMU wants firmware to
 boot from to a boot method.  It doesn't happen for devices the firmware
diff --git a/docs/system/s390x/bootdevices.rst b/docs/system/s390x/bootdevices.rst
index 1a7a18b43b..f096e1cc06 100644
--- a/docs/system/s390x/bootdevices.rst
+++ b/docs/system/s390x/bootdevices.rst
@@ -6,9 +6,7 @@ Booting with bootindex parameter
 
 For classical mainframe guests (i.e. LPAR or z/VM installations), you always
 have to explicitly specify the disk where you want to boot from (or "IPL" from,
-in s390x-speak -- IPL means "Initial Program Load"). In particular, there can
-also be only one boot device according to the architecture specification, thus
-specifying multiple boot devices is not possible (yet).
+in s390x-speak -- IPL means "Initial Program Load").
 
 So for booting an s390x guest in QEMU, you should always mark the
 device where you want to boot from with the ``bootindex`` property, for
@@ -17,6 +15,11 @@ example::
  qemu-system-s390x -drive if=none,id=dr1,file=guest.qcow2 \
                    -device virtio-blk,drive=dr1,bootindex=1
 
+Multiple devices may have a bootindex. The lowest bootindex is assigned to the
+device to IPL first.  If the IPL fails for the first, the device with the second
+lowest bootindex will be tried and so on until IPL is successful or there are no
+remaining boot devices to try.
+
 For booting from a CD-ROM ISO image (which needs to include El-Torito boot
 information in order to be bootable), it is recommended to specify a ``scsi-cd``
 device, for example like this::
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index c977a52b50..de3d1f0d5a 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -43,6 +43,7 @@ typedef unsigned long long u64;
 #include "iplb.h"
 
 /* start.s */
+extern char _start[];
 void disabled_wait(void) __attribute__ ((__noreturn__));
 void consume_sclp_int(void);
 void consume_io_int(void);
@@ -88,6 +89,11 @@ __attribute__ ((__noreturn__))
 static inline void panic(const char *string)
 {
     sclp_print(string);
+    if (load_next_iplb()) {
+        sclp_print("\nTrying next boot device...");
+        jump_to_IPL_code((long)_start);
+    }
+
     disabled_wait();
 }
 
-- 
2.45.1

