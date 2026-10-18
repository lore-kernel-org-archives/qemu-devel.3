Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E37CCF2C9
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2026 05:18:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIJI7-0000YV-NU; Sun, 18 Oct 2026 01:18:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1xIJI2-0000TS-Fo
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 01:18:35 -0400
Received: from nx182.node02.secure-mailgate.com ([192.162.87.182])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1xIJHy-0001BO-Rr
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 01:18:33 -0400
Received: from web279.dogado.net ([31.47.255.59])
 by node02.secure-mailgate.com with esmtps (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.94.2) (envelope-from <christian@quante.one>)
 id 1xIJHt-0008mf-Rg; Sun, 18 Oct 2026 07:18:27 +0200
Received: from Zeuss.fritz.box (p57b2fda0.dip0.t-ipconnect.de [87.178.253.160])
 (Authenticated sender: christian@quante.one)
 by web279.dogado.net (Postfix) with ESMTPSA id A517928249E;
 Sun, 18 Oct 2026 07:18:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quante.one;
 s=cloudpit; t=1792300705;
 bh=fj+B4TVvzgcaXjc/Pik+wmv8Jmpna0uKhAO5LFLC6YU=;
 h=From:To:Cc:Subject:Date:From;
 b=ik/mOoCmMkP1PzhQYEa0OvuVRoLz/AFlvkI6sW6z8Uw4sQ6VZ+qLoa5WmWJUPcxX1
 HjA1btQCVaUaqpWe4e6YaNBiVm2VQb7bDI6mn6vXGA1sshPLPRmrlnW3CN7+VAAP3v
 DMPgJF6J/LB7YSpyMMOeWawtm9U9alCR7ts00Hyk=
X-SecureMailgate-Identity: christian@quante.one;web279.dogado.net
From: Christian Quante <christian@quante.one>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Peter Xu <peterx@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Subject: [PATCH] system/memory: keep coalesced MMIO zones when RAM is mapped
 over them
Date: Sun, 18 Oct 2026 07:18:11 +0200
Message-ID: <20261018051813.12379-1-christian@quante.one>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <179230070515.399742.2342974060394009137@web279.dogado.net>
X-PPP-Vhost: quante.one
X-Originating-IP: 31.47.255.59
X-SecureMailgate-Domain: web279.dogado.net
X-SecureMailgate-Username: 31.47.255.59
Authentication-Results: secure-mailgate.com;
 auth=pass smtp.auth=31.47.255.59@web279.dogado.net
