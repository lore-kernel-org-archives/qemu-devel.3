Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D3DD3C912
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2024 01:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2Klp-0008OO-S3; Sat, 19 Oct 2024 21:30:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1t2Kln-0008NM-Ul; Sat, 19 Oct 2024 21:30:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1t2Klm-0005OL-07; Sat, 19 Oct 2024 21:30:11 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49JLldSN000320;
 Sun, 20 Oct 2024 01:30:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=3baPwsJ4d9/44iWyL
 E2uKRwn3a4yRi/xHKhWUigxytk=; b=Ku7eyp2jkpOPnnQ7xB6XCs6LQLeoPX+NG
 QRouuTvrzah4+QoRSAB+VtGVV8PVwHAOahvvaMvXMQZ++u+dQzsq7w3Fv79HBa5q
 TKP3DB3g+blXR4JJ6PACDMKElpYMFa4AmHZxps4bVvGIpXwHvwM0Jm7aAs3tp3jK
 SdvxE69KCvW8ddchVZm8NghL+uyzbIrZLcOY4gxpdjn4wNyhRB6ouOxWpHmL+E74
 3EYnMJ3QW3tmFNdV6S6+p/TdADuW1KxmNqOykk5HTVWVHEQnzTJQrtihRo0Pd47b
 Ua8RBKaf9RXlW2i0Qd6HsW76ueiICnAHtX+5/eu0NZJ+AtwzRdpoA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42c5h2u6hw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 20 Oct 2024 01:30:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49K1LVR4005946;
 Sun, 20 Oct 2024 01:30:07 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 428651k9he-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 20 Oct 2024 01:30:07 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49K1U6jb46465410
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 20 Oct 2024 01:30:06 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 305F45805F;
 Sun, 20 Oct 2024 01:30:06 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8197D5805A;
 Sun, 20 Oct 2024 01:30:05 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.54.50])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 20 Oct 2024 01:30:05 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: frankja@linux.ibm.com, jrossi@linux.ibm.com
Subject: [PATCH v5 06/19] docs/system/s390x/bootdevices: Update the
 documentation about network booting
Date: Sat, 19 Oct 2024 21:29:40 -0400
Message-ID: <20241020012953.1380075-7-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241020012953.1380075-1-jrossi@linux.ibm.com>
References: <20241020012953.1380075-1-jrossi@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cCRNL62IssOueBBfT4jDAaTPhXoM2cek
X-Proofpoint-ORIG-GUID: cCRNL62IssOueBBfT4jDAaTPhXoM2cek
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=948
 adultscore=0 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410200009
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


