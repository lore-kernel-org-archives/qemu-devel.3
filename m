Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D12C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 15:16:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzHnd-0007FU-KJ; Tue, 23 Apr 2024 11:11:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHnQ-0005uT-NQ
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:11:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHnO-0000OQ-8K
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:11:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713885057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q3fpgaieZvwFn+gr9nqsWuIGSElEFdOvEUynxMqPGDs=;
 b=PC1PMN8R9gXPfSNjiyENZovWCELgow7KmCOrf5VEQPmJkgaYrKzNQMVRE2y2z/RRDU3QGT
 eX15ex4ddI5bhoTc3qqreepgU2e+oAA0ma72RAbMjDdC7qZuu73MwthiayBeAspdCS3/wE
 QF8WBsnewBZ0GZwIWqZQN4R2UVofctI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-yDxWjvVHOZ2dFBy-PhcAgg-1; Tue, 23 Apr 2024 11:10:55 -0400
X-MC-Unique: yDxWjvVHOZ2dFBy-PhcAgg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 93904812C5F;
 Tue, 23 Apr 2024 15:10:55 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.192.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 09A5F200E290;
 Tue, 23 Apr 2024 15:10:54 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 63/63] target/i386/translate.c: always write 32-bits for SGDT
 and SIDT
Date: Tue, 23 Apr 2024 17:09:51 +0200
Message-ID: <20240423150951.41600-64-pbonzini@redhat.com>
In-Reply-To: <20240423150951.41600-1-pbonzini@redhat.com>
References: <20240423150951.41600-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

The various Intel CPU manuals claim that SGDT and SIDT can write either 24-bits
or 32-bits depending upon the operand size, but this is incorrect. Not only do
the Intel CPU manuals give contradictory information between processor
revisions, but this information doesn't even match real-life behaviour.

In fact, tests on real hardware show that the CPU always writes 32-bits for SGDT
and SIDT, and this behaviour is required for at least OS/2 Warp and WFW 3.11 with
Win32s to function correctly. Remove the masking applied due to the operand size
for SGDT and SIDT so that the TCG behaviour matches the behaviour on real
hardware.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2198

--
MCA: Whilst I don't have a copy of OS/2 Warp handy, I've confirmed that this
patch fixes the issue in WFW 3.11 with Win32s. For more technical information I
highly recommend the excellent write-up at
https://www.os2museum.com/wp/sgdtsidt-fiction-and-reality/.
Message-ID: <20240419195147.434894-1-mark.cave-ayland@ilande.co.uk>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 76a42c679c7..c05d9e52259 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -5846,9 +5846,10 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
             gen_op_st_v(s, MO_16, s->T0, s->A0);
             gen_add_A0_im(s, 2);
             tcg_gen_ld_tl(s->T0, tcg_env, offsetof(CPUX86State, gdt.base));
-            if (dflag == MO_16) {
-                tcg_gen_andi_tl(s->T0, s->T0, 0xffffff);
-            }
+            /*
+             * NB: Despite a confusing description in Intel CPU documentation,
+             *     all 32-bits are written regardless of operand size.
+             */
             gen_op_st_v(s, CODE64(s) + MO_32, s->T0, s->A0);
             break;
 
@@ -5901,9 +5902,10 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
             gen_op_st_v(s, MO_16, s->T0, s->A0);
             gen_add_A0_im(s, 2);
             tcg_gen_ld_tl(s->T0, tcg_env, offsetof(CPUX86State, idt.base));
-            if (dflag == MO_16) {
-                tcg_gen_andi_tl(s->T0, s->T0, 0xffffff);
-            }
+            /*
+             * NB: Despite a confusing description in Intel CPU documentation,
+             *     all 32-bits are written regardless of operand size.
+             */
             gen_op_st_v(s, CODE64(s) + MO_32, s->T0, s->A0);
             break;
 
-- 
2.44.0


