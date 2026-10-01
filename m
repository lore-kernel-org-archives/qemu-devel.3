Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 447BFCA5FD4
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 13:31:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCGrx-0007sw-Re; Thu, 01 Oct 2026 09:30:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCGrY-0007dB-JQ
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:30:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCGrW-0006Gx-SC
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:30:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790861414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=afFbDYOQZfArFQRaDE/FdfHqCf2G1EobRY/qHgBIMl0=;
 b=AqwmrySn+u8tBTd+iwwITa6vc+mq1LQqsoTPZkyG8Ip8m2sDN4BFuba6dVG7Zuo/4ZbcWU
 2dErR0a+KwW8gTEWMecxCIFm2FmpVubLjEhKkAmdAY6Tbc3NVz7JPDqnZVy1f0ozkxcQOt
 Lb2BeKERu8mBi16NeVsxZWFySEs7xsk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-320-W45b975PNuuWfpSnuCq77A-1; Thu,
 01 Oct 2026 09:30:10 -0400
X-MC-Unique: W45b975PNuuWfpSnuCq77A-1
X-Mimecast-MFC-AGG-ID: W45b975PNuuWfpSnuCq77A_1790861410
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EEC30180136E; Thu,  1 Oct 2026 13:30:09 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2F7D5180029C; Thu,  1 Oct 2026 13:30:08 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 01 Oct 2026 17:29:45 +0400
Subject: [GIT PULL 06/27] hw/usb/dev-smartcard-reader: fix OOB read in
 atr_get_protocol_num()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261001-smartcard-fixes-v1-6-ebb5a40dd497@redhat.com>
References: <20261001-smartcard-fixes-v1-0-ebb5a40dd497@redhat.com>
In-Reply-To: <20261001-smartcard-fixes-v1-0-ebb5a40dd497@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1100;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=5iowlDNhVdaQdg2jc1MaJUDefvrVlJpEui2BMNoySAo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqvmBHZQHDGvfZh0IipXzszfc5h2BqRV3BJTEha
 Fq13m65e0iJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar5gRwAKCRDa6OEJdZac
 5V0kEACw/JzN1QFUoLZtw5DJ8236XBGs5DM+fkQSjHfYCiYtK/pRuv7wqBWHYbDDG6Bfb88eGFM
 E25Y6WsYUogDf8kSH6uSawTvpEyshZrEjga3jpmpwfkqALhtjOpTrcFR2snn+DcIV/txFS2Xhz3
 xUyPiEVSsr2KJTQQcxZGQ/AqvtD+aaAlJkFcmsDnt9u2XnuOrn1X7rcWbyLwHoVi2kIjalawHjx
 bjN2WY7MRt7VXjvLEBvGBWWE54+VKPmW30mHucAUCYbcrzfyrBcQjaX0NG09xjs6lyNgepzp1uH
 rNrWABeScS0joM5SqR+FAQ0aZLtGCw62qs5r6NNNhPvd1f6IRduiCZx43VCa+zxc7Aw+xXy3wlr
 Ccmu8QHimLbiSPz0DtOEGlGokVQwzeg+HTuheV1GtW2oGg+wY2XeBD2daXp6FPkoDCIqMMewXKD
 pCDpXmxQ3xX8Uq8wKQZD7KA/j4a1j6+/BWahkk98Oul3Ddq2+qOlHy585wrXNutDdwkFdMA+Fot
 VJfj+MDhsRkD6/ViZd1ryPW18p/rt9fBxfvkZuBlQa+i+FUpM/Wb6mcKWxFybVC7Ls9evm3AoPm
 YQc/lwd9ICJR6A429fSsX2jXQYxn0iprsLrplNjYLN5zuwtCtrYc5GQEuWFJr69T4SSI25evPUn
 UMPXWvzVZVyqV2w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

atr_get_protocol_num() computes the TD1 offset from the T0 presence bits
without checking that the byte exists in the ATR buffer. A truncated ATR
causes an out-of-bounds read.

Validate the offset before dereferencing and fall back to T=0.

This is only triggerable by a buggy backend.

Fixes: 2f8f916b6d44 ("dev-smartcard-reader: copy atr protocol to ccid parameters")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Acked-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/usb/dev-smartcard-reader.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index c200af41c83d..b05f4a85666d 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -840,6 +840,9 @@ static uint8_t atr_get_protocol_num(const uint8_t *atr, uint32_t len)
     }
     i = 1 + !!(atr[1] & 0x10) + !!(atr[1] & 0x20) + !!(atr[1] & 0x40);
     i += !!(atr[1] & 0x80);
+    if (i >= len) {
+        return 0;
+    }
     return atr[i] & 0x0f;
 }
 

-- 
2.56.0.rc0.29.g47ce80527c56


