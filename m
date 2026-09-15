Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3C2DC88E72
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 00:04:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Gd5-0003KW-Mi; Mon, 14 Sep 2026 20:02:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x6Gd4-0003Jz-5h
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:02:30 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x6Gd2-0004mP-Cr
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:02:29 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9E7EA1FF21;
 Tue, 15 Sep 2026 00:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789430542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PZGSSzQYnTwqwkKB8Yyt6avqtEmbpcuPp0fGs8PrBic=;
 b=Lc7gcE5PIDro3pRlU+Wy1CqcFHAUboUpS1Zgor/KyR7dYQVK5FdrxtB1fzRgoDBVl7WdGi
 zJZA3+bCsg85AgJzA3dCY7+e3tgmfaXAdT7UwCRH3SILYsUs4K/e6zN7xuVetDWj6sAXU3
 kwW6rDpLRMRs9eMp6PafUoag60nkwFM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789430542;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PZGSSzQYnTwqwkKB8Yyt6avqtEmbpcuPp0fGs8PrBic=;
 b=bmow1ld6bnG9R44cD4V60msIGG87AzQuZlpZEQa8NHLAjxtK6jFmyEY66+5P46vyQyc8fL
 6TiQ3jfHjULM6ZDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="fjnXHS/L";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=dnOhplmD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789430538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PZGSSzQYnTwqwkKB8Yyt6avqtEmbpcuPp0fGs8PrBic=;
 b=fjnXHS/Lpcu4OXgn2au2j0W6u+1Gs1fJC1kOuBfwbWyipSnBf8mkS27/RDJwpfrd5tg9Ju
 GpdQCULN1KbFI1OswCgM/35ZOfwyHHCFH7fYyrL/El1t7LK12CCGmzv5VOdYX+vjuWB/Qx
 ttRqiAPO+CXXYSEap1GX+ja5wO619Cs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789430538;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PZGSSzQYnTwqwkKB8Yyt6avqtEmbpcuPp0fGs8PrBic=;
 b=dnOhplmDfYUCx4aarOwYqhQASFFAn5qVMjYfNwl40uu0jd+vXIr787QE6jrrBiF+J1LfbX
 /e+UZBScojd0kqAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3875113710;
 Tue, 15 Sep 2026 00:02:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Gk6xFQeLqGqIFAAAD6G6ig:T2
 (envelope-from <farosas@suse.de>); Tue, 15 Sep 2026 00:02:17 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PATCH v3 01/20] checkpatch: Fix checking of newlines in error
 messages
Date: Mon, 14 Sep 2026 21:01:49 -0300
Message-ID: <20260915000209.3692668-2-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915000209.3692668-1-farosas@suse.de>
References: <20260915000209.3692668-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9E7EA1FF21
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email,suse.de:mid];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; DKIM_TRACE(0.00)[suse.de:+]
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
index 9838a64178..1e9499ed9b 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3347,13 +3347,20 @@ sub process {
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


