Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F5C3E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 22:08:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTTL6-0004D9-4A; Thu, 02 Jan 2025 17:06:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tTTL1-00048X-MX
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 17:06:44 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tTTKz-00077X-Si
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 17:06:43 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8054921176;
 Thu,  2 Jan 2025 22:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1735855597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=apz5bqAfVz/BjZ5HPnton687GPghNn/BWXQ5E1fSeI4=;
 b=kpx/Yh5b0Zz1VoHSmlO7ajWiY1yn4YmDR/oqO6rqUPHht41c5LyR5EABSnitBWPRNi9M4F
 6Ewtkf7ZXvnn4+6XtDS9wg6Nbwn52xiG6CQK/LyL7jwl98BBs/q/59yQRYvr/YmoD8PzXm
 Mb8Zb3xgwsgWk6LhuyEl/6fR6FwXBPA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1735855597;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=apz5bqAfVz/BjZ5HPnton687GPghNn/BWXQ5E1fSeI4=;
 b=PFdyERAoZXcum4cXuybb1G898tPUzI9O57jGzxC5gHJVBcfy4X2kxbOh1THE2p7TUAHurB
 kY9ScdrY88k1jMAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="kpx/Yh5b";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=PFdyERAo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1735855597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=apz5bqAfVz/BjZ5HPnton687GPghNn/BWXQ5E1fSeI4=;
 b=kpx/Yh5b0Zz1VoHSmlO7ajWiY1yn4YmDR/oqO6rqUPHht41c5LyR5EABSnitBWPRNi9M4F
 6Ewtkf7ZXvnn4+6XtDS9wg6Nbwn52xiG6CQK/LyL7jwl98BBs/q/59yQRYvr/YmoD8PzXm
 Mb8Zb3xgwsgWk6LhuyEl/6fR6FwXBPA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1735855597;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=apz5bqAfVz/BjZ5HPnton687GPghNn/BWXQ5E1fSeI4=;
 b=PFdyERAoZXcum4cXuybb1G898tPUzI9O57jGzxC5gHJVBcfy4X2kxbOh1THE2p7TUAHurB
 kY9ScdrY88k1jMAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 465EE132EA;
 Thu,  2 Jan 2025 22:06:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OAYjA+wNd2emeQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 02 Jan 2025 22:06:36 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>
Subject: [PULL 3/8] tests/qtest/migration: Initialize buffer in
 probe_o_direct_support
Date: Thu,  2 Jan 2025 19:06:24 -0300
Message-Id: <20250102220629.11351-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250102220629.11351-1-farosas@suse.de>
References: <20250102220629.11351-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8054921176
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,linaro.org:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Valgrind complains about the probe_o_direct_support() function reading
from an uninitialized buffer. For probing O_DIRECT support we don't
actually need to write to the file, just make sure the pwrite call
doesn't reject the write. Still, write zeroes to the buffer to
suppress the warning.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Message-Id: <20241209204427.17763-3-farosas@suse.de>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/migration-util.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/migration/migration-util.c b/tests/qtest/migration/migration-util.c
index 525bf1eed4..401fe27f00 100644
--- a/tests/qtest/migration/migration-util.c
+++ b/tests/qtest/migration/migration-util.c
@@ -284,6 +284,7 @@ bool probe_o_direct_support(const char *tmpfs)
 
     buf = qemu_try_memalign(len, len);
     g_assert(buf);
+    memset(buf, 0, len);
 
     ret = pwrite(fd, buf, len, offset);
     unlink(filename);
-- 
2.35.3


