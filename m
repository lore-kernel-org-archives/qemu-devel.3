Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBCC2C3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 21:53:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2zpX-00074j-11; Thu, 10 Apr 2025 17:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alan.adamson@oracle.com>)
 id 1u2zpR-00073J-ID; Thu, 10 Apr 2025 17:52:58 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alan.adamson@oracle.com>)
 id 1u2zpO-0002jR-BX; Thu, 10 Apr 2025 17:52:55 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53ALMVXZ025460;
 Thu, 10 Apr 2025 21:52:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=corp-2023-11-20; bh=HT6Ywn2oXJSuX12F9zf6foz7WAmFy
 PeNDmcqWDyko04=; b=EldeNEbRuX6QV4+ZJX+lBMq34MpTnj10iPGBp1u8FljQF
 5qonm6ogz7/DSi9PZRClFTwkc2S1qVOhtGCf8ZzQCadY3UnLWWHSNt2BTGenyEb5
 LtTTdhTsQ1OeWV5CtdFAxYG0I1cLidgY9oO7UKZbEgviOQsxukuKMh46Tkzi49mA
 Vy6eqPOaCh8sGdzZojXfyn+H0R1yH5VY6GoEWsM0XZb4AL/bRipr9LtRymdPHGY8
 M3veb3HI6fsOnnBHAy7+doLplii7siyjFzaqyqFY0lZnKU8NRYKJwJalqdK7LOLX
 00cuP31UeglpRwnKy+mVZc+ZGSqrgHckZ3r9f5IUg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45xnu9066k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Apr 2025 21:52:46 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53ALf5Z5013695; Thu, 10 Apr 2025 21:52:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 45ttyk6twh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Apr 2025 21:52:45 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53ALqjZq008077;
 Thu, 10 Apr 2025 21:52:45 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 45ttyk6tw6-1; Thu, 10 Apr 2025 21:52:45 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: qemu-devel@nongnu.org
Cc: alan.adamson@oracle.com, foss@defmacro.it, kbusch@kernel.org,
 its@irrelevant.dk, qemu-block@nongnu.org
Subject: [PATCH v2 0/1] hw/nvme: CMIC.MCTRS should be set automatically for
 multi-controller subsystems or by parameter
Date: Thu, 10 Apr 2025 15:02:36 -0700
Message-ID: <20250410220237.587858-1-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_06,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504100159
X-Proofpoint-GUID: uSUwH3cxb8FOx5sC8AgU0UTu7rI3faHQ
X-Proofpoint-ORIG-GUID: uSUwH3cxb8FOx5sC8AgU0UTu7rI3faHQ
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alan.adamson@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
of this bit be a settable paramter? 


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

-- 
2.43.5


