Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05CB0EDEBF5
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 22:24:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxY83-0004ho-Fm; Tue, 03 Mar 2026 17:22:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vxY81-0004gZ-Te
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 17:22:09 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vxY80-0002QC-Dv
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 17:22:09 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4806bf39419so52539695e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 14:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772576527; x=1773181327; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CJx9Hj31eX7Y3Z+9nYTXa1xFEWa58APXwA1Xzcuwa6k=;
 b=RqflqJbzeXicS5hH7gdBzOH8KJVlFMtKHt1WY2kXulGOncBCwz8GP5bozCLcuPN14t
 LnfvcR1ldNdA+R+YUjrHoJUP70LQPavRhmA5wwqDpQKid3ftbtFKG/eTt4xN7KP3FEvx
 cmYT36lMrKDEf0NmjeeMJO414oVoO++P7YdV+0y6RBsBTkz4paRd6/dJX31D1oOx7gg2
 yeOckhLTMUQxGacuQd+2xw67dfosvgay2YtZhAjnUub9covp4MJiCrdpZThm9wnRn1UX
 Gpn8ZgTS4Sp6krLTIn8Y2b8a8Bt57qee9KD/sMRyBnH+dVxVwkg2Cztufu36n2xvOl/a
 564g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772576527; x=1773181327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CJx9Hj31eX7Y3Z+9nYTXa1xFEWa58APXwA1Xzcuwa6k=;
 b=PReS43SpT8WHbN1hYiQr88MPCXWD1sEd+W/XKz7CfkdOWAlQqQ8WtK0MQIpLm5XdHv
 De9qDHO1e4TRwxbt0LuUTv86ps1R7Xw2HEa/6+hjC7ydiasXzcMtNVj+djbeFnRF2iYp
 lHEWWEPGkpqPy4fdMJONhXy8hjbs2a1wW1Nr08/Q/ler9QoK7xS51Yh5vUMtVWXMc+XB
 tforDtxONIvFM2X4ORL2mmnz1NoEDqsUxDJs5cO6jZUlM5bb9JU2oZHQqsnTAFvoTT5Y
 l14Jfqpl6xhQz6NYw/IkrdNeDrNF40tAFXk7e0Ok6uZjWn7TFDBqlF3mcdbBnbVSfcvV
 fhpA==
X-Gm-Message-State: AOJu0YwVw2OkXL3qESrGdMxU0oGRvVPozZxnJl8RdOXktPEsbXf76Ag7
 AwjLQjIocqF4ModGPBDWJGcl1EHbeqmH2NfrOgTkgDNpLCVIf65CJS2l9/LcbA==
X-Gm-Gg: ATEYQzwjv9moJQ+552ernSWtWD8i+gpewir/qysZVk9Vqfx2EenXTdHuv7nMOZ82eIC
 RV14hLrIXx2/CGRXNjqdgIt22kt5Rjjt7+ZLEM4OrdzJHoAel8cjtXjLU2BfolwSsvLBaHycZyw
 TGGFtgr0fkl9w/lNsgG/YvbWXMQl9VqdgKVdnEmctfPip/dTbQGCGRI087c8E4MoBIm0YFRLcVc
 wiZtoXfrJBuLSz+GEb1TtXYtJ3nYqLHJ5k9qMlVHy43xpqRZtIMkdLbT3CkGiUtBSSlxy7KlnHp
 /0m0Zv+2/QkI+fKgjERP8vE1P0Vbd4JC3oswm6LovbSnriRnQvZ/mHS83UIrQYQUFHfIlOMnWbR
 UzM80lcMsOjzyatzMOjIohYvrWcqc0wcq+E0a6CGI7w1veu8rB7kTF7X314ON8TxAiS9NwSAA3v
 splGMH3vwk3eRSoSA7E4LzKJyXvznJbEjZeeElq5sxmFgDoYPQslMTjF+82ZugEa7Ia79ahqk0t
 88Qrxrbvo3CFVooVAth9v/4O11Fnig=
X-Received: by 2002:a05:600c:8b44:b0:479:13e9:3d64 with SMTP id
 5b1f17b1804b1-48513c76ea4mr57049865e9.15.1772576526557; 
 Tue, 03 Mar 2026 14:22:06 -0800 (PST)
Received: from Provence
 (dynamic-2a02-3100-1c79-b600-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:1c79:b600:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485187c81adsm7577715e9.6.2026.03.03.14.22.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 14:22:06 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Troy Lee <leetroy@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-arm@nongnu.org,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 04/13] hw/char/serial: Remove explicit cast from void
 pointer
Date: Tue,  3 Mar 2026 23:21:34 +0100
Message-ID: <20260303222143.142741-5-shentey@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303222143.142741-1-shentey@gmail.com>
References: <20260303222143.142741-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

A void pointer asks for being casted, so C allows for omitting the
explicit cast. Take advantage of that.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/char/serial.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index adbd1d1d4a..0f2e79dfba 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -715,7 +715,7 @@ static const VMStateDescription vmstate_serial_thr_ipending = {
 
 static bool serial_tsr_needed(void *opaque)
 {
-    SerialState *s = (SerialState *)opaque;
+    SerialState *s = opaque;
     return s->tsr_retry != 0;
 }
 
@@ -734,7 +734,7 @@ static const VMStateDescription vmstate_serial_tsr = {
 
 static bool serial_recv_fifo_needed(void *opaque)
 {
-    SerialState *s = (SerialState *)opaque;
+    SerialState *s = opaque;
     return !fifo8_is_empty(&s->recv_fifo);
 
 }
@@ -752,7 +752,7 @@ static const VMStateDescription vmstate_serial_recv_fifo = {
 
 static bool serial_xmit_fifo_needed(void *opaque)
 {
-    SerialState *s = (SerialState *)opaque;
+    SerialState *s = opaque;
     return !fifo8_is_empty(&s->xmit_fifo);
 }
 
@@ -769,7 +769,7 @@ static const VMStateDescription vmstate_serial_xmit_fifo = {
 
 static bool serial_fifo_timeout_timer_needed(void *opaque)
 {
-    SerialState *s = (SerialState *)opaque;
+    SerialState *s = opaque;
     return timer_pending(s->fifo_timeout_timer);
 }
 
@@ -786,7 +786,7 @@ static const VMStateDescription vmstate_serial_fifo_timeout_timer = {
 
 static bool serial_timeout_ipending_needed(void *opaque)
 {
-    SerialState *s = (SerialState *)opaque;
+    SerialState *s = opaque;
     return s->timeout_ipending != 0;
 }
 
@@ -803,7 +803,7 @@ static const VMStateDescription vmstate_serial_timeout_ipending = {
 
 static bool serial_poll_needed(void *opaque)
 {
-    SerialState *s = (SerialState *)opaque;
+    SerialState *s = opaque;
     return s->poll_msl >= 0;
 }
 
-- 
2.53.0


