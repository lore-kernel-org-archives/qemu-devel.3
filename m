Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A90C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 12:56:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgksj-0003rt-IO; Wed, 21 Aug 2024 08:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1sgksb-0003jB-8N
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 08:56:01 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1sgksW-0004yj-R6
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 08:55:58 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47LBtUT2012222;
 Wed, 21 Aug 2024 12:55:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=corp-2023-11-20; bh=oYHc0wo4VsroPM
 0U1RmaQspQu5CjBFclup9VoEuJ8yw=; b=J3wU73RH04uu8GfkFZoicmSX/g3bQV
 XhqqQ7zFisKEKNmb/OP/301wu1DBqzpRB5DaHZCID7CFBTGt5z8fXQUREJwU4vLN
 rFY/IMYvaRt1nsDstuwH/+ZyQ1hSdwqoTJFy+3Qvb07FgF5aC2/bbcnk2sUpy8zG
 bSLSvbS0nZd5SJqpVHONWuow3piPUedqOysFuisoocvlQmEAlqbFyVFaAUt8ZYWH
 F67hvNHTTo1M6Ee4ZJaFkhN9RTtt4HXbKFZlf4w/eiilp9WtOYNxu5u3qrmddDo8
 XKFszo2cKLJtf4kXCdiBGmaWqgtlUn/RlIjyFFFOqDVMsfZgIG5NYP3g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m6gfg0h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Aug 2024 12:55:52 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 47LBNxES011300; Wed, 21 Aug 2024 12:55:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 415fb23m5s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Aug 2024 12:55:52 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47LCtpoO002465;
 Wed, 21 Aug 2024 12:55:51 GMT
Received: from jonah-ol8.us.oracle.com (dhcp-10-39-201-48.vpn.oracle.com
 [10.39.201.48])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 415fb23m55-1; Wed, 21 Aug 2024 12:55:51 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: eperezma@redhat.com, mst@redhat.com, leiyang@redhat.com, peterx@redhat.com,
 dtatulea@nvidia.com, jasowang@redhat.com, si-wei.liu@oracle.com,
 boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Subject: [RFC 0/2] Handling aliased guest memory maps in vhost-vDPA SVQs
Date: Wed, 21 Aug 2024 08:55:44 -0400
Message-ID: <20240821125548.749143-1-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_09,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 adultscore=0
 suspectscore=0 spamscore=0 mlxlogscore=936 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408210094
X-Proofpoint-ORIG-GUID: PP4Nwvw0qKRnxvrW4wUOvewYiiPGucUm
X-Proofpoint-GUID: PP4Nwvw0qKRnxvrW4wUOvewYiiPGucUm
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
--------

To avoid this issue, we can create a GPA->IOVA tree for guest memory
mappings and use the GPA to find the correct IOVA translation, as GPAs
wont overlap and will always translate to the correct IOVA.

To accommodate this solution, we decouple the IOVA allocator, where all
allocated IOVA ranges are stored in an IOVA-only tree (iova_map), and
split the current IOVA->HVA tree into a GPA->IOVA tree (guest memory)
and a IOVA->SVQ HVA tree (host-only memory). In other words, any
allocated IOVA ranges are stored in an IOVA-only tree, any guest memory
mappings are placed inside of the GPA->IOVA tree, and lastly any
host-only memory mappings are stored in the IOVA->SVQ HVA tree.

--------
This series is a different approach of [1] and is based off of [2],
where this issue was originally discovered.

RFC v1:
-------
 * Alternative approach of [1].
 * First attempt to address this issue found in [2].

[1] https://lore.kernel.org/qemu-devel/20240410100345.389462-1-eperezma@redhat.com
[2] https://lore.kernel.org/qemu-devel/20240201180924.487579-1-eperezma@redhat.com

Jonah Palmer (2):
  vhost-vdpa: Decouple the IOVA allocator
  vhost-vdpa: Implement GPA->IOVA & IOVA->SVQ HVA trees

 hw/virtio/vhost-iova-tree.c        | 91 ++++++++++++++++++++++++++++--
 hw/virtio/vhost-iova-tree.h        |  6 +-
 hw/virtio/vhost-shadow-virtqueue.c | 48 +++++++++++++---
 hw/virtio/vhost-vdpa.c             | 43 +++++++++-----
 include/qemu/iova-tree.h           | 22 ++++++++
 net/vhost-vdpa.c                   | 13 ++++-
 util/iova-tree.c                   | 46 +++++++++++++++
 7 files changed, 240 insertions(+), 29 deletions(-)

-- 
2.43.5


