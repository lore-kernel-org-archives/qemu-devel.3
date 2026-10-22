Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACAB606A31D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 11:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Cm60CaqP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJrIq-00087u-4H; Thu, 22 Oct 2026 07:49:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJrHK-0006pW-2C
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 07:48:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJrHI-0007JB-Ik
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 07:48:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792669692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0tDABSE3pTCICLY9FmNTqSUPOMsAIDyqPC5pZoQ/qiY=;
 b=Cm60CaqPDq0rPPqb1Re4uNcF4MwYjj5FBMjyPuZ11DGIIulmGPSNSRSjDi5ck0pTxZfG4B
 oyZTNEqLrfLC4fcZRBIb5OjCLjYmOFtqIPWk+PQOnHnDsGotD6o12hYBD7VEu/3vBWk4bX
 1gPsNqM/xdSSWiOj0OE0Yyurjym5zuc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-I-V2zejcPaSEV0B_DcQrYw-1; Thu,
 22 Oct 2026 11:48:08 +0000
X-MC-Unique: I-V2zejcPaSEV0B_DcQrYw-1
X-Mimecast-MFC-AGG-ID: I-V2zejcPaSEV0B_DcQrYw_1792669686
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5115D1956054; Thu, 22 Oct 2026 11:48:06 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3C4281956089; Thu, 22 Oct 2026 11:48:04 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Oct 2026 15:47:23 +0400
Subject: [PATCH v3 10/10] tests/xilinx-zynq-sdhci-test: fix GIOChannel leak
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261022-nohmp-next-v3-10-8b581b590512@redhat.com>
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
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1290;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=q8J/y3hmdKkcrVl9eijNHa5xCK6axq1o5tLk9qkNbJ4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq2ffOjE5lbQJMRPf3uHjmjEF6g6+cxUEq/SlHC
 ox8rXFnNbuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatn3zgAKCRDa6OEJdZac
 5dR/EACUXwZBPFFg239eqvP4hK3+x1oXR/wxTR1CxxzYktmge5H9Mz/IxKsz7dfXljphJLvn+Dp
 Lo80aIjAeWIj2FouECua5nYTSrtIpNK4NCzobsyro+OB2Hg/3pnd2gq2uyx62j7E27c9ndpAOOh
 Zw6TlKBMuZWAJRxrWTw3qj9wS6/3LJuDya1TRVfFMP/9BdX6n/3SFs9nmEmGPvNn5Tw4G8+b3P/
 jjRTOUtZ/aDgkGJVUWjyUBIxlRZunpQdlPHuzHKflZd/YcatzjjPBVanulLP0idMHStYkDo1VxY
 US2o7qwFiZ3WfAzlZp1klkUrt+t8L6Yy8zaZKhNPJs7bxQchKUWHcccuDNX/seV18YPJo4hFc15
 KWyytSWyKF6xaIt6nEdbPrtB2sUEz+eBiunm4mwiU2mQuIqjPv+pxqqs5SG9t39WljPqS2Owyem
 CezHxssQEA7N/HjhVPUFs64mKtQKNlrn7SkpkqOnn2m3KZNeRkOWUQ7HfpG7W2mOevOFR3wcmEj
 ZkTeABAXK1GRWd8ylXDz2Hu7KDo/rYuh+DJy+ojBx8St2Oo5g53jDsod1sJsxXXkfJbKfxVN+Qu
 qmhnoEidHVPcK7cb5McJTR85pLQ/DArgZ2f70BBPOmScBB2ieBslZZXcLOegRnRefSc8tS4bTed
 4Jtr+WfbD+HBdgQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
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

Reported by ASAN.

Fixes: 255c627c645b ("qtest: add xilinx-zynq SDHCI sdma test")
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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


