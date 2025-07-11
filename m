Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E8EC83F21
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 14:22:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaEcA-0000R6-Sg; Fri, 11 Jul 2025 10:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uaEUG-0003Al-SV
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:12:33 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uaEUE-0006so-G3
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:12:28 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 97F921F46E;
 Fri, 11 Jul 2025 14:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752243076; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UWNsbznBa5U705aIiyQeomhLV9xkwjgD4c9PNhvCW+A=;
 b=q7vBqWO1gicb2ohYijgWxAayORK5P1GUlZWivxUE6xagWUdWp2vfGrEo/zZug0NnFGUrYP
 KumiCHD5DwNO2OD2CK41D24gK4vK7TP7s/ofihwDxCe3OTvQgsl9Y8zwfzlQOvkR1nv3jR
 5XpU+aRzMIC9xsXGuMNQ7Ezv/Ct/3rA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752243076;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UWNsbznBa5U705aIiyQeomhLV9xkwjgD4c9PNhvCW+A=;
 b=O+VRGvt8ANLGGtbBTFrvnetYIXZnYUEu+g1u0jmDlDSKMRFpbDfXlsZ1yhuUy3aK9PBIt/
 r5uxPERO6/DhXBAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=q7vBqWO1;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=O+VRGvt8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752243076; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UWNsbznBa5U705aIiyQeomhLV9xkwjgD4c9PNhvCW+A=;
 b=q7vBqWO1gicb2ohYijgWxAayORK5P1GUlZWivxUE6xagWUdWp2vfGrEo/zZug0NnFGUrYP
 KumiCHD5DwNO2OD2CK41D24gK4vK7TP7s/ofihwDxCe3OTvQgsl9Y8zwfzlQOvkR1nv3jR
 5XpU+aRzMIC9xsXGuMNQ7Ezv/Ct/3rA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752243076;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UWNsbznBa5U705aIiyQeomhLV9xkwjgD4c9PNhvCW+A=;
 b=O+VRGvt8ANLGGtbBTFrvnetYIXZnYUEu+g1u0jmDlDSKMRFpbDfXlsZ1yhuUy3aK9PBIt/
 r5uxPERO6/DhXBAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 836191388B;
 Fri, 11 Jul 2025 14:11:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UMK1D4MbcWg7TgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 11 Jul 2025 14:11:15 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 22/26] migration/postcopy: Cleanup the total blocktime
 accounting
Date: Fri, 11 Jul 2025 11:10:27 -0300
Message-Id: <20250711141031.423-23-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250711141031.423-1-farosas@suse.de>
References: <20250711141031.423-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 97F921F46E
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

The variable vcpu_total_blocktime isn't easy to follow.  In reality, it
wants to capture the case where all vCPUs are stopped, and now there will
be some vCPUs starts running.

The name now starts to conflict with vcpu_blocktime_total[], meanwhile it's
actually not necessary to have the variable at all: since nobody is
touching smp_cpus_down except ourselves, we can safely do the calculation
at the end before decrementing smp_cpus_down.

Hopefully this makes the logic easier to read, side benefit is we drop one
temp var.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20250613141217.474825-12-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/postcopy-ram.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index bf65d6035c..fd6c0bdb1e 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -972,7 +972,6 @@ static void mark_postcopy_blocktime_end(uintptr_t addr)
     MachineState *ms = MACHINE(qdev_get_machine());
     unsigned int smp_cpus = ms->smp.cpus;
     int i, affected_cpu = 0;
-    bool vcpu_total_blocktime = false;
     uint64_t read_vcpu_time, current;
 
     if (!dc) {
@@ -994,20 +993,19 @@ static void mark_postcopy_blocktime_end(uintptr_t addr)
         dc->vcpu_addr[i] = 0;
         vcpu_blocktime = current - read_vcpu_time;
         affected_cpu += 1;
-        /* we need to know is that mark_postcopy_end was due to
-         * faulted page, another possible case it's prefetched
-         * page and in that case we shouldn't be here */
-        if (!vcpu_total_blocktime && dc->smp_cpus_down == smp_cpus) {
-            vcpu_total_blocktime = true;
-        }
         /* continue cycle, due to one page could affect several vCPUs */
         dc->vcpu_blocktime_total[i] += vcpu_blocktime;
     }
 
-    dc->smp_cpus_down -= affected_cpu;
-    if (vcpu_total_blocktime) {
+    /*
+     * If all vCPUs used to be down, and copying this page would free some
+     * vCPUs, then the system-level blocktime ends here.
+     */
+    if (dc->smp_cpus_down == smp_cpus && affected_cpu) {
         dc->total_blocktime += current - dc->last_begin;
     }
+    dc->smp_cpus_down -= affected_cpu;
+
     trace_mark_postcopy_blocktime_end(addr, dc->total_blocktime,
                                       affected_cpu);
 }
-- 
2.35.3


