Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCAD8E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 17:09:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWIVJ-0006qR-4x; Fri, 10 Jan 2025 12:09:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1tWIVF-0006o9-N0
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 12:08:57 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1tWIVD-00056D-3P
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 12:08:57 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50AENgnq028069;
 Fri, 10 Jan 2025 17:08:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2023-11-20; bh=Ugiw4
 DJ9tIezl/pI2MqIQpWuC1K1OT2WOqEn6JhHMxA=; b=hWuYXfjnzDkUGCW40i7BQ
 I5IKqKPnGi9thkUtkz2AzrTu4yeRolnWkv9pvd5qgn/GQXKI6/VCqASh2o+EJKa1
 A4o3Ps6aoO/yQU72TBpKSPR9VnwiwfFuvXutruRMfo+k6UV36fFyl76QpZUD2+Bb
 WxTZIb4vIpRl6pkU/qaZ1PvIRmGXVG6fLUn6qsAl54njs1SyvXUGUbZlg96VHt0f
 NrxJYE74pVV0Lp1RObccCrKWCay/lmf8C47Rowr//lexFdz+fctpiHUA2lwJuWs1
 IA5m4DXE+qZPlvL1n99y0nPBW/NM0gG44tgNen4kLmiLqMYmi8GkjGKxBfHZKvUI
 Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xudcbkuh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Jan 2025 17:08:53 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50AFq57E004808; Fri, 10 Jan 2025 17:08:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 43xuecp0w4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Jan 2025 17:08:52 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50AH1lkU031831;
 Fri, 10 Jan 2025 17:08:51 GMT
Received: from jonah-ol8.us.oracle.com (dhcp-10-39-193-76.vpn.oracle.com
 [10.39.193.76])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 43xuecp0qc-5; Fri, 10 Jan 2025 17:08:51 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: eperezma@redhat.com, mst@redhat.com, leiyang@redhat.com, peterx@redhat.com,
 dtatulea@nvidia.com, jasowang@redhat.com, si-wei.liu@oracle.com,
 boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Subject: [RFC v3 4/5] virtio: add in_xlat_addr & out_xlat_addr
 VirtQueueElement members
Date: Fri, 10 Jan 2025 12:08:33 -0500
Message-ID: <20250110170837.2747532-5-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250110170837.2747532-1-jonah.palmer@oracle.com>
References: <20250110170837.2747532-1-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-10_07,2025-01-10_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501100134
X-Proofpoint-ORIG-GUID: LDwnHt4a6kyVJzVk0MWj-cot_YeA0x2h
X-Proofpoint-GUID: LDwnHt4a6kyVJzVk0MWj-cot_YeA0x2h
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.369,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Adds the in_xlat_addr & out_xlat_addr hwaddr arrays to the
VirtQueueElement struct and introduces an optional GPA output parameter
to dma_memory_map().

These arrays will store a VirtQueueElement's input/output descriptors'
GPA of the mapped memory region, if it's backed by guest memory, via
dma_memory_map().

The GPA will always correspond 1:1 to the iovec entry when translating
addresses between Qemu VAs and SVQ IOVAs in vhost_svq_translate_addr().
This helps to avoid extra complicated code in SVQ's
vhost_svq_vring_write_descs() function (e.g. splitting up iovec into
multiple buffers, not breaking devices using aliased mapping, etc.).

Since the translation is only done once inside the DMA API alongside
virtqueue_pop(), the cost should be minimal.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 hw/display/virtio-gpu.c     |  5 ++--
 hw/hyperv/vmbus.c           |  8 +++---
 hw/ide/ahci.c               |  7 +++---
 hw/usb/libhw.c              |  2 +-
 hw/virtio/virtio.c          | 50 ++++++++++++++++++++++++++-----------
 include/hw/pci/pci_device.h |  2 +-
 include/hw/virtio/virtio.h  |  2 ++
 include/system/dma.h        | 25 ++++++++++++++++++-
 system/dma-helpers.c        |  2 +-
 9 files changed, 77 insertions(+), 26 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 11a7a85750..afb9a8b69f 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -839,7 +839,7 @@ int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
             len = l;
             map = dma_memory_map(VIRTIO_DEVICE(g)->dma_as, a, &len,
                                  DMA_DIRECTION_TO_DEVICE,
-                                 MEMTXATTRS_UNSPECIFIED);
+                                 MEMTXATTRS_UNSPECIFIED, NULL);
             if (!map) {
                 qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to map MMIO memory for"
                               " element %d\n", __func__, e);
