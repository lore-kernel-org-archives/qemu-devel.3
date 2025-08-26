Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 285A9CA0FE7
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 16:15:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqwHM-00041H-09; Tue, 26 Aug 2025 12:12:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwHJ-0003zU-VH; Tue, 26 Aug 2025 12:12:10 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwHB-0007rh-KS; Tue, 26 Aug 2025 12:12:08 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b475dfb4f42so3986809a12.0; 
 Tue, 26 Aug 2025 09:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756224717; x=1756829517; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sf80EJqAcxGGTIu8UKFlaemvFTuxkqpoIGk43YfIQag=;
 b=HOr8gVkp9UL22W7gtnZRleTq/cTDrGU1wIzmouVXKLH5GNVD6McCuYS5f+RNBEiWeQ
 /wDKvpJnxaBoN3JrQEiFNc91FnyeUVQ3Ka6atSNh5YmfaK0toth50EvSUHjwUvdz/BFW
 hRQpi52rsW6XHGYsKt744k0OwXd1kNPDyAwKhv7TwYlGubFtu0cAveUKy2cjdu/P5JCQ
 Z/XTrCE9kk7kR5iZcKlGspn5CdrABRAtk+1WyUfQHLG6zhAtEbY/60rZCRSiTkMjF61i
 eWcKI+C00MOh0ceEJ4GdvDhD+7umYZx8LJVW5FE/HHba8gXfqzQh45u3ZzAFtE5Z4fkg
 e6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756224717; x=1756829517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sf80EJqAcxGGTIu8UKFlaemvFTuxkqpoIGk43YfIQag=;
 b=pkh8G05b5kFisFZLk9AEw6EP9fWgnvc/TXdMBdvRAfGIGcCI0P8QupfAPvHi6gzY4Z
 x3J5IrxQrEZTV+xE30bns8kqi7jpt3MITraf8iWFTnrbxuo4IBhelh6PeyU1WXPyNflb
 JR3fAV7c5SmaJq/MYDw5nA7ajt7ZiWyM2xj4OSgtVZeB+nIwvu3cOkKOfwut8NBQHRYq
 WpLuWHQHQD2KK1j9BJEicRrk5Yehqd953R7h1dyPIpH13nvdSBQZWRJk91DiKsmcW/qm
 hrtfWsLKeNtUtIxepeHZShKdEVnEMaTwleIPcpzL0sSpd0hkovGabC5GhMNEmvq/hyCd
 hJFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIpjKuqS+aqrXH44oAOXqlQcdb++mL67e853SnyE0U6MZ0Y6RfjnO88TTUpiyHBO5qePNk2SCLwoWYug==@nongnu.org,
 AJvYcCWCS0Iu0py5MkLegceG/O5qXgK/rp64c/lGTRuXyJfhxxfqrSWza+kRtgfwaja+35BO2pzFEdR7qQ==@nongnu.org
X-Gm-Message-State: AOJu0YwwjZfx86XPGPg2Fwtjz3C/0wGyHdXG9/zsAIjCPWUKcX6GLdmq
 QiCdKPWIZrziTYPdhzCW2ZFhDRArK9cxcB/HGntmJ0MfcwFDH6+4ZjDecQ0yeg==
X-Gm-Gg: ASbGncvWtDXaAGYrv9FeMCCaMp1FgQicYRVl6Xphuvn63JBmX6Ga7rGMzcbj/B0EqFk
 kP5YEzpo/tkeFqdnoEnqYozp7RdaGgJUMd/JPa3djvcyLeu+VlApzBlwk3kt70BBmhGqu/16QhK
 RFxebT/folgEExdHCClgoI0uCymJHvIpJ8UeCBXLyF2TZrwgpMXZEpTvN0Mu9L85OkZVoELOQKL
 bbTx5Be7ZTCHfhrH2g6e3MtExZlWPflQMuqEIq3AiufvHUIf53x87srnX1y7raIepNqi7flUn8J
 jD6OyQRV8BeCF2XyiU/HIRBmPd6K8z53XG0xkrVOQk04vjtyYmchewokg1vLISzJo9Ae1ocODPm
 NWfvZj73Owi45mh/omXCD3w==
X-Google-Smtp-Source: AGHT+IHkzb8GNUIJd+6cXFuaYf3HL0e5kdTq5UB5S4A7DqjXLuQ3OwOgUXumcqYlZ9cDQUmHo5UF6w==
X-Received: by 2002:a17:903:4585:b0:248:70b9:c70b with SMTP id
 d9443c01a7336-24870ba1165mr30153685ad.55.1756224716644; 
 Tue, 26 Aug 2025 09:11:56 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:561f:1400:11f5:714b])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32750bc341asm1749747a91.19.2025.08.26.09.11.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 09:11:55 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, ktokunaga.mail@gmail.com
Subject: [PATCH v2 08/35] tcg/wasm: Add relocation callbacks
Date: Wed, 27 Aug 2025 01:10:13 +0900
Message-ID: <5baf88bab53be1c51736b8caad24111d386f3f28.1756216429.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756216429.git.ktokunaga.mail@gmail.com>
References: <cover.1756216429.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x52e.google.com
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

Relocation callbacks are used for the TCI instructions to preserve the
original logic of the TCI backend.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm/tcg-target.c.inc | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tcg/wasm/tcg-target.c.inc b/tcg/wasm/tcg-target.c.inc
index 0b12c4ea03..4bcb594360 100644
--- a/tcg/wasm/tcg-target.c.inc
+++ b/tcg/wasm/tcg-target.c.inc
@@ -88,3 +88,24 @@ static bool tcg_target_const_match(int64_t val, int ct,
 {
     return ct & TCG_CT_CONST;
 }
+
+static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
+{
+    memset(p, 0, sizeof(*p) * count);
+}
+
+static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
+                        intptr_t value, intptr_t addend)
+{
+    intptr_t diff = value - (intptr_t)(code_ptr + 4);
+
+    tcg_debug_assert(addend == 0);
+    tcg_debug_assert(type == 20);
+
+    if (diff == sextract32(diff, 0, type)) {
+        tcg_patch32(code_ptr,
+                    deposit32(*(uint32_t *)code_ptr, 32 - type, type, diff));
+        return true;
+    }
+    return false;
+}
-- 
2.43.0


