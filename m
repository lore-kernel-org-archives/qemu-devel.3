Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC261FDEE3F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 19:25:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFzdN-0006gQ-3K; Thu, 23 Apr 2026 15:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzdK-0006Om-5M
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:22:42 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzdI-0002Vw-4h
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:22:41 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 182176A8A0;
 Thu, 23 Apr 2026 19:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/FKBYTvXSGjAZfvLVAh1z1tx4IgLgeuK7f7Tnrh6f+4=;
 b=pcUfbC2a+AG2sgMrsWDueQc4p513eGgT8sZPE1139usEC/F/BzhC/YRMKlXS94xbY9Dc6z
 T1GGBLSVfKUpYj0+v7wvKrsSTbA52BAuRejeD+jFWGS0i29/VeS7WNkIVn+sZ1jOpSegRD
 LU2efdJ/AWS3GCeRjX56L8+EOHQjdAk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972060;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/FKBYTvXSGjAZfvLVAh1z1tx4IgLgeuK7f7Tnrh6f+4=;
 b=3jwYFQsDTiJa9Bk0MGRYLr8wAKu+lie4+KdfvRtE8mZCKVw8dLT8xINbp29Y5ECnoKAUwN
 yFrJ8PR0kJXGUlDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/FKBYTvXSGjAZfvLVAh1z1tx4IgLgeuK7f7Tnrh6f+4=;
 b=pcUfbC2a+AG2sgMrsWDueQc4p513eGgT8sZPE1139usEC/F/BzhC/YRMKlXS94xbY9Dc6z
 T1GGBLSVfKUpYj0+v7wvKrsSTbA52BAuRejeD+jFWGS0i29/VeS7WNkIVn+sZ1jOpSegRD
 LU2efdJ/AWS3GCeRjX56L8+EOHQjdAk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972060;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/FKBYTvXSGjAZfvLVAh1z1tx4IgLgeuK7f7Tnrh6f+4=;
 b=3jwYFQsDTiJa9Bk0MGRYLr8wAKu+lie4+KdfvRtE8mZCKVw8dLT8xINbp29Y5ECnoKAUwN
 yFrJ8PR0kJXGUlDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CEDC7593A3;
 Thu, 23 Apr 2026 19:20:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iDU6Jhpx6mlJCwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 23 Apr 2026 19:20:58 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Junjie Cao <junjie.cao@intel.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 38/43] migration/file: fix type mismatch and NULL deref in
 multifd_file_recv_data
Date: Thu, 23 Apr 2026 16:19:52 -0300
Message-ID: <20260423191958.1440-39-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260423191958.1440-1-farosas@suse.de>
References: <20260423191958.1440-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:mid,
 suse.de:email, intel.com:email]
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

multifd_file_recv_data() stores the return value of qio_channel_pread()
(ssize_t) in a size_t variable.  On I/O error the -1 return value wraps
to SIZE_MAX, producing a nonsensical read size in the error message.

More critically, a short read (0 <= ret < data->size) is possible when
the migration file is truncated.  In that case qio_channel_pread()
returns a non-negative value without setting *errp.  The function then
calls error_prepend(errp, ...) which dereferences *errp -- a NULL
pointer -- crashing QEMU.

Fix both issues by switching to qio_channel_pread_all() introduced in
a previous patch, which retries on short reads and treats end-of-file
as an error, so the caller no longer needs to check the byte count
manually.  Add ERRP_GUARD() so that error_prepend() works correctly
even when errp is &error_fatal or NULL.

Fixes: a49d15a38d3d ("migration/multifd: Support incoming mapped-ram stream format")
Suggested-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/qemu-devel/20260413214549.926435-4-junjie.cao@intel.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/file.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/migration/file.c b/migration/file.c
index 962b4b3a1b..4e2524e548 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -256,15 +256,16 @@ int file_write_ramblock_iov(QIOChannel *ioc, const struct iovec *iov,
 
 int multifd_file_recv_data(MultiFDRecvParams *p, Error **errp)
 {
+    ERRP_GUARD();
     MultiFDRecvData *data = p->data;
-    size_t ret;
+    int ret;
 
-    ret = qio_channel_pread(p->c, (char *) data->opaque,
-                            data->size, data->file_offset, errp);
-    if (ret != data->size) {
+    ret = qio_channel_pread_all(p->c, (char *) data->opaque,
+                                data->size, data->file_offset, errp);
+    if (ret != 0) {
         error_prepend(errp,
-                      "multifd recv (%u): read 0x%zx, expected 0x%zx",
-                      p->id, ret, data->size);
+                      "multifd recv (%u): ",
+                      p->id);
         return -1;
     }
 
-- 
2.51.0


