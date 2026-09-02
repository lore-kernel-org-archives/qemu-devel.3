Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C19BC624D4
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 22:16:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1tFn-0000ry-9n; Wed, 02 Sep 2026 18:16:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x1tFl-0000rD-Aq
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 18:16:21 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x1tFj-0002MI-Nk
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 18:16:21 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 22C8E21C16;
 Wed,  2 Sep 2026 22:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788387371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Oo43kuECY/APRHl4nCTe7/bnJ8RAMa6iv1OPvyqxt/0=;
 b=CXdyC2efCXCK7ljXbv5l4kqHFs+fI2hn44gOoq5IlVPOq8NNE2TBCfglhnu9m2VXqAVwnB
 xicP40dhkzaJmQzMXTPm90GTT66bCdVEM6ow0wEHkYKjwa9eTRJUNpuiVArCf/UCFsqUej
 WPxFJ7E9zsb26RhAl2nD0EysfRcvybY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788387371;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Oo43kuECY/APRHl4nCTe7/bnJ8RAMa6iv1OPvyqxt/0=;
 b=DPseUysl/obV2I5+hnKWCjQsucDhvYyGQ3wm7XwyFrYqmy9HlVLk4pTA3nlIKo15N3oR2+
 e0EFVWgW5eMEzzDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788387367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Oo43kuECY/APRHl4nCTe7/bnJ8RAMa6iv1OPvyqxt/0=;
 b=GV3RILGwFDlCpZfxIubwx8eBv2H5TrLsy7RjZL9sF5uhISvweg13rP07gMednC0r0RBjYC
 UzJScGyY37vJ8smOtfw8kneStZb+75qrYECKVURsWn6idS2RS6GHDDZRDtR4U2loRguzEz
 HL2KRwvmp23aUvT6N8Y14vkw7xU5+Rw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788387367;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Oo43kuECY/APRHl4nCTe7/bnJ8RAMa6iv1OPvyqxt/0=;
 b=0/3palMA39vSwnLldMT7uZDgXsesksKs4Eked0xXiUL/MyM/lcHSm6edPBu1rZeVyoK6fY
 +iQoX3E12RSZmGDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 18D6213736;
 Wed,  2 Sep 2026 22:16:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wLehNiWgmGpxXwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 02 Sep 2026 22:16:05 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Chao Liu <chao.liu@processmission.com>
Subject: [PATCH 01/18] checkpatch: Fix checking of newlines in error messages
Date: Wed,  2 Sep 2026 19:15:29 -0300
Message-ID: <20260902221547.1812481-2-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902221547.1812481-1-farosas@suse.de>
References: <20260902221547.1812481-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.997];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
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

Using newlines in the g_test_message is fine. It automatically adds
the '#' required by the TAP protocol to the start of each line.

Relax the regex for this function, but still forbid a trailing newline
because it's added automatically and usually not what the user wants.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 scripts/checkpatch.pl | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 03f35e75012..fd4534b3a1e 100755
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
+		if ($rawline =~ /\b(?:$trail_newline_error_funcs)\(.*\".*\\n\"/) {
+		    ERROR("Error messages should not contain trailing " .
+			  "newlines\n" . $herecurr);
+		}
+
 		# Continue checking for error messages that contains newlines.
 		# This check handles cases where string literals are spread
 		# over multiple lines.
-- 
2.53.0


