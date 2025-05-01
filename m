Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E708C3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 18:37:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAYkm-00056J-1c; Thu, 01 May 2025 14:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alan.adamson@oracle.com>)
 id 1uAYki-00054h-ML; Thu, 01 May 2025 14:35:20 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alan.adamson@oracle.com>)
 id 1uAYkg-0007jV-LK; Thu, 01 May 2025 14:35:20 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541HtrlY002260;
 Thu, 1 May 2025 18:35:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=corp-2025-04-25; bh=LHharoMHmxsUWXauDkdcFjFbox8fa
 cOJsLCEfvBwxvM=; b=cjc/1fr5EIL+Q7BACiNopwCpnU9W8MM/Rbrc36CQMh7UZ
 91QeqKhigonblYrc1Xyzq6dAG3/iVzCRNhxEhEngBHMePkNoa7AFSPYlomTJyMyT
 IlXM93pg4i8YqnwhtycIN9mBekygsJwnUpUwK0Xo2YGJ+HLOseAXE6q/TEb8RdPJ
 zXJo0KUDJGxyqFhQF8VFcREfd0hIQJt0WVJE03E1UESJWrdDKqE8wc3symjHapz9
 NobqQfAkPF2feMo9euK4qvOO+vc8GrHImOzDMSY9pxGkcSWZfvdWrQFOuG1DhrJd
 ufH8Q53s9BdKaX0OOXEmssEtnCc9Qk2cGE5WI7SNA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6umbkqq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 01 May 2025 18:35:10 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 541INRZD023705; Thu, 1 May 2025 18:35:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 468nxk3vmk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 01 May 2025 18:35:09 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 541IZ9jW011241;
 Thu, 1 May 2025 18:35:09 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 468nxk3vm2-1; Thu, 01 May 2025 18:35:09 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: qemu-devel@nongnu.org
Cc: alan.adamson@oracle.com, foss@defmacro.it, kbusch@kernel.org,
 its@irrelevant.dk, qemu-block@nongnu.org
Subject: [PATCH v3 0/1] hw/nvme: CMIC.MCTRS should be set automatically for
 multi-controller subsystems or by parameter
Date: Thu,  1 May 2025 11:45:04 -0700
Message-ID: <20250501184505.3630283-1-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505010142
X-Authority-Analysis: v=2.4 cv=dfSA3WXe c=1 sm=1 tr=0 ts=6813bede b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=dt9VzEwgFbYA:10 a=bmEpc97xn6xAZHvFHbgA:9 cc=ntf awl=host:13130
X-Proofpoint-GUID: 2scnBPgWgsQKbe09kjCMWuwnB_2rrvDJ
X-Proofpoint-ORIG-GUID: 2scnBPgWgsQKbe09kjCMWuwnB_2rrvDJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDE0MSBTYWx0ZWRfX9HNz+WRYA1mG
 EQvmpf3yXPOzrw0Kva1EpzH/HQ5aQitAYT4xICDOpwJX6zzjLmNEPtk2GPDRUW5CowvM+IO6+Zq
 RGzh5Y1svctgjtnL06DAipY11cGK8tgRrE2XpZmc0cY2fncMz9oraehbLAt8Y5yMqKk4Q57oKvM
 acudYILOh/VcPg+Y5HKaDFfyblyuowXFmJa3cDExsZOSuOvt7WB0Mz6wHTz7JVHcpMgqdrOQgIH
 DOGg3jY2NxDAPOHAo0M5UvU1Lqb4o/X7wauWKEzDOGO+yriWDZKe5QWEafDz0KcXIFQB7jjMBiF
 HITnv6qyq0fhOUIWA4w4EHEf99EuC+yUQ/BhFK9e7DyQpIjut0G6fo0vNHCoiK0jwCZqyGk4ODd
 qhlWnNAQc5zhQrkmvDG3mfs+VAWUFkQMLWgDvXEGTdE6ycJiI8mqO1P/z/8dFjcZP95yYoDs
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alan.adamson@oracle.com; helo=mx0b-00069f02.pphosted.com
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

v3: - Sync up with v10.0

v2: - Change the parameter name from "cmic" to "cmic-mctrs".
    - If there is more than 1 controller in a subsystem, set CMIC.MCTRS
      for each controller whether or not the cmic-mctrs parameter is set.

While testing Linux atomic writes with qemu-nvme v10.0.0-rc1, Linux was
incorrectly displaying atomic_write_max_bytes
# cat /sys/block/nvme0n1/queue/atomic_write_max_bytes
0
# nvme id-ctrl /dev/nvme0n1 | grep awupf
awupf     : 15
#
Since AWUPF was set to 15, it was expected atomic_write_max_bytes would
be set to 8192.

The commit cd59f50ab017 ("hw/nvme: always initialize a subsystem")
introduced this behavior. The commit hardcodes the subsystem cmic bit
to ON which caused the Linux NVMe driver to treat the namespace as
multi-pathed which uncovered a bug with how Atomic Write Queue Limits
were being inherited.  This Linux issue is being addressed, but the
question was asked of why the subsystem CMIC.MCTRS bit was hardcoded to ON.
Most NVMe devices today don't set CMIC.MCTRS  to ON. Shouldn't the setting
of this bit be a settable parameter?


Proposal:

- The default setting of the CMIC.MCTRS bit will be OFF.

- If there is more than 1 controller detected in a subsystem, the CMIC.MCTRS
  bit will be set to ON for each controller in the subsystem.

- Create a subsystem specific parameter (cmic-mctrs) to specify CMIC.MCTRS
  in one controller subsystems.  This parameter does not affect
  multi-controller subsystems.

  <subsystem>,cmic-mctrs=BOOLEAN (default: off)

  Example:
    -device nvme-subsys,id=subsys0,cmic-mctrs=on \
    -device nvme,serial=deadbeef,id=nvme0,subsys=subsys0,atomic.dn=off,atomic.awun=31,atomic.awupf=15 \
    -drive id=ns1,file=/dev/nullb0,if=none \
    -device nvme-ns,drive=ns1,bus=nvme0,nsid=1,shared=false


Alan Adamson (1):
  hw/nvme: CMIC.MCTRS should be set automatically for multi-controller
    subsystems or by parameter

 hw/nvme/ctrl.c   | 15 ++++++++++++++-
 hw/nvme/nvme.h   |  2 ++
 hw/nvme/subsys.c |  1 +
 3 files changed, 17 insertions(+), 1 deletion(-)

-- 
2.43.5


