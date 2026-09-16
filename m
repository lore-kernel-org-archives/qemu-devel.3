Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D22BC88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:09:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6lcC-0000zr-Ap; Wed, 16 Sep 2026 05:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6lc3-0000nE-5T; Wed, 16 Sep 2026 05:07:32 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6lbz-0007Eh-9C; Wed, 16 Sep 2026 05:07:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789549558; bh=DtFcovN7LK9oBLwdrBNk9jVzOubxiS4+sfxvfb+EJJ4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=GmVBYDoU7OUHneKkpeQXoLnfc6EJ6xFQGcbt/SCd0MsXlnnWPwAVv/lly+dfKFK1o
 XnBuZhB4GCB0xnYtXttFzlCqy7I/qNJH5fsiVbm+EN7gGGzN4uTLqYDvQfY2HhKebt
 GUBTU8U1h+mVnmgXEUBlctjACnD9eJ/epjYv/R5ErgUDbY+invWwJ6MiNInSlO3GLb
 IEpaTmq+WCu9Ial9kjwaC1r9MKHIhB/Pjv22LjONrnwRzsKjD5tA+8goVUJ1mcxgGo
 SbrtE4xwicVq1gXnkqWw8J1gofPaqwNv4NLL9XpV1tjQvhGoQEzQyJnrjWsh4EACzn
 1AJfp/IFACsAA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B47D91D56C4;
 Wed, 16 Sep 2026 12:05:58 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 60201429E0F;
 Wed, 16 Sep 2026 12:06:41 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 311455A779; Wed, 16 Sep 2026 12:06:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.5 16/57] s390x/sclp: pv: only copy the original SCCB
 buffer
Date: Wed, 16 Sep 2026 12:03:40 +0300
Message-ID: <20260916090516.677749-16-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.5-20260916120417@cover.tls.msk.ru>
References: <qemu-stable-11.0.5-20260916120417@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Christian Borntraeger <borntraeger@linux.ibm.com>

With variable length and EXTENDED_LENGTH_SCCB, some callbacks might
change the length field. For example read SCP info might write a new
length into the SCCB header. We must not use that new length for the
buffer copy, since the buffer was allocated with the original length.
Only the length field in the work SCCB is changed, to indicate the
"necessary" size. Using the new length reads past the allocation, so
tools like ASAN might detect a buffer overrun.

Secure guests do not have EXTENDED_LENGTH_SCCB, and the ultravisor checks
and sanitizes the length field, so no qemu heap contents are exposed to
the guest and the non pv-path already has the same header.length.

Fixes: 0f73c5b30b8b ("s390x: protvirt: SCLP interpretation")
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260814125857.1729543-1-borntraeger@de.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
(cherry picked from commit d7913fac774706a02faef0dc1c4c19df65a5a379)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 9bc3b9a0eb8..106a3382320 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -285,7 +285,7 @@ int sclp_service_call_protected(S390CPU *cpu, uint64_t sccb, uint32_t code)
     sclp_c->execute(sclp, work_sccb, code);
 out_write:
     s390_cpu_pv_mem_write(env_archcpu(env), 0, work_sccb,
-                          be16_to_cpu(work_sccb->h.length));
+                          be16_to_cpu(header.length));
     sclp_c->service_interrupt(sclp, SCLP_PV_DUMMY_ADDR);
     return 0;
 }
-- 
2.47.3