X-SecureMailgate-Outgoing-Class: ham
X-SecureMailgate-Outgoing-Evidence: SB/global_tokens (1.85956616366e-06)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuW3wPy++XY7xCkxKc0LiunQkxkAUfNyhJyD
 tVaka2+oTSu2SmbhJN1U9FKs8X3+Nt1HOctZ5X+40a9IXddeG3M38JQYgcgjsac3uQcQdCX4ROfH
 zJ6mVE7ewsipSVIfs4adISu1MxHZVv9VNqlvgbZpS5+h1uiHzk/Rfxfh461YLyu3RZI1CD15pCOE
 1vk99RMgoMVb7lebWWPLzvZvEUCPdOtYechJ/ikE1WgRg4cS6A6B6pTstltS07kaQJ8I9sYal0h7
 43VOpKNY+4MjijihZK0EMmf3P50Ajf/tIX00Fuu2beRqilmjgQ6jA3UwYgm3QTha208ypFqQwBFb
 xm4JX7semJdl8Weuy8+tlMSTQwhoy9D5QZ6a84vJal7pM1XhlAOd290vPXa7Loma0jth+x0iJ0NX
 07iZIeUSWePdS+owFPr4kjXuZPwOU47Z9+s09nAWqoDs8zZa/KiCJd90Lk7053RUfwPXoECB9OvJ
 bLn1swB3T1pjkRB4Oin1jHhLJKN/2vrWxMo2o26o0qvS2LvKkambiqte5fzlaG3SxWFsAyId8SHb
 Cfn4Of0iS9xXYt2sLRbFsU6kQGWOTMYS31/E3ahF5MMcDI7KdpjQKan2U7ZgcTZllKur/pQUJIaP
 62wuydDkh8tfHJjBQ9REIK/1NH5THMtlYvyHAYGOGpWy0cyN8FWRzwSe4EFKYGNIvdGHXhtdYP1Z
 i1HkgdJMV4bWnQKOodYnULo2OnxrN/AmYYBVcnrFlwoNpg0qWXZlarNG9aCsHFVP39CopaUsB5hQ
 6nsDvccjqgmDvD9WhxPgVdc61dq1G8semuK7cffJmUgTQDSvcj2ycP8CA6qzQJajR4vlXL102p8r
 hkGjhZ9ohu/ssAude8XOICjh4eB/bgSBEAa0471ZSq8QjeAA7sgNPJdlMyuyKg6W1iTDUTtpQjB/
 E+b7Of58AZ/SMh0UHMjXuyUgi3KCvKEfjL6I4wjulufborR8FDCceIhjFlz1pRXWhjh9fdbl44I0
 Df0l2JKrqkzrdYax1j8kq9k8XdwJdE7zwH+JdV2ma6BQHkQNWfdv8Kozpx1IwFiVQxIzw2Sp5HCR
 RefMLpCVZC+EkqWv8KrtTa+BcuCE/OFcpvAZcJMXyXxXG5oZWE62IcEh3A0hdaJTz/++19ALCf98
 0J47sH4stohM5T5Jwri5PyfoiMstty+iVRobalIoISQUDLHLPgzzZtf6Jc5h8lOC
X-Report-Abuse-To: spam@node04.secure-mailgate.com
X-Complaints-To: abuse@node01.secure-mailgate.com
Received-SPF: pass client-ip=192.162.87.182; envelope-from=christian@quante.one;
 helo=nx182.node02.secure-mailgate.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

The coalesced MMIO zones of a region follow its flat ranges.  When RAM
is mapped over part of a coalesced region, the flat range of the region
changes, and the listeners get coalesced_io_del() for the old range and
coalesced_io_add() for the new one.  The VGA devices do this all the
time: they map RAM aliases of the video memory into the legacy window
0xa0000-0xbffff, which is coalesced, and remove them when the window
must be MMIO.  Cirrus does it for each BitBLT with source data from the
CPU and for write modes 4 and 5, among others.  The standard VGA does
it when it changes between planar and chain-4 modes, and for each VBE
bank switch.

For KVM, each change means KVM_UNREGISTER_COALESCED_MMIO and
KVM_REGISTER_COALESCED_MMIO, and the following KVM_SET_USER_MEMORY_REGION2
for the RAM alias then takes 1.4-2.2 ms instead of about 20 us (strace,
Linux 7.0).  The time is spent in the ioctl; I have not found out why.
But a zone under writable RAM has no effect for KVM, because accesses
to that RAM do not exit as MMIO.

So compute the coalesced zones of an address space from the whole flat
view, as it is done for the ioeventfds, and tell the listeners only
about the zones that really change.  A zone covers the parts where its
region is visible, and also the neighbouring flat ranges of writable
RAM in whole host pages, which KVM maps (kvm_align_section()).  So the
zones stay the same when the VGA window changes between RAM and MMIO.
Overlapping zones are merged, because KVM_UNREGISTER_COALESCED_MMIO
removes every zone that contains the given range
(virt/kvm/coalesced_mmio.c).  As before, zones are deleted before the
flat ranges change and added after that.  The zones are only kept for
address spaces with a listener that implements coalesced_io_add() or
coalesced_io_del().  The listeners get a MemoryRegionSection without a
MemoryRegion; the only users, the KVM listeners, do not use it.

This also replaces flat_range_coalesced_io_notify_listener_add_del(),
which stopped at the first coalesced range that does not intersect the
flat range.

