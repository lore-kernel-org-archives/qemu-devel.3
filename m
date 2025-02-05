Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D424BC02198
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 14:59:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfgrC-0007Z6-Hb; Wed, 05 Feb 2025 09:58:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1tfgrA-0007YY-Uu
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 09:58:24 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1tfgr8-0008Th-3V
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 09:58:24 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515DRQbv028418;
 Wed, 5 Feb 2025 14:58:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=corp-2023-11-20; bh=/n5lLnbRjCddVzIC9C6ZB1sLih7uz
 itheslnc5VXstQ=; b=F52RT/bpySzfTQ8uWW4GjRY6HANX3SkZuV48eVNoj/TSX
 kw8wyURaO2eC/LZXAOuaHI482Dl9QC1pw3RYiz+b0jDob8gmF83+aUTZ0oQHeElN
 av8rCKb8nQRrGvKOM4NxwxTsb5Yqliq+2DRn1HhRF6SJ3yB7hEf0xPy/EebZLJKK
 sMVHKHaBP+Jf3vcmix+GiTJplbeCci2gf7d0RAnM+4XeD8Fmmg1vxU0aRnCDg4Vl
 CnC7oSmokCOc4gnGw9hkaQzj8LoWSH39nQ4GAZS46zapjj4nkF6ODTmuczMC7LBW
 aH4A5bBwgO4urWYq5EBadjysTCB30uvTNzgJlxW5A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44kckxk7ed-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2025 14:58:18 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 515Eg0EN022807; Wed, 5 Feb 2025 14:58:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44j8e96be0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2025 14:58:17 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 515EwGh7022923;
 Wed, 5 Feb 2025 14:58:16 GMT
Received: from jonah-ol8.us.oracle.com (dhcp-10-65-182-246.vpn.oracle.com
 [10.65.182.246])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 44j8e96bbx-1; Wed, 05 Feb 2025 14:58:16 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: eperezma@redhat.com, mst@redhat.com, leiyang@redhat.com, peterx@redhat.com,
 dtatulea@nvidia.com, jasowang@redhat.com, si-wei.liu@oracle.com,
 boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Subject: [PATCH 0/4] Handling aliased guest memory maps in vhost-vDPA SVQs
Date: Wed,  5 Feb 2025 09:58:06 -0500
Message-ID: <20250205145813.394915-1-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_06,2025-02-05_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502050117
X-Proofpoint-GUID: fR7vlH7I4FWzIXVDJzoTPL_rPHEWJy_H
X-Proofpoint-ORIG-GUID: fR7vlH7I4FWzIXVDJzoTPL_rPHEWJy_H
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

An issue arises from aliased memory mappings in the guest, where
different GPAs map to the same HVA. For example:

 - GPA1->HVA1
 - GPA2->HVA1

When these mappings exist in the IOVA->HVA tree, a lookup by an HVA
backed by guest memory results in ambiguities because the same HVA could
correspond to multiple GPAs. This duplication causes issues in managing
IOVA trees for SVQs in vDPA, leading to incorrect behavior.

For example, consider these mapped guest memory regions:

              HVA                            GPA                         IOVA
-------------------------------  --------------------------- ----------------------------
[0x7f7903e00000, 0x7f7983e00000) [0x0, 0x80000000)           [0x1000, 0x80000000)
[0x7f7983e00000, 0x7f9903e00000) [0x100000000, 0x2080000000) [0x80001000, 0x2000001000)
[0x7f7903ea0000, 0x7f7903ec0000) [0xfeda0000, 0xfedc0000)    [0x2000001000, 0x2000021000)

The last HVA range [0x7f7903ea0000, 0x7f7903ec0000) is contained within
the first HVA range [0x7f7903e00000, 0x7f7983e00000). Despite this, the
GPA ranges for the first and third mappings do not overlap, so the guest
sees them as distinct physical memory regions.

Now consider an operation to unmap the mapping associated with HVA
0x7f7903eb0000. This HVA fits into both the first and third HVA ranges.

When searching the HVA->IOVA tree, the search stops at the first
matching HVA range [0x7f7903e00000, 0x7f7983e00000) due to the behavior
of the red-black tree (GTree). However, the correct mapping to remove is
the third mappings, as the HVA translate to GPA 0xfedb0000, which only
fits in the third mapping's GPA range.

To address this, we implement a GPA->IOVA tree and use the GPAs of
descriptors backed by guest memory when translating to IOVA.

When a descriptor's GPA is used for translation, the GPA->IOVA tree
ensures that each GPA maps to exactly one IOVA, regardless of any
overlapping HVAs. This guarantees that operations such as unmapping or
accessing a descriptor correctly targets the intended memory region in
the guest's address space.

For descriptors not backed by guest memory, the existing IOVA->HVA tree
is still used.

GPAs are unique and non-overlapping within the guest's address space. By
translating GPAs to IOVAs, the ambiguity caused by multiple GPAs mapping
to the same HVA is avoided.

--------
This series is a different approach of [1] and is based off of [2],
where this issue was originally discovered.

Patch v1:
---------
 * Created separate alloc functions for guest-backed and host-only
   memory.
 * Alloc functions also insert mappings to their respective trees.
 * Make patches self-contained and functional to prevent breakage during
   bisection.
 * Don't move range checks from alloc functions.
 * Use existing VirtQueueElement members 'in_addr' & 'out_addr' instead
   of creating custom 'in_xlat_addr' & 'out_xlat_addr' members.
 * Move documentation changes to separate patch.

RFC v3:
-------
 * Decouple the IOVA allocator to support a SVQ IOVA->HVA tree for
   host-only mappings.
 * Move range check for IOVA allocator to its own patch.
 * Implement a GPA->IOVA tree alongside the SVQ IOVA->HVA & IOVA-only
   trees.
 * Add in_xlat_addr & out_xlat_addr VirtQueueElement members to hold the
   GPAs of an element's input/output descriptors (to be used during
   translation).

RFC v2:
-------
 * Don't decouple IOVA allocator.
 * Build a IOVA->GPA tree (instead of GPA->IOVA tree).
 * Remove IOVA-only tree and keep the full IOVA->HVA tree.
 * Only search through RAMBlocks when we know the HVA is backed by
   guest memory.
 * Slight rewording of function names.

RFC v1:
-------
 * Alternative approach of [1].
 * First attempt to address this issue found in [2].

[1] https://lore.kernel.org/qemu-devel/20240410100345.389462-1-eperezma@redhat.com
[2] https://lore.kernel.org/qemu-devel/20240201180924.487579-1-eperezma@redhat.com

Jonah Palmer (4):
  vhost-iova-tree: Implement an IOVA-only tree
  vhost-iova-tree: Implement GPA->IOVA & partial IOVA->HVA trees
  svq: Support translations via GPAs in vhost_svq_translate_addr
  vhost-iova-tree: Update documentation

 hw/virtio/vhost-iova-tree.c        | 115 ++++++++++++++++++++++++-----
 hw/virtio/vhost-iova-tree.h        |   8 +-
 hw/virtio/vhost-shadow-virtqueue.c |  55 +++++++++-----
 hw/virtio/vhost-shadow-virtqueue.h |   5 +-
 hw/virtio/vhost-vdpa.c             |  40 ++++++----
 include/qemu/iova-tree.h           |  22 ++++++
 net/vhost-vdpa.c                   |  12 ++-
 util/iova-tree.c                   |  46 ++++++++++++
 8 files changed, 248 insertions(+), 55 deletions(-)

-- 
2.43.5


