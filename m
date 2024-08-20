Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60451C531DC
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 14:45:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgQ69-0000Ym-On; Tue, 20 Aug 2024 10:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sgQ67-0000Xd-2S
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 10:44:35 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sgQ64-0005Z0-RE
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 10:44:34 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-429e29933aaso43305715e9.0
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 07:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724165070; x=1724769870; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jMTfh60pZgpwtOsRiM0kPB17tfn1jZZzt39WO8xs1HQ=;
 b=Jk/2FBH2ghoEDJG68qJolXQcolj6qIhYPCv1aHfTC9iA9KJxQiyzrQVE6wLMRDH3Xy
 zsx64HH6WXqiUAMVjY2k8RaLngXlvYK8d3p+7rRAYjx0Qk0Gpmw43IHSFHjCffxC1+m4
 /rmOWIESrRrIHyufdFE14sJ+28JorXRBVcneUX4mFmncbI8weuzW3rf6tAiFifMnX7h1
 vbuZmNu3UOlmjSP36orhP278y6Z3abVJYUBqdf76ZtObWphWRWQ1MYYpLoOWmv4ddeYl
 2eLI1xhuwkUGEINkZ83vA22y1AfwlygBuL5ABAlIiNjp9eHFxFXxyxj/zKV3FKpy0xY+
 DB8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724165070; x=1724769870;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jMTfh60pZgpwtOsRiM0kPB17tfn1jZZzt39WO8xs1HQ=;
 b=UA1RiTnxj3vn+kY2v5fHnLOWKtzm+k/e2Ps4+ler7/4Bcg3CW86xBRTGbOar9r1a6O
 UOv4ZhO+ZsTmySwC6l3/XIjTTLr7fSKXsOWBs+JXyrZdO5vwd5Rjr0OqNKkDkscbo/XN
 Lpb7F06+p1IGZDWDXBEpAp548lVG/iMBXRiL4dN1mU4toy9W6gCNpvCN1SQ9gvJ2bV00
 HBmpF0dwU0Vbwm0XNXMyCf62Fr/ArAPfwFHo5OF5jrayG+wfWzxSflPm9Gq7vM0t2pmr
 sx2GUSbCHuID5FBtEKsNOZo7wmOnYfjnVCV6qq+fsD5KtHk0Ev0tuHuO9C9i6wNOj86A
 lBCw==
X-Gm-Message-State: AOJu0Yxc2HvQS8uIK9qvjfP889N//NqewyfUbKdGoRfi6aY4aFORfScx
 4rqZxxU70bl5qnkwUi6AoANZEHuX18zFOpIsjEsXhGdbfb0wEUVWnbJaBj0y2dJMbYkJY4EA2uZ
 M
X-Google-Smtp-Source: AGHT+IH90o0kY57HHJesl8nY4qa74NmQRgM+McKbrRoVBb3GxkUPmsYZHlFghX4oUTt8wLQjC1amjg==
X-Received: by 2002:a5d:5110:0:b0:34d:ae98:4e7 with SMTP id
 ffacd0b85a97d-3719469531fmr9051762f8f.41.1724165070374; 
 Tue, 20 Aug 2024 07:44:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3718985a6d1sm13423340f8f.57.2024.08.20.07.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2024 07:44:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Subject: [PATCH for-9.1?] migration/multifd: Free MultiFDRecvParams::data
Date: Tue, 20 Aug 2024 15:44:29 +0100
Message-Id: <20240820144429.320176-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
---
This bug was in the 9.0 release, so not a regression we absolutely
must fix for 9.1. I have also only tested this by running the
migration-test test suite.

NB that the tests themselves have a pile of leaks; I'm about to send
a separate patchseries for those.

 migration/multifd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/migration/multifd.c b/migration/multifd.c
index 552f9723c82..a6db05502aa 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -1357,6 +1357,8 @@ static void multifd_recv_cleanup_channel(MultiFDRecvParams *p)
     qemu_mutex_destroy(&p->mutex);
     qemu_sem_destroy(&p->sem_sync);
     qemu_sem_destroy(&p->sem);
+    g_free(p->data);
+    p->data = NULL;
     g_free(p->name);
     p->name = NULL;
     p->packet_len = 0;
-- 
2.34.1


