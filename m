Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED804C04FF6
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 19:01:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwo3R-0001jo-Qp; Tue, 16 Apr 2024 15:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwo3O-0001Za-Fr
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 15:01:14 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwo3L-0005jP-Dw
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 15:01:14 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a450bedffdfso607663766b.3
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 12:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713294062; x=1713898862; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xnRVHCDouTA+5HlMl31thguywp3whz3Nvn7kAUajqzI=;
 b=ZKa2ejw4GRIws2XhZpLlQWHneFq630p8RHMLZoklrSafv0XV/6bEJ14LJ7iqi8uY5V
 hmAd2AEvHjTKFqXtA6suHwkKtYKIyyF8+op1eQ59KvHqINceKbIBXp4HPDXZNjTLPrpe
 09J+4Qs+dIS3gC4R4wvFE0hhyDIMs+fbqk/FBV/HsGv9igx8+oyWi3OxQWVaOeilHBZ0
 CGe9NrBZcDmh7OUCMN1G/BOsyCIx4Rd/CGiq5YLR2366KpqZy9iDKiLPtP3+vE7TY74s
 rpddoVobeTDeUaAbp5RcubTtmF53d/EG1nrsg6+2GHxxqIsNYcUyUd+opVT3DGwSObhi
 GK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713294062; x=1713898862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xnRVHCDouTA+5HlMl31thguywp3whz3Nvn7kAUajqzI=;
 b=UOecHAmnUTmd68JWubTnZCRl8EI2zythq0y+R/LWCblkTON+wJHTnnxlZb2bqzQxVX
 3Un7Txq4/8Xw/TyWS5+EoYiyTbEEYdVHSet2nUG2K71qBDjj15nVu78Pb5uyKick9+I7
 Xu0GZFGCBqOoJGNYYK8iKhCHveS6ldc6jestYbXFQ9IuKhh7lN2XgQJrjLNGbm99NyXz
 DIzZfOV9xA+xNaEdoveUmJnSHIi9rWB24x/4fZWECuiB35MR9/+cmkFumnopr4F7U/ZL
 /tXq4EcaA7aoIewCJYGuRGZY6HHD0+IKEsQaJunBZ5WsQEdSLBA4TK41K8jJfxeO9yf8
 CveQ==
X-Gm-Message-State: AOJu0YylsXxlTFnvez5CZmVinSG8II3HV90rUzDeSXQw2S1A5C3dih1c
 320tlnlNwEqAq6XkxkWjMRajy/PhvDLFBI13ieDdotp0ZBi165NYAZhwFvGhOwms98v8HIE7z3g
 l
X-Google-Smtp-Source: AGHT+IHmrSIRqJsKZba5pLjtB/GfgVDWhUX3mw1VrEcy//79S5RNce+3653Kjo6DtPIWdXkATRLUrA==
X-Received: by 2002:a17:906:594f:b0:a55:428d:5de9 with SMTP id
 g15-20020a170906594f00b00a55428d5de9mr1810772ejr.28.1713294062573; 
 Tue, 16 Apr 2024 12:01:02 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.155.61])
 by smtp.gmail.com with ESMTPSA id
 q23-20020a170906a09700b00a519ec0a965sm7143556ejy.49.2024.04.16.12.01.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Apr 2024 12:01:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Thomas Huth <thuth@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v4 12/22] hw/smbios: Remove 'smbios_uuid_encoded',
 simplify smbios_encode_uuid()
Date: Tue, 16 Apr 2024 20:59:28 +0200
Message-ID: <20240416185939.37984-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240416185939.37984-1-philmd@linaro.org>
References: <20240416185939.37984-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

'smbios_encode_uuid' is always true, remove it,
simplifying smbios_encode_uuid().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/smbios/smbios.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 8261eb716f..3b7703489d 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -30,7 +30,6 @@
 #include "hw/pci/pci_device.h"
 #include "smbios_build.h"
 
-static const bool smbios_uuid_encoded = true;
 /*
  * SMBIOS tables provided by user with '-smbios file=<foo>' option
  */
@@ -600,11 +599,9 @@ static void smbios_build_type_0_table(void)
 static void smbios_encode_uuid(struct smbios_uuid *uuid, QemuUUID *in)
 {
     memcpy(uuid, in, 16);
-    if (smbios_uuid_encoded) {
-        uuid->time_low = bswap32(uuid->time_low);
-        uuid->time_mid = bswap16(uuid->time_mid);
-        uuid->time_hi_and_version = bswap16(uuid->time_hi_and_version);
-    }
+    uuid->time_low = bswap32(uuid->time_low);
+    uuid->time_mid = bswap16(uuid->time_mid);
+    uuid->time_hi_and_version = bswap16(uuid->time_hi_and_version);
 }
 
 static void smbios_build_type_1_table(void)
-- 
2.41.0


