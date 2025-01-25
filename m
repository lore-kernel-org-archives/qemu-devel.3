Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF90C0218E
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 18:16:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbkfu-0008KU-KZ; Sat, 25 Jan 2025 13:14:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbkff-0008DA-K1
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 13:14:16 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbkfe-0004G1-1X
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 13:14:15 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4361c705434so22040945e9.3
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 10:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737828852; x=1738433652; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oekQdNljsXmvRCfjRcF/YH736cTnRtLa3bqMS7/4HKc=;
 b=bR1OGlpggt6HX8m3z2x7MOCllw3RVk5BDUY4TGdhp8kCz+DUqDqF2hxqUyW1oVkfon
 wbpSH0FlL6ksGziFt9R0FLwimj2uO0MtrmUEoFIc1jRUMYDi2QzGO5pNjW4+tYmid5w+
 wfE3/QLzLMjikmNm5sFiZ80lWYPZOmhjRSAuTYz7hjgK0NaRsPOykXLB2Rqwzk0UDqLk
 7SLo35bUoripsOX35VozZLzJKGqr3xXsYVpQvaIOQfsW5HWleZEk8wQ7aHCa4nM8Nr4q
 r9eCKx59fG7UvEsCgfbseTcBoFhpBArUv9eNAh0SLlWKMDxb8WGYJz8/yALW1NY1uqGP
 CaDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737828852; x=1738433652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oekQdNljsXmvRCfjRcF/YH736cTnRtLa3bqMS7/4HKc=;
 b=ph1yTrGsvrGfjd1S3TR69oEoDDmElU93brJ6JAKdlo/FFiKm/oYRqUUrE4FbVQhs1J
 BRRgITAcqRiE9g6m8Uxs/QQV1K6HPkSPbdizZwzIz9gDnd1pV9M7WEFBx1pwfKOI7o5N
 tuTJKjya3tlArMe5OptybQcJMFGtQ2EvnZhp2imsFpmBIY5Rr9zwMc1YeiOjdNJTJzGr
 QH88k9UJRaseQJT/GXQkYHedHUzR5EF33+JK177/U4nnxrPxlg/PwwUKZGHGeLn+l+rD
 WJEwkydmrKIdHzpLMIqKF9Nh3Ni6hYKlhuT3EBC2WJ+jJDV1woOvWNYOg5Xg0EAKKCtW
 j1WA==
X-Gm-Message-State: AOJu0YzNTRz0mGiwMdvJKyvHzeggvGBW4THHns/KdxCKyRbd1hSS3M4K
 ic304yEABR8Rkg2hqIpD+FUTXzhZ+/oRVB+wwYpjeaHxyet8M6Woi+Bq2STFdKuRZHYUD+4WKGK
 2B4I=
X-Gm-Gg: ASbGncvPQDXL+7ra3qIG2sdGKKhUVCCiT6en2KEsWmaWq/y24MPIHF2okHfjcUc+SoK
 ImTpgrwmvisOMk/1WfKFY70Uge7iS1DO0alSL6EVUsw87x/NpsmHl0OgUPPCLE6dyMrsqGTMouj
 CYaz+wODEA7+L7K8TdjYg0b/WjgWuaChdy1fBL0dfBApWdTpFf6+PEOinIM4DM8Py/fQUAuvYXL
 nvxUraqspAtWo5yqj/CnEVJ2ub8RPa53YyhJjS3NYepQr1AqirY+mO+A3BaCkbr9/4eVdNKoWRJ
 fKHIBDkABUJdlCh79G1QDHKetZhEZjN9A+BcCxoPnz8D2MVyaw1mPjo5YW8X
X-Google-Smtp-Source: AGHT+IFcf5NC5w3OdMEeSdE+fJzRv8eMmKrsAaFn1q2W0Qs4+hxyDFiFEoLFYJSBxaKkISXGUJ3R0Q==
X-Received: by 2002:a05:600c:1f19:b0:434:a1d3:a30f with SMTP id
 5b1f17b1804b1-438b9cc072emr109914115e9.6.1737828852191; 
 Sat, 25 Jan 2025 10:14:12 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4900e2sm68626685e9.24.2025.01.25.10.14.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 10:14:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Anthony PERARD <anthony@xenproject.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <graf@amazon.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>, Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/9] hw/display: Have RAMFB device inherit from
 DYNAMIC_SYS_BUS_DEVICE
Date: Sat, 25 Jan 2025 19:13:39 +0100
Message-ID: <20250125181343.59151-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250125181343.59151-1-philmd@linaro.org>
References: <20250125181343.59151-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Because the RAM FB device can be optionally plugged on the
TYPE_PLATFORM_BUS_DEVICE, have it inherit TYPE_DYNAMIC_SYS_BUS_DEVICE.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/ramfb-standalone.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/display/ramfb-standalone.c b/hw/display/ramfb-standalone.c
index 6c35028965d..1be106b57f2 100644
--- a/hw/display/ramfb-standalone.c
+++ b/hw/display/ramfb-standalone.c
@@ -72,13 +72,12 @@ static void ramfb_class_initfn(ObjectClass *klass, void *data)
     dc->vmsd = &ramfb_dev_vmstate;
     dc->realize = ramfb_realizefn;
     dc->desc = "ram framebuffer standalone device";
-    dc->user_creatable = true;
     device_class_set_props(dc, ramfb_properties);
 }
 
 static const TypeInfo ramfb_info = {
     .name          = TYPE_RAMFB_DEVICE,
-    .parent        = TYPE_SYS_BUS_DEVICE,
+    .parent        = TYPE_DYNAMIC_SYS_BUS_DEVICE,
     .instance_size = sizeof(RAMFBStandaloneState),
     .class_init    = ramfb_class_initfn,
 };
-- 
2.47.1


