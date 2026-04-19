Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 107CBEA719B
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2026 13:03:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wERnH-00016n-2u; Sun, 19 Apr 2026 09:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wERmk-0000uD-Jl
 for qemu-devel@nongnu.org; Sun, 19 Apr 2026 09:02:05 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wERme-0008KL-Lq
 for qemu-devel@nongnu.org; Sun, 19 Apr 2026 09:02:01 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488c2690057so20460645e9.0
 for <qemu-devel@nongnu.org>; Sun, 19 Apr 2026 06:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1776603711; x=1777208511; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y091UvS4a88ptSlV8x9WKnLH+imaiJafi8HLwtDBHMs=;
 b=O/CKtncC+CnAe2OsAd1ilrpVHsBEy4GXNsEeoMgp330tWoctjtw+Chd5JtxtHDts4A
 c7BysGfldoxL0o/P1fBXlaEB0DoMdniVvGadN1jyi9/7R45gaV9NFoQqYi/zh5j1l60s
 QZFm0QNWTujFKBWnWgAAGAaijxiU6MLpyUjbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776603711; x=1777208511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y091UvS4a88ptSlV8x9WKnLH+imaiJafi8HLwtDBHMs=;
 b=L/OXiZFiQTxwCmUMmgZwXp0e/y7e9iOA7x9WULFueRIeWZuLdEgYqNvJDuVbhtLbfl
 q9HIsy9pP65GhAGfMWwJXo6Wu6C6sthu7shb86V28fIVpaBBoSeoGHR+w7UtqkAdMYax
 cSS0T7bOYTuP32zD7XoJTliL7ROD0JWc/NAn/X4Y+7rnw0DXOId+S8iqk9DKb5KXscQX
 Xrd+VQc+nT468Oxh4JvAMZXB16v+x9rqIr1Whjhc+yfG9ksoMH1CGJQ3WpHKt5ArSTrL
 f9Hq7mVsT76U/6TG7Ff3yfJEQdan0DopPq6aY4TWUlHeckTt4wT0s0ltj4jMy5LSkal9
 LgsQ==
X-Gm-Message-State: AOJu0YwlDiC/pE7Uffj+/FnzcpE9gSEjISkn31h1nhwl21ptkRkPVJR8
 ir5b9+6FDYVORrBgd6B2NJGoV37Wg/7npaora9KIRmeiSOBrev8pwPd5KUHronFGd2RfIiJ+AfI
 iNIL1P9I=
X-Gm-Gg: AeBDieudcakPK0u/v5dqY1maypaD7Qch6Ok2wtiWO7AG0l+hNSiZ7XyYMjd4WroguBa
 YS91wJf1oI5hWrqpXWw9wGelveHKtxXOLrtkPmXffv/XvqAo31yJo4LYEaahVdW8UsoC1l/fHQd
 Rz0c4yw/Tsq766c7kk/BceXtl6jZ0GjkOgaw9KW/3D5ryaTs2XPfjc979nD6f0rj1d23ie2MRk4
 Y7n+83b02OlaAZRFJ1HdzVH191FqWaG8hh9QpmA7KxWeeh/nLR4HIGc315WeUlLwDsxdDQU3Bw/
 2thTQ77Bw/bz1VucwJebMRBS0pHSH261AC9P0FldS/T4vvhhoJCp5Iq6HN8nCxEWSG9EsGhaqsb
 3xks2iADyw4ih2tK51nqA32WjJGB8rJEy1urPRDmhehp3uIGZmbDUsYdM2uOxxjLQmRLaOJNNhY
 iij1zzZ5dXi5gJW1XZxfLvUq4uk5WHUiNz7HfTFvuAFmbj2av4Der8xJSJqFSnipMc6ke7lSeh4
 w5JKRNADdg0RcsFlAajCg/y8b9R95Ta9Q==
X-Received: by 2002:a05:600c:888b:b0:488:c80c:c236 with SMTP id
 5b1f17b1804b1-488fb73d525mr115373365e9.5.1776603711438; 
 Sun, 19 Apr 2026 06:01:51 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf57228c00995e4e0d3496e07b.dip0.t-ipconnect.de.
 [2003:cf:5722:8c00:995e:4e0d:3496:e07b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cc2cacsm20734304f8f.13.2026.04.19.06.01.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 06:01:50 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Jesper Devantier <foss@defmacro.it>,
 Klaus Jensen <its@irrelevant.dk>, Fabiano Rosas <farosas@suse.de>,
 Zhao Liu <zhao1.liu@intel.com>, Keith Busch <kbusch@kernel.org>,
 Peter Xu <peterx@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v6 8/8] tests/qtest/nvme-test: add migration test with full CQ
