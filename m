Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38378C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 14:32:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzEdO-0001CT-Ht; Wed, 26 Aug 2026 10:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzEdM-0001Be-Md
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 10:29:44 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzEdL-0001z4-2s
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 10:29:44 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 89E911F810;
 Wed, 26 Aug 2026 14:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787754577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F9yJ3RLbH84d6XW+2lCMAgvOPxksUFhx40vXtd8SCNM=;
 b=iGUmXjz9kgXgQj1Bh/glWoOCvjNBCvPRyPr9/h6qCQSqvpOnKT6u4XZJqwG5wb72BKlPSe
 G4Q3EueCXo9s89UjnGJcs/LVdB29zrvPr8ulKGVXd6otyteMBDHKFaQURYgwEyt0B6BLBH
 bqkSPuJP6knRCS1McpZ0UxPJzgOhGzw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787754577;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F9yJ3RLbH84d6XW+2lCMAgvOPxksUFhx40vXtd8SCNM=;
 b=Yslpfypctyon7kIlVufEv7xMiQYaObP4d9fBRNsbnkDO8ZHu+ePPWtRGNe1QcdsSrhAwCI
 /UjhSgydt693+pDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787754573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F9yJ3RLbH84d6XW+2lCMAgvOPxksUFhx40vXtd8SCNM=;
 b=HuKKE9bCDnhzIJSsXBcGgVZSg2mIX40Ad+uqP6MJrNX+eaTp2qjpVWhtuMI8s48+/IEZ1D
 AbDsBlAuLzX4c3mgqwVw6AxoTQngBXz3evpTD++osz9O8up01SdeL7Cvl+1ltDqYN1gIXS
 n1oVD7BYowi3qfYYgmTl8BaYZLdKN58=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787754573;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F9yJ3RLbH84d6XW+2lCMAgvOPxksUFhx40vXtd8SCNM=;
 b=umQI/Iix50mLc0deMA7Rsi6BY9PPpV7aEfeozh9DDBlhgVKekOQ4mU0pofqlS2jFrxIevC
 X0I3Aa47dYiQ49AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9AA1E1364B;
 Wed, 26 Aug 2026 14:29:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uO3fGkz4jmpTJAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 26 Aug 2026 14:29:32 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Jinpu Wang <jinpu.wang@cloud.ionos.com>
Subject: [PULL 18/30] migration/rdma: Sanity check
 RDMA_CONTROL_REGISTER_REQUEST on buflen
Date: Wed, 26 Aug 2026 11:28:53 -0300
Message-ID: <20260826142905.2315503-19-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826142905.2315503-1-farosas@suse.de>
References: <20260826142905.2315503-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.77 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.17)[-0.846];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,ionos.com:email,gitlab.com:url];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url,suse.de:mid,suse.de:email,ionos.com:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
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


