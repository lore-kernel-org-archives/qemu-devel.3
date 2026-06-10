Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0258CD98C6
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:22:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLY6-0001Hk-LE; Wed, 10 Jun 2026 12:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXa-0007mI-JH
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:33 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXY-0005W5-VG
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:30 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-45e9f4a3510so3530694f8f.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781107947; x=1781712747; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YtZV5xmB1eK7d5I6gu73vHS8Io1YEt6tDLylGTFsGcY=;
 b=KI8wRZTq3j4/HamXB3EuVOasVUKgi5rQ6u0rfwPLN/w2qzfHeHHbSenqrI8LI88Ddn
 YQlkZapBcfYWVckFOsLzbD0QWJNO73X9IPCkg88kiar7MMpRZ07yWhvIqzwqX9KlbJRG
 VUEQlO9X+8GKrM+mlUYFipWiv6pUFNZYnmjDqB+V7Tc87Q69tjUkDW34f0al6/MfilA6
 kxyOt5s7ZNJEEm4xbOWFiG4B/eN7c6/PAi0au4Y0Kh91355HtEA+/NxMLz2b2AJOv1oq
 xtTXHQ44OiHMDj/tPCKDWMnz3HLc//YjRZvAs7rJEBn/v4X77A9SKgdrZKdcFE5UqIs2
 d4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781107947; x=1781712747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YtZV5xmB1eK7d5I6gu73vHS8Io1YEt6tDLylGTFsGcY=;
 b=WmBUEgNm5Pcc8pIWH6BqyW1L1mqUeyDB54XQbFGTp2IGTTSqFtkBqzXwRE5Xiu4hHz
 5uxjIAHXdKfyhhsUMdNi6H1aoZUfTukNdzqdYlAWwkMK42WvIXlc8wOlSn3M41vBBgdw
 RAe764pXhYM50sR+0vLnJoHw9dRyzkMAu2jb/OW1yR8Ye/UTzTpI2P/0rDGirDNCHnHo
 vMR4rwvPEZenC1xi6VfGUk5bYo0Be6c+n1+IwIGYdawjQXsO6dLdOdnoxAgZioa4VnuI
 fvuzwqq2l6DaaJ3VLGlnopwqzWe7G6rDsBqigntLosa1LHMKN5GHeBnYYK9uGot3psR5
 LvSQ==
X-Gm-Message-State: AOJu0Yy3+L4EylH33SI8Wt5xQmaWAZ3Ca5WRD/LsqZU+QwC9oIFUY1IW
 bHvO1moTltWBNqkAhygCVVWL+R9OaE8ejbFoUfzeLdR9puEDLw4xS8hPQCPp55E+iAHR3ffTHPd
 YP3F1
X-Gm-Gg: Acq92OFn4pMHvrTow2kgS2+RbezZ/Dc4jUBXArgXrbuevy5drFbIjsH9ipldeRgKXyQ
 QylTCdN+yq159tevyldqrgy/8sFuCxBqg6JIzzpjDXlqnvrjUesUChyjpqwV44TULuV6wJ315k6
 OTxz1KmgPG3ZvD0+WLaEeZexxQL+Q/HcIGYQeuoeBfCPa3jSUW6DIaOGEkZ2t60EsFhteDhmN1c
 AMP/pxRpFetyDg4ZCuUUfSIw2NQc1oMblRYi5rCrs+Qcjp9MmB86iTUtWqbvFng12uWBqQYbPpT
 zzqTkC9L6UWe2dgmSbexR9u5KNOE85c+WscjygT1y4ldcMBiHZmj7Qikui+Elp/yu2KdIxGS7M9
 2AfZK8Ktffme7FabSZqLMIxnmJAz98bUnYvlyRsOQI6gxlTPtSL78tezYdFOyReO8O0gmqOMgpJ
 LFrnQGr5yvksAp4+4BjLJEtUKGBlMkFHOHbSAEK1rthV1p9LoZZ//IsDp6ppLegdlIitS+IkUbB
 fY1srk484KiNgSaIm22usOo1aQgI1tv1Ev8rH7qOybqFSj+ZX/9BA==
X-Received: by 2002:a05:600c:c16f:b0:490:b8e6:be40 with SMTP id
 5b1f17b1804b1-490c25fc0d5mr411422455e9.21.1781107947594; 
 Wed, 10 Jun 2026 09:12:27 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.12.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:12:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/71] hw/usb/hcd-ohci: Assert isochronous TDs are never
 deferred
Date: Wed, 10 Jun 2026 17:11:08 +0100
Message-ID: <20260610161202.2235298-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Munkhbaatar Enkhbaatar <munkhuu0825@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/usb/hcd-ohci.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index 6ed8046fc2..8f4de0066e 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -746,11 +746,10 @@ static int ohci_service_iso_td(OHCIState *ohci, struct ohci_ed *ed)
     usb_packet_setup(pkt, pid, ep, 0, addr, false, int_req);
     usb_packet_addbuf(pkt, buf, len);
     usb_handle_packet(dev, pkt);
-    if (pkt->status == USB_RET_ASYNC) {
-        usb_device_flush_ep_queue(dev, ep);
-        g_free(pkt);
-        return 1;
-    }
+
+    /* The USB core guarantees to never defer ISO TDs. */
+    assert(pkt->status != USB_RET_ASYNC);
+
     if (pkt->status == USB_RET_SUCCESS) {
         ret = pkt->actual_length;
     } else {
-- 
2.43.0


