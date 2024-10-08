Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C144ACED24E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 01:24:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxyq3-0004Ek-Mp; Mon, 07 Oct 2024 21:16:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1sxypi-00045S-V4; Mon, 07 Oct 2024 21:16:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1sxype-0008HD-4a; Mon, 07 Oct 2024 21:16:14 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4980o7ZY008625;
 Tue, 8 Oct 2024 01:16:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:mime-version; s=pp1; bh=3baPwsJ4d9/44
 iWyLE2uKRwn3a4yRi/xHKhWUigxytk=; b=Rnr6vXLSNLgI2KWaLdoej6tHr6GwV
 ZwjuVndyZvZobRowEPZQSGJF/B30l40/VmfMLRbnIVhNUoP+/fIM/5vr9pT+y0TD
 lYsZoSaX5Dw78V4XzrDK8PrOYkIGUQsyKkf5qtgCpj4iB+EGwRNash5B+Ap87Hom
 MZ69yy5kIi/jTCHBkc4th65VG6UsIvUWkfiRgw9R+nBwgtkUwUbWBZaP4jTEfWnk
 3mUx0pA0Vu8E57yS9idk0tPuMR7PsoRC7T4BKib1vvLFTOS4Vh9XZNMb4nny3kGN
 v3mzNLMXVYTYni03wj74hDg93WQkIDouIwhQNIlm02fNgqzgL1x+PoslA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424thq02k0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Oct 2024 01:16:08 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4981G866026875;
 Tue, 8 Oct 2024 01:16:08 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424thq02jv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Oct 2024 01:16:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 497MEwQE010727;
 Tue, 8 Oct 2024 01:16:07 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 423j0j9ba5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Oct 2024 01:16:07 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4981G51N48038364
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Oct 2024 01:16:06 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9C9D258055;
 Tue,  8 Oct 2024 01:16:05 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 250A95805D;
 Tue,  8 Oct 2024 01:16:05 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.51.58])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  8 Oct 2024 01:16:05 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: frankja@linux.ibm.com, jrossi@linux.ibm.com
Subject: [PATCH v3 06/19] docs/system/s390x/bootdevices: Update the
 documentation about network booting
Date: Mon,  7 Oct 2024 21:15:39 -0400
Message-ID: <20241008011552.2645520-7-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241008011552.2645520-1-jrossi@linux.ibm.com>
References: <20241008011552.2645520-1-jrossi@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gvifKiS6IWwDdpVnhV4FqZqURrkHYdd8
X-Proofpoint-GUID: uh9FDgf2pI6dKlSjAXK2Nr_rrxfl6urq
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_16,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 mlxlogscore=923 bulkscore=0 clxscore=1015 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410080006
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

Remove the information about the separate s390-netboot.img from
the documentation.

Co-authored by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 docs/system/s390x/bootdevices.rst | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/docs/system/s390x/bootdevices.rst b/docs/system/s390x/bootdevices.rst
index 1a7a18b43b..c97efb8fc0 100644
--- a/docs/system/s390x/bootdevices.rst
+++ b/docs/system/s390x/bootdevices.rst
@@ -82,23 +82,17 @@ Note that ``0`` can be used to boot the default entry.
 Booting from a network device
 -----------------------------
 
-Beside the normal guest firmware (which is loaded from the file ``s390-ccw.img``
-in the data directory of QEMU, or via the ``-bios`` option), QEMU ships with
-a small TFTP network bootloader firmware for virtio-net-ccw devices, too. This
-firmware is loaded from a file called ``s390-netboot.img`` in the QEMU data
-directory. In case you want to load it from a different filename instead,
-you can specify it via the ``-global s390-ipl.netboot_fw=filename``
-command line option.
-
-The ``bootindex`` property is especially important for booting via the network.
-If you don't specify the ``bootindex`` property here, the network bootloader
-firmware code won't get loaded into the guest memory so that the network boot
-will fail. For a successful network boot, try something like this::
+The firmware that ships with QEMU includes a small TFTP network bootloader
+for virtio-net-ccw devices.  The ``bootindex`` property is especially
+important for booting via the network. If you don't specify the ``bootindex``
+property here, the network bootloader won't be taken into consideration and
+the network boot will fail. For a successful network boot, try something
+like this::
 
  qemu-system-s390x -netdev user,id=n1,tftp=...,bootfile=... \
                    -device virtio-net-ccw,netdev=n1,bootindex=1
 
-The network bootloader firmware also has basic support for pxelinux.cfg-style
+The network bootloader also has basic support for pxelinux.cfg-style
 configuration files. See the `PXELINUX Configuration page
 <https://wiki.syslinux.org/wiki/index.php?title=PXELINUX#Configuration>`__
 for details how to set up the configuration file on your TFTP server.
-- 
2.45.1


