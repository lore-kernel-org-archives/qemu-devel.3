Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 622FACA5FC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 22:12:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xC2XA-00081F-QS; Wed, 30 Sep 2026 18:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xC2Wo-0007wv-Td
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 18:11:56 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xC2Wl-00053B-Os
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 18:11:53 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5ECC11FB97;
 Wed, 30 Sep 2026 22:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790806306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xuiDDpmDXh47Fgd0I8y4cMCiRv6z5d2fdlK71G2PVZ4=;
 b=hYSpsZ9hltwKDE7//GyTtqHwLI/DsL49I67TiCjZVIE8aoEJ3zC/uX7Vjt0gdwwWyWJgP2
 cr7hNJkWRmvA69XfAr7xYwA7gMkXbJPbAPIvY8sEL8H/Be5dUw2KYW0H7nDxLYlgXL52Ik
 OK2hlo6cRHbvrZiwPV77wrQDTa4DUjc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790806306;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xuiDDpmDXh47Fgd0I8y4cMCiRv6z5d2fdlK71G2PVZ4=;
 b=gcvzVIb3BbJtKMYKEj6ZncBVa2tTm6rde0fqt6igylvjCyLyTuKNZez0XFmyLzZi7qr6bD
 wp1gEDbjibRB7FBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xcvqF3qb;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0Gy2chQP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790806302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xuiDDpmDXh47Fgd0I8y4cMCiRv6z5d2fdlK71G2PVZ4=;
 b=xcvqF3qbbBymw1kbk2HpYKfQ4T1JST9QPzpeTjb855/zA1O6FSiYDzzKacdEuxStIs4R/2
 Hq9UX+eyNNfKRVz02rwpcB0wPuHjUgxSPiCvrLR7oKlNsW2fD6QH4e2YXr/Et7vs8SahNF
 lnXVkL7mjpxX6zMUYskLgzMhLte4kCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790806302;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xuiDDpmDXh47Fgd0I8y4cMCiRv6z5d2fdlK71G2PVZ4=;
 b=0Gy2chQPAod1GExwgUgoyLHUZ0o92McRmeNvAjD4AXLCYJKfB+qBhFtIPJF9ZexLDxvCMZ
 3gywUPZ7AZc0LaAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4706613B24;
 Wed, 30 Sep 2026 22:11:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id befqOAqJvWpwXAAAD6G6ig:T11
 (envelope-from <farosas@suse.de>); Wed, 30 Sep 2026 22:11:41 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 10/11] qemu-option: Check for NULL list at qemu_opts_parse()
Date: Wed, 30 Sep 2026 19:11:04 -0300
Message-ID: <20260930221105.2262063-11-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930221105.2262063-1-farosas@suse.de>
References: <20260930221105.2262063-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5ECC11FB97
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Now that qemu_opts_parse_noisily() is protected against NULL list, do
the same for the non noisy version.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 util/qemu-option.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/util/qemu-option.c b/util/qemu-option.c
index 7c42b4feda..83fa2399d3 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -939,6 +939,10 @@ QemuOpts *qemu_opts_parse(const char *group, const char *params,
 {
     QemuOptsList *list = qemu_find_opts_err(group, errp);
 
+    if (!list) {
+        return NULL;
+    }
+
     return qemu_opts_parse_list(list, params, permit_abbrev, errp);
 }
 
-- 
2.53.0


