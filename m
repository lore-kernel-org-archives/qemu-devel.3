Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D061098788
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 14:22:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3aia-0002yR-Rv; Fri, 20 Mar 2026 10:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1w3aiW-0002wN-0n
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 10:20:48 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1w3aiS-0007Q6-Id
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 10:20:47 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62K8Y3OG3323029; Fri, 20 Mar 2026 14:20:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=corp-2025-04-25; bh=G2T4XgU12Ozeh0JI98yVjUGlp9/hx
 PTCbq9n5zDrZ2U=; b=TtaSylEGsu7ZAdS8kyFloA4LeG/CckifpYyIzbMS1LTIL
 gi3U57otkPA+V4KIdnzUnkIec0FdPaeUz7M9rwuB9WzQ8c3m4I71Fifj9ZSBeoz9
 TabKkcNCFQWurpTZ1EmQtAUc1Zg5jq5khcEaZU+A86AhqHB0GUKUnTrc5x92VnUC
 wf5LZBF20mP6m0XkuZzHJQnB8EnRGp6macCQpfYLSOwtidc6xc1k8GahgmKXpgPP
 pRhO6/eZz9qFTpt9oCfe93mtFeI2MCf6FSbuAR4VBddANb9nf9lt7pzjBX3z1jq4
 rXXbWav7HOx4u/psBe95r67G1LNAbHPsXlEyYg/6w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvxk8htjb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Mar 2026 14:20:19 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 62KEFoRF030614; Fri, 20 Mar 2026 14:20:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4cvx4eb3vm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Mar 2026 14:20:18 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62KEK2JV016730;
 Fri, 20 Mar 2026 14:20:17 GMT
Received: from jonah-amd-ol9-bm.osdevelopmeniad.oraclevcn.com
 (jonah-amd-ol9-bm.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.252.67])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 4cvx4eb3ue-1; Fri, 20 Mar 2026 14:20:17 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, mst@redhat.com,
 sgarzare@redhat.com, jasowang@redhat.com, leiyang@redhat.com,
 si-wei.liu@oracle.com, eperezma@redhat.com, boris.ostrovsky@oracle.com,
 armbru@redhat.com, jonah.palmer@oracle.com
Subject: [RFC v2 00/14] virtio-net: early VMStateDescription live migration
 support
Date: Fri, 20 Mar 2026 14:20:01 +0000
Message-ID: <20260320142015.3856652-1-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_02,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603200114
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDExNCBTYWx0ZWRfX2R/3k7Pw06un
 sVmonKfo07NtDDWnoBJQJWyH8Kbxq6F6TOThiZj63Bv93uTbJ1hYrvrr1lSpQhtCJScFsSD6paz
 iY2HT3ptE4WdkjZ2mW3PThwxDwZhQ6oA1OB4EKdBWeCMqxodKJ7QsUA/Zqeq7eZ01/GxrNMk+PP
 VWr9LoTC5LO/tBqNp7I5hTGB26HANUjfEeaauu8BqWF+XaOxMItA17vdedsI1dCNbhmmFw0eXz4
 /x4jfxp23Fyonb0bZS848CJxmN7XJDCh1KAZz+ihe35HVO7boWXYx0ypIjN1GDUSvWVRjcXS5dk
 54bj3IMlITWzT0zGi9SoilC0HMX+/mQbDDX40ok312ySKoGEEdDCDBo6TThgF9/xPHUZKjtTKUz
 k1A9cQqaaSNMexAIOZxaMIbXmeY8CcW9Wfw4hke8RvcmjZhudM7nG8eQKBc2m/rLq6pGcIF22gi
 Bosdmes1cf+zVR86Leg==
X-Authority-Analysis: v=2.4 cv=AI0/m/Lt c=1 sm=1 tr=0 ts=69bd57a3 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=tm5mL8KiohlMiDa1cBAA:9
X-Proofpoint-GUID: smgiDpCLjpELDDW51wRO5oVCEFOsX9Rs
X-Proofpoint-ORIG-GUID: smgiDpCLjpELDDW51wRO5oVCEFOsX9Rs
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This RFC explores using VMStateDescription to move virtio-net migration
work out of stop-and-copy. The goal is to reduce guest-visible downtime
by loading as much virtio-net state as possible during the setup phase,
then deciding at stop-and-copy whether the destination can finish with a
minimal resync or needs to fall back to the existing full reload path.

This is a continuation of the earlier RFC that prototyped the idea with
SaveVMHandlers [1]. This version reworks the approach around
VMStateDescription.

At a high level, the series does the following:
- adds an `early-mig` property for virtio-net and enables it by default
  only for newer machine types, while older machine types keep the
  legacy default through compat properties
- adds an early_setup-based VMSD so virtio-net setup work can be moved
  before stop-and-copy
