Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E95C02198
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2025 01:36:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tj74l-00045I-R7; Fri, 14 Feb 2025 20:34:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tj2NC-0006wo-HA
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 15:33:18 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tj2NA-0002HU-IA
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 15:33:18 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F411721185;
 Fri, 14 Feb 2025 20:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739565153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NYA9zBGCtEYGOHpxbu7/TjmCh0ZBIIvhAThCX1LXZGo=;
 b=X+cCGXNdhOUbv1nA+oCOTq8MRheZid9Nz81Ymw319C/XfxXel1WC9zk8KZKmkoUkreVFax
 yATPOWnT50OpsiCOMHMedqN66UdGZu0/1q94d34GxEImD2dUozBfcVSaxg4NlnK70wHsmA
 cGXYvaHXkJsV3H5l4VOKWmS6G6C4uWg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739565153;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NYA9zBGCtEYGOHpxbu7/TjmCh0ZBIIvhAThCX1LXZGo=;
 b=E1zdfEmU0ZNasbRr5GjU6Py+8EupFHiCphy4AVcWGS6UDb/pWocKvbxmDWVL8gymoSVSbJ
 ovuf4FxHqkw8VhCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739565153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NYA9zBGCtEYGOHpxbu7/TjmCh0ZBIIvhAThCX1LXZGo=;
 b=X+cCGXNdhOUbv1nA+oCOTq8MRheZid9Nz81Ymw319C/XfxXel1WC9zk8KZKmkoUkreVFax
 yATPOWnT50OpsiCOMHMedqN66UdGZu0/1q94d34GxEImD2dUozBfcVSaxg4NlnK70wHsmA
 cGXYvaHXkJsV3H5l4VOKWmS6G6C4uWg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739565153;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NYA9zBGCtEYGOHpxbu7/TjmCh0ZBIIvhAThCX1LXZGo=;
 b=E1zdfEmU0ZNasbRr5GjU6Py+8EupFHiCphy4AVcWGS6UDb/pWocKvbxmDWVL8gymoSVSbJ
 ovuf4FxHqkw8VhCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E7DD13285;
 Fri, 14 Feb 2025 20:32:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +BcLF1+or2cgEgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 14 Feb 2025 20:32:31 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Markus Armbruster <armbru@redhat.com>
Subject: [PULL 17/22] migration: Update migrate_cancel documentation
Date: Fri, 14 Feb 2025 17:31:54 -0300
Message-Id: <20250214203159.30168-18-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250214203159.30168-1-farosas@suse.de>
References: <20250214203159.30168-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.77 / 50.00]; BAYES_HAM(-2.97)[99.89%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
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

Update the migrate_cancel command documentation with a few words about
postcopy and the expected state of the machine after migration.

Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Message-ID: <20250213175927.19642-10-farosas@suse.de>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 qapi/migration.json | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 43babd1df4..8b9c53595c 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1524,7 +1524,9 @@
 ##
 # @migrate_cancel:
 #
-# Cancel the current executing migration process.
+# Cancel the currently executing migration process.  Allows a new
+# migration to be started right after.  When postcopy-ram is in use,
+# cancelling is not allowed after the postcopy phase has started.
 #
 # .. note:: This command succeeds even if there is no migration
 #    process running.
-- 
2.35.3


