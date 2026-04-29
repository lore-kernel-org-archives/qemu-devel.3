Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8470CCFA13
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 19:08:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIAEa-0001o3-Lb; Wed, 29 Apr 2026 15:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wIAEY-0001mG-AP
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 15:06:06 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wIAEW-0000Nd-GJ
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 15:06:06 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6622A5BD6D;
 Wed, 29 Apr 2026 19:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777489562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XFuWhPG5UR/GLn09TTRumzpk9PUd1gSL+5XeS232Sak=;
 b=M+GCoO8SS8lhNzIleffL96cJL6qYywrPHdUGSZsrH1jWg8vGYsHS5SjwutRJDQ6R8PkIVR
 hAoP5Myy/JMCsRqom2tSGVyKOcIJ1/2xmyV/LuACS+oR3wZUN40xXKm4ovMX8TdeAX9Wa9
 9+Zb80HMfUIxf9mZUtLlRKUs7NsNtPc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777489562;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XFuWhPG5UR/GLn09TTRumzpk9PUd1gSL+5XeS232Sak=;
 b=O3h8RVBoB3iJKL/tuwBnFXG/wWK5mt+f4YYqh+tl7yk0Lfodp+GCVMlaGL3RHV7ZTEpqOi
 txIHI5HuyeW0PYAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777489562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XFuWhPG5UR/GLn09TTRumzpk9PUd1gSL+5XeS232Sak=;
 b=M+GCoO8SS8lhNzIleffL96cJL6qYywrPHdUGSZsrH1jWg8vGYsHS5SjwutRJDQ6R8PkIVR
 hAoP5Myy/JMCsRqom2tSGVyKOcIJ1/2xmyV/LuACS+oR3wZUN40xXKm4ovMX8TdeAX9Wa9
 9+Zb80HMfUIxf9mZUtLlRKUs7NsNtPc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777489562;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XFuWhPG5UR/GLn09TTRumzpk9PUd1gSL+5XeS232Sak=;
 b=O3h8RVBoB3iJKL/tuwBnFXG/wWK5mt+f4YYqh+tl7yk0Lfodp+GCVMlaGL3RHV7ZTEpqOi
 txIHI5HuyeW0PYAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E031593B1;
 Wed, 29 Apr 2026 19:06:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eNyaM5hW8mm/eQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 29 Apr 2026 19:06:00 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, marcandre.lureau@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v1 5/5] tests/qtest/dbus-vmstate: Re-enable the test
Date: Wed, 29 Apr 2026 16:05:50 -0300
Message-ID: <20260429190550.20122-6-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260429190550.20122-1-farosas@suse.de>
References: <20260429190550.20122-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[]
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

Back in 2020, the dbus-vmstate test was disabled by commit d46f81cb74
("tests: Disable dbus-vmstate-test") due to Patchew failures. We don't
use Patchew anymore for CI, so re-enable the test.

G_TEST_DBUS_DAEMON=../tests/dbus-vmstate-daemon.sh \
QTEST_QEMU_BINARY=./qemu-system-x86_64  \
./tests/qtest/dbus-vmstate-test

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/meson.build | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 0d04e2cbaa..b3f62e8cd5 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -123,8 +123,7 @@ endif
 
 dbus_daemon = find_program('dbus-daemon', required: false)
 if dbus_daemon.found() and gdbus_codegen.found()
-  # Temporarily disabled due to Patchew failures:
-  #qtests_i386 += ['dbus-vmstate-test']
+  qtests_i386 += ['dbus-vmstate-test']
   dbus_vmstate1 = custom_target('dbus-vmstate description',
                                 build_by_default: true,
                                 output: [ 'dbus-vmstate1.h', 'dbus-vmstate1.c'],
-- 
2.51.0


