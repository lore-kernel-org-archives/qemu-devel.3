Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 349F0C5CFCF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:31:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpN9-000863-4G; Tue, 11 Aug 2026 12:30:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpMc-0007SV-Kd
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:30:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpMU-0000AN-Ly
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:30:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jl0zY/Wa96t6B9T7JaNvnxtWJoeA7k/H6Kmge1TwMl0=;
 b=NLzH7F8qQHG/8k0HljYc6TO6DTNihyiHBOlx10vYEuD2ZBouLvTq95Z9j5SfCvTUthl0br
 Z6N65h0hknAYwVfm3ozTk6rFLbUm0+n2E8r/ZE/129ghz9ef4crw1rjy467EdTte7q87Nk
 r/fzW5q3idyS3FQxBBl2ZMcRwGh90HU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-Q1_j8ub6Ose-B37w0LEHxg-1; Tue,
 11 Aug 2026 12:29:53 -0400
X-MC-Unique: Q1_j8ub6Ose-B37w0LEHxg-1
X-Mimecast-MFC-AGG-ID: Q1_j8ub6Ose-B37w0LEHxg_1786465792
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DAF9C18001D7; Tue, 11 Aug 2026 16:29:51 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E658D195DF91; Tue, 11 Aug 2026 16:29:49 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 04/83] hw/usb/hcd-ehci: Change descriptor addresses to 64-bit
 with migration compatibility
Date: Tue, 11 Aug 2026 18:28:19 +0200
Message-ID: <20260811162938.1403216-5-clg@redhat.com>
In-Reply-To: <20260811162938.1403216-1-clg@redhat.com>
References: <20260811162938.1403216-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

Change internal EHCI descriptor addresses from uint32_t to uint64_t.

The following fields are updated:
- EHCIPacket::qtdaddr
- EHCIQueue::{qhaddr, qtdaddr}
- EHCIState::{a_fetch_addr, p_fetch_addr}

Update get_dwords() and put_dwords() to take 64-bit addresses and
propagate the type change through the descriptor traversal paths.

Adjust NLPTR_GET() to operate on 64-bit values:

    #define NLPTR_GET(x) ((x) & ~0x1fULL)

so that link pointer masking works correctly when descriptor
addresses exceed 32-bit space. The previous mask (0xffffffe0)
implicitly truncated addresses to 32 bits.

This patch does not change the on-wire descriptor layout yet.
It only removes the internal 32-bit address limit and prepares
for later patches that will add full 64-bit QH/qTD/iTD/siTD support.

Update the EHCI trace-events prototypes for QH, qTD, iTD, and siTD to
use uint64_t for the address argument and print it with PRIx64. This
ensures full 64-bit addresses are shown in trace output and improves
debugging of queue heads and transfer descriptors.

Migration compatibility:

To preserve backward migration compatibility, keep the legacy 32-bit
fetch address fields (a_fetch_addr_32, p_fetch_addr_32) alongside the
new 64-bit fields.

Migration format is selected using a machine compat property
"x-migrate-fetch-addr-64bit":

- Old machine types migrate 32-bit fetch addresses
- New machine types migrate full 64-bit fetch addresses

This is implemented using VMSTATE_UINT32_TEST() and
VMSTATE_UINT64_TEST() so that only the appropriate format is migrated.

In pre_save, the 32-bit shadow fields are populated when migrating
to old machine types. In post_load, the 32-bit values are restored
into the 64-bit fields when loading old migration streams.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260713032704.3583103-2-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/usb/hcd-ehci.h   | 30 +++++++++++++-----
 hw/core/machine.c   |  2 ++
 hw/usb/hcd-ehci.c   | 74 +++++++++++++++++++++++++++++++--------------
 hw/usb/trace-events | 24 +++++++--------
 4 files changed, 89 insertions(+), 41 deletions(-)

diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
index d038ee1e310c..cbc32c296df6 100644
--- a/hw/usb/hcd-ehci.h
+++ b/hw/usb/hcd-ehci.h
@@ -208,7 +208,7 @@ struct EHCIPacket {
     QTAILQ_ENTRY(EHCIPacket) next;
 
     EHCIqtd qtd;           /* copy of current QTD (being worked on) */
-    uint32_t qtdaddr;      /* address QTD read from                 */
+    uint64_t qtdaddr;      /* address QTD read from                 */
 
     USBPacket packet;
     QEMUSGList sgl;
@@ -229,8 +229,8 @@ struct EHCIQueue {
      * when guest removes an entry (doorbell, handshake sequence)
      */
     EHCIqh qh;             /* copy of current QH (being worked on) */
-    uint32_t qhaddr;       /* address QH read from                 */
-    uint32_t qtdaddr;      /* address QTD read from                */
+    uint64_t qhaddr;       /* address QH read from                 */
+    uint64_t qtdaddr;      /* address QTD read from                */
     int last_pid;          /* pid of last packet executed          */
     USBDevice *dev;
     QTAILQ_HEAD(, EHCIPacket) packets;
@@ -256,6 +256,11 @@ struct EHCIState {
 
     /* properties */
     uint32_t maxframes;
+    /*
+     * Controls migration stream compatibility for old machine types.
+     * Old machine types only transfer 32-bit fetch addresses.
+     */
+    bool migrate_fetch_addr_64bit;
 
     /*
      *  EHCI spec version 1.0 Section 2.3
@@ -293,9 +298,18 @@ struct EHCIState {
     EHCIQueueHead aqueues;
     EHCIQueueHead pqueues;
 
-    /* which address to look at next */
-    uint32_t a_fetch_addr;
-    uint32_t p_fetch_addr;
+    /*
+     * which address to look at next
+     *
+     * Migration compatibility fields for old machine types that only
+     * support 32-bit fetch addresses in the migration stream.
+     *
+     * New machine types migrate the full 64-bit runtime fetch address.
+     */
+    uint32_t migrate_a_fetch_addr;
+    uint32_t migrate_p_fetch_addr;
+    uint64_t a_fetch_addr;
+    uint64_t p_fetch_addr;
 
     USBPacket ipacket;
     QEMUSGList isgl;
@@ -308,7 +322,9 @@ struct EHCIState {
 };
 
 #define DEFINE_EHCI_COMMON_PROPERTIES(_state) \
-    DEFINE_PROP_UINT32("maxframes", _state, ehci.maxframes, 128)
+    DEFINE_PROP_UINT32("maxframes", _state, ehci.maxframes, 128), \
+    DEFINE_PROP_BOOL("x-migrate-fetch-addr-64bit", _state, \
+                     ehci.migrate_fetch_addr_64bit, true)
 
 extern const VMStateDescription vmstate_ehci;
 
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 73b4d82b4a1d..eb5e3809d6d1 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -51,6 +51,8 @@ GlobalProperty hw_compat_11_0[] = {
     { TYPE_ARM_SMMUV3, "ssidsize", "0" },
     { TYPE_ARM_SMMUV3, "oas", "44" },
     { "migration", "switchover-ack-legacy", "on" },
+    { "sysbus-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },
+    { "pci-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },
 };
 const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
 
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index 28a60e4c1a78..1a0c58011539 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -72,7 +72,7 @@ typedef enum {
 } EHCI_STATES;
 
 /* macros for accessing fields within next link pointer entry */
-#define NLPTR_GET(x)             ((x) & 0xffffffe0)
+#define NLPTR_GET(x)             ((x) & ~0x1fULL)
 #define NLPTR_TYPE_GET(x)        (((x) >> 1) & 3)
 #define NLPTR_TBIT(x)            ((x) & 1)  /* 1=invalid, 0=valid */
 
@@ -287,7 +287,7 @@ static int ehci_get_state(EHCIState *s, int async)
     return async ? s->astate : s->pstate;
 }
 
-static void ehci_set_fetch_addr(EHCIState *s, int async, uint32_t addr)
+static void ehci_set_fetch_addr(EHCIState *s, int async, uint64_t addr)
 {
     if (async) {
         s->a_fetch_addr = addr;
@@ -296,7 +296,7 @@ static void ehci_set_fetch_addr(EHCIState *s, int async, uint32_t addr)
     }
 }
 
-static int ehci_get_fetch_addr(EHCIState *s, int async)
+static uint64_t ehci_get_fetch_addr(EHCIState *s, int async)
 {
     return async ? s->a_fetch_addr : s->p_fetch_addr;
 }
@@ -373,7 +373,7 @@ static inline bool ehci_periodic_enabled(EHCIState *s)
 }
 
 /* Get an array of dwords from main memory */
-static inline int get_dwords(EHCIState *ehci, uint32_t addr,
+static inline int get_dwords(EHCIState *ehci, uint64_t addr,
                              uint32_t *buf, int num)
 {
     int i;
@@ -395,7 +395,7 @@ static inline int get_dwords(EHCIState *ehci, uint32_t addr,
 }
 
 /* Put an array of dwords in to main memory */
-static inline int put_dwords(EHCIState *ehci, uint32_t addr,
+static inline int put_dwords(EHCIState *ehci, uint64_t addr,
                              uint32_t *buf, int num)
 {
     int i;
@@ -549,7 +549,7 @@ static void ehci_free_packet(EHCIPacket *p)
 
 /* queue management */
 
-static EHCIQueue *ehci_alloc_queue(EHCIState *ehci, uint32_t addr, int async)
+static EHCIQueue *ehci_alloc_queue(EHCIState *ehci, uint64_t addr, int async)
 {
     EHCIQueueHead *head = async ? &ehci->aqueues : &ehci->pqueues;
     EHCIQueue *q;
@@ -622,7 +622,7 @@ static void ehci_free_queue(EHCIQueue *q, const char *warn)
     g_free(q);
 }
 
-static EHCIQueue *ehci_find_queue_by_qh(EHCIState *ehci, uint32_t addr,
+static EHCIQueue *ehci_find_queue_by_qh(EHCIState *ehci, uint64_t addr,
                                         int async)
 {
     EHCIQueueHead *head = async ? &ehci->aqueues : &ehci->pqueues;
@@ -1135,7 +1135,7 @@ static void ehci_flush_qh(EHCIQueue *q)
 {
     uint32_t *qh = (uint32_t *) &q->qh;
     uint32_t dwords = sizeof(EHCIqh) >> 2;
-    uint32_t addr = NLPTR_GET(q->qhaddr);
+    uint64_t addr = NLPTR_GET(q->qhaddr);
 
     put_dwords(q->ehci, addr + 3 * sizeof(uint32_t), qh + 3, dwords - 3);
 }
@@ -1406,12 +1406,13 @@ static int ehci_execute(EHCIPacket *p, const char *action)
 /* 4.7.2 */
 static int ehci_process_itd(EHCIState *ehci,
                             EHCIitd *itd,
-                            uint32_t addr)
+                            uint64_t addr)
 {
     USBDevice *dev;
     USBEndpoint *ep;
     uint32_t i, len, pid, dir, devaddr, endp;
-    uint32_t pg, off, ptr1, ptr2, max, mult;
+    uint32_t pg, off, max, mult;
+    uint64_t ptr1, ptr2;
 
     ehci->periodic_sched_active = PERIODIC_ACTIVE;
 
@@ -1528,7 +1529,7 @@ static int ehci_state_waitlisthead(EHCIState *ehci,  int async)
     EHCIqh qh;
     int i = 0;
     int again = 0;
-    uint32_t entry = ehci->asynclistaddr;
+    uint64_t entry = ehci->asynclistaddr;
 
     /* set reclamation flag at start event (4.8.6) */
     if (async) {
@@ -1578,7 +1579,7 @@ out:
 static int ehci_state_fetchentry(EHCIState *ehci, int async)
 {
     int again = 0;
-    uint32_t entry = ehci_get_fetch_addr(ehci, async);
+    uint64_t entry = ehci_get_fetch_addr(ehci, async);
 
     if (NLPTR_TBIT(entry)) {
         ehci_set_state(ehci, async, EST_ACTIVE);
@@ -1611,8 +1612,8 @@ static int ehci_state_fetchentry(EHCIState *ehci, int async)
     default:
         /* TODO: handle FSTN type */
         qemu_log_mask(LOG_GUEST_ERROR,
-                      "FETCHENTRY: entry at 0x%x is of type %u "
-                      "which is not supported yet\n",
+                      "FETCHENTRY: entry at %" PRIx64 " is of type %" PRIu64
+                      " which is not supported yet\n",
                       entry, NLPTR_TYPE_GET(entry));
         return -1;
     }
@@ -1623,7 +1624,7 @@ out:
 
 static EHCIQueue *ehci_state_fetchqh(EHCIState *ehci, int async)
 {
-    uint32_t entry;
+    uint64_t entry;
     EHCIQueue *q;
     EHCIqh qh;
 
@@ -1712,7 +1713,7 @@ out:
 
 static int ehci_state_fetchitd(EHCIState *ehci, int async)
 {
-    uint32_t entry;
+    uint64_t entry;
     EHCIitd itd;
 
     assert(!async);
@@ -1738,7 +1739,7 @@ static int ehci_state_fetchitd(EHCIState *ehci, int async)
 
 static int ehci_state_fetchsitd(EHCIState *ehci, int async)
 {
-    uint32_t entry;
+    uint64_t entry;
     EHCIsitd sitd;
 
     assert(!async);
@@ -1802,7 +1803,7 @@ static int ehci_state_fetchqtd(EHCIQueue *q)
     EHCIqtd qtd;
     EHCIPacket *p;
     int again = 1;
-    uint32_t addr;
+    uint64_t addr;
 
     addr = NLPTR_GET(q->qtdaddr);
     if (get_dwords(q->ehci, addr +  8, &qtd.token,   1) < 0) {
@@ -1885,7 +1886,7 @@ static int ehci_fill_queue(EHCIPacket *p)
     USBEndpoint *ep = p->packet.ep;
     EHCIQueue *q = p->queue;
     EHCIqtd qtd = p->qtd;
-    uint32_t qtdaddr;
+    uint64_t qtdaddr;
 
     for (;;) {
         if (NLPTR_TBIT(qtd.next) != 0) {
@@ -2008,7 +2009,8 @@ static int ehci_state_executing(EHCIQueue *q)
 static int ehci_state_writeback(EHCIQueue *q)
 {
     EHCIPacket *p = QTAILQ_FIRST(&q->packets);
-    uint32_t *qtd, addr;
+    uint32_t *qtd;
+    uint64_t addr;
     int again = 0;
 
     /*  Write back the QTD from the QH area */
@@ -2414,6 +2416,18 @@ static USBBusOps ehci_bus_ops_standalone = {
     .wakeup_endpoint = ehci_wakeup_endpoint,
 };
 
+static bool ehci_fetch_addr_64_needed(void *opaque, int version_id)
+{
+    EHCIState *s = opaque;
+
+    return s->migrate_fetch_addr_64bit;
+}
+
+static bool ehci_fetch_addr_32_needed(void *opaque, int version_id)
+{
+    return !ehci_fetch_addr_64_needed(opaque, version_id);
+}
+
 static int usb_ehci_pre_save(void *opaque)
 {
     EHCIState *ehci = opaque;
@@ -2424,6 +2438,11 @@ static int usb_ehci_pre_save(void *opaque)
     ehci->last_run_ns -= (ehci->frindex - new_frindex) * UFRAME_TIMER_NS;
     ehci->frindex = new_frindex;
 
+    if (!ehci->migrate_fetch_addr_64bit) {
+        ehci->migrate_a_fetch_addr = ehci->a_fetch_addr;
+        ehci->migrate_p_fetch_addr = ehci->p_fetch_addr;
+    }
+
     return 0;
 }
 
@@ -2444,6 +2463,11 @@ static int usb_ehci_post_load(void *opaque, int version_id)
         }
     }
 
+    if (!s->migrate_fetch_addr_64bit) {
+        s->a_fetch_addr = s->migrate_a_fetch_addr;
+        s->p_fetch_addr = s->migrate_p_fetch_addr;
+    }
+
     return 0;
 }
 
@@ -2504,8 +2528,14 @@ const VMStateDescription vmstate_ehci = {
         /* schedule state */
         VMSTATE_UINT32(astate, EHCIState),
         VMSTATE_UINT32(pstate, EHCIState),
-        VMSTATE_UINT32(a_fetch_addr, EHCIState),
-        VMSTATE_UINT32(p_fetch_addr, EHCIState),
+        VMSTATE_UINT32_TEST(migrate_a_fetch_addr, EHCIState,
+                            ehci_fetch_addr_32_needed),
+        VMSTATE_UINT32_TEST(migrate_p_fetch_addr, EHCIState,
+                            ehci_fetch_addr_32_needed),
+        VMSTATE_UINT64_TEST(a_fetch_addr, EHCIState,
+                            ehci_fetch_addr_64_needed),
+        VMSTATE_UINT64_TEST(p_fetch_addr, EHCIState,
+                            ehci_fetch_addr_64_needed),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/hw/usb/trace-events b/hw/usb/trace-events
index 0d4318dcf143..8c90688bb3e7 100644
--- a/hw/usb/trace-events
+++ b/hw/usb/trace-events
@@ -86,15 +86,15 @@ usb_ehci_portsc_write(uint32_t addr, uint32_t port, uint32_t val) "wr mmio 0x%04
 usb_ehci_portsc_change(uint32_t addr, uint32_t port, uint32_t new, uint32_t old) "ch mmio 0x%04x [port %d] = 0x%x (old: 0x%x)"
 usb_ehci_usbsts(const char *sts, int state) "usbsts %s %d"
 usb_ehci_state(const char *schedule, const char *state) "%s schedule %s"
-usb_ehci_qh_ptrs(void *q, uint32_t addr, uint32_t nxt, uint32_t c_qtd, uint32_t n_qtd, uint32_t a_qtd) "q %p - QH @ 0x%08x: next 0x%08x qtds 0x%08x,0x%08x,0x%08x"
-usb_ehci_qh_fields(uint32_t addr, int rl, int mplen, int eps, int ep, int devaddr) "QH @ 0x%08x - rl %d, mplen %d, eps %d, ep %d, dev %d"
-usb_ehci_qh_bits(uint32_t addr, int c, int h, int dtc, int i) "QH @ 0x%08x - c %d, h %d, dtc %d, i %d"
+usb_ehci_qh_ptrs(void *q, uint64_t addr, uint32_t nxt, uint32_t c_qtd, uint32_t n_qtd, uint32_t a_qtd) "q %p - QH @ 0x%" PRIx64 ": next 0x%08x qtds 0x%08x,0x%08x,0x%08x"
+usb_ehci_qh_fields(uint64_t addr, int rl, int mplen, int eps, int ep, int devaddr) "QH @ 0x%" PRIx64 " - rl %d, mplen %d, eps %d, ep %d, dev %d"
+usb_ehci_qh_bits(uint64_t addr, int c, int h, int dtc, int i) "QH @ 0x%" PRIx64 " - c %d, h %d, dtc %d, i %d"
 usb_ehci_qh_tbytes(uint32_t tbytes) "updating tbytes to %d"
-usb_ehci_qtd_ptrs(void *q, uint32_t addr, uint32_t nxt, uint32_t altnext) "q %p - QTD @ 0x%08x: next 0x%08x altnext 0x%08x"
-usb_ehci_qtd_fields(uint32_t addr, int tbytes, int cpage, int cerr, int pid) "QTD @ 0x%08x - tbytes %d, cpage %d, cerr %d, pid %d"
-usb_ehci_qtd_bits(uint32_t addr, int ioc, int active, int halt, int babble, int xacterr) "QTD @ 0x%08x - ioc %d, active %d, halt %d, babble %d, xacterr %d"
-usb_ehci_itd(uint32_t addr, uint32_t nxt, uint32_t mplen, uint32_t mult, uint32_t ep, uint32_t devaddr) "ITD @ 0x%08x: next 0x%08x - mplen %d, mult %d, ep %d, dev %d"
-usb_ehci_sitd(uint32_t addr, uint32_t nxt, uint32_t active) "ITD @ 0x%08x: next 0x%08x - active %d"
+usb_ehci_qtd_ptrs(void *q, uint64_t addr, uint32_t nxt, uint32_t altnext) "q %p - QTD @ 0x%" PRIx64 ": next 0x%08x altnext 0x%08x"
+usb_ehci_qtd_fields(uint64_t addr, int tbytes, int cpage, int cerr, int pid) "QTD @ 0x%" PRIx64 " - tbytes %d, cpage %d, cerr %d, pid %d"
+usb_ehci_qtd_bits(uint64_t addr, int ioc, int active, int halt, int babble, int xacterr) "QTD @ 0x%" PRIx64 " - ioc %d, active %d, halt %d, babble %d, xacterr %d"
+usb_ehci_itd(uint64_t addr, uint32_t nxt, uint32_t mplen, uint32_t mult, uint32_t ep, uint32_t devaddr) "ITD @ 0x%" PRIx64 ": next 0x%08x - mplen %d, mult %d, ep %d, dev %d"
+usb_ehci_sitd(uint64_t addr, uint32_t nxt, uint32_t active) "SITD @ 0x%" PRIx64 ": next 0x%08x - active %d"
 usb_ehci_port_attach(uint32_t port, const char *owner, const char *device) "attach port #%d, owner %s, device %s"
 usb_ehci_port_detach(uint32_t port, const char *owner) "detach port #%d, owner %s"
 usb_ehci_port_reset(uint32_t port, int enable) "reset port #%d - %d"
@@ -104,15 +104,15 @@ usb_ehci_port_resume(uint32_t port) "port #%d"
 usb_ehci_port_disable(uint32_t port) "port #%d"
 usb_ehci_queue_action(void *q, const char *action) "q %p: %s"
 usb_ehci_packet_action(void *q, void *p, const char *action) "q %p p %p: %s"
-usb_ehci_packet_submit(uint32_t qhaddr, uint32_t next, uint32_t qtdaddr, int pid, size_t len, int endp, int status, int actual_length) "qh=0x%x, next=0x%x, qtd=0x%x, pid=0x%x, len=%zd, endp=0x%x, status=%d, actual_length=%d"
+usb_ehci_packet_submit(uint64_t qhaddr, uint32_t next, uint64_t qtdaddr, int pid, size_t len, int endp, int status, int actual_length) "qh=0x%" PRIx64 ", next=0x%x, qtd=0x%" PRIx64 ", pid=0x%x, len=%zd, endp=0x%x, status=%d, actual_length=%d"
 usb_ehci_irq(uint32_t level, uint32_t frindex, uint32_t sts, uint32_t mask) "level %d, frindex 0x%04x, sts 0x%x, mask 0x%x"
 usb_ehci_guest_bug(const char *reason) "%s"
 usb_ehci_doorbell_ring(void) ""
 usb_ehci_doorbell_ack(void) ""
 usb_ehci_dma_error(void) ""
-usb_ehci_execute_complete(uint32_t qhaddr, uint32_t next, uint32_t qtdaddr, int status, int actual_length) "qhaddr=0x%x, next=0x%x, qtdaddr=0x%x, status=%d, actual_length=%d"
-usb_ehci_fetchqh_reclaim_done(uint32_t qhaddr) "QH 0x%08x H-bit set, reclamation status reset - done processing"
-usb_ehci_fetchqh_dbg(uint32_t qhaddr, uint32_t h, uint32_t halt, uint32_t active, uint32_t next) "QH 0x%08x (h 0x%x halt 0x%x active 0x%x) next 0x%08x"
+usb_ehci_execute_complete(uint64_t qhaddr, uint32_t next, uint64_t qtdaddr, int status, int actual_length) "qhaddr=0x%" PRIx64 ", next=0x%x, qtdaddr=0x%" PRIx64 ", status=%d, actual_length=%d"
+usb_ehci_fetchqh_reclaim_done(uint64_t qhaddr) "QH 0x%" PRIx64 " H-bit set, reclamation status reset - done processing"
+usb_ehci_fetchqh_dbg(uint64_t qhaddr, uint32_t h, uint32_t halt, uint32_t active, uint32_t next) "QH 0x%" PRIx64 " (h 0x%x halt 0x%x active 0x%x) next 0x%08x"
 usb_ehci_periodic_state_advance(uint32_t frame, uint32_t list, uint32_t entry) "frame=%d, list=0x%x, entry=0x%x"
 usb_ehci_skipped_uframes(uint64_t skipped_uframes) "skipped %" PRIu64 " uframes"
 usb_ehci_log(const char *msg) "%s"
-- 
2.55.0