@@ -1258,7 +1258,8 @@ static bool virtio_gpu_load_restore_mapping(VirtIOGPU *g,
         hwaddr len = res->iov[i].iov_len;
         res->iov[i].iov_base =
             dma_memory_map(VIRTIO_DEVICE(g)->dma_as, res->addrs[i], &len,
-                           DMA_DIRECTION_TO_DEVICE, MEMTXATTRS_UNSPECIFIED);
+                           DMA_DIRECTION_TO_DEVICE, MEMTXATTRS_UNSPECIFIED,
+                           NULL);
 
         if (!res->iov[i].iov_base || len != res->iov[i].iov_len) {
             /* Clean up the half-a-mapping we just created... */
diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
index 12a7dc4312..c3308a1bfd 100644
--- a/hw/hyperv/vmbus.c
+++ b/hw/hyperv/vmbus.c
@@ -374,7 +374,7 @@ static ssize_t gpadl_iter_io(GpadlIter *iter, void *buf, uint32_t len)
             maddr = (iter->gpadl->gfns[idx] << TARGET_PAGE_BITS) | off_in_page;
 
             iter->map = dma_memory_map(iter->as, maddr, &mlen, iter->dir,
-                                       MEMTXATTRS_UNSPECIFIED);
+                                       MEMTXATTRS_UNSPECIFIED, NULL);
             if (mlen != pgleft) {
                 dma_memory_unmap(iter->as, iter->map, mlen, iter->dir, 0);
                 iter->map = NULL;
@@ -492,7 +492,8 @@ int vmbus_map_sgl(VMBusChanReq *req, DMADirection dir, struct iovec *iov,
             }
 
             iov[ret_cnt].iov_base = dma_memory_map(sgl->as, a, &l, dir,
-                                                   MEMTXATTRS_UNSPECIFIED);
+                                                   MEMTXATTRS_UNSPECIFIED,
+                                                   NULL);
             if (!l) {
                 ret = -EFAULT;
                 goto err;
@@ -568,7 +569,8 @@ static vmbus_ring_buffer *ringbuf_map_hdr(VMBusRingBufCommon *ringbuf)
     dma_addr_t mlen = sizeof(*rb);
 
     rb = dma_memory_map(ringbuf->as, ringbuf->rb_addr, &mlen,
-                        DMA_DIRECTION_FROM_DEVICE, MEMTXATTRS_UNSPECIFIED);
+                        DMA_DIRECTION_FROM_DEVICE, MEMTXATTRS_UNSPECIFIED,
+                        NULL);
     if (mlen != sizeof(*rb)) {
         dma_memory_unmap(ringbuf->as, rb, mlen,
                          DMA_DIRECTION_FROM_DEVICE, 0);
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 1303c21cb7..aeea2dc61d 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -221,7 +221,7 @@ static void map_page(AddressSpace *as, uint8_t **ptr, uint64_t addr,
     }
 
     *ptr = dma_memory_map(as, addr, &len, DMA_DIRECTION_FROM_DEVICE,
-                          MEMTXATTRS_UNSPECIFIED);
+                          MEMTXATTRS_UNSPECIFIED, NULL);
     if (len < wanted && *ptr) {
         dma_memory_unmap(as, *ptr, len, DMA_DIRECTION_FROM_DEVICE, len);
         *ptr = NULL;
@@ -928,7 +928,7 @@ static int ahci_populate_sglist(AHCIDevice *ad, QEMUSGList *sglist,
     /* map PRDT */
     if (!(prdt = dma_memory_map(ad->hba->as, prdt_addr, &prdt_len,
                                 DMA_DIRECTION_TO_DEVICE,
-                                MEMTXATTRS_UNSPECIFIED))){
+                                MEMTXATTRS_UNSPECIFIED, NULL))) {
         trace_ahci_populate_sglist_no_map(ad->hba, ad->port_no);
         return -1;
     }
