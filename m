Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F3AC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 10:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXdTR-0001bR-Ui; Fri, 04 Jul 2025 06:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdTO-0001Pz-3p
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:16:50 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdTM-00071J-70
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:16:49 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4537fdec33bso4595575e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 03:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751624205; x=1752229005; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UTBNOqbP3E+GBsl184QB6sPguCL61jIY7KiQPlXXwQU=;
 b=ldoYscVgpXSauEdjU5oFFFjInVsCQmmDC39LaF9qFoBd0OOJ1vty07R8sdqC0t+lRW
 uEO85O0dcySBYtHaSaeUV1cxlIutNOnVXimlZRmltzR6oC6oU9zXJg3IT9gBuo/m1BvS
 8tGjkYNWaJqwDLvVOuu3qaarl6E5RIOPsDQPMH3X6GVQhdbH0i464UbffBHz5xJuddag
 +FjxyDPzSZUmRLCi5/rYjsc59px2QkLzmbOJZcQPIqFg1pc3+SkvSAguJFFzRnYm8GsL
 aFkRH/IT4EG/YpLqb3nx6Rfw55443VyukCzE3HDT9l3lcd90jpwkYj5G1ZYXnTwNxJqb
 jcCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751624205; x=1752229005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UTBNOqbP3E+GBsl184QB6sPguCL61jIY7KiQPlXXwQU=;
 b=uSx1aCmzUBd02CECUzFXdXk2tuYF/KMq3X3Dj4O41X9h9pZBZymiCSZBv4v66x1Xn7
 ntVPyhV3xcrFY6NM6ZyrEeb/iledT3xYEmxQaXIR3uNe3mct704aKhWirIhvdSHUHiNa
 Pud58BUBmP/hB8v642ETqouadxX7PTU8UV2kupwlrioa1VyfirWQ19HfZnqavqYDr33Y
 LpMyUpbM3Diq5GOPYrtZ14aZHExV6/t7FJzXM4l3YWI3InPxSoklnufwgKNrS4qEIQjf
 MjuvkDkXTAFXR0wXafLPkoUSbG8IWzZTOn21h47oHuEsHU3kVxW1EDzTOSQeIQi/GIzm
 +u1Q==
X-Gm-Message-State: AOJu0YzwkXBANUl954eCsO643rO+OyTsycke+IdHBzg4zYHWUH4MtsCX
 BRbVj7cWP6EIrU4x91al1HWaS2ro7V6flGwmrULtmvigNn5Qv9U4fGn7N6UiSyWP8I7Xp+P1ME9
 MfNldub4=
X-Gm-Gg: ASbGncsxiSUQcmsceFlv8W0BMrRPOymB0sfMb8RM1BvZ0BcHMwYwSsX6ltHunPfUGIN
 mfZxcPK4pI3Ww+z/mhZ3vFQdjf9jG+DmkOQrPD+Fm13+oUT1ONReTR6TUB20wq5JKZ4cdQufQ13
 dVKe1HDoXDWXmS9rC5a6sRSwH9nzRVYrWNgYEYC83YaSwA/Zikcu05BOi7efJHOpYNB7RHine2j
 PqOcLlJUXBQBwYnAv7LeWZgMykHqugwGLPjcpeqZz3TvhXWA777cy+eKjORbBRkkMUxCRrq2f96
 FJGFqz9WImF1nyQlO2t4YDKjv/vd0mtkiw8FbjmcUVOkqUBKk1hg6+jWTGyfK3HEyyoRK4Sg1L1
 vXsj98mvE4gSG7TPpsi0EbiulStsYICyaWI5U
X-Google-Smtp-Source: AGHT+IEQ65Sixc21MzYmjV+Odyy/AXfdMZr1Acj3Yjp7ap5NE7L44HXopBvTc5d2AgVVUkfcAmT27Q==
X-Received: by 2002:a05:600c:8582:b0:453:745:8534 with SMTP id
 5b1f17b1804b1-454b5110ec7mr10872305e9.12.1751624204930; 
 Fri, 04 Jul 2025 03:16:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9bcececsm51406325e9.23.2025.07.04.03.16.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Jul 2025 03:16:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/31] accel: Remove unused MachineState argument of
 AccelClass::setup_post()
Date: Fri,  4 Jul 2025 12:14:29 +0200
Message-ID: <20250704101433.8813-29-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704101433.8813-1-philmd@linaro.org>
References: <20250704101433.8813-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

This method only accesses xen_domid/xen_domid_restrict, which are both
related to the 'accelerator', not the machine. Besides, xen_domid aims
to be in Xen AccelState and xen_domid_restrict a xen_domid_restrict
QOM property.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250703173248.44995-36-philmd@linaro.org>
---
 include/qemu/accel.h | 2 +-
 accel/accel-system.c | 2 +-
 accel/xen/xen-all.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index f327a71282c..a6a95ff0bcd 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -45,7 +45,7 @@ typedef struct AccelClass {
     void (*cpu_common_unrealize)(CPUState *cpu);
 
     /* system related hooks */
-    void (*setup_post)(MachineState *ms, AccelState *accel);
+    void (*setup_post)(AccelState *as);
     bool (*has_memory)(AccelState *accel, AddressSpace *as,
                        hwaddr start_addr, hwaddr size);
 
diff --git a/accel/accel-system.c b/accel/accel-system.c
index 913b7155d77..af713cc9024 100644
--- a/accel/accel-system.c
+++ b/accel/accel-system.c
@@ -58,7 +58,7 @@ void accel_setup_post(MachineState *ms)
     AccelState *accel = ms->accelerator;
     AccelClass *acc = ACCEL_GET_CLASS(accel);
     if (acc->setup_post) {
-        acc->setup_post(ms, accel);
+        acc->setup_post(accel);
     }
 }
 
diff --git a/accel/xen/xen-all.c b/accel/xen/xen-all.c
index 8279746f115..bd0ff64befc 100644
--- a/accel/xen/xen-all.c
+++ b/accel/xen/xen-all.c
@@ -64,7 +64,7 @@ static void xen_set_igd_gfx_passthru(Object *obj, bool value, Error **errp)
     xen_igd_gfx_pt_set(value, errp);
 }
 
-static void xen_setup_post(MachineState *ms, AccelState *accel)
+static void xen_setup_post(AccelState *as)
 {
     int rc;
 
-- 
2.49.0


