Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D89C61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 22:17:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1tFv-0000vb-RN; Wed, 02 Sep 2026 18:16:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x1tFu-0000v0-EE
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 18:16:30 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x1tFr-0002Nt-Mf
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 18:16:30 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 454B31F8B0;
 Wed,  2 Sep 2026 22:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788387382; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p0pVrT4YFXzQmFQwbGKMWn4S5JMORyy3+9+74k8tjWk=;
 b=ijxNbEbtAUL54ofHjx1wvCjR/95I9RCGw5eLleZ0r7a8huHnICGCW2RjQ8cL4skmlygunm
 c6b1n0eLn43FRmxTNfcZnKR4eOA//K9gec1Rff0IrufkAVVD7bM5I4Oo+IcJxp+LaV7wfb
 LpK4eITYBRhNrXiEmjCYaR++zWY+4P8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788387382;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p0pVrT4YFXzQmFQwbGKMWn4S5JMORyy3+9+74k8tjWk=;
 b=kUwK2l2DbmJyhdNZfen0+t26shbqjGmCTeZqB918yEgMTYvOb1NadMTiHCTrBaOsuJnf/c
 Qbjprg7okD3wExAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dzT7Dz8C;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=VxhKYfo3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788387378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p0pVrT4YFXzQmFQwbGKMWn4S5JMORyy3+9+74k8tjWk=;
 b=dzT7Dz8CmdZdHbk2nVVWtAvPnyxOzU8AlLOF/LNbuxkdf728iuUoRi6jPzNm1YnEXj0jJJ
 fEMaxaioa/6dE79OqyaT9aZ+J1pXx/g3lBB9GZHukWS2D0sdKF/tSWw/UxPv+w/G9wG0tk
 meEX4CRWgFh1st8xabjlgtm0eXyH1Bg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788387378;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p0pVrT4YFXzQmFQwbGKMWn4S5JMORyy3+9+74k8tjWk=;
 b=VxhKYfo3ureXUriyaawD28IHTNOtpQidNCnJ0MnCMu0anc8Y7XI8A6WV7hOEEra3NIoGmK
 HggQfiwWmGe+lNAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 681BF13738;
 Wed,  2 Sep 2026 22:16:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wL9sDjGgmGpxXwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 02 Sep 2026 22:16:17 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PATCH 10/18] migration: Validate that all params are set for query
Date: Wed,  2 Sep 2026 19:15:38 -0300
Message-ID: <20260902221547.1812481-11-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902221547.1812481-1-farosas@suse.de>
References: <20260902221547.1812481-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 454B31F8B0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.de:+]
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

There are a couple of situations where all fields of a
MigrationParameters object need to be marked as present: when cloning
an entire object and when creating the transient object in
qmp_query_migrate(). The query-migrate-parameters QMP command contract
requires that all parameters, except block-bitmap-mapping, are present
in the output.

Validate that a given object has all has_* fields set to true.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/options.c | 54 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/migration/options.c b/migration/options.c
index bd7be8f9832..5d17acdd881 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -12,6 +12,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qemu/units.h"
 #include "exec/target_page.h"
@@ -23,8 +24,10 @@
 #include "qapi/qmp/qerror.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qobject-output-visitor.h"
+#include "qobject/qbool.h"
 #include "qobject/qdict.h"
 #include "qobject/qnull.h"
+#include "qobject/qstring.h"
 #include "system/runstate.h"
 #include "migration/colo.h"
 #include "migration/cpr.h"
@@ -1149,12 +1152,63 @@ static void migrate_mark_all_params_present(MigrationParameters *p)
     }
 }
 
+static bool assert_all_params_present(MigrationParameters *params, Error **errp)
+{
+    g_autoptr(QDict) d = migrate_params_to_dict(params, errp);
+    const QDictEntry *e = NULL;
+    int i = 0;
+
+    if (!d) {
+        return false;
+    }
+
+    for (e = qdict_first(d); e; e = qdict_next(d, e), i++) {
+        const char *key = qdict_entry_key(e);
+        const char *p;
+
+        if (strstart(key, "tls-", &p)) {
+            QString *s = qobject_to(QString, qdict_entry_value(e));
+
+            if (!s) {
+                break;
+            }
+        } else if (strstart(key, "has-", &p)) {
+            if (qdict_haskey(d, p)) {
+                QBool *b = qobject_to(QBool, qdict_entry_value(e));
+
+                if (!b || !qbool_get_bool(b)) {
+                    break;
+                }
+            }
+        }
+    }
+
+    if (i && !e) {
+        return true;
+    }
+
+    /*
+     * Should never happen, but avoid asserting becase this is
+     * reachable from QMP.
+     */
+    error_setg(errp, "Missing parameter. Query output will be incomplete.");
+    return false;
+}
+
 MigrationParameters *qmp_query_migrate_parameters(Error **errp)
 {
     MigrationState *s = migrate_get_current();
     MigrationParameters *params = QAPI_CLONE(MigrationParameters,
                                              &s->parameters);
 
+    /*
+     * Validate all parameters have their has_* field set to true as
+     * consequence of the initial migrate_mark_all_params_present().
+     */
+    if (!assert_all_params_present(params, errp)) {
+        return NULL;
+    }
+
     /*
      * The block-bitmap-mapping breaks the expected API of
      * query-migrate-parameters of having all members present. To keep
-- 
2.53.0


