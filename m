Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9563DC36017
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 19:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzhge-00024K-Rf; Tue, 01 Apr 2025 15:54:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tzhgW-00023p-DI
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 15:54:08 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tzhgT-0004Ib-Ho
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 15:54:07 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D83661F445;
 Tue,  1 Apr 2025 19:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743537240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sZRpxeZp7MCAQlerfbPOpSzYPqrrNrQzZz6Uo8WLPWs=;
 b=ZpIKMQKfeyOsxksEAADAn5+w5x+9DFG0RAIp9gesHJtGRpnj/1IUY/LH8WUMmuvJGtMGF4
 uOsEQHx6FK27v52YQAUild259LTM4lXgxKT5MAjcy1HChd0JtJTKS8tMASjukFbepq+PsQ
 h7ZQaeCdZtgRAKmtKhlJ6aUVRSuNb4Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743537240;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sZRpxeZp7MCAQlerfbPOpSzYPqrrNrQzZz6Uo8WLPWs=;
 b=xW1VMrzAvAr75kAPa4ZKHrJG73ekA8b1DjxXTItzSi76ZgZ/lEN9qIFGvXZ8zq1YXc3yOO
 vV47etiZwU+JJcCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743537239; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sZRpxeZp7MCAQlerfbPOpSzYPqrrNrQzZz6Uo8WLPWs=;
 b=UIzCURRWGTOtdneXYVntIMQGh0UYVlFCAlpfgYFN9PNwuff7jE1bjSCRYucybSxr6RUs7m
 kL0BoB1XZrfz3FNc1/PM7Y6Om8tMb8H51tMnu3q9+RPyypRslMRQ03SrPf++U2EajBj17g
 oRN/3sKf3KvTU8vk23ma8rKE7zdyoUQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743537239;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sZRpxeZp7MCAQlerfbPOpSzYPqrrNrQzZz6Uo8WLPWs=;
 b=dFuuJiBW33Tb3mcadTClIiaoZewIH11d/qV4mMfRTuLdv3H7ZBB6Tskuz2ckcqPK2V3wMG
 e6ln84Yw1vZ3XsAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F4059138A5;
 Tue,  1 Apr 2025 19:53:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MJ/rK1VE7GdNSAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 01 Apr 2025 19:53:57 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Marco Cavenati <Marco.Cavenati@eurecom.fr>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 1/1] migration: fix SEEK_CUR offset calculation in
 qio_channel_block_seek
Date: Tue,  1 Apr 2025 16:53:53 -0300
Message-Id: <20250401195353.803-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250401195353.803-1-farosas@suse.de>
References: <20250401195353.803-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:email,
 suse.de:mid]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Marco Cavenati <Marco.Cavenati@eurecom.fr>

The SEEK_CUR case in qio_channel_block_seek was incorrectly using the
'whence' parameter instead of the 'offset' parameter when calculating the
new position.

Fixes: 65cf200a51 ("migration: introduce a QIOChannel impl for BlockDriverState VMState")
Signed-off-by: Marco Cavenati <Marco.Cavenati@eurecom.fr>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <20250326162230.3323199-1-Marco.Cavenati@eurecom.fr>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/channel-block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/channel-block.c b/migration/channel-block.c
index fff8d87094..b0477f5b6d 100644
--- a/migration/channel-block.c
+++ b/migration/channel-block.c
@@ -123,7 +123,7 @@ qio_channel_block_seek(QIOChannel *ioc,
         bioc->offset = offset;
         break;
     case SEEK_CUR:
-        bioc->offset += whence;
+        bioc->offset += offset;
         break;
     case SEEK_END:
         error_setg(errp, "Size of VMstate region is unknown");
-- 
2.35.3


