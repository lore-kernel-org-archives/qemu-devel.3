Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F2C0EDEBFA
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 22:23:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxY85-0004ja-W5; Tue, 03 Mar 2026 17:22:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vxY84-0004iM-C5
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 17:22:12 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vxY83-0002RK-0e
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 17:22:12 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4806cc07ce7so69991725e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 14:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772576529; x=1773181329; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TykOcg42N3v23e/MxBmcDCzlMjizZHJY8EyEUhsuAq4=;
 b=TABUdYsTokHoi+WQVS/6yiWPOL5JjNQj+HhbY1iKJKseqMTj2jee05Yxb94XXoNWIa
 yL0HfZ5/3U9HLFZyqfTKAkN+I4aXzYqphd13+ffhTFE2+Jv1yHUct71T9Uci2MrEbXhH
 bdW1IkO8/te4vmF1MKSHV1P7TDnp76rMjxIOserT8FuxHznpe6aqdFaRZgBIj/1fLW09
 jMqWqwu5bppdwHXgGsIXdUXtkFhHaHR56iyx2DqV0gwcaxfgDMPj9AgarGIjyz4J1F1f
 esp9qmrM9kB0zPODRlJBN84A5IpKvBEuJ+YWc20Y+Eo4ntPRVWRPfAnVE+q7DT8P66MC
 D4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772576529; x=1773181329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TykOcg42N3v23e/MxBmcDCzlMjizZHJY8EyEUhsuAq4=;
 b=C5K+BtIlC/aB6fgC69hupzN5p6Fg294zea8+xIUsXci1XvYCymMGhpKpm1Tcgd37da
 RzBEw4gH5Rbt/llzGDvfZhIPKukYU6mAV80+ppT1FBzoH2zkBjqIpYfFP/FTAkUTKKCC
 Z+d+6Hwrau8NrTNxB7hlFBuu1ZvcKLmbBSo0/9qb/wlCk3MH3sdtIiB16+/dcNmjdDlB
 egzMFvtyPZR1WySHtEyC03Ps331SCRa77aQnbPOm1E5wsu0Dm3+yi7qiPnSrdMGRiYAf
 FEn7ADMnFVTuUiKj71OdTnYhssXt8pxSDWX6oHP7FCS4eG37Jd89F6jFDhCVaP6hw11v
 +ozQ==
X-Gm-Message-State: AOJu0YyO2h1tYiqfq91ZdDIJ45hoOw3BLzHBw+hI8sqgRDbPIBdtTbY/
 /Q6doszoi49kCYqFHvFb7D66YiqeLDpYLOIfrfeQPungvrdAyjWGhKeb26KvTQ==
X-Gm-Gg: ATEYQzx445pWwfNPf07LtFMesEGmxa4y8c552lxJEshGJXZAjAGPiQghhZtq1VsQmWu
 fjQFMp2UsOPBvy5z5RZLO5Vch1pQXvoY8qL/iS7FSFoAH75BeHgOgmzN+XirrVwDzFwB2wYrfrp
 i2HFA1rXSVq3m1UXpVwwU/dd2MTASVmOkdkO78RWVY4KnvtrPDkhGVzwzFRCbLGPqiJ1y0BsXWf
 UMGms0qQ9Jj4e8C3hdEK7cGg1RG/Z8U/mSNSMzx7a3eqMj33fqOfdo2WyLBazmgQajhHDhBjlTA
 yrAoUwUL4vs21i+lUa0TgXbrzJWaLnk3KnmS8gisUmrUe5LY76GH2aSeg//YZ9OWA3C84dVaV2X
 UN4PcnW6SRlqtAkovGdHpGZKXvpFFGQ4zCEfYqZ+vjuU7RinsQQJxJ9SsGNHfd0llZNwPW7Ot6H
 G1evpdUDKd0bCUr+ahTES4nUC6jNyX6G2gndGRVyvm0JTLzf58v5F4/nqWQfRclG+25Fj0YHvV4
 zbdIIte6HDlrmLCYuMYFpIDaQMU/W4=
X-Received: by 2002:a05:600c:1f91:b0:477:8985:4036 with SMTP id
 5b1f17b1804b1-483c9ba7dffmr299940525e9.1.1772576529052; 
 Tue, 03 Mar 2026 14:22:09 -0800 (PST)
Received: from Provence
 (dynamic-2a02-3100-1c79-b600-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:1c79:b600:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485187c81adsm7577715e9.6.2026.03.03.14.22.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 14:22:08 -0800 (PST)
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
Subject: [PATCH v2 06/13] hw/char/serial: Reuse fifo8_num_used()
Date: Tue,  3 Mar 2026 23:21:36 +0100
Message-ID: <20260303222143.142741-7-shentey@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303222143.142741-1-shentey@gmail.com>
References: <20260303222143.142741-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32f.google.com
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

Avoids accessing private fields of struct Fifo8. Now, TYPE_SERIAL only
accesses struct Fifo8 through its methods.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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


