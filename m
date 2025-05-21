Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E6EC54E65
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 09:45:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHfzT-0002mp-8r; Wed, 21 May 2025 05:43:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uHfzK-0002k0-10
 for qemu-devel@nongnu.org; Wed, 21 May 2025 05:43:51 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uHfzC-0001bf-9c
 for qemu-devel@nongnu.org; Wed, 21 May 2025 05:43:49 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-742c73f82dfso3025625b3a.2
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 02:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747820618; x=1748425418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kw+/hkmATb95JeIY1+qMlFeBI8BcaQOwV1YDDwxVg+Y=;
 b=Q55TeUOlS1U50TqKSGWvYlcU2cp5FWLJ2aGseoSe/NbnHx1lYI3oIey2JYNo/RIPKI
 Oyy+plLuKNm6uW0S0x07BP4paA4seifw9EI/NlUFkSLWj/I5FMFZyPjPGCWNJHPyoq9j
 Umlbc3c3VCjcGD6qKFhb7ESvqyl976B83MMtONcyy7LxHgWAF+vBvhxTvLEa14K8uLJe
 Ig5HuMaMEXDZWQPny+SYhCq4MybSq376nswnk6SMhhMdKoDuPMIOzA/QWnm7tM81M8b9
 dQoqFhcLZE4Qilfpx2U41V7DAeOnBxKLWJZhyN4/8B+uWu5MgNvS+6x2u89txcxOuAy4
 KXbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747820618; x=1748425418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kw+/hkmATb95JeIY1+qMlFeBI8BcaQOwV1YDDwxVg+Y=;
 b=duSPa69u3EhbfyCD1sgtdY4GcpBQ+TCvuMwCU858lsNxSFuLLlje34/jMGrgVAnNUL
 SAfYcH9Wd4SljOShZUMkDtxEVcdAs+a9rQ/7ZgcH7Z7mNsCUAQypXwW+dY3ouF0MEfSF
 UzUwdzPPjr+wIBWpBM6gnk+ZZnlIt/SD6HOsVn/euPxpYpXMBwogc2A20wvnrQjezRIF
 4r/WbgBcTm9Lx/nCqvAz9nQ5PflzFJc0mrvrles1htDHW8FgSLTR7oG8/VG27/0QuA4l
 85YbJgdNE18a0jag5tqD7eHPL7n7L+2TAnAm4nTJ3OABnvzv7F3jSY7GKDwmBkrMzdWB
 F0Gg==
X-Gm-Message-State: AOJu0YxwxorQpDIw3q5GjDMAH/crQmwlXxiQUiQcZ51j5hEHxsA0I42n
 Aaje8+/WPopCNgYg4QSXnfpg6y3ebYS+HgngZxt6ix3t8Xqe/2ujhrNkykaZ9yNPvqI=
X-Gm-Gg: ASbGncsASh9Urm89szKqaHpAtZI7/dGeGw35tL2tn0RDJ3Jlf3OHG0ys0/Av/7TiGRE
 GokHLThDHE4Q/qWqySo5BXzfAIpsWpJhfRutmIDg8Nfh4Uf1VE2qlMee8Ba7aX8RF1r0vnO4rtV
 gjp5Rjy+6mWYXUORhm41htgIZAV4QbmJ2GciQm5iObMvbgjCVT0WSYoYBp/vaz9K7JOrEQIRuMr
 4U1VAnGBElMkaZIIBpVh2Gvq6pAwwQTorKzhY1M8XkZH4IOPvD1kq/zdN6zOUY0BZtF/AnHSvZj
 4a9HiS+kdWQebwFevNVEj6Ea/D5aeZuuN/ylzXIcVRaphkvvPEw=
X-Google-Smtp-Source: AGHT+IGqAHnSD3kFcXORJSPJhI1kBd/CJm6Kh0XdOkFd9XtM/pkgrNAx3AZexOAoI9/kFo3g6QT0pg==
X-Received: by 2002:a05:6a00:3c89:b0:740:a023:5d60 with SMTP id
 d2e1a72fcca58-742a989f492mr28881001b3a.19.1747820617776; 
 Wed, 21 May 2025 02:43:37 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a9829b87sm9255668b3a.114.2025.05.21.02.43.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 02:43:36 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, novafacing <rowanbhart@gmail.com>
Subject: [PATCH v3 4/8] Add memory virtual address write API
Date: Wed, 21 May 2025 02:43:28 -0700
Message-ID: <20250521094333.4075796-5-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250521094333.4075796-1-rowanbhart@gmail.com>
References: <20250521094333.4075796-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=rowanbhart@gmail.com; helo=mail-pf1-x434.google.com
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

From: novafacing <rowanbhart@gmail.com>

Signed-off-by: novafacing <rowanbhart@gmail.com>
Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
---
 include/qemu/qemu-plugin.h | 21 +++++++++++++++++++++
 plugins/api.c              | 18 ++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 1380f7d441..eff8430b4a 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -993,6 +993,27 @@ QEMU_PLUGIN_API
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
index d1cc6ff86e..19c10bb39e 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -551,6 +551,24 @@ bool qemu_plugin_read_memory_vaddr(uint64_t addr, GByteArray *data, size_t len)
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
2.49.0


