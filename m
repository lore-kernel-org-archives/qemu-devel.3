Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2133ACE7B02
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 11:27:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smX03-0001CP-BG; Fri, 06 Sep 2024 07:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smX00-0000a6-1i; Fri, 06 Sep 2024 07:19:32 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smWzx-0008MG-TK; Fri, 06 Sep 2024 07:19:31 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BC3018C4B2;
 Fri,  6 Sep 2024 14:12:10 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id C7C8713371B;
 Fri,  6 Sep 2024 14:13:28 +0300 (MSK)
Received: (nullmailer pid 353759 invoked by uid 1000);
 Fri, 06 Sep 2024 11:13:25 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.3 65/69] migration/multifd: Free MultiFDRecvParams::data
Date: Fri,  6 Sep 2024 14:13:14 +0300
Message-Id: <20240906111324.353230-65-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-9.0.3-20240906141259@cover.tls.msk.ru>
References: <qemu-stable-9.0.3-20240906141259@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

In multifd_recv_setup() we allocate (among other things)
 * a MultiFDRecvData struct to multifd_recv_state::data
 * a MultiFDRecvData struct to each multfd_recv_state->params[i].data

(Then during execution we might swap these pointers around.)

But in multifd_recv_cleanup() we free multifd_recv_state->data
in multifd_recv_cleanup_state() but we don't ever free the
multifd_recv_state->params[i].data. This results in a memory
leak reported by LeakSanitizer:

(cd build/asan && \
   ASAN_OPTIONS="fast_unwind_on_malloc=0:strip_path_prefix=/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/../../" \
   QTEST_QEMU_BINARY=./qemu-system-x86_64 \
   ./tests/qtest/migration-test --tap -k -p /x86_64/migration/multifd/file/mapped-ram )
[...]
Direct leak of 72 byte(s) in 3 object(s) allocated from:
    #0 0x561cc0afcfd8 in __interceptor_calloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/qemu-system-x86_64+0x218efd8) (BuildId: be72e086d4e47b172b0a72779972213fd9916466)
    #1 0x7f89d37acc50 in g_malloc0 debian/build/deb/../../../glib/gmem.c:161:13
    #2 0x561cc1e9c83c in multifd_recv_setup migration/multifd.c:1606:19
    #3 0x561cc1e68618 in migration_ioc_process_incoming migration/migration.c:972:9
    #4 0x561cc1e3ac59 in migration_channel_process_incoming migration/channel.c:45:9
    #5 0x561cc1e4fa0b in file_accept_incoming_migration migration/file.c:132:5
    #6 0x561cc30f2c0c in qio_channel_fd_source_dispatch io/channel-watch.c:84:12
    #7 0x7f89d37a3c43 in g_main_dispatch debian/build/deb/../../../glib/gmain.c:3419:28
    #8 0x7f89d37a3c43 in g_main_context_dispatch debian/build/deb/../../../glib/gmain.c:4137:7
    #9 0x561cc3b21659 in glib_pollfds_poll util/main-loop.c:287:9
    #10 0x561cc3b1ff93 in os_host_main_loop_wait util/main-loop.c:310:5
    #11 0x561cc3b1fb5c in main_loop_wait util/main-loop.c:589:11
    #12 0x561cc1da2917 in qemu_main_loop system/runstate.c:801:9
    #13 0x561cc3796c1c in qemu_default_main system/main.c:37:14
    #14 0x561cc3796c67 in main system/main.c:48:12
    #15 0x7f89d163bd8f in __libc_start_call_main csu/../sysdeps/nptl/libc_start_call_main.h:58:16
    #16 0x7f89d163be3f in __libc_start_main csu/../csu/libc-start.c:392:3
    #17 0x561cc0a79fa4 in _start (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/qemu-system-x86_64+0x210bfa4) (BuildId: be72e086d4e47b172b0a72779972213fd9916466)

Direct leak of 24 byte(s) in 1 object(s) allocated from:
    #0 0x561cc0afcfd8 in __interceptor_calloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/qemu-system-x86_64+0x218efd8) (BuildId: be72e086d4e47b172b0a72779972213fd9916466)
    #1 0x7f89d37acc50 in g_malloc0 debian/build/deb/../../../glib/gmem.c:161:13
    #2 0x561cc1e9bed9 in multifd_recv_setup migration/multifd.c:1588:32
    #3 0x561cc1e68618 in migration_ioc_process_incoming migration/migration.c:972:9
    #4 0x561cc1e3ac59 in migration_channel_process_incoming migration/channel.c:45:9
    #5 0x561cc1e4fa0b in file_accept_incoming_migration migration/file.c:132:5
    #6 0x561cc30f2c0c in qio_channel_fd_source_dispatch io/channel-watch.c:84:12
    #7 0x7f89d37a3c43 in g_main_dispatch debian/build/deb/../../../glib/gmain.c:3419:28
    #8 0x7f89d37a3c43 in g_main_context_dispatch debian/build/deb/../../../glib/gmain.c:4137:7
    #9 0x561cc3b21659 in glib_pollfds_poll util/main-loop.c:287:9
    #10 0x561cc3b1ff93 in os_host_main_loop_wait util/main-loop.c:310:5
    #11 0x561cc3b1fb5c in main_loop_wait util/main-loop.c:589:11
    #12 0x561cc1da2917 in qemu_main_loop system/runstate.c:801:9
    #13 0x561cc3796c1c in qemu_default_main system/main.c:37:14
    #14 0x561cc3796c67 in main system/main.c:48:12
    #15 0x7f89d163bd8f in __libc_start_call_main csu/../sysdeps/nptl/libc_start_call_main.h:58:16
    #16 0x7f89d163be3f in __libc_start_main csu/../csu/libc-start.c:392:3
    #17 0x561cc0a79fa4 in _start (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/qemu-system-x86_64+0x210bfa4) (BuildId: be72e086d4e47b172b0a72779972213fd9916466)

SUMMARY: AddressSanitizer: 96 byte(s) leaked in 4 allocation(s).

Free the params[i].data too.

Cc: qemu-stable@nongnu.org
Fixes: d117ed0699d41 ("migration/multifd: Allow receiving pages without packets")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
(cherry picked from commit 4c107870e8b2ba3951ee0c46123f1c3b5d3a19d3)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/migration/multifd.c b/migration/multifd.c
index fa55586f89..ac3742343f 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -1351,6 +1351,8 @@ static void multifd_recv_cleanup_channel(MultiFDRecvParams *p)
     qemu_mutex_destroy(&p->mutex);
     qemu_sem_destroy(&p->sem_sync);
     qemu_sem_destroy(&p->sem);
+    g_free(p->data);
+    p->data = NULL;
     g_free(p->name);
     p->name = NULL;
     p->packet_len = 0;
-- 
2.39.2


