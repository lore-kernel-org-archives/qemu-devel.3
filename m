Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B8A2C02193
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 16:10:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdAXL-0005A1-2Z; Wed, 29 Jan 2025 11:03:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAVg-0003JI-VD
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:01:52 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAVf-0005JN-3U
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:01:48 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 71DC51F387;
 Wed, 29 Jan 2025 16:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xdSdoaTnEZBeOXOT/uml7tEuGdrxBNGOwAicTO6KJd8=;
 b=rDJtvjsNDjdxYON2CSg2ydVP9HBKdzDou8SFGRCiyNePaFMKCipySdRfUiJC09aERr0xbt
 kptWWy/N4AQ+g+8W+N2uAoQMbxol8Hsu5Ebb0V94hg6e9mSp2w/IcMA5waOuT2QpET+yF5
 yDZxEtVN7X3DA90B1v6hcRG2jiw1+vI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166504;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xdSdoaTnEZBeOXOT/uml7tEuGdrxBNGOwAicTO6KJd8=;
 b=dz1vxBPzTuoeIzo/OQpp1cn1OwECphr6T82IyGVAeLf0uuA+Xa2JqUjaaCpxoDpTpOgYWM
 hYANWoPhadpyVJCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xdSdoaTnEZBeOXOT/uml7tEuGdrxBNGOwAicTO6KJd8=;
 b=rDJtvjsNDjdxYON2CSg2ydVP9HBKdzDou8SFGRCiyNePaFMKCipySdRfUiJC09aERr0xbt
 kptWWy/N4AQ+g+8W+N2uAoQMbxol8Hsu5Ebb0V94hg6e9mSp2w/IcMA5waOuT2QpET+yF5
 yDZxEtVN7X3DA90B1v6hcRG2jiw1+vI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166504;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xdSdoaTnEZBeOXOT/uml7tEuGdrxBNGOwAicTO6KJd8=;
 b=dz1vxBPzTuoeIzo/OQpp1cn1OwECphr6T82IyGVAeLf0uuA+Xa2JqUjaaCpxoDpTpOgYWM
 hYANWoPhadpyVJCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2DEE2137DB;
 Wed, 29 Jan 2025 16:01:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sK/+N+ZQmmffPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 29 Jan 2025 16:01:42 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 19/42] tests/qtest: optimize migrate_set_ports
Date: Wed, 29 Jan 2025 13:00:36 -0300
Message-Id: <20250129160059.6987-20-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250129160059.6987-1-farosas@suse.de>
References: <20250129160059.6987-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,suse.de:email,suse.de:mid];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Steve Sistare <steven.sistare@oracle.com>

Do not query connection parameters if all port numbers are known.  This is
more efficient, and also solves a problem for the cpr-transfer test.
At the point where cpr-transfer calls migrate_qmp and migrate_set_ports,
the monitor is not connected and queries are not allowed.  Port=0 is
never used for cpr-transfer.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/1736967650-129648-19-git-send-email-steven.sistare@oracle.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/migration-util.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/tests/qtest/migration/migration-util.c b/tests/qtest/migration/migration-util.c
index 526bed74ea..0ce1413b6c 100644
--- a/tests/qtest/migration/migration-util.c
+++ b/tests/qtest/migration/migration-util.c
@@ -135,25 +135,32 @@ migrate_get_connect_qdict(QTestState *who)
 
 void migrate_set_ports(QTestState *to, QList *channel_list)
 {
-    QDict *addr;
+    g_autoptr(QDict) addr = NULL;
     QListEntry *entry;
     const char *addr_port = NULL;
 
-    addr = migrate_get_connect_qdict(to);
-
     QLIST_FOREACH_ENTRY(channel_list, entry) {
         QDict *channel = qobject_to(QDict, qlist_entry_obj(entry));
         QDict *addrdict = qdict_get_qdict(channel, "addr");
 
-        if (qdict_haskey(addrdict, "port") &&
-            qdict_haskey(addr, "port") &&
-            (strcmp(qdict_get_str(addrdict, "port"), "0") == 0)) {
+        if (!qdict_haskey(addrdict, "port") ||
+            strcmp(qdict_get_str(addrdict, "port"), "0")) {
+            continue;
+        }
+
+        /*
+         * Fetch addr only if needed, so tests that are not yet connected to
+         * the monitor do not query it.  Such tests cannot use port=0.
+         */
+        if (!addr) {
+            addr = migrate_get_connect_qdict(to);
+        }
+
+        if (qdict_haskey(addr, "port")) {
             addr_port = qdict_get_str(addr, "port");
             qdict_put_str(addrdict, "port", addr_port);
         }
     }
-
-    qobject_unref(addr);
 }
 
 bool migrate_watch_for_events(QTestState *who, const char *name,
-- 
2.35.3


