Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C58606A334
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 07:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hMJXj5MI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJR74-0004d3-Mb; Wed, 21 Oct 2026 03:51:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJR72-0004cg-NT
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 03:51:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJR71-00042I-Ai
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 03:51:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792569110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eqYrNK+ys//UaGy7K0vgDldGdAKN4i1XSwiHAV7TkXY=;
 b=hMJXj5MIReUQF5fULWwCwwD7Vll+KWBhAmKniEiLU7f8TQzgV3eHnOh2vgJT4WQmGJ5WSX
 NL4Pcj28ws9Gvj0oiFZf5r65BCNOKZb48TyizeYcS/VIPPdJHuEj3mxObfzmPjlTtrnKdN
 Hqfmt3Gvn35UJTMK7XlvtDA4504Xe48=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-602-qGZ7N9BiMKijR9ecJxncjA-1; Wed,
 21 Oct 2026 07:51:45 +0000
X-MC-Unique: qGZ7N9BiMKijR9ecJxncjA-1
X-Mimecast-MFC-AGG-ID: qGZ7N9BiMKijR9ecJxncjA_1792569103
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 706FF195609F; Wed, 21 Oct 2026 07:51:43 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 32AA830000E3; Wed, 21 Oct 2026 07:51:41 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 21 Oct 2026 11:51:11 +0400
Subject: [PATCH v2 8/9] tests/exynos4210_uart_fifo-test: fix buffer leaks
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261021-nohmp-next-v2-8-85471fca83db@redhat.com>
References: <20261021-nohmp-next-v2-0-85471fca83db@redhat.com>
In-Reply-To: <20261021-nohmp-next-v2-0-85471fca83db@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Gerd Hoffman <kraxel@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Jared Rossi <jrossi@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Jason Herne <jjherne@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1132;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=6qk9s23emzvCS68kP8h6EMYINdQtUHNOCgnfOQ6ybQs=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq2G7tjn2s5qmkzM1DrMmDKoe29ebkXWpxePRK2
 WZuaX/dvL6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCathu7QAKCRDa6OEJdZac
 5d94D/4iCSW0qOkTSJtxJF6vUIyojUZHsc0sFoGHimYUfTqKv02Oy0VVVq8pnBTa6QR6qlpMX/O
 vGWRxIqkLMFFb1JEdv4+uiWVmEeJ2s4nwlC+eezZDNelVsb/zZRcSxr0uJTrxWA87GxiSEKlQn3
 7go5bXN1RZthMf8o+VjSAd6piYGjSEA0ZcFQOp5AdtbGMM6/ZTvUx/OsaaG4GsmwYoSCW0LdKhJ
 X8EIlQIVOG+oASx8PawZ0Ym8+xxfoF8NvlCgQ+GVSyoA8oHItAXx6k3SJD6K/fxVeHK4Yn+Khup
 j80MNwjg9Q7PKRNNe+lCQyVCsJ13TNTELIX3JLAQobI6miJQ2CarIOOSWxFrM7AZdPeCsHHKjci
 kPHqpJw2oIq6a5bXU2psi4NaTPYzGvndfabOJHZ0aVQ5yGyfk9zgFS3919Afc+/Ql0hbO9IvyBS
 UFNXKnimLd3M25buWY7Dgqp+H9Nd/DKTwqSELm3D96BsfEwyrXNAr311afqV+yWdP61jiC3Ml2z
 Aeklnl0QfuB37Ld33C1lk5fSzTnNC0yqsBp/oxC41ViTiYY+FTne/4jbnw8SEQ38aARPNJCbLWB
 VOAQXhlU+F9yWvaAqDgOmwYevEsWRSPRRQ8XSo1gdDDT27Wz1Y/kd3rC+NYMJ7llkFp2PHDtR98
 G3ed3/EZP1MRqUw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reported by ASAN.

Fixes: 6d459c75cfc4 ("tests/qtest: add test for exynos4210 uart fifo overflow bug")
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


