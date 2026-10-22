Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3EA606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 11:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jMHYNeMO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJrJE-0000ro-RV; Thu, 22 Oct 2026 07:50:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJrHT-0006vP-74
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 07:48:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJrHQ-0007Kr-Jr
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 07:48:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792669699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FujpUDGVZaJGZHjNg46qd4GgLkVzbOQUl0Lo+C7bKQk=;
 b=jMHYNeMO19dU53XvD3or9T2pmFD780OvsNCl2WO3g/Ex0qOK0EkF2jL6m1A7ZLU2+yfllt
 wD1bgy08s6nn6vkhsKBWwIJnrJakSB37qzv+kcG8k6pb62mEiWzBR+g2rLwvR1h0PIBco8
 SwQue3EEfZVAcawIUCyPH+1n6nIkQRc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-osoJASdqOwWTrDBbFX2UEQ-1; Thu,
 22 Oct 2026 11:48:13 +0000
X-MC-Unique: osoJASdqOwWTrDBbFX2UEQ-1
X-Mimecast-MFC-AGG-ID: osoJASdqOwWTrDBbFX2UEQ_1792669682
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7577F18005A0; Thu, 22 Oct 2026 11:48:02 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6B7781800480; Thu, 22 Oct 2026 11:48:01 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Oct 2026 15:47:22 +0400
Subject: [PATCH v3 09/10] tests/exynos4210_uart_fifo-test: fix buffer leaks
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261022-nohmp-next-v3-9-8b581b590512@redhat.com>
References: <20261022-nohmp-next-v3-0-8b581b590512@redhat.com>
In-Reply-To: <20261022-nohmp-next-v3-0-8b581b590512@redhat.com>
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
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1184;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=BRj8nTj/h5jiYm5/VZSXhg5EUw24S+JVPkcosvSgD5k=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq2ffN2RoEsv96v3tt+xG0fQ6ousoO/IAa/vedz
 g+79K/5NISJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatn3zQAKCRDa6OEJdZac
 5ToXD/9rXdKBNKylaEsp8suO4UMDI10PxAzUvTCAyKyp/oAVJOSYF0+z32XoTg1eZFjCelDhf88
 5qfzgSktK0mJN+qBEBjwpMrVWc3OI35GNj16VyFa3jHV96ipfdXGjNQazmDF7NEbKw2ykentONh
 72Dzt9UVcd4jqfVP0aYMVut1BIm5ZhlCiaCG5j7/Q8jWWxhDLtHSUE9I2MFjUiDmmo78M7MMFeM
 /dl/b2vZvtgHoxBBryefF5Wb9ytT0h+NJbiimEDeeIdwMZWMrN7Iq9iTNljIPMUxq6CKHLa7v0l
 eNYfLd6VzpmKn9MehgdtqWy3lJ5X9oN7ANL0TKdi2rkTBtx6l2VrDdCjYvAmrkpHvjd1MP7zPDW
 /rvJKKc5a3Y4M6B3hJgVGZeraTB5SqNTYGHfHIo+3gt2XRk0EeZ+h/VDJHE3ZUzzfOGrk4ahvaf
 Lxwvpb0RdhtGGkgLjxbQEfOPHvV32yVcFPE7T8UjPgIJ/mFefd4nU1v5P9f/auciwLDfFNUlsNz
 3zPjy2FlqLew0AjTPpk5eE55t/HKlZ0Tdqk1UM285YmoTkmInZKl2L8V0iEs5q8DJd4IgzOlnvE
 NFBkVLN6btB+taN9DEhdS93tAe56jLwGF1WjreeI31e9R/8u8Zqz1cBFCUuHFHCeyXnkC9gpVIq
 ABT764x2Fvo9QeA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


