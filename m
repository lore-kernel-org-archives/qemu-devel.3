Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF1CE7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 20:45:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKkcX-0007xV-7H; Mon, 09 Dec 2024 15:44:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tKkcU-0007wZ-O8
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 15:44:42 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tKkcT-0003wg-7c
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 15:44:42 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 14EA81F460;
 Mon,  9 Dec 2024 20:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733777078; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MN/ps47QCLiCbhneHiKjWtlETa8gj2DQ40VgoeWZc6M=;
 b=iDVKv/gEnh48vqD1QJQ4oS1XXDc0YF5W8Je0QGTr1IRGF2ZAJEXZovNd5ZUwtNZwj9osQj
 kF/S2+xe4IQ5T3jf5FEDWMGpSDsz901sLWcosDGo+4CozGbWl6VKbvCLkPhNxqXlSoRX8+
 01sFHRiNbJzDDoe1oG6usqWapstCgug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733777078;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MN/ps47QCLiCbhneHiKjWtlETa8gj2DQ40VgoeWZc6M=;
 b=AoowlOhbZrK9phUGBAM6KNhnBynUUhj1K0ejYYwXMCvc6M84ArT4UTzH3T+i0mm/fC6s6Z
 64cu19cLVdoJnTCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733777078; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MN/ps47QCLiCbhneHiKjWtlETa8gj2DQ40VgoeWZc6M=;
 b=iDVKv/gEnh48vqD1QJQ4oS1XXDc0YF5W8Je0QGTr1IRGF2ZAJEXZovNd5ZUwtNZwj9osQj
 kF/S2+xe4IQ5T3jf5FEDWMGpSDsz901sLWcosDGo+4CozGbWl6VKbvCLkPhNxqXlSoRX8+
 01sFHRiNbJzDDoe1oG6usqWapstCgug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733777078;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MN/ps47QCLiCbhneHiKjWtlETa8gj2DQ40VgoeWZc6M=;
 b=AoowlOhbZrK9phUGBAM6KNhnBynUUhj1K0ejYYwXMCvc6M84ArT4UTzH3T+i0mm/fC6s6Z
 64cu19cLVdoJnTCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DBC75138D2;
 Mon,  9 Dec 2024 20:44:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sEPzJ7RWV2ebbwAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 09 Dec 2024 20:44:36 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4/6] tests/qtest/virtio-iommu-test: Don't pass uninitialized
 data into qtest_memwrite
Date: Mon,  9 Dec 2024 17:44:25 -0300
Message-Id: <20241209204427.17763-5-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241209204427.17763-1-farosas@suse.de>
References: <20241209204427.17763-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Valgrind complains about:

Use of uninitialised value of size 8
&
Conditional jump or move depends on uninitialised value(s)

both at:
   at 0x5265931: _itoa_word (_itoa.c:180)
   by 0x527EEC7: __vfprintf_internal (vfprintf-internal.c:1687)
   by 0x528C8B0: __vsprintf_internal (iovsprintf.c:96)
   by 0x526B920: sprintf (sprintf.c:30)
   by 0x1296C7: qtest_memwrite (libqtest.c:1273)
   by 0x193C04: send_map (virtio-iommu-test.c:125)
   by 0x194392: test_attach_detach (virtio-iommu-test.c:214)
   by 0x17BDE7: run_one_test (qos-test.c:181)
   by 0x4B0699D: test_case_run (gtestutils.c:2900)
   by 0x4B0699D: g_test_run_suite_internal (gtestutils.c:2988)
   by 0x4B068B2: g_test_run_suite_internal (gtestutils.c:3005)
   by 0x4B068B2: g_test_run_suite_internal (gtestutils.c:3005)
   by 0x4B068B2: g_test_run_suite_internal (gtestutils.c:3005)
 Uninitialised value was created by a stack allocation
   at 0x193AFD: send_map (virtio-iommu-test.c:103)

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/virtio-iommu-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/virtio-iommu-test.c b/tests/qtest/virtio-iommu-test.c
index afb225971d..98ffa27912 100644
--- a/tests/qtest/virtio-iommu-test.c
+++ b/tests/qtest/virtio-iommu-test.c
@@ -105,7 +105,7 @@ static int send_map(QTestState *qts, QVirtioIOMMU *v_iommu,
     QVirtQueue *vq = v_iommu->vq;
     uint64_t ro_addr, wr_addr;
     uint32_t free_head;
-    struct virtio_iommu_req_map req;
+    struct virtio_iommu_req_map req = {};
     size_t ro_size = sizeof(req) - sizeof(struct virtio_iommu_req_tail);
     size_t wr_size = sizeof(struct virtio_iommu_req_tail);
     struct virtio_iommu_req_tail buffer;
@@ -147,7 +147,7 @@ static int send_unmap(QTestState *qts, QVirtioIOMMU *v_iommu,
     QVirtQueue *vq = v_iommu->vq;
     uint64_t ro_addr, wr_addr;
     uint32_t free_head;
-    struct virtio_iommu_req_unmap req;
+    struct virtio_iommu_req_unmap req = {};
     size_t ro_size = sizeof(req) - sizeof(struct virtio_iommu_req_tail);
     size_t wr_size = sizeof(struct virtio_iommu_req_tail);
     struct virtio_iommu_req_tail buffer;
-- 
2.35.3


