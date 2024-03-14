Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8624C54E60
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 21:39:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rksm8-0001p5-MA; Thu, 14 Mar 2024 17:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>)
 id 1rksm5-0001ol-Am; Thu, 14 Mar 2024 17:38:05 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>)
 id 1rksm3-0007w5-MS; Thu, 14 Mar 2024 17:38:05 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4BB9121D63;
 Thu, 14 Mar 2024 21:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710452281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=pP4betEpGnM5MgnyQWCVs9+190M4LeW8zXrFd8S/FwE=;
 b=fIR47HO7DE3rFXfY19GA0UTDEsGfZtcL3+A+sy0S1DXraZeESZCukRrBE4sn20QbpT48MG
 fhFyyyNsB4E4UZz7/pdkzFuszMoXwSHeCPQUxh6RvxJ+86GR+tLDgAgK1ST+lhHnjCrHLI
 Dj8ZUU9C3mRiGFQcVwnQMAJYURqYeFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710452281;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=pP4betEpGnM5MgnyQWCVs9+190M4LeW8zXrFd8S/FwE=;
 b=CPN6wgHl737CkLaT5iVE05sKPoJ10EHoZfcEFKFLW2bHG8xOxf/2QOxs4HMKM6V1sqvQf2
 K5Dbygyq1X8iwyCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710452281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=pP4betEpGnM5MgnyQWCVs9+190M4LeW8zXrFd8S/FwE=;
 b=fIR47HO7DE3rFXfY19GA0UTDEsGfZtcL3+A+sy0S1DXraZeESZCukRrBE4sn20QbpT48MG
 fhFyyyNsB4E4UZz7/pdkzFuszMoXwSHeCPQUxh6RvxJ+86GR+tLDgAgK1ST+lhHnjCrHLI
 Dj8ZUU9C3mRiGFQcVwnQMAJYURqYeFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710452281;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=pP4betEpGnM5MgnyQWCVs9+190M4LeW8zXrFd8S/FwE=;
 b=CPN6wgHl737CkLaT5iVE05sKPoJ10EHoZfcEFKFLW2bHG8xOxf/2QOxs4HMKM6V1sqvQf2
 K5Dbygyq1X8iwyCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A5CCE1368B;
 Thu, 14 Mar 2024 21:38:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 71NoJDhu82XcGQAAD6G6ig
 (envelope-from <cfontana@suse.de>); Thu, 14 Mar 2024 21:38:00 +0000
From: Claudio Fontana <cfontana@suse.de>
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>, Thomas Huth <thuth@redhat.com>
Cc: Claudio Fontana <cfontana@suse.de>, qemu-devel <qemu-devel@nongnu.org>,
 qemu-s390x <qemu-s390x@nongnu.org>, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2] target/s390x: improve cpu compatibility check error message
Date: Thu, 14 Mar 2024 22:37:46 +0100
Message-Id: <20240314213746.27163-1-cfontana@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.70 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 RCPT_COUNT_FIVE(0.00)[6]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
Authentication-Results: smtp-out1.suse.de;
	none
Received-SPF: pass client-ip=195.135.223.130; envelope-from=cfontana@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

some users were confused by this message showing under TCG:

Selected CPU generation is too new. Maximum supported model
in the configuration: 'xyz'

Clarify that the maximum can depend on the accel, and add a
hint to try a different one.

Also add a hint for features mismatch to suggest trying
different accel, QEMU and kernel versions.

Signed-off-by: Claudio Fontana <cfontana@suse.de>
---
 target/s390x/cpu_models.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 1a1c096122..8ed3bb6a27 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -500,6 +500,16 @@ static void error_prepend_missing_feat(const char *name, void *opaque)
     error_prepend((Error **) opaque, "%s ", name);
 }
 
+static void check_compat_model_failed(Error **errp,
+                                      const S390CPUModel *max_model,
+                                      const char *msg)
+{
+    error_setg(errp, "%s. Maximum supported model in the current configuration: \'%s\'",
+               msg, max_model->def->name);
+    error_append_hint(errp, "Consider a different accelerator, try \"-accel help\"\n");
+    return;
+}
+
 static void check_compatibility(const S390CPUModel *max_model,
                                 const S390CPUModel *model, Error **errp)
 {
@@ -507,15 +517,11 @@ static void check_compatibility(const S390CPUModel *max_model,
     S390FeatBitmap missing;
 
     if (model->def->gen > max_model->def->gen) {
-        error_setg(errp, "Selected CPU generation is too new. Maximum "
-                   "supported model in the configuration: \'%s\'",
-                   max_model->def->name);
+        check_compat_model_failed(errp, max_model, "Selected CPU generation is too new");
         return;
     } else if (model->def->gen == max_model->def->gen &&
                model->def->ec_ga > max_model->def->ec_ga) {
-        error_setg(errp, "Selected CPU GA level is too new. Maximum "
-                   "supported model in the configuration: \'%s\'",
-                   max_model->def->name);
+        check_compat_model_failed(errp, max_model, "Selected CPU GA level is too new");
         return;
     }
 
@@ -537,7 +543,9 @@ static void check_compatibility(const S390CPUModel *max_model,
     error_setg(errp, " ");
     s390_feat_bitmap_to_ascii(missing, errp, error_prepend_missing_feat);
     error_prepend(errp, "Some features requested in the CPU model are not "
-                  "available in the configuration: ");
+                  "available in the current configuration: ");
+    error_append_hint(errp,
+                      "Consider a different accelerator, QEMU, or kernel version\n");
 }
 
 S390CPUModel *get_max_cpu_model(Error **errp)
-- 
2.26.2


