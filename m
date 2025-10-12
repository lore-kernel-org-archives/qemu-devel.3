Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABEE0CCD184
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Oct 2025 22:37:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v84gh-000473-4o; Sun, 12 Oct 2025 18:37:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xpahos@gmail.com>) id 1v84gf-00046X-K9
 for qemu-devel@nongnu.org; Sun, 12 Oct 2025 18:37:09 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xpahos@gmail.com>) id 1v84gd-0007po-Rg
 for qemu-devel@nongnu.org; Sun, 12 Oct 2025 18:37:09 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-58afb2f42e3so4301415e87.2
 for <qemu-devel@nongnu.org>; Sun, 12 Oct 2025 15:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760308625; x=1760913425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cA95iX4M9+Cz6iNCJ6BOuR7+8GDEhxJbdoNVkou25AA=;
 b=fz1JgJxG7RqcZHJMNtkHnka2QDAkhkYFMnwWK71YwbCaEnNKTif4jSUjzGKOPdX2dv
 ua7fFUVcEN8MAGLaurSfQq0lSUsaUvmBkU1VgxkLzYSZ0nPCKhwRNo8qbkOzG/GFKAGZ
 xnc5OZh9OVTW2wHH+7ItS2U0bP+YUruTVzVetvpFHH/jsqFuCpxkVuSJ7nC/9VGTaFm/
 3fzJyk1qaVY15W7eRVbd9pEXdLwqJvdvsKep1SvaxpHL5YGBBoBPzfLrceoa0HyfU79B
 w6bbVDQWaH2L+pDv2kb1MXeJABil7cDQshSuUUzLFhdo+b5sA6JTfrDTm1RxPgMarURH
 9tZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760308625; x=1760913425;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cA95iX4M9+Cz6iNCJ6BOuR7+8GDEhxJbdoNVkou25AA=;
 b=uDNo0sdZtWCveLph1CL/TVvMIzAlUf7r8049/+SErbT455AHp3D8a0Oxenv67Xhx1M
 W90+kJ8I4RPtg/XH/egy9kRBZ3tHh4NeE7RpNxsFD7YJNMaMvcxXxGk7aWCBi9Zex+uf
 OuIxec1Kh8RStdsXaPkSXJymULdCDcxu+zibM4TjJwb25cryL7Ky7d/kEyVdbuLQfuuc
 ep2yhstjtHJd0MDXDRbJlOEgY3ExN42UwXZhp8JNB7tSCOwfIoPdmEXJ/ewn2SgA4hps
 2jR07fUKf56m1HN0rEEbQwu+QdhMCOT05Yy6Gm6/FycAw8jkk4oBwI4UhM2jOPclcCoD
 IrjA==
X-Gm-Message-State: AOJu0Ywp+IutLqXYDExeZM5lwPvRjb6/8B21qwvVGbryOuifFzu9VMJQ
 m/+bxu3vtAT2SVZwPNyqMwn1tvbGCer2gBE08hVL4ugZIfR3EtA5xrQJVuvj+I0LoB8=
X-Gm-Gg: ASbGnct4d3t56tfJUA4qvSEznRnLxqTHXXtg5IcFykDomP+enxoVuUKX+JMwmOQGYbH
 CJ3CoC1y20imJVDr9fMBVRejHpf9jL+iUsSDx2PTd0oe7XguDyO4uGPVrNA5z8P+Cf/+sIv5Gkx
 AA89AJDeTTU1oniY16ObnkqNB335njioW4mvIZWBbSMl6P0z3KgSkdajI0+aw2u1ELvfJ2mIxM3
 x2MAnssTWz+oVMwhblfBTGWNWieDYUIsVJ5IBZ4+fCjsRhu+d3aOvTVSlqxgYustZmaCE9c8ZQB
 latv/25rJu1pAKoZpGmkS4GLgTX+h384EOqE5IyPqrkgJkpF3CjGgr09KO7X91oR2dAJPMic/6p
 sq0QZ336s5/yhhV1qrNHJVt0YpKfmwfot3H6oomS95/C2javXflrfsiuUXs0xZSqX
X-Google-Smtp-Source: AGHT+IF/fcaMvhuDRJ7Kyj/JpHVQn4ZHrTfSTCtbCHLmZaK86RsPbbFWYtAdrOMArcHTwohs0/fNRQ==
X-Received: by 2002:a05:6512:b02:b0:587:6853:4caf with SMTP id
 2adb3069b0e04-5906dd6d74bmr4917504e87.40.1760308624480; 
 Sun, 12 Oct 2025 15:37:04 -0700 (PDT)
Received: from xpahos-osx.yandex.net ([2a02:6bf:8080:593::1:c])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5908820d20bsm3421701e87.54.2025.10.12.15.37.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Oct 2025 15:37:03 -0700 (PDT)
From: xpahos@gmail.com
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Alexander Gryanko <xpahos@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] hw/uefi: fix properties list definition
Date: Mon, 13 Oct 2025 01:36:10 +0300
Message-Id: <20251012-pvvars-fix-props-v1-1-6ca31af626e0@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20251012-pvvars-fix-props-5a8509b47420
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760308348; l=976;
 i=xpahos@gmail.com; s=20251004; h=from:subject:message-id;
 bh=t0v8/1O3IYDylhQel+d8JeKG2uQXb7Rh0D3TRsufzRs=;
 b=V12Pkpg7EfOVLJDWszKpXvEWd6k54jkizHyHbAiTq53YXR42U0b+2n2OSnWh+eDtwi7183faY
 bFdnZorfOK8BtKL/3sCgP0ALB5oEtB6/kG6IWjnOmZO9wlDvM9Qi3w5
X-Developer-Key: i=xpahos@gmail.com; a=ed25519;
 pk=bsSvP3Tn7PVKgjJT3BMV3jlAwSqreKIM4099C1r51eg=
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=xpahos@gmail.com; helo=mail-lf1-x130.google.com
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

From: Alexander Gryanko <xpahos@gmail.com>

Added DEFINE_PROP_END_OF_LIST() to the Property structure definition.
This fixes the device_class_set_legacy_reset error when accessing
the prop->info field.

Signed-off-by: Alexander Gryanko <xpahos@gmail.com>
---
 hw/uefi/var-service-sysbus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/uefi/var-service-sysbus.c b/hw/uefi/var-service-sysbus.c
index a5aa218e26..a19591b1c3 100644
--- a/hw/uefi/var-service-sysbus.c
+++ b/hw/uefi/var-service-sysbus.c
@@ -39,6 +39,7 @@ static const Property uefi_vars_sysbus_properties[] = {
                      state.disable_custom_mode, false),
     DEFINE_PROP_BOOL("use-pio", uefi_vars_sysbus_state,
                      state.use_pio, false),
+    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void uefi_vars_sysbus_init(Object *obj)

---
base-commit: f3f2ad119347e8c086b72282febcaac5d731b343
change-id: 20251012-pvvars-fix-props-5a8509b47420

Best regards,
-- 
Alexander Gryanko <xpahos@gmail.com>


