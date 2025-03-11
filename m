Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B13C28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:13:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzL6-0002qd-Dk; Tue, 11 Mar 2025 09:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzEu-0005sq-Gv; Tue, 11 Mar 2025 09:01:45 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzEp-0000Jv-Bk; Tue, 11 Mar 2025 09:01:44 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2feae794508so8087231a91.0; 
 Tue, 11 Mar 2025 06:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741698097; x=1742302897; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MvevJgZuo4bkG1Sd+5i0dJdPdtOcYaorR/nWe5rVjjE=;
 b=McXVTU7qOv4feBARpMHt7pyMy1FlVVrBkcA335/q+2nw36DmAKrv4gWz5mHTHWTBsu
 NruP6/cxhgCGmEmcBllkfRzgguz33bS24hvLXqu6e3vIWXx36iJD8zWMHVtUK3IgNqcs
 +zFqweuujZw+uv5vU/80w/zJ/OWWwCUYJaO0uSz4+Gx5AdtoeRcM0jqqCcbaI440YfpN
 oLJQK5gV7Zn5iEU67DjLM+G11POv6+b+ScARDgqfud2jjZh0z12KhNqnIyB6a2QpXGjT
 sc3Ag32a4DAZZdcQnypDQ5mTOxlFLK1fIA5rH5HJDCe7N1zpfZIUtigPCDwWXEjwFuoT
 r0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741698097; x=1742302897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MvevJgZuo4bkG1Sd+5i0dJdPdtOcYaorR/nWe5rVjjE=;
 b=MJjDgYHRoiwPpH0DMH+oFmu6gfZ9VtIqaTeygxQQ+z62KWNTL/ahBGvOzqCTQsed5M
 dQiEcpUQSeRHTsv9iM3VfUr6Qt9t4RafqfoFtQUIxNGJoSCXFMQrElib1MYBtay/XSzx
 rgPwW1pkqpcYlgk2WW/t5hjf/wMdAYnBVcDayINybwM6TD6yYtJLnuXYmOjCgmb0tAYH
 Ol3KyxQlgUk+fDX2WLZWP1TD56CvBdwVpUrX+Clzh2nc7LjQDzV/t8xpo/bxecCmBUS7
 KXdhXTFSqPnGRNYn/wjhVMdj8z/cwmvUYwHXRNVtwwKtmJ4CDEMH8hcd0RG5Wkl07TW2
 TCug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTEuplVE/+8vumGzWn4Lbq8zKtNRFjzObX2K3hu0R3RjnYYEyNpcbI+NvjFCwAE6k96zzmPBpt2A==@nongnu.org
X-Gm-Message-State: AOJu0YxjNkkxwLVLb6YVfobzoSqBWP+PpR1Sts+4oG+Y2GSfSQyhacj7
 WcRsOFC01/VOBS3t5EQiiuZDv5nLN7PDnK3Hd4pb9hIDPLiKYedI0zc8gQ==
X-Gm-Gg: ASbGncsiKZP1yFRW+1K13cXRcDTxDBPzir5PwT9c21JwdOIkiOufPZct7YMYYDnYhfk
 mQ/6i0hyoomRt4vicAnqC92gvpC+5RujnWnu9JANB4E21W1tqYw0ON1vJawQn8Apki+rNTDHWe/
 Z5H1uE8L8LBBsvM92dJgBbmc1mFIEKSYjG1YzOD6PHnuykXZ2SD1AhPCpLI2wnHkefvCej962lx
 gz9QrYlmrWhpjvYvNl4+/LMEI8zck+kaVavFZzl+b91L5zglxev6x+vtP9XJ1QmaqdHAPd5MO8g
 xqeM0fwhReFqlAYRtABM2OZephDJ738rSClG29XCfzW9BkOd30E=
X-Google-Smtp-Source: AGHT+IHGaq0nnS5TDBnbJU9Jr5a7d+IsbyF4+HVbzZAWZR8sNw+QHvH1/Pr5wdo/VLI5qABjqLzgdQ==
X-Received: by 2002:a17:90a:e7c2:b0:2ff:693a:758d with SMTP id
 98e67ed59e1d1-2ff7ceef0famr25706466a91.27.1741698097019; 
 Tue, 11 Mar 2025 06:01:37 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.06.01.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 06:01:36 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Vaibhav Jain <vaibhav@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 62/72] spapr: nested: Add support for reporting Hostwide state
 counter
