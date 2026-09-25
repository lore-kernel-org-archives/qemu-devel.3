Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69657C9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 15:42:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA82L-0006gm-W0; Fri, 25 Sep 2026 11:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xA82J-0006fl-SA
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:40:31 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xA82I-0004bH-8J
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:40:31 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 469A91F457;
 Fri, 25 Sep 2026 15:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790350824; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5G45mBCiYUDen0EoHtKerILaJEv08Eo3StMnQ0TSXzc=;
 b=m6vcviOivINBEauc67S/xHGkjogsaR0VD3ghyuvx7Bv3JU/7bfOBBMncf995rtLjSPBbTe
 vg6AxbDJwxk7NYi9sVwkkOLQ5nSS6qyGs0OoeoAvfeG0kEisNC/CpjwwRkWzDVCwEDdj7a
 qDOoxfB8+WWiJ7WnfkdQofsJUiuYr6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790350824;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5G45mBCiYUDen0EoHtKerILaJEv08Eo3StMnQ0TSXzc=;
 b=3nSFUnXTqiulniKoqnG6jkrerwSPCZMqA7GpnMykMYxtGwP1kJH/LGSe8k9dQEtvMg/1Xf
 kfkZTGu4Zk1Tx6CQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pzUpQP8H;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ihkwdhie
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790350820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5G45mBCiYUDen0EoHtKerILaJEv08Eo3StMnQ0TSXzc=;
 b=pzUpQP8Hwt3tHKIr6EgtJbxb/dOCNs55naMK9CGOoE9A1zKJyr+9MKoOrL5uj3yppBg3VV
 ADWDe8Can0V6mWvFcxUnMoZYxdToMapccxiaq2ubU9QSbvyWXsoS4X8FQ1ggmOXPX5pzX7
 UOnmdGpjJl0gONPnlVk4QqMDIUbTiuk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790350820;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5G45mBCiYUDen0EoHtKerILaJEv08Eo3StMnQ0TSXzc=;
 b=ihkwdhievJRFySxIE/U5MptiVIvV3Sqi40B+OVwXVmPC1R20PS6qTe+liiB8VpIWEJIqJJ
 s45XL1Zg+cGyO3DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A69D313274;
 Fri, 25 Sep 2026 15:40:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xxRgCd2VtmqjOwAAD6G6ig:T5
 (envelope-from <farosas@suse.de>); Fri, 25 Sep 2026 15:40:18 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Yanfei Xu <yanfei.xu@bytedance.com>,
 Jack Wang <jinpu.wang@cloud.ionos.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Lukas Straub <lukasstraub2@web.de>
Subject: [PULL 04/19] migration/rdma: Fix write-side shutdown
Date: Fri, 25 Sep 2026 12:39:55 -0300
Message-ID: <20260925154010.599247-5-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925154010.599247-1-farosas@suse.de>
References: <20260925154010.599247-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 469A91F457
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,bytedance.com,cloud.ionos.com,fujitsu.com,web.de];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[fujitsu.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,bytedance.com:email,ionos.com:email,suse.de:dkim,suse.de:email,suse.de:mid];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[web.de]; FROM_HAS_DN(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[6]; DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

From: Yanfei Xu <yanfei.xu@bytedance.com>

qio_channel_rdma_shutdown() reads rdmain for both the input and
output contexts.  As a result, a write-side shutdown marks the input
context as errored while leaving the output context active.  A shutdown
of both directions also fails to stop the output context.

Read rdmaout from the output context so each shutdown direction marks
the corresponding RDMA context as errored.

Fixes: 54db882f073a ("migration: implement the shutdown for RDMA QIOChannel")
Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
Tested-by: Lukas Straub <lukasstraub2@web.de>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index e976739fad..61181deb8a 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2860,7 +2860,7 @@ qio_channel_rdma_shutdown(QIOChannel *ioc,
     RCU_READ_LOCK_GUARD();
 
     rdmain = qatomic_rcu_read(&rioc->rdmain);
-    rdmaout = qatomic_rcu_read(&rioc->rdmain);
+    rdmaout = qatomic_rcu_read(&rioc->rdmaout);
 
     switch (how) {
     case QIO_CHANNEL_SHUTDOWN_READ:
-- 
2.53.0


