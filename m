Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 017F3CCD193
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Oct 2025 07:11:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vA15C-0005gx-2M; Sat, 18 Oct 2025 03:10:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sean.anderson@linux.dev>)
 id 1v9s7E-0000ag-DR
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 17:36:00 -0400
Received: from out-179.mta0.migadu.com ([91.218.175.179])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sean.anderson@linux.dev>)
 id 1v9s7C-0000uQ-B8
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 17:36:00 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1760736943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MNCqKXPKfDxfIU4kqikJ84i8HiPeFd3Ia+9CKZI7f3k=;
 b=SiYUKloxRcJhHFQAUFw83Q6JUB6AeCUHvC/iao+GlIvxfUROhHwCdHhfc/4In2p1nctrFd
 YnRQwn5V50FiNT2maJORNP1e+xg9D/A2ZoCeUA77Y1kY5U8wlh8xeNGqBV0Nkg+ObPIsDM
 KhM6u62IwA/1jSCmFXaNlSx7Sp386wU=
From: Sean Anderson <sean.anderson@linux.dev>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Luc Michel <lmichel@kalray.eu>, Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH 1/3] gdbstub: Fix %s formatting
Date: Fri, 17 Oct 2025 17:35:27 -0400
Message-Id: <20251017213529.998267-2-sean.anderson@linux.dev>
In-Reply-To: <20251017213529.998267-1-sean.anderson@linux.dev>
References: <20251017213529.998267-1-sean.anderson@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=91.218.175.179;
 envelope-from=sean.anderson@linux.dev; helo=out-179.mta0.migadu.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 18 Oct 2025 03:10:26 -0400
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

The format string for %s has two format characters. This causes it to
emit strings like "466f5bd8/6x" instead of "466f5bd8/6". GDB detects
this and returns EIO, causing all open File I/O calls to fail.

Fixes: 0820a075af ("gdbstub: Adjust gdb_do_syscall to only use uint32_t and uint64_t")
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 gdbstub/syscalls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gdbstub/syscalls.c b/gdbstub/syscalls.c
index e855df21ab..d8bb90cc1c 100644
--- a/gdbstub/syscalls.c
+++ b/gdbstub/syscalls.c
@@ -127,7 +127,7 @@ void gdb_do_syscall(gdb_syscall_complete_cb cb, const char *fmt, ...)
             case 's':
                 i64 = va_arg(va, uint64_t);
                 i32 = va_arg(va, uint32_t);
-                p += snprintf(p, p_end - p, "%" PRIx64 "/%x" PRIx32, i64, i32);
+                p += snprintf(p, p_end - p, "%" PRIx64 "/%" PRIx32, i64, i32);
                 break;
             default:
             bad_format:
-- 
2.35.1.1320.gc452695387.dirty


