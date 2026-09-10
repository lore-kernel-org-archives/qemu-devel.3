Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7184C79FBB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 21:31:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4mHl-0000nW-3k; Thu, 10 Sep 2026 17:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x4lTh-0005uE-Vn
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:35:00 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x4lTR-0002cy-5P
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:34:29 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6871621EB5;
 Thu, 10 Sep 2026 20:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789071973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lCKcpItZ3rarcJaUARK6pl3h137OPzjExEVzJ/bAK0c=;
 b=zMF/tLeEO06+xtpPkp9y5+mZVd1Cqufrg/NpW6yyiA8de7dD7XPhO1N472ESX0rI+wShOk
 YxpenbpA0PJbX9EeGlGK/DFxqP7ufW/zrHzCO0U2IlHUuJKCYHYeSeqWh24LzOzCdsUmJP
 jqMR3kv1C0WSTKslqV7w9TeJGbQ+l9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789071973;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lCKcpItZ3rarcJaUARK6pl3h137OPzjExEVzJ/bAK0c=;
 b=gOmpEVZ2Q8txOLrq5Xb3ZtCE+yMhO1jyODPI8PAmQHlTGZ6LyJ9mdltdW5HMKD0T/fEUzl
 JtiHYE6g+QlePgBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789071969; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lCKcpItZ3rarcJaUARK6pl3h137OPzjExEVzJ/bAK0c=;
 b=hzesXkTKeY+yt+7cYkUX5ll5GKbcL4VqbLA0g3AoEof7UGOPekYWA9pK1W0BKI3V885vY8
 fc06p+eulugJGR9xmcAowRXdyiLFMsh3/eIXC5wDfROMPhzf6uW+9nacNXsjX410PE+fnO
 nlHih3dpH69rTsw8UCaZaZmloW0a7kA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789071969;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lCKcpItZ3rarcJaUARK6pl3h137OPzjExEVzJ/bAK0c=;
 b=Yubk7ixzsax5JSExV/vdt+W3OuwMmIAYS+xTKij4aBdBVfmyR2UoCqNmM/5UXIZJylJWpk
 ynzkIvJZhnACQ1BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3933913955;
 Thu, 10 Sep 2026 20:26:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sFEoA2ASo2pJPQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 10 Sep 2026 20:26:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Christian Quante <christian@quante.one>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 2/7] tests/qtest/fdc-test: skip test cases when the 'pc'
 machine is missing
Date: Thu, 10 Sep 2026 17:25:54 -0300
Message-ID: <20260910202559.916866-3-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910202559.916866-1-farosas@suse.de>
References: <20260910202559.916866-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.996]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo, quante.one:email]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

From: Christian Quante <christian@quante.one>

run_isolated() starts every test case in fdc_tests[] with "-machine pc".
A QEMU built without the i440fx/pc machine fails them with "unsupported
machine type 'pc'" rather than skipping them.

Check for the machine in run_isolated() and skip there.  The previous
patch routed every table entry through that one function, so one check
covers all of them; 4e37f749dd ("tests/qtest/drive_del-test: skip pc
tests when 'pc' machine is unavailable") needed the same three lines
four times over.

The two CVE test cases are left alone.  They start QEMU without
-machine and so ask for the default machine, which is a separate
question from the one this patch answers.

Signed-off-by: Christian Quante <christian@quante.one>
Tested-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/fdc-test.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/qtest/fdc-test.c b/tests/qtest/fdc-test.c
index fd38475bf7..f480f4ba09 100644
--- a/tests/qtest/fdc-test.c
+++ b/tests/qtest/fdc-test.c
@@ -690,6 +690,11 @@ static void run_isolated(const void *data)
 {
     const FDCTest *test = data;
 
+    if (!qtest_has_machine("pc")) {
+        g_test_skip("Machine 'pc' is not available");
+        return;
+    }
+
     qtest_start("-machine pc -device floppy,id=floppy0");
     qtest_irq_intercept_in(global_qtest, "ioapic");
 
-- 
2.53.0


