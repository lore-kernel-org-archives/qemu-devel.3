Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A192CA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 22:40:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoUzC-00083U-7K; Tue, 19 Aug 2025 18:39:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uoUzA-00082d-Nx
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 18:39:20 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uoUz9-00083q-1R
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 18:39:20 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3A18A1F76B;
 Tue, 19 Aug 2025 22:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755643157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SGMs/cXmMsU9KIWBRfHaZ4oTboSJQO3fYScnCEcgy6Y=;
 b=YcvGie6Pt53yRq7hfIzRXFnr2xAiXDLRUacaLZg6Lmc7emYcKbwy2EDOZlRVcxrgfV9wXH
 mc8uSxNgYI5abzigU8LsBaig8mWWUFbtRTGby1PyfaL+AGhq02ahTdkai8popcmO9bPvEW
 ZN4zYQxse5clXEOHqAKJ6t7npb3zeC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755643157;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SGMs/cXmMsU9KIWBRfHaZ4oTboSJQO3fYScnCEcgy6Y=;
 b=LnutVre2Zj0nch06pQG0zvx7nySX3KYoQbD4ic0Xvgcg1Hq/kEQiQkBrkVwMrkqjVJeFGr
 WmlmxoNoLDLFGOCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=YcvGie6P;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LnutVre2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755643157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SGMs/cXmMsU9KIWBRfHaZ4oTboSJQO3fYScnCEcgy6Y=;
 b=YcvGie6Pt53yRq7hfIzRXFnr2xAiXDLRUacaLZg6Lmc7emYcKbwy2EDOZlRVcxrgfV9wXH
 mc8uSxNgYI5abzigU8LsBaig8mWWUFbtRTGby1PyfaL+AGhq02ahTdkai8popcmO9bPvEW
 ZN4zYQxse5clXEOHqAKJ6t7npb3zeC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755643157;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SGMs/cXmMsU9KIWBRfHaZ4oTboSJQO3fYScnCEcgy6Y=;
 b=LnutVre2Zj0nch06pQG0zvx7nySX3KYoQbD4ic0Xvgcg1Hq/kEQiQkBrkVwMrkqjVJeFGr
 WmlmxoNoLDLFGOCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B326E139B3;
 Tue, 19 Aug 2025 22:39:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EKTbGhL9pGh+TgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 19 Aug 2025 22:39:14 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Fabian Vogt <fvogt@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH 1/4] hw/intc/xics: Add missing call to register
 vmstate_icp_server
Date: Tue, 19 Aug 2025 19:39:02 -0300
Message-Id: <20250819223905.2247-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250819223905.2247-1-farosas@suse.de>
References: <20250819223905.2247-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_SEVEN(0.00)[7];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,redhat.com,suse.de,linaro.org,linux.ibm.com];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email];
 URIBL_BLOCKED(0.00)[linaro.org:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 3A18A1F76B
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
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

From: Fabian Vogt <fvogt@suse.de>

An obsolete wrapper function with a workaround was removed entirely,
without restoring the call it wrapped.

Without this, the guest is stuck after savevm/loadvm.

Fixes: 24ee9229fe31 ("ppc/spapr: remove deprecated machine pseries-2.9")
Signed-off-by: Fabian Vogt <fvogt@suse.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/6187781.lOV4Wx5bFT@fvogt-thinkpad
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 hw/intc/xics.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index d9a199e883..200710eb6c 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -335,6 +335,8 @@ static void icp_realize(DeviceState *dev, Error **errp)
             return;
         }
     }
+
+    vmstate_register(NULL, icp->cs->cpu_index, &vmstate_icp_server, icp);
 }
 
 static void icp_unrealize(DeviceState *dev)
-- 
2.35.3


