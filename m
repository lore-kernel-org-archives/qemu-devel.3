Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B57BC3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 14:50:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgQAk-00050p-0V; Tue, 20 Aug 2024 10:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sgQAh-0004sj-Sq
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 10:49:20 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sgQAf-0006L2-Lf
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 10:49:19 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4281faefea9so44578665e9.2
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 07:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724165356; x=1724770156; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m2tt9btfYolQ5/KH5Y6XBbi1169Zr1kBebqADkF/0Ng=;
 b=Z+EAyFSn26EzE8nX4Ed2oH08aCtu8bL+kV+3vEDYU6LK0JQKO6hl8gq13zpd41gDBr
 Yzx234x7TNHuSVMxmEfOxpgUoNi9oWTRlcPTcT4Pm9I2Mh45APt62widZBTDk3v8a11+
 u4XgkokUPqwzBA+se6/+BZztC0FDqAt87Qw1pnhU1jxb4bpLLWvOIuCleaRdmtohV1qa
 uy9RPT4lrYRArnfQL3+vWHqzp47Wr5tJW0NmavTYggcnJwLtdi4ZgPN8BWs0C1l5oz/S
 +iBxjrXgSGvobKp5/PZQbiHCSVOL5bNqcvR54KEtxbwGwi7rmZ0VemrDnw5fJHzKFqhV
 Whnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724165356; x=1724770156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m2tt9btfYolQ5/KH5Y6XBbi1169Zr1kBebqADkF/0Ng=;
 b=YGjWVaHsFsMglttvi6kviBuyRiDyRa437cX00Zls59arYM59g95MqgXy/Zvh9Pk4iR
 ALRWKSukKDKOoqn4h71cHYDMGEPodIc+fbcNltpsUdxEge4YYLtRFw2Re3qVgWrAvjt9
 Hme2QrSavbuqLhca6Yt1/c1XJQSVLXrGgW3zSvl8alOqRD8rqrfttCy3yOFtjp3I96Tw
 0/GSSAne2n5iPuVg6YcT4FjBgsswi0PIpMFoO2q6CasdyIbwiuDCWM1+GGMKDOimdNii
 J8kDBUsXCIPP2t9BzsOmwJKwmE6+hIgLYZlDwyZ2tK/Lm1ji3C//p1qIytU+32Kxh6Z7
 bzLw==
X-Gm-Message-State: AOJu0YwkApbfsruBsSSiA8M7vU5fPiYOCeoeJOFaWojFyEOZvx9OTUdT
 PQ69y9/p6Ma022sfzQrhF9cte/mLa2Q8moOeU6tvsqkG8yt/gfpp6Ad5pqMIKIEj5SFI70JEcfs
 p
X-Google-Smtp-Source: AGHT+IH0mpRybfWorbfvqpJ9Cx0C5U32cJIm9odTT70UG3zFn/RRu2XFjl+FcMqA0c86jIqMflrg6w==
X-Received: by 2002:adf:f9d1:0:b0:368:30a6:16d8 with SMTP id
 ffacd0b85a97d-371946ccb85mr7823477f8f.57.1724165355984; 
 Tue, 20 Aug 2024 07:49:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3718983a306sm13334672f8f.15.2024.08.20.07.49.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2024 07:49:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH for-9.2 4/9] tests/qtest/migration-helpers: Fix
 migrate_get_socket_address() leak
Date: Tue, 20 Aug 2024 15:49:07 +0100
Message-Id: <20240820144912.320744-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240820144912.320744-1-peter.maydell@linaro.org>
References: <20240820144912.320744-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

In migrate_get_socket_address() we leak the SocketAddressList:
 (cd build/asan && \
  ASAN_OPTIONS="fast_unwind_on_malloc=0:strip_path_prefix=/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/../../"
  QTEST_QEMU_BINARY=./qemu-system-x86_64 \
  ./tests/qtest/migration-test --tap -k -p /x86_64/migration/multifd/tcp/tls/psk/match )

[...]
Direct leak of 16 byte(s) in 1 object(s) allocated from:
    #0 0x563d7f22f318 in __interceptor_calloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/tests/qtest/migration-test+0x22f318) (BuildId: 2ad6282fb5d076c863ab87f41a345d46dc965ded)
    #1 0x7f9de3b39c50 in g_malloc0 debian/build/deb/../../../glib/gmem.c:161:13
    #2 0x563d7f3a119c in qobject_input_start_list qapi/qobject-input-visitor.c:336:17
    #3 0x563d7f390fbf in visit_start_list qapi/qapi-visit-core.c:80:10
    #4 0x563d7f3882ef in visit_type_SocketAddressList /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/qapi/qapi-visit-sockets.c:519:10
    #5 0x563d7f3658c9 in migrate_get_socket_address tests/qtest/migration-helpers.c:97:5
    #6 0x563d7f362e24 in migrate_get_connect_uri tests/qtest/migration-helpers.c:111:13
    #7 0x563d7f362bb2 in migrate_qmp tests/qtest/migration-helpers.c:222:23
    #8 0x563d7f3533cd in test_precopy_common tests/qtest/migration-test.c:1817:5
    #9 0x563d7f34dc1c in test_multifd_tcp_tls_psk_match tests/qtest/migration-test.c:3185:5
    #10 0x563d7f365337 in migration_test_wrapper tests/qtest/migration-helpers.c:458:5

The code fishes out the SocketAddress from the list to return it, and the
callers are freeing that, but nothing frees the list.

Since this function is called in only two places, the simple fix is to
make it return the SocketAddressList rather than just a SocketAddress,
and then the callers can easily access the SocketAddress, and free
the whole SocketAddressList when they're done.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/migration-helpers.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index 84f49db85e0..7cbb9831e76 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -82,11 +82,10 @@ static QDict *SocketAddress_to_qdict(SocketAddress *addr)
     return dict;
 }
 
-static SocketAddress *migrate_get_socket_address(QTestState *who)
+static SocketAddressList *migrate_get_socket_address(QTestState *who)
 {
     QDict *rsp;
     SocketAddressList *addrs;
-    SocketAddress *addr;
     Visitor *iv = NULL;
     QObject *object;
 
@@ -95,36 +94,35 @@ static SocketAddress *migrate_get_socket_address(QTestState *who)
 
     iv = qobject_input_visitor_new(object);
     visit_type_SocketAddressList(iv, NULL, &addrs, &error_abort);
-    addr = addrs->value;
     visit_free(iv);
 
     qobject_unref(rsp);
-    return addr;
+    return addrs;
 }
 
 static char *
 migrate_get_connect_uri(QTestState *who)
 {
-    SocketAddress *addrs;
+    SocketAddressList *addrs;
     char *connect_uri;
 
     addrs = migrate_get_socket_address(who);
-    connect_uri = SocketAddress_to_str(addrs);
+    connect_uri = SocketAddress_to_str(addrs->value);
 
-    qapi_free_SocketAddress(addrs);
+    qapi_free_SocketAddressList(addrs);
     return connect_uri;
 }
 
 static QDict *
 migrate_get_connect_qdict(QTestState *who)
 {
-    SocketAddress *addrs;
+    SocketAddressList *addrs;
     QDict *connect_qdict;
 
     addrs = migrate_get_socket_address(who);
-    connect_qdict = SocketAddress_to_qdict(addrs);
+    connect_qdict = SocketAddress_to_qdict(addrs->value);
 
-    qapi_free_SocketAddress(addrs);
+    qapi_free_SocketAddressList(addrs);
     return connect_qdict;
 }
 
-- 
2.34.1