Date: Sun, 19 Apr 2026 15:01:39 +0200
Message-ID: <20260419130139.15554-9-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260419130139.15554-1-alexander@mihalicyn.com>
References: <20260419130139.15554-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

As suggested by Stefan [1], let's add a migration test to cover
rare scenario when CQ is full of non-processed CQEs and migration
happens.

To run this test:
$ meson test -C build 'qtest-x86_64/qos-test'

Link: https://lore.kernel.org/qemu-devel/20260408183529.GB319710@fedora/ [1]
Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
---
 tests/qtest/nvme-test.c | 393 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 393 insertions(+)

diff --git a/tests/qtest/nvme-test.c b/tests/qtest/nvme-test.c
index 4aec1651e6e..1ba2fa6943f 100644
--- a/tests/qtest/nvme-test.c
+++ b/tests/qtest/nvme-test.c
@@ -8,9 +8,11 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bswap.h"
 #include "qemu/module.h"
 #include "qemu/units.h"
 #include "libqtest.h"
+#include "libqtest-single.h"
 #include "libqos/qgraph.h"
 #include "libqos/pci.h"
 #include "block/nvme.h"
@@ -142,6 +144,395 @@ static void nvmetest_pmr_reg_test(void *obj, void *data, QGuestAllocator *alloc)
     qpci_iounmap(pdev, pmr_bar);
 }
 
