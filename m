Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50098CA5FF1
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:27:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJQ7-0000Yp-O1; Sun, 04 Oct 2026 06:26:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJPT-0007NR-GU
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:25:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJPQ-0003KZ-V8
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:25:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=28lTlXxwdAXV/sf4XAyLK5GtDQHlCgt2z/t3HmAGeCc=;
 b=fyoamokdNK0o8sm3ujYzrSfYdc1N6ScsusWxvrpxgr1J1gtzjOrsLIV0wWDrBC0wMrbwqb
 4qrbACEKgcNs89hr0gLnudaWF4M5pCui1W7qqDkifFlmfz+j6JSPgSP2ZduSGLz8moJGa/
 CJgPj6xOv1bwrbDIAxu/Th0CP1DP20Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-311-wQOevcsYORqdLyDm4JY8lg-1; Sun,
 04 Oct 2026 06:25:29 -0400
X-MC-Unique: wQOevcsYORqdLyDm4JY8lg-1
X-Mimecast-MFC-AGG-ID: wQOevcsYORqdLyDm4JY8lg_1791109528
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0D1B61800591; Sun,  4 Oct 2026 10:25:28 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E96411956042; Sun,  4 Oct 2026 10:25:26 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:23:45 +0400
Subject: [PATCH 31/63] hw/char/exynos4210_uart: fix baud rate calculation
 operator precedence
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-31-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Pavee Hui <phui@google.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1028;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=J9TsU9+Nyb0d7T7dqv8Gm8o1O7dkcS4vJdsHcHfkEF8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqwikjRFqXxfz2HpwkpV9puAaxBMGAHkH4gT4BC
 knq5lMmywiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpIwAKCRDa6OEJdZac
 5Yf+EACecMtOdA++sLUfnBm/OZPm2g913p5qlHFq4Mum7v1/2IQ+DbhiM76PVU4W6MqwUtwLU6N
 tuAbBCeOo7PPlr2Qhci41DDU1uyJ8RjXLAdm4DpAorbXgMIXZVlfwYXsqkpf9AKiZ3/mCg4ObyG
 1sdJn4kmp19OnPQzSjy+PwBgu+/ZkeNHP5M7hk0BwlQwlJyDW1hmvikquYwf7OpbeB5ecYVjhwA
 Dbu912UtYM4vusB6gNKUWtp1q0Ep/sIZIVUTv2zjjEDVV2YPQJsdBj0lsiQPqyR4GIe4YAWwfmZ
 V0Yf+jgxV/IRuByDHi7+s1mdlCIM4uXk24B/Z3z1kn27V9JCgvcqyB/uRWw37tttbzNVIbw8ft4
 EdTP1wmWRn9pOk3km9c3LYoextXYJdbyCRB4JR5sM+L/6IZ3fZOJr1d6tguIyvdEqMjXltj92uq
 eByiTUqvH0Qq10anPgvbSVF25TwUd2GdpUwn5jSGzKCExius78IztIdjRj5nYtAu8izafOIwToJ
 LzIqYzGNa1kyEjAOIpODKvmU8ujOQqI72vJALjiV3vKq5FW6ZUO/Q4suFAv+rJNwhlAvGzz6kdF
 +haVhLUm0yq1VcfEt17n3RT60e6k7Jm0zHTXu5qi/OZcrXb1fkx7IOM4KyX335MQRkVlZ7YOB/1
 CVATPlYCxZTIDBQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The 0xffff mask was applied to the result of (16 * UBRDIV) instead of
the register value itself, due to C operator precedence (* binds tighter
than &). When UBRDIV >= 0x1000, the multiplication by 16 pushes bits
past the 16-bit mask, producing a wrong baud rate calculation.

Reported-by: Pavee Hui <phui@google.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/char/exynos4210_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
index 9d1825150d1c..7240ff7b5c24 100644
--- a/hw/char/exynos4210_uart.c
+++ b/hw/char/exynos4210_uart.c
@@ -327,7 +327,7 @@ static void exynos4210_uart_update_parameters(Exynos4210UartState *s)
 
     uclk_rate = 24000000;
 
-    speed = uclk_rate / ((16 * (s->reg[I_(UBRDIV)]) & 0xffff) +
+    speed = uclk_rate / ((16 * (s->reg[I_(UBRDIV)] & 0xffff)) +
             (s->reg[I_(UFRACVAL)] & 0x7) + 16);
 
     ssp.speed     = speed;

-- 
2.56.0.rc0.29.g47ce80527c56