With KVM, a boot sector test that switches the Cirrus window between
RAM and MMIO takes 73 us per switch instead of 2073 us.  A Cirrus BitBLT
with 4 bytes of source data from the CPU takes 176 us instead of
4076 us, and a VBE bank switch of the standard VGA 309 us instead of
4159 us.  A coalesced write to the window costs the same as before.

Signed-off-by: Christian Quante <christian@quante.one>
---

Notes:
    Tests on a Linux 7.0 (x86_64) host:
     - qtest-x86_64 (some of the slow tests use KVM) and unit tests: no
       failures.
     - Guests booted with KVM, with and without the patch: openSUSE
       Tumbleweed (q35, std VGA) to the desktop, also with e1000 (only with
       the patch); with vmware-svga to the boot loader (the screen dump does
       not show the Linux console).  Windows 10 (q35, std VGA): to the lock
       screen with the patch; without the patch I compared only the zone
       ioctls.  q35 with OVMF (flash): only the zones, without a boot disk.
       OS/2 Warp 3 (pc, isa-cirrus-vga, with my Cirrus patches; the first
       series is <20261018050643.9288-1-christian@quante.one>, the others
       follow).  With a debug print of the coalesced MMIO ioctls I replayed
       the register/unregister sequence the way KVM handles it: no
       overlapping zones, no unregister of an unknown zone, no unregister
       that removes more than one zone.  The PIO zones are the same as
       before; only the zones of the VGA window stay registered across the
       RAM alias changes (a Windows 10 boot did 115 registrations and 114
       unregistrations of them before, 2 and 1 now).
     - With KVM, OS/2 Warp 3 with its Cirrus driver opens a folder at once
       with the patch: from the first click of the double click until the
       folder is complete, it takes 0.41-0.42 s instead of 0.74-0.91 s.  The
       double click itself takes 0.4 s in my script; with TCG it also takes
       0.42 s.
     - Not tested: other architectures (vga-mmio), confidential guests.
       Windows NT 4.0 (also with SP6a) does not boot with KVM here, with or
       without the patch (STOP 0x0000000A in ntoskrnl.exe), so it is not
       in the list above.
    
    The kernel side (why the memory slot update after a coalesced zone change
    takes so long) I have not looked into.

 include/system/memory.h |  19 ++-
 system/memory.c         | 323 ++++++++++++++++++++++++++++------------
 2 files changed, 242 insertions(+), 100 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 027ca81bd2..fcfa3760e3 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -838,11 +838,14 @@ struct MemoryListener {
      * @coalesced_io_add:
      *
      * Called during an address space update transaction,
-     * for a section of the address space that has had a new coalesced
-     * MMIO range registration since the last transaction.
+     * for a range of the address space that has become coalesced
+     * since the last transaction.  The range can also cover writable
+     * RAM that is mapped over part of a coalesced MMIO region; accesses
+     * to that RAM are not MMIO, so the coalescing does not apply to them.
      *
      * @listener: The #MemoryListener.
-     * @section: The new #MemoryRegionSection.
+     * @section: The #MemoryRegionSection of the range (without a
+     *           #MemoryRegion).
      * @addr: The starting address for the coalesced MMIO range.
      * @len: The length of the coalesced MMIO range.
      */
@@ -853,11 +856,12 @@ struct MemoryListener {
      * @coalesced_io_del:
      *
      * Called during an address space update transaction,
-     * for a section of the address space that has dropped a coalesced
-     * MMIO range since the last transaction.
+     * for a range of the address space that is no longer coalesced.
+     * It is always a range that was passed to @coalesced_io_add before.
      *
      * @listener: The #MemoryListener.
-     * @section: The new #MemoryRegionSection.
+     * @section: The #MemoryRegionSection of the range (without a
+     *           #MemoryRegion).
      * @addr: The starting address for the coalesced MMIO range.
      * @len: The length of the coalesced MMIO range.
      */
@@ -908,6 +912,9 @@ struct AddressSpace {
     int ioeventfd_nb;
     int ioeventfd_notifiers;
     struct MemoryRegionIoeventfd *ioeventfds;
+    int coalesced_nb;
+    int coalesced_notifiers;
+    struct AddrRange *coalesced;
     QTAILQ_HEAD(, MemoryListener) listeners;
     QTAILQ_ENTRY(AddressSpace) address_spaces_link;
 
diff --git a/system/memory.c b/system/memory.c
index f1910af8a0..585c8b0a11 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -43,6 +43,7 @@
 static unsigned memory_region_transaction_depth;
 static bool memory_region_update_pending;
 static bool ioeventfd_update_pending;
+static bool coalesced_update_pending;
 unsigned int global_dirty_tracking;
 
 static QTAILQ_HEAD(, MemoryListener) memory_listeners
@@ -885,91 +886,206 @@ static void address_space_update_ioeventfds(AddressSpace *as)
 }
 
 /*
- * Notify the memory listeners about the coalesced IO change events of
- * range `cmr'.  Only the part that has intersection of the specified
- * FlatRange will be sent.
+ * Coalescing has no effect on writable RAM that the accelerator maps,
+ * because accesses to it are not MMIO.  KVM maps RAM only in whole host
+ * pages (kvm_align_section()).
  */
-static void flat_range_coalesced_io_notify(FlatRange *fr,
-                                           const AddressSpace *as,
-                                           CoalescedMemoryRange *cmr, bool add)
+static bool flat_range_ignores_coalescing(const FlatRange *fr)
 {
-    AddrRange tmp;
+    uint64_t page_size = qemu_real_host_page_size();
 
-    tmp = addrrange_shift(cmr->addr,
-                          int128_sub(fr->addr.start,
-                                     int128_make64(fr->offset_in_region)));
-    if (!addrrange_intersects(tmp, fr->addr)) {
-        return;
-    }
-    tmp = addrrange_intersection(tmp, fr->addr);
+    return memory_region_is_ram(fr->mr) && !fr->readonly &&
+           QEMU_IS_ALIGNED(int128_get64(fr->addr.start), page_size) &&
+           QEMU_IS_ALIGNED(int128_get64(fr->addr.size), page_size);
+}
 
-    if (add) {
-        MEMORY_LISTENER_UPDATE_REGION(fr, as, Forward, coalesced_io_add,
-                                      int128_get64(tmp.start),
-                                      int128_get64(tmp.size));
-    } else {
-        MEMORY_LISTENER_UPDATE_REGION(fr, as, Reverse, coalesced_io_del,
-                                      int128_get64(tmp.start),
-                                      int128_get64(tmp.size));
-    }
+/* Does @fr map @mr with the region start at address @base? */
+static bool flat_range_maps_region_at(const FlatRange *fr, MemoryRegion *mr,
+                                      Int128 base)
+{
+    return fr->mr == mr &&
+           int128_eq(int128_sub(fr->addr.start,
+                                int128_make64(fr->offset_in_region)), base);
 }
 
-static void flat_range_coalesced_io_del(FlatRange *fr, const AddressSpace *as)
+static int addrrange_cmp(const void *a, const void *b)
 {
-    CoalescedMemoryRange *cmr;
+    const AddrRange *r1 = a, *r2 = b;
 
-    QTAILQ_FOREACH(cmr, &fr->mr->coalesced, link) {
-        flat_range_coalesced_io_notify(fr, as, cmr, false);
+    if (!int128_eq(r1->start, r2->start)) {
+        return int128_lt(r1->start, r2->start) ? -1 : 1;
+    }
+    if (!int128_eq(r1->size, r2->size)) {
+        return int128_lt(r1->size, r2->size) ? -1 : 1;
     }
+    return 0;
 }
 
-static void flat_range_coalesced_io_add(FlatRange *fr, const AddressSpace *as)
+/*
+ * Compute the coalesced zones of @view, sorted and without overlaps.
+ *
+ * A coalesced range of a region covers the parts where the region is
+ * visible, and also the flat ranges next to them that ignore coalescing.
+ * So the zones do not change when RAM is mapped over part of a coalesced
+ * region and unmapped again, as the VGA window does with its bank aliases.
+ * Changing a zone is expensive for KVM.
+ */
+static unsigned flatview_get_coalesced(FlatView *view, AddrRange **pzones)
 {
-    MemoryRegion *mr = fr->mr;
-    CoalescedMemoryRange *cmr;
+    AddrRange *zones = NULL;
+    unsigned nb = 0, i, j;
 
-    if (QTAILQ_EMPTY(&mr->coalesced)) {
-        return;
+    for (i = 0; i < view->nr; i++) {
+        FlatRange *fr = &view->ranges[i];
+        CoalescedMemoryRange *cmr;
+        Int128 base;
+
+        if (QTAILQ_EMPTY(&fr->mr->coalesced)) {
+            continue;
+        }
+        base = int128_sub(fr->addr.start, int128_make64(fr->offset_in_region));
+        QTAILQ_FOREACH(cmr, &fr->mr->coalesced, link) {
+            AddrRange tmp = addrrange_shift(cmr->addr, base);
+            Int128 tmp_end = addrrange_end(tmp);
+            Int128 start, end;
+
+            if (!addrrange_intersects(tmp, fr->addr)) {
+                continue;
+            }
+            start = int128_max(tmp.start, fr->addr.start);
+            end = int128_min(tmp_end, addrrange_end(fr->addr));
+
+            for (j = i; j > 0 && int128_gt(start, tmp.start); j--) {
+                FlatRange *prev = &view->ranges[j - 1];
+
+                if (!int128_eq(addrrange_end(prev->addr), start) ||
+                    !(flat_range_maps_region_at(prev, fr->mr, base) ||
+                      flat_range_ignores_coalescing(prev))) {
+                    break;
+                }
+                start = int128_max(prev->addr.start, tmp.start);
+            }
+            for (j = i + 1; j < view->nr && int128_lt(end, tmp_end); j++) {
+                FlatRange *next = &view->ranges[j];
+
+                if (!int128_eq(next->addr.start, end) ||
+                    !(flat_range_maps_region_at(next, fr->mr, base) ||
+                      flat_range_ignores_coalescing(next))) {
+                    break;
+                }
+                end = int128_min(addrrange_end(next->addr), tmp_end);
+            }
+
+            zones = g_renew(AddrRange, zones, nb + 1);
+            zones[nb++] = addrrange_make(start, int128_sub(end, start));
+        }
     }
 
-    QTAILQ_FOREACH(cmr, &mr->coalesced, link) {
-        flat_range_coalesced_io_notify(fr, as, cmr, true);
+    /*
+     * Merge overlapping zones.  KVM_UNREGISTER_COALESCED_MMIO removes every
+     * zone that contains the given range, so a zone must not lie inside
+     * another one.
+     */
+    if (nb > 1) {
+        qsort(zones, nb, sizeof(*zones), addrrange_cmp);
     }
+    for (i = j = 0; i < nb; i++) {
+        if (j && int128_lt(zones[i].start, addrrange_end(zones[j - 1]))) {
+            Int128 end = int128_max(addrrange_end(zones[i]),
+                                    addrrange_end(zones[j - 1]));
+
+            zones[j - 1].size = int128_sub(end, zones[j - 1].start);
+        } else {
+            zones[j++] = zones[i];
+        }
+    }
+
+    *pzones = zones;
+    return j;
 }
 
-static void
-flat_range_coalesced_io_notify_listener_add_del(FlatRange *fr,
-                                                MemoryRegionSection *mrs,
-                                                MemoryListener *listener,
-                                                const AddressSpace *as,
-                                                bool add)
+/* Tell @listener about all coalesced zones of @as when it is (un)registered */
+static void listener_notify_coalesced(MemoryListener *listener,
+                                      const AddressSpace *as, FlatView *view,
+                                      bool add)
 {
-    CoalescedMemoryRange *cmr;
-    MemoryRegion *mr = fr->mr;
-    AddrRange tmp;
-
-    QTAILQ_FOREACH(cmr, &mr->coalesced, link) {
-        tmp = addrrange_shift(cmr->addr,
-                              int128_sub(fr->addr.start,
-                                         int128_make64(fr->offset_in_region)));
+    unsigned i;
 
-        if (!addrrange_intersects(tmp, fr->addr)) {
-            return;
-        }
-        tmp = addrrange_intersection(tmp, fr->addr);
+    for (i = 0; i < as->coalesced_nb; i++) {
+        hwaddr start = int128_get64(as->coalesced[i].start);
+        hwaddr size = int128_get64(as->coalesced[i].size);
+        MemoryRegionSection section = (MemoryRegionSection) {
+            .fv = view,
+            .offset_within_address_space = start,
+            .size = as->coalesced[i].size,
+        };
 
         if (add && listener->coalesced_io_add) {
-            listener->coalesced_io_add(listener, mrs,
-                                       int128_get64(tmp.start),
-                                       int128_get64(tmp.size));
+            listener->coalesced_io_add(listener, &section, start, size);
         } else if (!add && listener->coalesced_io_del) {
-            listener->coalesced_io_del(listener, mrs,
-                                       int128_get64(tmp.start),
-                                       int128_get64(tmp.size));
+            listener->coalesced_io_del(listener, &section, start, size);
         }
     }
 }
 
+/*
+ * Tell the listeners of @as about each zone of @zones that is not in
+ * @other: as added zones if @add, else as dropped zones.
+ */
+static void address_space_notify_coalesced(AddressSpace *as, FlatView *view,
+                                           AddrRange *zones, unsigned nb,
+                                           AddrRange *other, unsigned other_nb,
+                                           bool add)
+{
+    MemoryRegionSection section;
+    unsigned i, j = 0;
+
+    for (i = 0; i < nb; i++) {
+        while (j < other_nb && addrrange_cmp(&other[j], &zones[i]) < 0) {
+            j++;
+        }
+        if (j < other_nb && addrrange_equal(other[j], zones[i])) {
+            continue;
+        }
+        section = (MemoryRegionSection) {
+            .fv = view,
+            .offset_within_address_space = int128_get64(zones[i].start),
+            .size = zones[i].size,
+        };
+        if (add) {
+            MEMORY_LISTENER_CALL(as, coalesced_io_add, Forward, &section,
+                                 int128_get64(zones[i].start),
+                                 int128_get64(zones[i].size));
+        } else {
+            MEMORY_LISTENER_CALL(as, coalesced_io_del, Reverse, &section,
+                                 int128_get64(zones[i].start),
+                                 int128_get64(zones[i].size));
+        }
+    }
+}
+
+static void address_space_update_coalesced(AddressSpace *as)
+{
+    FlatView *view;
+    AddrRange *zones;
+    unsigned nb;
+
+    if (!as->coalesced_notifiers) {
+        return;
+    }
+
+    view = address_space_get_flatview(as);
+    nb = flatview_get_coalesced(view, &zones);
+    address_space_notify_coalesced(as, view, as->coalesced, as->coalesced_nb,
+                                   zones, nb, false);
+    address_space_notify_coalesced(as, view, zones, nb,
+                                   as->coalesced, as->coalesced_nb, true);
+    g_free(as->coalesced);
+    as->coalesced = zones;
+    as->coalesced_nb = nb;
+    flatview_unref(view);
+}
+
 static void address_space_update_topology_pass(AddressSpace *as,
                                                const FlatView *old_view,
                                                const FlatView *new_view,
@@ -1002,7 +1118,6 @@ static void address_space_update_topology_pass(AddressSpace *as,
             /* In old but not in new, or in both but attributes changed. */
 
             if (!adding) {
-                flat_range_coalesced_io_del(frold, as);
                 MEMORY_LISTENER_UPDATE_REGION(frold, as, Reverse, region_del);
             }
 
@@ -1031,7 +1146,6 @@ static void address_space_update_topology_pass(AddressSpace *as,
 
             if (adding) {
                 MEMORY_LISTENER_UPDATE_REGION(frnew, as, Forward, region_add);
-                flat_range_coalesced_io_add(frnew, as);
             }
 
             ++inew;
@@ -1101,12 +1215,27 @@ static void address_space_set_flatview(AddressSpace *as)
 
     if (!QTAILQ_EMPTY(&as->listeners)) {
         FlatView tmpview = { .nr = 0 }, *old_view2 = old_view;
+        AddrRange *zones = NULL;
+        unsigned nb = 0;
 
         if (!old_view2) {
             old_view2 = &tmpview;
         }
+        if (as->coalesced_notifiers) {
+            nb = flatview_get_coalesced(new_view, &zones);
+            address_space_notify_coalesced(as, old_view2, as->coalesced,
+                                           as->coalesced_nb, zones, nb, false);
+        }
         address_space_update_topology_pass(as, old_view2, new_view, false);
         address_space_update_topology_pass(as, old_view2, new_view, true);
+        if (as->coalesced_notifiers) {
+            address_space_notify_coalesced(as, new_view, zones, nb,
+                                           as->coalesced, as->coalesced_nb,
+                                           true);
+            g_free(as->coalesced);
+            as->coalesced = zones;
+            as->coalesced_nb = nb;
+        }
     }
 
     /* Writes are protected by the BQL.  */
@@ -1160,15 +1289,25 @@ void memory_region_transaction_commit(void)
             QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
                 address_space_set_flatview(as);
                 address_space_update_ioeventfds(as);
+                if (coalesced_update_pending) {
+                    address_space_update_coalesced(as);
+                }
             }
             memory_region_update_pending = false;
             ioeventfd_update_pending = false;
+            coalesced_update_pending = false;
             MEMORY_LISTENER_CALL_GLOBAL(commit, Forward);
-        } else if (ioeventfd_update_pending) {
+        } else if (ioeventfd_update_pending || coalesced_update_pending) {
             QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
-                address_space_update_ioeventfds(as);
+                if (ioeventfd_update_pending) {
+                    address_space_update_ioeventfds(as);
+                }
+                if (coalesced_update_pending) {
+                    address_space_update_coalesced(as);
+                }
             }
             ioeventfd_update_pending = false;
+            coalesced_update_pending = false;
         }
    }
 }
@@ -2330,29 +2469,6 @@ void memory_region_writeback(MemoryRegion *mr, hwaddr addr, hwaddr size)
     }
 }
 
-/*
- * Call proper memory listeners about the change on the newly
- * added/removed CoalescedMemoryRange.
- */
-static void memory_region_update_coalesced_range(MemoryRegion *mr,
-                                                 CoalescedMemoryRange *cmr,
-                                                 bool add)
-{
-    AddressSpace *as;
-    FlatView *view;
-    FlatRange *fr;
-
-    QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
-        view = address_space_get_flatview(as);
-        FOR_EACH_FLAT_RANGE(fr, view) {
-            if (fr->mr == mr) {
-                flat_range_coalesced_io_notify(fr, as, cmr, add);
-            }
-        }
-        flatview_unref(view);
-    }
-}
-
 void memory_region_set_coalescing(MemoryRegion *mr)
 {
     memory_region_clear_coalescing(mr);
@@ -2365,10 +2481,12 @@ void memory_region_add_coalescing(MemoryRegion *mr,
 {
     CoalescedMemoryRange *cmr = g_malloc(sizeof(*cmr));
 
+    memory_region_transaction_begin();
     cmr->addr = addrrange_make(int128_make64(offset), int128_make64(size));
     QTAILQ_INSERT_TAIL(&mr->coalesced, cmr, link);
-    memory_region_update_coalesced_range(mr, cmr, true);
     memory_region_set_flush_coalesced(mr);
+    coalesced_update_pending |= mr->enabled;
+    memory_region_transaction_commit();
 }
 
 void memory_region_clear_coalescing(MemoryRegion *mr)
@@ -2382,12 +2500,14 @@ void memory_region_clear_coalescing(MemoryRegion *mr)
     qemu_flush_coalesced_mmio_buffer();
     mr->flush_coalesced_mmio = false;
 
+    memory_region_transaction_begin();
     while (!QTAILQ_EMPTY(&mr->coalesced)) {
         cmr = QTAILQ_FIRST(&mr->coalesced);
         QTAILQ_REMOVE(&mr->coalesced, cmr, link);
-        memory_region_update_coalesced_range(mr, cmr, false);
         g_free(cmr);
     }
+    coalesced_update_pending |= mr->enabled;
+    memory_region_transaction_commit();
 }
 
 void memory_region_set_flush_coalesced(MemoryRegion *mr)
@@ -2936,15 +3056,13 @@ static void listener_add_address_space(MemoryListener *listener,
             listener->region_add(listener, &section);
         }
 
-        /* send coalesced io add notifications */
-        flat_range_coalesced_io_notify_listener_add_del(fr, &section,
-                                                        listener, as, true);
-
         if (fr->dirty_log_mask && listener->log_start) {
             listener->log_start(listener, &section, 0, fr->dirty_log_mask);
         }
     }
 
+    listener_notify_coalesced(listener, as, view, true);
+
     /*
      * register all eventfds for this address space for the newly registered
      * listener.
@@ -2981,6 +3099,7 @@ static void listener_del_address_space(MemoryListener *listener,
         listener->begin(listener);
     }
     view = address_space_get_flatview(as);
+    listener_notify_coalesced(listener, as, view, false);
     FOR_EACH_FLAT_RANGE(fr, view) {
         MemoryRegionSection section = section_from_flat_range(fr, view);
 
@@ -2988,9 +3107,6 @@ static void listener_del_address_space(MemoryListener *listener,
             listener->log_stop(listener, &section, fr->dirty_log_mask, 0);
         }
 
-        /* send coalesced io del notifications */
-        flat_range_coalesced_io_notify_listener_add_del(fr, &section,
-                                                        listener, as, false);
         if (listener->region_del) {
             listener->region_del(listener, &section);
         }
@@ -3052,6 +3168,15 @@ void memory_listener_register(MemoryListener *listener, AddressSpace *as)
         QTAILQ_INSERT_BEFORE(other, listener, link_as);
     }
 
