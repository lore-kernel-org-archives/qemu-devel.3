Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E79EC48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 08:57:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcLsM-0008KW-4J; Tue, 20 Feb 2024 03:53:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rcLsI-0008Ge-0t
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:53:14 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rcLsF-00089G-Hz
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:53:13 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-564647bcdbfso2148912a12.2
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 00:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708419190; x=1709023990; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=74P+PKZ6orTLj/5plkkdrxWuHnGI5wedPF2+fgfkjP0=;
 b=IProdb+RTIenez6FNm/luv2riechFOQy4SBgLCZYgZKC9/ulzrR24aw/F7GEY44GkK
 gr4WSZrmXAp+nPb4Mn3Jclpi+kAzNMQAQAcMBUsFuFqRA4f5an1DWphZsSCI6SedPzNA
 TiKMeimSN714tnG+yIWJuEPGPNVt4+GzWqOZMuL2Tb4TyNYm1zjgBGFEZGeyZVWxGAB7
 yE01gMuyFHbrF8rbCgCmLFhOqg9unUZNVaiH4RbpXHB7SuclHqAT5qz5Kkf3ddldCboo
 XmQ2oIC8A9guz5bYQomUiQlDNK4hct3sH1KsuEkQo9FnC5k7T34nHQhQaVPZ2UCwbtYG
 qGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708419190; x=1709023990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=74P+PKZ6orTLj/5plkkdrxWuHnGI5wedPF2+fgfkjP0=;
 b=WhcSvHeiey5PIZPeQZXhvQnzYGQI0bffjfu99hC68jyggR/brOIMSfWodTECrntdHB
 sJStrmlY5cWZLXnoZt9oUKKOa1ztNLU0LCsH/X3gZGWwtrSNgtiXg5eOR/Ch/1/eN/Z8
 2oBZ9QqVTV7M34ECuvLjnkmwA0RkClsbxgysr3YDUyXtVAGIvXGQ9/6ZAYWp6zZ66bss
 yzwrI+edi5mIn10NOldppp/etdvD7TRequXXMg0Vcdk+DDPkkjZf0Xjn1jjFDuivMLQV
 pJ+bqI7Wz761pyykFXe3zhxbQaslOuYnDTZaPW1L/tWsMkWPRco1wAmLB1mLNcAibdIF
 MzOg==
X-Gm-Message-State: AOJu0Yz83lmFE29WaKdcIbDi8b0+PMFR+RFiA0zpJ/U6Mi1bI/OU6+Bg
 TWXWRUXlFx8aaxBkiw/7tkqGPVjyrZkoewCshUx1Oc89dRhYwTPovTQgiAlEHsQ=
X-Google-Smtp-Source: AGHT+IH0/5iDtgDsLwpGN/YmUhRGA55XSWPIdNMzHkhCmG1fsWPv29/an+50Zc6oVwnQznVwV1dJEg==
X-Received: by 2002:a17:906:57ca:b0:a3f:ce8:1234 with SMTP id
 u10-20020a17090657ca00b00a3f0ce81234mr403891ejr.68.1708419190280; 
 Tue, 20 Feb 2024 00:53:10 -0800 (PST)
Received: from localhost.localdomain (adsl-245.37.6.163.tellas.gr.
 [37.6.163.245]) by smtp.gmail.com with ESMTPSA id
 cu3-20020a170906ba8300b00a3d014fa12esm3747876ejd.196.2024.02.20.00.53.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 00:53:10 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org
Subject: [PATCH v1 03/21] Xen headers: correct typos
Date: Tue, 20 Feb 2024 10:52:10 +0200
Message-Id: <dca380ada7f7eabfb473828eccafc2902b1985b7.1708419115.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1708419115.git.manos.pitsidianakis@linaro.org>
References: <cover.1708419115.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Correct typos automatically found with the `typos` tool
<https://crates.io/crates/typos>

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 include/hw/xen/interface/arch-x86/xen-x86_64.h | 2 +-
 include/hw/xen/interface/arch-x86/xen.h        | 2 +-
 include/hw/xen/interface/event_channel.h       | 2 +-
 include/hw/xen/interface/grant_table.h         | 2 +-
 include/hw/xen/interface/hvm/hvm_op.h          | 2 +-
 include/hw/xen/interface/io/blkif.h            | 4 ++--
 include/hw/xen/interface/io/fbif.h             | 2 +-
 include/hw/xen/interface/io/kbdif.h            | 2 +-
 include/hw/xen/interface/io/ring.h             | 2 +-
 include/hw/xen/interface/memory.h              | 2 +-
 include/hw/xen/interface/physdev.h             | 4 ++--
 include/hw/xen/interface/xen.h                 | 4 ++--
 12 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/hw/xen/interface/arch-x86/xen-x86_64.h b/include/hw/xen/interface/arch-x86/xen-x86_64.h
