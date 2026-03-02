Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3074BEB363D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 22:04:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxBM8-0000M4-Sv; Mon, 02 Mar 2026 17:03:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vxBM7-0000Kl-CZ
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 17:03:11 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vxBM5-00017Y-V7
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 17:03:11 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-436e87589e8so4745277f8f.3
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 14:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772488988; x=1773093788; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J3N+1yHcxqfmWgXhBpMNBjivWGghseKDEx+m36TEs5k=;
 b=OJD+LWYw+dIHip8psNfKrEkN4B6HVhsgBnDwUGKOMVMaJP+GBJlS7D1l+/odxPNe3a
 wgO1Usyu1PWufKRMSzYABsiAGxVQnjeianK5n+8IlY5ibfmkilGIKO2EZPugmEA3PrgV
 AkQJV726Yzjl+XtVNKTQnq6Wqn4Zh4z2H435QpifoJq2zaW53H9I78me2A6Pg4cUVFZW
 vw40Fs+HhH1JpMelsKkcnnxEq8M1KTodqB7e673TUhrCibh32LZUOA209qQ//i+oP1wQ
 FWm2sG/xG1ob7YsX91mgwBJn78SQqTPtTcELdHZ4caA28ML+Dfivd63bFE7NxeaDaM8d
 KIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772488988; x=1773093788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J3N+1yHcxqfmWgXhBpMNBjivWGghseKDEx+m36TEs5k=;
 b=eHiPnaOa10UWxN4VkUmW4u48VvSblkZxeO3zzpoVslug/r+b2NKlElynlna8I+QH1s
 dJDh4SR3S/pnkzn0lck736/5bKuzFXaaLUjX7JjrFD96RTaI8RIMPfezoXGJ+j4NONAU
 Po9ssZUuUSE1ddt45N2DqSG7nJKnbARg2VSnE/m3K0HKtVl7D29nswZzI3R680yPten7
 5BA5TH5+ZiEHSuurvpz/YLRKOafaMi6mmJsdsH2EYaedIxzvpjrANALbQ1TgupKVc3vf
 SxgEMIX575DzfpXAHU3TN7z/tR4zCG66B4LNiQVy+pp5a8mwmBmpYjui8pqLmD5gfQRA
 cn+w==
X-Gm-Message-State: AOJu0Yz67r1wWnZEXDjdfJ0rN1ucdUYqS5t666zYwkhN8kIVVYCfLXwj
 qWse1iVzBjN+ut+JAdJmuURHa3uNcaKwaLaTaa3V19dfcIhVpdoMrg/hs1CSyQ==
X-Gm-Gg: ATEYQzw62F0IKLkYscFFQ4Wyy37Bd4BB4bkLw7uaX7mMffBLwt2NaGo6mOnGFDcQwNK
 +XNkC4iPvNX+6QybTkTog7waXxN1is8PIGWYq0R9zqyKPQb0tWfcLm54qFsYq9Vn/j0TEiE4t43
 YwwbtFJvwGadpscRNPlwjbqmq/IBjSoDx6uJCrdN2tEvI/IvaiZlUiuqqZ65D55otfhXPVnrFBL
 mHymjxFiSyYmTvYzqkJB8Sf2e9y38RAIh0gGi9IHi+rb6xQ2t9V3paaERg16YxpTXscwiVHEkoC
 nDxhfoLO6DeXXq2fz9NyeN8i+LQD+VozUEqydlEyMEhFGQpayk5xHtFaRs+U787jK6n9D1O2bln
 X72ww7m4rHzIAgsrMc29THewn2Ww5ezQv7PWAFaRv8PHCkZ2CL2tj6X1IvoPhC7EFGF+aBrU24R
 TjJgmpSqo9sN+dERPUzWlMVXBOPPEfRwnpqDYPfoYPsmT46G5oxivKhTi8uzPHX3XOTILSqhEMj
 fFXVN8Vkl2XwfcPcuEruvAHtpFtiEamREkVMXz/yKPFUJiRbYlSGZCpYg==
X-Received: by 2002:a05:6000:2c04:b0:439:b486:ba5e with SMTP id
 ffacd0b85a97d-439b486c3c9mr11043902f8f.51.1772488988094; 
 Mon, 02 Mar 2026 14:03:08 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-2a02-3100-2e0b-4800-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:2e0b:4800:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c765c38sm29308102f8f.31.2026.03.02.14.03.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 14:03:07 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Helge Deller <deller@gmx.de>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Troy Lee <leetroy@gmail.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 04/12] hw/char/serial: Reuse fifo8_num_used()
Date: Mon,  2 Mar 2026 23:02:46 +0100
Message-ID: <20260302220254.1166849-5-shentey@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302220254.1166849-1-shentey@gmail.com>
References: <20260302220254.1166849-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Avoids accessing private fields of struct Fifo8. Now, TYPE_SERIAL only
accesses struct Fifo8 through its methods.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/char/serial.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index 20f68fd2f8..2c558cb9fc 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -128,7 +128,7 @@ static void serial_update_irq(SerialState *s)
         tmp_iir = UART_IIR_CTI;
     } else if ((s->ier & UART_IER_RDI) && (s->lsr & UART_LSR_DR) &&
                (!(s->fcr & UART_FCR_FE) ||
-                s->recv_fifo.num >= s->recv_fifo_itl)) {
+                fifo8_num_used(&s->recv_fifo) >= s->recv_fifo_itl)) {
         tmp_iir = UART_IIR_RDI;
     } else if ((s->ier & UART_IER_THRI) && s->thr_ipending) {
         tmp_iir = UART_IIR_THRI;
@@ -563,8 +563,8 @@ static int serial_can_receive(SerialState *s)
              * the guest has a chance to respond, effectively overriding the ITL
              * that the guest has set.
              */
-            return (s->recv_fifo.num <= s->recv_fifo_itl) ?
-                        s->recv_fifo_itl - s->recv_fifo.num : 1;
+            return (fifo8_num_used(&s->recv_fifo) <= s->recv_fifo_itl) ?
+                        s->recv_fifo_itl - fifo8_num_used(&s->recv_fifo) : 1;
         } else {
             return 0;
         }
-- 
2.53.0


