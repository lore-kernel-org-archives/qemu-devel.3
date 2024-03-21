Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DDB8C6FD1F
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 20:13:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnOmX-0003E9-Ar; Thu, 21 Mar 2024 16:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rnOmT-0003Dl-D8
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 16:12:53 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rnOmQ-0006LL-UF
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 16:12:52 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5AED33799B;
 Thu, 21 Mar 2024 20:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1711051968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=SOJMIwp8p6Z7dSXDaTOyjfgw1f1dQ+NCC450ewsAuiw=;
 b=SzPParyak4jsmBll/sw5V40DuHfIXxZZePfiLpon1RZUQQQw39Z3/w7xzdNNERxlyuhByd
 dXW6oFaCjatB0+iUZetp0b5UpJG4gwUVxBq+OSC+PPOqbTh1Z2+ut3AQfSSVxJCdDgS1UK
 AeMA1M94YAdY/akmDTLzvMBnw4nBv7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1711051968;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=SOJMIwp8p6Z7dSXDaTOyjfgw1f1dQ+NCC450ewsAuiw=;
 b=eWZnu4URGPMrt8VIUryzFdrNTSQjcOrKd3+NVmXwpUaGMDr9UQIvAb2jtfstxhUAxDl80f
 HCP1cGLJqzBiUKCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1711051966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=SOJMIwp8p6Z7dSXDaTOyjfgw1f1dQ+NCC450ewsAuiw=;
 b=NyjTCPsy2Bh0b2BcO2uk4o6Bvx8r6dAhgfFSzikvoTa6S6XrumYW7Umc8UM5HxS+S/34b+
 kKdgrMU32Gb68hVxOCtKQxaLBxzb7EO05pyIPjYt5xcwu+hcjO2Qqt2NfU1M1ndIWMdGWa
 gZZyx+Ozy6mAFSMqIZweHVPvgc8mNBs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1711051966;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=SOJMIwp8p6Z7dSXDaTOyjfgw1f1dQ+NCC450ewsAuiw=;
 b=ZkZK6FZhf7jKYg1xCzsFaIoQv2YYo+eHWU4ZIqJHdcV2jbGGi2T6abDTixGMEn29hsmQ4Z
 Ah9uvqTXrbN1E6Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 26BB9138A1;
 Thu, 21 Mar 2024 20:12:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8778NryU/GV7XwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 21 Mar 2024 20:12:44 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>,
	Peter Xu <peterx@redhat.com>
Subject: [PATCH] migration/multifd: Fix clearing of mapped-ram zero pages
Date: Thu, 21 Mar 2024 17:12:42 -0300
Message-Id: <20240321201242.6009-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NyjTCPsy;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ZkZK6FZh
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.80 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 BROKEN_CONTENT_TYPE(1.50)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; BAYES_HAM(-0.69)[83.22%];
 ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,gitlab.com:url];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: 5AED33799B
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

When the zero page detection is done in the multifd threads, we need
to iterate the second part of the pages->offset array and clear the
file bitmap for each zero page. The piece of code we merged to do that
is wrong.

The reason this has passed all the tests is because the bitmap is
initialized with zeroes already, so clearing the bits only really has
an effect during live migration and when a data page goes from having
data to no data.

Fixes: 303e6f54f9 ("migration/multifd: Implement zero page transmission on the multifd thread.")
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
CI run: https://gitlab.com/farosas/qemu/-/pipelines/1222882269
---
 migration/multifd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index d2f0238f70..2802afe79d 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -111,7 +111,6 @@ void multifd_send_channel_created(void)
 static void multifd_set_file_bitmap(MultiFDSendParams *p)
 {
     MultiFDPages_t *pages = p->pages;
-    uint32_t zero_num = p->pages->num - p->pages->normal_num;
 
     assert(pages->block);
 
@@ -119,7 +118,7 @@ static void multifd_set_file_bitmap(MultiFDSendParams *p)
         ramblock_set_file_bmap_atomic(pages->block, pages->offset[i], true);
     }
 
-    for (int i = p->pages->num; i < zero_num; i++) {
+    for (int i = p->pages->normal_num; i < p->pages->num; i++) {
         ramblock_set_file_bmap_atomic(pages->block, pages->offset[i], false);
     }
 }
-- 
2.35.3


