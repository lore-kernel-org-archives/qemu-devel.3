Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E19CEC3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 18:59:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAvay-0007pQ-H2; Fri, 02 May 2025 14:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAvaR-000614-QP
 for qemu-devel@nongnu.org; Fri, 02 May 2025 14:58:20 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAvaP-0005cC-1V
 for qemu-devel@nongnu.org; Fri, 02 May 2025 14:58:15 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-acb2faa9f55so300238366b.3
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 11:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746212291; x=1746817091; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iOAW9p4ck3r31lLX8gMavE55BXuL7nNj0tlEn6BG7jc=;
 b=fvAUFww6RIybGhfDfReNzIk+Sy3Hgo7rWd0f5nPap5vNHl49CwGzMIEanq9BQNVWSI
 vluNhVuE25FIu0VuO1AoDHnj+GNXqNDcS955hNhzCYiYHZbr3YNzPKcGO+U5lGKVFXgL
 2oEVIYYcs9D4CAE4jg99xmvkcT2jUcY7SSN9Gp5uWrZGVeGHtXV3jvzKEY3D+fSQsV4J
 eeCw2flLjRn/cFjN1p4UA9cpOXHSZHyw6gC4NZvW4k4nGvMp+m/aiu0szpmCTNaGU/rh
 0cSMluXgbprUqQuSxe94jZPGBxfsj2RSggVgGo0w/WY8r7jhiyLsWeScFNPtKHBv0TBJ
 kPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746212291; x=1746817091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iOAW9p4ck3r31lLX8gMavE55BXuL7nNj0tlEn6BG7jc=;
 b=tkn7vBKP+oO1oXAvHu4AlqQtjwNsZnEGXWViraVa3agb2M+jbeZuZUTBqkSfsetD1W
 WtcR7cfm/JuaDAec+PHymJY7yYZHpSqs46ly9Uf1SQPGjGEjxJExJ1mm4SrG+HnPI5i1
 BZV/ObpfqC4cI/CcEJ8um5W2Y+mgPlp8SCmWtJ46qr6eZCSQ5EZXhqls64vGRLzJM3SZ
 093YRMw0FORJqwMP+2IAbm3Qrs13tq7zXQQff/aKoVwfsm9mQDrDj1s0/nUVB42iEFvk
 zH1aSLfksE59S4HEDi2VNh18mSOMme0mI/MJDtONGkle521cT3MeBqBjDQkSPCzcTZEH
 VWqg==
X-Gm-Message-State: AOJu0YyQWmZu0b+yXOxzVuh23q+dS1+vq4eci/q0y/AXgbu1Uoe0pK53
 3Rh4vUVCzfS6sDZA1YnuJr+eVMZH+S20AlLl7QmiD1J/PKx73TZIOAnbz3tv41sjUG6vD5LYmU/
 y
X-Gm-Gg: ASbGncveLFgQu65Z5BAyjVJBP1iv2L7uh6RbO3UT0uFN9P3Pjcq0fEIJ747tzg1Zez7
 PpPO7LXpGfPb+uhJ2AEuhJxSr4jo3R1+wkrUr3p3/LQb3/4V5wksOV0uchTwMOsaiam7sbde/m/
 TOSXLcUsVOwqDxEMsSZgifDbL4k9nVIbFfJB/gN9soPHepaV1eW+7lkiBhGmop6m1IKqpohK9ha
 b7MgsNlMfUF+OVzUeDilIaSMwwQW2vHHnSkXN7EgkjX0KPE6RciJH99N3YyNKUgQyn7YrMlgSyv
 i4GMfHEdaUbSPCKFj8voG7lXASMxaUY052ugDuxUVzb8MCc0D3VyL5hsS6sSiuVzTuV1ioEHuw7
 ykotH73ZdpXw7OLHbbqr1XltJdzYmfTg=
X-Google-Smtp-Source: AGHT+IH4Ktw63AefTAMBmPROVmQaYAE+EpJ5gxnleKSO7z4RqmAR6tAeJflz7C5Tpbw44qd1B363lA==
X-Received: by 2002:a17:907:97c2:b0:ac6:fc40:c996 with SMTP id
 a640c23a62f3a-ad17ada7320mr391516066b.23.1746212291072; 
 Fri, 02 May 2025 11:58:11 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1894c028fsm85922566b.97.2025.05.02.11.58.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 02 May 2025 11:58:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Amit Shah <amit@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: [PATCH v3 13/19] hw/audio/pcspk: Remove PCSpkState::migrate field
Date: Fri,  2 May 2025 20:56:45 +0200
Message-ID: <20250502185652.67370-14-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502185652.67370-1-philmd@linaro.org>
References: <20250502185652.67370-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

The PCSpkState::migrate boolean was only set in the
pc_compat_2_7[] array, via the 'migrate=off' property.
We removed all machines using that array, lets remove
that property, simplifying vmstate_spk[].

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/audio/pcspk.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
index a419161b5b1..0e83ba0bf73 100644
--- a/hw/audio/pcspk.c
+++ b/hw/audio/pcspk.c
@@ -56,7 +56,6 @@ struct PCSpkState {
     unsigned int play_pos;
     uint8_t data_on;
     uint8_t dummy_refresh_clock;
-    bool migrate;
 };
 
 static const char *s_spk = "pcspk";
@@ -196,18 +195,10 @@ static void pcspk_realizefn(DeviceState *dev, Error **errp)
     pcspk_state = s;
 }
 
-static bool migrate_needed(void *opaque)
-{
-    PCSpkState *s = opaque;
-
-    return s->migrate;
-}
-
 static const VMStateDescription vmstate_spk = {
     .name = "pcspk",
     .version_id = 1,
     .minimum_version_id = 1,
-    .needed = migrate_needed,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT8(data_on, PCSpkState),
         VMSTATE_UINT8(dummy_refresh_clock, PCSpkState),
@@ -218,7 +209,6 @@ static const VMStateDescription vmstate_spk = {
 static const Property pcspk_properties[] = {
     DEFINE_AUDIO_PROPERTIES(PCSpkState, card),
     DEFINE_PROP_UINT32("iobase", PCSpkState, iobase,  0x61),
-    DEFINE_PROP_BOOL("migrate", PCSpkState, migrate,  true),
 };
 
 static void pcspk_class_initfn(ObjectClass *klass, const void *data)
-- 
2.47.1


