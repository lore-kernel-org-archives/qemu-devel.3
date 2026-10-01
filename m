Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74514CA5FCB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 13:34:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCGuL-0002hf-I7; Thu, 01 Oct 2026 09:33:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCGsL-0008GU-85
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:31:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCGsI-0006Px-UR
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:31:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790861462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yYHNvJpFLSZFL7ouF7hNfIkVHpQ4xl/jm8rXxvtAA6A=;
 b=OVmN5SwXVKOiEIUHy8+9hzidpiX3h5Rxi0a8iLaOcYyJ7XerEDk8u02UsGko0RNHPV3xW1
 /4gIYcLzL5oSoqLPuneSCF22ALWy/VjzIUhkgOBKF8j1dKi50cMOrDyd+joHd2bluB7lI3
 lS4dNbyCY2bCuPuaAmqW/gVgRZm3PRQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-j3L0RfReMQ-msMEWOshdfg-1; Thu,
 01 Oct 2026 09:31:00 -0400
X-MC-Unique: j3L0RfReMQ-msMEWOshdfg-1
X-Mimecast-MFC-AGG-ID: j3L0RfReMQ-msMEWOshdfg_1790861460
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 011D018011F3; Thu,  1 Oct 2026 13:31:00 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 36A9B30000E4; Thu,  1 Oct 2026 13:30:58 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 01 Oct 2026 17:30:00 +0400
Subject: [GIT PULL 21/27] hw/usb/dev-smartcard-reader: report error on
 XfrBlock with no card
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261001-smartcard-fixes-v1-21-ebb5a40dd497@redhat.com>
References: <20261001-smartcard-fixes-v1-0-ebb5a40dd497@redhat.com>
In-Reply-To: <20261001-smartcard-fixes-v1-0-ebb5a40dd497@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1267;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=L3ECr7grYuToT7blHOBeTWg+GgZ4M8ndBx33X1qV31Q=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqvmBIu60d1Nh6qNBBlByNuui9Uc0p7WDG9iOal
 yxqjucX5bSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar5gSAAKCRDa6OEJdZac
 5aNUD/99r6ZvqwNbbgIA/6cXs52Yw3INBU93vcgo7rdudyKnl97Poc9r+Fs1iGVchCzTGr9Zsio
 8EZNDU8/lPoWFB0QR1VfxyzwK2JT3xK576ziRRER2Zl1ZCXMnevSQ1mq5GuQRwe3iymbLZdkbMJ
 NgIWsTGd/khS9MheFje/0MXQXXPRzd6SdbIRAt30NB34fijn1VMY80fN8QElhaS/ci2iH/0HVMM
 27qY7x43b/dJ71vehFCyvChY2+J+/Zf8Rn7fWmHjKevqkfM1QJdMMmTr0srjcs7w7Qzq093JNlT
 O8S8xd38lJnkuy51sZFDIz4cTGlJUoGmOcyqhHunB5fcclHLfJV94iqG+7poKdWBAe/JSfgeEvm
 /85ENJcizj6xDC4QJATCSYEk9opxvqJnx1Qi+cZPfhXRjoIYmFGpO4dY+kVsrSmbvxuTNGNibVV
 uMXNi5J/jvWbrf3aG81Xvn0stXfOw2veQDUBZclARPGX2pf4VbsyXDzG/1bESQT6hnzwktjbv/o
 mxgZbkeFsfveHj+XxOaAHJSsH7qkLdDpZIQHC7/9yZNCjasMbifjjxnw1vLTrNR5xS+N5kfrfo0
 XBTRUPC8tur87ZPZVdq4tsi2l3hkffRFp5rr6uhAv5eu0CGQUZJGdqJFggFrR0l9a0Pg+8KCvol
 xbf5Y4OEaF/3kMQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

ccid_on_apdu_from_guest() returns an empty DataBlock when no card is
active, but without first setting failed command status. This makes
bStatus report success and leaves bError unset, violating CCID Rev 1.1
section 6.1.4 which requires failed status with ICC_MUTE.

Call ccid_report_error_failed() with ERROR_ICC_MUTE before queuing the
response, matching the existing pattern in the slot-busy error path.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Acked-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/usb/dev-smartcard-reader.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index 208a14dbd1b3..65ceed57541a 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -1046,6 +1046,7 @@ static void ccid_on_apdu_from_guest(USBCCIDState *s, CCID_XferBlock *recv)
     if (ccid_card_status(s) != ICC_STATUS_PRESENT_ACTIVE) {
         DPRINTF(s, 1,
                 "usb-ccid: not sending apdu to client, no card connected\n");
+        ccid_report_error_failed(s, ERROR_ICC_MUTE);
         ccid_write_data_block_error(s, recv->hdr.bSlot, recv->hdr.bSeq);
         return;
     }

-- 
2.56.0.rc0.29.g47ce80527c56


