Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B41EC61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 14:30:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzEdP-0001CW-4W; Wed, 26 Aug 2026 10:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzEdN-0001C2-UF
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 10:29:45 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzEdM-00020P-8E
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 10:29:45 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CFEEF1F840;
 Wed, 26 Aug 2026 14:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787754579; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wMa2/41ubuJQG7osaYAeN+fD11e+ewIuN36eXzoto9M=;
 b=sfViFL4G8DYPF990Ik1J2C874rQ6/8do1vUFgMVagCaHL+ZHuSBZtLuUWfVOyJhd25qBDV
 q1SNK5zIFNK78eNr0tjdLWWxjf2WF88oM837J7KzBsV+pI07OHB8XuuT0k64va//LCBy6n
 rJ0nL04XWKth2qwtY7xIljoeJVJq0Yg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787754579;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wMa2/41ubuJQG7osaYAeN+fD11e+ewIuN36eXzoto9M=;
 b=XbY2c5aQDDYOBxbc8/sXv8dvSV8Qp1ClRa6/UcgJz8ckMU/U0G2HSZIFzPEobnlJzfPd1I
 Tscur5F47SMGj2AQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=C5wJ6pkK;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=8UFTKFH6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787754574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wMa2/41ubuJQG7osaYAeN+fD11e+ewIuN36eXzoto9M=;
 b=C5wJ6pkKTv5ThDiNxY425jrr5whkwEp4QwF3V9KnGPZX/Z4428MtDHa2fzbncdk+4b2Elr
 cFh3N79E2HYGoeUIcVqvDozRMFclvBtDOTq/vEVxR5HRUSgguunU2zEXM0TpGKrnH+cIik
 skqc2ZSmrky4ioZes6HyNbKHfAgjSjY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787754574;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wMa2/41ubuJQG7osaYAeN+fD11e+ewIuN36eXzoto9M=;
 b=8UFTKFH6huwORz3qdKTeEwb8P6Iapas4/ebzybUdJ5Of0Y/0zUf5rTErV9MrZ1EFkbEzXb
 KptBNA779jfmryAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DFEF31364F;
 Wed, 26 Aug 2026 14:29:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yMPFK034jmpTJAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 26 Aug 2026 14:29:33 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Jinpu Wang <jinpu.wang@cloud.ionos.com>
Subject: [PULL 19/30] migration/rdma: Sanity check
 RDMA_CONTROL_REGISTER_REQUEST chunks
Date: Wed, 26 Aug 2026 11:28:54 -0300
Message-ID: <20260826142905.2315503-20-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826142905.2315503-1-farosas@suse.de>
References: <20260826142905.2315503-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.978]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.de:dkim,ionos.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,gitlab.com:url];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[ionos.com:email,suse.de:email,suse.de:mid,suse.de:dkim,gitlab.com:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: CFEEF1F840
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

From: Peter Xu <peterx@redhat.com>

The value received on wire for head.chunks when registering new RDMA
regions is not correctly checked.  Logically the value can still make
ram_chunk_start() (of ram_chunk_end()) to overflow, having a result pointer
very small, smaller than RDMALocalBlock.local_host_addr.

Add the sanity check.

Reported-by: Tristan (@TristanInSec)
Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4011
Reviewed-by: Jinpu Wang <jinpu.wang@cloud.ionos.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/rdma.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index f7356e759fc..cf6688a4bc3 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3369,7 +3369,7 @@ int rdma_registration_handle(QEMUFile *f)
             }
 
             for (int count = 0; count < head.repeat; count++) {
-                uint64_t chunk;
+                uint64_t chunk, chunk_sum;
                 uint8_t *chunk_start, *chunk_end;
 
                 reg = &registers[count];
@@ -3399,6 +3399,14 @@ int rdma_registration_handle(QEMUFile *f)
                 chunk = ram_chunk_index(block->local_host_addr,
                                         (uint8_t *) host_addr);
                 chunk_start = ram_chunk_start(block, chunk);
+                if (uadd64_overflow(chunk, reg->chunks, &chunk_sum) ||
+                    chunk_sum >= block->nb_chunks) {
+                    error_report("%s: head.chunks contains illegal value"
+                                 " (chunk=%"PRIu64", chunks=%"PRIu64", "
+                                 "nb_chunks=%d)", __func__, chunk,
+                                 reg->chunks, block->nb_chunks);
+                    goto err;
+                }
                 chunk_end = ram_chunk_end(block, chunk + reg->chunks);
                 /* avoid "-Waddress-of-packed-member" warning */
                 uint32_t tmp_rkey = 0;
-- 
2.53.0


