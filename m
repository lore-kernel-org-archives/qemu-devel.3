Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1766AE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 22:07:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTTLC-0004Q2-Fn; Thu, 02 Jan 2025 17:06:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tTTL6-0004EV-Ez; Thu, 02 Jan 2025 17:06:48 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tTTL4-0007A0-WE; Thu, 02 Jan 2025 17:06:48 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5ED9D1F76E;
 Thu,  2 Jan 2025 22:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1735855605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BQ9qjoRM4jkG5sve6+kc7w1GTquDUDYCKplBq7BGOgo=;
 b=Yebi2VUqFYv1YzHzPTp5oAJsXesmDE9N4vBuwPblAhZSughaNFzDr+WYmjqZNgscYfvE1Z
 VPxCBQUh7sdQHrFkSbFmki2i8oxOGXiNG8taFHv6CGAsZWU8vPRDlg5bcYcwxFs/xRlf0t
 bUyiZ+Goxi8g6ZJTy2SOc3rOlm1QQ1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1735855605;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BQ9qjoRM4jkG5sve6+kc7w1GTquDUDYCKplBq7BGOgo=;
 b=BnG7al+Aoz0Z6we670NUxQXCC/OZ3T+KXaN5ljEIEKYB5aOA8dx9qQmBesSiTuld9kigzt
 u4W7dBPmmPWQLgBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Yebi2VUq;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BnG7al+A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1735855605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BQ9qjoRM4jkG5sve6+kc7w1GTquDUDYCKplBq7BGOgo=;
 b=Yebi2VUqFYv1YzHzPTp5oAJsXesmDE9N4vBuwPblAhZSughaNFzDr+WYmjqZNgscYfvE1Z
 VPxCBQUh7sdQHrFkSbFmki2i8oxOGXiNG8taFHv6CGAsZWU8vPRDlg5bcYcwxFs/xRlf0t
 bUyiZ+Goxi8g6ZJTy2SOc3rOlm1QQ1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1735855605;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BQ9qjoRM4jkG5sve6+kc7w1GTquDUDYCKplBq7BGOgo=;
 b=BnG7al+Aoz0Z6we670NUxQXCC/OZ3T+KXaN5ljEIEKYB5aOA8dx9qQmBesSiTuld9kigzt
 u4W7dBPmmPWQLgBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E26D8132EA;
 Thu,  2 Jan 2025 22:06:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yEkVKfMNd2emeQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 02 Jan 2025 22:06:43 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 8/8] qtest/fw-cfg: remove compiled out code
Date: Thu,  2 Jan 2025 19:06:29 -0300
Message-Id: <20250102220629.11351-9-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250102220629.11351-1-farosas@suse.de>
References: <20250102220629.11351-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5ED9D1F76E
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-2.99)[99.95%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

From: Ani Sinha <anisinha@redhat.com>

Remove code that is already compiled out. This prevents confusion.

CC: qemu-trivial@nongnu.org
Signed-off-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20250101081555.1050736-1-anisinha@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/fw_cfg-test.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tests/qtest/fw_cfg-test.c b/tests/qtest/fw_cfg-test.c
index 5dc807ba23..e48b34afa5 100644
--- a/tests/qtest/fw_cfg-test.c
+++ b/tests/qtest/fw_cfg-test.c
@@ -243,12 +243,6 @@ int main(int argc, char **argv)
     qtest_add_func("fw_cfg/ram_size", test_fw_cfg_ram_size);
     qtest_add_func("fw_cfg/nographic", test_fw_cfg_nographic);
     qtest_add_func("fw_cfg/nb_cpus", test_fw_cfg_nb_cpus);
-#if 0
-    qtest_add_func("fw_cfg/machine_id", test_fw_cfg_machine_id);
-    qtest_add_func("fw_cfg/kernel", test_fw_cfg_kernel);
-    qtest_add_func("fw_cfg/initrd", test_fw_cfg_initrd);
-    qtest_add_func("fw_cfg/boot_device", test_fw_cfg_boot_device);
-#endif
     qtest_add_func("fw_cfg/max_cpus", test_fw_cfg_max_cpus);
     qtest_add_func("fw_cfg/numa", test_fw_cfg_numa);
     qtest_add_func("fw_cfg/boot_menu", test_fw_cfg_boot_menu);
-- 
2.35.3


