Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CDC0C79FB7
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 21:46:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Q6r-0000Um-9S; Wed, 09 Sep 2026 17:45:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x4Q6p-0000Tj-2K
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 17:45:35 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x4Q6m-0005L0-6T
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 17:45:34 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 443FB21C86;
 Wed,  9 Sep 2026 21:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788990323; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i0xypdlguFgZqf9pf4kZeAPVThtLBKBKIFhZdXB6v4k=;
 b=vSBZbAaFCReVaeIFizOmSzqALwt5qazQZCtF+1CX/Ol9eHiJJA3GIldgxQXvDQLa7K7CSe
 aVe1NqdgKZlTtVOz8F0Kg+4LA0pRsZpYIcW8LcfNmNKrt8yR+7rkLVY/Oq3AITQQjE6FMH
 csT/cgpEG5jCfrJ/9R7I7DlO5kZ3Bjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788990323;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i0xypdlguFgZqf9pf4kZeAPVThtLBKBKIFhZdXB6v4k=;
 b=ldBq1TNCB6r1uAcKqloH1nKzuExFoZR9YH8LgJH4KVlbFY6FXXAT6UAucyq0BDtxusbz91
 Spa3vAK7sWlOvuAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xlpZm5VJ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sKJb0szh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788990319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i0xypdlguFgZqf9pf4kZeAPVThtLBKBKIFhZdXB6v4k=;
 b=xlpZm5VJDsfSGPUg9M5gamPysFLeVUhIb25cz2cnR4KODpemGa39jJkY17pbRqMt1p1XAi
 i2yg3UHAjdbWmCfintzTSb2ajFMTd/h02iBBcwiubnUZZ8erOBLSpWiqzRJtEPEqXa8XWi
 Z7zlLBZxeWPCp4UvRYRKlm8w82/w6AE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788990319;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i0xypdlguFgZqf9pf4kZeAPVThtLBKBKIFhZdXB6v4k=;
 b=sKJb0szhtOBveQ8A5CK3gbOQQqZK6RQxZ3ctkQ+tRgCdIqwmobn+ObkNkCcmigxz8qqzdQ
 ED7FCBOiFjRZxjAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C716136ED;
 Wed,  9 Sep 2026 21:45:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YK9xFW3ToWqzawAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 09 Sep 2026 21:45:17 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PATCH v2 01/18] checkpatch: Fix checking of newlines in error
 messages
Date: Wed,  9 Sep 2026 18:44:51 -0300
Message-ID: <20260909214509.237309-2-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909214509.237309-1-farosas@suse.de>
References: <20260909214509.237309-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 443FB21C86
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
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

Using newlines in error messages is not allowed as per qapi/error.h
documentation.

Checkpatch has been enforcing this for the error.h API, but also for
g_test_message() which doesn't fall under the qapi/error.h
prescription. Using newlines in that function's format string is fine
and can help with readability of test code when formatting test
results. Note that g_test_message() automatically adds the '#'
required by the TAP protocol to the start of each line.

Relax the regex for this function, but still forbid a trailing newline
because it's added automatically and usually not what the user wants.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 scripts/checkpatch.pl | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 03f35e7501..8fd38868c5 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3303,13 +3303,20 @@ sub process {
 					 info_vreport|
 					 error_report|
 					 warn_report|
-					 info_report|
-					 g_test_message}x;
+					 info_report}x;
 
 		if ($rawline =~ /\b(?:$qemu_error_funcs)\s*\(.*\".*\\n/) {
 			ERROR("Error messages should not contain newlines\n" . $herecurr);
 		}
 
+		# No newlines at the end
+		my $trail_newline_error_funcs = qr{g_test_message}x;
+
+		if ($rawline =~ /\b(?:$trail_newline_error_funcs)\s*\(.*\".*\\n\"/) {
+		    ERROR("Error messages should not contain trailing " .
+			  "newlines\n" . $herecurr);
+		}
+
 		# Continue checking for error messages that contains newlines.
 		# This check handles cases where string literals are spread
 		# over multiple lines.
-- 
2.53.0


