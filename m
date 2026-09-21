Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F2C9C982E6
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 21:52:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8lsL-0006xt-B5; Mon, 21 Sep 2026 17:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8lsD-0006kF-2S
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:48:29 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8lsB-0000QI-GE
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:48:28 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49b965f447cso29549205e9.3
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 14:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790027296; x=1790632096; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CUS9A8hWbDyBG/5uxhxg2kV3QDj5nSuCczg8XGeFQDM=;
 b=Za5SgfYVOwXW04FJED9hpEgQChGIxEF0C0fzgzrmh5XDFB6NNJHHjdXKgYlJVEDPTl
 oOYbyRdU8Wnbxx8wiQ9wDghy4M92fa9QblRvIvlaFHNVl5sesdb63R2HjwzTnE6VYpnb
 nlu3R3TVTtbRS+JdmPhHFj9xsjf4uEaXPJ8W12QNAFmeXEyecuPCTpvnd6jwzvJoY6LE
 tNlV0S5HrnCzzOZbAZIBfGfGtHjmiYIT+AKQAQ2Ft6UrGi9VIhqHTdGcicYi4nQhxb/y
 xhwd0wmWmYW0kRASKsfxfIme/+rGR4PN1uFCTmjw5+Z9nbQMtDMkEU2MZQOuc3h08qlR
 OeCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790027296; x=1790632096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CUS9A8hWbDyBG/5uxhxg2kV3QDj5nSuCczg8XGeFQDM=;
 b=iHPgWhUVkO/egQXng5HN2U2K3pY1aEzuVHEdUKaPP+5Bkf5Y0t4B+uoDnChM0IK0Kv
 KOm8T9O07021oh7ytJ0GW8NrMIInc/kWpkXGH/KJw8SjwRGnrJr+edJIjTGNWkJZ7ov8
 wuAgNNm42U0uDSDZtp1cFGTrDnoSrXjZ0YunQwztaPliCbUkDwDAP0RFb3/9fyDk+ND0
 02XPiFANCehlko+pu0ifuxWYaqJcJQ+zJqI15CLFyISoJmuvg7eM9CC+VgZoKt3fa/hB
 rKUtLTalXfkkbW8LVErRkUbp8PJdwuXs7Aq8vHR/zMLiJnMleEhpyY3S5FYOj8h/SVhT
 mDzg==
X-Gm-Message-State: AFuF++mcNzo9Ryv2Ko4/5VCDj9gu833fiVFxADmng/sa0USiHzPUq8t4
 nQ+6eABcEGCB/fqsZU4CHwQ8eRNP9wbMvjl7PLgefco7nZxPeJBi5Mb0aZtreg==
X-Gm-Gg: AYBFou12l9a5VYGKr/wDXvMaY6omSV4ltaEz49jgxU7XGLS1ReYenLz8F1kJPkvEHbw
 NPeTioOnxGkLmzCB70yZYA1SmukH8WGhn/dNVcL9ICNNmqn1avxi4fi9xMZt3DqqDgeVEH9fh56
 N6mpAzVBEfTaMkjB3VBSnQ49jHqWMwESJjGLTW/9mNTco4LZqCUcyf1Q+X4ML2Ytl3NOfOTGxlm
 lxnDzxG/9q6Y0kdb00xEHfNQRdkJYXUkegjqa4mehFV/AKlzhofcaKtNOUFINhGoTkfT+v4zI9L
 Jm4y61gzFBZ+D1txHSo9ap/vjAV6iRcYi+4E0hypkFmg2CdIMhZ7/R3V0FbJ2EuOyL1cKpOyUgW
 kAP6t9HrCJOFCJsXNB7s6k+G7/QorAxCA5xAw2stPuHASPs9uz/OLSl2gA3z/Z3HmdXR8jHrpYc
 ugwqNwwWubVcVQ+wscWKtwqZhXlAteSZqpjJ32ST0VXn8k106hSEJwnSFs2+tlbOc8Oxbm3nBY8
 ZYjQudR+1hI3It4H+jPKkYzx1wblrHLOBLxbSym4knBtjWICzijOouxcW1H2FSMRqeHrVz92Gp6
 xiU=
X-Received: by 2002:a05:600c:4f8c:b0:49f:c18a:61c8 with SMTP id
 5b1f17b1804b1-49fc573f858mr171411175e9.29.1790027296094; 
 Mon, 21 Sep 2026 14:48:16 -0700 (PDT)
Received: from Provence
 (dynamic-2a02-3100-1c91-bf00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:1c91:bf00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fda0ce29fsm4986905e9.6.2026.09.21.14.48.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 14:48:15 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Jason Wang <jasowangio@gmail.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Subject: [PATCH 37/42] hw/intc/imx_avic: Avoid casting from void *
Date: Mon, 21 Sep 2026 23:47:05 +0200
Message-ID: <20260921214710.29422-38-shentey@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921214710.29422-1-shentey@gmail.com>
References: <20260921214710.29422-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=shentey@gmail.com; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/intc/imx_avic.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/intc/imx_avic.c b/hw/intc/imx_avic.c
index a3d71aba8e..d05c71fb39 100644
--- a/hw/intc/imx_avic.c
+++ b/hw/intc/imx_avic.c
@@ -89,7 +89,7 @@ static void imx_avic_update(IMXAVICState *s)
 
 static void imx_avic_set_irq(void *opaque, int irq, int level)
 {
-    IMXAVICState *s = (IMXAVICState *)opaque;
+    IMXAVICState *s = opaque;
 
     if (level) {
         DPRINTF("Raising IRQ %d, prio %d\n",
@@ -108,7 +108,7 @@ static void imx_avic_set_irq(void *opaque, int irq, int level)
 static uint64_t imx_avic_read(void *opaque,
                              hwaddr offset, unsigned size)
 {
-    IMXAVICState *s = (IMXAVICState *)opaque;
+    IMXAVICState *s = opaque;
 
     DPRINTF("read(offset = 0x%" HWADDR_PRIx ")\n", offset);
 
@@ -217,7 +217,7 @@ static uint64_t imx_avic_read(void *opaque,
 static void imx_avic_write(void *opaque, hwaddr offset,
                           uint64_t val, unsigned size)
 {
-    IMXAVICState *s = (IMXAVICState *)opaque;
+    IMXAVICState *s = opaque;
 
     /* Vector Registers not yet supported */
     if (offset >= 0x100 && offset <= 0x2fc) {
-- 
2.55.0


