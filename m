Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A8BFC25B74
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 23:37:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4qpb-00039g-Mj; Wed, 08 May 2024 19:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s4qpZ-00033b-U3
 for qemu-devel@nongnu.org; Wed, 08 May 2024 19:36:13 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s4qpW-0002UF-Nz
 for qemu-devel@nongnu.org; Wed, 08 May 2024 19:36:13 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4940837725;
 Wed,  8 May 2024 23:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715211369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NMgdBzy6B6BZ+ndeqFAhyOm8zroXBnrmqFiaqChf4Hw=;
 b=AEVAspSlIx6Rf0TpVEmFyuvo9OyUT1tJ6zTPsI6u5b2pHmjzDrfgKbKZT+Gweo3msllM73
 v0GHuGurg74UJkyDjHfOdVLB6OcuQTk8d98FcHfmxSTAeb6kwUBXLkHhf/R28c9mrRvGl2
 1ytTNXB//Y6gPY28qeL/gKW3BJ/RsNs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715211369;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NMgdBzy6B6BZ+ndeqFAhyOm8zroXBnrmqFiaqChf4Hw=;
 b=qU7AIzB9egfDWik8PjZZUKS+z/+H71hWqDzkEVbCnOctI9+eCk49aB5UT5OQ5zj1HusQqM
 +vSQPbMC76CIDnAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=AEVAspSl;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qU7AIzB9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715211369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NMgdBzy6B6BZ+ndeqFAhyOm8zroXBnrmqFiaqChf4Hw=;
 b=AEVAspSlIx6Rf0TpVEmFyuvo9OyUT1tJ6zTPsI6u5b2pHmjzDrfgKbKZT+Gweo3msllM73
 v0GHuGurg74UJkyDjHfOdVLB6OcuQTk8d98FcHfmxSTAeb6kwUBXLkHhf/R28c9mrRvGl2
 1ytTNXB//Y6gPY28qeL/gKW3BJ/RsNs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715211369;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NMgdBzy6B6BZ+ndeqFAhyOm8zroXBnrmqFiaqChf4Hw=;
 b=qU7AIzB9egfDWik8PjZZUKS+z/+H71hWqDzkEVbCnOctI9+eCk49aB5UT5OQ5zj1HusQqM
 +vSQPbMC76CIDnAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A00BF13A27;
 Wed,  8 May 2024 23:36:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eJGHGWcMPGZ7FQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 08 May 2024 23:36:07 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL v2 13/13] hmp/migration: Fix "migrate" command's documentation
Date: Wed,  8 May 2024 20:35:41 -0300
Message-Id: <20240508233541.2403-14-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240508233541.2403-1-farosas@suse.de>
References: <20240508233541.2403-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4940837725
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

From: Peter Xu <peterx@redhat.com>

Peter missed the Sphinx HMP document for the "resume/-r" flag in commit
7a4da28b26 ("qmp: hmp: add migrate "resume" option").  Add it.

When at it, slightly cleanup the lines around:

  - Move "detach/-d" to a separate section rather than appending it at the
  end of the command description. Add a hint for how to query the migration
  results in detached mode.

  - Add "postcopy" keyword to "resume/-r" help messages, as it only applies
  to postcopy.

Cc: Dr. David Alan Gilbert <dave@treblig.org>
Cc: Fabiano Rosas <farosas@suse.de>
Fixes: 7a4da28b26 ("qmp: hmp: add migrate "resume" option")
Reported-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 hmp-commands.hx | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index ebca2cdced..06746f0afc 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -912,14 +912,20 @@ ERST
         .args_type  = "detach:-d,resume:-r,uri:s",
         .params     = "[-d] [-r] uri",
         .help       = "migrate to URI (using -d to not wait for completion)"
-		      "\n\t\t\t -r to resume a paused migration",
+		      "\n\t\t\t -r to resume a paused postcopy migration",
         .cmd        = hmp_migrate,
     },
 
 
 SRST
-``migrate [-d]`` *uri*
-  Migrate to *uri* (using -d to not wait for completion).
+``migrate [-d] [-r]`` *uri*
+  Migrate the VM to *uri*.
+
+  ``-d``
+    Start the migration process, but do not wait for its completion.  To
+    query an ongoing migration process, use "info migrate".
+  ``-r``
+    Resume a paused postcopy migration.
 ERST
 
     {
-- 
2.35.3


