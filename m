Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A66CBC7EE30
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 10:45:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWuwl-0006kC-CV; Wed, 02 Jul 2025 06:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWuwY-0006g8-Mo
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:43:59 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWuwR-0001KT-1q
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:43:58 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6097d144923so13717720a12.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 03:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751453029; x=1752057829; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jz2+qC8xETuWCBtFi38dLbw9y0bYYX3IVoNM5Sk2/QI=;
 b=o/iimxjJLB6zvjtrKVVvHkSd7vAQnIQr3Pz+pJc0WN22s0QhUcdwN3LnQWRGLhrRxr
 nF9K/efIF3QDI0OVFqqr42bcDSi14qwIKuovXvufBHZutp0eJWm//2trScmiEsEMHEc/
 tKAj22N5YPX3q44/asm3i1Ym2NG7NTay7d495EQMWqo2kEGhCOhJdPQnwyjuLDkSCHO4
 L6zGKmZDxdBHYkvR3CCP8CBhD/bYPYaImpvG8JWKh9grhVW+dN712dO+c7ZlQ1vk5J9l
 ymbWfPYeLpuAgXwCrn+TwFoOmCqlB6AbAMDX+ywi9Lu69Wu/B7nc1Ftue0r0Tjj9tsiN
 +9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751453029; x=1752057829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jz2+qC8xETuWCBtFi38dLbw9y0bYYX3IVoNM5Sk2/QI=;
 b=EmxDYUWtbX1+QdtleYGgUqx0tUKKJvRk87m8s44eXBfSDJo/iOEehlFQgZm8x64yGH
 7oGj6s0RC1Odu/NOFpU6LlJ4WXV6iIRz55rO79aCb+mdALmY03+31RdXkm2d6GiX5o7A
 9a+ZFiBEOvwmqQ3L8F25rOR57Ru0k4xmMVvR2sIUsl8UTXmBtd+/nhi/B45zehuuljNc
 Qua0OiHqrypa0BWaAXlPwD+UHtcdVLL9QWFAZAGUgToatP3zywkcx8LQjE+dVJHFsqjE
 5bj41Qo59ZiAysU+DYj3vNJ/mRFGve3D24MOvzxJAWddZzXdPey5teygTkiZ1/L0lLZB
 rypg==
X-Gm-Message-State: AOJu0Yxi5TEnYAAArwMv26bru9B7+ZXW8w10+8Eij1rF+evBOMNWpfn1
 /+LVwJrrAUX3vHMn7UvEecvkTcq35ILDy5cUbnXs1RCE2h5bX+O4boIJdvAurFMNN60=
X-Gm-Gg: ASbGncuHO5HbiN95270zGKXNSt03A0pvCkvHylhgN53rR6Kb3FewXHZ+D+SywmTu48C
 q4j31/66bSXtuZ6+ZaplTcES7h9d8JwgLeTIX3C5pQA3Q9ZY+Fy+OyiyO2LioRjOfNrrLUKzKht
 rPfQd91EpY7EaCI8CnGD7YCpQynsysakK+YHMZXmTfw7KYp1U0l9mYagm3TNQFmNQEbVia3nwJY
 S4eA7yHHKIYpn4mUMthoShn6zL0RV6Eg/zfBObRq2VE9wD2iuMwJgqqcXsNNeUf5pncfk2G7tXY
 zWSHBB0xAkhGeYbPrEEAab7cNlELvLv3xR6wuYX4+jjDK/ZoXV710xESTd5/mZs=
X-Google-Smtp-Source: AGHT+IEWtBw0UfgHdFmYSDqnUEUJZwm8dm1g74p/VYPFonJoYROlca2QAaOwLA/bBEpbTVU33M+fwg==
X-Received: by 2002:a05:6402:51d3:b0:608:f816:1f88 with SMTP id
 4fb4d7f45d1cf-60e544eda9amr1975753a12.6.1751453028768; 
 Wed, 02 Jul 2025 03:43:48 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60c8292076csm8710186a12.32.2025.07.02.03.43.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 03:43:42 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 97CB35F8F1;
 Wed, 02 Jul 2025 11:43:37 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Rowan Hart <rowanbhart@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 08/15] plugins: Add memory virtual address write API
Date: Wed,  2 Jul 2025 11:43:29 +0100
Message-ID: <20250702104336.3775206-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250702104336.3775206-1-alex.bennee@linaro.org>
References: <20250702104336.3775206-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
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

From: Rowan Hart <rowanbhart@gmail.com>

This patch adds functions to the plugins API to allow reading and
writing memory via virtual addresses. These functions only permit doing
so on the current CPU, because there is no way to ensure consistency if
plugins are allowed to read or write to other CPUs that aren't currently
in the context of the plugin.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
Message-ID: <20250624175351.440780-5-rowanbhart@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250627112512.1880708-9-alex.bennee@linaro.org>

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 9c9ebf6ce0..4167c46c2a 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -958,6 +958,27 @@ QEMU_PLUGIN_API
 bool qemu_plugin_read_memory_vaddr(uint64_t addr,
                                    GByteArray *data, size_t len);
 
+/**
+ * qemu_plugin_write_memory_vaddr() - write to memory using a virtual address
+ *
+ * @addr: A virtual address to write to
+ * @data: A byte array containing the data to write
+ *
+ * The contents of @data will be written to memory starting at the virtual
+ * address @addr.
+ *
+ * This function does not guarantee consistency of writes, nor does it ensure
+ * that pending writes are flushed either before or after the write takes place,
+ * so callers should take care to only call this function in vCPU context (i.e.
+ * in callbacks) and avoid depending on the existence of data written using this
+ * function which may be overwritten afterward.
+ *
+ * Returns true on success and false on failure.
+ */
+QEMU_PLUGIN_API
+bool qemu_plugin_write_memory_vaddr(uint64_t addr,
+                                   GByteArray *data);
+
 /**
  * qemu_plugin_scoreboard_new() - alloc a new scoreboard
  *
diff --git a/plugins/api.c b/plugins/api.c
index 3f04399c26..1f64a9ea64 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -476,6 +476,24 @@ bool qemu_plugin_read_memory_vaddr(uint64_t addr, GByteArray *data, size_t len)
     return true;
 }
 
+bool qemu_plugin_write_memory_vaddr(uint64_t addr, GByteArray *data)
+{
+    g_assert(current_cpu);
+
+    if (data->len == 0) {
+        return false;
+    }
+
+    int result = cpu_memory_rw_debug(current_cpu, addr, data->data,
+                                     data->len, true);
+
+    if (result < 0) {
+        return false;
+    }
+
+    return true;
+}
+
 struct qemu_plugin_scoreboard *qemu_plugin_scoreboard_new(size_t element_size)
 {
     return plugin_scoreboard_new(element_size);
-- 
2.47.2


