Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 752ADC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 14:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaEcA-0000Ps-Jd; Fri, 11 Jul 2025 10:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uaETv-0002sa-PH
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:12:16 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uaETt-0006pb-TN
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:12:07 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6A70B1F451;
 Fri, 11 Jul 2025 14:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752243069; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J9U1h2MCqxrlE/miqEs5+j53V0GiCpV0gcF61UPWvMQ=;
 b=S17TAfmYuZKHQJpewH9OoQ4YCMLD6X3hIwGyxOTlM8OZ6hqgEp72NBsAA1F0cI3z+Ipjz6
 XLRKtgpEfZ3JZC6chE7ngkbSg/Q1QIvScM08GjoSNMT/lYSsy/KpQFkjA/iOKtACU8Cy40
 Dr3HGxNpzHe4GxOEgYL+mdwcFyO1vtI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752243069;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J9U1h2MCqxrlE/miqEs5+j53V0GiCpV0gcF61UPWvMQ=;
 b=ipu0Q3tCwYY3RrFV8lW7I5cyGVpgRQ9GvkH6iyef+Zt4tzFbPW3iLqxSEBF6BWzatyORUK
 FF2Sdv/UdkoqKeDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=S17TAfmY;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ipu0Q3tC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752243069; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J9U1h2MCqxrlE/miqEs5+j53V0GiCpV0gcF61UPWvMQ=;
 b=S17TAfmYuZKHQJpewH9OoQ4YCMLD6X3hIwGyxOTlM8OZ6hqgEp72NBsAA1F0cI3z+Ipjz6
 XLRKtgpEfZ3JZC6chE7ngkbSg/Q1QIvScM08GjoSNMT/lYSsy/KpQFkjA/iOKtACU8Cy40
 Dr3HGxNpzHe4GxOEgYL+mdwcFyO1vtI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752243069;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J9U1h2MCqxrlE/miqEs5+j53V0GiCpV0gcF61UPWvMQ=;
 b=ipu0Q3tCwYY3RrFV8lW7I5cyGVpgRQ9GvkH6iyef+Zt4tzFbPW3iLqxSEBF6BWzatyORUK
 FF2Sdv/UdkoqKeDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4FAF61388B;
 Fri, 11 Jul 2025 14:11:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yH4LA3wbcWg7TgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 11 Jul 2025 14:11:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 18/26] migration/postcopy: Add blocktime fault counts per-vcpu
Date: Fri, 11 Jul 2025 11:10:23 -0300
Message-Id: <20250711141031.423-19-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250711141031.423-1-farosas@suse.de>
References: <20250711141031.423-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6A70B1F451
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:dkim, suse.de:mid, suse.de:email]
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

From: Peter Xu <peterx@redhat.com>

Add a field to count how many remote faults one vCPU has taken.  So far
it's still not used, but will be soon.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20250613141217.474825-8-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/postcopy-ram.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 9dfa92a62d..15ea106910 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -116,6 +116,8 @@ typedef struct PostcopyBlocktimeContext {
     uint64_t *vcpu_blocktime_start;
     /* blocktime per vCPU */
     uint64_t *vcpu_blocktime_total;
+    /* count of faults per vCPU */
+    uint64_t *vcpu_faults_count;
     /* page address per vCPU */
     uintptr_t *vcpu_addr;
     /* total blocktime when all vCPUs are stopped */
@@ -136,6 +138,7 @@ static void destroy_blocktime_context(struct PostcopyBlocktimeContext *ctx)
 {
     g_free(ctx->vcpu_blocktime_start);
     g_free(ctx->vcpu_blocktime_total);
+    g_free(ctx->vcpu_faults_count);
     g_free(ctx->vcpu_addr);
     g_free(ctx);
 }
@@ -155,6 +158,7 @@ static struct PostcopyBlocktimeContext *blocktime_context_new(void)
 
     ctx->vcpu_blocktime_start = g_new0(uint64_t, smp_cpus);
     ctx->vcpu_blocktime_total = g_new0(uint64_t, smp_cpus);
+    ctx->vcpu_faults_count = g_new0(uint64_t, smp_cpus);
     ctx->vcpu_addr = g_new0(uintptr_t, smp_cpus);
     ctx->exit_notifier.notify = migration_exit_cb;
     qemu_add_exit_notifier(&ctx->exit_notifier);
@@ -857,6 +861,7 @@ void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
     dc->last_begin = current;
     dc->vcpu_blocktime_start[cpu] = current;
     dc->vcpu_addr[cpu] = addr;
+    dc->vcpu_faults_count[cpu]++;
 
     /*
      * The caller should only inject a blocktime entry when the page is
-- 
2.35.3


