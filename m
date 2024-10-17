Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C15D2F7DE
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 02:08:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1Fvk-0008QV-O0; Wed, 16 Oct 2024 22:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1t1Fvi-0008OF-Lr; Wed, 16 Oct 2024 22:07:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1t1Fvg-0005eo-4O; Wed, 16 Oct 2024 22:07:58 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GLR3Nf000412;
 Thu, 17 Oct 2024 02:07:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=ndeaX6PMgLY5SeP7Y
 RmQTgpwbgI8Ev7vjODAIIffpNE=; b=MXbvlq/2tSy+Oi5MaKpSV1sW3iHM4RsR4
 oERHccKyi5EhE8FLatkOwR/tfUHVYBqyW6kWsJ9bXez12nyqsfidqvHsOZ6cXDH0
 MmeWR2kYTpZq3W3Id2pw0AChsktAdmzU75rWYJH0l4wHcxW94D03Jm5JnwftXvK5
 xtYHcmCPdDoflnYqRJPrHhNvtf9ao17tl+3TXHKnSU7vIgvRI/8XcGaStdy3F2HZ
 LEH32YVuWSxeNKiCoxaOCAejYNOgOXOYyqHZU8/Oj+tXmYOBWLwf2aoAMuWn63GO
 pHzn2ygnSTkOyxmglfVoiFz7cDGBMQ/cfea/+G8NZ84jLkZOLyjtw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42and7gtm3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Oct 2024 02:07:53 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49H27qGp015993;
 Thu, 17 Oct 2024 02:07:52 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42and7gtkw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Oct 2024 02:07:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49GLlGq4005215;
 Thu, 17 Oct 2024 01:48:17 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4285njc3vq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Oct 2024 01:48:17 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49H1mFef14287438
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Oct 2024 01:48:15 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6C45558056;
 Thu, 17 Oct 2024 01:48:15 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E564858052;
 Thu, 17 Oct 2024 01:48:14 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.153.16])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 17 Oct 2024 01:48:14 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: frankja@linux.ibm.com, jrossi@linux.ibm.com
Subject: [PATCH v4 18/19] docs/system: Update documentation for s390x IPL
Date: Wed, 16 Oct 2024 21:47:47 -0400
Message-ID: <20241017014748.829029-19-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241017014748.829029-1-jrossi@linux.ibm.com>
References: <20241017014748.829029-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5IuuVtoKtBnR5moL3cXVOMyNcqXPgY5x
X-Proofpoint-ORIG-GUID: uwhukN1urjbQ_R-CEw6AeKEOHylF2Jsa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=809 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410170011
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Jared Rossi <jrossi@linux.ibm.com>

Update docs to show that s390x PC BIOS can support more than one boot device.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
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


