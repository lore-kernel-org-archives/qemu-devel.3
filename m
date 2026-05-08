Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DFBECD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 16:21:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLNw7-0001Ms-VW; Fri, 08 May 2026 12:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wLNw6-0001LI-5P
 for qemu-devel@nongnu.org; Fri, 08 May 2026 12:20:22 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wLNw4-0000xG-D7
 for qemu-devel@nongnu.org; Fri, 08 May 2026 12:20:21 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48a563e4ef7so20305085e9.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 09:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778257219; x=1778862019; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LTDqMeLcyGj/NXygQntrcbmLjmm6kj/aNSi917QkrfA=;
 b=WwhJejmzrfOEPhii6BcDtt8HGwAXEzXDeNiSxnxDGgEmzX3S0jvi46g360z0nsDG3S
 p4BtLNFBx7RB2hldaxT+7geY6i5wG2PZLXs2dLxwKnEwA33omlHzWCxaTvlajKSXT4Dy
 YhWl3GgdZffV00SCLE2Sol7NTBPh2k/Kl3MeaOydx7Xsf5gdf37z7bkyWbg9/5I4/hYZ
 jmJ2RXArFNmLt5WnciFbIFXIuviWjNYI7h8zKAqT9tIREgkYKjfoiVjy7FNiVEPtuAn+
 WzqdxKq00tZn6/dhlIVnOdVo4xppWuyV4EkoXRcNRxoXwvYnk5kszqN0+uABvpoAKvXT
 7bow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778257219; x=1778862019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LTDqMeLcyGj/NXygQntrcbmLjmm6kj/aNSi917QkrfA=;
 b=eNH1IrhHxUe0WGqnJvGpiWBndLl0jPoVBP/1ICA/cs8Dmy7m+Vf3BhjvAr2bhgNVug
 arQj6iMSs4DYpYUoEAk1G7EixyRi0FCHddArcVCn+iL4n+uVynToG0CLzV2JwDDQZhOX
 rimPXdH3rzdNrld/xDUnm6vlKwkjWv4ugXHqlHHcotOSk7ff2oToMZXWxztpfA8Q0PhA
 wO9mXqYq137T2P0o6cTFOLxbaxq1iEime6FFVCnVykPVKpi6G57Gw+qsXLOjPmE6WE2p
 lnY6IO697npBnCOZOVKO602GpJH+gUdJsuPj7ea/zfb4lW07uIEB36gvcTWqvHWnHS4/
 LHBA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8/M7clxFkcc7/58kzcbhdU/ZHSnq2XMy8p8c5qpAL//FDzdLrgm3T2ucEvanYys3aE2MNJL+PLfTSA@nongnu.org
X-Gm-Message-State: AOJu0YxBU9IRadxG/u8SkJUgfa4KSeSgO9BcRzfFBRJmuC4/VlG40nn1
 kCieZ6bur8+59bs7Zzp3a/fEYgtYfFzQlsC8fXc2ePMwwqStp0YZfHakd5G+Maw+oDk=
X-Gm-Gg: AeBDiesltlbNfpU5AAT9yzVTNhW3juF9rjn6MB6YBnLMnRZ/YQ+d7qsGnty5v4rhpkn
 hbVKW5s6XsURjgjIzn1KIINbVslFrPCCdkzsE3rZ4rwagyMhMsBswfNMVmL9cuzonS0pyrmEw0c
 CTMTl/bOgmmSawyIUjd1Q8/LaE4jHRBNDkHXstzzaFRAcT+YkrJ2t6kgbXwJuzecOAYCoGB4Lxm
 IitxopJ3abDdD8Tx9mnIDo0QrdNk9I/kEeo5j1nelSq+AiqlRvj+aknwNFcie1LDcQLOW4EQic7
 4JGRQlj7FlpFzc2rSWA/5J2HGJNKOVbmHQ7sOktUhIlRzeSp/BaBoU44c+SYncwP1u1GcEzozbS
 8Spg3kESh0yxMzbCzM4yR4h5cesCbb8jEXF4jODvgK+BvM9pbqcn9QYgSEgwENzynoyXLgdwj48
 iDvi74PJoYQY/hPmAXuGqyC9NtN4cjkAlaq1iHC5w+DNlqgleDE6lcei+ATnTp41a6eq2/QHg2L
 qkAb5yHQ9U51ovhXe7VVpQAY8VuMhY=
X-Received: by 2002:a05:600d:10:b0:489:a4:e555 with SMTP id
 5b1f17b1804b1-48e51f36fc6mr176894445e9.21.1778257218794; 
 Fri, 08 May 2026 09:20:18 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548ec6aea4sm6226998f8f.10.2026.05.08.09.20.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 09:20:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/4] hw/display/exynos4210_fimd: Use LOG_GUEST_ERROR instead
 of hw_error()
Date: Fri,  8 May 2026 17:20:12 +0100
Message-ID: <20260508162013.2751001-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508162013.2751001-1-peter.maydell@linaro.org>
References: <20260508162013.2751001-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

The exynos4210_fimd device model uses hw_error() in several places
for "the guest set this register field to something out of range";
update to the more modern LOG_GUEST_ERROR.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3405
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/display/exynos4210_fimd.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/display/exynos4210_fimd.c b/hw/display/exynos4210_fimd.c
index a91f04aaf7..0c9e42ec52 100644
--- a/hw/display/exynos4210_fimd.c
+++ b/hw/display/exynos4210_fimd.c
@@ -533,7 +533,8 @@ exynos4210_fimd_palette_format(Exynos4210fimdState *s, int window)
             ((s->wpalcon[1] >> FIMD_WPAL_W4PAL_L_SHT) & FIMD_WPAL_W4PAL_L);
         break;
     default:
-        hw_error("exynos4210.fimd: incorrect window number %d\n", window);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "exynos4210.fimd: incorrect window number %d\n", window);
         ret = 0;
         break;
     }
@@ -757,7 +758,9 @@ exynos4210_fimd_blend_pixel(Exynos4210fimdWindow *w, rgba p_bg, rgba *ret)
             blend_param[i] = FIMD_1_MINUS_COLOR(bg_color);
             break;
         default:
-            hw_error("exynos4210.fimd: blend equation coef illegal value\n");
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "exynos4210.fimd: blend equation coef illegal value\n");
+            blend_param[i] = 0;
             break;
         }
     }
-- 
2.43.0


