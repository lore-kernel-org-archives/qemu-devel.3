Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBCFAC5B54A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 14:57:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjK6a-0002eU-Ql; Wed, 28 Aug 2024 10:57:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sjK6W-0002O1-NJ
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 10:57:00 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sjK6V-00027q-94
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 10:57:00 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BB56F1FC83;
 Wed, 28 Aug 2024 14:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724857017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UI9nhhU0+z9UmAzui+fQPbgnK1DOQlBouwrZU0rQWYU=;
 b=cuOAq/qDrSDIgK+YtVnrcTHbggCXAZu/qsEVKd2ArOMxgtcinZYiitBFlj3jbE3kNhShzI
 j2moh1NLgQ0H6oD8RLBUGNVFnrT/fOdy2svnghQtA5rGGWhLPDX77blbB+KZRtajguD4u5
 revbPBSNTxLGzHYO3fu9X8Yi7V1pzQI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724857017;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UI9nhhU0+z9UmAzui+fQPbgnK1DOQlBouwrZU0rQWYU=;
 b=J/LEBq34Nl0ubCH6GyScTL6/MMX/tC84ivYIMaQ8S3K/pWHI029RKnYiqH/TxMoo0E+DPI
 4blhaD5GKTuJPyDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="cuOAq/qD";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="J/LEBq34"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724857017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UI9nhhU0+z9UmAzui+fQPbgnK1DOQlBouwrZU0rQWYU=;
 b=cuOAq/qDrSDIgK+YtVnrcTHbggCXAZu/qsEVKd2ArOMxgtcinZYiitBFlj3jbE3kNhShzI
 j2moh1NLgQ0H6oD8RLBUGNVFnrT/fOdy2svnghQtA5rGGWhLPDX77blbB+KZRtajguD4u5
 revbPBSNTxLGzHYO3fu9X8Yi7V1pzQI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724857017;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UI9nhhU0+z9UmAzui+fQPbgnK1DOQlBouwrZU0rQWYU=;
 b=J/LEBq34Nl0ubCH6GyScTL6/MMX/tC84ivYIMaQ8S3K/pWHI029RKnYiqH/TxMoo0E+DPI
 4blhaD5GKTuJPyDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 965241398F;
 Wed, 28 Aug 2024 14:56:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YEw3F7g6z2YnRgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 28 Aug 2024 14:56:56 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v7 2/4] migration/multifd: Fix p->iov leak in multifd-uadk.c
Date: Wed, 28 Aug 2024 11:56:48 -0300
Message-Id: <20240828145650.15879-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240828145650.15879-1-farosas@suse.de>
References: <20240828145650.15879-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BB56F1FC83
X-Spamd-Result: default: False [-5.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:email, suse.de:dkim, suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The send_cleanup() hook should free the p->iov that was allocated at
send_setup(). This was missed because the UADK code is conditional on
the presence of the accelerator, so it's not tested by default.

Fixes: 819dd20636 ("migration/multifd: Add UADK initialization")
Reported-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd-uadk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/migration/multifd-uadk.c b/migration/multifd-uadk.c
index 89f6a72f0e..6e6a290ae9 100644
--- a/migration/multifd-uadk.c
+++ b/migration/multifd-uadk.c
@@ -132,6 +132,8 @@ static void multifd_uadk_send_cleanup(MultiFDSendParams *p, Error **errp)
 
     multifd_uadk_uninit_sess(wd);
     p->compress_data = NULL;
+    g_free(p->iov);
+    p->iov = NULL;
 }
 
 static inline void prepare_next_iov(MultiFDSendParams *p, void *base,
-- 
2.35.3


