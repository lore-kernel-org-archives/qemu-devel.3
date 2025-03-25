Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7903C36005
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 22:44:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txD0E-0001Jx-NQ; Tue, 25 Mar 2025 18:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1txCzr-0000tn-K3
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 18:43:49 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1txCzn-0006xg-Gk
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 18:43:46 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso43756725e9.0
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 15:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742942620; x=1743547420; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yIX4KSGXtWAoTbQjaPooH4t4GimyycM1pa7qZNzCrRo=;
 b=vKqZ9GTAkJyecLZDVzo2FTK+nnSdAY6lWTjkZ3dNMNaO8jVx4nu32eF3qTILgJoKot
 lw5GeRZVy/MoPMRGCad8bj47gK15HQv/HB09SfbH7xpGMk5zvfOJK1o/uED6FwNZXuPB
 hRWjqS+4gpyZ4FsH9L2EPC4FmytkagjAzBSwgdsC64y8X+5XZ8BDVoLaxtvyELKjc+14
 hYfYIHkfYqWlagqASs3RLdO6dhMlBQHTQsdw9s4sWZJQIot6XEHozuImc2YRZ1JrFKr+
 NZVTb2gVjcXB48LYc5rxeVAXvTkeavPieYErtVJ3Poi7yntfJm+8I0TP2pTvhddQCVDN
 EQzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742942620; x=1743547420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yIX4KSGXtWAoTbQjaPooH4t4GimyycM1pa7qZNzCrRo=;
 b=Ti5H96AWjjWRk7gQmGI4MkRz2VhfCmmjHCwZRzLusuT0LNelnIn5ZBx/wYg2QzPS21
 BlgSuyYfjNeNRm5/ODNoydsQUskirpTdOxjB3je5VmpyjnC0LbM5+Kgka9ymdzXGNmtj
 KImO1jIvyQCozbSHMLnMvLSRAmrYHVdTwKHPlnsZZ8RKiKq3ebK874NiBIuJ8WzoJxFS
 97Hni6xWe8gqnyZGcjHxJgLXmY9nViicVfzPJJVTqquE6Rw8dNta8aYx8KdhcTyZiyKj
 26nY9eR/3I18T3MBTWlajwT4V9L8D0+LtY1TscYyT2TVFZqWLx1dPxdCzcehn8O2fk2y
 N1gQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUTdMd9bOm6LLbndn1dcoWTglYYeGfAgbklzvaFUn1SmoLSFngNEFnPbAMSir7rSM0smrOj4ntPyEo@nongnu.org
X-Gm-Message-State: AOJu0Yw7+unUM2eK+Yr42pnZxQWVt8knrU05+V9gEvNadLMOHX06xZxd
 wKG/OtMdXtJ20zAbBp5uiDtJanEWu6aI/enyMtp/JGFckcOiAxQPIQAIP0iS6vU=
X-Gm-Gg: ASbGncup2A3GdWFd4cNhDK+JcYZCD5UqirYj5GLjkPU/aZ3hEvcO14Pmx/P+iWBL7dw
 mczEuyzJt0hRv9xNf7tmwxUxo/so+KwgW8yYstZg7mOYOXQHNJi6Zb3niSvfjh1X/05mHUpPiEl
 Ewkal1h2uRWGCZ6m/FXpxUy+eBHWkThFf+FWPtaO7BRc3szgfpFpxaZqQfZyZoYKERWpL3b+zyk
 A1OPdSxpIYS4O/IWBEG1Zdberk6HLJOr9d8iqCEpgzxFg/wilpMljROFfrFems7R3bihTKSl0Aq
 gVu19Cjz8ulDpdTaiK/oSh38KNXMhmBYlKqnikQLAN49s8MvAwuv3d0yTcyB5QcepCvzxotXsXY
 fP/aN6vSE2Ikma51ZlF5X1i5pqHO+PA==
X-Google-Smtp-Source: AGHT+IFRqh/Vd1SuHAABJReB+gbfJmTAkiSk3He+i35fHdQnaMoXvEG8rqhh197oEjZJPnwiu3FGtw==
X-Received: by 2002:a05:600c:1989:b0:43d:9d5:474d with SMTP id
 5b1f17b1804b1-43d50873c28mr165157725e9.0.1742942620465; 
 Tue, 25 Mar 2025 15:43:40 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43fdeb79sm214467435e9.25.2025.03.25.15.43.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Mar 2025 15:43:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Thomas Huth <thuth@redhat.com>,
	qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Glenn Miles <milesg@linux.ibm.com>, Samuel Tardieu <sam@rfc1149.net>,
 qemu-block@nongnu.org, Patrick Leis <venture@google.com>,
 David Hildenbrand <david@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Tyrone Ting <kfting@nuvoton.com>, Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Bernhard Beschow <shentey@gmail.com>, Hanna Reitz <hreitz@redhat.com>,
 Hao Wu <wuhaotsh@google.com>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org
Subject: [PATCH-for-10.0 05/12] hw/gpio/pca9552: Categorize and add description
Date: Tue, 25 Mar 2025 23:43:03 +0100
Message-ID: <20250325224310.8785-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250325224310.8785-1-philmd@linaro.org>
References: <20250325224310.8785-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/gpio/pca9552.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
index 1ac0cf6c464..b152872f6c6 100644
--- a/hw/gpio/pca9552.c
+++ b/hw/gpio/pca9552.c
@@ -459,6 +459,8 @@ static void pca9552_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
     PCA955xClass *pc = PCA955X_CLASS(oc);
 
+    dc->desc = "PCA9552 LED blinker";
+    set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
     device_class_set_legacy_reset(dc, pca9552_reset);
     dc->vmsd = &pca9552_vmstate;
     pc->max_reg = PCA9552_LS3;
-- 
2.47.1


