Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE3C3CED24F
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 01:23:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxyq4-0004F3-7e; Mon, 07 Oct 2024 21:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1sxypw-0004Ah-Tz; Mon, 07 Oct 2024 21:16:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1sxypt-0008Mc-7f; Mon, 07 Oct 2024 21:16:27 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497Nt6Oh026136;
 Tue, 8 Oct 2024 01:16:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=kF5dPfxF8Y8gE
 NUt8C3/z/Ntb9QSp63LYS6fH7P+zvM=; b=SJ57YM0+Zq4P65nknYchi+NtPLa7V
 MEtt2IQoYsTBR8nlhSTolgiC84OXH4J+dnA1V0nd2/b/MQS5kmWlXtqGu6TzUi1e
 gCq3QwtP2w900sZAD6SlXWEglw0QwVDTc0P4C93hSLXhn0URiTozj1gdnwILnjqh
 Dkve3QA2/BlkWPRy9FWzEJzsjl9MukjyredWOtfnr4NA2725x/ocIxxYsUlwK87i
 fAOAmRrhu6FAYJXQTl4f9TYEwxByqEssQWTizHVzBFqQHPXFUoQso5OnvzqCUtmy
 0QpLnf4nbUyE6OKhZev3nahuktUxjLJYRcL0RsjwTKWyZ9n0v7z4VjQmw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424sr4g7hx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Oct 2024 01:16:23 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4981GMNv017880;
 Tue, 8 Oct 2024 01:16:22 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424sr4g7hv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Oct 2024 01:16:22 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 497NC6u3022840;
 Tue, 8 Oct 2024 01:16:21 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 423jg0s7pm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Oct 2024 01:16:21 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4981GKPs24969830
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Oct 2024 01:16:20 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A1B258043;
 Tue,  8 Oct 2024 01:16:20 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A9F7A58055;
 Tue,  8 Oct 2024 01:16:19 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.51.58])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  8 Oct 2024 01:16:19 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: frankja@linux.ibm.com, jrossi@linux.ibm.com
Subject: [PATCH v3 18/19] docs/system: Update documentation for s390x IPL
Date: Mon,  7 Oct 2024 21:15:51 -0400
Message-ID: <20241008011552.2645520-19-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241008011552.2645520-1-jrossi@linux.ibm.com>
References: <20241008011552.2645520-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -uNYwC_waoNLXv66RvApjIu-ukA9TllH
X-Proofpoint-GUID: NBP6MlgOsOiYyGrsSHhAmaIWt8UCo5Ol
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_16,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=756 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410080003
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Jared Rossi <jrossi@linux.ibm.com>

Update docs to show that s390x PC BIOS can support more than one boot device.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 docs/system/bootindex.rst         | 7 ++++---
 docs/system/s390x/bootdevices.rst | 9 ++++++---
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/docs/system/bootindex.rst b/docs/system/bootindex.rst
index 8b057f812f..988f7b3beb 100644
--- a/docs/system/bootindex.rst
+++ b/docs/system/bootindex.rst
@@ -49,10 +49,11 @@ Limitations
 -----------
 
 Some firmware has limitations on which devices can be considered for
-booting.  For instance, the PC BIOS boot specification allows only one
-disk to be bootable.  If boot from disk fails for some reason, the BIOS
+booting.  For instance, the x86 PC BIOS boot specification allows only one
+disk to be bootable.  If boot from disk fails for some reason, the x86 BIOS
 won't retry booting from other disk.  It can still try to boot from
-floppy or net, though.
+floppy or net, though. In the case of s390x BIOS, the BIOS will try up to
+8 total devices, any number of which may be disks.
 
 Sometimes, firmware cannot map the device path QEMU wants firmware to
 boot from to a boot method.  It doesn't happen for devices the firmware
diff --git a/docs/system/s390x/bootdevices.rst b/docs/system/s390x/bootdevices.rst
index c97efb8fc0..1a1a764c1c 100644
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
-- 
2.45.1


