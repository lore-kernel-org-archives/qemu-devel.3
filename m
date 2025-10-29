Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F7DCCF9F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 15:52:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE8S6-00043L-J1; Wed, 29 Oct 2025 11:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8S4-00042I-C0
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:51:08 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8Ru-0002sb-3c
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:51:08 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b6d5e04e0d3so2730366b.2
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 08:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761753052; x=1762357852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fhb+7Qy/aaY0P5BrwBDb6iFOKoQxT9GF6cclukqj4aw=;
 b=aX64Nmrj1glK0I9Fa0Q1mcgCnblV0uy0Tdw1iuZGf5N9ct+U8WP/3H0tWEUb0QN5Lp
 YMf2Gr55YBMJb571GU7ntdpnoy9cf3cwQvsOgHx16Ya1ifv60wH0CUz2C5EAkgGO+E7I
 ao7CsYwwQMoxpFT1cCrDzZRDZvxaPv70audRLJSUDb7VJBgN/DUPG1YF1lnAhy89vmhs
 Mi5tzcWsvw34NYJaSHqbpSFHFnrTt7r8Eb9Mew5W6oRHASI7QTkFasDQmMk+qQs4mOPw
 dFTWC2GafrKKBOBqycTcnsVR/asT78CEytjoXDrHt8Odf5d8KrY5+u56HsZ0AVdjUX5p
 HLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761753052; x=1762357852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fhb+7Qy/aaY0P5BrwBDb6iFOKoQxT9GF6cclukqj4aw=;
 b=HpLKsf9+Mr0kQbOZrsUqW6z6PKXwe3fSxw0vk44hnJORxUsT29Y4yd/5K5Zxqdod9l
 IqUrzI8HJKkzu6FcipD5CqyjDMB7mTE0Oo+2USgtJOEqzrO5J7KpYKnZ0c7otlk/Mvn5
 FcRi4gyLQ7b/y316Xi0lk5eK6FmC+IRQalR7Zg0wxUvmsxgo3f1XBj8+CuRmbooFeppC
 q72yfpo2ek37AcMlKdyDiNwwQgyQXllnQQZpzd2+qpcDPXb6F23q//WXbcFCXUzyq50A
 /Xos/i/I61/Smz4ojfHl/pPFtPq1/PqPVDgYh9Dpm3wXTCWxVbZMwx5Qt1YDOhsLgX7a
 XWvw==
X-Gm-Message-State: AOJu0Yw03dyixEjMNBVABBi/Fbw4qq1UpeMVgl+R4Ja5YsNdtQPLEjm4
 VBctQTPdcfcEFlXCoFEyFVAYxy4mhejZbkpw8m8JobS+qPri812Dn+SRotpLTLsW8Uc=
X-Gm-Gg: ASbGnctr5hygbsLl+bfc0SeClbEMSVxBlZaM1bVolIjJ8JrnQn/cPFabi46t2poFDtD
 tQ0dHWDao4y/yxfe/8M96GDIlwsro8UKWyJqWvXjixyHJOWSG5T4uJP7xLgnCKJpLnZE76ujJht
 vx+9a4ufllojwCEUwhp6/NanY6qT2ijjBbggXMh6c3rcgmcu8mecMVp3t554MncQ3LY0WjVdXeS
 3j2OFK1IdG6YBnWO4peDi6pzRdknnbHly+aR3W5kEzbCE9o8Fo+ZEfqfD1c4efDEFFExtH24XHv
 978n4dLToqghXS+W4V217AE+0Th0K9XCIoYgyaZy10t++dpoMPutiok3iYoeUocznIQvoGqQ1ki
 NgTYcgrDHZeLnNz5ChTUEUpbY5/pshPe2JgjrlRBBAKaWvp3DPJjkqhmuOALeuoOhQuKdKZCijX
 jr
