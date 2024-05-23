Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A217C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 19:07:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sADlc-0002B5-AC; Thu, 23 May 2024 15:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sADla-0002AW-Sh
 for qemu-devel@nongnu.org; Thu, 23 May 2024 15:06:18 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sADlZ-0004Iv-8j
 for qemu-devel@nongnu.org; Thu, 23 May 2024 15:06:18 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C7F0F22B73;
 Thu, 23 May 2024 19:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716491175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wtQ1u0erj1/fAKsKQRglQTtk58OkABCFdk6wbusgBdY=;
 b=LvKxKJDcM1CXVrIT0jemfZAdJLBS4Dmj3OxGMVTwY00gOxH3/lTJW2RZdXDBm/mRgvKldo
 X3zP/c2oPhbuwVivK2gdIW7KQa9HTAxqf5QKOW8ZrvPUfNFnUCf5N5cqSbMRZ4bfJtFh+Y
 s7sMpi0bofuNqt0TzjU17ugdTrWYP8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716491175;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wtQ1u0erj1/fAKsKQRglQTtk58OkABCFdk6wbusgBdY=;
 b=OpciNtucqAEkiIkRZpT1ZqtgSXOOi/DW810VHyytVoHu9kSui3a6gxzQS1A+ROJTWxfHoU
 6AGJvTg/L5bDY7Aw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LvKxKJDc;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=OpciNtuc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716491175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wtQ1u0erj1/fAKsKQRglQTtk58OkABCFdk6wbusgBdY=;
 b=LvKxKJDcM1CXVrIT0jemfZAdJLBS4Dmj3OxGMVTwY00gOxH3/lTJW2RZdXDBm/mRgvKldo
 X3zP/c2oPhbuwVivK2gdIW7KQa9HTAxqf5QKOW8ZrvPUfNFnUCf5N5cqSbMRZ4bfJtFh+Y
 s7sMpi0bofuNqt0TzjU17ugdTrWYP8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716491175;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wtQ1u0erj1/fAKsKQRglQTtk58OkABCFdk6wbusgBdY=;
 b=OpciNtucqAEkiIkRZpT1ZqtgSXOOi/DW810VHyytVoHu9kSui3a6gxzQS1A+ROJTWxfHoU
 6AGJvTg/L5bDY7Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF64313A6B;
 Thu, 23 May 2024 19:06:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mEoTLaWTT2bUEQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 23 May 2024 19:06:13 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>
Subject: [PATCH v2 09/18] io: Stop using qemu_open_old in channel-file
Date: Thu, 23 May 2024 16:05:39 -0300
Message-Id: <20240523190548.23977-10-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240523190548.23977-1-farosas@suse.de>
References: <20240523190548.23977-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C7F0F22B73
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

We want to make use of the Error object to report fdset errors from
qemu_open_internal() and passing the error pointer to qemu_open_old()
would require changing all callers. Move the file channel to the new
API instead.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 io/channel-file.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/io/channel-file.c b/io/channel-file.c
index 6436cfb6ae..2ea8d08360 100644
--- a/io/channel-file.c
+++ b/io/channel-file.c
@@ -68,11 +68,13 @@ qio_channel_file_new_path(const char *path,
 
     ioc = QIO_CHANNEL_FILE(object_new(TYPE_QIO_CHANNEL_FILE));
 
-    ioc->fd = qemu_open_old(path, flags, mode);
+    if (flags & O_CREAT) {
+        ioc->fd = qemu_create(path, flags & ~O_CREAT, mode, errp);
+    } else {
+        ioc->fd = qemu_open(path, flags, errp);
+    }
     if (ioc->fd < 0) {
         object_unref(OBJECT(ioc));
-        error_setg_errno(errp, errno,
-                         "Unable to open %s", path);
         return NULL;
     }
 
-- 
2.35.3


