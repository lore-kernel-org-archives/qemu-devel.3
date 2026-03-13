Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B405F107BCD6
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 18:31:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w17IK-0008W4-U1; Fri, 13 Mar 2026 14:31:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w17HA-0007cG-Ca
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 14:30:23 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w17H8-0005Sb-9F
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 14:30:19 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CF5665BFA0;
 Fri, 13 Mar 2026 18:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773426607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MncAG3t5Y1v2exCQafgl4tCgcp9DxaNWVxRhlbJmQpw=;
 b=Fa10+IZ1j/w1gE6SABzqugP72VohqyvT/WIc07vWtHjR1shyE6X0a1czBBlpmZPQNArS2r
 pFXlWmZ3Prs/w9325UYQTkh6w6fGn7d45sAgz59Y/tiGf3TEldIu20w2DeNoNSs5mbqbjT
 lOqDfu579I7MOfIoKp4UHZeIHEgHCjU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773426607;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MncAG3t5Y1v2exCQafgl4tCgcp9DxaNWVxRhlbJmQpw=;
 b=U2tM/DK23GIpSz06EEy+aZVwe0jNbppmOY7D5Lhnjb9O29gT3nVGv+mc5d/RjB8Cp1kPkw
 iXE4wdAon+vPtwCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773426607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MncAG3t5Y1v2exCQafgl4tCgcp9DxaNWVxRhlbJmQpw=;
 b=Fa10+IZ1j/w1gE6SABzqugP72VohqyvT/WIc07vWtHjR1shyE6X0a1czBBlpmZPQNArS2r
 pFXlWmZ3Prs/w9325UYQTkh6w6fGn7d45sAgz59Y/tiGf3TEldIu20w2DeNoNSs5mbqbjT
 lOqDfu579I7MOfIoKp4UHZeIHEgHCjU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773426607;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MncAG3t5Y1v2exCQafgl4tCgcp9DxaNWVxRhlbJmQpw=;
 b=U2tM/DK23GIpSz06EEy+aZVwe0jNbppmOY7D5Lhnjb9O29gT3nVGv+mc5d/RjB8Cp1kPkw
 iXE4wdAon+vPtwCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE9A340678;
 Fri, 13 Mar 2026 18:30:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QCj0IK1XtGn9MwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 13 Mar 2026 18:30:05 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v1 3/4] target/riscv: Don't leak general_user_opts
Date: Fri, 13 Mar 2026 15:29:55 -0300
Message-ID: <20260313182957.28432-4-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260313182957.28432-1-farosas@suse.de>
References: <20260313182957.28432-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.79 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.19)[-0.951];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[linaro.org,dabbelt.com,wdc.com,gmail.com,ventanamicro.com,linux.alibaba.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
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

The global variable general_user_opts is being assigned twice, losing
the reference to the previously allocated g_hash_table.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 target/riscv/cpu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e56470a374..afccfc2935 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1099,8 +1099,6 @@ static void riscv_cpu_init(Object *obj)
                             "riscv.cpu.rnmi", RNMI_MAX);
 #endif /* CONFIG_USER_ONLY */
 
-    general_user_opts = g_hash_table_new(g_str_hash, g_str_equal);
-
     /*
      * The timer and performance counters extensions were supported
      * in QEMU before they were added as discrete extensions in the
@@ -2751,6 +2749,7 @@ static void riscv_cpu_common_class_init(ObjectClass *c, const void *data)
     cc->tcg_ops = &riscv_tcg_ops;
 #endif /* CONFIG_TCG */
 
+    general_user_opts = g_hash_table_new(g_str_hash, g_str_equal);
     device_class_set_props(dc, riscv_cpu_properties);
 }
 
-- 
2.51.0


