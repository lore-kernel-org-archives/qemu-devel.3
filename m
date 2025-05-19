Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD5BC2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 15:21:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH2I9-0006rn-2Z; Mon, 19 May 2025 11:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uH2I6-0006r8-0C
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:20:34 -0400
Received: from mailgate02.uberspace.is ([185.26.156.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uH2I3-0005S5-Nl
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:20:33 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 3EDB9180DF7
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 17:20:22 +0200 (CEST)
Received: (qmail 1343 invoked by uid 990); 19 May 2025 15:20:22 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Mon, 19 May 2025 17:20:21 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 01/25] plugins: add types for callbacks related to certain
 discontinuities
Date: Mon, 19 May 2025 17:19:41 +0200
Message-ID: <08cd73b30ee74d4b264890e193ef56d2270c04c0.1747666625.git.neither@nut.email>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747666625.git.neither@nut.email>
References: <cover.1747666625.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-3) MID_CONTAINS_FROM(1) MIME_GOOD(-0.1)
 R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=/arU7/EJ2As6MS+N1KAvg7D4U6fSqd8rZJUYyNsrlFc=;
 b=An8HopdpwPwo5HnhimKCtfeVD7HbM4PfVJjLBQegGpEn4y3nwidC2pY08UrK8KOmkM9FOIvR4F
 NWIpIjZ8Jmt1SjY0y3c3cOUdDgVsRS0V7JRYjySU8v9Mm9UT+ELHO0rKdUqp5GCWDc3+JwzxyxNG
 VetzaPArwVeSAJ3BAYNpJFUSssaOPRdNmj1XvRqLCzn4QjcwLfwzklDYJivktKUPLw0jnrNAT037
 NAgSQc4ssw2t3/gZnq2I5IUENpTJldK6QxMk89A5Rhv8YPR3wtugE7pxgz1MqgkOaomkwcX+785Q
 nFtVzMNLfgho4zmreWLw7YJJIqgv+F+6QoeQgVYVI2NVOzq5Yq+jEj6VqrPTkf1WHwZ5GSq9DD0K
 HmTu3Y2PPmgyG/IQ0d1QCfiYcvpr4DNfKkG+7R5BYmSJjp/cua3/yu7bb2dLqdMcBCQ5EaeaoHTC
 5unG+sva9x6jEkKDzg+KGd0ugqb23IjIlcFboNX9EX1hAay6oWwgGUedxwZHip2nT0CAEbnh5/Di
 jqHWeZN/nyxs8BJ2qex1KSR+slZuz+Tjzwnplz17loqkhbtSE2s+I3t74oPyE5RgQaCh0BJLU8Cy
 XjpPmMpP8lCn9vTEK9bJH+w0MNerzqLclnzdLg7q2F6nLJCOcZpidquWXpzYoehecOo5RoGqhMT7
 w=
Received-SPF: pass client-ip=185.26.156.114; envelope-from=neither@nut.email;
 helo=mailgate02.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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
index 3a850aa216..2e849bff0b 100644
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
+ * The exact semantics of @from_pc depends on the @type of discontinuity. For
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


