Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BDEEC83F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 12:43:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueCK7-0002Uv-HY; Tue, 22 Jul 2025 08:42:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1ueCJO-0002JA-8W
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 08:41:39 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1ueCJL-0006K4-DB
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 08:41:37 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M5TCk3031647;
 Tue, 22 Jul 2025 12:41:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=corp-2025-04-25; bh=SiUCTq2sDtERGyDvsyMh1YyOjA9Hw
 rC/0CHq+bpL5MI=; b=dF1O6FndNxntbZbg4/9oGUBjufn7Wk++wY1tyL0Rl4IjE
 hriAG+VVbpKf1kVAqzMOQzuo7bZe5FYSxs/oBx4JLOIJdtQ9FHrSKRiHMFAQdaIY
 5RMCuuKs6M+iKJcGW+jBqtV4jba2o3HODTIDZZUaCRFoIen1MrWUJaRuyrAnnJ6d
 QwqUSqqskMWJGVEIqffNU7SYDgP9U2YDqXUTvqfs7SeOEq2Z6PQyJCAKewhdk15z
 l0wY6CfMSH+KvIsAVF6UerJI8ovdbf1Kah0fbm4iYF0OlaF5UOMDAVPF/wJMOdbV
 lbC64glrWzLYs0q5fYCp19YTgsbY4VpvZLb11LNeQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 480576n1d9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Jul 2025 12:41:31 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56MCFGa7010247; Tue, 22 Jul 2025 12:41:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4801t99ga4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Jul 2025 12:41:30 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56MCfT3n039536;
 Tue, 22 Jul 2025 12:41:29 GMT
Received: from jonah-amd-ol9-bm.osdevelopmeniad.oraclevcn.com
 (jonah-amd-ol9-bm.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.252.67])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 4801t99g9h-1; Tue, 22 Jul 2025 12:41:29 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com, 
 jasowang@redhat.com, mst@redhat.com, si-wei.liu@oracle.com,
 eperezma@redhat.com, boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Subject: [RFC 0/6] virtio-net: initial iterative live migration support
Date: Tue, 22 Jul 2025 12:41:21 +0000
Message-ID: <20250722124127.2497406-1-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507220104
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDEwNCBTYWx0ZWRfXyqI+WZG+vOHs
 zk8CNjtV2+bdiw9CDEj+A+9pzhPzhgckfXpz4xYP4BrBa01wEGnSaxZVNYX+Fhg+21PK+nuNw8Y
 GQep/aIaumH86W6jkAEFT5eW/wfFqShzdRSmR0oMsMNO0LlEbhyhf8omo1DxgadiMxsDby893KT
 hTuBLsoV8C55dtB3qxgRQ2960VHpULAvrvg/EVa76/Jl3oW70MXmJ1DbaNFOTa/43qJIveRdK60
 FVv+qkRBIWOqf/exZ6dLjOgSqxV1glX76ItmuarOPe7beAZ+fV50iDGLS7sX7vrvpYMQiH7V59P
 wpGNCf1DZQywmv3we3IdYnn0A2xO4rnDGbHL7PRg8B4v+XRJQZN9sG29/fnpzIRfIAygoXMh1KJ
 6Hgwo8fEx+tZS6Z5DvtqBbjggfBqgTKpuiYW7h0VDiRYA2TLroSacJ+BEoBcBaCUBob37Lr+
X-Authority-Analysis: v=2.4 cv=doDbC0g4 c=1 sm=1 tr=0 ts=687f86fb cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=Wb1JkmetP80A:10 a=QJ7LjP0NDpSce9unQJYA:9
X-Proofpoint-GUID: 6OEgey6YkgWRiqCR1F6wcVYp9XI4nnJQ
X-Proofpoint-ORIG-GUID: 6OEgey6YkgWRiqCR1F6wcVYp9XI4nnJQ
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

This series is an RFC initial implementation of iterative live
migration for virtio-net devices.

The main motivation behind implementing iterative migration for
virtio-net devices is to start on heavy, time-consuming operations
for the destination while the source is still active (i.e. before
the stop-and-copy phase).

The motivation behind this RFC series specifically is to provide an
initial framework for such an implementation and get feedback on the
design and direction.
-------

This implementation of iterative live migration for a virtio-net device
is enabled via setting the migration capability 'virtio-iterative' to
on for both the source & destination, e.g. (HMP):

(qemu) migrate_set_capability virtio-iterative on

The virtio-net device's SaveVMHandlers hooks are registered/unregistered
during the device's realize/unrealize phase.

Currently, this series only sends and loads the vmstate at the start of
migration. The vmstate is still sent (again) during the stop-and-copy
phase, as it is today, to handle any deltas in the state since it was
initially sent. A future patch in this series could avoid having to
re-send and re-load the entire state again and instead focus only on the
deltas.

There is a slight, modest improvement in guest-visible downtime from
this series. More specifically, when using iterative live migration with
a virtio-net device, the downtime contributed by migrating a virtio-net
device decreased from ~3.2ms to ~1.4ms on average:

Before:
-------
vmstate_downtime_load type=non-iterable idstr=0000:00:03.0/virtio-net
  instance_id=0 downtime=3594

After:
------
vmstate_downtime_load type=non-iterable idstr=0000:00:03.0/virtio-net
  instance_id=0 downtime=1607

This slight improvement is likely due to the initial vmstate_load_state
call "warming up" pages in memory such that, when it's called a second
time during the stop-and-copy phase, allocation and page-fault latencies
are reduced.
-------

Comments, suggestions, etc. are welcome here.

Jonah Palmer (6):
  migration: Add virtio-iterative capability
  virtio-net: Reorder vmstate_virtio_net and helpers
  virtio-net: Add SaveVMHandlers for iterative migration
  virtio-net: iter live migration - migrate vmstate
  virtio,virtio-net: skip consistency check in virtio_load for iterative
    migration
  virtio-net: skip vhost_started assertion during iterative migration

 hw/net/virtio-net.c            | 246 +++++++++++++++++++++++++++------
 hw/virtio/virtio.c             |  32 +++--
 include/hw/virtio/virtio-net.h |   8 ++
 include/hw/virtio/virtio.h     |   7 +
 migration/savevm.c             |   1 +
 qapi/migration.json            |   7 +-
 6 files changed, 247 insertions(+), 54 deletions(-)

-- 
2.47.1


