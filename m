Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 106821098782
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 14:21:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3aiX-0002x7-TK; Fri, 20 Mar 2026 10:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1w3aiU-0002w3-EH
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 10:20:47 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1w3aiS-0007Pw-73
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 10:20:46 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62K8Yx423255891; Fri, 20 Mar 2026 14:20:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=uI8Ig
 lFLYDJRx7W0jNdr2C9/1ScT5QmOSawTRa4KXCc=; b=F5Cc6IwoYceHXIUrQ82Dl
 LEEMc5Pew2xgnhsHLKKu9XaNh16wryaE1IWorYAYecGmPxBxtuYZCrsFWxgqRlUa
 gz4fe3S9sb3+5Nljabq9QBFIY3s6XqcJzg8ZtSZRvbqRWjL02XMKjsIEZezIJ1YN
 LVvSmkf5Xbvo8QuzqjR6zYotKcVURTjaVmlOiiQLX+fp1yUy5eqB2e+ylrV1jac8
 cTuWnFsfjw1Bg1ZyTb4/qgfLsHGgTC2T4bfoEXJKzyUCXN0yrUVv+HNKGTZdMAgj
 Aseevek2+KuZMBi17MjXQUI4gEs76XhsqP3nlaewLDGSZWTM0yCAPsGawhVxWlVy
 A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvyj69pbx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Mar 2026 14:20:20 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 62KDoNiX030576; Fri, 20 Mar 2026 14:20:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4cvx4eb3x0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Mar 2026 14:20:19 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62KEK2JX016730;
 Fri, 20 Mar 2026 14:20:19 GMT
Received: from jonah-amd-ol9-bm.osdevelopmeniad.oraclevcn.com
 (jonah-amd-ol9-bm.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.252.67])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 4cvx4eb3ue-2; Fri, 20 Mar 2026 14:20:19 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, mst@redhat.com,
 sgarzare@redhat.com, jasowang@redhat.com, leiyang@redhat.com,
 si-wei.liu@oracle.com, eperezma@redhat.com, boris.ostrovsky@oracle.com,
 armbru@redhat.com, jonah.palmer@oracle.com
Subject: [RFC v2 01/14] machine,virtio-net: add early-mig property
Date: Fri, 20 Mar 2026 14:20:02 +0000
Message-ID: <20260320142015.3856652-2-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260320142015.3856652-1-jonah.palmer@oracle.com>
References: <20260320142015.3856652-1-jonah.palmer@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=LKFrgZW9 c=1 sm=1 tr=0 ts=69bd57a4 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=yPCof4ZbAAAA:8 a=uYdD1a5eg0DnrcKIs-gA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDExNCBTYWx0ZWRfXwbr7ybUEUST0
 WkVnfHRL3BCVw8gClVpmaoDxaNUy3QMvJ5VQEsCu27LD6DyPcni8jGuMoUvJQxAD2k5W8dxod3q
 GFv3KqaXuK5t1TlZZyplBsfbC21i/ZWO5pmM5D2xBbkyt6oUUfSrR12Kqa88Ma360O6lCA8xGsd
 ABekwPMMEs550jBA8KoQoE+ipLqqkJxOzPE5RwN5lXS6z+5ZHD1rqsLXmQ4JLKzBJHP+RWQTUsR
 5nmQ0YaI0eBiocou9RCvHir4zN4Pt+EWixoTUuv/iXF3wRpbHzIAnV7nWLdm4inuiop6kho4zFi
 AruuCXbgCjQpq/2LhtEPHT/viwalSeNL/JnW9fjS24CVgEvwr3iWnPpzF4jtfCuXo0DfXHo2SDg
 kGmtVdO3FMiC8RF0FjQzu/9ETyMhdw69zhuRVhGl6ybeyTUFJFkj0tG4GJuTnuYUyXIzUzJ4SDa
 WakduQeuiP4XLDy0kLw==
X-Proofpoint-GUID: Z73GoIBUqHMxImCG9SUlEYgLxdGwPi2p
X-Proofpoint-ORIG-GUID: Z73GoIBUqHMxImCG9SUlEYgLxdGwPi2p
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

Introduce a new 'early-mig' property that enables the early migration
path for virtio-net devices on machine types >= 10.2:

 - virtio-net-device,early-mig=on
 - virtio-net-pci,early-mig=on
 - virtio-net-pci-transitional,early-mig=on
 - virtio-net-pci-non-transitional,early-mig=on
 - virtio-net-ccw,early-mig=on

To preserve compatibility for older machine types (<= 10.1), add compat
overrides in hw_compat_10_1 to keep the legacy default (off).

With this, machine types 10.2 and newer enable early migration by
default while older machine types retain the previous behavior. Users
may still override explicitly via:

 -device virtio-net-pci,early-mig=off
 or
 -global virtio-net-device.early-mig=off

Follow-up patches will implement the actual early migration feature for
virtio-net devices.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 hw/core/machine.c              | 5 +++++
 hw/net/virtio-net.c            | 1 +
 include/hw/virtio/virtio-net.h | 1 +
 3 files changed, 7 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 6cf0e2f404..1b6c7db119 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -45,6 +45,11 @@ const size_t hw_compat_10_2_len = G_N_ELEMENTS(hw_compat_10_2);
 
 GlobalProperty hw_compat_10_1[] = {
     { TYPE_ACPI_GED, "x-has-hest-addr", "false" },
+    { "virtio-net-device", "early-mig", "off" },
+    { "virtio-net-pci", "early-mig", "off" },
+    { "virtio-net-pci-transitional", "early-mig", "off" },
+    { "virtio-net-pci-non-transitional", "early-mig", "off" },
+    { "virtio-net-ccw", "early-mig", "off" },
     { TYPE_VIRTIO_NET, "host_tunnel", "off" },
     { TYPE_VIRTIO_NET, "host_tunnel_csum", "off" },
     { TYPE_VIRTIO_NET, "guest_tunnel", "off" },
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 2a5d642a64..12b3456ca2 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -4258,6 +4258,7 @@ static const Property virtio_net_properties[] = {
                       VIRTIO_NET_F_GUEST_USO6, true),
     DEFINE_PROP_BIT64("host_uso", VirtIONet, host_features,
                       VIRTIO_NET_F_HOST_USO, true),
+    DEFINE_PROP_BOOL("early-mig", VirtIONet, early_mig, true),
     DEFINE_PROP_ON_OFF_AUTO_BIT64("hash-ipv4", VirtIONet,
                                   rss_data.specified_hash_types,
                                   VIRTIO_NET_HASH_REPORT_IPv4 - 1,
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 371e376428..ddb141fefc 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -230,6 +230,7 @@ struct VirtIONet {
     struct EBPFRSSContext ebpf_rss;
     uint32_t nr_ebpf_rss_fds;
     char **ebpf_rss_fds;
+    bool early_mig;
 };
 
 size_t virtio_net_handle_ctrl_iov(VirtIODevice *vdev,
-- 
2.51.0


