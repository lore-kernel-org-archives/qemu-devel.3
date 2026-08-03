Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1BF9C55182
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 19:40:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqyW5-0000Y1-Sq; Mon, 03 Aug 2026 15:40:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mpatocka@redhat.com>)
 id 1wqyW4-0000Xt-I3
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 15:40:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mpatocka@redhat.com>)
 id 1wqyW2-00052v-RF
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 15:40:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785786001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=jhxxe5YH1XoA2W6fjeD0OvEICcTahHqGGvfqyuhxkLY=;
 b=TnYLPrJqMJU0lWpmjvY0t7xxJJHhhVxOvPdb05cQI9Dx04C17VMd9EKyaCUyCZIZryMFjY
 KxeBoQ/8pX1Mz3WiLrqF7pKT33kBGbVmzDk29bz1sgAud9FKHNEZGFMG5Of/gMZiec2/kQ
 LeBbUQ+r1mq8KpBejJfybLsKQL2Iplc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-IZ0K9hK0P_2UVrn5Jod7GA-1; Mon,
 03 Aug 2026 15:38:41 -0400
X-MC-Unique: IZ0K9hK0P_2UVrn5Jod7GA-1
X-Mimecast-MFC-AGG-ID: IZ0K9hK0P_2UVrn5Jod7GA_1785785920
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C9256195609F; Mon,  3 Aug 2026 19:38:39 +0000 (UTC)
Received: from [10.44.32.79] (unknown [10.44.32.79])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7AB0D1800480; Mon,  3 Aug 2026 19:38:38 +0000 (UTC)
Date: Mon, 3 Aug 2026 21:38:32 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Richard Henderson <richard.henderson@linaro.org>
cc: qemu-devel@nongnu.org
Subject: [PATCH] linux-user/sh4: Fix crashes on signal delivery in conditional
 delay slot
Message-ID: <99f60fb8-e9db-e775-38db-44df9514a4c7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mpatocka@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.811,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

If we get a signal in the delay slot, we must roll-back the PC to the
jump instruction. This was already fixed by the commit 3b894b699c9a
("linux-user/sh4: Fix crashes on signal delivery"), however this fix
omits a test for TB_FLAG_DELAY_SLOT_COND. TB_FLAG_DELAY_SLOT_COND is set
by the conditional delayed branches bf/s and bt/s. Qemu did not roll-back
the PC in this case, resulting in incorrect program execution.

This patch fixes it.

Cc: qemu-stable@nongnu.org
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 linux-user/sh4/signal.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: qemu/linux-user/sh4/signal.c
===================================================================
--- qemu.orig/linux-user/sh4/signal.c	2026-08-02 18:02:30.000000000 +0200
+++ qemu/linux-user/sh4/signal.c	2026-08-02 18:03:09.000000000 +0200
@@ -109,7 +109,7 @@ static void unwind_gusa(CPUSH4State *reg
            the SP, otherwise we would be pushing the signal context to
            invalid memory.  */
         regs->gregs[15] = regs->gregs[1];
-    } else if (regs->flags & TB_FLAG_DELAY_SLOT) {
+    } else if (regs->flags & (TB_FLAG_DELAY_SLOT | TB_FLAG_DELAY_SLOT_COND)) {
         /* If we are in a delay slot, push the previous instruction.  */
         regs->pc -= 2;
     }


