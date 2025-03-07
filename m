Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DAF1C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 13:59:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqXyC-000069-Qw; Fri, 07 Mar 2025 08:42:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tqXy9-00005O-6u
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 08:42:31 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tqXy7-0006k2-Hi
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 08:42:28 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 711032116B;
 Fri,  7 Mar 2025 13:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741354932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kSFMKV2+l6+plMuEClTWNa7x/CpsdYIayUOc/rnDJP0=;
 b=J1cNW2evLWnAok7g1O1aT51cFt9LPDvncy4qWgwEZBzTKFDs/qehJrWK5pUwbOKSsxHzop
 fHl7Ylqs4kVsejWIps5YHt6OhEZWAU3KMjwLiVfWbhy/FOUH5WClTMoFAe0aHkYpfwYBtd
 FsXeeIBkv+ZFdyIUYWfwlbphDtGjV7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741354932;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kSFMKV2+l6+plMuEClTWNa7x/CpsdYIayUOc/rnDJP0=;
 b=QXtde9NT0NNtDld0qrZ5CjL3/QTmfV9JlQgRk/mPxIVi0A//sEdpB/fJEQQtQpqkNiPFmc
 7qIDwS3YmGDWPeBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=J1cNW2ev;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=QXtde9NT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741354932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kSFMKV2+l6+plMuEClTWNa7x/CpsdYIayUOc/rnDJP0=;
 b=J1cNW2evLWnAok7g1O1aT51cFt9LPDvncy4qWgwEZBzTKFDs/qehJrWK5pUwbOKSsxHzop
 fHl7Ylqs4kVsejWIps5YHt6OhEZWAU3KMjwLiVfWbhy/FOUH5WClTMoFAe0aHkYpfwYBtd
 FsXeeIBkv+ZFdyIUYWfwlbphDtGjV7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741354932;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kSFMKV2+l6+plMuEClTWNa7x/CpsdYIayUOc/rnDJP0=;
 b=QXtde9NT0NNtDld0qrZ5CjL3/QTmfV9JlQgRk/mPxIVi0A//sEdpB/fJEQQtQpqkNiPFmc
 7qIDwS3YmGDWPeBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF91E13A22;
 Fri,  7 Mar 2025 13:42:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yFtUHrL3ymfJHAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 07 Mar 2025 13:42:10 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 2/2] migration: Move compression docs under multifd
Date: Fri,  7 Mar 2025 10:42:03 -0300
Message-Id: <20250307134203.29443-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250307134203.29443-1-farosas@suse.de>
References: <20250307134203.29443-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 711032116B
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]; ARC_NA(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 DKIM_TRACE(0.00)[suse.de:+]
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

The current migration compression documentation applies only to
multifd. Now that we have a multifd section, move the compression
documentation under it.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 docs/devel/migration/features.rst |  3 ---
 docs/devel/migration/multifd.rst  | 10 ++++++++++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/docs/devel/migration/features.rst b/docs/devel/migration/features.rst
index 249d653124..dc59278aa7 100644
--- a/docs/devel/migration/features.rst
+++ b/docs/devel/migration/features.rst
@@ -12,7 +12,4 @@ Migration has plenty of features to support different use cases.
    virtio
    mapped-ram
    CPR
-   qpl-compression
-   uadk-compression
-   qatzip-compression
    multifd
diff --git a/docs/devel/migration/multifd.rst b/docs/devel/migration/multifd.rst
index 8f5ec840cb..5238b79055 100644
--- a/docs/devel/migration/multifd.rst
+++ b/docs/devel/migration/multifd.rst
@@ -216,6 +216,16 @@ or to disable zero page detection completely:
 
     ``migrate_set_parameter zero-page-detection none``
 
+Compression
++++++++++++
+
+.. toctree::
+   :maxdepth: 1
+
+   qpl-compression
+   uadk-compression
+   qatzip-compression
+
 Error handling
 --------------
 
-- 
2.35.3


