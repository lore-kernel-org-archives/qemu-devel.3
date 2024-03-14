Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28119C54E5D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 19:01:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkqJc-0000yw-5v; Thu, 14 Mar 2024 15:00:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>)
 id 1rkqJM-0000uh-Pj; Thu, 14 Mar 2024 15:00:17 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>)
 id 1rkqJJ-0001C0-U8; Thu, 14 Mar 2024 15:00:15 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 785C721D46;
 Thu, 14 Mar 2024 19:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710442811; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=eYSu5daNDS+3wATpN1Xe4U4YgTJkyNGcLEklzWZKnUo=;
 b=1Gf9O/qLujahz7NAnp639SX0t9yyPzEJGzKOVExyVZfVbBT5Kz9STpTAS3mkifIXbG00B5
 F/Zuxxka93rEI86hl2uw8CrbWWH2CeiK8Al2HOeDqP/OtfF1tZpwV7PdYKaoCBeP44WDfe
 +SRyz6hKLxKK4EhM+YvBOuOFqVhOnbM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710442811;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=eYSu5daNDS+3wATpN1Xe4U4YgTJkyNGcLEklzWZKnUo=;
 b=9TDV30FNTSv9hVJ7Bh0hQ1iC0r4tM+mgTuEYmPLBbYrSIikh67WtzHTjMnBoYI6KUNCqqw
 nw10IdHYG/UYySAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710442811; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=eYSu5daNDS+3wATpN1Xe4U4YgTJkyNGcLEklzWZKnUo=;
 b=1Gf9O/qLujahz7NAnp639SX0t9yyPzEJGzKOVExyVZfVbBT5Kz9STpTAS3mkifIXbG00B5
 F/Zuxxka93rEI86hl2uw8CrbWWH2CeiK8Al2HOeDqP/OtfF1tZpwV7PdYKaoCBeP44WDfe
 +SRyz6hKLxKK4EhM+YvBOuOFqVhOnbM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710442811;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=eYSu5daNDS+3wATpN1Xe4U4YgTJkyNGcLEklzWZKnUo=;
 b=9TDV30FNTSv9hVJ7Bh0hQ1iC0r4tM+mgTuEYmPLBbYrSIikh67WtzHTjMnBoYI6KUNCqqw
 nw10IdHYG/UYySAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 05C9F1368C;
 Thu, 14 Mar 2024 19:00:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6mYuOjpJ82WAbQAAD6G6ig
 (envelope-from <cfontana@suse.de>); Thu, 14 Mar 2024 19:00:10 +0000
From: Claudio Fontana <cfontana@suse.de>
To: Thomas Huth <thuth@redhat.com>, Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Cc: Claudio Fontana <cfontana@suse.de>, qemu-devel <qemu-devel@nongnu.org>,
 qemu-s390x <qemu-s390x@nongnu.org>, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH] target/s390x: improve cpu compatibility check error message
Date: Thu, 14 Mar 2024 20:00:07 +0100
Message-Id: <20240314190007.19568-1-cfontana@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="1Gf9O/qL";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9TDV30FN
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.68 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 RCPT_COUNT_FIVE(0.00)[6]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 TO_DN_ALL(0.00)[]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-0.997];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.81)[84.93%]
X-Rspamd-Queue-Id: 785C721D46
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

Try to clarify that the maximum can depend on the accel by
adding also the current accelerator to the message as such:

Selected CPU generation is too new. Maximum supported model
in the accelerator 'tcg' configuration: 'xyz'

Signed-off-by: Claudio Fontana <cfontana@suse.de>
---
 target/s390x/cpu_models.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 1a1c096122..0d6d8fc727 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -508,14 +508,14 @@ static void check_compatibility(const S390CPUModel *max_model,
 
     if (model->def->gen > max_model->def->gen) {
         error_setg(errp, "Selected CPU generation is too new. Maximum "
-                   "supported model in the configuration: \'%s\'",
-                   max_model->def->name);
+                   "supported model in the accelerator \'%s\' configuration: \'%s\'",
+                   current_accel_name(), max_model->def->name);
         return;
     } else if (model->def->gen == max_model->def->gen &&
                model->def->ec_ga > max_model->def->ec_ga) {
         error_setg(errp, "Selected CPU GA level is too new. Maximum "
-                   "supported model in the configuration: \'%s\'",
-                   max_model->def->name);
+                   "supported model in the accelerator \'%s\' configuration: \'%s\'",
+                   current_accel_name(), max_model->def->name);
         return;
     }
 
@@ -537,7 +537,8 @@ static void check_compatibility(const S390CPUModel *max_model,
     error_setg(errp, " ");
     s390_feat_bitmap_to_ascii(missing, errp, error_prepend_missing_feat);
     error_prepend(errp, "Some features requested in the CPU model are not "
-                  "available in the configuration: ");
+                  "available in the accelerator \'%s\' configuration: ",
+                  current_accel_name());
 }
 
 S390CPUModel *get_max_cpu_model(Error **errp)
-- 
2.26.2


