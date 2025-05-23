Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A65C54ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 02:05:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIHlV-0001Ge-97; Thu, 22 May 2025 22:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uIHlN-0001Eo-Kk
 for qemu-devel@nongnu.org; Thu, 22 May 2025 22:03:57 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uIHlH-0007k8-U0
 for qemu-devel@nongnu.org; Thu, 22 May 2025 22:03:57 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-739b3fe7ce8so6983014b3a.0
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 19:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747965829; x=1748570629; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TL3Io6uv1wYqEJLOSkdLO7yEUmLjlnt6GTg1df0N+1g=;
 b=eNZEd2O404eftQiLnph3APLJ7Eo+Zw8VKZM7yk9uW9wSHze9FqTHXvfscOnWwFHeb0
 iAXejo5xCU54JtpTvo0pDRpNXBkkzBlghZEKoU/W1FgJpu3dCfh0i5uXpHTbGuWW7ylk
 CeflY+5b2Hrh9aX12nfqCVtAZgwamX9Otb21Pt4orhLO6AIPDmWEqbMz12UgTj5BOUGt
 Ps+YRmxMBAN1v68npooFC30VSKd/iS6XccAadNQ5TmdnLztmmuf7d96UbVXia2LjBHd8
 WljEERtJQXrZf05KD+HQAacMMyaAerNuRcM7ck9sMzzD0M7my8xiYhsUfS7bPJYv7ugn
 IyhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747965829; x=1748570629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TL3Io6uv1wYqEJLOSkdLO7yEUmLjlnt6GTg1df0N+1g=;
 b=HGHY0v4hn/7WLLIbKdA7qw4dViPDufZ8IL2Vp4bnW9wi7Lp1w1EDJDovEKwBg6+ETo
 v+76AQvr+LivNKdaXOnsuKq4UFiU+DU0kogh1WStGefMC3hjhTVhpcwKSzI9eg4gDNrm
 AixVPMgClRrGlyHq9ntKveWj5kElhLIanqQ1iLHPJwceMZhrC4sNSMaVLHWA22z1kYaX
 Hz1HJXrIzvDiE0UD3gVC3UWjVv50uswRR8L1kUpD3QRgJKfW0nFebslCiE7dFV7QwZ8E
 mc5lM7QDq5ybFDgYwP9WGbCJ6fEQJcB/Q49e9COORJZY2qhs0bjmc+127H0XhJf1qjJf
 Umjg==
X-Gm-Message-State: AOJu0YxHN6eACbVpRzHBJcoeaCc3ay0AizChpid3ZGraJu0+rLW9u4yb
 plO7/oaEd3seed3mtkHS+Rd4WQSMQGwaARc1wCqPHxL2teWVtF+wXZwWnCW3wd1Lzn4=
X-Gm-Gg: ASbGncv5DFzM1T1LeymyJqYsNbvYAKI/01Q+q6Lj7gUuhh9F3FVRo8kFLjIyO1z4NXe
 xXV1NLGTur6DCAC2GrW7XZUn9GRLgDZSc4JjDqb+NDG3/VpkVn/ZauL3tnQKb/YanfFNFuTVTCi
 i5Pv+KOaZbLdafGrJIqbNwfk6mUjgjFqo8a6R67kD7szu97KDAvhZDBoKb2OzjcRsgwsHS/3RsS
 mPrNNfvveG/FKnJldNHYSjcXuPCfjcwbk+WSLIPeAerDGQmqppXRuoL4k/QDWilS+Ko7JbxKJIZ
 jAk+An1cIcpzTGMREcDMN418a9xZwddQgRa/z+ltCexHnvDKwmk=
X-Google-Smtp-Source: AGHT+IGvHk6WQrsF7M3tQWAkfOk5ZWuoDwGq2l4gQ0sYK9spcEev+7khcDvBWnvJ2cOFsappRkgSWw==
X-Received: by 2002:a05:6a00:3e16:b0:736:53ce:a32c with SMTP id
 d2e1a72fcca58-742a98a252cmr34200830b3a.17.1747965828727; 
 Thu, 22 May 2025 19:03:48 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a98a242asm11820818b3a.164.2025.05.22.19.03.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 19:03:48 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Eduardo Habkost <eduardo@habkost.net>,
 novafacing <rowanbhart@gmail.com>
Subject: [PATCH v4 4/9] plugins: Add memory virtual address write API
Date: Thu, 22 May 2025 19:03:38 -0700
Message-ID: <20250523020344.1341179-5-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250523020344.1341179-1-rowanbhart@gmail.com>
References: <20250523020344.1341179-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=rowanbhart@gmail.com; helo=mail-pf1-x42b.google.com
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

This patch adds functions to the plugins API to allow reading and
writing memory via virtual addresses. These functions only permit doing
so on the current CPU, because there is no way to ensure consistency if
plugins are allowed to read or write to other CPUs that aren't currently
in the context of the plugin.

Signed-off-by: novafacing <rowanbhart@gmail.com>
Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
---
 include/qemu/qemu-plugin.h | 21 +++++++++++++++++++++
 plugins/api.c              | 18 ++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 120fb626a6..8ae7758b95 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -948,6 +948,27 @@ QEMU_PLUGIN_API
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
index 16141f5c25..7258b6590b 100644
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


