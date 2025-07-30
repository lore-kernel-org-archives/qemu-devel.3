Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF6A7C83F26
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 21:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhE3T-0002MK-1N; Wed, 30 Jul 2025 17:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uhDnK-0005DX-K5
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 16:53:02 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uhDnH-0002L5-Tc
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 16:53:02 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 874A11F7B6;
 Wed, 30 Jul 2025 20:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753908773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N/koInHJHB0Tawbx0b6/y9YWT+/bGQdyeF0S1AcZL7Y=;
 b=KJTag24rdrpL+ljSM2CUMW5auXH/8bvNzr+voa7d2uHE3iwlTvELIvN2wn6GpAKkrFubZP
 7RTCj2eIZx/R3+48lgwUJTjSTJ0rOifNAcx05OeuCtAIVzkaiF2/JoedoTjxAOZ8s+rh4L
 8ivr68u0s3Uu3I6QoVp70szZr1VyLwk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753908773;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N/koInHJHB0Tawbx0b6/y9YWT+/bGQdyeF0S1AcZL7Y=;
 b=ZNlUpHuZX5siscSvdi+WsdvSIxux1N40zvfPhpgQcNd1ru8Kv8oYWqxmwKypDIz7D17tsN
 OTAgVaIfX88WOKCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753908773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N/koInHJHB0Tawbx0b6/y9YWT+/bGQdyeF0S1AcZL7Y=;
 b=KJTag24rdrpL+ljSM2CUMW5auXH/8bvNzr+voa7d2uHE3iwlTvELIvN2wn6GpAKkrFubZP
 7RTCj2eIZx/R3+48lgwUJTjSTJ0rOifNAcx05OeuCtAIVzkaiF2/JoedoTjxAOZ8s+rh4L
 8ivr68u0s3Uu3I6QoVp70szZr1VyLwk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753908773;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N/koInHJHB0Tawbx0b6/y9YWT+/bGQdyeF0S1AcZL7Y=;
 b=ZNlUpHuZX5siscSvdi+WsdvSIxux1N40zvfPhpgQcNd1ru8Kv8oYWqxmwKypDIz7D17tsN
 OTAgVaIfX88WOKCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C317B1388B;
 Wed, 30 Jul 2025 20:52:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EB/iICOGimjhPwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 30 Jul 2025 20:52:51 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH 2/3] tests/qtest/migration: Only test aarch64 on TCG
Date: Wed, 30 Jul 2025 17:52:44 -0300
Message-Id: <20250730205245.2118-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250730205245.2118-1-farosas@suse.de>
References: <20250730205245.2118-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,linaro.org:email]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Currently our aarch64 tests are only being run using identical QEMU
versions. When running the tests with different QEMU versions, which
is a common use-case for migration, the tests are broken due to the
current choice of the 'max' cpu, which is not stable and is prone to
breaking migration.

This means aarch64 tests are currently only testing about the same
situations as any other arch, i.e. no arm-specific testing is being
done.

To make the aarch64 tests more useful, -cpu max will be changed to
-cpu neoverse-n1 in the next patch. Before doing that, make sure
aarch64 tests only run with TCG, since KVM testing depends on usage of
the -cpu host and we currently don't have code to switch between cpus
according to test runtime environment.

Also, TCG alone should allow us to catch most issues with migration,
since there is no guarantee of a uniform environment as there is with
KVM.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/framework.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 407c9023c0..f09365d122 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -353,8 +353,17 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
         memory_backend = g_strdup_printf("-m %s ", memory_size);
     }
 
-    if (args->use_dirty_ring) {
-        kvm_opts = ",dirty-ring-size=4096";
+
+    if (g_str_equal(arch, "aarch64")) {
+        /*
+         * aarch64 is only tested with TCG because there is no single
+         * cpu that can be used for both KVM and TCG.
+         */
+        kvm_opts = NULL;
+    } else if (args->use_dirty_ring) {
+        kvm_opts = "-accel kvm,dirty-ring-size=4096";
+    } else {
+        kvm_opts = "-accel kvm";
     }
 
     if (!qtest_has_machine(machine_alias)) {
@@ -368,7 +377,7 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
 
     g_test_message("Using machine type: %s", machine);
 
-    cmd_source = g_strdup_printf("-accel kvm%s -accel tcg "
+    cmd_source = g_strdup_printf("%s -accel tcg "
                                  "-machine %s,%s "
                                  "-name source,debug-threads=on "
                                  "%s "
@@ -395,7 +404,7 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
      */
     events = args->defer_target_connect ? "-global migration.x-events=on" : "";
 
-    cmd_target = g_strdup_printf("-accel kvm%s -accel tcg "
+    cmd_target = g_strdup_printf("%s -accel tcg "
                                  "-machine %s,%s "
                                  "-name target,debug-threads=on "
                                  "%s "
-- 
2.35.3


