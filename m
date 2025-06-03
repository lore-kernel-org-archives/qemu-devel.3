Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76EE8C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 01:41:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMGcG-0006iu-FJ; Mon, 02 Jun 2025 21:39:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uMGcF-0006iX-4P
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 21:38:59 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uMGcD-0001XC-D6
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 21:38:58 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5B662218E8;
 Tue,  3 Jun 2025 01:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748914727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZsEmCZqcH0pwNdi8IcQf5V3H0fZ9OGiuoI7A9Iypbfg=;
 b=p2l0hWfRPtQPVGgq2dMmmiEpkGeiIndXqU9uWJxzxkce7Xl2ff9MeG3mcyKFMaRIbnHq2p
 692iW+LzIjwNlIUObddVLEFHdIWcbh9ZhjGSgM0giagY87QAAHsX5lgVPQBTziVggIsRGa
 yZl5Jw8FxORSXqIgLqRPC67hc3Y2jMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748914727;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZsEmCZqcH0pwNdi8IcQf5V3H0fZ9OGiuoI7A9Iypbfg=;
 b=3rcLASNSo6rD+bPSADbocD6fneXlVQZa3cEJBUh9rvUxtZDEZqky3//h8aoEbsz/Eckfwp
 Q1cstTLJ0YRy1aDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=p2l0hWfR;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3rcLASNS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748914727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZsEmCZqcH0pwNdi8IcQf5V3H0fZ9OGiuoI7A9Iypbfg=;
 b=p2l0hWfRPtQPVGgq2dMmmiEpkGeiIndXqU9uWJxzxkce7Xl2ff9MeG3mcyKFMaRIbnHq2p
 692iW+LzIjwNlIUObddVLEFHdIWcbh9ZhjGSgM0giagY87QAAHsX5lgVPQBTziVggIsRGa
 yZl5Jw8FxORSXqIgLqRPC67hc3Y2jMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748914727;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZsEmCZqcH0pwNdi8IcQf5V3H0fZ9OGiuoI7A9Iypbfg=;
 b=3rcLASNSo6rD+bPSADbocD6fneXlVQZa3cEJBUh9rvUxtZDEZqky3//h8aoEbsz/Eckfwp
 Q1cstTLJ0YRy1aDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CEBBD13700;
 Tue,  3 Jun 2025 01:38:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4E52IyVSPmiNLwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 03 Jun 2025 01:38:45 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 16/21] qapi/migration: Mark that query/set-migrate-parameters
 support capabilities
Date: Mon,  2 Jun 2025 22:38:05 -0300
Message-Id: <20250603013810.4772-17-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250603013810.4772-1-farosas@suse.de>
References: <20250603013810.4772-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.98%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 5B662218E8
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

Add a QAPI command feature "capabilities" that can be queried by the
client to check that the parameters commands now also support
capabilities.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 qapi/migration.json | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 5942622ba7..557a9c523e 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -776,6 +776,13 @@
 #
 # Set various migration parameters.
 #
+# Features:
+#
+# @capabilities: Indicates this command supports setting the set of
+# parameters previously known as capabilities.  This means this
+# command can (and should) be used instead of the depreacated
+# @migrate-set-capabilities.
+#
 # Since: 2.4
 #
 # .. qmp-example::
@@ -785,7 +792,8 @@
 #     <- { "return": {} }
 ##
 { 'command': 'migrate-set-parameters', 'boxed': true,
-  'data': 'MigrationParameters' }
+  'data': 'MigrationParameters',
+  'features': [ 'capabilities' ] }
 
 ##
 # @MigrationParameters:
@@ -1110,6 +1118,13 @@
 #
 # Returns: @MigrationParameters
 #
+# Features:
+#
+# @capabilities: Indicates this command supports setting the set of
+# parameters previously known as capabilities.  This means this
+# command can (and should) be used instead of the depreacated
+# @migrate-set-capabilities.
+#
 # Since: 2.4
 #
 # .. qmp-example::
@@ -1125,7 +1140,8 @@
 #        }
 ##
 { 'command': 'query-migrate-parameters',
-  'returns': 'MigrationParameters' }
+  'returns': 'MigrationParameters',
+  'features': [ 'capabilities' ] }
 
 ##
 # @migrate-start-postcopy:
-- 
2.35.3


