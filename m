Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A24CD4A5E8
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 01:47:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgYvJ-0000wj-Lw; Thu, 15 Jan 2026 20:46:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vgYvE-0000tj-Jb
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 20:46:44 -0500
Received: from k57.kb8c70eb.use4.send.mailgun.net ([204.220.184.57])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vgYvC-0000NP-Ts
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 20:46:44 -0500
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 c8fc28ba1c5f09dd064e927860b232e16d225bfb57441d43028ffa272cd9ed93 with SMTP id
 69699879a73c4f5662bb64d6; Fri, 16 Jan 2026 01:46:33 GMT
X-Mailgun-Sending-Ip: 204.220.184.57
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1768527992;
 bh=qDz9Tgb8Mfo5Sgdp3qif/5BgN8SzBhXDPm5V4Lv8Uhs=;
 h=X-Mailgun-Dkim:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:From:Reply-to:
 Subject:Date:Message-id:To:Cc:Mime-version:Content-type:
 Content-transfer-encoding:In-reply-to:References;
 b=ma7x/5VQNMJnqXwoIFLuM2bDBOWHrgPMWiZSexFCmN6Wudggf4KJif/zhN198ioSY
 zxoAGmVxELYOwTvsGAw4sz/PtwGLLYL4BkRT9DB+wImYm/Qgki8rLdvvGCF3JpQbbk
 BvPnXFnJFMqTLcpyMtkro1jioow/Bt3zWwHTH7ZTUWt3iA1ETndV1pXm4fyA/YX9LF
 st40GLAytucILLdnTCcAjyQ650okb4SD8BC1KZrVMuWyhkm21ausJxv9Bqe7dPa/Hs
 C52B07uv4MfQpEHGVtfsCGvdhRgOIXioYfzuGwdEuHDSd16d0UzVw8pNKIkG+AT54g
 oKcXo26Qm3tlw==
X-Mailgun-Dkim: no
X-Mailgun-Dkim: no
From: Yodel Eldar <yodel.eldar@yodel.dev>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Dominik Disconnect3d Czarnota <dominik.b.czarnota@gmail.com>,
 Yodel Eldar <yodel.eldar@yodel.dev>
Subject: [PATCH v3 1/3] include/gdbstub/syscalls: Add EIO and ENOSYS GDB
 File-I/O errno values
Date: Thu, 15 Jan 2026 19:46:10 -0600
Message-ID: <20260116014612.226183-2-yodel.eldar@yodel.dev>
In-Reply-To: <20260116014612.226183-1-yodel.eldar@yodel.dev>
References: <20260116014612.226183-1-yodel.eldar@yodel.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=204.220.184.57;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=k57.kb8c70eb.use4.send.mailgun.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patch adds the EIO and ENOSYS errno values that were missing from
the GDB Manual [1] when the other errno values were defined.

[1] https://sourceware.org/gdb/current/onlinedocs/gdb.html/Errno-Values.html

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
---
 include/gdbstub/syscalls.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/gdbstub/syscalls.h b/include/gdbstub/syscalls.h
index d63228e96b..6200416f77 100644
--- a/include/gdbstub/syscalls.h
+++ b/include/gdbstub/syscalls.h
@@ -22,6 +22,7 @@
 #define GDB_EPERM           1
 #define GDB_ENOENT          2
 #define GDB_EINTR           4
+#define GDB_EIO             5
 #define GDB_EBADF           9
 #define GDB_EACCES         13
 #define GDB_EFAULT         14
@@ -37,6 +38,7 @@
 #define GDB_ENOSPC         28
 #define GDB_ESPIPE         29
 #define GDB_EROFS          30
+#define GDB_ENOSYS         88
 #define GDB_ENAMETOOLONG   91
 #define GDB_EUNKNOWN       9999
 
-- 
2.52.0


