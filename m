Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85506CCF9F1
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 15:57:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE8SA-00044x-F0; Wed, 29 Oct 2025 11:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8S5-00041q-2T
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:51:09 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8Rs-0002sk-JG
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:51:05 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b6d3effe106so2704866b.2
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 08:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761753053; x=1762357853; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Kd8waiEhdlSlAVSoCg9cTPL8dWN6kzQLSSEo6gGGq8=;
 b=rpl+3WuIuW71LvxTyMqVTe7epZ3PkigkrnoL0BT3eSDZej3iq94MAivyyy4SDxJyzD
 l4xYfrbUCbFyMouvbKkqwbW5BFH8Twb5q8xQt0VZvvW+q7xlL4hpvDTz6CwQQqcSTajT
 L61/QqlUu4j5IKXoGeU2F0DmWjgd9bHYTvdIzTJorphgio32BveaQUhZMjui0QEPmXGp
 20xPnzheBBXvjNWUcvzgAQ2yXTut31X7yeQ/QWY2/sVlD7hjjoCtqJck18EiEi1lKk0/
 RXNSq8eQcD1lZHp7HpmbNZPLdI5t1sPl/NykuYFBbqlQvSSzM7B+euYTKg4W+CIErOWD
 XH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761753053; x=1762357853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Kd8waiEhdlSlAVSoCg9cTPL8dWN6kzQLSSEo6gGGq8=;
 b=LJeFmK9bOZRMBr8nuKxkQbPKEq1aSfOvujoTOdEmlbNPmdA4zp3iuHqM2j+edBA0qp
 1jBiRKy8XX6vt3yBYZGd0oe0aPEpoFzxvARUDmU76xE4NRVjihqmVdt4y2mrCrzUTYdg
 p2qqnaBTu61R173V/eeG5rXRm2Rs3qYtg6cGLZfNJYJvWTbZlYmR80j0F5YzMMD7u9ar
 4D5BHqGlXvEDjxJ6ykr9IADNMQazpJZa00Z9dGWN0qJGlyb6G39RLz6CnNCiA1/iyKod
 nQpYrspxcgwrC990r0PFGO39eoS5ZzgQrMMFEpl53dJWFY9hz071ayA/mIFvCNOm2021
 87gQ==
X-Gm-Message-State: AOJu0Yyh0CxxElUB6h5B9hUIsj9Gpey/YLlLEmtPLJCW9wq6Wgt7lWp6
 Jwr11N5mVlU57GerGlCCKtAWNba7vgZBnsDj0XM458v0jvt/mMoIAvD8yt/v9GEnt4Y=
X-Gm-Gg: ASbGncs/LOguuSQFiRxXObDa2kWtxDLUzgyYqm8RcWC2FGu7xKbEcumAoihOWI7KY8s
 2UxhnQoF7FTnsIg6fNBY8+kIrr8TJxU6yJBR4tpgHO1myWKUqP1gzYPdROkKmel+Aw1osJcC2eT
 IZvyiHaZ2QAf+iM17L8SNTURJt0sEDTV3Ao6t0SWWx8cR8/qmxmeUuxAqyCOxcnS0BmnhiZ93jD
 I3kXMYDfOvq0OkICnznyB46IiGWESXfzJo/fy+VdXy0lMEs5xN5zXKL+nrSBnZy4lCj5omV24rg
 gcBAcv8PYKDLKkKspeQ7mW1lhY/mZSQ2gZbT5Ate8fgL2kl5mA2Slnr/f+TBLVpX3almGUw21Sj
 f3pp/ZAwYkRtYWvRH/z5FEJelhfwrtoJd0qMwssnkSeK5c3nYSuoiyb5r9LJ2wRB1uR+F2B13/h
 sV
X-Google-Smtp-Source: AGHT+IH74DfAcpZzJjY5gVucN/iocAD2IdJwRSSi7LcnqQGKNq6pzCc8B0Oo1aWNXUavs+VjXcRB6A==
X-Received: by 2002:a17:907:1c93:b0:b55:e023:5e79 with SMTP id
 a640c23a62f3a-b703d55cd84mr392077566b.51.1761753052555; 
 Wed, 29 Oct 2025 08:50:52 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6da1e2226fsm1058027266b.20.2025.10.29.08.50.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 08:50:50 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 851835FAD0;
 Wed, 29 Oct 2025 15:50:46 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 07/35] plugins: add types for callbacks related to certain
 discontinuities
Date: Wed, 29 Oct 2025 15:50:16 +0000
Message-ID: <20251029155045.257802-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251029155045.257802-1-alex.bennee@linaro.org>
References: <20251029155045.257802-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62e.google.com
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

From: Julian Ganz <neither@nut.email>

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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Julian Ganz <neither@nut.email>
Message-ID: <20251027110344.2289945-8-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index f355c7cb8ab..8cf20cd96f7 100644
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
index c450106af18..08bf366e363 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -161,6 +161,50 @@ typedef void (*qemu_plugin_vcpu_simple_cb_t)(qemu_plugin_id_t id,
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
2.47.3


