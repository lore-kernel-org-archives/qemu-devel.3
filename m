Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 347BCCD5BDD
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 05:27:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smROu-000723-R7; Fri, 06 Sep 2024 01:20:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smROW-0004zj-Kj; Fri, 06 Sep 2024 01:20:30 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smROR-0000Bh-Gj; Fri, 06 Sep 2024 01:20:25 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9FECD8C13C;
 Fri,  6 Sep 2024 08:15:18 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 4E226133381;
 Fri,  6 Sep 2024 08:16:36 +0300 (MSK)
Received: (nullmailer pid 10504 invoked by uid 1000);
 Fri, 06 Sep 2024 05:16:34 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.14 39/40] crypto/tlscredspsk: Free username on finalize
Date: Fri,  6 Sep 2024 08:16:27 +0300
Message-Id: <20240906051633.10288-39-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.14-20240906080824@cover.tls.msk.ru>
References: <qemu-stable-7.2.14-20240906080824@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

When the creds->username property is set we allocate memory
for it in qcrypto_tls_creds_psk_prop_set_username(), but
we never free this when the QCryptoTLSCredsPSK is destroyed.
Free the memory in finalize.

This fixes a LeakSanitizer complaint in migration-test:

$ (cd build/asan; ASAN_OPTIONS="fast_unwind_on_malloc=0" QTEST_QEMU_BINARY=./qemu-system-x86_64 ./tests/qtest/migration-test --tap -k -p /x86_64/migration/precopy/unix/tls/psk)

=================================================================
==3867512==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 5 byte(s) in 1 object(s) allocated from:
    #0 0x5624e5c99dee in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/qemu-system-x86_64+0x218edee) (BuildId: a9e623fa1009a9435c0142c037cd7b8c1ad04ce3)
    #1 0x7fb199ae9738 in g_malloc debian/build/deb/../../../glib/gmem.c:128:13
    #2 0x7fb199afe583 in g_strdup debian/build/deb/../../../glib/gstrfuncs.c:361:17
    #3 0x5624e82ea919 in qcrypto_tls_creds_psk_prop_set_username /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/../../crypto/tlscredspsk.c:255:23
    #4 0x5624e812c6b5 in property_set_str /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/../../qom/object.c:2277:5
    #5 0x5624e8125ce5 in object_property_set /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/../../qom/object.c:1463:5
    #6 0x5624e8136e7c in object_set_properties_from_qdict /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/../../qom/object_interfaces.c:55:14
    #7 0x5624e81372d2 in user_creatable_add_type /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/../../qom/object_interfaces.c:112:5
    #8 0x5624e8137964 in user_creatable_add_qapi /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/../../qom/object_interfaces.c:157:11
    #9 0x5624e891ba3c in qmp_object_add /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/../../qom/qom-qmp-cmds.c:227:5
    #10 0x5624e8af9118 in qmp_marshal_object_add /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/qapi/qapi-commands-qom.c:337:5
    #11 0x5624e8bd1d49 in do_qmp_dispatch_bh /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/../../qapi/qmp-dispatch.c:128:5
    #12 0x5624e8cb2531 in aio_bh_call /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/../../util/async.c:171:5
    #13 0x5624e8cb340c in aio_bh_poll /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/../../util/async.c:218:13
    #14 0x5624e8c0be98 in aio_dispatch /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/../../util/aio-posix.c:423:5
    #15 0x5624e8cba3ce in aio_ctx_dispatch /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/../../util/async.c:360:5
    #16 0x7fb199ae0d3a in g_main_dispatch debian/build/deb/../../../glib/gmain.c:3419:28
    #17 0x7fb199ae0d3a in g_main_context_dispatch debian/build/deb/../../../glib/gmain.c:4137:7
    #18 0x5624e8cbe1d9 in glib_pollfds_poll /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/../../util/main-loop.c:287:9
    #19 0x5624e8cbcb13 in os_host_main_loop_wait /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/../../util/main-loop.c:310:5
    #20 0x5624e8cbc6dc in main_loop_wait /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/../../util/main-loop.c:589:11
    #21 0x5624e6f3f917 in qemu_main_loop /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/../../system/runstate.c:801:9
    #22 0x5624e893379c in qemu_default_main /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/../../system/main.c:37:14
    #23 0x5624e89337e7 in main /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/../../system/main.c:48:12
    #24 0x7fb197972d8f in __libc_start_call_main csu/../sysdeps/nptl/libc_start_call_main.h:58:16
    #25 0x7fb197972e3f in __libc_start_main csu/../csu/libc-start.c:392:3
    #26 0x5624e5c16fa4 in _start (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/qemu-system-x86_64+0x210bfa4) (BuildId: a9e623fa1009a9435c0142c037cd7b8c1ad04ce3)

SUMMARY: AddressSanitizer: 5 byte(s) leaked in 1 allocation(s).

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20240819145021.38524-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit 87e012f29f2e47dcd8c385ff8bb8188f9e06d4ea)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/crypto/tlscredspsk.c b/crypto/tlscredspsk.c
index 546cad1c5a..0d6b71a37c 100644
--- a/crypto/tlscredspsk.c
+++ b/crypto/tlscredspsk.c
@@ -243,6 +243,7 @@ qcrypto_tls_creds_psk_finalize(Object *obj)
     QCryptoTLSCredsPSK *creds = QCRYPTO_TLS_CREDS_PSK(obj);
 
     qcrypto_tls_creds_psk_unload(creds);
+    g_free(creds->username);
 }
 
 static void
-- 
2.39.2


