Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCBEDCD3431
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 12:48:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slpNE-0003gg-RK; Wed, 04 Sep 2024 08:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1slpND-0003Z9-0E
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 08:44:35 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1slpNB-0005SO-8l
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 08:44:34 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E86862191F;
 Wed,  4 Sep 2024 12:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725453872; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qi/XzRa+1wsS1LuzhOV4ldJ/cldmkU5okDmZg2VwaI4=;
 b=yus6klPTXXznuJ2MXhCbRajMTwHH68uH14+Wr25BZ+/dYKm8I9X4RVWac44waVnDNaXDXe
 Yf6W8dVfHJgXxBUU7wnQI8my4A6cgIzyK0CC4UB4g96NUkx5InzWCp5fDkJsRz/STReaHO
 mfvUKEhFPP/KoqenlZRpaaHu5IksDFg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725453872;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qi/XzRa+1wsS1LuzhOV4ldJ/cldmkU5okDmZg2VwaI4=;
 b=cfysV+y+ZEWJIM+TVOBQIlT/OdX6MEt6wRdMgPF9XpN7C3EUmI5PwL5uv9FWUDCMUM/CDB
 GJdsKV4k8JrV5iCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725453871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qi/XzRa+1wsS1LuzhOV4ldJ/cldmkU5okDmZg2VwaI4=;
 b=NgVnCv3icurnoyRCy0fsyGgSIcPXu/jKge6Rq0l4NIe7Jlv+7V70QEVYwFhzaSdvuJxz+o
 /4X+wUFnsLSDiiuETs1nx3IXISNoSfUy/brEBaJv2xGQN6Ff2g88noeXDLOfUnF6IS3oLW
 VYEU9juZry7/Ua+qQVVKZvweQVBdKqU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725453871;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qi/XzRa+1wsS1LuzhOV4ldJ/cldmkU5okDmZg2VwaI4=;
 b=renisp8KyRitIJkL+WjV5ITllep5UcD6Fw5z2MFWOQcChjcuvJyHk1+Dh4xbbiRWbyxJm4
 GTPzoUEKGq5yTKAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 88E41139D2;
 Wed,  4 Sep 2024 12:44:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cKwBFC5W2GZuVQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 04 Sep 2024 12:44:30 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 06/34] tests/qtest/migration-helpers: Fix
 migrate_get_socket_address() leak
Date: Wed,  4 Sep 2024 09:43:49 -0300
Message-Id: <20240904124417.14565-7-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240904124417.14565-1-farosas@suse.de>
References: <20240904124417.14565-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.78 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.18)[-0.925];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,suse.de:mid,suse.de:email];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-helpers.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index 84f49db85e..7cbb9831e7 100644
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
2.35.3


