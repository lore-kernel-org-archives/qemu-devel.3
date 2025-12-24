Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD754E75453
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 13:49:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYPDA-0006Jx-FZ; Wed, 24 Dec 2025 08:47:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYPD3-0006Gp-PT
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 08:47:25 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYPD1-0003i4-F6
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 08:47:25 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-42fbc3056afso3207486f8f.2
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 05:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766584041; x=1767188841; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wYWAkKrgLGKLEJzBNF2mvdemi8iXnGeEWzBQwxd6OM4=;
 b=qe4MMcACgyp19BAGesYEO1eojGdxgZqAA283DX/gzrLy95CU/DyisRd60j7HIIhAUh
 vfbcqhm9uTNlcPSWkMfW9mce7z1wM05fr8T7NGmmtfuJokVXx2LK/dsSBxe2RZ0KWb3v
 tbv0h9PsRNw0Msop40aSzTQbQ0Bv5qblM2nfLPiyXd68OUyq0gKey1ELEVIvXDeJIyhM
 8e5+OLdrRpgTZ8Ngt/Wb7mfRRIGfN3PXYTxDoKrCxqOr6LpXchSLa5nxb55LSqedeCTa
 cN7XYMcWjDvV05pv9IvtdvY6eUQlQE48bil3Ku30jb6NOl8qszu6pGP3AQARybZlXFVN
 w3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766584041; x=1767188841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wYWAkKrgLGKLEJzBNF2mvdemi8iXnGeEWzBQwxd6OM4=;
 b=Q7c8X5AFH3WXpiAyzyBNX830M2HD5dRLMapsWCSUpH/nJB60nVqFptk40q2NlMEc8a
 hBGd3cd5XfhprR1FQogE+5ddMMjosz8QCU/xJpYO0MDn5m5M5FZ4+CiMG4YH3+BGlOrK
 v/m1NbQeqQZctHD4ulqQZMXOzwwsYeew0VpYVoVKA3X+WFY63/0F07/nZZ8PSATHfMyU
 3sA913d/IYA0mV5litG02BmFValgADUghrg2VTyNFYxFj2iANkGIwuqPMlhV32XHDyCt
 +V9oJXzQ9yQnNWk+TFcz6fSupR5Di3yGQ8Jp4DaDHxPAwcyN8yRZyCypi2T/gaTlr5uD
 xYLA==
X-Gm-Message-State: AOJu0Yw5MrEnWDzZB7eNKZtC+enzi891LurypisQENpJvxWh3ZZBYG20
 B2dCLO9+PYfTDuOU6uilk4FN0KLOI1ZBziHoH+2tMEhiHO7DX14YsAsu/TWy/csabaIH7Io5W5/
 MTSU8Egk=
X-Gm-Gg: AY/fxX5nvSotF1ClNoTbykg9u0FM1W7OCNIVGQV+8WT/DZtjPrCNaz4s1UH8jGGdSgO
 AUmMloOSmT5KCz1jTobLGDHkgES9Rbs2VBj9Jo4tY9L8oU/dBLTzfct79Lw6vw7ZNZcZvZe59ag
 0hRE9o971h3WTHJautPn9jNGlIFopIlqLjlUgAdirQRK7dlBufutuZ641UKxAruvTNLHkqqPx2P
 IggQ0mMGhHI0z+lsi8tBn2ZEqNRYng63FwGLPNfsDRp2Z3CADRCg9fRj/09ZBFoKVyoZQwuhQ59
 ccxn39jyMvd76gpxsAl/5GgQj+6a6o0B0mWKruxw05fQXNyiEOEK/JjSWVDLgiTxv8cFseULm1N
 opK9pNBo++BGmndkYvUXuEoai4FEWmX1LTpzaw+9zIocR5nwDSjCvB3UfLrJKsxhij9xlMCSx1v
 Ghvi8TTi/2Lrjw+6s/ZIY++hR9fjC5abXieH5/kU3vzt9AwlZ4vyFPbo80pw3d
X-Google-Smtp-Source: AGHT+IGpRKcg+SvCUKQRGP5OhocSibsnsK6aqxmEiszVTN8Sq1AhPQpiR+QXZPhejGYSZFJevKjHgg==
X-Received: by 2002:a05:6000:2305:b0:431:316:920a with SMTP id
 ffacd0b85a97d-4324e4c1519mr17318370f8f.8.1766584041532; 
 Wed, 24 Dec 2025 05:47:21 -0800 (PST)
Received: from localhost.localdomain (218.170.88.92.rev.sfr.net.
 [92.88.170.218]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eab2ebfsm33933748f8f.40.2025.12.24.05.47.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 05:47:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, qemu-rust@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Anton Johansson <anjo@rev.ng>,
 Max Filippov <jcmvbkbc@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 4/8] hw/misc/pvpanic: Expose MMIO interface as little-endian
Date: Wed, 24 Dec 2025 14:46:40 +0100
Message-ID: <20251224134644.85582-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224134644.85582-1-philmd@linaro.org>
References: <20251224134644.85582-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Make the PVPanic MMIO interface behave like the ISA and PCI
variants: access it using little endianness.

Fixes: a89607c4d0e ("hw/misc/pvpanic: Add MMIO interface")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/pvpanic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
index c83247c4087..3e60b226e18 100644
--- a/hw/misc/pvpanic.c
+++ b/hw/misc/pvpanic.c
@@ -62,6 +62,7 @@ static void pvpanic_write(void *opaque, hwaddr addr, uint64_t val,
 }
 
 static const MemoryRegionOps pvpanic_ops = {
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .read = pvpanic_read,
     .write = pvpanic_write,
     .impl = {
-- 
2.52.0


