Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C98ECFA776
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 12:45:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swhg0-0004Vu-Uj; Fri, 04 Oct 2024 08:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1swhfz-0004Vc-Lr
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 08:44:55 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1swhfx-0005EQ-Ss
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 08:44:55 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494CMX5s026710;
 Fri, 4 Oct 2024 12:44:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=corp-2023-11-20; bh=ZRvDUFA2jmi6uR
 QiaHXn3nIiJrvVTTmwCd4QFgfHhwo=; b=Yz86ICTktFi3X+dPJ02EwHeHr9MBoL
 Mbuoj2iV9kSbx7fvYPTV7IERsC109ulOEWyt32+ivQUtB8PO8YbtpQnRtQ30GTX4
 hejZrsTg+WP+lSU4ZoRnfUUY6jHoGG/6ivuXLHwQQhpgQZegD3epIiQXx2B8k8J9
 +8jnlFHOFmbl3twza+t+nTihGZLDVkMCiu00j+kxGXOoInPlf5WGVS/OQQm50mOR
 DTewJmPUt5PZqI8nUHVPnAZaWQi5/NHXOekCR/OVzyGpWAi8TpAwH6h760pZgdDM
 Fo8enTvArhAeR42xSRShRyhEooR1rhBuf30C0Mb+p7N7lhVZD9ZHcQsQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4220489htq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 04 Oct 2024 12:44:49 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 494BS14I005858; Fri, 4 Oct 2024 12:44:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 422056fcf1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 04 Oct 2024 12:44:48 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 494Cimo2020535;
 Fri, 4 Oct 2024 12:44:48 GMT
Received: from jonah-ol8.us.oracle.com (dhcp-10-65-167-128.vpn.oracle.com
 [10.65.167.128])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 422056fce8-1; Fri, 04 Oct 2024 12:44:48 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: eperezma@redhat.com, mst@redhat.com, leiyang@redhat.com, peterx@redhat.com,
 dtatulea@nvidia.com, jasowang@redhat.com, si-wei.liu@oracle.com,
 boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Subject: [RFC v2 0/2] Handling aliased guest memory maps in vhost-vDPA SVQs
Date: Fri,  4 Oct 2024 08:44:40 -0400
Message-ID: <20241004124445.3802090-1-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_10,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=832
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410040093
X-Proofpoint-ORIG-GUID: vJYRizNJyVWOBzGThD2n1hpfvxcLkLmW
X-Proofpoint-GUID: vJYRizNJyVWOBzGThD2n1hpfvxcLkLmW
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The guest may overlap guest memory regions when mapping IOVA to HVA
translations in the IOVA->HVA tree. This means that different HVAs, that
correspond to different guest memory region mappings, may translate to
the same IOVA. This can cause conflicts when a mapping is incorrectly
referenced.

For example, consider this example of mapped guest memory regions:

              HVA                            GPA                         IOVA
-------------------------------  --------------------------- ----------------------------
[0x7f7903e00000, 0x7f7983e00000) [0x0, 0x80000000)           [0x1000, 0x80000000)
[0x7f7983e00000, 0x7f9903e00000) [0x100000000, 0x2080000000) [0x80001000, 0x2000001000)
[0x7f7903ea0000, 0x7f7903ec0000) [0xfeda0000, 0xfedc0000)    [0x2000001000, 0x2000021000)

The last HVA range [0x7f7903ea0000, 0x7f7903ec0000) is contained within
the first HVA range [0x7f7903e00000, 0x7f7983e00000). Despite this, the
GPA ranges for the first and third mappings don't overlap, so the guest
sees them as different physical memory regions.

So, for example, say we're given an HVA of 0x7f7903eb0000 when we go to
unmap the mapping associated with this address. This HVA technically
fits in the first and third mapped HVA ranges.

When we go to search the IOVA->HVA tree, we'll stop at the first mapping
whose HVA range accommodates our given HVA. Given that IOVATrees are
GTrees which are balanced binary red-black trees, the search will stop
at the first mapping, which has an HVA range of [0x7f7903e00000,
0x7f7983e00000).

However, the correct mapping to remove in this case is the third mapping
because the HVA to GPA translation would result in a GPA of 0xfedb0000,
which only fits in the third mapping's GPA range.

To avoid this issue, we can create a IOVA->GPA tree for guest memory
mappings and use the GPA to find the correct IOVA translation, as GPAs
wont overlap and will always translate to the correct IOVA.

--------
This series is a different approach of [1] and is based off of [2],
where this issue was originally discovered.

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


Jonah Palmer (2):
  vhost-vdpa: Implement IOVA->GPA tree
  vhost-svq: Translate guest-backed memory with IOVA->GPA tree

 hw/virtio/vhost-iova-tree.c        | 78 ++++++++++++++++++++++++++++--
 hw/virtio/vhost-iova-tree.h        |  5 ++
 hw/virtio/vhost-shadow-virtqueue.c | 61 ++++++++++++++++++-----
 hw/virtio/vhost-vdpa.c             | 20 +++++---
 4 files changed, 141 insertions(+), 23 deletions(-)

-- 
2.43.5


