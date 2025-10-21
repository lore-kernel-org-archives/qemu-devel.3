Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC3DCCD1AA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:53:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJJ2-0003Yf-Qx; Tue, 21 Oct 2025 16:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJIt-0002w0-J1
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:49:59 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJIo-0001Hm-BZ
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:49:57 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-470ffbf2150so1605375e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 13:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761079791; x=1761684591; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pKK8jXEIKyswNJmUlNwj/PbQlBslE24jFLxpid4Aerk=;
 b=wmleXjYjNUH230Bpj6Bw0qlqho8M0nDn4s/4PbPS00R9RVUkmkPsiQCbnDGWHCtjy0
 qDk41JFOuUmNZsxf7aBPD1eWvagmRUHgWCeFmnI6Pn5B3LI01KCmy3VtLGKt3wNvEi1t
 8U2fYiNI6nvo1HoK8Fgfe8cyPNbVs5xfCx15K00hs4gw0eCoYmIO5a1Y1EwZxLXHIwXX
 ekyzHxRepCu8DKoFFhsFEpmbixiDJEaASwqSD45m9d9mpdKqvqVXyru8sgh2ugCYB/Ry
 lqwfgtM6ajsz/k/esIPK0DlUIIQhhtssk1WNhYE0y47wbIoO24ThXMhlY5fOBbXqeeQo
 vfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761079791; x=1761684591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pKK8jXEIKyswNJmUlNwj/PbQlBslE24jFLxpid4Aerk=;
 b=FvKIFjqw82ytxEXcu2404lmrzJNDCQ7NOCXTZefa99UMV8O3WoCADO7qxWuIgeBnnB
 4cbzZ1sjP5d3K7In/FuVEXN7DQOM8Xw/7/VjjmkNAExn1iq5fhZ3pwyf7B4YKuA4BYBI
 GR9TjX8H5RGpxQYuugU4jwXdfpX01x4Gsg/zLmoYqAchD26HrG7xah+t5U4PLh/TYh5j
 1SWGi30FpOccMBchF+RAgliXc+xtrzbgmqvs1DwZquoyGpuA09Delsh1NKs6UdyFkl9B
 aKM3Tdad46t4J319NPwILUDdKWQIeioomqFMK0W2WzKaKBa2yusetFDdPj8lgwxxvkyg
 80JQ==
X-Gm-Message-State: AOJu0Yy/X76jIVOGCBOypnN3d2meeXoqxJ1OBSypNCO2e+jfJ4vqRP9B
 YClPfg/gF/89yFOWi3wX9Rp84S4kv7Yh6gXp1YlzCBsgeS/f2j3EqMoAFkOj6II+MV+LIjs0Yg0
 3c/wgbxQ=
X-Gm-Gg: ASbGncu3EyITtzd/BAco8uA/I75wHFNXPlZ8DJ4XuXsOaHZ13A9aj03X3DiQC4DM3Dh
 9QKrOj/ljRjVCwlEwei2uRk/zhZWziT7AeVtE/neiK0+IZ+gWf87kzsHWOWQgUAyaP83yGpyAFR
 zXZDZtK/EBV4I+veA7ndhiSJDDRagMiRgklplCdVinA5vbbx0dd8H165QdO69QUlROuFTiuMgE8
 z8z80R7pXcTB0e+4qyitNgrAIy4B6zykmG0d7RS5u69I+wU8sCnGXTtg1ukAC2oGSWjql6sDHKG
 MCMz+ADgrqTrBbwZhn3oHOEr6+tw8adwbTDg4/2Q3K7CVzWEU4sVk/fxp2FU1B+rNrRpfk7tAZm
 yo0saXw/Ap+8IObpoW7F9V0mD6H9jdOC4zMYRSvqQUBhF9kgQx8et8+8PYKoSXRb71kNtC8b1Ku
 443cZohwWzw2CDq+2CPYYa87h2i3z0w5Tdv3KtiS5pIRluvT5V19pHkd8jw4/x
X-Google-Smtp-Source: AGHT+IGwDqW5rHtJuXG1+gIz3Zn2UNyqI9CKQC6yXGdOmT8XslhPz0lz9vmV0WalSqCHlZGmHczsxw==
X-Received: by 2002:a05:600c:6992:b0:471:5c0:94fc with SMTP id
 5b1f17b1804b1-475c3fa355cmr6999585e9.6.1761079791185; 
 Tue, 21 Oct 2025 13:49:51 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00b9fa8sm22368755f8f.38.2025.10.21.13.49.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 13:49:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/45] hw/audio: remove global pcspk
Date: Tue, 21 Oct 2025 22:46:50 +0200
Message-ID: <20251021204700.56072-37-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021204700.56072-1-philmd@linaro.org>
References: <20251021204700.56072-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

It is no longer used since commit 6033b9ecd4 ("pc: remove -soundhw pcspk")

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251021090317.425409-4-marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/audio/pcspk.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
index f8020593b0b..610a5b21626 100644
--- a/hw/audio/pcspk.c
+++ b/hw/audio/pcspk.c
@@ -61,7 +61,6 @@ struct PCSpkState {
 };
 
 static const char *s_spk = "pcspk";
-static PCSpkState *pcspk_state;
 
 static inline void generate_samples(PCSpkState *s)
 {
@@ -200,8 +199,6 @@ static void pcspk_realizefn(DeviceState *dev, Error **errp)
     if (s->card.state && AUD_register_card(s_spk, &s->card, errp)) {
         pcspk_audio_init(s);
     }
-
-    pcspk_state = s;
 }
 
 static bool migrate_needed(void *opaque)
@@ -237,7 +234,6 @@ static void pcspk_class_initfn(ObjectClass *klass, const void *data)
     set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
     dc->vmsd = &vmstate_spk;
     device_class_set_props(dc, pcspk_properties);
-    /* Reason: realize sets global pcspk_state */
     /* Reason: pit object link */
     dc->user_creatable = false;
 }
-- 
2.51.0


