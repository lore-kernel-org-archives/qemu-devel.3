Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75CF8FEDA04
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 18:24:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Z5n-0004o8-Fo; Tue, 17 Mar 2026 14:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w2Z5R-0004kD-54
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 14:24:13 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w2Z5O-00038F-7Q
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 14:24:11 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CFF444D3C0;
 Tue, 17 Mar 2026 18:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773771815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zqaLLFRvAqv9HvFvoTB699fqhZJlGHS7AV1u0kLxxjY=;
 b=s0kdzWg26MpWCsTCGXZYiBmCtlF8i1SUzdQ1KxvI5bhcvLi6Z0vXOT2ox65HqsnXZ2eeeV
 8BNB2ww0t6l7/NgqW3DzK4bCDmQh0VIxPvXMiNrvRQHSHQhK4TZHrmSNynXNekhY9J71iF
 wZU7x87hNVxBpCsYGtI0Xl8ymrVzwSk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773771815;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zqaLLFRvAqv9HvFvoTB699fqhZJlGHS7AV1u0kLxxjY=;
 b=bIdY6/OthOj6+p6p15w4XQUr1HWTz9SbxKvXMsAabWZzi7t3zBFGYFCeqsh53W9KD4QGM2
 SQCAbCuPooJqu9Bw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773771815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zqaLLFRvAqv9HvFvoTB699fqhZJlGHS7AV1u0kLxxjY=;
 b=s0kdzWg26MpWCsTCGXZYiBmCtlF8i1SUzdQ1KxvI5bhcvLi6Z0vXOT2ox65HqsnXZ2eeeV
 8BNB2ww0t6l7/NgqW3DzK4bCDmQh0VIxPvXMiNrvRQHSHQhK4TZHrmSNynXNekhY9J71iF
 wZU7x87hNVxBpCsYGtI0Xl8ymrVzwSk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773771815;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zqaLLFRvAqv9HvFvoTB699fqhZJlGHS7AV1u0kLxxjY=;
 b=bIdY6/OthOj6+p6p15w4XQUr1HWTz9SbxKvXMsAabWZzi7t3zBFGYFCeqsh53W9KD4QGM2
 SQCAbCuPooJqu9Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 396CE4273B;
 Tue, 17 Mar 2026 18:23:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kDuEACacuWnXdQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Mar 2026 18:23:34 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: [PULL 07/10] migration/options: Fix leaks in StrOrNull qdev accessors
Date: Tue, 17 Mar 2026 15:23:17 -0300
Message-ID: <20260317182320.31991-8-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317182320.31991-1-farosas@suse.de>
References: <20260317182320.31991-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[]
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

Fix a couple of possible leaks detected by Coverity. Both are
currently harmless. This code is only used for the very specific
purpose of maintaining compatibility of a few migration options which
can be set via QEMU command line (-global migration.tls-*). The
command line interface is not supported and only used during
development and testing.

1) The setter function set_StrOrNull() is invoked whenever the -global
migration.tls-* command line options are set. The way it could leak is
that the temporary "StrOrNull *str_or_null" object is allocated before
calling the visitor, which could fail and cause an early return of the
function, leaving *ptr unset and str_or_null leaking.

2) The getter function get_StrOrNull() is unreachable code. It's only
there to provide a complete implementation of the property. Still, the
way it could leak is that the temporary "StrOrNull *str_or_null" might
be allocated and is simply never returned to the caller nor freed.

Fix the possible leaks:

1) at set_StrOrNull(): change the allocation of str_or_null to happen
only after the visit call has returned successfully.

2) at get_StrOrNull(): assert that the object is non-NULL, there is no
need for a temporary object.

The reason it should be non-NULL is that the property is initialized
by the default setter of the qdev property. The initialization is
unlikely to fail because the call to the setter is setup by qdev,
which has boilerplate ensuring the to-be-set object is allocated and
of the correct type. Moreover, passing NULL via command line to
-global migration.tls-* is not possible.

A programming error could result in an invalid call to the setter,
which would leave the object NULL and cause a crash in the getter, but
that's not a worthwhile scenario to protect against given the low
probability of this code being even reached.

While here, update the comment about why there's no QNULL in this
StrOrNull property to be more clear.

Fixes: CID 1643919
Fixes: CID 1643920
Cc: Markus Armbruster <armbru@redhat.com>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>
Link: https://lore.kernel.org/qemu-devel/20260312204619.1969-1-farosas@suse.de
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/options.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index f33b297929..658c578191 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -220,14 +220,12 @@ static void get_StrOrNull(Object *obj, Visitor *v, const char *name,
     StrOrNull **ptr = object_field_prop_ptr(obj, prop);
     StrOrNull *str_or_null = *ptr;
 
-    if (!str_or_null) {
-        str_or_null = g_new0(StrOrNull, 1);
-        str_or_null->type = QTYPE_QSTRING;
-        str_or_null->u.s = g_strdup("");
-    } else {
-        /* the setter doesn't allow QNULL */
-        assert(str_or_null->type != QTYPE_QNULL);
-    }
+    /*
+     * The property should never be NULL because it's part of
+     * s->parameters and a default value is always set by qdev. It
+     * should also never be QNULL as the setter doesn't allow it.
+     */
+    assert(str_or_null && str_or_null->type != QTYPE_QNULL);
     visit_type_str(v, name, &str_or_null->u.s, errp);
 }
 
@@ -236,16 +234,25 @@ static void set_StrOrNull(Object *obj, Visitor *v, const char *name,
 {
     const Property *prop = opaque;
     StrOrNull **ptr = object_field_prop_ptr(obj, prop);
-    StrOrNull *str_or_null = g_new0(StrOrNull, 1);
+    StrOrNull *str_or_null;
+    char *str;
+
+    if (!visit_type_str(v, name, &str, errp)) {
+        return;
+    }
 
     /*
-     * Only str to keep compatibility, QNULL was never used via
-     * command line.
+     * This property only applies to the command line usage of
+     * migration's TLS options (-global migration.tls-*) where the
+     * NULL value cannot be provided as input (only strings are
+     * allowed). Therefore, this StrOrNull implementation never
+     * produces a QNULL value to avoid ever returning values outside
+     * the range of what was previously handled by consumers of the
+     * TLS options.
      */
+    str_or_null = g_new0(StrOrNull, 1);
     str_or_null->type = QTYPE_QSTRING;
-    if (!visit_type_str(v, name, &str_or_null->u.s, errp)) {
-        return;
-    }
+    str_or_null->u.s = str;
 
     qapi_free_StrOrNull(*ptr);
     *ptr = str_or_null;
-- 
2.51.0