X-Google-Smtp-Source: AGHT+IFCzOgsW8c3t/UdEfGN6N5tXpvg6NmQmmAsgRwrUV2tDyctQC8FL+k4YZRcDWTRKOsG3DVv4g==
X-Received: by 2002:a17:906:4fca:b0:b1d:285c:e0ef with SMTP id
 a640c23a62f3a-b703d36dd21mr334808466b.26.1761753051773; 
 Wed, 29 Oct 2025 08:50:51 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d85353ff7sm1475768666b.22.2025.10.29.08.50.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 08:50:50 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9F4415FAE6;
 Wed, 29 Oct 2025 15:50:46 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 08/35] plugins: add API for registering discontinuity callbacks
Date: Wed, 29 Oct 2025 15:50:17 +0000
Message-ID: <20251029155045.257802-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251029155045.257802-1-alex.bennee@linaro.org>
References: <20251029155045.257802-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x634.google.com
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
related events, such as VCPU reset, idle and resume. In addition to
those events, we recently defined discontinuity events, which include
traps.

This change introduces a function to register callbacks for these
events. We define one distinct plugin event type for each type of
discontinuity, granting fine control to plugins in term of which events
they receive.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Julian Ganz <neither@nut.email>
Message-ID: <20251027110344.2289945-9-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/include/qemu/plugin-event.h b/include/qemu/plugin-event.h
index 7056d8427b7..1100dae2123 100644
--- a/include/qemu/plugin-event.h
+++ b/include/qemu/plugin-event.h
@@ -20,6 +20,9 @@ enum qemu_plugin_event {
     QEMU_PLUGIN_EV_VCPU_SYSCALL_RET,
     QEMU_PLUGIN_EV_FLUSH,
     QEMU_PLUGIN_EV_ATEXIT,
+    QEMU_PLUGIN_EV_VCPU_INTERRUPT,
+    QEMU_PLUGIN_EV_VCPU_EXCEPTION,
+    QEMU_PLUGIN_EV_VCPU_HOSTCALL,
     QEMU_PLUGIN_EV_MAX, /* total number of plugin events we support */
 };
 
diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 08bf366e363..60de4fdd3fa 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -281,6 +281,22 @@ QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_resume_cb(qemu_plugin_id_t id,
                                          qemu_plugin_vcpu_simple_cb_t cb);
 
+/**
+ * qemu_plugin_register_vcpu_discon_cb() - register a discontinuity callback
+ * @id: plugin ID
+ * @type: types of discontinuities for which to call the callback
+ * @cb: callback function
+ *
+ * The @cb function is called every time a vCPU receives a discontinuity event
+ * of the specified type(s), after the vCPU was prepared to handle the event.
+ * Preparation entails updating the PC, usually to some interrupt handler or
+ * trap vector entry.
+ */
+QEMU_PLUGIN_API
+void qemu_plugin_register_vcpu_discon_cb(qemu_plugin_id_t id,
+                                         enum qemu_plugin_discon_type type,
+                                         qemu_plugin_vcpu_discon_cb_t cb);
+
 /** struct qemu_plugin_tb - Opaque handle for a translation block */
 struct qemu_plugin_tb;
 /** struct qemu_plugin_insn - Opaque handle for a translated instruction */
diff --git a/plugins/core.c b/plugins/core.c
index ead09fd2f1e..40d001d39ad 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -569,6 +569,21 @@ void qemu_plugin_register_vcpu_resume_cb(qemu_plugin_id_t id,
     plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_RESUME, cb);
 }
 
+void qemu_plugin_register_vcpu_discon_cb(qemu_plugin_id_t id,
+                                         enum qemu_plugin_discon_type type,
+                                         qemu_plugin_vcpu_discon_cb_t cb)
+{
+    if (type & QEMU_PLUGIN_DISCON_INTERRUPT) {
+        plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_INTERRUPT, cb);
+    }
+    if (type & QEMU_PLUGIN_DISCON_EXCEPTION) {
+        plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_EXCEPTION, cb);
+    }
+    if (type & QEMU_PLUGIN_DISCON_HOSTCALL) {
+        plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_HOSTCALL, cb);
+    }
+}
+
 void qemu_plugin_register_flush_cb(qemu_plugin_id_t id,
                                    qemu_plugin_simple_cb_t cb)
 {
-- 
2.47.3


