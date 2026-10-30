Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A50606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 00:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=hC8kIB1g
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMadn-0004ZV-A7; Thu, 29 Oct 2026 20:38:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1xMadk-0004Yt-Mt
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 20:38:40 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1xMadW-0003cf-Qb
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 20:38:33 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TLZ2hf2257220; Fri, 30 Oct 2026 00:38:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=corp-2025-04-25; bh=NPZUh4nbiEkDGcK1gsiE2Vm4vZNBh
 rSy8CJAjKz0V1s=; b=hC8kIB1gNtSrMGfOmFhOXewRquwgGfzvaJekZs40WeZmB
 SY8YZVqPf4E2umInnpe2c1Jyxx+m20isxdaX2ZtVEc3nL422WCg3sZD9bnM3c+4R
 VNDJ1CDX7n1kAEAdQMb6YO5wCd+fYvpUk1FTOjj0/TStv4lytS/lwl2CKL0dIhn2
 8kInxe006UBLCBJlWyZa0vL7RW1kO0S+5R+JTBsrRJ5JMy6x4pMRj/4N9Lovv9BQ
 1KCMk4enysX3T2ZiC+/kwiCYmfHzzZXBbwz2Q16Iz4QBiT5zihGVkJsXD8cEPrcV
 56aKwaCqIotv0V/PYHJzW5uZvzePPWEpg+VmN2UiQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hme61r42e-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
 Fri, 30 Oct 2026 00:38:18 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11)
 with ESMTP id 69TNgCf42004316; Fri, 30 Oct 2026 00:38:18 GMT
Received: from alaljime-e5-test-20240903-1847.osdevelopmeniad.oraclevcn.com
 (alaljime-e5-test-20240903-1847.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.250.206])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 4hmg231tmh-1; Fri, 30 Oct 2026 00:38:18 +0000 (GMT)
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: mst@redhat.com, dongli.zhang@oracle.com
Cc: qemu-devel@nongnu.org, sarunkod@amd.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, joe.jin@oracle.com,
 alejandro.j.jimenez@oracle.com
Subject: [PATCH v3 0/5] amd_iommu: Bugfix and Cleanup for IO Page Fault
Date: Fri, 30 Oct 2026 00:38:12 +0000
Message-ID: <20261030003817.3521476-1-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2610190000 definitions=main-2610300001
X-Authority-Analysis: v=2.4 cv=L9qI0OT8 c=1 sm=1 tr=0 ts=6ae3e6fa b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=NEAV23lmAAAA:8
 a=3WaX2tH2aqYjHfAcjo4A:9 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-GUID: qDG2yB9K6PFYHS7LioBhGGGqp415mjur
X-Proofpoint-ORIG-GUID: qDG2yB9K6PFYHS7LioBhGGGqp415mjur
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAwMSBTYWx0ZWRfX55qCKP7pw2Eh
 63rBqnXFBoQZ5P9mBSfdxhHTcnX1kBTgp8NPkecLy3qPm8Hp0d20aLGdxQDP3rfa8T7Q5OBZFd5
 zIgTghp0T0+5AKjdIqyla7O98vJlEDApyJkbx8C/dfw+7GzPHO1qcMeSxrCmOyGp3ufqHvaj4Kz
 WtJIQpGNQ7moIhjFjFfvJTVOpvfYcZYYR7pOUguTpSqia1Ud79j/Zcs8n8Ur4AtKk6UcUa0YdO9
 RC6fl+KUzSCuK7IjoRZWZdMrepiWM7qCLd4IW/jMI72JEDSWt5JEVmm8UcNMfVqmLkyvOM1tS4G
 jOqFq8W8AGBmFK8KAkIA0llC05Adf0JkjtGmbHhB9LzFdYXZWZreFF2pFHtvg8nmDI8cHpXKTTE
 b5V0AE8zz1xb+FfzCwokDrHL2MdkHwIi6Asc4e08jkBluhSVaHxT1acMCYm6CJSuEEUV4RO+/IM
 14UuiFMVX38Ywi3K1zg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAwMSBTYWx0ZWRfXz3tPdoOV2ord
 4bUrSV5p0NcDeg/B9a/oPKQbg8zJUjWF8JoYN3hAM/lpDBYXZu+zWoGpSzSz4UoEQreifDBHFPp
 0/ecJ4WFbnnnYYxg4I+ArNThjqpDBXfvACM9PnziI20zlmQK+XS3
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 KHOP_DYNAMIC=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Michael,

I am re-sending Dongli's series after reviewing and addressing the comments from
his earlier v2 submission:
v2: https://lore.kernel.org/qemu-devel/20260724223216.108667-1-dongli.zhang@oracle.com/

The series has been rebased on top of:
b574eaf640f0 ("Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging")

Please queue it for your next pull request, whenever it is convenient.

Also available at:
https://github.com/aljimenezb/qemu/commits/amdvi-dongli-fixes-2026/

Changes since v2:
 - Rebased onto b574eaf640f0.
 - Patch 3: Applied suffix LOG for consistent EVTLOG/PPRLOG/GALOG naming, updated
the existing macros and all their call sites. I preferred the use of LOG since
GA by itself is generally used to refer to Guest Virtual APIC support in the docs.
 - Patch 4: Minor change in commit message, code unchanged from v2.
 - Patch 5: added GALOG_RUN to the RO mask [Sairaj].
 - Added Reviewed-by and Signed-off trailers as appropriate.

Thank you Dongli and Sairaj for your work on these fixes. Please let me know if
I missed any of your proposed changes.

Thank you.
Alejandro

Dongli Zhang (5):
  amd_iommu: Do not create duplicate MSI capability
  amd_iommu: Use full BDF when reporting page faults
  amd_iommu: Define MMIO register masks
  amd_iommu: Make extended feature register read-only
  amd_iommu: Do not latch unsupported GA log status bits

 hw/i386/amd_iommu.c | 47 +++++++++++++++++++++++++++------------------
 hw/i386/amd_iommu.h | 25 ++++++++++++++++++++----
 2 files changed, 49 insertions(+), 23 deletions(-)


base-commit: b574eaf640f02c4edf28cbee6417378f0d79cda0
-- 
2.47.3


