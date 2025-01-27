Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F002C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 20:48:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcW28-0005aS-O5; Mon, 27 Jan 2025 15:48:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lacraig3@gmail.com>)
 id 1tcVYD-0006gh-CN
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 15:17:42 -0500
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lacraig3@gmail.com>)
 id 1tcVYA-0000UX-OO
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 15:17:40 -0500
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-4679eacf25cso28325941cf.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 12:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738009057; x=1738613857; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WcKTGMMiTjZZht9zvN7I639YNhzuzVFjcTQBn6ctpVY=;
 b=HOqBmzuv9YbRb6elYMMF/SfwRNORm7vewrSfT+91i02CUBAb+2ysBvSVlT6D24AsXA
 H5zUA88NztEyNDln9/d8DNzdFjqcozakhfYdHNJ3om+2XDVsWQCH4K6f0VPu/DM891xy
 gvEVp5ndXCfcX3DC5XBgjDjJEfrI2qLF7TH+0n7/5Aumt94PfMhj1dJ6FJr1ZHAh2SmV
 CCYEeZDbaDTYnF2jswwLtgXoB8FQcobklJGwQfPyZgx0HCbEpgVv8z1ROZJuonWtQ8qY
 k0RfDOO2LXWLeOMsmziM8I8ToOcVHvGcSGrc4sn31Vh/jTsVJLYoyfsoGWc9Lb3q+Hez
 2MNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738009057; x=1738613857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WcKTGMMiTjZZht9zvN7I639YNhzuzVFjcTQBn6ctpVY=;
 b=mmwffjpe6tlUtzHAcGGLMGlOSY9H2kI8jxBOseUaMuF3ITKDQ2i+Dki8SiRRESpJtg
 N4110BZA7b67qmu4x4pyOMZhdDWxBSlzUOAlNmB7S6ssC0rKz2mfYMzm5Gal3H2HBSE9
 AF4PX627j6MrL5C8S9srmMxeJgnWoFbjkk7JOQ5t7Wx3GjA/kN3CDsgHdBfbyeR89c/m
 hnmt34odMba3PuucdenFMRSb6lLVCyM9eKEz83T0NHhQc6hwt79qts1DL4DQRZ4ZuSTm
 Qd4EFoh+lpQYbFnji8vKX1rY8gMTyGFzp4L/K/yBKG+ZW3oYz2RK6Vcl/8JopUEuaYh9
 RlXg==
X-Gm-Message-State: AOJu0YwsKOnm2UqgpqMtodmqeU/H314sT2oORj952ubu1qRWSz+F2TV8
 c7e7LVF+PoKoZGuCrgAz3FDWlahi6iuWR5DNE9Km6LSeDZTsiRpIT1Bfw1sf
X-Gm-Gg: ASbGncsD+6KZ/Ec88JkhTZFr11SRMgXjO44CPV0pHuhh1LsDnkdBMMBzZCxEnlAhikp
 y/Uhrz62qc3iuEO8DruGjJrBnQ6bly8C2xWX9UXOKOvvt3ndQQkm2lavdlgvz3QwHn5cpiEoxRa
 EhDSsO02bRMhO1Q0Xy2CQYFArOqTJN6GzJOGrOwzzbrZtXPAB8T/CPq1bMAGw7QT2534wUEvvrs
 btOw4y93OTzEFzo7iOodAQhPmiEm8F4Nrz5Wci95mOX7eaMRZXCP+xKHdFysxcxxw7JX0fnZoGX
X-Google-Smtp-Source: AGHT+IGs76o6hwvNVVabsf2sPFIcodGALqJHGphFjIbC8Ps2ENXLhVDGa8OaPQDZfMOZNVk5joTEBg==
X-Received: by 2002:ac8:7608:0:b0:46e:548f:ab8d with SMTP id
 d75a77b69052e-46e548fad8amr289542651cf.37.1738009057164; 
 Mon, 27 Jan 2025 12:17:37 -0800 (PST)
Received: from luke-igloo.. ([18.4.85.124]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e668636e5sm42601081cf.4.2025.01.27.12.17.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 12:17:36 -0800 (PST)
From: Luke Craig <lacraig3@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Luke Craig <lacraig3@gmail.com>
Subject: [PATCH 1/2] plugin: extend API with qemu_plugin_tb_get_insn_by_vaddr
Date: Mon, 27 Jan 2025 15:17:33 -0500
Message-Id: <20250127201734.1769540-2-lacraig3@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250127201734.1769540-1-lacraig3@gmail.com>
References: <20250127201734.1769540-1-lacraig3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::836;
 envelope-from=lacraig3@gmail.com; helo=mail-qt1-x836.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 27 Jan 2025 15:48:33 -0500
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

---
 include/qemu/qemu-plugin.h | 11 +++++++++++
 plugins/api.c              | 13 +++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 3a850aa216..a1c478c54f 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -500,6 +500,17 @@ QEMU_PLUGIN_API
 struct qemu_plugin_insn *
 qemu_plugin_tb_get_insn(const struct qemu_plugin_tb *tb, size_t idx);
 
+/**
+ * qemu_plugin_tb_get_insn_by_vaddr() - lookup handle for instruction by vaddr
+ * @tb: opaque handle to TB passed to callback
+ * @vaddr: virtual address of instruction
+ *
+ * Returns: opaque handle to instruction
+ */
+QEMU_PLUGIN_API
+struct qemu_plugin_insn *
+qemu_plugin_tb_get_insn_by_vaddr(const struct qemu_plugin_tb *tb, uint64_t vaddr);
+
 /**
  * qemu_plugin_insn_data() - copy instruction data
  * @insn: opaque instruction handle from qemu_plugin_tb_get_insn()
diff --git a/plugins/api.c b/plugins/api.c
index 4110cfaa23..7ff5e1c1bd 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -258,6 +258,19 @@ qemu_plugin_tb_get_insn(const struct qemu_plugin_tb *tb, size_t idx)
     return insn;
 }
 
+struct qemu_plugin_insn *
+qemu_plugin_tb_get_insn_by_vaddr(const struct qemu_plugin_tb *tb, uint64_t vaddr)
+{
+    struct qemu_plugin_insn *insn;
+    for (size_t i = 0; i < tb->n; i++){
+        insn = g_ptr_array_index(tb->insns, idx);
+        if (insn != NULL && insn->vaddr == vaddr){
+            return insn;
+        }
+    }
+    return NULL;
+}
+
 /*
  * Instruction information
  *
-- 
2.34.1