+#define PAGE_SIZE 4096
+
+typedef struct nvme_ctrl nvme_ctrl;
+
+typedef struct nvme_queue {
+    nvme_ctrl *ctrl;
+    uint64_t doorbell;
+    uint32_t size;
+} nvme_queue;
+
+typedef struct nvme_cq {
+    nvme_queue common;
+    NvmeCqe *phys_cqe;
+    uint16_t head;
+    uint8_t phase;
+} nvme_cq;
+
+typedef struct nvme_sq {
+    nvme_queue common;
+    NvmeCmd *phys_sqe;
+    nvme_cq *cq;
+    uint16_t head;
+    uint16_t tail;
+} nvme_sq;
+
+struct nvme_ctrl {
+    QGuestAllocator *alloc;
+    QPCIDevice *pdev;
+    QPCIBar bar;
+
+    uint32_t db_stride;
+
+    nvme_sq admin_sq;
+    nvme_cq admin_cq;
+};
+
+static void nvme_init_queue_common(nvme_ctrl *ctrl, nvme_queue *q,
+                                   uint16_t db_idx, uint32_t size)
+{
+    q->ctrl = ctrl;
+    q->doorbell = (sizeof(NvmeBar) + db_idx * ctrl->db_stride);
+    g_test_message(" q %p db_idx %u doorbell %lx", q, db_idx, q->doorbell);
+    q->size = size;
+}
+
+static void nvme_init_sq(nvme_ctrl *ctrl, nvme_sq *sq, uint16_t db_idx,
+                         uint32_t size, nvme_cq *cq)
+{
+    nvme_init_queue_common(ctrl, &sq->common, db_idx, size);
+
+    sq->phys_sqe = (typeof(sq->phys_sqe))guest_alloc(ctrl->alloc,
+                                                     PAGE_SIZE);
+    g_assert(sq->phys_sqe);
+
+    g_test_message("sq %p db_idx %u sqe %p", sq, db_idx, sq->phys_sqe);
+    sq->cq = cq;
+    sq->head = 0;
+    sq->tail = 0;
+}
+
+static void nvme_init_cq(nvme_ctrl *ctrl, nvme_cq *cq, uint16_t db_idx,
+                         uint32_t size)
+{
+    nvme_init_queue_common(ctrl, &cq->common, db_idx, size);
+
+    cq->phys_cqe = (typeof(cq->phys_cqe))guest_alloc(ctrl->alloc,
+                                                     PAGE_SIZE);
+    g_assert(cq->phys_cqe);
+
+    g_test_message("cq %p db_idx %u cqe %p", cq, db_idx, cq->phys_cqe);
+    cq->head = 0;
+    cq->phase = 1;
+}
+
+static int nvme_cqe_pending(nvme_cq *cq)
+{
+    uint16_t status = qtest_readw(cq->common.ctrl->pdev->bus->qts,
+                                  (uint64_t)&cq->phys_cqe[cq->head].status);
+    return (le16_to_cpu(status) & 1) == cq->phase;
+}
+
+static int nvme_is_cqe_success(NvmeCqe *cqe)
+{
+    return (le16_to_cpu(cqe->status) >> 1) == NVME_SUCCESS;
+}
+
+static NvmeCqe nvme_handle_cqe(nvme_sq *sq)
+{
+    nvme_cq *cq = sq->cq;
+    NvmeCqe *phys_cqe = &cq->phys_cqe[cq->head];
+    NvmeCqe cqe;
+    uint16_t cq_next_head;
+
+    g_assert(nvme_cqe_pending(cq));
+
+    qtest_memread(sq->common.ctrl->pdev->bus->qts, (uint64_t)phys_cqe, &cqe, sizeof(cqe));
+
+    cq_next_head = (cq->head + 1) % cq->common.size;
+    g_test_message("cq %p head %u -> %u", cq, cq->head, cq_next_head);
+    if (cq_next_head < cq->head) {
+        cq->phase ^= 1;
+    }
+    cq->head = cq_next_head;
+
+    if (cqe.sq_head != sq->head) {
+        sq->head = cqe.sq_head;
+        g_test_message("sq %p head = %u", sq, sq->head);
+    }
+
+    qpci_io_writel(cq->common.ctrl->pdev, cq->common.ctrl->bar, cq->common.doorbell, cq->head);
+
+    return cqe;
+}
+
+static NvmeCqe nvme_wait(nvme_sq *sq)
+{
+    int i;
+    bool ready = false;
+
+    for (i = 0; i < 10; i++) {
+        if (nvme_cqe_pending(sq->cq)) {
+            ready = true;
+            break;
+        }
+
+        g_usleep(1000);
+    }
+
+    g_assert(ready);
+
+    return nvme_handle_cqe(sq);
+}
+
+static NvmeCmd *nvme_get_next_sqe(nvme_sq *sq, uint8_t opcode, uint16_t cid, void *prp1)
+{
+    NvmeCmd *phys_sqe = &sq->phys_sqe[sq->tail];
+
+    if (((sq->tail + 1) % sq->common.size) == sq->head) {
+        /* no space in SQ */
+        g_test_message("%s head %d tail %d", __func__, sq->head, sq->tail);
+        g_assert(false);
+        return NULL;
+    }
+
+    qtest_memset(sq->common.ctrl->pdev->bus->qts,
+                 (uint64_t)phys_sqe, 0, sizeof(*phys_sqe));
+
+    #define GUEST_MEM_WRITE(fn, field, val) \
+        fn(sq->common.ctrl->pdev->bus->qts, (uint64_t)&(field), (val))
+
+    GUEST_MEM_WRITE(qtest_writeb, phys_sqe->opcode, opcode);
+    GUEST_MEM_WRITE(qtest_writew, phys_sqe->cid, cid);
+    GUEST_MEM_WRITE(qtest_writeq, phys_sqe->dptr.prp1, (uint32_t)(uint64_t)prp1);
+
+    #undef GUEST_MEM_WRITE
+
+    g_test_message("sq %p next_sqe %u sqe %p", sq, sq->tail, phys_sqe);
+    return phys_sqe;
+}
+
+static void nvme_commit_sqe(nvme_sq *sq)
+{
+    g_test_message("sq %p commit sqe tail %u", sq, sq->tail);
+    sq->tail = (sq->tail + 1) % sq->common.size;
+    qpci_io_writel(sq->common.ctrl->pdev, sq->common.ctrl->bar, sq->common.doorbell, sq->tail);
+}
+
+static NvmeIdCtrl *nvme_admin_identify_ctrl(nvme_ctrl *ctrl, uint16_t cid, bool no_wait)
+{
+    NvmeCmd *phys_cmd_identify;
+    NvmeIdCtrl *phys_identify;
+    NvmeCqe cqe;
+
+    g_test_message("sending req cid %u no_wait %d", cid, no_wait);
+
+    phys_identify = (typeof(phys_identify))guest_alloc(ctrl->alloc, PAGE_SIZE);
+    g_assert(phys_identify);
+
+    phys_cmd_identify = nvme_get_next_sqe(&ctrl->admin_sq,
+                                          NVME_ADM_CMD_IDENTIFY, cid,
+                                          phys_identify);
+    g_assert(phys_cmd_identify);
+
+    #define GUEST_MEM_WRITE(fn, field, val) \
+        fn(ctrl->pdev->bus->qts, (uint64_t)&(field), (val))
+
+    GUEST_MEM_WRITE(qtest_writel, phys_cmd_identify->nsid, 0);
+    GUEST_MEM_WRITE(qtest_writel, ((NvmeIdentify *)phys_cmd_identify)->cns, NVME_ID_CNS_CTRL);
+
+    #undef GUEST_MEM_WRITE
+
+    nvme_commit_sqe(&ctrl->admin_sq);
+
+    if (no_wait) {
+        return phys_identify;
+    }
+
+    cqe = nvme_wait(&ctrl->admin_sq);
+    g_assert(nvme_is_cqe_success(&cqe));
+    g_assert(cqe.cid == cid);
+
+    return phys_identify;
+}
+
+static void nvme_wait_ready(nvme_ctrl *ctrl, int val)
+{
+    int i;
+
+    for (i = 0; i < 10; i++) {
+        uint32_t csts = qpci_io_readl(ctrl->pdev, ctrl->bar, NVME_REG_CSTS);
+        g_test_message("%s: csts %x", __func__, csts);
+
+        if (NVME_CSTS_RDY(csts) == val) {
+            return;
+        }
+
+        g_usleep(1000);
+    }
+
+    g_assert(false);
+}
+
+static void test_migrate_setup_nvme_ctrl(nvme_ctrl *ctrl)
+{
+    uint64_t cap;
+
+    /* disable controller */
+    qpci_io_writel(ctrl->pdev, ctrl->bar, NVME_REG_CC, 0);
+    nvme_wait_ready(ctrl, 0);
+
+    cap = qpci_io_readq(ctrl->pdev, ctrl->bar, NVME_REG_CAP);
+    ctrl->db_stride = 4 << NVME_CAP_DSTRD(cap);
+
+    nvme_init_cq(ctrl, &ctrl->admin_cq, 1, 2 /* CQEs num */);
+    nvme_init_sq(ctrl, &ctrl->admin_sq, 0, 4 /* SQEs num */, &ctrl->admin_cq);
+
+    qpci_io_writel(ctrl->pdev, ctrl->bar, NVME_REG_AQA,
+        ((ctrl->admin_cq.common.size - 1) << AQA_ACQS_SHIFT) |
+        ((ctrl->admin_sq.common.size - 1) << AQA_ASQS_SHIFT)
+    );
+
+    qpci_io_writeq(ctrl->pdev, ctrl->bar,
+                   NVME_REG_ASQ, (uint64_t)ctrl->admin_sq.phys_sqe);
+    qpci_io_writeq(ctrl->pdev, ctrl->bar,
+                   NVME_REG_ACQ, (uint64_t)ctrl->admin_cq.phys_cqe);
+
+    /* enable controller */
+    {
+        uint32_t cc = 0;
+        NVME_SET_CC_EN(cc, 1);
+        qpci_io_writel(ctrl->pdev, ctrl->bar, NVME_REG_CC, cc);
+    }
+
+    nvme_wait_ready(ctrl, 1);
+}
+
+typedef struct test_migrate_req {
+    uint16_t cid;
+    bool handle_cqe;
+    NvmeIdCtrl *phys_identify;
+} test_migrate_req;
+
+static void test_migrate_send_nvme_reqs(nvme_ctrl *ctrl, test_migrate_req *reqs,
+                                        int num)
+{
+    int i;
+
+    for (i = 0; i < num; i++) {
+        reqs[i].phys_identify = nvme_admin_identify_ctrl(ctrl, reqs[i].cid,
+                                                         !reqs[i].handle_cqe);
+        g_assert(reqs[i].phys_identify);
+
+        if (reqs[i].handle_cqe) {
+            guest_free(ctrl->alloc, (uint64_t)reqs[i].phys_identify);
+        }
+    }
+}
+
+static void test_migrate_check_nvme(nvme_ctrl *ctrl, test_migrate_req *reqs, int num)
+{
+    int i;
+
+    for (i = 0; i < num; i++) {
+        NvmeCqe cqe;
+
+        if (reqs[i].handle_cqe) {
+            continue;
+        }
+
+        cqe = nvme_wait(&ctrl->admin_sq);
+        g_assert(nvme_is_cqe_success(&cqe));
+
+        g_assert_cmpint(cqe.cid, ==, reqs[i].cid);
+
+        #define GUEST_MEM_READB(field) \
+                            qtest_readb(ctrl->pdev->bus->qts, (uint64_t)&(field))
+
+        g_assert_cmpint(GUEST_MEM_READB(reqs[i].phys_identify->ieee[0]), ==, 0x0);
+        g_assert_cmpint(GUEST_MEM_READB(reqs[i].phys_identify->ieee[1]), ==, 0x54);
+        g_assert_cmpint(GUEST_MEM_READB(reqs[i].phys_identify->ieee[2]), ==, 0x52);
+
+        #undef GUEST_MEM_READB
+
+        guest_free(ctrl->alloc, (uint64_t)reqs[i].phys_identify);
+    }
+}
+
+static void test_migrate(void *obj, void *data, QGuestAllocator *alloc)
+{
+    g_autofree gchar *tmpfs = NULL;
+    GError *err = NULL;
+    g_autofree gchar *mig_path;
+    g_autofree gchar *uri;
+    GString *dest_cmdline;
+    QTestState *to;
+    QDict *rsp;
+    QNvme *nvme = obj;
+    QPCIDevice *pdev = &nvme->dev;
+    nvme_ctrl *ctrl;
+    test_migrate_req test_reqs[] = {
+        { 123, true },
+        { 456, false },
+        { 300, false },
+        { 333, false }
+    };
+
+    /* create temporary dir and prepare unix socket path for migration */
+    tmpfs = g_dir_make_tmp("nvme-test-XXXXXX", &err);
+    if (!tmpfs) {
+        g_test_message("Can't create temporary directory in %s: %s",
+                       g_get_tmp_dir(), err->message);
+        g_error_free(err);
+    }
+    g_assert(tmpfs);
+
+    mig_path = g_strdup_printf("%s/socket.mig", tmpfs);
+    uri = g_strdup_printf("unix:%s", mig_path);
+
+    /* enable NVMe PCI device */
+    qpci_device_enable(pdev);
+
+    ctrl = g_malloc0(sizeof(*ctrl));
+    ctrl->alloc = alloc;
+    ctrl->pdev = pdev;
+    ctrl->bar = qpci_iomap(ctrl->pdev, 0, NULL);
+    g_assert(pdev->bus->qts == global_qtest);
+
+    test_migrate_setup_nvme_ctrl(ctrl);
+    test_migrate_send_nvme_reqs(ctrl, test_reqs, ARRAY_SIZE(test_reqs));
+
+    qpci_iounmap(ctrl->pdev, ctrl->bar);
+
+    dest_cmdline = g_string_new(qos_get_current_command_line());
+    g_string_append_printf(dest_cmdline, " -incoming %s", uri);
+
+    /* Create destination VM */
+    to = qtest_init(dest_cmdline->str);
+
+    /* Get access to PCI device from destination VM */
+    nvme = qos_allocate_objects(to, &ctrl->alloc);
+    pdev = &nvme->dev;
+    ctrl->pdev = pdev;
+    ctrl->bar = qpci_iomap(ctrl->pdev, 0, NULL);
+    g_assert(pdev->bus->qts == to);
+
+    /* Migrate VM */
+    rsp = qmp("{ 'execute': 'migrate', 'arguments': { 'uri': %s } }", uri);
+    g_assert(qdict_haskey(rsp, "return"));
+    qobject_unref(rsp);
+
+    /* Wait when source VM is stopped */
+    qmp_eventwait("STOP");
+
+    /* Copy guest physical memory allocator state */
+    migrate_allocator(alloc, ctrl->alloc);
+
+    /* Wait for destination VM to become alive */
+    qtest_qmp_eventwait(to, "RESUME");
+
+    test_migrate_check_nvme(ctrl, test_reqs, ARRAY_SIZE(test_reqs));
+
+    qpci_iounmap(ctrl->pdev, ctrl->bar);
+
+    qtest_quit(to);
+    g_unlink(mig_path);
+    g_rmdir(tmpfs);
+    g_string_free(dest_cmdline, true);
+}
+
 static void nvme_register_nodes(void)
 {
     QOSGraphEdgeOptions opts = {
@@ -168,6 +559,8 @@ static void nvme_register_nodes(void)
     });
 
     qos_add_test("reg-read", "nvme", nvmetest_reg_read_test, NULL);
+
+    qos_add_test("migrate", "nvme", test_migrate, NULL);
 }
 
 libqos_init(nvme_register_nodes);
-- 
2.47.3


