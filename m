Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09FCEC7EE3A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 11:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV7DM-0005Ne-U0; Fri, 27 Jun 2025 07:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uV7D8-00059H-SL
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 07:25:38 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uV7D1-0007C2-9K
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 07:25:37 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a522224582so993537f8f.3
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 04:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751023528; x=1751628328; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r3YHCH9Vx9jwaVt/qjrhR+H7QrQ05OqcT22Iq4fVf7E=;
 b=lJRc+Nx0P9y5CKGoBCi2jaXlzy9OBnvbQJsd4HYQ5l7h/bt2A4qM6vKmyVMLBPRw+3
 V70BoJzE+uuwgh+jmvya0GJJK/pV2638RHN9CLUbN2Omw0suuZGiqFKtYMfcabb924W5
 vKdiR4hEfFqkiIMfpmBrdS44dTnhzEAY0bCZqFVvkVhzNGFmdmPef9kX0rrK5igIs0Oc
 HRqy89J++YWEkewAu9RjW//t5SXIdoQlpovQvzr+aDn+UacT2WaRYV0nD9cXzlwLRR2N
 PJmNoYiWF6JEIJkRwiOg6ByjUGjlw7T2Pd3WeGxFhsfyjzSF07swmVTkZkbt+/e+A+Zy
 apNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751023528; x=1751628328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r3YHCH9Vx9jwaVt/qjrhR+H7QrQ05OqcT22Iq4fVf7E=;
 b=GnvlcIS8AH7aq6Cv56c43QPcPisltw4KOAmBKRV6pFvpcdAu1TiNBm7jtX0RRtnOz8
 CzKh1WJ+3G8CA2cuSuHxGhMuI6L2SNG1m6e1CC9b3N7E+lfPDdz61puBAq/vwmgyvOjm
 gRhHI4VJWtzhrdRSbcXUgnZs/nlGWD3U9bCdfOb1TIikfOoNGaQNrKC0dnISHQmkv5Jl
 XiYQpDyF7wnzuemKdbsGevTLuMptxc9frhW0/IDZH+lxrMElULJrAfbO//ONpFKItlpm
 9toWpi8blN4EBbvs3QonCofrtpOrxd3HFlit0xR2VypxvjCpabQ1uu5O2++hLQq5cIyJ
 UgOg==
X-Gm-Message-State: AOJu0YxAzxFs7p73C7SYCQr5sgAv39UkI4bAwIb3LD7CYCMY8E+FVWT4
 7atoQzT5UdYtDvnTJEufewWrBjBGyNVHjEIllRujt8njFj/aamhO0YxZDoX8BpKAuD8=
X-Gm-Gg: ASbGncuWMkDkdI/1uzhX+NBqmqjqb7/6auxcPb0SDtRO9drNmW2chB4BJkxXNTo8EPU
 Xv1sNPilgYzQm1YOe07sNQd05RVhaMb0xZtKRRkyS0VY+Vrki7JWo4GetfAfAjTxVzvpwM9fMra
 lmbZoFcHitiEW9Rq+nGVo/UB8dpzwbyeiA6W0ljpWfHARnvEyeKr1MiNEIZBbSYkvj2hrZ3WvkL
 +IambRI29Jq8wa16BdKfOBkwxnmiWDAGYtOXh0L6bw4UmXMVOAN0BIJg/7URu8YaYU0A4c/K40R
 8GXtVJ73M6aldl26CdLRoche4fVs8WZuXKbjQ44NqN+G8jzGY+z4orVd9ME0PlU=
X-Google-Smtp-Source: AGHT+IFa/ZXjmAHipUOjWD9OCrgHu9incO6kwvMWapD8dJJoXjz8oEhqlrh0ke3sYxDBetA4CtG82w==
X-Received: by 2002:adf:ae02:0:b0:3a4:ed10:c14 with SMTP id
 ffacd0b85a97d-3a8fdff4355mr2084975f8f.14.1751023528271; 
 Fri, 27 Jun 2025 04:25:28 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538233c749sm79308685e9.4.2025.06.27.04.25.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 04:25:20 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F1D245F90B;
 Fri, 27 Jun 2025 12:25:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 qemu-s390x@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alexandre Iooss <erdnaxe@crans.org>, Rowan Hart <rowanbhart@gmail.com>
Subject: [PATCH 08/15] plugins: Add memory virtual address write API
Date: Fri, 27 Jun 2025 12:25:04 +0100
Message-ID: <20250627112512.1880708-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250627112512.1880708-1-alex.bennee@linaro.org>
References: <20250627112512.1880708-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
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
2.47.2


