Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D1A8EF99EA
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Feb 2026 02:13:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vr59q-0003j6-CI; Fri, 13 Feb 2026 21:13:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vr59p-0003in-5Q
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 21:13:17 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vr59n-0004a5-Q7
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 21:13:16 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48069a48629so13637965e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 18:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771035194; x=1771639994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=99tut9IOO9gtsFLHOORswTThLZP4XwALyE4UKZNWpNM=;
 b=waiB9u5acn0S6iOlk/SDtMHzk8LUGxYuzNiEZ7SUs0skTHPBLb9H+1dq5DsQQcx3Wk
 pYsSbQxvl1FVfDhvg4+TCz3D+w4OjBnf+RoxInAZ3b8cTqBV8YUkQBYB1Ar1j7jCjI2j
 JzsuFwYG+AC0qUfzh/q0P3EJ4NLj7nGZXAGGhRrhB8A0k4NoHQ9yyR5ue3brXhBTn81U
 fsi22fKASdSnKCiS6jX+fQP8mZoBk9eU9tk5wGPMVdNxLjjmRfXrMCv81QM95zy8WruM
 t0aCmKR9YVo2Dox+nEg7q1zkUn8l4lGrss3y8XBkPmUb9ZnJvNM+Hqs9vTtSDPyJL7tn
 zDOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771035194; x=1771639994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=99tut9IOO9gtsFLHOORswTThLZP4XwALyE4UKZNWpNM=;
 b=uRlLvYt3mRMNp/Ji3e3Dnn7FvC5ptI5XsCOzIkcburCTF/7pykdceEnAbEnNMssz8i
 C13NV78iOCBwA8GvtWCPyOgnHIAEx3ctcNi8lNI18CTwpnynvHiahZvEIPYygJUg1rKi
 oIUxPCBwNMUAGZ+bfTlz0YkhgE+R3h7iANOKMJeigjSxbvlOL0Y3LdhAxEGkPPJzF8Qp
 GR1DklrJL8BI/TEhhyvisS7warknhUhnS50FV9ILJrtgDX+ODSINUez3WnYCSRcNNlRg
 ODNCMPX6pdIxeW/NXAaY5dx4k9pUPNSr5rGDpzFSUYrEG6O+R04LaEhJZBg24ugVyYnw
 eIBg==
X-Gm-Message-State: AOJu0Yz5p3vEBcyfMbNdItjDGSmFRqR3SEhGnehqbmSfHtmVXVzPDZNF
 wHnhaR/P3+VZM65HCO9QNKYrzTtun9A1Ljvrr4dOx1d7Xg/HoaCWRMhlqRo+YRluaVhO6iuco98
 mAsx+m6A=
X-Gm-Gg: AZuq6aKgaY6NypMQmL0elISfV/p8s99lmjkg35XmXGbB/flJjL5uy1MV+tWZEINphXL
 1//FMgx2ny+1Hz3z2QIvlNAYdwSttxZRXqDRfdSZ4GzENWVTgFcIF6arjFIwXGAgrF/magmtoPT
 zl1Jg+MWE0aAaG0qQNQ5GyAgx2jffVpUMDykRcA0RiKtPGa4TlWUFPbU9yc1EomlOyH/jDEH8yB
 HmTqpQlGjWy0pjgv6NhwjFvULQ5WiG3XGFSeY6y9C1JQIXl8iPT0kjOCM0CMiOJA2RsIQvwliV+
 H8yFKCjVp0WgD0xbi6Jqpfvs+T/r6aBrICAMGLItPVFuopXVWj9KJoC+T6JQ4RIGVyf4mfUgHXc
 r94Qtv1S2RF3ZHZkDnGNqOAZtIc8r16DVvL1+M/uhdIMDPqXAzdZtPR7Y6Jt8MB+UjIE3VAn+eV
 lm1dYOgwj5WWmcJjrwOKOdrhPK3oC6od1pn8fxRH8RYD9RePEg/5icqVwZBaVl0V6jPMxdnAg0s
 IXuhxdoMC4=
X-Received: by 2002:a05:600c:3e87:b0:480:32da:f338 with SMTP id
 5b1f17b1804b1-48373a0f961mr58292885e9.14.1771035193914; 
 Fri, 13 Feb 2026 18:13:13 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4837a5d562esm19158015e9.15.2026.02.13.18.13.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Feb 2026 18:13:13 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-ppc@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/8] hw/m68k/q800: Set MACFB_DISPLAY_APPLE_21_COLOR within
 MacFrameBuffer
Date: Sat, 14 Feb 2026 03:12:35 +0100
Message-ID: <20260214021240.58657-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260214021240.58657-1-philmd@linaro.org>
References: <20260214021240.58657-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

The MACFB_DISPLAY_APPLE_21_COLOR mode is not specific to the Q800
machine. Check and set it once in the MacFB DeviceRealize handler.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/macfb.c | 4 ++++
 hw/m68k/q800.c     | 5 -----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/hw/display/macfb.c b/hw/display/macfb.c
index 8ef174dc6df..b8115c2be13 100644
--- a/hw/display/macfb.c
+++ b/hw/display/macfb.c
@@ -645,6 +645,10 @@ static bool macfb_common_realize(DeviceState *dev, MacfbState *s, Error **errp)
 {
     DisplaySurface *surface;
 
+    if (s->width == 1152 && s->height == 870) {
+        s->type = MACFB_DISPLAY_APPLE_21_COLOR;
+    }
+
     s->mode = macfb_find_mode(s->type, s->width, s->height, s->depth);
     if (!s->mode) {
         gchar *list;
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index b55c03a90bf..ba32da2fa45 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -563,11 +563,6 @@ static void q800_machine_init(MachineState *machine)
     qdev_prop_set_uint32(dev, "width", graphic_width);
     qdev_prop_set_uint32(dev, "height", graphic_height);
     qdev_prop_set_uint8(dev, "depth", graphic_depth);
-    if (graphic_width == 1152 && graphic_height == 870) {
-        qdev_prop_set_uint8(dev, "display", MACFB_DISPLAY_APPLE_21_COLOR);
-    } else {
-        qdev_prop_set_uint8(dev, "display", MACFB_DISPLAY_VGA);
-    }
     qdev_realize(dev, BUS(nubus), &error_fatal);
 
     macfb_mode = (NUBUS_MACFB(dev)->macfb).mode;
-- 
2.52.0


