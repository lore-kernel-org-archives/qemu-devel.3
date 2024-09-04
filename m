Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DEDACD37B4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 12:48:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slpP8-00030B-2i; Wed, 04 Sep 2024 08:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1slpNy-0006n8-9t; Wed, 04 Sep 2024 08:45:22 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1slpNw-0005uU-93; Wed, 04 Sep 2024 08:45:22 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1996E219AE;
 Wed,  4 Sep 2024 12:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725453918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FsP7vs9wLXy+/Qf4dErPzeH4vBCbn1FKP69bjd7sNkE=;
 b=0zr1qR8k9vAiHLBRnhCLjZFrHjgQB7KK0qVJo2EhicPJyO2axUqGf9ADDvbyc19E3LW0mZ
 je4L55RyGyXoVyAbcS8B2ToSfFNOeCPQHeIQpmCm63FFkOCA180GtvOX/2cAShZZuDzlpm
 LBMZLVH29kCxdWW2gK2ZLRhIcOCEntM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725453918;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FsP7vs9wLXy+/Qf4dErPzeH4vBCbn1FKP69bjd7sNkE=;
 b=/NzjHL2Rc4zco/UGgV/b+Vk1kct8dx4yeDOHUZns2P2wGnzPu9vRIkwurR7LTJkOwV0mTH
 87QWtb5k/ttc73BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725453918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FsP7vs9wLXy+/Qf4dErPzeH4vBCbn1FKP69bjd7sNkE=;
 b=0zr1qR8k9vAiHLBRnhCLjZFrHjgQB7KK0qVJo2EhicPJyO2axUqGf9ADDvbyc19E3LW0mZ
 je4L55RyGyXoVyAbcS8B2ToSfFNOeCPQHeIQpmCm63FFkOCA180GtvOX/2cAShZZuDzlpm
 LBMZLVH29kCxdWW2gK2ZLRhIcOCEntM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725453918;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FsP7vs9wLXy+/Qf4dErPzeH4vBCbn1FKP69bjd7sNkE=;
 b=/NzjHL2Rc4zco/UGgV/b+Vk1kct8dx4yeDOHUZns2P2wGnzPu9vRIkwurR7LTJkOwV0mTH
 87QWtb5k/ttc73BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F629139D2;
 Wed,  4 Sep 2024 12:45:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AAD0AVxW2GZuVQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 04 Sep 2024 12:45:16 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Arman Nabiev <nabiev.arman13@gmail.com>, qemu-stable@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 33/34] target/ppc: Fix migration of CPUs with TLB_EMB TLB type
Date: Wed,  4 Sep 2024 09:44:16 -0300
Message-Id: <20240904124417.14565-34-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240904124417.14565-1-farosas@suse.de>
References: <20240904124417.14565-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.20 / 50.00]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 BAYES_HAM(-0.00)[41.71%]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TAGGED_RCPT(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,suse.de:email,suse.de:mid];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[redhat.com,linaro.org,gmail.com,nongnu.org];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
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

From: Arman Nabiev <nabiev.arman13@gmail.com>

In vmstate_tlbemb a cut-and-paste error meant we gave
this vmstate subsection the same "cpu/tlb6xx" name as
the vmstate_tlb6xx subsection. This breaks migration load
for any CPU using the TLB_EMB CPU type, because when we
see the "tlb6xx" name in the incoming data we try to
interpret it as a vmstate_tlb6xx subsection, which it
isn't the right format for:

 $ qemu-system-ppc -drive
 if=none,format=qcow2,file=/home/petmay01/test-images/virt/dummy.qcow2
 -monitor stdio -M bamboo
 QEMU 9.0.92 monitor - type 'help' for more information
 (qemu) savevm foo
 (qemu) loadvm foo
 Missing section footer for cpu
 Error: Error -22 while loading VM state

Correct the incorrect vmstate section name. Since migration
for these CPU types was completely broken before, we don't
need to care that this is a migration compatibility break.

This affects the PPC 405, 440, 460 and e200 CPU families.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2522
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Arman Nabiev <nabiev.arman13@gmail.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 target/ppc/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index 731dd8df35..d433fd45fc 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -621,7 +621,7 @@ static bool tlbemb_needed(void *opaque)
 }
 
 static const VMStateDescription vmstate_tlbemb = {
-    .name = "cpu/tlb6xx",
+    .name = "cpu/tlbemb",
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = tlbemb_needed,
-- 
2.35.3


