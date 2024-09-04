Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C036ECD3431
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 12:47:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slpNC-0003WP-AO; Wed, 04 Sep 2024 08:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1slpNB-0003SQ-8Z
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 08:44:33 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1slpN9-0005Rm-JI
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 08:44:32 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1EE961F38E;
 Wed,  4 Sep 2024 12:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725453870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GqaP/FCR+HWdzVs0QVMLDNAsRWxwmc3xCegKzUxtsN8=;
 b=Ava6dQEZiRDFXQSAJ+BEw20Uudp8LvvzCFGd0ZkIZVy+GwJJijHcrLhqHpnFKTGyXrG+Sm
 pGpDxygFhrNmylXu1VFMPkrXZuzMX9TMupCGDO/EwmFnfv5Zj/AphAc5AZDvIAHRSTC3pz
 +mR8XPfmPUzPnngJ7Es2KrPrARn2hH4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725453870;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GqaP/FCR+HWdzVs0QVMLDNAsRWxwmc3xCegKzUxtsN8=;
 b=KYenGYCetC5k6R9d8w6qRLVX4Uv/FkN2E+Hj+jHiem+/3t6pyCk0t1IH0eF/J291+IKv3E
 wMY/Wgf18K4tj7BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725453870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GqaP/FCR+HWdzVs0QVMLDNAsRWxwmc3xCegKzUxtsN8=;
 b=Ava6dQEZiRDFXQSAJ+BEw20Uudp8LvvzCFGd0ZkIZVy+GwJJijHcrLhqHpnFKTGyXrG+Sm
 pGpDxygFhrNmylXu1VFMPkrXZuzMX9TMupCGDO/EwmFnfv5Zj/AphAc5AZDvIAHRSTC3pz
 +mR8XPfmPUzPnngJ7Es2KrPrARn2hH4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725453870;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GqaP/FCR+HWdzVs0QVMLDNAsRWxwmc3xCegKzUxtsN8=;
 b=KYenGYCetC5k6R9d8w6qRLVX4Uv/FkN2E+Hj+jHiem+/3t6pyCk0t1IH0eF/J291+IKv3E
 wMY/Wgf18K4tj7BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B38F5139D2;
 Wed,  4 Sep 2024 12:44:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WBwxHixW2GZuVQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 04 Sep 2024 12:44:28 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 05/34] tests/qtest/migration-test: Fix leaks in
 calc_dirtyrate_ready()
Date: Wed,  4 Sep 2024 09:43:48 -0300
Message-Id: <20240904124417.14565-6-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240904124417.14565-1-farosas@suse.de>
References: <20240904124417.14565-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.78 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.18)[-0.925];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,linaro.org:email];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

From: Peter Maydell <peter.maydell@linaro.org>

In calc_dirtyrate_ready() we g_strdup() a string but then never free it:

Direct leak of 19 byte(s) in 2 object(s) allocated from:
    #0 0x55ead613413e in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/tests/qtest/migration-test+0x22f13e) (BuildId: e7cd5c37b2987a1af682b43ee5240b98bb316737)
    #1 0x7f7a13d39738 in g_malloc debian/build/deb/../../../glib/gmem.c:128:13
    #2 0x7f7a13d4e583 in g_strdup debian/build/deb/../../../glib/gstrfuncs.c:361:17
    #3 0x55ead6266f48 in calc_dirtyrate_ready tests/qtest/migration-test.c:3409:14
    #4 0x55ead62669fe in wait_for_calc_dirtyrate_complete tests/qtest/migration-test.c:3422:13
    #5 0x55ead6253df7 in test_vcpu_dirty_limit tests/qtest/migration-test.c:3562:9
    #6 0x55ead626a407 in migration_test_wrapper tests/qtest/migration-helpers.c:456:5

We also fail to unref the QMP rsp_return, so we leak that also.

Rather than duplicating the string, use the in-place value from
the qdict, and then unref the qdict.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-test.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index b775ffed81..97f99c1316 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -3318,15 +3318,18 @@ static QDict *query_vcpu_dirty_limit(QTestState *who)
 static bool calc_dirtyrate_ready(QTestState *who)
 {
     QDict *rsp_return;
-    gchar *status;
+    const char *status;
+    bool ready;
 
     rsp_return = query_dirty_rate(who);
     g_assert(rsp_return);
 
-    status = g_strdup(qdict_get_str(rsp_return, "status"));
+    status = qdict_get_str(rsp_return, "status");
     g_assert(status);
+    ready = g_strcmp0(status, "measuring");
+    qobject_unref(rsp_return);
 
-    return g_strcmp0(status, "measuring");
+    return ready;
 }
 
 static void wait_for_calc_dirtyrate_complete(QTestState *who,
-- 
2.35.3


