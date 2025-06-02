Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E787C5B549
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 06:06:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLyFL-0004no-UD; Mon, 02 Jun 2025 02:02:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uLy3H-0001fB-IL
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 01:49:41 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uLy3D-0007Ka-0t
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 01:49:37 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-231e98e46c0so36299455ad.3
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 22:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748843366; x=1749448166; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Io8QAlH/AZbTYfjODl1SD6d4ZkI/a0qoPWASwOSekic=;
 b=NRHnYk4Lt163zE8LAUnbrVszx+c6XcZQGMTP0Hy+eVFsg90DnBp1U/cdWIurbD48nb
 teMOjONci8r0rF7DfpdV+SPeswPhGlYpdfXIJbc9UF11uuI2miagPjYaF6YmQCFna5tq
 Jtg9Rx8QKqxmhSuUiM/LiBZBWTMHVQhxNq8YSlqfg7w45juw7L2SimUBB3WyMffukH4v
 ddUD0N0b0S0Vp/wD2vryfEoJruo+brU8v6TBqElxlQ2qX//7PFHy4T/Gj3PBzRsQgd6j
 EXj/yOPE95z2tsKTafrNOUoKtDoMvYxOmKuNIktmXg8JPyotAPwNm+QGNS7lmTSMLhDi
 DFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748843366; x=1749448166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Io8QAlH/AZbTYfjODl1SD6d4ZkI/a0qoPWASwOSekic=;
 b=Gvkyhw4dHj1CS3Vfx9U/920f3ti77DvOVpAH2Ex3At0o/TM1EO/EpOfqGveis7CKEv
 LLHJvKpbIbCXfR6g+eAO3EOPyG+0hC3isMnf5RT9itWlzcMEQf0TSu3LLeJeKS3fqHNm
 AMcUX/CekyG2EvMktFdR4S4vQHWVFbrD/3qD4VnTIxm8ezVGh5rjd91u3WDWl6Ij0MDC
 ++wN+rzTkQX1+vzqXkgKcvOsz1XanT3jqBynFSr+QXrY6oZ0yam806+CnlHIVibSRiuW
 0qLGFsUhhGLeFem9cnqbJZbEomgnjNKM0x3WYg5yXMExu/h4sb9ZVLQhFRCk2eUYLsyJ
 oZ7Q==
X-Gm-Message-State: AOJu0YwPtkNka9Jj1fLAkhYxz3zU/UTJ0LCrtmmo7yfP8oTfw8RqCozt
 sL/syluxXQKlF8lCuu6VsavAO/fFEbzGXscKErGrLRwB4fJBorSQSMA4gj3HJtsBSHc=
X-Gm-Gg: ASbGncvxS7c5yqniRio9H0H/VP1ryj3HeNVBbAa3RbXr4fdU8AtfI8XWhQ3tB+5LRv6
 JCSZ1sk/ExVDFdTLk7+7WjuR8Lv0vlwLlrGECKADByDST02yQ0ukJQmV33PxMiMExj4ydhqy8w7
 B12fPBrQLl8gBIDQ4BheULM94A+0ML7klkNcLpb3jLavz1I4DTd0oa/VAz+IjUvX9/vZOu2XXqL
 F3rxncLpEv0didB+4a3e/DVpdYyqN3EtzvF39Y6o1vsK63dbHIQTzNXLgCsPJ+JWxD/r7HXaynN
 XXzpVRbMxbLXI1N55EhfPDReXcfmwwvXlSbD2Ekc9Gh9D+VvcPU9IdAK1L/uLw==
X-Google-Smtp-Source: AGHT+IEmRuQaBFFOP4kP57ym3fMwtHgFuDBwhkA4BrsRkKtg3LH39pRVroXF9ujJv/z+O/4oxgBv4Q==
X-Received: by 2002:a17:902:f550:b0:220:cb1a:da5 with SMTP id
 d9443c01a7336-2355f781da2mr105162295ad.40.1748843365773; 
 Sun, 01 Jun 2025 22:49:25 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23506bdce12sm63464085ad.99.2025.06.01.22.49.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 22:49:25 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 novafacing <rowanbhart@gmail.com>
Subject: [PATCH v5 9/9] plugins: Update plugin version and add notes
Date: Sun,  1 Jun 2025 22:49:16 -0700
Message-ID: <20250602054917.302638-10-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602054917.302638-1-rowanbhart@gmail.com>
References: <20250602054917.302638-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=rowanbhart@gmail.com; helo=mail-pl1-x62b.google.com
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

This patch updates the plugin version to gate new APIs and adds notes
describing what has been added.

Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
---
 include/qemu/qemu-plugin.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 2cb5de9f64..170a79e667 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -65,11 +65,18 @@ typedef uint64_t qemu_plugin_id_t;
  *
  * version 4:
  * - added qemu_plugin_read_memory_vaddr
+ *
+ * version 5:
+ * - added qemu_plugin_write_memory_vaddr
+ * - added qemu_plugin_read_memory_hwaddr
+ * - added qemu_plugin_write_memory_hwaddr
+ * - added qemu_plugin_write_register
+ * - added qemu_plugin_translate_vaddr
  */
 
 extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;
 
-#define QEMU_PLUGIN_VERSION 4
+#define QEMU_PLUGIN_VERSION 5
 
 /**
  * struct qemu_info_t - system information for plugins
-- 
2.49.0


