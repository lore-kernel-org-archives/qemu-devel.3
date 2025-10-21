Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5379CCD1AF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJJ7-0003qf-3e; Tue, 21 Oct 2025 16:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJJ3-0003fw-E6
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:50:09 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJIy-0001JA-AN
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:50:09 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4710683a644so2574025e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 13:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761079801; x=1761684601; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tXHQlfeNsbjB93VOH3deA9mNCchfVoce66tmua/L+g4=;
 b=MZ7afG97XYObp1YySiPtAQvY+1BweNKOJ9wUDt8TqpoOFtxibZbJhXupHS095gLdTN
 7Qnm0jIstzUzyd4xB4W6XyT2IEyl2Lvh8H0jvevgOkPCz8OzSzfb+3iDlErpq2ZeFgQn
 Yw9yUV+mtjltLbwQPRJA+rX6CMNEJFIlGJ0FDDhZ1Vnx51YR6zGBz3jcZ3boLNjmts0U
 ocNoZXbyiPH0Cvk0iAjBkWx2p6C7vlRF/G6qlHVZwyZhneP+pr478PqKTCilct/Sjs2e
 BcGOClOCeYwk2Pc7RSMFrx4ROgy5pVXhMvMfPyeRQtHG3soIlKz3y+qdMX9rhGyt1Uef
 bw7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761079801; x=1761684601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tXHQlfeNsbjB93VOH3deA9mNCchfVoce66tmua/L+g4=;
 b=hADJtA76gSs9tmKGfio7rNzKHZncWnAwbwtIuPL0pe0nBRbCUPbtTHvFm9aIHVAbqy
 YuJHHAb0IQnzut2PPdmQ1PjxSk4KZ1KVnvVpyD8hNOugjn5Xc+pUESh0W1Fhw5HAI9i4
 /RkNyynsLNEbrLhi4sW6I4imnJdQ3+kROTnTzzDceZXFq6k3BqoBC+pnc1K3AP2W7VP/
 XdTYoMSBsn2VUdlZkn/37YhzAPrwPEqZZ08nezeo6ir7KJ770fbHL+CBNjb8+HAKvHls
 U9IYWBHg68B0if4LcBRhgQIKlckDzoHQvCkTSSfpgyDsEqb4ywfloQ/DpJXyOJABldrL
 5n2w==
X-Gm-Message-State: AOJu0YzCe4IyL+oXPhKslloRmaIhtEHg1DFVDV/Vt3SHq8Y8K2vX/jKl
 wc41ZxGTZHZL7exURedVAclvtxEGUKF/GkggFgHfOgIgyzlcUILvLvBqBCSAzYqVtp6SebELrUj
 TSYTdjfo=
X-Gm-Gg: ASbGncvHizy1obCWd9H64n/vlCeF5RnChGreQ1+OfY32z1GWOqnEOghF/ed8eulAJMW
 VpbmAIyxRbg8Lf12p/pk3shcU6PvaS9RUF1+DksAfFfMdgAdJGByvM2+u0e0uY9DI5ASt9fXM+B
 S3pcgQXnD0dQKtgXu+PABE+r9TC3FZ13HVSoPSXf/ns095FrYuomD0tI3lfqBpQQlwlXn5w9cXK
 xPZDqZl4n2hGdpzltcO2nZ9I+e8NNojJS3zzTkYYlpaqj74bko/C7JENBX823d+lV2XIF1ZXlsl
 qjwlGUHN4GuwPaQ912q9IYDJQmnMBjTd0FizvJsUggOWpMBjkWLUVbF2b8RqPzQ884n0TQ42Pat
 4qZk80IvFMCAfAIxCTNes0261wH14xbhCwppuPfWe9TDOgOmCEpZwFXB7WPKEFHu1ynmhGOmJG+
 5+1GpXBlwqdPVDjsffB1IMQAhPwWIXa/sb7iULq2LdGyreCZMeUQ==
X-Google-Smtp-Source: AGHT+IE0Bho83YAOQgXJp6K824Z6Y59VJ/SsssyB8mbKl813qwDVEGZH1Xjg8zF9m0Q4kOM3LDWeTA==
X-Received: by 2002:a05:600c:3e8c:b0:46f:a8fd:c0dc with SMTP id
 5b1f17b1804b1-475c3f96944mr9837965e9.3.1761079800882; 
 Tue, 21 Oct 2025 13:50:00 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00b988dsm22360567f8f.35.2025.10.21.13.50.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 13:50:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 38/45] hw/pcspk: make 'pit' a class property
Date: Tue, 21 Oct 2025 22:46:52 +0200
Message-ID: <20251021204700.56072-39-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021204700.56072-1-philmd@linaro.org>
References: <20251021204700.56072-1-philmd@linaro.org>
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

This should be functionally equivalent. (for some reason, the device
property was convert to an object instance property in commit 873b4d3f0571)

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20251021090317.425409-6-marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/audio/pcspk.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
index 9cf78ff55fa..7b716c08efc 100644
--- a/hw/audio/pcspk.c
+++ b/hw/audio/pcspk.c
@@ -182,11 +182,6 @@ static void pcspk_initfn(Object *obj)
     PCSpkState *s = PC_SPEAKER(obj);
 
     memory_region_init_io(&s->ioport, OBJECT(s), &pcspk_io_ops, s, "pcspk", 1);
-
-    object_property_add_link(obj, "pit", TYPE_PIT_COMMON,
-                             (Object **)&s->pit,
-                             qdev_prop_allow_set_link_before_realize,
-                             0);
 }
 
 static void pcspk_realizefn(DeviceState *dev, Error **errp)
@@ -224,6 +219,7 @@ static const Property pcspk_properties[] = {
     DEFINE_AUDIO_PROPERTIES(PCSpkState, card),
     DEFINE_PROP_UINT32("iobase", PCSpkState, iobase,  0x61),
     DEFINE_PROP_BOOL("migrate", PCSpkState, migrate,  true),
+    DEFINE_PROP_LINK("pit", PCSpkState, pit, TYPE_PIT_COMMON, PITCommonState *),
 };
 
 static void pcspk_class_initfn(ObjectClass *klass, const void *data)
-- 
2.51.0


