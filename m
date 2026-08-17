Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F662C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 19:01:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww2aW-0007Gt-2n; Mon, 17 Aug 2026 15:01:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww2Yw-00062N-Tk
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 15:00:00 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww2Yv-0006OF-23
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 14:59:58 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-496bb7cdf51so46949415e9.2
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 11:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786993194; x=1787597994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c9H56BOI6x1HNNI7/8WusEwmBUtaW++scE8GWB5zaTo=;
 b=Xof7EbmV9ixjs9LMcI0MuDht/XRdICSHjpX0tMSqmzGTtuzUdcSCHFXg+TMiYkY3GM
 rq3ur1XEDOw16ArxTpPPmrTCZwRKjS6A0TT3RV130CWrQtTqfigQA6VLI/PlqTEKas/X
 SwZOrmAZa5D7EDYLOcxf6fbPv8bZ2WpxtVuLtiXP2Q8qYF5rChBLCQYziNl5F/7ujg27
 DPQzb6apr+CzxvI2+OLSuCTf9Bim5IAAEanmdkIZA1pd5dXQTgQJjBhLmXSj1ml1/8Ji
 6WyktIe4wGhJN/HSdTDjG3cG0WagP5MGGU69x7vzq73cOk4Uynuffa0aSFXxwL3zoHus
 8YjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786993194; x=1787597994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=c9H56BOI6x1HNNI7/8WusEwmBUtaW++scE8GWB5zaTo=;
 b=qAhw/ed+iOgZpHd/23yM7ebJQLwv390kAZlZi5QKeMFGJ/1LQslc4Ezn37RW+Ajmnw
 BUvluPIRsuZp56z90UDn1mpSIAGZkycBYL2I+9XD/1D2eSizmAZy+ObWjK/WEYNmPmom
 FaEHJvLX3KHamIFGg1r+MJlaM6y2QaqQwGc/jCTFqDvMDVF1D2cheb0up5qg1mtCqinE
 5tcYDiz6tTa+2U3qD1rhMCshztrqZ1mRjLBAHRnVXyolBY79oFulGGUZT56bYV5BS2Ba
 1fq+RlQM+zXlpC6gYmhLwht1ZJvi1uroN7VxYUaatb9XCvtBv6swVutc14TbW9eht7WQ
 pIWA==
X-Gm-Message-State: AOJu0YynLLNx6Te9i+T7Xh9tkupe0Ni77k0CDv3/tW4Yn8RV1nksFBpZ
 83Bu0I/5k4QpFJH9n8Kih5Z2EJGfU5Ltg2OEAm2J5FG7d31niITXy2dp58nikzQdAoh8J3RspwQ
 qSM9C
X-Gm-Gg: AR+sD12QMWyEYQHx09UWSEprgtE9Jdr+8ZNCGo0rrO0gGDGEVXGFDcrcuNenyEceAU0
 YN/82EVRoslOdg4+1evs1MzaeBf6SvQ+TT1/SL3PYyFUZnHo9ajuGfGYp2ARXZ2cF2h09pCiWGD
 oF1htALgU/qat6sBUQIKySSRp6o/GfLeEpG9fKzfv6ko7rye4DRz6M+n5cqH76qoXoINNa3tvJV
 eNM/q3riofKYYrNSJaNLDYc3jFN5WnDKvFqQkDB7JNkoHWK6WNMYH8MGLeRkfaDeUGvp88fjyxe
 utTVgoQ6yFKI3gmLYJ9bQddc64V1H31o8poE3fi3L3A6HCl5AdBy53qiggqLNfYrRO/PlkgxieQ
 VleTJpNaUCoo4NX83b1DLOyGyYTbpaoHv2xXREusOWpB8x1zOd04nOA9WtzjGH62x5APkPkY/7E
 gIopUSmuMWCJQvq3KNgdFYKIzKVx+6OaDVPHP/ZqXOA71ZInZKCA==
X-Received: by 2002:a05:600c:3b8b:b0:495:4fd4:619b with SMTP id
 5b1f17b1804b1-4999fb04106mr46471195e9.1.1786993194201; 
 Mon, 17 Aug 2026 11:59:54 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:f6f8:884c:b162:eaeb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996188217sm381011085e9.13.2026.08.17.11.59.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 11:59:53 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Subject: [PATCH v6 08/25] parallels: Create used bitmap even if checks needed
Date: Mon, 17 Aug 2026 20:59:25 +0200
Message-ID: <20260817185942.1065143-9-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817185942.1065143-1-den@openvz.org>
References: <20260817185942.1065143-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=den@openvz.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>

All the checks were fixed to work with used bitmap. Create used bitmap in
parallels_open() even if need_check is true.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index cacf23143b..307e90ec71 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -1476,13 +1476,11 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
         }
     }
 
-    if (!need_check) {
-        ret = parallels_fill_used_bitmap(bs);
-        if (ret == -ENOMEM) {
-            goto fail;
-        }
-        need_check = need_check || ret < 0; /* These are correctable errors */
+    ret = parallels_fill_used_bitmap(bs);
+    if (ret == -ENOMEM) {
+        goto fail;
     }
+    need_check = need_check || ret < 0; /* These are correctable errors */
 
     /*
      * We don't repair the image here if it's opened for checks. Also we don't
-- 
2.53.0


