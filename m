Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61493C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 14:52:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reynU-0006lH-Mk; Tue, 27 Feb 2024 09:51:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1reynQ-0006VY-AH
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:51:05 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1reynN-0004V9-SY
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:51:03 -0500
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AF0A422750;
 Tue, 27 Feb 2024 14:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1709045460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=77JXEA8PRL4Zm524FuPoSA0RD4eVoHv1RO/KS7dFFNQ=;
 b=gNovJ/WdLknIROABdAf0+7GznFMdAKqA2HfHrNkhWAfyqakU6oIwAbj0Rt8UyKQ+6rtZoz
 DK1MT2ejLg6qxGt7nOnp7YgVXQpuPUZ73Q1jIOQA2ybmIGEoq0iUEVwTdDGSp+qM9OxuTD
 GZNYpknum3u8E+BilkN4O/ZqhafFp4A=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1709045460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=77JXEA8PRL4Zm524FuPoSA0RD4eVoHv1RO/KS7dFFNQ=;
 b=gNovJ/WdLknIROABdAf0+7GznFMdAKqA2HfHrNkhWAfyqakU6oIwAbj0Rt8UyKQ+6rtZoz
 DK1MT2ejLg6qxGt7nOnp7YgVXQpuPUZ73Q1jIOQA2ybmIGEoq0iUEVwTdDGSp+qM9OxuTD
 GZNYpknum3u8E+BilkN4O/ZqhafFp4A=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id EA5FB13419;
 Tue, 27 Feb 2024 14:50:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap2.dmz-prg2.suse.org with ESMTPSA id oGbgNtP23WXMAQAAn2gu4w
 (envelope-from <roy.hopkins@suse.com>); Tue, 27 Feb 2024 14:50:59 +0000
From: Roy Hopkins <roy.hopkins@suse.com>
To: qemu-devel@nongnu.org
Cc: Roy Hopkins <roy.hopkins@suse.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?J=C3=B6rg=20Roedel?= <jroedel@suse.com>
Subject: [PATCH 6/9] i386/pc: Skip initialization of system FW when using IGVM
Date: Tue, 27 Feb 2024 14:50:12 +0000
Message-ID: <63a4febd571701bb9f2f7511d71fc968ed9205ab.1709044754.git.roy.hopkins@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1709044754.git.roy.hopkins@suse.com>
References: <cover.1709044754.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.com header.s=susede1 header.b="gNovJ/Wd"
X-Spamd-Result: default: False [0.98 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 BROKEN_CONTENT_TYPE(1.50)[];
 R_RATELIMIT(0.00)[to_ip_from(RL1cdfboiju7js16zrknyuzw5d)];
 RCVD_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.com:+];
 MX_GOOD(-0.01)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; BAYES_HAM(-1.71)[93.24%];
 ARC_NA(0.00)[]; R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
 FROM_HAS_DN(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_GOOD(-0.10)[text/plain];
 DWL_DNSWL_HI(-3.50)[suse.com:dkim];
 DKIM_SIGNED(0.00)[suse.com:s=susede1];
 RCPT_COUNT_TWELVE(0.00)[16]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 FREEMAIL_CC(0.00)[suse.com,redhat.com,gmail.com,habkost.net,alistair23.me,amd.com];
 RCVD_TLS_ALL(0.00)[]; SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: AF0A422750
X-Spamd-Bar: /
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=roy.hopkins@suse.com; helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

When using an IGVM file the configuration of the system firmware is
defined by IGVM directives contained in the file. Therefore the default
system firmware should not be initialized when an IGVM file has been
provided.

This commit checks to see if an IGVM file has been provided and, if it
has then the standard system firmware initialization is skipped and any
prepared flash devices are cleaned up.

Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
---
 hw/i386/pc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f8eb684a49..17bb211708 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -63,6 +63,7 @@
 #include "e820_memory_layout.h"
 #include "trace.h"
 #include CONFIG_DEVICES
+#include "exec/confidential-guest-support.h"
 
 #ifdef CONFIG_XEN_EMU
 #include "hw/xen/xen-legacy-backend.h"
@@ -1023,8 +1024,15 @@ void pc_memory_init(PCMachineState *pcms,
         }
     }
 
-    /* Initialize PC system firmware */
-    pc_system_firmware_init(pcms, rom_memory);
+    /*
+     * If this is a confidential guest configured using IGVM then the IGVM
+     * configuration will include the system firmware. In this case do not
+     * initialise PC system firmware.
+     */
+    if (!cgs_is_igvm(machine->cgs)) {
+        /* Initialize PC system firmware */
+        pc_system_firmware_init(pcms, rom_memory);
+    }
 
     option_rom_mr = g_malloc(sizeof(*option_rom_mr));
     memory_region_init_ram(option_rom_mr, NULL, "pc.rom", PC_ROM_SIZE,
-- 
2.43.0


