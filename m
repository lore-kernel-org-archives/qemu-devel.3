Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CDE2CE7A9E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 21:04:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smJdo-0005Cn-OJ; Thu, 05 Sep 2024 17:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1smJdl-000515-GX
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 17:03:41 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1smJdk-0007JU-3f
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 17:03:41 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B920C2198A;
 Thu,  5 Sep 2024 21:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725570218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1TwWoOSlyrwzv/skpMfJPPd9rjnkVgHME9SOsTcOT0o=;
 b=joQEecekq6uxMIkXE1xDPvPdHx3oAEdpZcfHfzvyRbXYm2VdVQx++BRJtfyuH3Khy5+Vcp
 v5PNXBSw+4DGXJu+eNxrqrXAL1gWuDgWb12HpLEAyubKzkz0AiQVM+RVrqE1i6djxNKJrK
 eDllaqyJeuyAGrbpn1TwYGGUFLD60sM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725570218;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1TwWoOSlyrwzv/skpMfJPPd9rjnkVgHME9SOsTcOT0o=;
 b=aBrgcFA28lf9klDV1PnzWdiqTFLSoFnIgDzIcjsfjoLPnX3QEwZS7Ixc6gvHFVw8EGo7SA
 dUI8Y5mLU/shNUCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725570218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1TwWoOSlyrwzv/skpMfJPPd9rjnkVgHME9SOsTcOT0o=;
 b=joQEecekq6uxMIkXE1xDPvPdHx3oAEdpZcfHfzvyRbXYm2VdVQx++BRJtfyuH3Khy5+Vcp
 v5PNXBSw+4DGXJu+eNxrqrXAL1gWuDgWb12HpLEAyubKzkz0AiQVM+RVrqE1i6djxNKJrK
 eDllaqyJeuyAGrbpn1TwYGGUFLD60sM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725570218;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1TwWoOSlyrwzv/skpMfJPPd9rjnkVgHME9SOsTcOT0o=;
 b=aBrgcFA28lf9klDV1PnzWdiqTFLSoFnIgDzIcjsfjoLPnX3QEwZS7Ixc6gvHFVw8EGo7SA
 dUI8Y5mLU/shNUCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A698A1395F;
 Thu,  5 Sep 2024 21:03:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uFshG6gc2mYcBwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 05 Sep 2024 21:03:36 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH 2/2] tests/qtest: Mute -qtest-log
Date: Thu,  5 Sep 2024 18:03:28 -0300
Message-Id: <20240905210328.25393-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240905210328.25393-1-farosas@suse.de>
References: <20240905210328.25393-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_SEVEN(0.00)[7];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
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

Make the -qtest-log be conditional on the --verbose flag, along with
the existing QTEST_LOG to avoid noisy qtest_memread() messages. Those
are particularly annoying for migration-test because all tests read
guest memory at the end and the QMP messages get lost in a flood of:

[R +1.096069] read 0x63ce000 0x1
[S +1.096071] OK 0xb8
[R +1.096077] read 0x63cf000 0x1
[S +1.096079] OK 0xb8
...

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/libqtest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 347664cea6..9fca9c7260 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -479,7 +479,7 @@ static QTestState *qtest_init_internal(const char *qemu_bin,
                          " -accel qtest"
                          " 2> %s",
                          socket_path,
-                         getenv("QTEST_LOG") ? DEV_STDERR : DEV_NULL,
+                         g_test_verbose() ? DEV_STDERR : DEV_NULL,
                          qmp_socket_path,
                          extra_args ?: "",
                          getenv("QTEST_LOG") ? DEV_STDERR : DEV_NULL);
-- 
2.35.3


