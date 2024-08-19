Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC1C2C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 14:51:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sg3iG-0005fy-0n; Mon, 19 Aug 2024 10:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sg3iE-0005ea-GZ
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 10:50:26 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sg3iC-0005Sm-9V
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 10:50:26 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-428085a3ad1so38747555e9.1
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 07:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724079022; x=1724683822; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WW7irc5dOsdR2uIMYAGlC01tbGaKYU0hXrA9re5XZlY=;
 b=IJY9XItS5XKLUOyCKtxEn3A1pFklXiuhAle7ClLAs2PO712T/ZyqYR24DC9z1xor2u
 FmiV7qFjOAnKSb4Wky5EjDFU7hC6cu177qrzS99O40vNjh5j6Bo0KUyMznHdQ/OEaadD
 PqB7C4kdKNhvksoQGY34Sl6q7ffOn8gB/oVUYIZcyfErvQFxSj5+aStBPLs9u9LX8mC9
 KG8SHv2mIH7D3DMoHg5uhoGVRBQwSsr26HTPtsEyW2Kqdyudze1F1sqOIQaeTddGL0y5
 sArlXjsO+XNukQkCQLfbkolH2MPPqeqDpqOSbdtpWiLpsRku0ShXkvC8ukflYJ33UTRZ
 XM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724079022; x=1724683822;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WW7irc5dOsdR2uIMYAGlC01tbGaKYU0hXrA9re5XZlY=;
 b=Ob5Nzz+EtLv16giE/psSrIMJ2YTdcaNc28hbfXURbcugp6coajRqMrSmh+6Gup+gEP
 8njMEOaAvCfBoIjCD70/JxfVG17H3W+BatfUuPXBtlgecxnfD+WEdBkMtSrZpI05XgCX
 fgwi/M06/fgPdWzffVwPQZ6Mrdwwx58Uki19zy53o/j3k9h/KIRWKE7ZSw8HAyECWTyZ
 qutMamyH/CrqejzyP9BHxDNg8aoYI7t/ksAOhnDAdnddDsi7wkkqegfJOh9WXpCsvL1L
 GHi0CTpiB+zug9zUolrpsxExPWS+IGRLkEOD+UXBQrKlKA3G/NVwxIsp9SmT/s0TuWG0
 n9dQ==
X-Gm-Message-State: AOJu0YyPyEeJUkEYU+cinCuQVKkE7zrgmwuuQOwnAIUVESapLiEpCNEe
 ToRWzR3+es943F+ou68/ObQaIUJZq8YuEV5Smbc4+Wj/TtGzSM3hcyZf6JfqkXKATH3fR0eH1OD
 s
X-Google-Smtp-Source: AGHT+IFnx7ZUHZ7XUUNioVenLG/yssOqTtCnFUkHuhioPjpwda1jyfp4KvNmfydBbWhH+47WW4nFFQ==
X-Received: by 2002:a05:600c:4ed1:b0:426:5c34:b19b with SMTP id
 5b1f17b1804b1-429ed7b8a1fmr88681545e9.20.1724079022295; 
 Mon, 19 Aug 2024 07:50:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429ded18468sm163546855e9.2.2024.08.19.07.50.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 07:50:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] crypto/tlscredspsk: Free username on finalize
Date: Mon, 19 Aug 2024 15:50:21 +0100
Message-Id: <20240819145021.38524-1-peter.maydell@linaro.org>
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
---
Found this playing around with the address-sanitizer and running
"make check".  I guess this is stable material but maybe not
important enough to go into 9.1 at this point in the cycle, since the
bug has been present since the code was first written in 2018.

 crypto/tlscredspsk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/crypto/tlscredspsk.c b/crypto/tlscredspsk.c
index 546cad1c5a4..0d6b71a37cf 100644
--- a/crypto/tlscredspsk.c
+++ b/crypto/tlscredspsk.c
@@ -243,6 +243,7 @@ qcrypto_tls_creds_psk_finalize(Object *obj)
     QCryptoTLSCredsPSK *creds = QCRYPTO_TLS_CREDS_PSK(obj);
 
     qcrypto_tls_creds_psk_unload(creds);
+    g_free(creds->username);
 }
 
 static void
-- 
2.34.1


