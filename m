Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6EF1C531CB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 07:02:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmnRS-00022c-VM; Thu, 23 Jul 2026 03:02:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wmnRK-0001xh-V1
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 03:01:57 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wmnRJ-00043q-Fv
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 03:01:54 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4954d29264cso1191235e9.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 00:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784790111; x=1785394911; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rp3IQqFJt5p9nlS3zJ1MItzaTmiVTLGkLsSBcTTrc1g=;
 b=JBFbGj82ab9D4mzC2M5kYZQX/bM7OeojnUNbIezVxoQ4qfDq2QXyKyo08+Q4qruJ0I
 Muad1ZskwVXUZz0wSNO/WLqk/2QWskfDqR2G9BhR3uCC4yfqaE6yDUuuLHt4HKZJu0CB
 ItleYrJY0rvbXBWU5fTmQijeE+/FwY3DB62iYBDw8TvWsD1lGgTPcnSkUh2aiJJCiPaZ
 zm8HUgyiqZIIUW9Jb3SAFM7NZe508gYCdINY74v3K62jaH//Wr6XQXuwnUn7xHNPxDo9
 y3dldhtH/OB/Z3njTnWpbBBVq4CmfxwBmYC2sfGGQkl9gQmVqU5lnY4yfJeadCsPGq11
 jYJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784790111; x=1785394911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rp3IQqFJt5p9nlS3zJ1MItzaTmiVTLGkLsSBcTTrc1g=;
 b=i9P+DLCFOgqkoq8xPPmmwcV1XXFS4QA+kuRL0bAgyxuPBpW2gEzzX4k182ryUzHVvF
 yuJxEwgpTFpILlH+iNE4/XJiWfgZAFSIQjEzVFwMl+KlT9dskzG/z1AyCOqgVBIV9LWO
 Lb4bHHijSGSf3s7IK3xIlsgu/BZdP6nlYHm0CbJ0eOAFZ2hCvtnXH7vAdcZZHkPRjvIs
 mTL8efLMR/pHL+fgFuWJgaDZeWg+M283H71bmXyg3fDZSlrZykIEFO2Rh1eUGIZuiJln
 i1kfuG9Km/8hdCquiZ0SSboLy+jk6swCWFS2L15yb6w0pYDOWwv7gS8Pn1Jo/9dsJCfa
 B5CA==
X-Gm-Message-State: AOJu0Yxi/LZQO+YGCvK+762zUuyLCN78fHcCPHuoCmBRwj6I8vP8hG9o
 VArvZ/RxkSQbwOjIu5NbYKv0XMCtYOZ2Y+pedy78fta3Yc8nq2EN2QCk4r9Cpj32
X-Gm-Gg: AR+sD12RJu+f1Nmepa1hpEjy1mzjspG2VuZ7deXqGGNVxW59yzVhEE4kkcXvrxwae9z
 +OzJZJwQqn201PAnYeAzFZegevrzqz1qkxNC6SmXPXCOfJOm9vyl4GrcLdxT0A3tdKDTIoqgL9Q
 Fko6fD0pltdLAkMEtXV1JYVJlVIPv8ucqM2yk2UZaWA6J0dZHNLnDClT0V+2l/7r7L+efHVFEUN
 BAR9qmlGgKYTe1Tq9IXBbxoO7hXFSWAoGzjOj0dvq6DI1ugqpj+lo7nA7EfW5RIwi+i9icC01ZS
 X8aKqR9wgJvF3EsAxxv3JnsXcOgBoXIhQQgSHwSTwOhs4ZhtON28alzIr1zKk5Cp5DhXOYOlOmc
 u+PA/b6aqwl6HoBxC/eMBcbR2Iz5GLnAATB2InScqE3hBTHNdF+YAxct/jpd8KEibNzbkyGVYeV
 Xj1VbW+dFcstSdalAWp+6F2H3oOtbdfyBZ2ju6a98FtqyiDO/hR+5stdMkYm9pL+BjYZK9d/+/K
 GgROysjkL77mE2NUjeGd4GhOw==
X-Received: by 2002:a05:6000:1846:b0:47f:8cfd:d383 with SMTP id
 ffacd0b85a97d-47f8d76e513mr2241303f8f.52.1784790110729; 
 Thu, 23 Jul 2026 00:01:50 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-29ed-6000-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:29ed:6000:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6dc25sm13293923f8f.33.2026.07.23.00.01.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 00:01:50 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Matyas Bobek <matyas.bobek@gmail.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Jason Wang <jasowangio@gmail.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 8/9] hw/net/can/flexcan: Fix RXIMR reset mask
Date: Thu, 23 Jul 2026 09:00:58 +0200
Message-ID: <20260723070059.6332-9-shentey@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260723070059.6332-1-shentey@gmail.com>
References: <20260723070059.6332-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32e.google.com
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

The RXIMR registers are not affected by soft reset, so their reset mask
must preserve all entries. Set the mask for the entire array instead of
only the first register.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/net/can/flexcan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/can/flexcan.c b/hw/net/can/flexcan.c
index f84f090a7f..205d0d6413 100644
--- a/hw/net/can/flexcan.c
+++ b/hw/net/can/flexcan.c
@@ -140,7 +140,7 @@ static const FlexcanRegs flexcan_regs_reset_mask = {
         .data = { 0xFFFFFFFF, 0xFFFFFFFF },
     } },
     ._reserved4 = {0},
-    .rximr = {0xFFFFFFFF},
+    .rximr = { [0 ... 63] = 0xFFFFFFFF },
     ._reserved5 = {0},
     .gfwr_mx6 = 0,
     ._reserved6 = {0},
-- 
2.55.0


