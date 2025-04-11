Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B322C369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 19:16:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3Jqf-0004Ef-Q8; Fri, 11 Apr 2025 15:15:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u3JqL-0003yI-Tn
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 15:15:24 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u3JqG-0006AR-Oe
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 15:15:11 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E82BD21195;
 Fri, 11 Apr 2025 19:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744398895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3tIyrgfRRtKoSyhqRZyFijGoBLABFttNkQx5rn3jGRQ=;
 b=bKGeDgXfHxBbZpfI8XvTSseFfcEEAYi3tuM2web9vKOhE2FPKhvUyaT/m9YsjOh7BU2inX
 IEHwKo19D4ILqKnWucbUDUQAQZDOGTeJdWcsMEAc8RuT68SIw5XmjL/5R8kx2yb7Ts4WYJ
 SnuOlTUeeg6IQlP6CXN78vcV6ZnixHY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744398896;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3tIyrgfRRtKoSyhqRZyFijGoBLABFttNkQx5rn3jGRQ=;
 b=1TjBOuaOC6BhKpqPSj7B4+YKVUhb7owiBgls6OF6ls4dcRIi5+oz0s2oDUk7NNsXtAhpAP
 L++hZTYFf5z5YcCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744398895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3tIyrgfRRtKoSyhqRZyFijGoBLABFttNkQx5rn3jGRQ=;
 b=bKGeDgXfHxBbZpfI8XvTSseFfcEEAYi3tuM2web9vKOhE2FPKhvUyaT/m9YsjOh7BU2inX
 IEHwKo19D4ILqKnWucbUDUQAQZDOGTeJdWcsMEAc8RuT68SIw5XmjL/5R8kx2yb7Ts4WYJ
 SnuOlTUeeg6IQlP6CXN78vcV6ZnixHY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744398895;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3tIyrgfRRtKoSyhqRZyFijGoBLABFttNkQx5rn3jGRQ=;
 b=qrE7lDGTx9H5ElvAfYRHWFGtBkBtjwmUfpOfa9VOD9UiTfoaFKrkTYMB7dGSinPqwdrqfA
 mCM0b1HKVJBqAOBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 610EC13886;
 Fri, 11 Apr 2025 19:14:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mHP/CC5q+We5WQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 11 Apr 2025 19:14:54 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [RFC PATCH 04/13] migration: Fix parameter validation
Date: Fri, 11 Apr 2025 16:14:34 -0300
Message-Id: <20250411191443.22565-5-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250411191443.22565-1-farosas@suse.de>
References: <20250411191443.22565-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
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

The migration parameters validation involves producing a temporary
structure which merges the current parameter values with the new
parameters set by the user.

The has_ boolean fields of MigrateSetParameter are taken into
consideration when writing the temporary structure, however the copy
of the current parameters also copies all the has_ fields of
s->parameters and those are (almost) all true due to being initialized
by migrate_params_init().

Since the temporary structure copy does not carry over the has_ fields
from MigrateSetParameters, only the values which were initialized in
migrate_params_init() will end up being validated. This causes
(almost) all of the migration parameters to be validated again every
time a parameter is set, which could be considered a bug. But it also
skips validation of those values which are not set in
migrate_params_init(), which is a worse issue.

Fix by initializing the missing values in migrate_params_init().
Currently 'avail_switchover_bandwidth' and 'block_bitmap_mapping' are
affected.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/options.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/migration/options.c b/migration/options.c
index cac28540dd..625d597a85 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -987,6 +987,8 @@ void migrate_params_init(MigrationParameters *params)
     params->has_mode = true;
     params->has_zero_page_detection = true;
     params->has_direct_io = true;
+    params->has_avail_switchover_bandwidth = true;
+    params->has_block_bitmap_mapping = true;
 }
 
 /*
-- 
2.35.3


