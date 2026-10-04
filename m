Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77702CA5FCE
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:30:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJPn-00084V-U6; Sun, 04 Oct 2026 06:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJPK-0007AW-BJ
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:25:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJPH-00036w-PU
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:25:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a6RJgyUgneJxSAr6u/BntYVKldwQsIdnR5gZ46c6I8I=;
 b=VidixPPQvoSHW9w+lll4fD3rlGge3hkMoaKyMLzCn+Lor4RZQG4v8OYf81R1DjyIjU0J0w
 hhl2MCJ2JI/NLWvO+XuBJK5lYdVENxA6UWItvSvbBctGX72hzcJbDOpaYFkJB3PhAcel6J
 gPRefoAZYNuDxkaVKM5AbW61OhjUeR0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-Et4O8QuZPxmZ28Bp4xS1vg-1; Sun,
 04 Oct 2026 06:25:12 -0400
X-MC-Unique: Et4O8QuZPxmZ28Bp4xS1vg-1
X-Mimecast-MFC-AGG-ID: Et4O8QuZPxmZ28Bp4xS1vg_1791109511
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E1CF61944D33; Sun,  4 Oct 2026 10:25:10 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BB1B319560AB; Sun,  4 Oct 2026 10:25:09 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:23:40 +0400
Subject: [PATCH 26/63] hw/char/cadence_uart: fix RX FIFO overflow handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-26-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Pavee Hui <phui@google.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1709;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=wmlbgAkp5IMqyKQLFWWUMX/JP+57PU9lyUpiwEIUUDk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqwikjSnA6c/fRe15ABZM+8qTNZSOsUBti8Zfr4
 8Et5PlngQWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpIwAKCRDa6OEJdZac
 5diMEACLLT9LnFl5P1MRVb9OLs5ZLGBuejy4chfsMF7R7PjebmdBMGIwTI3XGv9AS5lBcaQLtXK
 NHiVcG13xyHED+79U0xskKZ0z3SQZYExGJSGb909YNKeBzpq9LKRcoAaJlBBGYNeQDAPs0ezf9z
 WYd3J/knlU+IJ1VBeAzeF2a/q9aO6PBFMoewNcLLRC1G2stutMMXNCBocdhtMBA8siBUJq+8JK3
 ug9OK8JHqzWbnI51nCn7cy4N+/Q2TpwWWfI2Dw7IOh4LU88+zqWbjpr6AgLdj6ByHyRT9NERJ27
 fLLKFZ4nCF4H0gdD9BuSPPHzEv/92iK8TVFQNOAPCDI5LlXEowjuAuOP7+RUGz0UJZKRHOYJFC6
 3GZa1e1VvpWcffZ8fZhOXbSx64Htaa/ulVfTK/YfgZr7RF6PJqgArIoe38kGMRLzuFyK3RFHC37
 DV791cZQHr3mkmRJ0Rn5Qb3PL6k9gmGHVUfQonznO5ags5ScQyXWOiTWE9C9VBGEjD8cTcZaxB6
 5K1GP/IgUd7EGEf+yQXQx8hLpZEZM6Olb/IYegBszM9LixzShqg/znaGMvdkZOuQ8LfvFX4J64T
 7DEeNSOLLT4cBDwsQ6jCOCeLxAw+9kRISQE/B0tr5kwirr0Fad7PJ1iZLNHqmuf6Q8YbMqCuh/c
 gCIhYKQV8Ygbn3A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

The old code checked for overflow only once before the loop, which
meant a multi-byte write could silently overflow the FIFO when there
was space for some but not all bytes. Check per-byte instead, storing
as many bytes as possible before flagging ROVR. Only arm the FIFO
trigger timer when bytes were actually stored.

Fixes: 35548b06cf55 ("cadence_uart: initial version of device model")
Reported-by: Pavee Hui <phui@google.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/char/cadence_uart.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
index eff6a3c4d17a..ae11caa11b82 100644
--- a/hw/char/cadence_uart.c
+++ b/hw/char/cadence_uart.c
@@ -284,14 +284,16 @@ static void uart_write_rx_fifo(void *opaque, const uint8_t *buf, int size)
         return;
     }
 
-    if (s->rx_count == CADENCE_UART_RX_FIFO_SIZE) {
-        s->r[R_CISR] |= UART_INTR_ROVR;
-    } else {
-        for (i = 0; i < size; i++) {
-            s->rx_fifo[s->rx_wpos] = buf[i];
-            s->rx_wpos = (s->rx_wpos + 1) % CADENCE_UART_RX_FIFO_SIZE;
-            s->rx_count++;
+    for (i = 0; i < size; i++) {
+        if (s->rx_count >= CADENCE_UART_RX_FIFO_SIZE) {
+            s->r[R_CISR] |= UART_INTR_ROVR;
+            break;
         }
+        s->rx_fifo[s->rx_wpos] = buf[i];
+        s->rx_wpos = (s->rx_wpos + 1) % CADENCE_UART_RX_FIFO_SIZE;
+        s->rx_count++;
+    }
+    if (i > 0) {
         timer_mod(s->fifo_trigger_handle, new_rx_time +
                                                 (s->char_tx_time * 4));
     }

-- 
2.56.0.rc0.29.g47ce80527c56


