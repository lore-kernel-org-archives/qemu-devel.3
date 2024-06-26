Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 504EBC27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 23:39:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMcDr-0007W6-TC; Wed, 26 Jun 2024 19:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sMcDK-0007Rr-6Q
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 19:38:12 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sMcDI-0007Ft-Fq
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 19:38:09 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1faad2f1967so120105ad.0
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 16:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719445086; x=1720049886; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pEE58Wfx3Oif89AADmhPQguadlcOn12TkYSZVg6ccjY=;
 b=rg0Ph9VnKXP78yvmrSJR3pcdE5y+2Hrr8Y/nCjNrLYsF0Td/grm3VPFNUGOQI1mtHo
 Y6AbcxYn0AhrVMwrJcFXHmot2M8klm5xuDcXU7QW9jkXoy3gVTUcTOm3LgMdaAyT54Ib
 M/GGi9vqYJcVKqxNgKgGi+FPMtWkbPjVbhB/uvLx3N/FvqJRMYCVzhyCCWvjvI18GHnl
 gdZ0dLufOI4P8HblsLsXVWCK9lx2ud5oi6yHmk+/yTtbmS0+GESOVffbNM6zl8cfogfk
 lVb8sNKgJ/OvOYF5wd1IZBuJ0xqFOT2ni5WxV7tC2ZSbka6OwuhyG3Za9jwwWN0ipw65
 Xtpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719445086; x=1720049886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pEE58Wfx3Oif89AADmhPQguadlcOn12TkYSZVg6ccjY=;
 b=Kv0l00BS58E2h10snFROjMAdDZ7JOqtwTj+lo/ojsTvycDaTg0otqiq5HLaSEn3I+n
 k5i2ggJQNyHg+av/X7bRufmx3hJXAAkF/VVTaisfR+3MpPT0Rx7YuEyrJBnXMI7SvHs2
 tSqvWoFSomGxoZIMIXIY+WBTm2LzcAuhIY65F325JWSoy+LyhtCTaJV1ruGsh0ohfrLG
 ZA7FHEZkRuNlJKEsY2g7dvGeznvJmPEry6dcxPGNy03fvg3b3aNd9qOWJldo+tL54zzE
 3eUJf4W06drlpHvyDXp5XF4+2NLWTEZIX1VXXan8Un5Op1TocaBGvnA1R/yw+8hVkL0R
 mCsg==
X-Gm-Message-State: AOJu0YyWug3g8yLSmtnlmzTJJkdkGxk/4FzKiESOEroGLNVd0hxZX4IR
 vusmG6CS5IpXlqnGvpuQgjycNUCCSQ8NpZ0/SmGJi0ZjMgIwGCu6F1mW/zwi52WmlRISnCGZSA4
 QLPM=
X-Google-Smtp-Source: AGHT+IFUlS0MOVG4Sqkk4TKuA62TyLTKSoQfrwD0O6Rub/P0Id4SqqY0ldcxkc9GWhZ5zc+SHVCTzA==
X-Received: by 2002:a17:903:2444:b0:1f9:b698:3221 with SMTP id
 d9443c01a7336-1faac2ba21amr3421045ad.21.1719445086682; 
 Wed, 26 Jun 2024 16:38:06 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1faac8df624sm563055ad.29.2024.06.26.16.38.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 16:38:05 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 3/7] plugins: extend API to get latest memory value accessed
Date: Wed, 26 Jun 2024 16:37:53 -0700
Message-Id: <20240626233757.375083-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240626233757.375083-1-pierrick.bouvier@linaro.org>
References: <20240626233757.375083-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

Two functions are added to plugins API:
- qemu_plugin_mem_get_value_upper_bits
- qemu_plugin_mem_get_value_lower_bits

This value can be accessed only during a memory callback.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/qemu-plugin.h   | 20 ++++++++++++++++++++
 plugins/api.c                | 21 +++++++++++++++++++++
 plugins/qemu-plugins.symbols |  2 ++
 3 files changed, 43 insertions(+)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index c71c705b699..5945f256949 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -551,6 +551,26 @@ bool qemu_plugin_mem_is_big_endian(qemu_plugin_meminfo_t info);
 QEMU_PLUGIN_API
 bool qemu_plugin_mem_is_store(qemu_plugin_meminfo_t info);
 
+/**
+ * qemu_plugin_mem_get_value_lower_bits() - return 64 lower bits of latest
+ * accessed memory value
+ * @info: opaque memory transaction handle
+ *
+ * Returns: lower bits for value accessed
+ */
+QEMU_PLUGIN_API
+uint64_t qemu_plugin_mem_get_value_lower_bits(qemu_plugin_meminfo_t info);
+
+/**
+ * qemu_plugin_mem_get_value_upper_bits() - return 64 upper bits of latest
+ * accessed memory value
+ * @info: opaque memory transaction handle
+ *
+ * Returns: upper bits for value accessed
+ */
+QEMU_PLUGIN_API
+uint64_t qemu_plugin_mem_get_value_upper_bits(qemu_plugin_meminfo_t info);
+
 /**
  * qemu_plugin_get_hwaddr() - return handle for memory operation
  * @info: opaque memory info structure
diff --git a/plugins/api.c b/plugins/api.c
index 2ff13d09de6..89e9f6ba5b4 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -351,6 +351,27 @@ bool qemu_plugin_mem_is_store(qemu_plugin_meminfo_t info)
     return get_plugin_meminfo_rw(info) & QEMU_PLUGIN_MEM_W;
 }
 
+uint64_t qemu_plugin_mem_get_value_upper_bits(qemu_plugin_meminfo_t info)
+{
+    return current_cpu->plugin_state->mem_value_upper_bits;
+}
+
+uint64_t qemu_plugin_mem_get_value_lower_bits(qemu_plugin_meminfo_t info)
+{
+    uint64_t value = current_cpu->plugin_state->mem_value_lower_bits;
+    /* tcg values are sign extended, so we must clip them */
+    switch (qemu_plugin_mem_size_shift(info)) {
+    case 0:
+        return value & 0xff;
+    case 1:
+        return value & 0xffff;
+    case 2:
+        return value & 0xffffffff;
+    default:
+        return value;
+    }
+}
+
 /*
  * Virtual Memory queries
  */
diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
index ca773d8d9fe..9f2646fc812 100644
--- a/plugins/qemu-plugins.symbols
+++ b/plugins/qemu-plugins.symbols
@@ -13,6 +13,8 @@
   qemu_plugin_insn_size;
   qemu_plugin_insn_symbol;
   qemu_plugin_insn_vaddr;
+  qemu_plugin_mem_get_value_upper_bits;
+  qemu_plugin_mem_get_value_lower_bits;
   qemu_plugin_mem_is_big_endian;
   qemu_plugin_mem_is_sign_extended;
   qemu_plugin_mem_is_store;
-- 
2.39.2


