Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BDB8CA5FC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 22:14:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xC2Wy-0007xs-H8; Wed, 30 Sep 2026 18:12:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xC2Wi-0007wE-I8
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 18:11:48 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xC2Wg-00052W-2W
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 18:11:47 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D9D931FBA1;
 Wed, 30 Sep 2026 22:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790806299; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IxwT3cijmhc+wS0q1TDbdYSFNOPuYddUPyU+ZkUQk5k=;
 b=1jSGAUkeKr7lUBi6+mkNaFtgnsyDLwDf5g6J9gVh7LCvBcOnea3vS97dKeqNF754s06XeT
 ivghTsyE4B7aHIRx0gDdoM6HFtUm6h9AGXvJ8K4r3CQ45Jg2d/fPJzxivHrsBGyyMKta6M
 fSyrzoo7J/5vqhgnNPagXJHGvIKqjsA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790806299;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IxwT3cijmhc+wS0q1TDbdYSFNOPuYddUPyU+ZkUQk5k=;
 b=EpjXuk15M2fh9U6J5tWEe0u8genJnlHrzHRtsG5FqdHHr+aLAXe9LvJorhrW5l+5yXA12n
 PIjuKp5BJeT33ABQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=D1uQKIG+;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=a4LOdZb9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790806294; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IxwT3cijmhc+wS0q1TDbdYSFNOPuYddUPyU+ZkUQk5k=;
 b=D1uQKIG+S1Z6hiinUvxkjuCLafbEJ9HCH10n6A8ZlOvm26xD0e28i8yccYnGTdRlJSo3np
 qduuxjY2xvd7CIRbXoy0rFbXUdmSmbiDbkF4yAJBflKBTzwDn/Q1k3JgVE68wY64RQmFbP
 wCzdvzeLYtsY7fnEhHofWRkCnjU0lB0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790806294;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IxwT3cijmhc+wS0q1TDbdYSFNOPuYddUPyU+ZkUQk5k=;
 b=a4LOdZb9LOLX8pbzV2s3Wlh+ozN7sZQkba+xLIgdNHiPOU9uDspSPBCHPq+Ab9Sc2MpDe9
 y4qV2qf+0lu1G/Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD0B613AF1;
 Wed, 30 Sep 2026 22:11:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id befqOAqJvWpwXAAAD6G6ig:T8
 (envelope-from <farosas@suse.de>); Wed, 30 Sep 2026 22:11:33 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 07/11] qemu-option: Add qemu_opts_parse_list_noisily
Date: Wed, 30 Sep 2026 19:11:01 -0300
Message-ID: <20260930221105.2262063-8-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930221105.2262063-1-farosas@suse.de>
References: <20260930221105.2262063-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D9D931FBA1
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Add a new function that takes a QemuOptsList pointer and expects
informative messages to be printed instead of returned in an Error
object. This makes the _noisily version simmetric with the
"non-noisily". The next patch will convert the callers to use the
appropriate version.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/qemu/option.h |  2 ++
 util/qemu-option.c    | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/qemu/option.h b/include/qemu/option.h
index dfe0d9b893..df68da9aa8 100644
--- a/include/qemu/option.h
+++ b/include/qemu/option.h
@@ -134,6 +134,8 @@ QemuOpts *qemu_opts_parse(const char *group, const char *params,
                           bool permit_abbrev, Error **errp);
 QemuOpts *qemu_opts_parse_list(QemuOptsList *list, const char *params,
                                bool permit_abbrev, Error **errp);
+QemuOpts *qemu_opts_parse_list_noisily(QemuOptsList *list, const char *params,
+                                       bool permit_abbrev);
 QemuOpts *qemu_opts_from_qdict(QemuOptsList *list, const QDict *qdict,
                                Error **errp);
 QDict *qemu_opts_to_qdict_filtered(QemuOpts *opts, QDict *qdict,
diff --git a/util/qemu-option.c b/util/qemu-option.c
index 7cb45f0710..be9404ab7f 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -965,6 +965,20 @@ QemuOpts *qemu_opts_parse_list(QemuOptsList *list, const char *params,
  */
 QemuOpts *qemu_opts_parse_noisily(QemuOptsList *list, const char *params,
                                   bool permit_abbrev)
+{
+    return qemu_opts_parse_list_noisily(list, params, permit_abbrev);
+}
+
+/**
+ * Create a QemuOpts in @list and with options parsed from @params.
+ * If @permit_abbrev, the first key=value in @params may omit key=,
+ * and is treated as if key was @list->implied_opt_name.
+ * Report errors with error_report_err().  This is inappropriate in
+ * QMP context.  Do not use this function there!
+ * Return the new QemuOpts on success, null pointer on error.
+ */
+QemuOpts *qemu_opts_parse_list_noisily(QemuOptsList *list, const char *params,
+                                       bool permit_abbrev)
 {
     Error *err = NULL;
     QemuOpts *opts;
-- 
2.53.0


