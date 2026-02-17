Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B781E909CF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 16:18:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsNkR-00040W-V2; Tue, 17 Feb 2026 11:16:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vsNkP-0003sh-Qv
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:16:25 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vsNkO-0003GC-1f
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:16:25 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5CECF5BCEB;
 Tue, 17 Feb 2026 16:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771344937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FLDyIb6P4oWZvT3IGYsRCxpf2OohFweZuBrP+JjpjyI=;
 b=UVz+TZeLL4ZVi4RC5nk++0E82q1x5aaek+Tk/8ICO4wU7madJoTJnWEPgaeDP7cCweHdoZ
 RTJL9Cz5e1JhP/dt+4yhosY4BHx7PyELPgn9xF9fwBGUAGfT5Gw7gzTuBZkLQrnBmID4Fy
 RjH196TWo5BYCPtYOIXnDnLpGz6Jd6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771344937;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FLDyIb6P4oWZvT3IGYsRCxpf2OohFweZuBrP+JjpjyI=;
 b=9l5f7b1xJtGXIXe+JUgHa4NzbsnrldC1pNNB1qpeUeZ6Z9F4pK2gSoubUGbuZ+ZyGu6Mgk
 kZbtWX39QQusVDDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UVz+TZeL;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9l5f7b1x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771344937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FLDyIb6P4oWZvT3IGYsRCxpf2OohFweZuBrP+JjpjyI=;
 b=UVz+TZeLL4ZVi4RC5nk++0E82q1x5aaek+Tk/8ICO4wU7madJoTJnWEPgaeDP7cCweHdoZ
 RTJL9Cz5e1JhP/dt+4yhosY4BHx7PyELPgn9xF9fwBGUAGfT5Gw7gzTuBZkLQrnBmID4Fy
 RjH196TWo5BYCPtYOIXnDnLpGz6Jd6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771344937;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FLDyIb6P4oWZvT3IGYsRCxpf2OohFweZuBrP+JjpjyI=;
 b=9l5f7b1xJtGXIXe+JUgHa4NzbsnrldC1pNNB1qpeUeZ6Z9F4pK2gSoubUGbuZ+ZyGu6Mgk
 kZbtWX39QQusVDDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A3A6E3EA66;
 Tue, 17 Feb 2026 16:15:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mML0GSeUlGmHTgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Feb 2026 16:15:35 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
 Paul Durrant <paul@xen.org>, Lukas Straub <lukasstraub2@web.de>
Subject: [PULL 29/32] migration: Simplify qemu_save_device_state()
Date: Tue, 17 Feb 2026 13:14:40 -0300
Message-ID: <20260217161443.12738-30-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260217161443.12738-1-farosas@suse.de>
References: <20260217161443.12738-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 URIBL_BLOCKED(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,infradead.org:email];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,suse.de:email,infradead.org:email];
 FROM_EQ_ENVFROM(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 FREEMAIL_CC(0.00)[redhat.com,infradead.org,xen.org,web.de];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FREEMAIL_ENVRCPT(0.00)[web.de]
X-Rspamd-Queue-Id: 5CECF5BCEB
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

From: Peter Xu <peterx@redhat.com>

This function is used by both COLO and Xen.  Simplify it with two changes:

- Remove checks on qemu_savevm_se_iterable(): this is not needed as
  vmstate_save() also checks for "save_state() || vmsd" instead.  Here,
  save_setup() (or say, iterable states) should be mutual exclusive to
  "save_state() || vmsd" [*].

- Remove migrate_error_propagate(): both of the users are not using live
  migration framework, but raw vmstate operations.  Error propagation is
  only needed for query-migrate persistence.

[*] One tricky user is VFIO, who provided _both_ save_state() and
save_setup().  However VFIO mustn't have been used in these paths or it
means both COLO and Xen have ignored VFIO data instead (that is,
qemu_savevm_se_iterable() will return true for VFIO). Hence, this change is
safe.

Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Paul Durrant <paul@xen.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Tested-by: Lukas Straub <lukasstraub2@web.de>
Link: https://lore.kernel.org/qemu-devel/20260127185254.3954634-24-peterx@redhat.com
[commit msg: s/not needed for/only needed for]
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/savevm.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 130b9764a7..b29272db3b 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1897,13 +1897,8 @@ int qemu_save_device_state(QEMUFile *f)
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
         int ret;
 
-        if (qemu_savevm_se_iterable(se)) {
-            continue;
-        }
         ret = vmstate_save(f, se, NULL, &local_err);
         if (ret) {
-            migrate_error_propagate(migrate_get_current(),
-                                    error_copy(local_err));
             error_report_err(local_err);
             return ret;
         }
-- 
2.51.0


