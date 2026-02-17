Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3734E909CF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 16:20:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsNk1-0001n0-5j; Tue, 17 Feb 2026 11:16:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vsNju-0001Um-M8
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:15:55 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vsNjt-0003CH-17
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:15:54 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2F2173E735;
 Tue, 17 Feb 2026 16:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771344917; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BUmJ0IvEJx3XS6jfar8Y6nO2F1CFsMvTWaMOiGZ8Zxs=;
 b=d6pWS94SYunPOkA16pGtKYY0nPlEVTUYUkhBmfw52WVPp+2dBlSFaXb8Zwaslej95Fxfbo
 rNDkuJXzAPBKaLmdgPIO6KqCwCMKHpXMoyFEpzzyIa9new/Rg2iOtBI0+RdUb4wWQfESn3
 2bu/7vChDQWunxvLt1wTIxGgCJB9W5Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771344917;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BUmJ0IvEJx3XS6jfar8Y6nO2F1CFsMvTWaMOiGZ8Zxs=;
 b=pN0pnv2VYZgIfWoj+6ZFFerPuyOjSwqqT/jvHI8Qw1S4TuaciJBhdM6B5ILAumD1Hf9DBF
 vxJgPH4Os+08F8Ag==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=d6pWS94S;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=pN0pnv2V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771344917; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BUmJ0IvEJx3XS6jfar8Y6nO2F1CFsMvTWaMOiGZ8Zxs=;
 b=d6pWS94SYunPOkA16pGtKYY0nPlEVTUYUkhBmfw52WVPp+2dBlSFaXb8Zwaslej95Fxfbo
 rNDkuJXzAPBKaLmdgPIO6KqCwCMKHpXMoyFEpzzyIa9new/Rg2iOtBI0+RdUb4wWQfESn3
 2bu/7vChDQWunxvLt1wTIxGgCJB9W5Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771344917;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BUmJ0IvEJx3XS6jfar8Y6nO2F1CFsMvTWaMOiGZ8Zxs=;
 b=pN0pnv2VYZgIfWoj+6ZFFerPuyOjSwqqT/jvHI8Qw1S4TuaciJBhdM6B5ILAumD1Hf9DBF
 vxJgPH4Os+08F8Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E0AF03EA67;
 Tue, 17 Feb 2026 16:15:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sK7wKBOUlGmHTgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Feb 2026 16:15:15 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Lukas Straub <lukasstraub2@web.de>
Subject: [PULL 17/32] migration: Drop qemu_file_set_error() when save
 non-iterable fails
Date: Tue, 17 Feb 2026 13:14:28 -0300
Message-ID: <20260217161443.12738-18-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260217161443.12738-1-farosas@suse.de>
References: <20260217161443.12738-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,suse.de:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[redhat.com,web.de]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; FREEMAIL_ENVRCPT(0.00)[web.de]
X-Rspamd-Queue-Id: 2F2173E735
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

All users of qemu_savevm_state_complete_precopy_non_iterable() process
return values.  There's no need to set error on qemufile (which we likely
should remove gradually across the tree).  Remove it for possible code
dedup to happen later.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Tested-by: Lukas Straub <lukasstraub2@web.de>
Link: https://lore.kernel.org/qemu-devel/20260127185254.3954634-12-peterx@redhat.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/savevm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index da9a60c73f..9d2109718a 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1688,7 +1688,6 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
         if (ret) {
             migrate_error_propagate(ms, error_copy(local_err));
             error_report_err(local_err);
-            qemu_file_set_error(f, ret);
             return ret;
         }
 
-- 
2.51.0


