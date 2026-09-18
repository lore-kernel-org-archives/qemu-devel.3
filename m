Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2583CC982D8
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 22:31:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7h6N-000858-67; Fri, 18 Sep 2026 18:30:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x7h6L-00081x-SJ
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 18:30:37 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x7h6K-0000gI-DY
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 18:30:37 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CF32520005;
 Fri, 18 Sep 2026 22:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789770631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WfrKmIFuG5uSEY1zSMZt8t3wRpCkwiQiryE/71OpRkw=;
 b=zvyJObeAWZI6DbQtRysou5Hy1URI+rRfjA/imTUAJKR5uiyTKhoepSRl7LGtN2mfBWBCQo
 w8UiCI0FbO3AhdWuklzoej+2jxFUHiU4g4qcIa+GDVm2bVLCYTlPFyA+u9KZAgb7wV3+gp
 b7mS0BmKD8GSDTt8MVypKBtmTgdUi6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789770631;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WfrKmIFuG5uSEY1zSMZt8t3wRpCkwiQiryE/71OpRkw=;
 b=mW6FZHJT30fe/MO2e3LYHFnt2iQr6ELJdAjsIyj8qCTCrV+DW84okxq6Rsfbn3trGG2vRJ
 WHTL/7QKNL/beYAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GhmSCi9p;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=uwMep+1Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789770626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WfrKmIFuG5uSEY1zSMZt8t3wRpCkwiQiryE/71OpRkw=;
 b=GhmSCi9pPW5su/SMwxTOoV3U27awY8+GSjFOJ0BYxJblQ7WAODT+fD7JUggFx2O4m/f7tG
 5V5mEESmVhRN4+tsyuYei+HOB8XisLXkMfbOjb0t9EgPiESheoVmpOdAzkH/53AzVci7Ha
 4FT0gNa/9rili7Znn2y6EfiNOMKSjEk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789770626;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WfrKmIFuG5uSEY1zSMZt8t3wRpCkwiQiryE/71OpRkw=;
 b=uwMep+1ZER7+vSYTyHlllsZZ/S5CxIhPA1ZlwsBGxIHsqeafu08l/Xw9+1hd5scNPEcz7+
 sNF9/j7Np7bGLYBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EFAB61348F;
 Fri, 18 Sep 2026 22:30:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hQIbBW27rWrsdQAAD6G6ig:T14
 (envelope-from <farosas@suse.de>); Fri, 18 Sep 2026 22:30:25 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH 13/14] qemu-options: Further simplify
 qemu_opts_parse_list()
Date: Fri, 18 Sep 2026 19:30:00 -0300
Message-ID: <20260918223002.1892021-14-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918223002.1892021-1-farosas@suse.de>
References: <20260918223002.1892021-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CF32520005
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email,suse.de:mid];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
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

Now that the two branches of this function are similar, turn it into a
single call to opts_parse().

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 util/qemu-option.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/util/qemu-option.c b/util/qemu-option.c
index 8dadb47170..1e8042a1bd 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -950,19 +950,18 @@ QemuOpts *qemu_opts_parse_list(QemuOptsList *list, const char *params,
 {
     bool noisily = !errp;
     QemuOpts *opts = NULL;
+    Error *err = NULL;
 
     assert(list);
+    opts = opts_parse(list, params, permit_abbrev, noisily, &err);
 
-    if (noisily) {
-        Error *err = NULL;
-
-        opts = opts_parse(list, params, permit_abbrev, noisily, &err);
-        if (!opts && err) {
+    if (!opts) {
+        assert(err);
+        if (noisily) {
             error_report_err(err);
+        } else {
+            error_propagate(errp, err);
         }
-
-    } else {
-        opts = opts_parse(list, params, permit_abbrev, noisily, errp);
     }
 
     return opts;
-- 
2.53.0


