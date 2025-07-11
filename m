Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2CDBC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 14:19:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaEWf-0000bY-FS; Fri, 11 Jul 2025 10:14:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uaETP-0001pv-J5
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:11:44 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uaETL-0006iQ-S3
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:11:34 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E8ABA21197;
 Fri, 11 Jul 2025 14:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752243063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o9QJlhQ/lxb/HDco23SyqNvtvSX5N8Qjj+ieM9lAfNQ=;
 b=JMkXFVvTiTT2+GaQYHiTIHtugZ2oL5WVut61yTHCUmBeZ0IZimn7T98oxe0U2VURd8GFD7
 2av+ptW6ZLDh3IVGEq+nxrT8jBRX80swy9nW280Ydg6iw/8SgLUd9XDk560zJrdNooXOqb
 DlBceyE+u0I4qak7QOm+4HNCxtue0+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752243063;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o9QJlhQ/lxb/HDco23SyqNvtvSX5N8Qjj+ieM9lAfNQ=;
 b=01P3cbhi17LnPL4Vr/3JC7Yy1KtCOLMXAl7C4JamPQFhup4i4BT8nhLpcF+Ra3GJhD/h2M
 ky8IEAsrPUWAwgDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752243062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o9QJlhQ/lxb/HDco23SyqNvtvSX5N8Qjj+ieM9lAfNQ=;
 b=Ah7Kd2g4A5tbXsOqFzPqJ+a0GaIcBm7ObBCuItu5m0anunt9G+hmVMLiRhZKHMAVni6NfD
 ueYIZXd93jkKFqL0XCMPPDfNCo7Obbq4SWLf9ItbFy0Pd3kuvMjkHzD+UQoZxqieHjwgTg
 gNatM//vN0E9RXBI2fcapDuq3G2j0HM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752243062;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o9QJlhQ/lxb/HDco23SyqNvtvSX5N8Qjj+ieM9lAfNQ=;
 b=nUNkFGEB8V5/yUOK1qqr+FLLEsxSyLjUINvr/OCC5l8FxZn8hjlqj6OdZ6VSOYci246LT6
 +clCpZTgrkmlEfAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D84761388B;
 Fri, 11 Jul 2025 14:11:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8JRQJXUbcWg7TgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 11 Jul 2025 14:11:01 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 14/26] migration/postcopy: Drop all atomic ops in blocktime
 feature
Date: Fri, 11 Jul 2025 11:10:19 -0300
Message-Id: <20250711141031.423-15-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250711141031.423-1-farosas@suse.de>
References: <20250711141031.423-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Now with the mutex protection it's not needed anymore.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20250613141217.474825-4-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/postcopy-ram.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 32fa06dabd..81925532de 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -849,12 +849,12 @@ void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
 
     low_time_offset = get_low_time_offset(dc);
     if (dc->vcpu_addr[cpu] == 0) {
-        qatomic_inc(&dc->smp_cpus_down);
+        dc->smp_cpus_down++;
     }
 
-    qatomic_xchg(&dc->last_begin, low_time_offset);
-    qatomic_xchg(&dc->page_fault_vcpu_time[cpu], low_time_offset);
-    qatomic_xchg(&dc->vcpu_addr[cpu], addr);
+    dc->last_begin = low_time_offset;
+    dc->page_fault_vcpu_time[cpu] = low_time_offset;
+    dc->vcpu_addr[cpu] = addr;
 
     /*
      * The caller should only inject a blocktime entry when the page is
@@ -915,29 +915,26 @@ static void mark_postcopy_blocktime_end(uintptr_t addr)
     for (i = 0; i < smp_cpus; i++) {
         uint32_t vcpu_blocktime = 0;
 
-        read_vcpu_time = qatomic_fetch_add(&dc->page_fault_vcpu_time[i], 0);
-        if (qatomic_fetch_add(&dc->vcpu_addr[i], 0) != addr ||
-            read_vcpu_time == 0) {
+        read_vcpu_time = dc->page_fault_vcpu_time[i];
+        if (dc->vcpu_addr[i] != addr || read_vcpu_time == 0) {
             continue;
         }
-        qatomic_xchg(&dc->vcpu_addr[i], 0);
+        dc->vcpu_addr[i] = 0;
         vcpu_blocktime = low_time_offset - read_vcpu_time;
         affected_cpu += 1;
         /* we need to know is that mark_postcopy_end was due to
          * faulted page, another possible case it's prefetched
          * page and in that case we shouldn't be here */
-        if (!vcpu_total_blocktime &&
-            qatomic_fetch_add(&dc->smp_cpus_down, 0) == smp_cpus) {
+        if (!vcpu_total_blocktime && dc->smp_cpus_down == smp_cpus) {
             vcpu_total_blocktime = true;
         }
         /* continue cycle, due to one page could affect several vCPUs */
         dc->vcpu_blocktime[i] += vcpu_blocktime;
     }
 
-    qatomic_sub(&dc->smp_cpus_down, affected_cpu);
+    dc->smp_cpus_down -= affected_cpu;
     if (vcpu_total_blocktime) {
-        dc->total_blocktime += low_time_offset - qatomic_fetch_add(
-                &dc->last_begin, 0);
+        dc->total_blocktime += low_time_offset - dc->last_begin;
     }
     trace_mark_postcopy_blocktime_end(addr, dc, dc->total_blocktime,
                                       affected_cpu);
-- 
2.35.3