index 5d9035ed22..3e94eeb0bf 100644
--- a/include/hw/xen/interface/arch-x86/xen-x86_64.h
+++ b/include/hw/xen/interface/arch-x86/xen-x86_64.h
@@ -89,7 +89,7 @@
  *   RING1 -> RING3 kernel mode.
  *   RING2 -> RING3 kernel mode.
  *   RING3 -> RING3 user mode.
- * However RING0 indicates that the guest kernel should return to iteself
+ * However RING0 indicates that the guest kernel should return to itself
  * directly with
  *      orb   $3,1*8(%rsp)
  *      iretq
diff --git a/include/hw/xen/interface/arch-x86/xen.h b/include/hw/xen/interface/arch-x86/xen.h
index c0f4551247..323bd06a63 100644
--- a/include/hw/xen/interface/arch-x86/xen.h
+++ b/include/hw/xen/interface/arch-x86/xen.h
@@ -156,7 +156,7 @@ typedef uint64_t tsc_timestamp_t; /* RDTSC timestamp */
  * information in this structure is updated, the fields read include: fpu_ctxt
  * (if VGCT_I387_VALID is set), flags, user_regs and debugreg[*].
  *
- * Note: VCPUOP_initialise for HVM guests is non-symetric with
+ * Note: VCPUOP_initialise for HVM guests is non-symmetric with
  * DOMCTL_setvcpucontext, and uses struct vcpu_hvm_context from hvm/hvm_vcpu.h
  */
 struct vcpu_guest_context {
diff --git a/include/hw/xen/interface/event_channel.h b/include/hw/xen/interface/event_channel.h
index 0d91a1c4af..d446863230 100644
--- a/include/hw/xen/interface/event_channel.h
+++ b/include/hw/xen/interface/event_channel.h
@@ -302,7 +302,7 @@ typedef struct evtchn_set_priority evtchn_set_priority_t;
  * ` enum neg_errnoval
  * ` HYPERVISOR_event_channel_op_compat(struct evtchn_op *op)
  * `
- * Superceded by new event_channel_op() hypercall since 0x00030202.
+ * Superseded by new event_channel_op() hypercall since 0x00030202.
  */
 struct evtchn_op {
     uint32_t cmd; /* enum event_channel_op */
diff --git a/include/hw/xen/interface/grant_table.h b/include/hw/xen/interface/grant_table.h
index 1dfa17a6d0..7652e8bf81 100644
--- a/include/hw/xen/interface/grant_table.h
+++ b/include/hw/xen/interface/grant_table.h
@@ -607,7 +607,7 @@ DEFINE_XEN_GUEST_HANDLE(gnttab_cache_flush_t);
  /*
   * GNTMAP_contains_pte subflag:
   *  0 => This map request contains a host virtual address.
-  *  1 => This map request contains the machine addess of the PTE to update.
+  *  1 => This map request contains the machine address of the PTE to update.
   */
 #define _GNTMAP_contains_pte    (4)
 #define GNTMAP_contains_pte     (1<<_GNTMAP_contains_pte)
diff --git a/include/hw/xen/interface/hvm/hvm_op.h b/include/hw/xen/interface/hvm/hvm_op.h
index e22adf0319..3defe1c108 100644
--- a/include/hw/xen/interface/hvm/hvm_op.h
+++ b/include/hw/xen/interface/hvm/hvm_op.h
@@ -337,7 +337,7 @@ struct xen_hvm_altp2m_op {
 #define HVMOP_altp2m_vcpu_disable_notify  13
 /* Get the active vcpu p2m index */
 #define HVMOP_altp2m_get_p2m_idx          14
-/* Set the "Supress #VE" bit for a range of pages */
+/* Set the "Suppress #VE" bit for a range of pages */
 #define HVMOP_altp2m_set_suppress_ve_multi 15
 /* Set visibility for a given altp2m view */
 #define HVMOP_altp2m_set_visibility       16
diff --git a/include/hw/xen/interface/io/blkif.h b/include/hw/xen/interface/io/blkif.h
index 22f1eef0c0..4356956975 100644
--- a/include/hw/xen/interface/io/blkif.h
+++ b/include/hw/xen/interface/io/blkif.h
@@ -42,7 +42,7 @@
  * All data in the XenStore is stored as strings.  Nodes specifying numeric
  * values are encoded in decimal.  Integer value ranges listed below are
  * expressed as fixed sized integer types capable of storing the conversion
- * of a properly formated node string, without loss of information.
+ * of a properly formatted node string, without loss of information.
  *
  * Any specified default value is in effect if the corresponding XenBus node
  * is not present in the XenStore.
@@ -406,7 +406,7 @@
  *     further requests may reuse these grants and require write permissions.
  * (9) Linux implementation doesn't have a limit on the maximum number of
  *     grants that can be persistently mapped in the frontend driver, but
- *     due to the frontent driver implementation it should never be bigger
+ *     due to the frontend driver implementation it should never be bigger
  *     than RING_SIZE * BLKIF_MAX_SEGMENTS_PER_REQUEST.
  *(10) The discard-secure property may be present and will be set to 1 if the
  *     backing device supports secure discard.
diff --git a/include/hw/xen/interface/io/fbif.h b/include/hw/xen/interface/io/fbif.h
index 93c73195d8..46046f6775 100644
--- a/include/hw/xen/interface/io/fbif.h
+++ b/include/hw/xen/interface/io/fbif.h
@@ -72,7 +72,7 @@ union xenfb_out_event
  * just ignore it.  Frontends that use the advice should immediately
  * refresh the framebuffer (and send an update notification event if
  * those have been requested), then use the update frequency to guide
- * their periodical refreshs.
+ * their periodical refresh.
  */
 #define XENFB_TYPE_REFRESH_PERIOD 1
 #define XENFB_NO_REFRESH 0
diff --git a/include/hw/xen/interface/io/kbdif.h b/include/hw/xen/interface/io/kbdif.h
index 4bde6b3821..5794cc33f8 100644
--- a/include/hw/xen/interface/io/kbdif.h
+++ b/include/hw/xen/interface/io/kbdif.h
@@ -22,7 +22,7 @@
  * All data in XenStore is stored as strings.  Nodes specifying numeric
  * values are encoded in decimal. Integer value ranges listed below are
  * expressed as fixed sized integer types capable of storing the conversion
- * of a properly formated node string, without loss of information.
+ * of a properly formatted node string, without loss of information.
  *
  *****************************************************************************
  *                            Backend XenBus Nodes
diff --git a/include/hw/xen/interface/io/ring.h b/include/hw/xen/interface/io/ring.h
index 025939278b..6d8f63d7a5 100644
--- a/include/hw/xen/interface/io/ring.h
+++ b/include/hw/xen/interface/io/ring.h
@@ -145,7 +145,7 @@ typedef struct __name##_back_ring __name##_back_ring_t
  *
  * N.B. these macros do NO INTERLOCKS OR FLOW CONTROL.
  * This is OK in 1-for-1 request-response situations where the
- * requestor (front end) never has more than RING_SIZE()-1
+ * requester (front end) never has more than RING_SIZE()-1
  * outstanding requests.
  */
 
diff --git a/include/hw/xen/interface/memory.h b/include/hw/xen/interface/memory.h
index 29cf5c8239..ad11573d90 100644
--- a/include/hw/xen/interface/memory.h
+++ b/include/hw/xen/interface/memory.h
@@ -167,7 +167,7 @@ struct xen_machphys_mfn_list {
 
     /*
      * Pointer to buffer to fill with list of extent starts. If there are
-     * any large discontiguities in the machine address space, 2MB gaps in
+     * any large discontinuities in the machine address space, 2MB gaps in
      * the machphys table will be represented by an MFN base of zero.
      */
     XEN_GUEST_HANDLE(xen_pfn_t) extent_start;
diff --git a/include/hw/xen/interface/physdev.h b/include/hw/xen/interface/physdev.h
index f0c0d4727c..053c045cf5 100644
--- a/include/hw/xen/interface/physdev.h
+++ b/include/hw/xen/interface/physdev.h
@@ -206,7 +206,7 @@ typedef struct physdev_manage_pci_ext physdev_manage_pci_ext_t;
 DEFINE_XEN_GUEST_HANDLE(physdev_manage_pci_ext_t);
 
 /*
- * Argument to physdev_op_compat() hypercall. Superceded by new physdev_op()
+ * Argument to physdev_op_compat() hypercall. Superseded by new physdev_op()
  * hypercall since 0x00030202.
  */
 struct physdev_op {
@@ -332,7 +332,7 @@ DEFINE_XEN_GUEST_HANDLE(physdev_dbgp_op_t);
 
 #if __XEN_INTERFACE_VERSION__ < 0x00040600
 /*
- * These all-capitals physdev operation names are superceded by the new names
+ * These all-capitals physdev operation names are superseded by the new names
  * (defined above) since interface version 0x00030202. The guard above was
  * added post-4.5 only though and hence shouldn't check for 0x00030202.
  */
diff --git a/include/hw/xen/interface/xen.h b/include/hw/xen/interface/xen.h
index 920567e006..b8fe746f78 100644
--- a/include/hw/xen/interface/xen.h
+++ b/include/hw/xen/interface/xen.h
@@ -733,8 +733,8 @@ struct shared_info {
      * are delivered by this mechanism:
      *  1. Bi-directional inter- and intra-domain connections. Domains must
      *     arrange out-of-band to set up a connection (usually by allocating
-     *     an unbound 'listener' port and avertising that via a storage service
-     *     such as xenstore).
+     *     an unbound 'listener' port and advertising that via a storage
+     *     service such as xenstore).
      *  2. Physical interrupts. A domain with suitable hardware-access
      *     privileges can bind an event-channel port to a physical interrupt
      *     source.
-- 
γαῖα πυρί μιχθήτω


