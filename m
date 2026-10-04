Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9190ECA5FF1
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJPl-0007pO-Vb; Sun, 04 Oct 2026 06:25:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJPK-0007AY-CT
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:25:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJPH-000371-PU
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:25:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tk50WfpApsEOV64E0IoWHeyeK1LBW4KdtEG0hdo7urk=;
 b=H7NcpUQKFxk2MZ76Ai8Owc/HwVL9DMGIDpPQNHcfjE87FsuR7jbfRq4P/Rx7Ix0ryiK75a
 QLAm1uNXHTPGsg8fWNFKw82yA6mUrOO8Gt4eZAOYM6w7haF+XmkrOTyeon9Z7hAr3zxDcW
 WybqnCcV68rSYKCh8qgqQgfPQb6Pbp8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-hTalvSE6O0ehOEdmfUEvKg-1; Sun,
 04 Oct 2026 06:25:15 -0400
X-MC-Unique: hTalvSE6O0ehOEdmfUEvKg-1
X-Mimecast-MFC-AGG-ID: hTalvSE6O0ehOEdmfUEvKg_1791109514
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 007261954204; Sun,  4 Oct 2026 10:25:14 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0F72C40E; Sun,  4 Oct 2026 10:25:12 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:23:41 +0400
Subject: [PATCH 27/63] hw/char/cadence_uart: use correct interrupt for TX
 FIFO overflow
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-27-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Pavee Hui <phui@google.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=935;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=MXIU9SlcUTgKpIf/IAMsCmYcu6Slla/qJQelbHZoA4Q=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqwikjproKUO8aa5zxkukIgKvSp0O0gJkCi6PDT
 82boxw6xw6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpIwAKCRDa6OEJdZac
 5U4vD/4ltcyaaV/MNtoZ9HicAU4rj7ORWBNs9R6LpTFfm/I5IbavczVYHUutM96HaqddJzdvKYY
 MXDWc2RA0AhDGLdSmE0DZrhCzgSSw7ND1Xw/2pYrDY3oqiVbUE/3xFk8Nx6dU8M68h8snvtb0tS
 nNvP6pnO607oISI7n4GMc1fkbEOPz4qAj7Oi6VObrxCN+IwqQqhoJ/U4fdlEwsOCWIugB4n5cs5
 qEQDMaxtPpff3zu8Xt8Q4uegNwkOMtoOJLdq/BvL2tz+zhY8kFOTh9Zo3Kie9dkFO6XD2Ez2Mac
 35fZDg5hD7RJvGKjp4J1GY6IU17ITXhflc5GA6tJHGiMpzX6N8CFVb8162qsOC5dgS02AJAFmmF
 jr/roeRi69ojVZX0IuYKNSkuA6XjPHrD0KksYggvW0yLS+qPTiVkdDBcG7Zn5UN3gSr2PeUiyRz
 LYwP8KaCrZnTUpDyIoCZGtrlZmqOzyBXROB29LzYbZMSfM8ZWYNZ7kq3G03LbQHG7Bzcwbh3KFB
 5QRTNCIbp7xaoho/MjQHch7jK3Si5M2ivVxtLX7Jb8BwJGubIMgERiF2kqllYE2dFtIpPOOTpaI
 9H/gQiJk3eJZI9ZpJYRAi9qJCoThBXqXKp0qQS7f09UWfBLPGzEPqAIuhRfM+c+m5RM3f0Es6cp
 VCGfwLnIC3exrqg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The TX FIFO overflow path was raising UART_INTR_ROVR (RX overflow)
instead of UART_INTR_TOVR (TX overflow).

Fixes: 86baecc3e435 ("char/cadence_uart: Use the TX fifo for transmission")
Reported-by: Pavee Hui <phui@google.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/char/cadence_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
index ae11caa11b82..c790372e98fb 100644
--- a/hw/char/cadence_uart.c
+++ b/hw/char/cadence_uart.c
@@ -351,7 +351,7 @@ static void uart_write_tx_fifo(CadenceUARTState *s, const uint8_t *buf,
          * us to here.
          */
         qemu_log_mask(LOG_GUEST_ERROR, "cadence_uart: TxFIFO overflow");
-        s->r[R_CISR] |= UART_INTR_ROVR;
+        s->r[R_CISR] |= UART_INTR_TOVR;
     }
 
     memcpy(s->tx_fifo + s->tx_count, buf, size);

-- 
2.56.0.rc0.29.g47ce80527c56


