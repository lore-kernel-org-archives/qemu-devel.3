Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 396BECD98C6
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:22:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLY6-0001K6-TI; Wed, 10 Jun 2026 12:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXc-0007qG-0Q
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:33 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXa-0005WQ-B2
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:31 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-45ef56d9b67so5457472f8f.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781107949; x=1781712749; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GZKxoyMSnbKsvfb5DvITG7DMsLNBYfuh4Rm0/Eix71Q=;
 b=B387Fdj/8e7jwpLEn+KBqMiybkNpJm1K4IsmvGVk/fcA9yxCWGTagNr7oQIWHYOkhG
 GfgEWl6M8bvYFU3lPfsqwTmZKtCOhVtlX6XKpGtxsktOeTVrm2PtO/kJ/Ybpxhwwt71z
 4JducUc078Os//D4GXpa3W6TcD0wCbzEop3JUEpYsCwOs9KZ41zt/LGqZlHJHzcICBSH
 f3KH5WNSY08iLViDwxQdHncdh6EcAGCja8YpkNQzTDMhm/kqa3hqL1m/xhaf/ploiTwi
 Zht7CMWH9YMlulgvqJ20EE5yjDyBBjiQ/lnQntBzhGrRYuI9J3dQLWOkAjfhi7ios5y4
 C+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781107949; x=1781712749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GZKxoyMSnbKsvfb5DvITG7DMsLNBYfuh4Rm0/Eix71Q=;
 b=NQBFNJca21tHQ8//t+qgHTBywfWrmJxU9ZhrhlBjU1tYDJ81Pi4xvjFC/mihWinkNo
 DWp8g8Jd73o7Xy0Sdi417AAjNVAqcuskbQ6toxwT765/Fr4oTs7dIBbv2AuinuY/vzrk
 RAiVayE07mjK40sH44KmDkgYApUCqekRhQggcpftTzzX+QXV+8mgTqV1qXJ3RH3QUEu1
 rykioJFJPy0tOzuM25422O2xVjfcDKPDbjZOVVnLa5fcI+eZyo6fpulGrfxqgskuP89j
 itw5HRD7UxGdWivYNwyOyc3m+T/rQ+9AXp0tSIAjtfOvWwz6JSyZfWVt+YQ0etHNDSsq
 h6GA==
X-Gm-Message-State: AOJu0Yy5BwXEOM0By9BNBBk5YIMVS1hbm5Tsrz91gz0DW8x60LP3f8cN
 +4JsmGN0qfF6Gq1vae6oDfO24AlCejFgQZEycmroRgP+Tl+7+JUM4QrVF0f1bg06QEbwGGeYZR1
 88380
X-Gm-Gg: Acq92OE7VmYnFvDHCONHcogCsLfNvZmqYk4jAKzxZdbnEvzuWk1/vVzoAcwIqjNrnno
 74bU7scWjl6ToYC1iH18Wxpcq1D4tqU/3So+iG3+Fph1L/atiVIiQvJ/GR6xQQBZ04SKGPFlbCQ
 gUdb4Q0XTJB0PStngNWJ0cxK9Oc2NmgS2qrt5ifeO4D6MNR+FLiOm5LhUWH1supYZh8DJQQp6Wa
 RMiz52a8YMS6oEhve+84y+/6VQVYWGV7fEqn3VQyIUrnNl5RzuKZk3SbdOYm/zofk3z8SJEwcAc
 jHjiZFLLoghZuQ1du8iHKTNrdxPzfw1Q1v3gMAOLqC7QcTBOxsNiLRzhxMLmSwpQRbbdJDFZKCf
 zUJrSylwiIJ7AL1j22bbpeBJlud0wXm838lNxeROWwrctOBqeczr/ChuUaA/w5afQpYLt3gag0x
 KiPjD6mjSJ+7hhXhn0YmJTPLmu+7IZZ1V/00MaSgqqgCKle4i8QplWE5KF4MPn9pQZa+4RbVNnd
 Wm/MEWIu0drfylKKN2+OWFdTP8fftj/nq/A0Ssg7ys=
X-Received: by 2002:a05:6000:15d2:b0:45e:f228:830d with SMTP id
 ffacd0b85a97d-460305061f8mr25792069f8f.23.1781107948644; 
 Wed, 10 Jun 2026 09:12:28 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.12.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:12:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/71] hw/usb/hcd-ohci: Clean up USBPacket before freeing ISO
 TD packet
Date: Wed, 10 Jun 2026 17:11:09 +0100
Message-ID: <20260610161202.2235298-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Munkhbaatar Enkhbaatar <munkhuu0825@gmail.com>

ohci_service_iso_td() allocates a USBPacket and frees it after synchronous
completion, but it does not call usb_packet_cleanup() first.

Call usb_packet_cleanup() before g_free() so resources owned by USBPacket
are released.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3463

Signed-off-by: Munkhbaatar Enkhbaatar <munkhuu0825@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/usb/hcd-ohci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index 8f4de0066e..40ebafb4dd 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -755,6 +755,7 @@ static int ohci_service_iso_td(OHCIState *ohci, struct ohci_ed *ed)
     } else {
         ret = pkt->status;
     }
+    usb_packet_cleanup(pkt);
     g_free(pkt);
 
     trace_usb_ohci_iso_td_so(start_offset, end_offset, start_addr, end_addr,
-- 
2.43.0


