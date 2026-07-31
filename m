Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D49EC55167
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 09:37:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpjfL-0007Rl-MZ; Fri, 31 Jul 2026 05:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wpjfF-0007Qw-TN
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 05:36:27 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wpjfD-0002dB-NK
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 05:36:25 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-476a130c138so920696f8f.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 02:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785490582; x=1786095382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0+HekxhPTXUqW3FXCX3ePVvrMLmZ/u7/wQufHqeCYMI=;
 b=KgeQ/EsOXf/as/W0EwTS69IOI32zrzxePbAO720Vx2ckDQnjKE9S5pv/TVPQwHt55h
 QChJSPXlyfSk2uX+64pgcY59woTYTqG9+yN5UWT48Y7IbqlOwCi4rJ1QrlG6p57doEI2
 AQpVQlzCdaLUYr6ei+Ra4kKlmus/uafzdqEzo5PtDZ/g4UxCjvSIpg2jpbdPebQNiW6a
 Q1oCFZ+rEZxWIkfroSAE+SKvNVqA0KjVF1xx4p0F7xfrupAVeJ9aetyY+o2SJUuiRgqp
 ortWNmYgU1/PLx2X3iHdT2dsATqWXFT37e/g2qItJuecmHgh7XRxmTRsNwmGGrrnodlS
 /I4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785490582; x=1786095382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0+HekxhPTXUqW3FXCX3ePVvrMLmZ/u7/wQufHqeCYMI=;
 b=QYc0KUw+IG6keDrf9raBmJPnw5L2A0x2rivRrcvUal6cQrlbd14t74ZA6dE7pV5tKK
 qK1QOQQ0M5cqi94z6mIeVKtTA/ag1UE6/0R3vywRIpYuA+nyHEPlcoDS9g+0UudzSVow
 kS8kJTwT5XDW49T/2S1FBONRxv61yDicNRzRCdMrMCkTFjxorjihKEOv4N81a4XReKwz
 zhTqIinFla5gSMnjdvyS6F1ogXFqzGWi29GRLOK6ceETcllzLuFCSbAZIjmNVtyfNNAK
 ERytz0IxBweRMrV/o+aj3jcgnD4fjRe6T4cX2eFx4O2p3zaYGMSXyx4QSXew0JF8/UFB
 c2Mg==
X-Gm-Message-State: AOJu0YyiuSQbcqQShIHADTJjk1E59sCX5F1O1GW9+FExodGj0bki0CQ6
 klgv4ybz/GjDTlgQ7hQlzVgQhWzodWYs0PC3uzlnp+6ZFkbLMwdM47kgAhwMzMhv1oqA6+7Dhly
 tXwKu
X-Gm-Gg: AR+sD11HVHL/ncYmCO5uJh90WWIlYUuJItLk6dz/dKXfkav7KleKRJIpW/Qm+xO4lX0
 mqin9P29/KhklkUGDyMqzrkA2iCVcUUTtGJrbjYujES5RQ8BMcq9mhHhh7OUGlCQ0tYaQoNrHHT
 kQxnsnSRXLwK0a02DeU99j7FQBg0/foFr1uyaWYzm94Woaii7iRLBQaNJyYDecGo2XWOyfeS0Go
 SQEcA1YnBAuAx00lYbVyG6LTS1aRbVUWVU5N8lj47J6MmQ0vuHyPt6DVyIo60+QAXayv+m+0i0C
 QgG1XcqvfKfw3eu6msN0p/ncIwKRFdxAuMseGPV4/VuEaonXbAumy5HEWqLP1LhR4w7zSTuweH8
 Whw4oIAJwoC3ao1gPexKwQWX/Gllfvy2ra5M/9kO6d0TT6IohnjsyK1UVyp2qLk/f3cKgOptcJF
 gXO8qrJfRGDD+7urlT9+rshnYs4Dbb9BlRXMmqaMliMjyOr/cN8oHL4DStrzLNhC8Y67F2DlsX6
 jrbbkY/UyI9ylBPN1oZbf4bM4Acz4CTkPgMHGt3c+Sk3qAxS4Ot52drRHejVUr3DURYiA==
X-Received: by 2002:a05:6000:2dc2:b0:47f:9220:3d with SMTP id
 ffacd0b85a97d-47fd2b61f70mr3096977f8f.58.1785490581680; 
 Fri, 31 Jul 2026 02:36:21 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41e296csm2861208f8f.12.2026.07.31.02.36.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 02:36:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>,
	Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 1/2] hw/net/rtl8139: Fix handling of VLAN tags on incoming
 short packets
Date: Fri, 31 Jul 2026 10:36:17 +0100
Message-ID: <20260731093618.2961031-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731093618.2961031-1-peter.maydell@linaro.org>
References: <20260731093618.2961031-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

The rtl8139 receive code handles VLAN tags in incoming packets by
copying the VLAN tag to a special field in the receive descriptor,
and copying only the actual payload data to the receive buffer.  This
code tries to ensure that it pads out the payload to at least
MIN_BUF_SIZE bytes.

In commit 63b901bfd30 we removed the main "pad short frames" code
from this device because we switched to requiring net backends to do
the padding.  However we didn't notice that this broke the VLAN tag
handling, which relied on the old code making the buffer at least
MIN_BUF_SIZE + VLAN_HLEN bytes so that it could copy MIN_BUF_SIZE
bytes into the receive buffer even after removing the VLAN tag.  The
result is that the guest can make us read 4 bytes off the end of a
buffer by feeding itself a suitable short packet in loopback mode.

The old behaviour is actually not correct, because the IEEE802.1Q
standard says that the minimum ethernet frame size remains 64 bytes
including the 4 checksum bytes, and so when a tag is present the
payload data only needs to be 56 bytes.  (A bridge implementation can
choose to pad tagged frames out to 68 bytes, but it doesn't have to,
and so all devices have to correctly handle incoming tagged frames
that are 64 bytes long.)

The RTL8139 datasheet isn't very communicative on this topic, but
there's nothing that suggests it adds extra padding on receive that
didn't exist in the incoming packet.

Drop the last remnants of the padding handling from this device;
this avoids overcopying into the guest when we receive a short
VLAN tagged packet.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3518
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I had been looking at this from the POV of making the generic
net code add extra padding when a VLAN tag is present, but I
went and read the 802.1Q spec and I now think this is just a
place where the rtl8139 code got it wrong.
---
 hw/net/rtl8139.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index 424af73a18..2b61c171f2 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -778,7 +778,6 @@ static void rtl8139_write_buffer(RTL8139State *s, const void *buf, int size)
     s->RxBufAddr += size;
 }
 
-#define MIN_BUF_SIZE 60
 static inline dma_addr_t rtl8139_addr64(uint32_t low, uint32_t high)
 {
     return low | ((uint64_t)high << 32);
@@ -1007,10 +1006,6 @@ static ssize_t rtl8139_receive(NetClientState *nc,
             lduw_be_p(&buf[ETH_ALEN * 2]) == ETH_P_VLAN) {
             dot1q_buf = &buf[ETH_ALEN * 2];
             size -= VLAN_HLEN;
-            /* if too small buffer, use the tailroom added duing expansion */
-            if (size < MIN_BUF_SIZE) {
-                size = MIN_BUF_SIZE;
-            }
 
             rxdw1 &= ~CP_RX_VLAN_TAG_MASK;
             /* BE + ~le_to_cpu()~ + cpu_to_le() = BE */
-- 
2.43.0


