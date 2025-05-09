Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B2CDC3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 17:51:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDRsK-0000qO-AD; Fri, 09 May 2025 13:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uDRs9-0000nO-FS
 for qemu-devel@nongnu.org; Fri, 09 May 2025 13:50:58 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uDRs7-0000yi-K7
 for qemu-devel@nongnu.org; Fri, 09 May 2025 13:50:57 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BC1F81F397;
 Fri,  9 May 2025 17:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1746813053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=dRVse9f796e5HVMjXc/wv8g8KASemDr6yYOQdJ5128w=;
 b=E8iLhiNp1UaTbpcVIjElplhKGdg0phLfXlv6LG7Czh/EayxxJ086+64lUPPrqnSVNX/REo
 QrTT6/7lbetdvZ3voC/5AL3FWgA//ijYH+pk7WZplJYked9Yrls+JAAYJ6pjiLYvO3uAHX
 BNlEFxVwoBR6I1zz8LP4dWLDAMQurxk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1746813053;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=dRVse9f796e5HVMjXc/wv8g8KASemDr6yYOQdJ5128w=;
 b=61QFz8s7OaVkFkHXCQNxXvmtnYXIzN9CtqMtnhwjWTnkvsrcikRQ8YVVsqrmP66w3ZqrMl
 duJ8R1MCO2lRzFDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=E8iLhiNp;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=61QFz8s7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1746813053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=dRVse9f796e5HVMjXc/wv8g8KASemDr6yYOQdJ5128w=;
 b=E8iLhiNp1UaTbpcVIjElplhKGdg0phLfXlv6LG7Czh/EayxxJ086+64lUPPrqnSVNX/REo
 QrTT6/7lbetdvZ3voC/5AL3FWgA//ijYH+pk7WZplJYked9Yrls+JAAYJ6pjiLYvO3uAHX
 BNlEFxVwoBR6I1zz8LP4dWLDAMQurxk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1746813053;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=dRVse9f796e5HVMjXc/wv8g8KASemDr6yYOQdJ5128w=;
 b=61QFz8s7OaVkFkHXCQNxXvmtnYXIzN9CtqMtnhwjWTnkvsrcikRQ8YVVsqrmP66w3ZqrMl
 duJ8R1MCO2lRzFDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 77A101399F;
 Fri,  9 May 2025 17:50:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SkQFDXpAHmhwBQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 09 May 2025 17:50:50 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] tests/qtest/ast2700-smc-test: Fix leak
Date: Fri,  9 May 2025 14:50:47 -0300
Message-Id: <20250509175047.26066-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: BC1F81F397
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[kaod.org,linaro.org,aspeedtech.com,gmail.com,codeconstruct.com.au,jms.id.au,redhat.com];
 RCPT_COUNT_SEVEN(0.00)[10]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Action: no action
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

ASAN spotted a leak of the memory used to hold the tmp_path:

Direct leak of 35 byte(s) in 1 object(s) allocated from:
    #0 0x55e29aa96da9 in malloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:69:3
    #1 0x7fe0cfb26518 in g_malloc ../glib/gmem.c:106
    #2 0x7fe0cfb4146e in g_strconcat ../glib/gstrfuncs.c:629
    #3 0x7fe0cfb0a78f in g_get_tmp_name ../glib/gfileutils.c:1742
    #4 0x7fe0cfb0b00b in g_file_open_tmp ../glib/gfileutils.c:1802
    #5 0x55e29ab53961 in test_ast2700_evb ../tests/qtest/ast2700-smc-test.c:20:10
    #6 0x55e29ab53803 in main ../tests/qtest/ast2700-smc-test.c:65:5
    #7 0x7fe0cf7bd24c in __libc_start_main ../csu/libc-start.c:308
    #8 0x55e29a9f7759 in _start ../sysdeps/x86_64/start.S:120

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/ast2700-smc-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/ast2700-smc-test.c b/tests/qtest/ast2700-smc-test.c
index d1c4856307..62d538d8a3 100644
--- a/tests/qtest/ast2700-smc-test.c
+++ b/tests/qtest/ast2700-smc-test.c
@@ -67,5 +67,6 @@ int main(int argc, char **argv)
 
     qtest_quit(ast2700_evb_data.s);
     unlink(ast2700_evb_data.tmp_path);
+    g_free(ast2700_evb_data.tmp_path);
     return ret;
 }
-- 
2.35.3