- snapshots state that was sent early, detects relevant mid-migration
  deltas at stop-and-copy, and falls back to the existing full
  virtio-net reload path if any tracked state changed
- if no tracked deltas are found, skips the full reload and only resends
  the minimal state that still must be synchronized at stop-and-copy
- extends the same model to vhost-net by starting most vhost state early
  and deferring backend binding/finalization until stop-and-copy

This RFC series works as follows:
- state loaded early is treated as provisional
- at stop-and-copy, tracked VirtIODevice/VirtIONet state is compared
  against the early snapshot
- if anything relevant changed, migration falls back to the existing
  full virtio-net reload path
- only the no-delta case keeps the shorter stop-and-copy path

For an actual patch series, the following should be implemented:
- handle deltas individually instead of forcing a full reload whenever
  any tracked state changes
- include support for vhost-vDPA

The `early-mig` property is enabled by default only for machine types >=
10.2. Older machine types keep the legacy default off through compat
properties, so existing machine-version behavior is preserved unless the
user overrides the setting explicitly.

For vhost-net, failures while starting vhost early or during the
stop-and-copy quickstart path are treated as non-fatal to migration. In
those cases the destination continues on the userspace virtio-net
datapath, and the normal post-switchover vhost start path may retry
later. If a delta forces a full reload, any early-started vhost
instance is stopped before restart so notifier/backend state is torn
down safely.

Testing framework:
- Local live migration testing compared:
  - baseline: the current VMSD migration flow
  - early VMSD: this RFC series
- Setup:
  - 30 measured runs after 3 warmup runs per mode (baseline vs early)
  - virtio-net with 4 queue pairs
  - guest UDP request/response probe sampled at 10 ms intervals
  - no configuration deltas injected; only early VMSD path used
- Metrics:
  - query-migrate downtime
  - maximum observed probe gap as a guest-visible interruption proxy

Testing results:
- vhost=on (n=30):
  - query-migrate downtime median: 69.0 ms baseline, 60.5 ms early
    (12.3% lower)
  - maximum probe gap median: 309.0 ms baseline, 282.5 ms early
    (8.6% lower)
  - p95: downtime 85 ms baseline vs 86 ms early; probe gap 338 ms in
    both modes

- vhost=off (n=30):
  - `query-migrate` downtime median: 55.0 ms baseline, 49.0 ms early
    (10.9% lower)
  - maximum probe gap median: 283.5 ms baseline, 252.5 ms early
    (10.9% lower)
  - p95: downtime 69 ms baseline vs 81 ms early; probe gap 310.0 ms
    baseline vs 301.0 ms early

Median results improved relative to baseline in both the vhost=on and
vhost=off runs. Higher-percentile results were mixed, especially for
query-migrate downtime in the vhost=off case. That may partly reflect
the relatively small test setup and the fact that these are broader
migration-level or end-to-end measurements rather than explicit
virtio-net device downtime.

A non-RFC submission will have more targeted testing with larger
migration state and more explicit device-focused measurement.

Comments on the overall VMSD structure, migration compatibility
implications, and whether this is the right direction for early
virtio-net device migration would be appreciated.

[1] https://lore.kernel.org/qemu-devel/20250722124127.2497406-1-jonah.palmer@oracle.com/

Jonah Palmer (14):
  machine,virtio-net: add early-mig property
  virtio,virtio-net: add initial early VMSD for setup-phase migration
  virtio,virtio-net: virtio-delta VMSD - VQ state
  virtio-net: detect VirtIODevice status mid-migration change
  virtio-net: detect VirtIODevice config buffer mid-migration change
  virtio-net: detect VirtIONet MAC addr mid-migration change
  virtio-net: detect VirtIONet MAC table mid-migration changes
  virtio-net: detect VirtIONet status mid-migration change
  virtio-net: detect VirtIONet Rx filter mid-migration changes
  virtio-net: detect VirtIONet VLAN filter table changes
  virtio-net: detect VirtIONet guest offload & MQ mid-migration changes
  virtio-net: detect RSS state mid-migration changes
  virtio-net: detect pending Tx work for VQs mid-migration changes
  virtio-net,vhost-net: early migration support for vhost-net

 hw/core/machine.c              |   5 +
 hw/net/vhost_net.c             | 183 ++++++++++++++
 hw/net/virtio-net.c            | 423 +++++++++++++++++++++++++++++++++
 hw/virtio/virtio.c             | 164 ++++++++++++-
 include/hw/virtio/virtio-net.h |  50 ++++
 include/hw/virtio/virtio.h     |  18 ++
 include/net/vhost_net.h        |   9 +
 7 files changed, 851 insertions(+), 1 deletion(-)

-- 
2.51.0


