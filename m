Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04631C55184
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 09:00:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrAzk-0007X1-Kl; Tue, 04 Aug 2026 04:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mpatocka@redhat.com>)
 id 1wrAzi-0007WU-GO
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 04:59:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mpatocka@redhat.com>)
 id 1wrAzg-0003EZ-U7
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 04:59:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785833967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=PUCRwA+bUw62h+ogH/Fji4Fq9p/iOalBFNMvNXXrtVI=;
 b=PvpnmqiypRUGq0+U48NtZyJ3/VT+S3eH4mFTNoSG9Oyd39kNlVvsD9Yt4DH+NC35S6D9n5
 iEOQmyw1ByhmxWiLWBGgIN/MKsJlkADu32YQVcJ5ImN6ookiyVqyBeGEFF/l67Ep67BVYb
 lNLvlR9SApHMO6qskYHXxHOHLLSThBk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-360-C_OZw7iWOny_-oFo7DVODw-1; Tue,
 04 Aug 2026 04:59:25 -0400
X-MC-Unique: C_OZw7iWOny_-oFo7DVODw-1
X-Mimecast-MFC-AGG-ID: C_OZw7iWOny_-oFo7DVODw_1785833965
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ADC9D18002AB; Tue,  4 Aug 2026 08:59:24 +0000 (UTC)
Received: from [10.44.32.79] (unknown [10.44.32.79])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 74163195422C; Tue,  4 Aug 2026 08:59:23 +0000 (UTC)
Date: Tue, 4 Aug 2026 10:59:18 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Richard Henderson <richard.henderson@linaro.org>
cc: qemu-devel@nongnu.org
Subject: [PATCH] linux-user/sh4: Initialize the FPSCR register on signal
Message-ID: <22c7eceb-286c-090c-a128-f8a35565e560@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mpatocka@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.811,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On the SH4 architecture, the instructions that perform single precision
and double precision floating point operations are encoded in the same
way. The bit PR in the FPSCR register determines if the CPU performs
single or double operation.

According to the ABI, the PR bit must be set at function entry and
function exit.

GCC generates code that flips this bit as needed during function
execution. If we get a signal, we must set the PR bit, so that the signal
handler finds the bit in the expected state. Qemu lacked this logic, so
that if the signal interrupts single-precision floating point
calculation, the PR bit would be incorrectly clear at signal handler
entry. If the signal handler performed some floating-point calculation,
it would get incorrect result.

This patch fixes the bug, by initializing the FPSCR register at signal
entry. Note that we initialize the whole register, because the Linux
kernel initializes the whole register too.

Cc: qemu-stable@nongnu.org
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 linux-user/sh4/signal.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: qemu/linux-user/sh4/signal.c
===================================================================
--- qemu.orig/linux-user/sh4/signal.c	2026-08-02 18:03:09.000000000 +0200
+++ qemu/linux-user/sh4/signal.c	2026-08-04 09:40:21.000000000 +0200
@@ -206,6 +206,8 @@ void setup_frame(int sig, struct target_
         __put_user(set->sig[i + 1], &frame->extramask[i]);
     }
 
+    regs->fpscr = FPSCR_PR;
+
     /* Set up to return from userspace.  If provided, use a stub
        already in userspace.  */
     if (ka->sa_flags & TARGET_SA_RESTORER) {
@@ -258,6 +260,8 @@ void setup_rt_frame(int sig, struct targ
         __put_user(set->sig[i], &frame->uc.tuc_sigmask.sig[i]);
     }
 
+    regs->fpscr = FPSCR_PR;
+
     /* Set up to return from userspace.  If provided, use a stub
        already in userspace.  */
     if (ka->sa_flags & TARGET_SA_RESTORER) {


