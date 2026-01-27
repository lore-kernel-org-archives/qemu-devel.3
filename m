Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53CED1953D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 15:10:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkkh5-0006Ec-BO; Tue, 27 Jan 2026 10:09:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vkkh4-0006EC-BM
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 10:09:26 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vkkh2-0004Ww-Iw
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 10:09:26 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 58AAF337C2;
 Tue, 27 Jan 2026 15:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769526561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xp7C8NY13Bji1YpuziNMnFlAQUXNfjVhh4AoYxC5Cyc=;
 b=iyVp2qmUW+FkMFS6CvtTvAFrF5QxCgBV2QLthdVFxxQ1/9xfKhxd1Nb6E28gQ8nQswMsc6
 SzxZzyjrJvhg8RMvLvO7X+yXwjDZBgQkmmiXvM7zGSbRHMSrzaCqbl+rPXN4M2Zuhle2V5
 9J06llbIrSoB7AymYRiPV1nw0WykVwY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769526561;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xp7C8NY13Bji1YpuziNMnFlAQUXNfjVhh4AoYxC5Cyc=;
 b=I2W/0+s/oDpzQwf042IPeFZ97pujV8at6aDlRGMpQHqWYl+/I6UZN3slM0/kHQ2Vlqco1V
 dIP1BU94/Yu54QAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769526561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xp7C8NY13Bji1YpuziNMnFlAQUXNfjVhh4AoYxC5Cyc=;
 b=iyVp2qmUW+FkMFS6CvtTvAFrF5QxCgBV2QLthdVFxxQ1/9xfKhxd1Nb6E28gQ8nQswMsc6
 SzxZzyjrJvhg8RMvLvO7X+yXwjDZBgQkmmiXvM7zGSbRHMSrzaCqbl+rPXN4M2Zuhle2V5
 9J06llbIrSoB7AymYRiPV1nw0WykVwY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769526561;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xp7C8NY13Bji1YpuziNMnFlAQUXNfjVhh4AoYxC5Cyc=;
 b=I2W/0+s/oDpzQwf042IPeFZ97pujV8at6aDlRGMpQHqWYl+/I6UZN3slM0/kHQ2Vlqco1V
 dIP1BU94/Yu54QAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F8923EA61;
 Tue, 27 Jan 2026 15:09:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id S1v+Dx/VeGlFbAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 27 Jan 2026 15:09:19 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, armbru@redhat.com, ppandit@redhat.com,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2] migration/options: Fix leaks in StrOrNull qdev accessors
Date: Tue, 27 Jan 2026 12:09:16 -0300
Message-ID: <20260127150916.23329-1-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email,linaro.org:email];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email, imap1.dmz-prg2.suse.org:helo]
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
harmless.

- set_StrOrNull: the visitor should never fail unless there's a
programming error and a property of different type has been passed in.

Change it to only allocate memory after the visit call has returned
successfully.

- get_StrOrNull: the whole of the getter is unused, it's only purpose at
the moment is to provide a complete implementation of the StrOrNull
property. If it were used, it would always receive a non-NULL pointer
because this property is part of s->parameters and always initialized
by the setter.

Assert non-NULL instead of allocating a new object.

Fixes: CID 1643919
Fixes: CID 1643920
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/options.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index 1ffe85a2d8..93d11bba60 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -216,36 +216,36 @@ const size_t migration_properties_count = ARRAY_SIZE(migration_properties);
 static void get_StrOrNull(Object *obj, Visitor *v, const char *name,
                           void *opaque, Error **errp)
 {
-    const Property *prop = opaque;
-    StrOrNull **ptr = object_field_prop_ptr(obj, prop);
+    StrOrNull **ptr = object_field_prop_ptr(obj, opaque);
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
+     * s->parameters and a default value is always set. It should also
+     * never be QNULL as the setter doesn't allow it.
+     */
+    assert(str_or_null && str_or_null->type != QTYPE_QNULL);
     visit_type_str(v, name, &str_or_null->u.s, errp);
 }
 
 static void set_StrOrNull(Object *obj, Visitor *v, const char *name,
                           void *opaque, Error **errp)
 {
-    const Property *prop = opaque;
-    StrOrNull **ptr = object_field_prop_ptr(obj, prop);
-    StrOrNull *str_or_null = g_new0(StrOrNull, 1);
+    StrOrNull **ptr = object_field_prop_ptr(obj, opaque);
+    StrOrNull *str_or_null;
+    char *str;
+
+    if (!visit_type_str(v, name, &str, errp)) {
+        return;
+    }
 
     /*
      * Only str to keep compatibility, QNULL was never used via
      * command line.
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


