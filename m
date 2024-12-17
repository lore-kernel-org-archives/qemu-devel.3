Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87913E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 17:52:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNbhD-0005tG-Aq; Tue, 17 Dec 2024 12:49:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tNbhC-0005sW-HE; Tue, 17 Dec 2024 12:49:22 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tNbh7-0007fq-LK; Tue, 17 Dec 2024 12:49:22 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 037BC2115D;
 Tue, 17 Dec 2024 17:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734457754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ab54mipHcLAjbnV+jY1cykYiP4rHgV7TsfxNM2xGBFs=;
 b=nbliXO7n23sKNOAmlCKdbC9BXUS6xJNhsy00Gjit1NVQ+Wnz733yEHLDtHC1yIqXE3g+s3
 vfBGbKfuLjhg8XPIQiab1ChogdL06rsrk88zx6qNdy2QYgsR58h++5xo/PkyWYahbLg9qj
 SikR361QJ1152Bzia2wHAE6ZzmhAiO0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734457754;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ab54mipHcLAjbnV+jY1cykYiP4rHgV7TsfxNM2xGBFs=;
 b=uxfaa5+a8tV85EaOJZ+7wGeR8+ZzuuvfUhiz5I9uX7+YFo35JExIpApWr+qk7m+S23ls6H
 8+Mukmw/xuY2o+Bw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734457754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ab54mipHcLAjbnV+jY1cykYiP4rHgV7TsfxNM2xGBFs=;
 b=nbliXO7n23sKNOAmlCKdbC9BXUS6xJNhsy00Gjit1NVQ+Wnz733yEHLDtHC1yIqXE3g+s3
 vfBGbKfuLjhg8XPIQiab1ChogdL06rsrk88zx6qNdy2QYgsR58h++5xo/PkyWYahbLg9qj
 SikR361QJ1152Bzia2wHAE6ZzmhAiO0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734457754;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ab54mipHcLAjbnV+jY1cykYiP4rHgV7TsfxNM2xGBFs=;
 b=uxfaa5+a8tV85EaOJZ+7wGeR8+ZzuuvfUhiz5I9uX7+YFo35JExIpApWr+qk7m+S23ls6H
 8+Mukmw/xuY2o+Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 50D5D13A3C;
 Tue, 17 Dec 2024 17:49:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SAfEBZi5YWd1TwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Dec 2024 17:49:12 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>
Subject: [PULL 10/17] s390x: Fix CSS migration
Date: Tue, 17 Dec 2024 14:48:48 -0300
Message-Id: <20241217174855.24971-11-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241217174855.24971-1-farosas@suse.de>
References: <20241217174855.24971-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Commit a55ae46683 ("s390: move css_migration_enabled from machine to
css.c") disabled CSS migration globally instead of doing it
per-instance.

CC: Paolo Bonzini <pbonzini@redhat.com>
CC: qemu-stable@nongnu.org #9.1
Fixes: a55ae46683 ("s390: move css_migration_enabled from machine to css.c")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2704
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Message-Id: <20241213160120.23880-3-farosas@suse.de>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 hw/s390x/s390-virtio-ccw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 67ae34aead..4db73fc6f2 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -1201,6 +1201,7 @@ static void ccw_machine_2_9_instance_options(MachineState *machine)
     s390_cpudef_featoff_greater(12, 1, S390_FEAT_ZPCI);
     s390_cpudef_featoff_greater(12, 1, S390_FEAT_ADAPTER_INT_SUPPRESSION);
     s390_cpudef_featoff_greater(12, 1, S390_FEAT_ADAPTER_EVENT_NOTIFICATION);
+    css_migration_enabled = false;
 }
 
 static void ccw_machine_2_9_class_options(MachineClass *mc)
@@ -1213,7 +1214,6 @@ static void ccw_machine_2_9_class_options(MachineClass *mc)
     ccw_machine_2_10_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_2_9, hw_compat_2_9_len);
     compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
-    css_migration_enabled = false;
 }
 DEFINE_CCW_MACHINE(2, 9);
 
-- 
2.35.3


