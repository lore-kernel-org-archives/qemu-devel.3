Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AAE606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 01:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=comstyle.com header.i=@comstyle.com header.a=rsa-sha256 header.s=default header.b=NA4tkKeY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMxZc-0002P0-Ao; Fri, 30 Oct 2026 21:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1xMxZV-0002On-6d
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 21:07:49 -0400
Received: from speedy.comstyle.com ([2607:f938:3000:8::2]
 helo=mail.comstyle.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1xMxZS-0001Yv-ST
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 21:07:48 -0400
Received: from mail.comstyle.com (localhost [127.0.0.1])
 by mail.comstyle.com (Postfix) with ESMTP id 4jGfw075kQz8Pbj;
 Fri, 30 Oct 2026 21:07:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=comstyle.com; h=date
 :from:to:cc:subject:message-id:mime-version:content-type; s=
 default; bh=rJp2uFkRexT2R7XwpfI8lgfPsqc6oa80E8iBFq79koY=; b=NA4t
 kKeYZQw292UuOdChCTdhrRmqg7a+opFDPgxlIp5sIAi5LZ2sH9X2IF/SJkroTRdm
 kuXCcKEYExt+eo5VEB9kYcVh1nIJUpFCufl2QayBegsN0Yym0ZB2fj+jDd3dX6TX
 YFVvUmrg+h2X/OWsYEILB45VLlavdXdWn3mGv0A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=date:from:to
 :cc:subject:message-id:mime-version:content-type; q=dns; s=
 default; b=de24i9neCWbytGKW4VWK7/v1lxrN7j3BmrRABhfxeE2DXW1xfFj1T
 C/B7NXzCj6mx9KybvBvidj/+2jZTWMKlzo1inyNPXjRfE735qgIx96Fw2vMHacbY
 GgHDPQCAXdrLFMR3svIQZQov5mCgmcTjDCiyvLKK/QBVHocx/4SHFQ=
Received: from humpty.home.comstyle.com (unknown
 [IPv6:2001:470:b050:3:72be:d7:b79c:1bb7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested) (Authenticated sender: brad)
 by mail.comstyle.com (Postfix) with ESMTPSA id 4jGfw06Vtnz8Pbd;
 Fri, 30 Oct 2026 21:07:44 -0400 (EDT)
Date: Fri, 30 Oct 2026 21:07:43 -0400
From: Brad Smith <brad@comstyle.com>
To: Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH] qga: fix crash when a signal arrives during shutdown
Message-ID: <auU_X4KYujIpR2Qo@humpty.home.comstyle.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=2607:f938:3000:8::2;
 envelope-from=brad@comstyle.com; helo=mail.comstyle.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

qga: fix crash when a signal arrives during shutdown

quit_handler() stays installed for SIGINT and SIGTERM for the life
of the process and dereferences the global ga_state. cleanup_agent()
frees the agent state and clears ga_state, so a SIGINT or SIGTERM
arriving after cleanup makes quit_handler() dereference NULL in
ga_is_frozen() and the agent crashes with SIGSEGV.

This happens in practice when qemu-ga runs under something that
forwards signals. For example, running it under sudo and stopping it
with "pkill -f" signals both sudo and qemu-ga, so the agent receives
SIGTERM twice.

Reproduced on FreeBSD by sending SIGTERM after cleanup_agent() under
lldb.

Return early from quit_handler() when ga_state is NULL, and clear
ga_state as soon as the command state cleanup is done, before the
main loop and the state are freed, so a signal during the rest of
cleanup does not touch freed memory. ga_state cannot be cleared
earlier, as command cleanup callbacks such as
guest_fsfreeze_cleanup() still use it.

Signed-off-by: Brad Smith <brad@comstyle.com>
---
 qga/main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/qga/main.c b/qga/main.c
index fd19c7037d..8cc9810572 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -167,6 +167,10 @@ init_dfl_pathnames(void)
 
 static void quit_handler(int sig)
 {
+    if (!ga_state) {
+        return;
+    }
+
     /* if we're frozen, don't exit unless we're absolutely forced to,
      * because it's basically impossible for graceful exit to complete
      * unless all log/pid files are on unfreezable filesystems. there's
@@ -1589,13 +1593,13 @@ static void cleanup_agent(GAState *s)
         ga_command_state_free(s->command_state);
         json_message_parser_destroy(&s->parser);
     }
+    ga_state = NULL;
     g_free(s->pstate_filepath);
     g_free(s->state_filepath_isfrozen);
     if (s->main_loop) {
         g_main_loop_unref(s->main_loop);
     }
     g_free(s);
-    ga_state = NULL;
 }
 
 static int run_agent_once(GAState *s)
-- 
2.56.0


