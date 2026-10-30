Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E81D606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ppyk5lAR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMtwM-0007f6-KO; Fri, 30 Oct 2026 17:15:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xMtwD-0007c4-Fl
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 17:15:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xMtwC-0007qO-3Z
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 17:15:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793394899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VyXgq1DDXioBHKFmhDSRrecUaXRMoobWR+jycwhTqQs=;
 b=Ppyk5lARQbjv/d9/8qcXQ2ijgqe4hLr5JaknpX5czQK/sdL7ubKa/5cxCGx5yKLcwsMl6V
 yBhd1LmyPtdjwTknHONNpIxGZVnbgAhBqarZQNMx07Jc6yVZ8UX2H9hWQdN5snX8WdsxIg
 opq9iFXM5N9KPyFWeA/AvkLYg53Rjr8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-79-POs7zeh4NoSOr4tRj2GaHA-1; Fri,
 30 Oct 2026 17:14:50 -0400
X-MC-Unique: POs7zeh4NoSOr4tRj2GaHA-1
X-Mimecast-MFC-AGG-ID: POs7zeh4NoSOr4tRj2GaHA_1793394889
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C485D195604A; Fri, 30 Oct 2026 21:14:48 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DE8AD1956087; Fri, 30 Oct 2026 21:14:47 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 31 Oct 2026 01:14:13 +0400
Subject: [GIT PULL 10/10] tests/xilinx-zynq-sdhci-test: fix GIOChannel leak
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261031-nohmp-next-v1-10-9a9fb205cf3f@redhat.com>
References: <20261031-nohmp-next-v1-0-9a9fb205cf3f@redhat.com>
In-Reply-To: <20261031-nohmp-next-v1-0-9a9fb205cf3f@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1381;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=DZK5TRFGQWVf7qNN++WjgyYu3fgIJg6uTk9cT5heCmE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq5Qih7AcSFmOfK/lZEcPlHToMXQJujUFaJbrPT
 jXaql45U9aJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCauUIoQAKCRDa6OEJdZac
 5ZoIEACvNGDJYHa1RYsEh5BFE4d4iFHskYtbbxTuDKbbGEj4AXgUpMiFqSjbHhrmtlk2GpMAPRR
 lKfni9q39EJgH9jOoRhN2Ad+L6L6jzNkKENJryPjSEj5G+Id+1QPOjF8zt7PDO3j7qqSA/bFnuG
 6qatqSjIqIf1cdcwsCtxaixzbLfUTK2w8QY+kupGaGsrix0td6+GLveDDpsx8q/ArXpxWWVFA42
 Ke/cpU2PI8H0UhNVyBAKpgQJRFch3jmwy+2Dr701htTjiTtoY/3pxnXAtqMGyrX8KRhMEcxPd4q
 trQS7najIbut7A7LfJJL6y2GV0UyFYGNZSjbTZvC0Dy/fcraRc0auf33t5dZndAjDxUm+r55gsU
 mpjTTKsZrfKt6v38VmrtvRme7+exgcDNOHTNDSwq077/XlY5aVm2MrTupzH0jgRr2HphzP41HSr
 AOXzIk+ZJjUUk8Q/LUIrz51mrP/ZtcNXX8cqR7XEDyT+z4t588t8S4JYeR+ot/v//7vknTU6yAL
 1CNsAKOADWdOwyUDqBb59MYBINx8voF/xqbDsuSz4jPQEjrfBkHJ+ye+vcIsSHnGM/1/LyUOsrK
 u47NF8u9Cg+DxUfGC1zn5F7piQ2QFUBmjJ6ur4lnQ6pD+2A31efHQPSMaorFpDbL92FUm++9iR3
 vMGOai2Qp/sTOgA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

Fixes: 255c627c645b ("qtest: add xilinx-zynq SDHCI sdma test")
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qtest/xilinx-zynq-sdhci-test.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/xilinx-zynq-sdhci-test.c b/tests/qtest/xilinx-zynq-sdhci-test.c
index 7957358cf5d4..42e1b8f46e88 100644
--- a/tests/qtest/xilinx-zynq-sdhci-test.c
+++ b/tests/qtest/xilinx-zynq-sdhci-test.c
@@ -58,10 +58,10 @@ static QTestState *setup_sd_card(void)
 
 static void write_pattern_to_image(size_t offset, size_t len)
 {
-    gchar *buf = g_malloc(len);
+    g_autofree gchar *buf = g_malloc(len);
+    g_autoptr(GIOChannel) chan = NULL;
     GError *err = NULL;
     gsize bytes_written;
-    GIOChannel *chan;
 
     for (size_t i = 0; i < len; i++) {
         buf[i] = (i * 13 + 7) & 0xff;
@@ -78,8 +78,6 @@ static void write_pattern_to_image(size_t offset, size_t len)
     g_assert_cmpint(bytes_written, ==, len);
     g_io_channel_shutdown(chan, TRUE, &err);
     g_assert_no_error(err);
-
-    g_free(buf);
 }
 
 static void wait_for_block_count(QTestState *qts, uint16_t expected)

-- 
2.56.0.116.g6de20f6092dc


