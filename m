Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A52D1268E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 03:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQe1L-0008ED-QV; Tue, 02 Dec 2025 22:59:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.x8k9of7zkabb1w5=xzjezy0rkw99=e7l6md1o6apd9i@em483429.getutm.app>)
 id 1vQe1K-0008Dh-Kx
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 22:59:14 -0500
Received: from a4i956.smtp2go.com ([158.120.83.188])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.x8k9of7zkabb1w5=xzjezy0rkw99=e7l6md1o6apd9i@em483429.getutm.app>)
 id 1vQe1I-00007p-8U
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 22:59:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getutm.app;
 i=@getutm.app; q=dns/txt; s=s483429; t=1764734342; h=from : subject :
 to : message-id : date;
 bh=a7Dkb2KHnm/ht47tdJWttydGvnkucrr+JAvb4EnnYSg=;
 b=CoULHtPecpSBpVxirBnsQ0hxXVuLAqufcfhqkTFGWn0373ydlFeboRaBmtZU3cbXq+S7r
 rAPEzF3C3iw1BhpKJ03LdNm5fMLevFrOOhPh1Rwj4DwoW9/OV+h0KtCj0keGnvvuFzLRiMY
 tQEMANObOVPb9r/cQ6x4m8Fp6tdbjkcAOAzQLF3mDgcXCgGRB31RLBol4tiGrgzvxxWMt8X
 QbfLLXr3L+2pvIt7i7UPI/qzrE/w4MEuKS1C/wNsFqxiXpDEqku6aaqcL8GGKmZ/XpQWodV
 ofkMdN/+6PCr2u+/S5z/71T6Yy0hhSjjt6WtHT5VHjW7RZNK8OyJBRpR2HUQ==
Received: from [10.159.238.187] (helo=localhost.localdomain)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA512__CHACHA20_POLY1305:256)
 (Exim 4.98.1-S2G) (envelope-from <j@getutm.app>)
 id 1vQe11-FnQW0hPuz7X-VkJn; Wed, 03 Dec 2025 03:58:55 +0000
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH] hvf: allow slot size to increase
Date: Tue,  2 Dec 2025 19:58:46 -0800
Message-ID: <20251203035847.94102-1-j@getutm.app>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Feedback-ID: 483429m:483429abrvJvs:483429skAbc49uMO
X-smtpcorp-track: expYtByXnsVz.k1HGI-DjMiJK.CjD3hwFsKqP
Received-SPF: pass client-ip=158.120.83.188;
 envelope-from=bounce.x8k9of7zkabb1w5=xzjezy0rkw99=e7l6md1o6apd9i@em483429.getutm.app;
 helo=a4i956.smtp2go.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Instead of having a fixed limit of 32 slots, we allow the number of slots
to expand. Currently there does not seem to be a need to add a limit, but
if the allocation fails, we will abort. The KVM backend was used for
inspiration here.

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 include/system/hvf_int.h | 12 ++++++-
 accel/hvf/hvf-all.c      | 78 ++++++++++++++++++++++++++++++----------
 2 files changed, 71 insertions(+), 19 deletions(-)

diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index 3d2be4092e..1d2616595c 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -27,6 +27,7 @@ typedef hv_vcpuid_t hvf_vcpuid;
 /* hvf_slot flags */
 #define HVF_SLOT_LOG (1 << 0)
 