@@ -1338,7 +1338,8 @@ static void handle_cmd(AHCIState *s, int port, uint8_t slot)
     tbl_addr = le64_to_cpu(cmd->tbl_addr);
     cmd_len = 0x80;
     cmd_fis = dma_memory_map(s->as, tbl_addr, &cmd_len,
-                             DMA_DIRECTION_TO_DEVICE, MEMTXATTRS_UNSPECIFIED);
+                             DMA_DIRECTION_TO_DEVICE, MEMTXATTRS_UNSPECIFIED,
+                             NULL);
     if (!cmd_fis) {
         trace_handle_cmd_badfis(s, port);
         return;
diff --git a/hw/usb/libhw.c b/hw/usb/libhw.c
index 4f03ef4ba9..762d70b419 100644
--- a/hw/usb/libhw.c
+++ b/hw/usb/libhw.c
@@ -37,7 +37,7 @@ int usb_packet_map(USBPacket *p, QEMUSGList *sgl)
         while (len) {
             dma_addr_t xlen = len;
             mem = dma_memory_map(sgl->as, base, &xlen, dir,
-                                 MEMTXATTRS_UNSPECIFIED);
+                                 MEMTXATTRS_UNSPECIFIED, NULL);
             if (!mem) {
                 goto err;
             }
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 85110bce37..be756f3ac8 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1553,9 +1553,9 @@ int virtqueue_avail_bytes(VirtQueue *vq, unsigned int in_bytes,
 }
 
 static bool virtqueue_map_desc(VirtIODevice *vdev, unsigned int *p_num_sg,
-                               hwaddr *addr, struct iovec *iov,
-                               unsigned int max_num_sg, bool is_write,
-                               hwaddr pa, size_t sz)
+                               hwaddr *addr, hwaddr *xlat_addr,
+                               struct iovec *iov, unsigned int max_num_sg,
+                               bool is_write, hwaddr pa, size_t sz)
 {
     bool ok = false;
     unsigned num_sg = *p_num_sg;
@@ -1579,7 +1579,8 @@ static bool virtqueue_map_desc(VirtIODevice *vdev, unsigned int *p_num_sg,
                                               is_write ?
                                               DMA_DIRECTION_FROM_DEVICE :
                                               DMA_DIRECTION_TO_DEVICE,
-                                              MEMTXATTRS_UNSPECIFIED);
+                                              MEMTXATTRS_UNSPECIFIED,
+                                              &xlat_addr[num_sg]);
         if (!iov[num_sg].iov_base) {
             virtio_error(vdev, "virtio: bogus descriptor or out of resources");
             goto out;
@@ -1618,7 +1619,7 @@ static void virtqueue_undo_map_desc(unsigned int out_num, unsigned int in_num,
 
 static void virtqueue_map_iovec(VirtIODevice *vdev, struct iovec *sg,
                                 hwaddr *addr, unsigned int num_sg,
-                                bool is_write)
+                                hwaddr *xlat_addr, bool is_write)
 {
     unsigned int i;
     hwaddr len;
@@ -1629,7 +1630,8 @@ static void virtqueue_map_iovec(VirtIODevice *vdev, struct iovec *sg,
                                         addr[i], &len, is_write ?
                                         DMA_DIRECTION_FROM_DEVICE :
                                         DMA_DIRECTION_TO_DEVICE,
-                                        MEMTXATTRS_UNSPECIFIED);
+                                        MEMTXATTRS_UNSPECIFIED,
+                                        &xlat_addr[i]);
         if (!sg[i].iov_base) {
             error_report("virtio: error trying to map MMIO memory");
             exit(1);
@@ -1643,9 +1645,10 @@ static void virtqueue_map_iovec(VirtIODevice *vdev, struct iovec *sg,
 
 void virtqueue_map(VirtIODevice *vdev, VirtQueueElement *elem)
 {
-    virtqueue_map_iovec(vdev, elem->in_sg, elem->in_addr, elem->in_num, true);
+    virtqueue_map_iovec(vdev, elem->in_sg, elem->in_addr, elem->in_num,
+                        elem->in_xlat_addr, true);
     virtqueue_map_iovec(vdev, elem->out_sg, elem->out_addr, elem->out_num,
-                                                                        false);
+                        elem->out_xlat_addr, false);
 }
 
 static void *virtqueue_alloc_element(size_t sz, unsigned out_num, unsigned in_num)
@@ -1654,7 +1657,14 @@ static void *virtqueue_alloc_element(size_t sz, unsigned out_num, unsigned in_nu
     size_t in_addr_ofs = QEMU_ALIGN_UP(sz, __alignof__(elem->in_addr[0]));
     size_t out_addr_ofs = in_addr_ofs + in_num * sizeof(elem->in_addr[0]);
     size_t out_addr_end = out_addr_ofs + out_num * sizeof(elem->out_addr[0]);
-    size_t in_sg_ofs = QEMU_ALIGN_UP(out_addr_end, __alignof__(elem->in_sg[0]));
+    size_t in_xlat_addr_ofs =
+        QEMU_ALIGN_UP(out_addr_end, __alignof__(elem->in_xlat_addr[0]));
+    size_t out_xlat_addr_ofs = in_xlat_addr_ofs + in_num *
+                               sizeof(elem->in_xlat_addr[0]);
+    size_t out_xlat_addr_end = out_xlat_addr_ofs + out_num *
+                               sizeof(elem->out_xlat_addr[0]);
+    size_t in_sg_ofs =
+        QEMU_ALIGN_UP(out_xlat_addr_end, __alignof__(elem->in_sg[0]));
     size_t out_sg_ofs = in_sg_ofs + in_num * sizeof(elem->in_sg[0]);
     size_t out_sg_end = out_sg_ofs + out_num * sizeof(elem->out_sg[0]);
 
@@ -1665,6 +1675,8 @@ static void *virtqueue_alloc_element(size_t sz, unsigned out_num, unsigned in_nu
     elem->in_num = in_num;
     elem->in_addr = (void *)elem + in_addr_ofs;
     elem->out_addr = (void *)elem + out_addr_ofs;
+    elem->in_xlat_addr = (void *)elem + in_xlat_addr_ofs;
+    elem->out_xlat_addr = (void *)elem + out_xlat_addr_ofs;
     elem->in_sg = (void *)elem + in_sg_ofs;
     elem->out_sg = (void *)elem + out_sg_ofs;
     return elem;
@@ -1681,6 +1693,7 @@ static void *virtqueue_split_pop(VirtQueue *vq, size_t sz)
     VirtQueueElement *elem = NULL;
     unsigned out_num, in_num, elem_entries;
     hwaddr addr[VIRTQUEUE_MAX_SIZE];
+    hwaddr xlat_addr[VIRTQUEUE_MAX_SIZE];
     struct iovec iov[VIRTQUEUE_MAX_SIZE];
     VRingDesc desc;
     int rc;
@@ -1754,7 +1767,7 @@ static void *virtqueue_split_pop(VirtQueue *vq, size_t sz)
 
         if (desc.flags & VRING_DESC_F_WRITE) {
             map_ok = virtqueue_map_desc(vdev, &in_num, addr + out_num,
-                                        iov + out_num,
+                                        xlat_addr + out_num, iov + out_num,
                                         VIRTQUEUE_MAX_SIZE - out_num, true,
                                         desc.addr, desc.len);
         } else {
@@ -1762,8 +1775,8 @@ static void *virtqueue_split_pop(VirtQueue *vq, size_t sz)
                 virtio_error(vdev, "Incorrect order for descriptors");
                 goto err_undo_map;
             }
-            map_ok = virtqueue_map_desc(vdev, &out_num, addr, iov,
-                                        VIRTQUEUE_MAX_SIZE, false,
+            map_ok = virtqueue_map_desc(vdev, &out_num, addr, xlat_addr,
+                                        iov, VIRTQUEUE_MAX_SIZE, false,
                                         desc.addr, desc.len);
         }
         if (!map_ok) {
@@ -1790,10 +1803,12 @@ static void *virtqueue_split_pop(VirtQueue *vq, size_t sz)
     for (i = 0; i < out_num; i++) {
         elem->out_addr[i] = addr[i];
         elem->out_sg[i] = iov[i];
+        elem->out_xlat_addr[i] = xlat_addr[i];
     }
     for (i = 0; i < in_num; i++) {
         elem->in_addr[i] = addr[out_num + i];
         elem->in_sg[i] = iov[out_num + i];
+        elem->in_xlat_addr[i] = xlat_addr[out_num + i];
     }
 
     if (virtio_vdev_has_feature(vdev, VIRTIO_F_IN_ORDER)) {
@@ -1827,6 +1842,7 @@ static void *virtqueue_packed_pop(VirtQueue *vq, size_t sz)
     VirtQueueElement *elem = NULL;
     unsigned out_num, in_num, elem_entries;
     hwaddr addr[VIRTQUEUE_MAX_SIZE];
+    hwaddr xlat_addr[VIRTQUEUE_MAX_SIZE];
     struct iovec iov[VIRTQUEUE_MAX_SIZE];
     VRingPackedDesc desc;
     uint16_t id;
@@ -1891,7 +1907,7 @@ static void *virtqueue_packed_pop(VirtQueue *vq, size_t sz)
 
         if (desc.flags & VRING_DESC_F_WRITE) {
             map_ok = virtqueue_map_desc(vdev, &in_num, addr + out_num,
-                                        iov + out_num,
+                                        xlat_addr + out_num, iov + out_num,
                                         VIRTQUEUE_MAX_SIZE - out_num, true,
                                         desc.addr, desc.len);
         } else {
@@ -1899,7 +1915,7 @@ static void *virtqueue_packed_pop(VirtQueue *vq, size_t sz)
                 virtio_error(vdev, "Incorrect order for descriptors");
                 goto err_undo_map;
             }
-            map_ok = virtqueue_map_desc(vdev, &out_num, addr, iov,
+            map_ok = virtqueue_map_desc(vdev, &out_num, addr, xlat_addr, iov,
                                         VIRTQUEUE_MAX_SIZE, false,
                                         desc.addr, desc.len);
         }
@@ -1928,10 +1944,12 @@ static void *virtqueue_packed_pop(VirtQueue *vq, size_t sz)
     for (i = 0; i < out_num; i++) {
         elem->out_addr[i] = addr[i];
         elem->out_sg[i] = iov[i];
+        elem->out_xlat_addr[i] = xlat_addr[i];
     }
     for (i = 0; i < in_num; i++) {
         elem->in_addr[i] = addr[out_num + i];
         elem->in_sg[i] = iov[out_num + i];
+        elem->in_xlat_addr[i] = xlat_addr[out_num + i];
     }
 
     elem->index = id;
@@ -2117,10 +2135,14 @@ void *qemu_get_virtqueue_element(VirtIODevice *vdev, QEMUFile *f, size_t sz)
     elem->index = data.index;
 
     for (i = 0; i < elem->in_num; i++) {
+        /* xlat_addr is overwritten by virtqueue_map */
+        elem->in_xlat_addr[i] = 0;
         elem->in_addr[i] = data.in_addr[i];
     }
 
     for (i = 0; i < elem->out_num; i++) {
+        /* xlat_addr is overwritten by virtqueue_map */
+        elem->out_xlat_addr[i] = 0;
         elem->out_addr[i] = data.out_addr[i];
     }
 
diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index 8eaf0d58bb..e2bb453dcc 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -328,7 +328,7 @@ static inline void *pci_dma_map(PCIDevice *dev, dma_addr_t addr,
                                 dma_addr_t *plen, DMADirection dir)
 {
     return dma_memory_map(pci_get_address_space(dev), addr, plen, dir,
-                          MEMTXATTRS_UNSPECIFIED);
+                          MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
 static inline void pci_dma_unmap(PCIDevice *dev, void *buffer, dma_addr_t len,
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 6386910280..e822aafd91 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -75,6 +75,8 @@ typedef struct VirtQueueElement
     hwaddr *out_addr;
     struct iovec *in_sg;
     struct iovec *out_sg;
+    hwaddr *in_xlat_addr;
+    hwaddr *out_xlat_addr;
 } VirtQueueElement;
 
 #define VIRTIO_QUEUE_MAX 1024
diff --git a/include/system/dma.h b/include/system/dma.h
index 5a49a30628..b5d4c07452 100644
--- a/include/system/dma.h
+++ b/include/system/dma.h
@@ -12,6 +12,7 @@
 
 #include "exec/memory.h"
 #include "exec/address-spaces.h"
+#include "exec/ramblock.h"
 #include "block/block.h"
 #include "block/accounting.h"
 
@@ -201,10 +202,12 @@ MemTxResult dma_memory_set(AddressSpace *as, dma_addr_t addr,
  * @len: pointer to length of buffer; updated on return
  * @dir: indicates the transfer direction
  * @attrs: memory attributes
+ * @guest_addr: optional output for GPA
  */
 static inline void *dma_memory_map(AddressSpace *as,
                                    dma_addr_t addr, dma_addr_t *len,
-                                   DMADirection dir, MemTxAttrs attrs)
+                                   DMADirection dir, MemTxAttrs attrs,
+                                   hwaddr *guest_addr)
 {
     hwaddr xlen = *len;
     void *p;
@@ -212,6 +215,26 @@ static inline void *dma_memory_map(AddressSpace *as,
     p = address_space_map(as, addr, &xlen, dir == DMA_DIRECTION_FROM_DEVICE,
                           attrs);
     *len = xlen;
+
+    /* Attempt to find a backing GPA for this HVA */
+    if (guest_addr) {
+        if (p) {
+            RAMBlock *rb;
+            ram_addr_t offset;
+
+            rb = qemu_ram_block_from_host(p, false, &offset);
+            if (rb) {
+                /* HVA corresponds to guest memory */
+                *guest_addr = rb->offset + offset;
+            } else {
+                /* HVA doesn't correspond to guest memory */
+                *guest_addr = 0;
+            }
+        } else {
+            /* Mapping failed */
+            *guest_addr = 0;
+        }
+    }
     return p;
 }
 
diff --git a/system/dma-helpers.c b/system/dma-helpers.c
index f6403242f5..a6d2352c0f 100644
--- a/system/dma-helpers.c
+++ b/system/dma-helpers.c
@@ -135,7 +135,7 @@ static void dma_blk_cb(void *opaque, int ret)
         cur_addr = dbs->sg->sg[dbs->sg_cur_index].base + dbs->sg_cur_byte;
         cur_len = dbs->sg->sg[dbs->sg_cur_index].len - dbs->sg_cur_byte;
         mem = dma_memory_map(dbs->sg->as, cur_addr, &cur_len, dbs->dir,
-                             MEMTXATTRS_UNSPECIFIED);
+                             MEMTXATTRS_UNSPECIFIED, NULL);
         /*
          * Make reads deterministic in icount mode. Windows sometimes issues
          * disk read requests with overlapping SGs. It leads
-- 
2.43.5


