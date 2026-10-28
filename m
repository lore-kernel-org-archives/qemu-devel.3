Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F6D606A339
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 09:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HeO+ysCJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM0BO-0007Op-Ii; Wed, 28 Oct 2026 05:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xM0Af-0006uC-Cj
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 05:42:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xM0Ad-0008SI-LA
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 05:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793180531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R9iCslM5tBL63stEtpQc9HVGDsEzNqzJAnD367d+6J0=;
 b=HeO+ysCJFGD5AyscGJvjnAxf4tYwVZMPqC4GY5U8gwlnukZPNRYB+cqRPinTzRo/tuOl0K
 Mx68rEWGYsoEgZND9922NeygmRugYrqBnpzqKzmomqk0V7t/kIFTDJGRF8lKtBJTJPqQ1I
 HECI0zonstMdHtnuXT1ndZXKZsVwtIc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-456-3S5yMh9WPSSWZKnUXK6emg-1; Wed,
 28 Oct 2026 05:42:07 -0400
X-MC-Unique: 3S5yMh9WPSSWZKnUXK6emg-1
X-Mimecast-MFC-AGG-ID: 3S5yMh9WPSSWZKnUXK6emg_1793180526
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0775D1955E9C; Wed, 28 Oct 2026 09:42:06 +0000 (UTC)
Received: from Kostiantyns-MacBook-Pro.redhat.com (unknown [10.44.32.20])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AAD6A1956086; Wed, 28 Oct 2026 09:42:04 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 5/6] tests/unit/test-qga: enable on FreeBSD
Date: Wed, 28 Oct 2026 11:41:51 +0200
Message-ID: <20261028094152.14934-6-kkostiuk@redhat.com>
In-Reply-To: <20261028094152.14934-1-kkostiuk@redhat.com>
References: <20261028094152.14934-1-kkostiuk@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Roman Bogorodskiy <bogorodskiy@gmail.com>

FreeBSD has all necessary commands implemented,
so enable test-qga for it.

Requires only minimal portability fixes for sockets
in connect_qga().

Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260929150100.66035-1-bogorodskiy@gmail.com
Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
---
 tests/unit/meson.build | 2 +-
 tests/unit/test-qga.c  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index d17435c187..295df1a7eb 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -169,7 +169,7 @@ if have_system
   tests += {'test-qdev': [qom, hwcore]}
 endif
 
-if have_ga and host_os == 'linux'
+if have_ga and host_os in ['freebsd', 'linux']
   tests += {'test-qga': ['../qtest/libqmp.c', '../qtest/libqtest.c']}
   test_deps += {'test-qga': qga}
 endif
diff --git a/tests/unit/test-qga.c b/tests/unit/test-qga.c
index 01ccf826e6..b1c84c188b 100644
--- a/tests/unit/test-qga.c
+++ b/tests/unit/test-qga.c
@@ -18,7 +18,7 @@ typedef struct {
 static int connect_qga(char *path)
 {
     int s, ret, len, i = 0;
-    struct sockaddr_un remote;
+    struct sockaddr_un remote = { 0 };
 
     s = socket(AF_UNIX, SOCK_STREAM, 0);
     g_assert(s != -1);
@@ -26,7 +26,7 @@ static int connect_qga(char *path)
     remote.sun_family = AF_UNIX;
     do {
         strcpy(remote.sun_path, path);
-        len = strlen(remote.sun_path) + sizeof(remote.sun_family);
+        len = sizeof(remote);
         ret = connect(s, (struct sockaddr *)&remote, len);
         if (ret == -1) {
             g_usleep(G_USEC_PER_SEC);
-- 
2.54.0 (Apple Git-157)


