Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4056BC02181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 21:35:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZzPY-0005nH-48; Mon, 20 Jan 2025 16:34:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tZzPD-0005iW-Me
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 16:33:59 -0500
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tZzPA-0000vN-IH
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 16:33:57 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 2E942A404DD;
 Mon, 20 Jan 2025 21:32:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F4C6C4CEDD;
 Mon, 20 Jan 2025 21:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1737408827;
 bh=f4X9zMW2UNRK6C5YvFLwtVaulKW3SQq3pLWgREWOxYk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bXwuAVEltR28ZZUPZhkVJKKt9+fmuoqsy8hy22tCQO4MkRQpdwJFw8AgKMAJuiIDC
 7NHnUpDELWMFpZeu/vncE/kYB6JS8Eo8wudNRcsiVtU+W73ddErZukp6Z0fD5yfW4N
 nKXOg4LqII1fB8T4rfhpfSja944Vi0O/EUgiqirfxM7/Jk7EWy2VsUXyLwU8Heqwh6
 2BM6OHjX68VnzEfHawYSDt0jQQR+U4UhO1r/fQAEoTNUHU9nluiEYCcV+GPOFwvIvx
 Sr/blVqN9fgyskHceMnEC+dPCr1cTADMSCGv0psVBeqvMy8wcqI4SZt/vSgzoG91ZK
 zQczDIRwytr8g==
From: deller@kernel.org
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@gmail.com>
Cc: deller@gmx.de
Subject: [PATCH v4 2/7] linux-user: Use unique error messages for cmsg parsing
Date: Mon, 20 Jan 2025 22:33:35 +0100
Message-ID: <20250120213340.359195-3-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250120213340.359195-1-deller@kernel.org>
References: <20250120213340.359195-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=147.75.193.91; envelope-from=deller@kernel.org;
 helo=nyc.source.kernel.org
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Helge Deller <deller@gmx.de>

Avoid using the same error message for two different code paths
as it complicates determining the one which actually triggered.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 78c7c0b34e..a157abc40c 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1827,7 +1827,7 @@ static inline abi_long target_to_host_cmsg(struct msghdr *msgh,
                 *dst = tswap32(*dst);
             }
         } else {
-            qemu_log_mask(LOG_UNIMP, "Unsupported ancillary data: %d/%d\n",
+            qemu_log_mask(LOG_UNIMP, "Unsupported target ancillary data: %d/%d\n",
                           cmsg->cmsg_level, cmsg->cmsg_type);
             memcpy(data, target_data, len);
         }
@@ -2049,7 +2049,7 @@ static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
 
         default:
         unimplemented:
-            qemu_log_mask(LOG_UNIMP, "Unsupported ancillary data: %d/%d\n",
+            qemu_log_mask(LOG_UNIMP, "Unsupported host ancillary data: %d/%d\n",
                           cmsg->cmsg_level, cmsg->cmsg_type);
             memcpy(target_data, data, MIN(len, tgt_len));
             if (tgt_len > len) {
-- 
2.47.0


