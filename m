Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 622EBC0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 18:16:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbkg0-0008Qy-22; Sat, 25 Jan 2025 13:14:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbkfx-0008Oz-ER
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 13:14:33 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbkfv-0004I9-VD
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 13:14:33 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43625c4a50dso20247365e9.0
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 10:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737828870; x=1738433670; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OjNRCKPy/l7f95vUUTcVvrIiqVVOepFXrbHeokjkTeQ=;
 b=QEeGtKyTyaRXQyqMFPgl+hD7/VA2rBivdSHvJDNPW6gkOiJnBdoo7UvHJU6itwATKe
 pdPeP7vO47T7GSQZZjADcoHBGw20bmHfUxqf7pPgLs4rkS/RCK8b/TzGSiHA5muk8uDK
 R2YPCP3OXHO+hf1dNeygV1esnp/f273QLcMOWMz1TJ5KIfKMRWZWGc8DDjdO2csmcc5h
 GkIxlu+YgP2eeyQEWtuTbmCJqHeV3TLM7HHsRH2AVIhN4bYBDVwtJgAx2TiugvaILHnd
 6UOLIfsS2inftG/DwMW5mR9p9PI717T6dcJMyitmwJjsowEq/Jr5tGJvTmIUaqnakYjD
 IBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737828870; x=1738433670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OjNRCKPy/l7f95vUUTcVvrIiqVVOepFXrbHeokjkTeQ=;
 b=Z/ajJpte4xYBOYwzpzynMFHfLD+1FhxdWBF41ExxBpInkcslBESfyBCZct8xgP0Yme
 eXcV+Y05sPza+TdVj+00cv0O74ZDBBkqcEDFUCIW7Ku4qnJmUdX7KLRkXLgG39CSL+02
 99Nlbe8MDXd8F/8Ia1oeyez6KGignLCXT8/Dj80oaNNOJnVdWaSP2oko8kt6RY3hoIqe
 qKmecJApu55V8v0G+A4+3+/FaTBSB4ejnOr+9ewNIw7IJlmvOr/7vw5HfPJMYLifiKPw
 deeLZC46ow3h3Ib1YtJIACWfBnkcYwtW1KyYRXUmyAmno0vS7btqtpBCh+EeFaJCAcuJ
 +GJw==
X-Gm-Message-State: AOJu0YzsjVFuCAQy9VnjZ9JRukGmK8oV4PPO8Y5AoKKFStt7Lx1jSY+g
 HKBZsGocmvmxtTZVEAJRaq9yaPza2oJoGzsSfyDDVTqJR9FzSFCf4ho3dgEi9JJxIsHl4sx6HlG
 wvNI=
X-Gm-Gg: ASbGncuFkhOfLOBdAKlcFgXyHbZAx50gEVeP1Bol9lXcELpR/UnpV5E3G9FgI676clX
 KPi7ZyEr7ZBF/Xj4ukihAEUrHAUgIegQfEgpheoIMAl6m/PoutIL6t/uhYfHKM2H3eCpiRyRHyj
 UkW5PcGC3r6HcwupuqRZ1+o4NLjYKOk9Rrb9sN91KimnSUSBRi7+mvYrKZcUkGgfvxpyDuF6jAg
 iAay2r/jqyPf77b9iJ5/RMfiM1bP1LW8w1GzB4ui8j5CwlqJtUChVwVncYe0tsXuGhPqKUcwxsq
 380A2pKJmB9Ul6lWjY5RQNPBytqSd15nrYCKHtc7Ki7i/cPHEkXhbIVJavmL
X-Google-Smtp-Source: AGHT+IGsW1rE0tr04FeKYA2KGXlK/mvTNA5dlL64lnJuwONXDJIce4w6YtcdzlGTbIKmz0lEq52uwg==
X-Received: by 2002:a5d:4d83:0:b0:385:f195:2a8 with SMTP id
 ffacd0b85a97d-38bf566cd2emr22422454f8f.30.1737828870120; 
 Sat, 25 Jan 2025 10:14:30 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a176434sm6225313f8f.13.2025.01.25.10.14.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 10:14:29 -0800 (PST)
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
Subject: [PATCH 8/9] hw/tpm: Have TPM TIS sysbus device inherit from
 DYNAMIC_SYS_BUS_DEVICE
Date: Sat, 25 Jan 2025 19:13:42 +0100
Message-ID: <20250125181343.59151-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250125181343.59151-1-philmd@linaro.org>
References: <20250125181343.59151-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Because the TPM TIS sysbus device can be optionally plugged on the
TYPE_PLATFORM_BUS_DEVICE, have it inherit TYPE_DYNAMIC_SYS_BUS_DEVICE.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/tpm/tpm_tis_sysbus.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
index ee0bfe9538e..4f187690a28 100644
--- a/hw/tpm/tpm_tis_sysbus.c
+++ b/hw/tpm/tpm_tis_sysbus.c
@@ -133,7 +133,6 @@ static void tpm_tis_sysbus_class_init(ObjectClass *klass, void *data)
     dc->vmsd  = &vmstate_tpm_tis_sysbus;
     tc->model = TPM_MODEL_TPM_TIS;
     dc->realize = tpm_tis_sysbus_realizefn;
-    dc->user_creatable = true;
     device_class_set_legacy_reset(dc, tpm_tis_sysbus_reset);
     tc->request_completed = tpm_tis_sysbus_request_completed;
     tc->get_version = tpm_tis_sysbus_get_tpm_version;
@@ -142,7 +141,7 @@ static void tpm_tis_sysbus_class_init(ObjectClass *klass, void *data)
 
 static const TypeInfo tpm_tis_sysbus_info = {
     .name = TYPE_TPM_TIS_SYSBUS,
-    .parent = TYPE_SYS_BUS_DEVICE,
+    .parent = TYPE_DYNAMIC_SYS_BUS_DEVICE,
     .instance_size = sizeof(TPMStateSysBus),
     .instance_init = tpm_tis_sysbus_initfn,
     .class_init  = tpm_tis_sysbus_class_init,
-- 
2.47.1


