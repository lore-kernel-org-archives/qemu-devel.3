Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3884C83F10
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 20:58:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZbrI-000636-1L; Wed, 09 Jul 2025 16:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1uZbrA-00061W-OA
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 16:57:32 -0400
Received: from todd.t-8ch.de ([2a01:4f8:c010:41de::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1uZbr8-0003TO-ID
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 16:57:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
 t=1752094644; bh=KbAx5NAsj30tozBCjpDql1DDg2iJELLWicogCToWbNg=;
 h=From:Date:Subject:To:Cc:From;
 b=h8vo30/GZ05qjlsE26UO/fYzAcwhkJLfXUUP0vX3KhEYcbgLgFpCm2GzXXd0ZcXtu
 hycMKzcaHRZDRDzHbDmbG5KShxVddrYKmQYAEPMRoJ6dI/yMhee4kCpDypYg2Zty6n
 B1nMXRyrv6aq4qC3sGxRO7iHiv5iDBykUpHQaFWQ=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Date: Wed, 09 Jul 2025 22:57:16 +0200
Subject: [PATCH] linux-user/mips/o32: Drop sa_restorer functionality
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250709-mips-sa-restorer-v1-1-fc17120e4afe@t-8ch.de>
X-B4-Tracking: v=1; b=H4sIAKvXbmgC/x3MTQ5AQAxA4atI15rMDxGuIhYzFF0w0opIxN1NL
 L/Few8oCZNCVzwgdLFy2jNsWcC4hn0h5CkbnHG1aUyLGx+KGlBIzyQkWLm28tMcovURcnYIzXz
 /y3543w87XIW9YgAAAA==
X-Change-ID: 20250709-mips-sa-restorer-42943dfab13b
To: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Benjamin Berg <benjamin.berg@intel.com>, Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752094644; l=1856;
 i=thomas@t-8ch.de; s=20221212; h=from:subject:message-id;
 bh=KbAx5NAsj30tozBCjpDql1DDg2iJELLWicogCToWbNg=;
 b=PaMdMxZt6/gpLCd2Lq9DSpasmPw/qbOnaIOu4V496AN/E5a7ENenjpguLM7iRyzBzuXyLklxA
 tw/7zf6wtRwBL5AQ79idV6bnOFuPJJ+1qp7SVIU9RDWCsoHOUvKAyGZ
X-Developer-Key: i=thomas@t-8ch.de; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
Received-SPF: pass client-ip=2a01:4f8:c010:41de::1;
 envelope-from=thomas@t-8ch.de; helo=todd.t-8ch.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The Linux kernel dropped support for sa_restorer on O32 MIPS in the
release 2.5.48 because it was unused. See the comment in
arch/mips/include/uapi/asm/signal.h.

Applications using the kernels UAPI headers will not reserve enough
space for qemu-user to copy the sigaction.sa_restorer field to.
Unrelated data may be overwritten.

Align qemu-user with the kernel by also dropping sa_restorer support.

Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
---
 linux-user/mips/target_signal.h | 1 -
 linux-user/syscall_defs.h       | 4 ----
 2 files changed, 5 deletions(-)

diff --git a/linux-user/mips/target_signal.h b/linux-user/mips/target_signal.h
index fa542c1f4e2eff4efb79989fb8edb2bf44310b60..4481426b99f084a703ea29a965a9af70f1feca98 100644
--- a/linux-user/mips/target_signal.h
+++ b/linux-user/mips/target_signal.h
@@ -64,7 +64,6 @@ typedef struct target_sigaltstack {
 #define TARGET_SA_NODEFER       0x40000000
 #define TARGET_SA_RESTART       0x10000000
 #define TARGET_SA_RESETHAND     0x80000000
-#define TARGET_SA_RESTORER      0x04000000      /* Only for O32 */
 
 #define TARGET_MINSIGSTKSZ    2048
 
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 5d22759992423ada408e51d4c08f3faee7a7f2d9..df26a2d28f2556dae5466c029ec8f630186a73bd 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -515,10 +515,6 @@ struct target_sigaction {
     abi_ulong       _sa_handler;
 #endif
     target_sigset_t sa_mask;
-#ifdef TARGET_ARCH_HAS_SA_RESTORER
-    /* ??? This is always present, but ignored unless O32.  */
-    abi_ulong sa_restorer;
-#endif
 };
 #else
 struct target_old_sigaction {

---
base-commit: df6fe2abf2e990f767ce755d426bc439c7bba336
change-id: 20250709-mips-sa-restorer-42943dfab13b

Best regards,
-- 
Thomas Weißschuh <thomas@t-8ch.de>


