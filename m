Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD281C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 00:04:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Gdf-0004Oi-AP; Mon, 14 Sep 2026 20:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x6Gda-00047U-Dq
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:03:02 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x6GdY-0004qk-NH
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:03:02 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 51DE61FF46;
 Tue, 15 Sep 2026 00:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789430575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RWLyAQI8rH4KCZ+XK+8nFWATteNCHFMVIwTcysQXND0=;
 b=gKICXjpRM5aUgubv1hymlVXBGrfVAt7NXCKsJSMO2FdyB+VGlE3nuUdbQHIYIZA8daXYkL
 inHhsDq4IpxJtmaxiUvFWVZFOYLAB22vgGYpMe7yWh3n+rOTz3LYUXiS2hHoZbdBVwiAeS
 eRR89rjkVEwMoxFx4PwKqsPpKBd0yI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789430575;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RWLyAQI8rH4KCZ+XK+8nFWATteNCHFMVIwTcysQXND0=;
 b=Rc3jjmsun/09i2nO489KWer6ezkPNZdeFkkKrtBDS8+RCvwbGe9CVOYXFlF3Is4AGcs1ng
 QagXl8OTpBapv2Bg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GxUzBIKm;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ASPjE1Qf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789430571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RWLyAQI8rH4KCZ+XK+8nFWATteNCHFMVIwTcysQXND0=;
 b=GxUzBIKmeJYjkIWy2GHz8znT13OKUW5Ny81C2qLsvn8NpU+lQb7x1h+hHKzXlDrYSv7FrY
 5DNRzMfRf83LMv8mOO+D/DJtKTJ8wlsdBHfWz2aiB66Y5bEytXsrv5GVaaoBIYb3FkcZey
 zW+rd/EnOpt1xZsEsMs1tSVxj5GXsRU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789430571;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RWLyAQI8rH4KCZ+XK+8nFWATteNCHFMVIwTcysQXND0=;
 b=ASPjE1QfO3i5Ks+wHAl7K/eyqJHnt/T/TPbgfjyQfJn9WSXgOfYO6QzzoAHCzsa/1FLh9U
 VFBR/WGftNTdq7Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF15213710;
 Tue, 15 Sep 2026 00:02:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Gk6xFQeLqGqIFAAAD6G6ig:T21
 (envelope-from <farosas@suse.de>); Tue, 15 Sep 2026 00:02:49 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH v3 20/20] qapi: Remove MigrationParameter
Date: Mon, 14 Sep 2026 21:02:08 -0300
Message-ID: <20260915000209.3692668-21-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915000209.3692668-1-farosas@suse.de>
References: <20260915000209.3692668-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 51DE61FF46
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email,suse.de:mid];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

The MigrationParameter enum is now unused, remove it.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 qapi/migration.json | 43 -------------------------------------------
 1 file changed, 43 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index b303e91456..9f3b9b718d 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -808,49 +808,6 @@
       'bitmaps': [ 'BitmapMigrationBitmapAlias' ]
   } }
 
-##
-# @MigrationParameter:
-#
-# Migration parameters enumeration.  The enumeration values mirror the
-# members of @MigrationParameters.
-#
-# Features:
-#
-# @unstable: Members @x-checkpoint-delay, @x-rdma-chunk-size, and
-#     @x-vcpu-dirty-limit-period are experimental.
-#
-# Since: 2.4
-##
-{ 'enum': 'MigrationParameter',
-  'data': ['announce-initial', 'announce-max',
-           'announce-rounds', 'announce-step',
-           'throttle-trigger-threshold',
-           'cpu-throttle-initial', 'cpu-throttle-increment',
-           'cpu-throttle-tailslow',
-           'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
-           'avail-switchover-bandwidth', 'downtime-limit',
-           { 'name': 'x-checkpoint-delay', 'features': [ 'unstable' ] },
-           'multifd-channels',
-           'xbzrle-cache-size', 'max-postcopy-bandwidth',
-           'max-cpu-throttle', 'multifd-compression',
-           'multifd-zlib-level', 'multifd-zstd-level',
-           'multifd-qatzip-level',
-           'block-bitmap-mapping',
-           { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] },
-           'vcpu-dirty-limit',
-           'mode',
-           'zero-page-detection',
-           'direct-io',
-           { 'name': 'x-rdma-chunk-size', 'features': [ 'unstable' ] },
-           'cpr-exec-command',
-           'local', 'xbzrle', 'rdma-pin-all', 'auto-converge', 'events',
-           'postcopy-ram', 'x-colo', 'release-ram', 'return-path',
-           'pause-before-switchover', 'multifd', 'dirty-bitmaps',
-           'postcopy-blocktime', 'late-block-activate', 'x-ignore-shared',
-           'validate-uuid', 'background-snapshot', 'zero-copy-send',
-           'postcopy-preempt', 'switchover-ack', 'dirty-limit',
-           'mapped-ram'] }
-
 ##
 # @migrate-set-parameters:
 #
-- 
2.53.0


