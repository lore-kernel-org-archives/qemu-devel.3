Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA54BC4829C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 18:21:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXmXM-0004l5-6A; Wed, 07 Feb 2024 13:20:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rXmXI-0004ic-1N
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 13:20:40 -0500
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rXmXG-00087d-90
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 13:20:39 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 7713FCE1AD0;
 Wed,  7 Feb 2024 18:20:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54F8C433F1;
 Wed,  7 Feb 2024 18:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707330034;
 bh=FaxA3mFrSxmY5kTESFNBYrTItNp7faYaL5jQs64YYHE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Rmu/KzsaU6UABUhm+KVn4mv8gcHJLeW6qMC7lknsg7yfFJNSLciicdRKIs3Ou9Sps
 Tjn1EJUqze7h/emedNv8qIRq8hMb45Y889I5kQhgOq4qOSON2P+biItAnfFhjI1RiR
 RcyZHRZ2ZEsB8c06jjYUOrmuIa/9DYA8OPXVP/5Jzqn9Ys2fmeal1fYAGmLkxB7Tb8
 OHrI/rlj5UJWxyjbXbYzJWiK0BZNnEOFAO3ScA5kstrPH4jgJuYKdF5TINlH2TgIiN
 NEdYxsdRh+kHrpbXD86XoqaFeMwiiQTZejtJGz5wr2WVy68y9IfQ8Xf8kafZ/Nsftt
 InunyqljsWgwQ==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH 06/13] lasi: allow access to LAN MAC address registers
Date: Wed,  7 Feb 2024 19:20:16 +0100
Message-ID: <20240207182023.36316-7-deller@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207182023.36316-1-deller@kernel.org>
References: <20240207182023.36316-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.40.73.55; envelope-from=deller@kernel.org;
 helo=sin.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

Firmware and qemu reads and writes the MAC address for the LASI LAN via
registers in LASI. Allow those accesses and return zero even if LASI
LAN isn't enabled to avoid HPMCs (=crashes).

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/misc/lasi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/misc/lasi.c b/hw/misc/lasi.c
index 003f5b5ed8..9cfa5bb316 100644
--- a/hw/misc/lasi.c
+++ b/hw/misc/lasi.c
@@ -38,6 +38,7 @@ static bool lasi_chip_mem_valid(void *opaque, hwaddr addr,
     case LASI_LPT:
     case LASI_UART:
     case LASI_LAN:
+    case LASI_LAN + 12: /* LASI LAN MAC */
     case LASI_RTC:
 
     case LASI_PCR ... LASI_AMR:
@@ -78,6 +79,7 @@ static MemTxResult lasi_chip_read_with_attrs(void *opaque, hwaddr addr,
     case LASI_LPT:
     case LASI_UART:
     case LASI_LAN:
+    case LASI_LAN + 12:
         val = 0;
         break;
     case LASI_RTC:
-- 
2.43.0


