Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2129CC47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 22:21:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTUYR-0006WA-KR; Fri, 26 Jan 2024 17:20:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rTUYN-0006Vi-P8
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 17:20:03 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rTUYJ-000261-Jt
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 17:20:02 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 739881F896;
 Fri, 26 Jan 2024 22:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706307598; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t5nrPbb2/swQSB4PAyteV7ZgNtEp4AHh1oKRX7TQMsU=;
 b=xKnF4INU1R/dRvN7Kbr9/ZsOSH67khkrytoqAjw2nQhkOTDPKNuIzJZDxTjUDxpnoXIv8M
 YxQ02LzfFPyjpXkKlR6b5WNt78xfAUK4WhYA6wVnkaIddvhf4WTp3WGMAW+tuZT13hLE/E
 dYg2amfOR/NbKq4KRMB+QLZpVjrFnwk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706307598;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t5nrPbb2/swQSB4PAyteV7ZgNtEp4AHh1oKRX7TQMsU=;
 b=6pr+MJ1TYTOMD+sEURzjkg2xqB8grF8yZOC4VK704bPMz9zCs3zzSC00D8l4Rt9ozeVt8G
 fgGow9HOtoRIFYAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706307598; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t5nrPbb2/swQSB4PAyteV7ZgNtEp4AHh1oKRX7TQMsU=;
 b=xKnF4INU1R/dRvN7Kbr9/ZsOSH67khkrytoqAjw2nQhkOTDPKNuIzJZDxTjUDxpnoXIv8M
 YxQ02LzfFPyjpXkKlR6b5WNt78xfAUK4WhYA6wVnkaIddvhf4WTp3WGMAW+tuZT13hLE/E
 dYg2amfOR/NbKq4KRMB+QLZpVjrFnwk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706307598;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t5nrPbb2/swQSB4PAyteV7ZgNtEp4AHh1oKRX7TQMsU=;
 b=6pr+MJ1TYTOMD+sEURzjkg2xqB8grF8yZOC4VK704bPMz9zCs3zzSC00D8l4Rt9ozeVt8G
 fgGow9HOtoRIFYAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CFBA613A22;
 Fri, 26 Jan 2024 22:19:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uB9sJQwwtGWScwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 26 Jan 2024 22:19:56 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Hao Xiang <hao.xiang@bytedance.com>,
 Yuan Liu <yuan1.liu@intel.com>, Bryan Zhang <bryan.zhang@bytedance.com>
Subject: [PATCH 5/5] migration/multifd: Move zero copy flag into
 multifd_socket_setup
Date: Fri, 26 Jan 2024 19:19:43 -0300
Message-Id: <20240126221943.26628-6-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240126221943.26628-1-farosas@suse.de>
References: <20240126221943.26628-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [3.70 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_FIVE(0.00)[5];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.00)[17.80%]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

The generic multifd save setup code should not be responsible for
deciding how the client code is going to send the data. Since the zero
copy feature is supported only by the socket migration, move the
setting of the flag into the socket specific function.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.c | 7 +------
 migration/socket.c  | 4 ++++
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 358a4dbf8f..16d02a4aac 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -817,12 +817,7 @@ int multifd_save_setup(Error **errp)
         p->normal = g_new0(ram_addr_t, page_count);
         p->page_size = qemu_target_page_size();
         p->page_count = page_count;
-
-        if (migrate_zero_copy_send()) {
-            p->write_flags = QIO_CHANNEL_WRITE_FLAG_ZERO_COPY;
-        } else {
-            p->write_flags = 0;
-        }
+        p->write_flags = 0;
 
         multifd_new_send_channel_create(p);
     }
diff --git a/migration/socket.c b/migration/socket.c
index af22ff7cc4..e9d0a5235c 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -206,6 +206,10 @@ void socket_start_incoming_migration(SocketAddress *saddr,
 
 static int multifd_socket_send_setup(MultiFDSendParams *p, Error **errp)
 {
+    if (migrate_zero_copy_send()) {
+        p->write_flags |= QIO_CHANNEL_WRITE_FLAG_ZERO_COPY;
+    }
+
     return 0;
 }
 
-- 
2.35.3