+/* Represent memory logically mapped by QEMU */
 typedef struct hvf_slot {
     uint64_t start;
     uint64_t size;
@@ -36,6 +37,14 @@ typedef struct hvf_slot {
     MemoryRegion *region;
 } hvf_slot;
 
+/* Represent memory currently mapped in HVF */
+typedef struct hvf_mac_slot {
+    int present;
+    uint64_t size;
+    uint64_t gpa_start;
+    uint64_t gva;
+} hvf_mac_slot;
+
 typedef struct hvf_vcpu_caps {
     uint64_t vmx_cap_pinbased;
     uint64_t vmx_cap_procbased;
@@ -48,7 +57,8 @@ typedef struct hvf_vcpu_caps {
 struct HVFState {
     AccelState parent_obj;
 
-    hvf_slot slots[32];
+    hvf_slot *slots;
+    hvf_mac_slot *mac_slots;
     int num_slots;
 
     hvf_vcpu_caps *hvf_caps;
diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 0a4b498e83..367ff4fd40 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -21,14 +21,8 @@
 
 bool hvf_allowed;
 
-struct mac_slot {
-    int present;
-    uint64_t size;
-    uint64_t gpa_start;
-    uint64_t gva;
-};
-
-struct mac_slot mac_slots[32];
+/* Default num of memslots to be allocated when VM starts */
+#define  HVF_MEMSLOTS_NUM_ALLOC_DEFAULT                      32
 
 const char *hvf_return_string(hv_return_t ret)
 {
@@ -58,12 +52,60 @@ void assert_hvf_ok_impl(hv_return_t ret, const char *file, unsigned int line,
     abort();
 }
 
+static bool hvf_slots_grow(HVFState *state, unsigned int num_slots_new)
+{
+    unsigned int i, cur = state->num_slots;
+    hvf_slot *slots;
+    hvf_mac_slot *mac_slots;
+
+    assert(num_slots_new > cur);
+    if (cur == 0) {
+        slots = g_new0(hvf_slot, num_slots_new);
+        if (!slots) {
+            return false;
+        }
+        mac_slots = g_new0(hvf_mac_slot, num_slots_new);
+        if (!mac_slots) {
+            g_free(slots);
+            return false;
+        }
+    } else {
+        slots = g_renew(hvf_slot, state->slots, num_slots_new);
+        if (!slots) {
+            return false;
+        }
+        mac_slots = g_renew(hvf_mac_slot, state->mac_slots, num_slots_new);
+        if (!mac_slots) {
+            /* save allocated slots but not new size */
+            state->slots = slots;
+            return false;
+        }
+        /*
+         * g_renew() doesn't initialize extended buffers, however hvf
+         * memslots require fields to be zero-initialized. E.g. pointers,
+         * memory_size field, etc.
+         */
+        memset(&slots[cur], 0x0, sizeof(slots[0]) * (num_slots_new - cur));
+        memset(&mac_slots[cur], 0x0, sizeof(mac_slots[0]) * (num_slots_new - cur));
+    }
+
+    for (i = cur; i < num_slots_new; i++) {
+        slots[i].slot_id = i;
+    }
+
+    state->slots = slots;
+    state->mac_slots = mac_slots;
+    state->num_slots = num_slots_new;
+
+    return true;
+}
+
 static int do_hvf_set_memory(hvf_slot *slot, hv_memory_flags_t flags)
 {
-    struct mac_slot *macslot;
+    hvf_mac_slot *macslot;
     hv_return_t ret;
 
-    macslot = &mac_slots[slot->slot_id];
+    macslot = &hvf_state->mac_slots[slot->slot_id];
 
     if (macslot->present) {
         if (macslot->size != slot->size) {
@@ -160,8 +202,11 @@ static void hvf_set_phys_mem(MemoryRegionSection *section, bool add)
     }
 
     if (x == hvf_state->num_slots) {
-        error_report("No free slots");
-        abort();
+        if (!hvf_slots_grow(hvf_state, hvf_state->num_slots * 2)) {
+            error_report("Cannot allocate any more slots");
+            abort();
+        }
+        mem = &hvf_state->slots[x];
     }
 
     mem->size = int128_get64(section->size);
@@ -250,11 +295,11 @@ static MemoryListener hvf_memory_listener = {
 
 static int hvf_accel_init(AccelState *as, MachineState *ms)
 {
-    int x;
     hv_return_t ret;
     HVFState *s = HVF_STATE(as);
     int pa_range = 36;
     MachineClass *mc = MACHINE_GET_CLASS(ms);
+    bool success;
 
     if (mc->hvf_get_physical_address_range) {
         pa_range = mc->hvf_get_physical_address_range(ms);
@@ -271,11 +316,8 @@ static int hvf_accel_init(AccelState *as, MachineState *ms)
     }
     assert_hvf_ok(ret);
 
-    s->num_slots = ARRAY_SIZE(s->slots);
-    for (x = 0; x < s->num_slots; ++x) {
-        s->slots[x].size = 0;
-        s->slots[x].slot_id = x;
-    }
+    success = hvf_slots_grow(s, HVF_MEMSLOTS_NUM_ALLOC_DEFAULT);
+    assert(success);
 
     QTAILQ_INIT(&s->hvf_sw_breakpoints);
 
-- 
2.41.0


