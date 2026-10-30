Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD5D606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=J/m2kJl0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMtw5-0007ML-QK; Fri, 30 Oct 2026 17:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xMtw3-0007M4-HP
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 17:14:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xMtw2-0007qB-5q
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 17:14:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793394889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f9FupMBFJDe82B5XsTDiAOhFmsR68B2joGxlwlihelM=;
 b=J/m2kJl0W/Eck/nXYZEZpDZjKcQMKHN/8JEKcW5xRE/PGn90nKGJg3/CeIGT9v1gDgEt8Q
 /thbdCrtkuqDLNoOr57cZrKU+KI06bMlsz3mspmWRsrmiYhvucNcLruiaWmRX4A6v7vcGd
 yB9mPEA0YXEojtpVnj9H9HSTausCvo0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-lBSYJLjXPNKkBskaJmx5sA-1; Fri,
 30 Oct 2026 17:14:46 -0400
X-MC-Unique: lBSYJLjXPNKkBskaJmx5sA-1
X-Mimecast-MFC-AGG-ID: lBSYJLjXPNKkBskaJmx5sA_1793394885
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3445419541A1; Fri, 30 Oct 2026 21:14:45 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 644921956086; Fri, 30 Oct 2026 21:14:44 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 31 Oct 2026 01:14:12 +0400
Subject: [GIT PULL 09/10] tests/exynos4210_uart_fifo-test: fix buffer leaks
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261031-nohmp-next-v1-9-9a9fb205cf3f@redhat.com>
References: <20261031-nohmp-next-v1-0-9a9fb205cf3f@redhat.com>
In-Reply-To: <20261031-nohmp-next-v1-0-9a9fb205cf3f@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1275;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=xI2pRzvvHiAYzJh6NSmbqQ9iPp95m8SxfvG8pCf9PHU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq5Qigcy9JhpU/197lCryk/v3qL3C0hzbIaIakw
 eDPEpXFl0eJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCauUIoAAKCRDa6OEJdZac
 5UArEACixBI9vU7YNwoCRntFIFLZeNN2FkLhEM+Jx4XF2XDvNkAdWHJ+Z8D8W8pT9AwAENUMnrC
 fsdrzI3VAj1L5l9UP5E9nWr6YWFteQaFuDFftvn7Xu1+ziU1JJKngE8uF0+wDakC0gFnfmDKb2B
 RThcKj7uo4GuDSoP9Lby3WjnPnhHXIQpzwypV+BqzxNKiy7rCclnpHhJxd1nNpvTeSYUtJO+AXC
 af8lwAAqsM7/JFag2KnNCuLIGZbmyYy7zgMOMMA8FVE9556mNgTbdPNqxZJ/596mGnv78v7vsDA
 Xdy10YIEdNh77D6mYy7rkqDlFijbjmf9ETYstEEI86pTkE93GTtRrZldBMut1K+lhq/s/gsw1rc
 BZ0rZ9yPq5FNFvmcqPzvNGWrVrjvCOwdc3IVcpun70G7MY7OTD/kb3cwJFnQHcwURAoHBsmAqdS
 PsGSQLKqzAgrGaUIqJNGwyMs31ewvpYqV0etLekWYnG6UX8PfNo3m8GqRdNQEPrIQ7pltsDUqjH
 ZBmBWS2bnmuINdjyBd3w+A/PWvyPeQrJL8y5jp8BZkwisMKUQpKB2gOZUlNKU1UCXNnbJAHXirN
 X9Xjc1ESiTBIujOC1uZmhlz+gZzeZQld/81MaBqqjZelsDcKJVdA0eSH0QWXIhcu2TXfM1Zh88e
 r4mEVO5/AaVAtRQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Reported by ASAN.

Fixes: 6d459c75cfc4 ("tests/qtest: add test for exynos4210 uart fifo overflow bug")
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qtest/exynos4210_uart_fifo-test.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/exynos4210_uart_fifo-test.c b/tests/qtest/exynos4210_uart_fifo-test.c
index 54c09a6de723..c336ed22b028 100644
--- a/tests/qtest/exynos4210_uart_fifo-test.c
+++ b/tests/qtest/exynos4210_uart_fifo-test.c
@@ -52,8 +52,8 @@ static void enable_uart_fifo(QTestState *qts)
  */
 static void test_recv_large_str(void)
 {
-    int sock_fd;
-    char *sendbuf, *recvbuf;
+    g_autofd int sock_fd = -1;
+    g_autofree char *sendbuf = NULL, *recvbuf = NULL;
     QTestState *qts = qtest_init_with_serial("-M smdkc210", &sock_fd);
 
     enable_uart_fifo(qts);
@@ -71,8 +71,6 @@ static void test_recv_large_str(void)
     g_assert_true(TEST_BUFFER_LEN - 1 == strlen(recvbuf));
     g_assert_true(strcmp(sendbuf, recvbuf) == 0);
 
-    close(sock_fd);
-
     qtest_quit(qts);
 }
 

-- 
2.56.0.116.g6de20f6092dc


