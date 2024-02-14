Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A297C4829F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 06:48:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ra93v-0002ob-BV; Wed, 14 Feb 2024 01:48:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ra93n-0002nQ-GV
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 01:47:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ra93k-0003OW-T3
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 01:47:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707893275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2wQMYKCZZhAH2J9Jz08H4qUvKp4MeE6Ve/LZSxR0vpU=;
 b=N+snFtSANiD+f/7InTTx2ihSOpsI4m6EDibOBLl2nNz0rhSycP5dsEm/KyCOe9YAZ8U6zi
 MTl5JknaAii/KNdCzglOBR9s1IGPNl2DTEwcfzh2ScNZQvNW8v9R3lr1cxwNkYhmXLzqkV
 mHa68DdmT+JLhrawcgMZ/tHn7+OvFBY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-20-c0J814JlPluQVxsMM3AQQA-1; Wed,
 14 Feb 2024 01:47:51 -0500
X-MC-Unique: c0J814JlPluQVxsMM3AQQA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0725329ABA24;
 Wed, 14 Feb 2024 06:47:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ACB8CAC06;
 Wed, 14 Feb 2024 06:47:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7F30621E669D; Wed, 14 Feb 2024 07:47:49 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eric Blake <eblake@redhat.com>
Subject: [PULL v2 2/4] tests/unit/test-char: Fix qemu_socket(),
 make_udp_socket() check
Date: Wed, 14 Feb 2024 07:47:47 +0100
Message-ID: <20240214064749.1060107-3-armbru@redhat.com>
In-Reply-To: <20240214064749.1060107-1-armbru@redhat.com>
References: <20240214064749.1060107-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

qemu_socket() and make_udp_socket() return a file descriptor on
success, -1 on failure.  The check misinterprets 0 as failure.  Fix
that.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240203080228.2766159-3-armbru@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/unit/test-char.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/unit/test-char.c b/tests/unit/test-char.c
index 2aea49c3b6..f273ce5226 100644
--- a/tests/unit/test-char.c
+++ b/tests/unit/test-char.c
@@ -556,7 +556,7 @@ static int make_udp_socket(int *port)
     socklen_t alen = sizeof(addr);
     int ret, sock = qemu_socket(PF_INET, SOCK_DGRAM, 0);
 
-    g_assert_cmpint(sock, >, 0);
+    g_assert_cmpint(sock, >=, 0);
     addr.sin_family = AF_INET ;
     addr.sin_addr.s_addr = htonl(INADDR_ANY);
     addr.sin_port = 0;
@@ -1407,7 +1407,7 @@ static void char_hotswap_test(void)
 
     int port;
     int sock = make_udp_socket(&port);
-    g_assert_cmpint(sock, >, 0);
+    g_assert_cmpint(sock, >=, 0);
 
     chr_args = g_strdup_printf("udp:127.0.0.1:%d", port);
 
-- 
2.43.0