Date: Tue, 11 Mar 2025 22:57:56 +1000
Message-ID: <20250311125815.903177-63-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Vaibhav Jain <vaibhav@linux.ibm.com>

Add support for reporting Hostwide state counters for nested KVM pseries
guests running with 'cap-nested-papr' on Qemu-TCG acting as
L0-hypervisor. The Hostwide state counters are statistics about state that
L0-hypervisor maintains for the L2-guests and represent the state of all
L2-guests, not just a specific one.

These stats counters are exposed to L1-Hypervisor by the L0-Hypervisor via a
new bit-flag named 'getHostWideState' for the H_GUEST_GET_STATE hcall which
is documented at [1]. Once this flag is set the hcall should populate the
Guest-State-Elements in the requested GSB with the stat counter
values. Currently following five counters are supported:

* l0_guest_heap_size_inuse
* l0_guest_heap_size_max
* l0_guest_pagetable_size_inuse
* l0_guest_pagetable_size_max
* l0_guest_pagetable_reclaimed

At the moment '0' is being reported for all these counters as these
counters doesn't align with how L0-Qemu manages Guest memory.

The patch implements support for these counters by adding new members to
the 'struct SpaprMachineStateNested'. These new members are then plugged
into the existing 'guest_state_element_types[]' with the help of a new
macro 'GSBE_NESTED_MACHINE_DW' together with a new helper
'get_machine_ptr()'. guest_state_request_check() is updated to ensure
correctness of the requested GSB and finally h_guest_getset_state() is
updated to handle the newly introduced flag
'GUEST_STATE_REQUEST_HOST_WIDE'.

This patch is tested with the proposed linux-kernel implementation to
expose these stat-counter as perf-events at [2].

[1]
https://lore.kernel.org/all/20241222140247.174998-2-vaibhav@linux.ibm.com

[2]
https://lore.kernel.org/all/20241222140247.174998-1-vaibhav@linux.ibm.com

Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Message-ID: <20250221155449.530645-1-vaibhav@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr_nested.c         | 119 ++++++++++++++++++++++++----------
 include/hw/ppc/spapr_nested.h |  67 +++++++++++++++++--
 2 files changed, 147 insertions(+), 39 deletions(-)

diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index 23958c6383..201f629203 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -65,10 +65,9 @@ static
 SpaprMachineStateNestedGuest *spapr_get_nested_guest(SpaprMachineState *spapr,
                                                      target_ulong guestid)
 {
-    SpaprMachineStateNestedGuest *guest;
-
-    guest = g_hash_table_lookup(spapr->nested.guests, GINT_TO_POINTER(guestid));
-    return guest;
+    return spapr->nested.guests ?
+        g_hash_table_lookup(spapr->nested.guests,
+                            GINT_TO_POINTER(guestid)) : NULL;
 }
 
 bool spapr_get_pate_nested_papr(SpaprMachineState *spapr, PowerPCCPU *cpu,
@@ -594,26 +593,37 @@ static bool spapr_nested_vcpu_check(SpaprMachineStateNestedGuest *guest,
     return false;
 }
 
-static void *get_vcpu_state_ptr(SpaprMachineStateNestedGuest *guest,
-                              target_ulong vcpuid)
+static void *get_vcpu_state_ptr(SpaprMachineState *spapr,
+                                SpaprMachineStateNestedGuest *guest,
+                                target_ulong vcpuid)
 {
     assert(spapr_nested_vcpu_check(guest, vcpuid, false));
     return &guest->vcpus[vcpuid].state;
 }
 
-static void *get_vcpu_ptr(SpaprMachineStateNestedGuest *guest,
-                                   target_ulong vcpuid)
+static void *get_vcpu_ptr(SpaprMachineState *spapr,
+                          SpaprMachineStateNestedGuest *guest,
+                          target_ulong vcpuid)
 {
     assert(spapr_nested_vcpu_check(guest, vcpuid, false));
     return &guest->vcpus[vcpuid];
 }
 
-static void *get_guest_ptr(SpaprMachineStateNestedGuest *guest,
+static void *get_guest_ptr(SpaprMachineState *spapr,
+                           SpaprMachineStateNestedGuest *guest,
                            target_ulong vcpuid)
 {
     return guest; /* for GSBE_NESTED */
 }
 
+static void *get_machine_ptr(SpaprMachineState *spapr,
+                             SpaprMachineStateNestedGuest *guest,
+                             target_ulong vcpuid)
+{
+    /* ignore guest and vcpuid for this */
+    return &spapr->nested;
+}
+
 /*
  * set=1 means the L1 is trying to set some state
  * set=0 means the L1 is trying to get some state
@@ -1013,7 +1023,15 @@ struct guest_state_element_type guest_state_element_types[] = {
     GSBE_NESTED_VCPU(GSB_VCPU_OUT_BUFFER, 0x10, runbufout,   copy_state_runbuf),
     GSBE_NESTED_VCPU(GSB_VCPU_OUT_BUF_MIN_SZ, 0x8, runbufout, out_buf_min_size),
     GSBE_NESTED_VCPU(GSB_VCPU_HDEC_EXPIRY_TB, 0x8, hdecr_expiry_tb,
-                     copy_state_hdecr)
+                     copy_state_hdecr),
+    GSBE_NESTED_MACHINE_DW(GSB_L0_GUEST_HEAP_INUSE, l0_guest_heap_inuse),
+    GSBE_NESTED_MACHINE_DW(GSB_L0_GUEST_HEAP_MAX, l0_guest_heap_max),
+    GSBE_NESTED_MACHINE_DW(GSB_L0_GUEST_PGTABLE_SIZE_INUSE,
+                           l0_guest_pgtable_size_inuse),
+    GSBE_NESTED_MACHINE_DW(GSB_L0_GUEST_PGTABLE_SIZE_MAX,
+                           l0_guest_pgtable_size_max),
+    GSBE_NESTED_MACHINE_DW(GSB_L0_GUEST_PGTABLE_RECLAIMED,
+                           l0_guest_pgtable_reclaimed),
 };
 
 void spapr_nested_gsb_init(void)
@@ -1031,8 +1049,13 @@ void spapr_nested_gsb_init(void)
         else if (type->id >= GSB_VCPU_IN_BUFFER)
             /* 0x0c00 - 0xf000 Thread + RW */
             type->flags = 0;
+        else if (type->id >= GSB_L0_GUEST_HEAP_INUSE)
+
+            /*0x0800 - 0x0804 Hostwide Counters + RO */
+            type->flags = GUEST_STATE_ELEMENT_TYPE_FLAG_HOST_WIDE |
+                          GUEST_STATE_ELEMENT_TYPE_FLAG_READ_ONLY;
         else if (type->id >= GSB_VCPU_LPVR)
-            /* 0x0003 - 0x0bff Guest + RW */
+            /* 0x0003 - 0x07ff Guest + RW */
             type->flags = GUEST_STATE_ELEMENT_TYPE_FLAG_GUEST_WIDE;
         else if (type->id >= GSB_HV_VCPU_STATE_SIZE)
             /* 0x0001 - 0x0002 Guest + RO */
@@ -1139,18 +1162,26 @@ static bool guest_state_request_check(struct guest_state_request *gsr)
             return false;
         }
 
-        if (type->flags & GUEST_STATE_ELEMENT_TYPE_FLAG_GUEST_WIDE) {
+        if (type->flags & GUEST_STATE_ELEMENT_TYPE_FLAG_HOST_WIDE) {
+            /* Hostwide elements cant be clubbed with other types */
+            if (!(gsr->flags & GUEST_STATE_REQUEST_HOST_WIDE)) {
+                qemu_log_mask(LOG_GUEST_ERROR, "trying to get/set a host wide "
+                              "Element ID:%04x.\n", id);
+                return false;
+            }
+        } else  if (type->flags & GUEST_STATE_ELEMENT_TYPE_FLAG_GUEST_WIDE) {
             /* guest wide element type */
             if (!(gsr->flags & GUEST_STATE_REQUEST_GUEST_WIDE)) {
-                qemu_log_mask(LOG_GUEST_ERROR, "trying to set a guest wide "
+                qemu_log_mask(LOG_GUEST_ERROR, "trying to get/set a guest wide "
                               "Element ID:%04x.\n", id);
                 return false;
             }
         } else {
             /* thread wide element type */
-            if (gsr->flags & GUEST_STATE_REQUEST_GUEST_WIDE) {
-                qemu_log_mask(LOG_GUEST_ERROR, "trying to set a thread wide "
-                              "Element ID:%04x.\n", id);
+            if (gsr->flags & (GUEST_STATE_REQUEST_GUEST_WIDE |
+                              GUEST_STATE_REQUEST_HOST_WIDE)) {
+                qemu_log_mask(LOG_GUEST_ERROR, "trying to get/set a thread wide"
+                            " Element ID:%04x.\n", id);
                 return false;
             }
         }
@@ -1419,7 +1450,8 @@ static target_ulong h_guest_create_vcpu(PowerPCCPU *cpu,
     return H_SUCCESS;
 }
 
-static target_ulong getset_state(SpaprMachineStateNestedGuest *guest,
+static target_ulong getset_state(SpaprMachineState *spapr,
+                                 SpaprMachineStateNestedGuest *guest,
                                  uint64_t vcpuid,
                                  struct guest_state_request *gsr)
 {
@@ -1452,7 +1484,7 @@ static target_ulong getset_state(SpaprMachineStateNestedGuest *guest,
 
         /* Get pointer to guest data to get/set */
         if (type->location && type->copy) {
-            ptr = type->location(guest, vcpuid);
+            ptr = type->location(spapr, guest, vcpuid);
             assert(ptr);
             if (!~(type->mask) && is_gsr_invalid(gsr, element, type)) {
                 return H_INVALID_ELEMENT_VALUE;
@@ -1469,6 +1501,7 @@ next_element:
 }
 
 static target_ulong map_and_getset_state(PowerPCCPU *cpu,
+                                         SpaprMachineState *spapr,
                                          SpaprMachineStateNestedGuest *guest,
                                          uint64_t vcpuid,
                                          struct guest_state_request *gsr)
@@ -1492,7 +1525,7 @@ static target_ulong map_and_getset_state(PowerPCCPU *cpu,
         goto out1;
     }
 
-    rc = getset_state(guest, vcpuid, gsr);
+    rc = getset_state(spapr, guest, vcpuid, gsr);
 
 out1:
     address_space_unmap(CPU(cpu)->as, gsr->gsb, len, is_write, len);
@@ -1510,27 +1543,46 @@ static target_ulong h_guest_getset_state(PowerPCCPU *cpu,
     target_ulong buf = args[3];
     target_ulong buflen = args[4];
     struct guest_state_request gsr;
-    SpaprMachineStateNestedGuest *guest;
+    SpaprMachineStateNestedGuest *guest = NULL;
 
-    guest = spapr_get_nested_guest(spapr, lpid);
-    if (!guest) {
-        return H_P2;
-    }
     gsr.buf = buf;
     assert(buflen <= GSB_MAX_BUF_SIZE);
     gsr.len = buflen;
     gsr.flags = 0;
-    if (flags & H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE) {
+
+    /* Works for both get/set state */
+    if ((flags & H_GUEST_GET_STATE_FLAGS_GUEST_WIDE) ||
+        (flags & H_GUEST_SET_STATE_FLAGS_GUEST_WIDE)) {
         gsr.flags |= GUEST_STATE_REQUEST_GUEST_WIDE;
     }
-    if (flags & ~H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE) {
-        return H_PARAMETER; /* flag not supported yet */
-    }
 
     if (set) {
+        if (flags & ~H_GUEST_SET_STATE_FLAGS_MASK) {
+            return H_PARAMETER;
+        }
         gsr.flags |= GUEST_STATE_REQUEST_SET;
+    } else {
+        /*
+         * No reserved fields to be set in flags nor both
+         * GUEST/HOST wide bits
+         */
+        if ((flags & ~H_GUEST_GET_STATE_FLAGS_MASK) ||
+            (flags == H_GUEST_GET_STATE_FLAGS_MASK)) {
+            return H_PARAMETER;
+        }
+
+        if (flags & H_GUEST_GET_STATE_FLAGS_HOST_WIDE) {
+            gsr.flags |= GUEST_STATE_REQUEST_HOST_WIDE;
+        }
+    }
+
+    if (!(gsr.flags & GUEST_STATE_REQUEST_HOST_WIDE)) {
+        guest = spapr_get_nested_guest(spapr, lpid);
+        if (!guest) {
+            return H_P2;
+        }
     }
-    return map_and_getset_state(cpu, guest, vcpuid, &gsr);
+    return map_and_getset_state(cpu, spapr, guest, vcpuid, &gsr);
 }
 
 static target_ulong h_guest_set_state(PowerPCCPU *cpu,
@@ -1641,7 +1693,8 @@ static int get_exit_ids(uint64_t srr0, uint16_t ids[16])
     return nr;
 }
 
-static void exit_process_output_buffer(PowerPCCPU *cpu,
+static void exit_process_output_buffer(SpaprMachineState *spapr,
+                                       PowerPCCPU *cpu,
                                        SpaprMachineStateNestedGuest *guest,
                                        target_ulong vcpuid,
                                        target_ulong *r3)
@@ -1679,7 +1732,7 @@ static void exit_process_output_buffer(PowerPCCPU *cpu,
     gsr.gsb = gsb;
     gsr.len = VCPU_OUT_BUF_MIN_SZ;
     gsr.flags = 0; /* get + never guest wide */
-    getset_state(guest, vcpuid, &gsr);
+    getset_state(spapr, guest, vcpuid, &gsr);
 
     address_space_unmap(CPU(cpu)->as, gsb, len, true, len);
     return;
@@ -1705,7 +1758,7 @@ void spapr_exit_nested_papr(SpaprMachineState *spapr, PowerPCCPU *cpu, int excp)
 
     exit_nested_store_l2(cpu, excp, vcpu);
     /* do the output buffer for run_vcpu*/
-    exit_process_output_buffer(cpu, guest, vcpuid, &r3_return);
+    exit_process_output_buffer(spapr, cpu, guest, vcpuid, &r3_return);
 
     assert(env->spr[SPR_LPIDR] != 0);
     nested_load_state(cpu, spapr_cpu->nested_host_state);
@@ -1820,7 +1873,7 @@ static target_ulong h_guest_run_vcpu(PowerPCCPU *cpu,
     gsr.buf = vcpu->runbufin.addr;
     gsr.len = vcpu->runbufin.size;
     gsr.flags = GUEST_STATE_REQUEST_SET; /* Thread wide + writing */
-    rc = map_and_getset_state(cpu, guest, vcpuid, &gsr);
+    rc = map_and_getset_state(cpu, spapr,  guest, vcpuid, &gsr);
     if (rc == H_SUCCESS) {
         nested_papr_run_vcpu(cpu, lpid, vcpu);
     } else {
diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
index e420220484..f7be0d5a95 100644
--- a/include/hw/ppc/spapr_nested.h
+++ b/include/hw/ppc/spapr_nested.h
@@ -11,7 +11,13 @@
 #define GSB_TB_OFFSET           0x0004 /* Timebase Offset */
 #define GSB_PART_SCOPED_PAGETBL 0x0005 /* Partition Scoped Page Table */
 #define GSB_PROCESS_TBL         0x0006 /* Process Table */
-                    /* RESERVED 0x0007 - 0x0BFF */
+                    /* RESERVED 0x0007 - 0x07FF */
+#define GSB_L0_GUEST_HEAP_INUSE 0x0800 /* Guest Management Heap Size */
+#define GSB_L0_GUEST_HEAP_MAX   0x0801 /* Guest Management Heap Max Size */
+#define GSB_L0_GUEST_PGTABLE_SIZE_INUSE  0x0802 /* Guest Pagetable Size */
+#define GSB_L0_GUEST_PGTABLE_SIZE_MAX    0x0803 /* Guest Pagetable Max Size */
+#define GSB_L0_GUEST_PGTABLE_RECLAIMED   0x0804 /* Pagetable Reclaim in bytes */
+                    /* RESERVED 0x0805 - 0xBFF */
 #define GSB_VCPU_IN_BUFFER      0x0C00 /* Run VCPU Input Buffer */
 #define GSB_VCPU_OUT_BUFFER     0x0C01 /* Run VCPU Out Buffer */
 #define GSB_VCPU_VPA            0x0C02 /* HRA to Guest VCPU VPA */
@@ -196,6 +202,38 @@ typedef struct SpaprMachineStateNested {
 #define NESTED_API_PAPR    2
     bool capabilities_set;
     uint32_t pvr_base;
+
+    /**
+     * l0_guest_heap_inuse: The currently used bytes in the Hypervisor's Guest
+     * Management Space associated with the Host Partition.
+     **/
+    uint64_t l0_guest_heap_inuse;
+
+    /**
+     * host_heap_max: The maximum bytes available in the Hypervisor's Guest
+     * Management Space associated with the Host Partition.
+     **/
+    uint64_t l0_guest_heap_max;
+
+    /**
+     * host_pagetable: The currently used bytes in the Hypervisor's Guest
+     * Page Table Management Space associated with the Host Partition.
+     **/
+    uint64_t l0_guest_pgtable_size_inuse;
+
+    /**
+     * host_pagetable_max: The maximum bytes available in the Hypervisor's Guest
+     * Page Table Management Space associated with the Host Partition.
+     **/
+    uint64_t l0_guest_pgtable_size_max;
+
+    /**
+     * host_pagetable_reclaim: The amount of space in bytes that has been
+     * reclaimed due to overcommit in the  Hypervisor's Guest Page Table
+     * Management Space associated with the Host Partition.
+     **/
+    uint64_t l0_guest_pgtable_reclaimed;
+
     GHashTable *guests;
 } SpaprMachineStateNested;
 
@@ -229,9 +267,15 @@ typedef struct SpaprMachineStateNestedGuest {
 #define HVMASK_HDEXCR                 0x00000000FFFFFFFF
 #define HVMASK_TB_OFFSET              0x000000FFFFFFFFFF
 #define GSB_MAX_BUF_SIZE              (1024 * 1024)
-#define H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE 0x8000000000000000
-#define GUEST_STATE_REQUEST_GUEST_WIDE       0x1
-#define GUEST_STATE_REQUEST_SET              0x2
+#define H_GUEST_GET_STATE_FLAGS_MASK   0xC000000000000000ULL
+#define H_GUEST_SET_STATE_FLAGS_MASK   0x8000000000000000ULL
+#define H_GUEST_SET_STATE_FLAGS_GUEST_WIDE 0x8000000000000000ULL
+#define H_GUEST_GET_STATE_FLAGS_GUEST_WIDE 0x8000000000000000ULL
+#define H_GUEST_GET_STATE_FLAGS_HOST_WIDE  0x4000000000000000ULL
+
+#define GUEST_STATE_REQUEST_GUEST_WIDE     0x1
+#define GUEST_STATE_REQUEST_HOST_WIDE      0x2
+#define GUEST_STATE_REQUEST_SET            0x4
 
 /*
  * As per ISA v3.1B, following bits are reserved:
@@ -251,6 +295,15 @@ typedef struct SpaprMachineStateNestedGuest {
     .copy = (c)                                    \
 }
 
+#define GSBE_NESTED_MACHINE_DW(i, f)  {                             \
+        .id = (i),                                                  \
+        .size = 8,                                                  \
+        .location = get_machine_ptr,                                \
+        .offset = offsetof(struct SpaprMachineStateNested, f),     \
+        .copy = copy_state_8to8,                                    \
+        .mask = HVMASK_DEFAULT                                      \
+}
+
 #define GSBE_NESTED(i, sz, f, c) {                             \
     .id = (i),                                                 \
     .size = (sz),                                              \
@@ -509,9 +562,11 @@ struct guest_state_element_type {
     uint16_t id;
     int size;
 #define GUEST_STATE_ELEMENT_TYPE_FLAG_GUEST_WIDE 0x1
-#define GUEST_STATE_ELEMENT_TYPE_FLAG_READ_ONLY  0x2
+#define GUEST_STATE_ELEMENT_TYPE_FLAG_HOST_WIDE 0x2
+#define GUEST_STATE_ELEMENT_TYPE_FLAG_READ_ONLY 0x4
    uint16_t flags;
-    void *(*location)(SpaprMachineStateNestedGuest *, target_ulong);
+   void *(*location)(struct SpaprMachineState *, SpaprMachineStateNestedGuest *,
+                     target_ulong);
     size_t offset;
     void (*copy)(void *, void *, bool);
     uint64_t mask;
-- 
2.47.1


