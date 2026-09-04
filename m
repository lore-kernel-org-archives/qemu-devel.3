Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E29C61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 04:32:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2LbF-0001Cm-5V; Fri, 04 Sep 2026 00:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <getshell@seu.edu.cn>)
 id 1x2Kmy-0004TH-35; Thu, 03 Sep 2026 23:40:28 -0400
Received: from mail-m155101.qiye.163.com ([101.71.155.101])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <getshell@seu.edu.cn>)
 id 1x2Kmv-00038f-So; Thu, 03 Sep 2026 23:40:27 -0400
Received: from LAPTOP-99KJFSET (unknown [36.153.54.56])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4c7fb79e5;
 Fri, 4 Sep 2026 11:31:13 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-stable@nongnu.org, Hongyan Xu <getshell@seu.edu.cn>
Subject: [PATCH] dump: reset guest_note_size when the guest note is discarded
Date: Fri,  4 Sep 2026 11:31:12 +0800
Message-ID: <20260904033113.1194-1-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa06a786f8203a1kunm32f5d9e724039
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSB9KVhpMGkNNHR5NTRpJTFYeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlITVVKTkhVTk9VTk1ZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0
 NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
 b=eZSOaVKSC4pKGaD+LJCGUwJqowHlTZyRPIJ2AVK7siXyw9Ncu2Tp8H+N8BevhjNcta5ovA6lPc+ws6tB/zSUV+oc40HLUDHOhnFhstdyVDjZ7Uyb/hVilgzydG/HUtzP6wJ5sXalGuAEqC5LdnT2+crIJwB60NOh1cagshvqEnI=;
 c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1; 
 bh=cEN3FPmkQR+mfyk0Hh7Q/XQ8BfLjMjCvjCsiEnuYpQ0=;
 h=date:mime-version:subject:message-id:from;
Received-SPF: pass client-ip=101.71.155.101; envelope-from=getshell@seu.edu.cn;
 helo=mail-m155101.qiye.163.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 04 Sep 2026 00:32:22 -0400
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

When dump_init() reads the guest VMCOREINFO note and decides the note
header is invalid (oversized name/desc or note_size larger than the
buffer read from the guest), it frees s->guest_note and sets it to NULL
but leaves s->guest_note_size at its previous value.

dump_process() later dispatches on the requested format.  For
DUMP_GUEST_MEMORY_FORMAT_WIN_DMP it calls create_win_dump(), which in
dump/win_dump-x86.c dereferences s->guest_note unconditionally:

    WinDumpHeader *h = (void *)(s->guest_note + VMCOREINFO_ELF_NOTE_HDR_SIZE);

so a NULL s->guest_note results in a NULL-pointer dereference (crash /
host DoS) instead of the intended clean error.

guest_note is only ever non-NULL when guest_note_size was set together
with it, so make the two consistent: whenever the note is freed and
reset to NULL, also reset guest_note_size to 0, and harden
create_win_dump() to reject a missing note before dereferencing it.

Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
---
 dump/dump.c         | 1 +
 dump/win_dump-x86.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/dump/dump.c b/dump/dump.c
index 52be7258a5..a2073cea5d 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -1906,6 +1906,7 @@ static void dump_init(DumpState *s, int fd, bool has_format,
                 warn_report("Invalid guest note header");
                 g_free(s->guest_note);
                 s->guest_note = NULL;
+                s->guest_note_size = 0;
             } else {
                 vmcoreinfo_update_phys_base(s);
                 s->note_size += s->guest_note_size;
diff --git a/dump/win_dump-x86.c b/dump/win_dump-x86.c
index 0dd0c503c5..97c5e3e0da 100644
--- a/dump/win_dump-x86.c
+++ b/dump/win_dump-x86.c
@@ -445,6 +445,11 @@ bool win_dump_available(Error **errp)
 
 void create_win_dump(DumpState *s, Error **errp)
 {
+    if (!s->guest_note) {
+        error_setg(errp, "win-dump: no vmcoreinfo note available");
+        return;
+    }
+
     WinDumpHeader *h = (void *)(s->guest_note + VMCOREINFO_ELF_NOTE_HDR_SIZE);
     X86CPU *first_x86_cpu = X86_CPU(first_cpu);
     uint64_t saved_cr3 = first_x86_cpu->env.cr[3];
-- 
2.50.1.windows.1


