Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ABD5C982D8
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 22:30:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7h6B-0007ou-13; Fri, 18 Sep 2026 18:30:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x7h66-0007oN-Cc
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 18:30:22 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x7h64-0000aR-DV
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 18:30:21 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ECD6A21EE2;
 Fri, 18 Sep 2026 22:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789770615; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l0Xc52nHv3u5ujrP4zfiyGstwX0hT67QnX+jedekjls=;
 b=g2QOWvHGJYUMMmFeG4lhduv2gEMmVfsCPJv0O+Visgs6oNa1jI4bZYsFf5jvfHbID2T/rG
 PFVgzF3al3/mxPPaUB4UwI4oIikB5Q+3c2xPjYl49QxbW/s6t1Os1STqN9dFKGRPDfk3uH
 ZnuoIe08hDTBLhM1dKNv0nByJxkq5Wo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789770615;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l0Xc52nHv3u5ujrP4zfiyGstwX0hT67QnX+jedekjls=;
 b=j31NgiNZGvdGpIKcy/LqbK0ICapS91JXJIVkQVDCGtTnemKk0R+gqvwEMIxNlTBALVOhDF
 ygU1/WyM8xA220Bw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789770610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l0Xc52nHv3u5ujrP4zfiyGstwX0hT67QnX+jedekjls=;
 b=VIMoww2TcogPRh0dMuzV9bqR9PZFWySlkTFOUxxPRxkIbjIeesvy06ETcKZuxBli+0XmhC
 a2fmCSi6hV6/lLuno7ofpdQ0Rz1x3lIOS1OfBGHBwYUkcQUcnhoNR3CIfL9A1TeaHhMVk+
 oJuX/Van7PbaHE5z6+RL59orZei/zgo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789770610;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l0Xc52nHv3u5ujrP4zfiyGstwX0hT67QnX+jedekjls=;
 b=TLhxOBQlKZqxBwahHjR8bBKoUycVw9YP62QPNY0jMPs+C+B4VU7N1bQ3ErJYiDHOP8k3Gt
 tnLycP9JnEL/YhDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB162139B1;
 Fri, 18 Sep 2026 22:30:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hQIbBW27rWrsdQAAD6G6ig:T4
 (envelope-from <farosas@suse.de>); Fri, 18 Sep 2026 22:30:09 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH 03/14] qemu-options: Consolidate branches in opts_parse
Date: Fri, 18 Sep 2026 19:29:50 -0300
Message-ID: <20260918223002.1892021-4-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918223002.1892021-1-farosas@suse.de>
References: <20260918223002.1892021-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.997];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
 RCVD_TLS_ALL(0.00)[]
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

The two branches that return NULL can be put under a single branch
because the qemu_opts_del function can take a NULL opt. The next patch
will add common cleanup code to the error path so change this now to
avoid code duplication.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 util/qemu-option.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/util/qemu-option.c b/util/qemu-option.c
index 557d5d929c..e115e1acef 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -900,12 +900,8 @@ static QemuOpts *opts_parse(QemuOptsList *list, const char *params,
 
     opts = qemu_opts_create(list, id, !list->merge_lists, errp);
     g_free(id);
-    if (opts == NULL) {
-        return NULL;
-    }
-
-    if (!opts_do_parse(opts, params, firstname,
-                       warn_on_flag, help_wanted, errp)) {
+    if (!opts || !opts_do_parse(opts, params, firstname,
+                                warn_on_flag, help_wanted, errp)) {
         qemu_opts_del(opts);
         return NULL;
     }
-- 
2.53.0


