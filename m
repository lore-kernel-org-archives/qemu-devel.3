Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034DA606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 07:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KwB/P9UA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJR78-0004eq-9Z; Wed, 21 Oct 2026 03:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJR75-0004dN-0t
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 03:51:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJR73-00042q-GJ
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 03:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792569112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JupTufx8wx16zRgd1FXJYPMEUO2deNAaidiNZIsC3bg=;
 b=KwB/P9UARHlWm81I7KTMiegDfFWiux+Z1iFTKeWzNZGVGQnx08PCniE4vyEQwtEd3OxRil
 u4XzUEH56OzZdrbM54WKTsHj2WBPRTUxYQBopxt4sLxkht5A68B4NOq8BZFW4HpzdJt4xB
 ElzARysec3oLRiGjPdR9Mxv6d28ZUE0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-Ehn5osW8PHKzMgMQAUDxpg-1; Wed,
 21 Oct 2026 07:51:49 +0000
X-MC-Unique: Ehn5osW8PHKzMgMQAUDxpg-1
X-Mimecast-MFC-AGG-ID: Ehn5osW8PHKzMgMQAUDxpg_1792569107
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 444301800344; Wed, 21 Oct 2026 07:51:47 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ACC14418; Wed, 21 Oct 2026 07:51:45 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 21 Oct 2026 11:51:12 +0400
Subject: [PATCH v2 9/9] tests/xilinx-zynq-sdhci-test: fix GIOChannel leak
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261021-nohmp-next-v2-9-85471fca83db@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1226;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=xx8KsuA3vrL8IkXpXCmEI7mUiEYaap8Z6U5SZlwV1kU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq2G7t1/knq7ItIkcrybrLVXfYLgY65tuDFeDm1
 j9sRMVGni6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCathu7QAKCRDa6OEJdZac
 5ZQmD/wJGxsK5ZCY0GW2KfBSS5zSgObFAanhtm0mmHb+aF2nAtF+Dnot8NngNUYWxQcWqaSWzci
 j6MqyRlNYfAe2gw/1DfEkHP4mhnnKCKHjiZlwURBLRujVdiVyDo/V/zq0EwozUFv5u/xrO80zPf
 4IUx0uFETDSd1PO4KpqXFyID6bv1CRT53qNUX5i6QcAT4Gb0/KoUsnpmwAQ43u69aVg7niQG40J
 537BhUIDPPxetKMVdBSz5ARLNTUDPuoruXugqWQ4ceqrS3PSX53Gy6SGXs4QxEQQ4pHbjpPdzji
 4LY6NfSTuFgzAiYNJH5Vgz+nFPVXW9STWxsFzYNhytYYMX4RaRX9NyW4/a3uGOb8POPICtjxQg2
 kT2Yvq/NV+F0+iSpkCJZhuQTPGyKyHoSJlWxXqaUSQW6vGGk3fpY4BenzKKx4BjWlmZkz06PAZI
 Vd3V/YcjlxgNIGr0H1hQkv5oBFntEWA22kk6bY5orTfibRez/8UoKzpiGrjk91QqOJVodfztohB
 yTDKvyN9OSUbWUTpcBwSafBtmVzeBp+LeYSEl8vpmArycTvp+LYaKhuMpoAwelaJfQz/uU5YVQa
 pdKhwNKg3Yju/9MgsAJNWP8vW+vZztHBSBte5Z4l6GiJXMrjUCHmOup3Txm/ICkRyqQlaWkyu7x
 +HT2pH/MhEiUCrA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Fixes: 255c627c645b ("qtest: add xilinx-zynq SDHCI sdma test")
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


