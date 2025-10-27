Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B62ECCF9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 11:10:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDL22-000164-Ji; Mon, 27 Oct 2025 07:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDL1a-0000iJ-GV
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:04:32 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDL1J-0005d2-FW
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:04:28 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-63c2d72581fso6565403a12.0
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 04:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761563031; x=1762167831; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=80isSoz7EOdlCaIZfqdN1lA628I3DHM5sFKCGcUmW68=;
 b=TSPh37aPZW4vu1QXTfVnStpNZsT7hT7MQtrkc6ivXSfapjyFzfGftgQ/4ZfG3c4yom
 GH4V4QV+9XWeZ4r+fpg3WiJzLwGSHagvTsiEANHzfeL8pOohfpEjf7LU7GFCSbSugOUu
 N8S3j8OmJBdpGJv/Js5hJmZy8te6kSlB/kPeZ+xOn/eeHyAm1+TA8v5ZcaULxVP2GUwV
 DHDE3vB7WzfVHSfqVa69Vn53nAavojUoxogYL7x/dUgGKCX9VM+dLetStcL/0xjo7ieR
 edbU3Gjxj6K8f47XTczS1/WME7wg4ImMLmPvPk0tbM67adn2slhmHpJFiIqA6T1HanK/
 nLXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761563031; x=1762167831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=80isSoz7EOdlCaIZfqdN1lA628I3DHM5sFKCGcUmW68=;
 b=IuPLVJGFA5G0ZHO36hf3gt6TjpRnoXCxwO9WxVwt1ThmXygCW3ncTeCCaeOc8HxJWV
 bOCCxKfJ8tSlPVbrs6IACglDg2OzYacV+6Ol6rK36QKMZhlR6lxyfVI7cV+vM+yTcgd8
 ofvbhhpIePSTZwC2/F4fr+ucb3EuqB0shmpOBXjsihFp8fdV3nIWh/rz/fiHj8bajtVf
 cGSxZuNsHHEalSL1/QsdOlXNi3gbpA4Xp/IdnMGbVNxVyNrSR5HZlkZGP+vxgBsCDxJo
 uLeF1ZZ4TzIBM19I5XjYm7DfvGRdMWJx+dinIjbSUWjJ7OvLdkCPvbMUQdZ4+5JZUxte
 YhtQ==
X-Gm-Message-State: AOJu0Yz+qlyO32y1pX2ICn2CzBcSsg6kQCzdjOmiBCm460a8F0UwBafz
 GhNlFLMZ2nz+Z22BSR+AHdpOjCJsxCj4d9NeIRZHsCy9YvmHHcf1eSKMAmuIYj+EAos=
X-Gm-Gg: ASbGnctM03f5dWs+TkZ1XIGcnomM+6gqGGzwR/SCUZDT39K10yEN3mYjM67kRRjFx1h
 S6pxhmUdouhuligrVr9h5laxfmi1LNm9De+dkxLYV66MG5gDboCyoVAmiA+Y42dlK1bir+gjEzl
 KNygJXMoHez9a3rXsCYdBT51NIQjTqU03GA+4JpHqCF0pxXURUlSN6Pg8WqqA/3L7pLYC+f0zma
 iqBg9rGHyzNr9xYaBPzEOqowuAo69hgLcXiz1G6/gamG4zldD4D2yg0firufrvjMaxfc97d644g
 oVpBPu7izLkTteBvE2y0dUgOV0z+kTenpIpHcDSSsUu4BBjCWqEb/1C35cwkY97LUQTvFpD0ksi
 2/Bc+9olpIfqyH+7agfUf4ooMBYOYtP+RmemDtaDfGzFLTqSbnpea+89i52DnD8tSHNN/T0coOt
 u9
X-Google-Smtp-Source: AGHT+IEwkJfYwImH4/uCjYjquIxa9anv7Yli+nUcbmModwXg9PXqYo5p22WyVAQiluKBu9SNJZsjpA==
X-Received: by 2002:a05:6402:5191:b0:63c:4f1e:6d82 with SMTP id
 4fb4d7f45d1cf-63c4f1e73acmr31079387a12.24.1761563030929; 
 Mon, 27 Oct 2025 04:03:50 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63e7efb950csm6163477a12.28.2025.10.27.04.03.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 04:03:49 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BD2B55FAD0;
 Mon, 27 Oct 2025 11:03:44 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Chinmay Rath <rathc@linux.ibm.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stafford Horne <shorne@gmail.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Laurent Vivier <laurent@vivier.eu>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Michael Rolnik <mrolnik@gmail.com>,
 Song Gao <gaosong@loongson.cn>, qemu-riscv@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>, Julian Ganz <neither@nut.email>
Subject: [PATCH 07/35] plugins: add types for callbacks related to certain
 discontinuities
Date: Mon, 27 Oct 2025 11:03:14 +0000
Message-ID: <20251027110344.2289945-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251027110344.2289945-1-alex.bennee@linaro.org>
References: <20251027110344.2289945-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
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
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/qemu/plugin.h      |  1 +
 include/qemu/qemu-plugin.h | 44 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

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


