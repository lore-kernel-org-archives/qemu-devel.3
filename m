Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 980BEC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 14:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaEUs-0005Gt-QV; Fri, 11 Jul 2025 10:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uaESh-0000pP-7W
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:10:59 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uaESc-0006Vt-Ey
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:10:49 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3061121190;
 Fri, 11 Jul 2025 14:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752243041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l0u6vcmpKguZljP7Odh29cS/hGK5fEOpnoNZOACCmqg=;
 b=BvZwGXZGIjezfKNn4epcUqMB1GUwcwl6IG5hhKFw60MR63IWDulSDvBuRgTXY85RVVVvD8
 w2LFXem8Ak23oB/bbmpmPMhSm8M2vy9+1iRL2AQthBCbuXzTxQ341cj3aL/FT6+MeB9/Og
 7kcJBnHBCpxMY8ThixDus9vG6HuDLL0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752243041;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l0u6vcmpKguZljP7Odh29cS/hGK5fEOpnoNZOACCmqg=;
 b=CJkf6kYxq9nvfIjDoZxOQmpXpZj/1n660pqRQpdgdtekuPe8wH+7rAizDBr5V5n4XNV+fu
 oYvXJB38cf9seEBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BvZwGXZG;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CJkf6kYx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752243041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l0u6vcmpKguZljP7Odh29cS/hGK5fEOpnoNZOACCmqg=;
 b=BvZwGXZGIjezfKNn4epcUqMB1GUwcwl6IG5hhKFw60MR63IWDulSDvBuRgTXY85RVVVvD8
 w2LFXem8Ak23oB/bbmpmPMhSm8M2vy9+1iRL2AQthBCbuXzTxQ341cj3aL/FT6+MeB9/Og
 7kcJBnHBCpxMY8ThixDus9vG6HuDLL0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752243041;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l0u6vcmpKguZljP7Odh29cS/hGK5fEOpnoNZOACCmqg=;
 b=CJkf6kYxq9nvfIjDoZxOQmpXpZj/1n660pqRQpdgdtekuPe8wH+7rAizDBr5V5n4XNV+fu
 oYvXJB38cf9seEBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF99D1388B;
 Fri, 11 Jul 2025 14:10:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YJ+RHl4bcWg7TgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 11 Jul 2025 14:10:38 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, "Dr . David Alan Gilbert" <dave@treblig.org>,
 Alexey Perevalov <a.perevalov@samsung.com>,
 Markus Armbruster <armbru@redhat.com>,
 Mario Casquero <mcasquer@redhat.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 02/26] migration/hmp: Fix postcopy-blocktime per-vCPU results
Date: Fri, 11 Jul 2025 11:10:07 -0300
Message-Id: <20250711141031.423-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250711141031.423-1-farosas@suse.de>
References: <20250711141031.423-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-5.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email,treblig.org:email,samsung.com:email];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[7];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 3061121190
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

Unfortunately, it was never correctly shown..

This is only found when I started to look into making the blocktime feature
more useful (so as to avoid using bpftrace, even though I'm not sure which
one will be harder to use..).

So the old dump would look like this:

  Postcopy vCPU Blocktime: 0-1,4,10,21,33,46,48,59

Even though there're actually 40 vcpus, and the string will merge same
elements and also sort them.

To fix it, simply loop over the uint32List manually.  Now it looks like:

  Postcopy vCPU Blocktime (ms):
   [15, 0, 0, 43, 29, 34, 36, 29, 37, 41,
    33, 37, 45, 52, 50, 38, 40, 37, 40, 49,
    40, 35, 35, 35, 81, 19, 18, 19, 18, 30,
    22, 3, 0, 0, 0, 0, 0, 0, 0, 0]

Cc: Dr. David Alan Gilbert <dave@treblig.org>
Cc: Alexey Perevalov <a.perevalov@samsung.com>
Cc: Markus Armbruster <armbru@redhat.com>
Tested-by: Mario Casquero <mcasquer@redhat.com>
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20250613140801.474264-3-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration-hmp-cmds.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 367ff6037f..867e017b32 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -208,15 +208,19 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
     }
 
     if (info->has_postcopy_vcpu_blocktime) {
-        Visitor *v;
-        char *str;
-        v = string_output_visitor_new(false, &str);
-        visit_type_uint32List(v, NULL, &info->postcopy_vcpu_blocktime,
-                              &error_abort);
-        visit_complete(v, &str);
-        monitor_printf(mon, "Postcopy vCPU Blocktime: %s\n", str);
-        g_free(str);
-        visit_free(v);
+        uint32List *item = info->postcopy_vcpu_blocktime;
+        const char *sep = "";
+        int count = 0;
+
+        monitor_printf(mon, "Postcopy vCPU Blocktime (ms):\n [");
+
+        while (item) {
+            monitor_printf(mon, "%s%"PRIu32, sep, item->value);
+            item = item->next;
+            /* Each line 10 vcpu results, newline if there's more */
+            sep = ((++count % 10 == 0) && item) ? ",\n  " : ", ";
+        }
+        monitor_printf(mon, "]\n");
     }
 
 out:
-- 
2.35.3


