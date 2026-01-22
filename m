Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD8FD6CFAB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 23:26:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vj435-0003Wv-KQ; Thu, 22 Jan 2026 18:25:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vj434-0003W9-5e
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 18:25:10 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vj432-00055t-De
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 18:25:09 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 49FA933765;
 Thu, 22 Jan 2026 23:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769124304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=MGeexF4c2j41dm7JpZyMcjLbL+4b4pxGUqi1TunsNvk=;
 b=QkmFMHfTSTIg0wJAtY2O+Rsq/AbTETj1pXVscqDcTKCi318rRRYEFMsrV9fCH1bOv0XrSA
 cNr10NK3pN9/l5YV7fz2OUznnP98e5arvB1FCNYTtqMAa6MjiTyqHDqW/bndXCFZzCsfOz
 FrVyxfkDAcqUvC6az0nswcpcLkpzCcA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769124304;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=MGeexF4c2j41dm7JpZyMcjLbL+4b4pxGUqi1TunsNvk=;
 b=EwBNbctZdCrJ4+9H3iyIkoY8i5UCnOchG+siZF8P++QRogEtngMaaINJQDWNt8lw02SSAM
 ImWQymk0fspQoGBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QkmFMHfT;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=EwBNbctZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769124304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=MGeexF4c2j41dm7JpZyMcjLbL+4b4pxGUqi1TunsNvk=;
 b=QkmFMHfTSTIg0wJAtY2O+Rsq/AbTETj1pXVscqDcTKCi318rRRYEFMsrV9fCH1bOv0XrSA
 cNr10NK3pN9/l5YV7fz2OUznnP98e5arvB1FCNYTtqMAa6MjiTyqHDqW/bndXCFZzCsfOz
 FrVyxfkDAcqUvC6az0nswcpcLkpzCcA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769124304;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=MGeexF4c2j41dm7JpZyMcjLbL+4b4pxGUqi1TunsNvk=;
 b=EwBNbctZdCrJ4+9H3iyIkoY8i5UCnOchG+siZF8P++QRogEtngMaaINJQDWNt8lw02SSAM
 ImWQymk0fspQoGBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB8671395E;
 Thu, 22 Jan 2026 23:25:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6ihEGs6xcml+IQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 22 Jan 2026 23:25:02 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, armbru@redhat.com,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] migration/options: Fix leaks in StrOrNull accessors
Date: Thu, 22 Jan 2026 20:24:56 -0300
Message-ID: <20260122232456.12722-1-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 49FA933765
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

Fix a couple of leaks detected by Coverity. Both are currently
harmless because the visitor in the setter can never fail and the
whole of the getter is unused, it's only purpose at the moment is to
provide a complete implementation of the StrOrNull property.

Fixes: CID 1643919
Fixes: CID 1643920
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
CI run: https://gitlab.com/farosas/qemu/-/pipelines/2280325023
---
 migration/options.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/migration/options.c b/migration/options.c
index 9a5a39c886..9dc44a3736 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -225,6 +225,7 @@ static void get_StrOrNull(Object *obj, Visitor *v, const char *name,
         str_or_null = g_new0(StrOrNull, 1);
         str_or_null->type = QTYPE_QSTRING;
         str_or_null->u.s = g_strdup("");
+        *ptr = str_or_null;
     } else {
         /* the setter doesn't allow QNULL */
         assert(str_or_null->type != QTYPE_QNULL);
@@ -245,6 +246,7 @@ static void set_StrOrNull(Object *obj, Visitor *v, const char *name,
      */
     str_or_null->type = QTYPE_QSTRING;
     if (!visit_type_str(v, name, &str_or_null->u.s, errp)) {
+        qapi_free_StrOrNull(str_or_null);
         return;
     }
 
-- 
2.51.0


