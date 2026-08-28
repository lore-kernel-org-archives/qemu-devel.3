Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC0E7C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 16:01:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzyzS-0001Wp-2I; Fri, 28 Aug 2026 11:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzyzQ-0001Pp-04
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 11:59:36 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzyzF-0008Rb-6i
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 11:59:35 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0BE451FB86;
 Fri, 28 Aug 2026 15:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787932758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F9yJ3RLbH84d6XW+2lCMAgvOPxksUFhx40vXtd8SCNM=;
 b=ADHz0oVRZz5YScbUn37VnVHevXw+SeKZI7DwM3EgGsz3vcHARr0E8G6SKcBdoMmMjGK7PZ
 VkxybhtgEeMMzlZtkIrmJYQ2MQhxk6aWaogPZN3ypyquLubYcGMH7BjPdxRNLQTJvM5C0r
 x2szG+Nc9gGkGttnawuw8NIQ4AbQuo8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787932758;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F9yJ3RLbH84d6XW+2lCMAgvOPxksUFhx40vXtd8SCNM=;
 b=MLJY3v4M5x4CokGhihAfmwZVxgdiifd++0sa8B/q9F/cyhaKP62n0d1DIDRjsmHLjiZso9
 b/IB0jLFVJqjMPDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787932754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F9yJ3RLbH84d6XW+2lCMAgvOPxksUFhx40vXtd8SCNM=;
 b=SgE/wGB0zWrAITVspIsYvRJ3uTCIuWroMq/nkLk85Bla+1NwGktGeqk39k5dotfwwJuTa+
 83l3wa5eaGUOeP7EdZ7TuvTzRWt/LprOrEVTc9RWPNLL1iAI8uZ92XOP6FqXlr5dU5BuR2
 ArGljrACK15MJn+dkEwnlY9seMjdvdw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787932754;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F9yJ3RLbH84d6XW+2lCMAgvOPxksUFhx40vXtd8SCNM=;
 b=6OQGbT9Cj5P5jjIArQAgGDqqX4CBMqXKsk++QPY4Lx57S0HeNv87Iebo36GpWC1UlaDbbr
 jH5a2vDWFAA8x8BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0396513694;
 Fri, 28 Aug 2026 15:59:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KICAMVCwkWpoBQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 28 Aug 2026 15:59:12 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Jinpu Wang <jinpu.wang@cloud.ionos.com>
Subject: [PULL v2 18/30] migration/rdma: Sanity check
 RDMA_CONTROL_REGISTER_REQUEST on buflen
Date: Fri, 28 Aug 2026 12:58:33 -0300
Message-ID: <20260828155845.2874508-19-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828155845.2874508-1-farosas@suse.de>
References: <20260828155845.2874508-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.993];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url,suse.de:email,suse.de:mid,ionos.com:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
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

From: Peter Xu <peterx@redhat.com>

RDMA header supports head.repeat on RDMA_CONTROL_REGISTER_REQUEST, which
can include >1 memory registrations.  The current code did check over
head.repeat to guard against RDMA_CONTROL_MAX_COMMANDS_PER_MESSAGE, however
it didn't further check the buffer size (head.len) to make sure the
received data is large enough to include the repeated entries.  Check it.

This is almost only to harden this piece of code, in reality on source side
QEMU never uses repeat>1..  However since it's a protocol, still keep it.
Check the buffer size instead.

In case it's not obvious to new RDMA readers: head.len should be the size
RDMA has last received, as qemu_rdma_exchange_get_response() checked on it
against byte_len (which was further fetched from ibv_wc.byte_len in
qemu_rdma_poll()).

Reported-by: Tristan (@TristanInSec)
Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4028
Reviewed-by: Jinpu Wang <jinpu.wang@cloud.ionos.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/rdma.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/migration/rdma.c b/migration/rdma.c
index 683c24ba4dd..f7356e759fc 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3360,6 +3360,14 @@ int rdma_registration_handle(QEMUFile *f)
             reg_resp.repeat = head.repeat;
             registers = (RDMARegister *) rdma->wr_data[idx].control_curr;
 
+            /* Making sure the register buffers to read are valid */
+            if (head.len != head.repeat * sizeof(RDMARegister)) {
+                error_report("%s: Invalid RDMA_CONTROL_REGISTER_REQUEST "
+                             "(head.repeat=%"PRIu32", head.len=%"PRIu32")",
+                             __func__, head.repeat, head.len);
+                goto err;
+            }
+
             for (int count = 0; count < head.repeat; count++) {
                 uint64_t chunk;
                 uint8_t *chunk_start, *chunk_end;
-- 
2.53.0