+    if ((listener->coalesced_io_add || listener->coalesced_io_del) &&
+        !as->coalesced_notifiers++) {
+        /* The zones are only kept up to date while somebody needs them */
+        FlatView *view = address_space_get_flatview(as);
+
+        as->coalesced_nb = flatview_get_coalesced(view, &as->coalesced);
+        flatview_unref(view);
+    }
+
     listener_add_address_space(listener, as);
 
     if (listener->eventfd_add || listener->eventfd_del) {
@@ -3070,6 +3195,12 @@ void memory_listener_unregister(MemoryListener *listener)
     }
 
     listener_del_address_space(listener, listener->address_space);
+    if ((listener->coalesced_io_add || listener->coalesced_io_del) &&
+        !--listener->address_space->coalesced_notifiers) {
+        g_free(listener->address_space->coalesced);
+        listener->address_space->coalesced = NULL;
+        listener->address_space->coalesced_nb = 0;
+    }
     QTAILQ_REMOVE(&memory_listeners, listener, link);
     QTAILQ_REMOVE(&listener->address_space->listeners, listener, link_as);
     listener->address_space = NULL;
@@ -3089,6 +3220,9 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
     as->current_map = NULL;
     as->ioeventfd_nb = 0;
     as->ioeventfds = NULL;
+    as->coalesced_nb = 0;
+    as->coalesced_notifiers = 0;
+    as->coalesced = NULL;
     QTAILQ_INIT(&as->listeners);
     QTAILQ_INSERT_TAIL(&address_spaces, as, address_spaces_link);
     as->max_bounce_buffer_size = DEFAULT_MAX_BOUNCE_BUFFER_SIZE;
@@ -3111,6 +3245,7 @@ static void do_address_space_destroy(AddressSpace *as)
     flatview_unref(as->current_map);
     g_free(as->name);
     g_free(as->ioeventfds);
+    g_free(as->coalesced);
     memory_region_unref(as->root);
 }
 
-- 
2.53.0


