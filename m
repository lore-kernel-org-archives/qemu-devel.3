Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C88C55174
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 16:23:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wreOn-0004GS-AX; Wed, 05 Aug 2026 12:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mpatocka@redhat.com>)
 id 1wreOk-0004CN-D8
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 12:23:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mpatocka@redhat.com>)
 id 1wreOg-0007S8-CY
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 12:23:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785946992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=UV1a1GUQzrfupq7bpNH7AnYHi9xGtwR/UiQyeOUpwiM=;
 b=cNuiEwVKBHv667j/HX2NvBSuBJNs++sEzFT2O8ew2U1EHLXzi3AuV8M2cakmG8wBUTuFMs
 gIT1qUl4xWyLWwla3xfk4e+VfgF4MWvyF6sB3iV+u35cES/kQ8Q7o8CknT89vUfi9CHT0o
 /9s9Q+3VzPAxpyGpklSojUJ9IibB4wU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-nmfqkuB7NhSUJxkEEyqItw-1; Wed,
 05 Aug 2026 12:23:09 -0400
X-MC-Unique: nmfqkuB7NhSUJxkEEyqItw-1
X-Mimecast-MFC-AGG-ID: nmfqkuB7NhSUJxkEEyqItw_1785946988
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1B1A51955BD0; Wed,  5 Aug 2026 16:23:08 +0000 (UTC)
Received: from [10.44.32.79] (unknown [10.44.32.79])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9905219560AB; Wed,  5 Aug 2026 16:23:06 +0000 (UTC)
Date: Wed, 5 Aug 2026 18:23:04 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Richard Henderson <richard.henderson@linaro.org>
cc: qemu-devel@nongnu.org
Subject: [PATCH v2] linux-user/sh4: Deliver SIGILL on invalid instruction
Message-ID: <9691a731-5d0c-15b7-e773-60bac1f54fc8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mpatocka@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

On invalid instruction, deliver SIGILL rather than crashing the whole
process unconditionally.

Cc: qemu-stable@nongnu.org
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 linux-user/sh4/cpu_loop.c |    7 +++++++
 1 file changed, 7 insertions(+)

Index: qemu/linux-user/sh4/cpu_loop.c
===================================================================
--- qemu.orig/linux-user/sh4/cpu_loop.c	2026-08-05 18:05:44.000000000 +0200
+++ qemu/linux-user/sh4/cpu_loop.c	2026-08-05 18:12:12.000000000 +0200
@@ -64,6 +64,13 @@ void cpu_loop(CPUSH4State *env)
             cpu_exec_step_atomic(cs);
             arch_interrupt = false;
             break;
+        case 0x180:
+            /* Illegal instruction */
+            /* fallthrough */
+        case 0x1a0:
+            /* Illegal instruction in delay slot */
+            force_sig_fault(TARGET_SIGILL, TARGET_ILL_ILLOPC, env->pc);
+            break;
         default:
             fprintf(stderr, "Unhandled trap: 0x%x\n", trapnr);
             cpu_dump_state(cs, stderr, 0);


