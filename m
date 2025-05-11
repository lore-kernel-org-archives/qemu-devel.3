Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A39CC3ABC5
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 13:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uE6WE-0006Qo-6A; Sun, 11 May 2025 09:15:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uE6WA-0006P8-Li
 for qemu-devel@nongnu.org; Sun, 11 May 2025 09:14:58 -0400
Received: from mailgate02.uberspace.is ([2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uE6W8-0006m5-DA
 for qemu-devel@nongnu.org; Sun, 11 May 2025 09:14:58 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 7F26A17FFFF
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 15:14:46 +0200 (CEST)
Received: (qmail 25911 invoked by uid 990); 11 May 2025 13:14:46 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Sun, 11 May 2025 15:14:46 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>
Subject: [PATCH v4 01/23] plugins: add types for callbacks related to certain
 discontinuities
Date: Sun, 11 May 2025 15:13:53 +0200
Message-ID: <dd35ee0194bc8c30340b31c85ea1e5ba64eb9140.1746968215.git.neither@nut.email>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746968215.git.neither@nut.email>
References: <cover.1746968215.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-3) MID_CONTAINS_FROM(1) MIME_GOOD(-0.1)
 R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=PNobHiGUf869pN4ZoD111xxkjH57FzTLCI3b/hS8dYI=;
 b=tfxwGixhslnPDrXrxSvwbbUEX8jyXnlCzEnbZxndwM0Qk7ooI5AWXHI04ZmR031WoEhPrMkqvj
 nHkBGu2BP/5gdnwXGJ8OZOsr3jDqOcQ8opQKwyFLRH1q9OSZcNxGkRmg3Lh4e70MLOq8rGgGY+sF
 TVyXxPGeU4+phxlSQfNDmpIgjbMEv7cRIsF9SEdWFmdRjh+J5p9BpxDCxUnKaK+qdp5xgrQPoiJa
 lL9cXvDX81ddUO5D6VkuZLj48Q+az07MsBH7CzXJeo6XfReB5Xa/RZKCf0eW5mPSc50wVTCG1ws3
 +H53BFqIi8f+eXsktM2n3xQjhoUoVAA45prMZz/bXa4Jq3i84vCgpbzKKlN4x5ORAmwFztX9pI4I
 nhcNCgJ1LXUv/RbeGRRh0crLbFCA8WDH35UEbEEvXEHROtVIS9sGapD+bD22uOMW+tG7XQCQJQmc
 6kJldi27S8x6EhWOsEWt2MYekSJMmg11NVQvFpdrAs4BG5IcZQgXUJC/sVicMejaaqqVLi367gb4
 yrNC+6sIjZbYApaO7we2RsKth8zTYCq0NXjxf64Tz3uNh5sN6w8U2K0CtYF+nWzgjhLvy4vB/TiT
 4YZUsPaWNjJ++5lPZeevEMT0MjwE74Ac9O/UI/7OOTLvYyvJT9FOng/LAtDAbQQugUeMZgNoY4X3
 A=
Received-SPF: pass client-ip=2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4;
 envelope-from=neither@nut.email; helo=mailgate02.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The plugin API allows registration of callbacks for a variety of VCPU
related events, such as VCPU reset, idle and resume. However, traps of
any kind, i.e. interrupts or exceptions, were previously not covered.
These kinds of events are arguably quite significant and usually go hand
in hand with a PC discontinuity. On most platforms, the discontinuity
also includes a transition from some "mode" to another. Thus, plugins
for the analysis of (virtualized) embedded systems may benefit from or
even require the possiblity to perform work on the occurance of an
interrupt or exception.

This change introduces the concept of such a discontinuity event in the
form of an enumeration. Currently only traps are covered. Specifically
we (loosely) define interrupts, exceptions and host calls across all
platforms. In addition, this change introduces a type to use for
callback functions related to such events. Since possible modes and the
enumeration of interupts and exceptions vary greatly between different
architectures, the callback type only receives the VCPU id, the type of
event as well as the old and new PC.

Signed-off-by: Julian Ganz <neither@nut.email>
---
 include/qemu/plugin.h      |  1 +
 include/qemu/qemu-plugin.h | 44 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 9726a9ebf3..27a176b631 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -59,6 +59,7 @@ union qemu_plugin_cb_sig {
     qemu_plugin_udata_cb_t           udata;
     qemu_plugin_vcpu_simple_cb_t     vcpu_simple;
     qemu_plugin_vcpu_udata_cb_t      vcpu_udata;
+    qemu_plugin_vcpu_discon_cb_t     vcpu_discon;
     qemu_plugin_vcpu_tb_trans_cb_t   vcpu_tb_trans;
     qemu_plugin_vcpu_mem_cb_t        vcpu_mem;
     qemu_plugin_vcpu_syscall_cb_t    vcpu_syscall;
diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 3a850aa216..0c036e3292 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -154,6 +154,50 @@ typedef void (*qemu_plugin_vcpu_simple_cb_t)(qemu_plugin_id_t id,
 typedef void (*qemu_plugin_vcpu_udata_cb_t)(unsigned int vcpu_index,
                                             void *userdata);
 
+
+/**
+ * enum qemu_plugin_discon_type - type of a (potential) PC discontinuity
+ *
+ * @QEMU_PLUGIN_DISCON_INTERRUPT: an interrupt, defined across all architectures
+ *                                as an asynchronous event, usually originating
+ *                                from outside the CPU
+ * @QEMU_PLUGIN_DISCON_EXCEPTION: an exception, defined across all architectures
+ *                                as a synchronous event in response to a
+ *                                specific instruction being executed
+ * @QEMU_PLUGIN_DISCON_HOSTCALL: a host call, functionally a special kind of
+ *                               exception that is not handled by code run by
+ *                               the vCPU but machinery outside the vCPU
+ * @QEMU_PLUGIN_DISCON_ALL: all types of disconinuity events currently covered
+ */
+enum qemu_plugin_discon_type {
+    QEMU_PLUGIN_DISCON_INTERRUPT = 1 << 0,
+    QEMU_PLUGIN_DISCON_EXCEPTION = 1 << 1,
+    QEMU_PLUGIN_DISCON_HOSTCALL = 1 << 2,
+    QEMU_PLUGIN_DISCON_ALL = -1
+};
+
+/**
+ * typedef qemu_plugin_vcpu_discon_cb_t - vcpu discontinuity callback
+ * @id: plugin ID
+ * @vcpu_index: the current vcpu context
+ * @type: the type of discontinuity
+ * @from_pc: the source of the discontinuity, e.g. the PC before the
+ *           transition
+ * @to_pc: the PC pointing to the next instruction to be executed
+ *
+ * The excact semantics of @from_pc depends on @the type of discontinuity. For
+ * interrupts, @from_pc will point to the next instruction which would have
+ * been executed. For exceptions and host calls, @from_pc will point to the
+ * instruction that caused the exception or issued the host call. Note that
+ * in the case of exceptions, the instruction may not be retired and thus not
+ * observable via general instruction exec callbacks. The same may be the case
+ * for some host calls such as hypervisor call "exceptions".
+ */
+typedef void (*qemu_plugin_vcpu_discon_cb_t)(qemu_plugin_id_t id,
+                                             unsigned int vcpu_index,
+                                             enum qemu_plugin_discon_type type,
+                                             uint64_t from_pc, uint64_t to_pc);
+
 /**
  * qemu_plugin_uninstall() - Uninstall a plugin
  * @id: this plugin's opaque ID
-- 
2.49.0


