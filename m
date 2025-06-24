Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C9AAC77B7F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 17:55:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU7qY-00031h-4m; Tue, 24 Jun 2025 13:54:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uU7qL-0002x3-Cu
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 13:54:01 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uU7qH-0002mC-Um
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 13:54:00 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-73c17c770a7so6092256b3a.2
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 10:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750787636; x=1751392436; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rScIR27n9i6dN1NjlWQKj1zSHK/8glc3yPQGNsFP5G4=;
 b=Lg4F/LV5qgMMXgAQwd0WQ2BsyTpbc4KkFRls33YR3AmuwiFZK4IwLMfQK0flPiuq33
 Bz6ZHoWXB2fJY/r/Q7JTWt7uLbOgPKbGgwPIqxMlHX7z9vXVCfpW2VipsTQdcjsfvVpp
 XUY7VwmP3KNuj55l9mDMgtZnEYwy3JllyaJizUXSMD607wZmVB3zXngcDPhW2vyQkv88
 OACeCaCTg9kjZsAv4EEXYXEwMniewD372D4ai8jSVk9irfwqkAgki/gmeypITs3GgQap
 +fZfiCxJBMBCL3dCgxltvoX3dl85MuY9hvxlyKdycGrDtZ4HNPMoLD5QExw4nZHeQEWE
 /Jfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750787636; x=1751392436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rScIR27n9i6dN1NjlWQKj1zSHK/8glc3yPQGNsFP5G4=;
 b=ZbHhNi+FBNsUQbT47/9WBFS3uImh/BedURSRNWlM+jD32s5FzIfzmf/lrXwewvMY3f
 cQU/tqs9IN8PjmR/VCwqJuHNItqVQYExqjcUHb6/DsIBaj8OztgwfTU4y6QXvRdWlr7Y
 gxWYKbtj+77CfA7cL+VSZhj6Mm5ST3yOV2iSEO/twst1lixgnL33suNQ56YQo3O+U8co
 ZiEjyA9Swj/ii2H8AYq9b4CLk0pHjfNiWCqJdKENNoYlBC6lxwKZfi2U309g3UJbEAdz
 MgugAvBDrPMsoSIHgOrfqdX1ycsbKN5bQa1Zbxa4fJd/Gd97aDdluwOOKs5zRdQzGem4
 Dkkw==
X-Gm-Message-State: AOJu0YxRfMQrSeEQBYGm9QkftlRNXUrPibLMdGjHY+7N/yODNAjNSczh
 2412RVhH/YFRMKstsCEPMeMNnB86+XdDlAxwPb5np+AFn6a6BlxZcAUqqQyS5uwS778=
X-Gm-Gg: ASbGncsyxtBvheHdHqTLvVIFK+K5hhGAwujkA5/JBXDA+sG7m5TtCwBvuoFnhjXxVMC
 jNPl0cj0frDPgdmXzDFHaPFcc36DuVwlEBkXOhMFr9qspuSrFtGC2PwMuvccBNVKLMZwUtG+Ht3
 l0H4GtVVCLPKlB60Iu6lovDkoIFIGhmvbNLGwSzULAsHaz3lPp75kbRAbJ2uRTNiArflCPReaEe
 ldaM1Pcn5qN+kaOMxthqXKmDMClQrEVyB2MlKZKrgVq7o+4Yntbt0c73QfW9EwofdeM0krlATWK
 wlhyzJoR72wI+cXuygR74EkxTSLtNyE2IK6BIOQiHGvH3mPM5cWcKJPk2K1dlA==
X-Google-Smtp-Source: AGHT+IHXoW7PY+On6qtK8QvNTetC75fyOjixusiE3pWIbQVk5uq6IBKEwN7veUbAjiNwX+8AksPFIA==
X-Received: by 2002:a05:6a00:2d91:b0:736:35d4:f03f with SMTP id
 d2e1a72fcca58-74ad44774famr58471b3a.6.1750787636301; 
 Tue, 24 Jun 2025 10:53:56 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b31f12427b7sm9318153a12.40.2025.06.24.10.53.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Jun 2025 10:53:55 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rowan Hart <rowanbhart@gmail.com>
Subject: [PATCH v14 4/8] plugins: Add memory virtual address write API
Date: Tue, 24 Jun 2025 10:53:47 -0700
Message-ID: <20250624175351.440780-5-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624175351.440780-1-rowanbhart@gmail.com>
References: <20250624175351.440780-1-rowanbhart@gmail.com>
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

This patch adds functions to the plugins API to allow reading and
writing memory via virtual addresses. These functions only permit doing
so on the current CPU, because there is no way to ensure consistency if
plugins are allowed to read or write to other CPUs that aren't currently
in the context of the plugin.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
---
 include/qemu/qemu-plugin.h | 21 +++++++++++++++++++++
 plugins/api.c              | 18 ++++++++++++++++++
 2 files changed, 39 insertions(+)

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
2.49.0


