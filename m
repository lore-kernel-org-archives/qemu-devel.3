Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A69FDEE47
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 19:24:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFzdN-0006kJ-KF; Thu, 23 Apr 2026 15:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzcw-0005CZ-Ix
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:22:20 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzct-0002Rz-Ch
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:22:16 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B10605BD92;
 Thu, 23 Apr 2026 19:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M3UDVOPUiWpobauA+2TDTDMQ+HGhvLbgz+74mugUk44=;
 b=XFUu2ywjfRqSIgmNBD8FBYE0YTyZbxhdv+4Y0cm6UJZUSwy/nzhRHj3g0oJIeafW2M/K2V
 sjugS/zEV9fdrnTHWKY41Oe/TCfxQtJMlqnWNuMvBQV9knwulo3RuI3vKhtvjv/IPRj+Da
 PZmdHUuGt2UcLyXpCMBbPHq435uE+kg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972067;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M3UDVOPUiWpobauA+2TDTDMQ+HGhvLbgz+74mugUk44=;
 b=tFJF+hjX4aaxmfYLFjRmwu2CO7wJBQhV7bvLAGBY5g/dzlIhieb+n3MzHrAPXSqcROTB/z
 r53KmAcsin/ThyBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M3UDVOPUiWpobauA+2TDTDMQ+HGhvLbgz+74mugUk44=;
 b=XFUu2ywjfRqSIgmNBD8FBYE0YTyZbxhdv+4Y0cm6UJZUSwy/nzhRHj3g0oJIeafW2M/K2V
 sjugS/zEV9fdrnTHWKY41Oe/TCfxQtJMlqnWNuMvBQV9knwulo3RuI3vKhtvjv/IPRj+Da
 PZmdHUuGt2UcLyXpCMBbPHq435uE+kg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972067;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M3UDVOPUiWpobauA+2TDTDMQ+HGhvLbgz+74mugUk44=;
 b=tFJF+hjX4aaxmfYLFjRmwu2CO7wJBQhV7bvLAGBY5g/dzlIhieb+n3MzHrAPXSqcROTB/z
 r53KmAcsin/ThyBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7375C593A3;
 Thu, 23 Apr 2026 19:21:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aFDxDyJx6mlJCwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 23 Apr 2026 19:21:06 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Junjie Cao <junjie.cao@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 43/43] migration/qemu-file: drop incorrect const from
 qemu_get_buffer_at buf
Date: Thu, 23 Apr 2026 16:19:57 -0300
Message-ID: <20260423191958.1440-44-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260423191958.1440-1-farosas@suse.de>
References: <20260423191958.1440-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email, suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo, intel.com:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

From: Junjie Cao <junjie.cao@intel.com>

qemu_get_buffer_at() reads data *into* buf -- it should not be const.
Drop the qualifier and remove the now-unnecessary cast.

Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260420201317.30199-4-junjie.cao@intel.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/qemu-file.c | 4 ++--
 migration/qemu-file.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 9dfb202203..d5a48115bd 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -550,7 +550,7 @@ void qemu_put_buffer_at(QEMUFile *f, const uint8_t *buf, size_t buflen,
 }
 
 
-size_t qemu_get_buffer_at(QEMUFile *f, const uint8_t *buf, size_t buflen,
+size_t qemu_get_buffer_at(QEMUFile *f, uint8_t *buf, size_t buflen,
                           off_t pos)
 {
     Error *err = NULL;
@@ -559,7 +559,7 @@ size_t qemu_get_buffer_at(QEMUFile *f, const uint8_t *buf, size_t buflen,
         return 0;
     }
 
-    if (qio_channel_pread_all(f->ioc, (char *)buf, buflen, pos, &err) < 0) {
+    if (qio_channel_pread_all(f->ioc, buf, buflen, pos, &err) < 0) {
         qemu_file_set_error_obj(f, -EIO, err);
         return 0;
     }
diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index a390554208..8f824c124d 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -76,7 +76,7 @@ void qemu_set_offset(QEMUFile *f, off_t off, int whence);
 off_t qemu_get_offset(QEMUFile *f);
 void qemu_put_buffer_at(QEMUFile *f, const uint8_t *buf, size_t buflen,
                         off_t pos);
-size_t qemu_get_buffer_at(QEMUFile *f, const uint8_t *buf, size_t buflen,
+size_t qemu_get_buffer_at(QEMUFile *f, uint8_t *buf, size_t buflen,
                           off_t pos);
 
 QIOChannel *qemu_file_get_ioc(QEMUFile *file);
-- 
2.51.0


