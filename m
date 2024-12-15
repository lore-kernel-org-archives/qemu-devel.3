Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D4A5E7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:07:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMtwS-0001J1-WC; Sun, 15 Dec 2024 14:06:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtwO-0001Hx-Or
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:06:08 -0500
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtwJ-00013l-3q
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:06:07 -0500
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-2a3bf796cccso765581fac.1
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289560; x=1734894360; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YfdvdEpw4rd0ZJsP5bikzz8MeMRZ+4kEVHeHluJTAAc=;
 b=BYLIxb0gd65Nb+2K0Es4chgAoYpsMzU9Qn9S9/blRoH1oKuxlnaa+bzzs3ZTSVykPR
 hL+0aAOWqYHCKPXGsGlDa8GT33NbS8NDxLskVGQRKfVXcam789cbKLaf1lu3lQEDKmWK
 UWHdja8dRzsspNIcMAJMJ2NMY+Mjti0cHlgmjwMp3c15vaXpj9b2m8CGJ9UckcMMcstK
 Ay8wi/OkfEZ5tQ9gWQa6xMfPbg7I4jd2CXnFD8FWHqqHySD3kTAa/8pn1C+ZOFkJzJss
 OoJVBSVA+4+zzhBcI0Nhdj62sUsMqFarug+9PYD+EDAi+y9ezvXnCn3NGlgbf8D0uiqP
 CJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289560; x=1734894360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YfdvdEpw4rd0ZJsP5bikzz8MeMRZ+4kEVHeHluJTAAc=;
 b=ayBtqtcHjMb890ydMXOPTX/7Fmdl4ORUQvF4yTK+1SmUR7BJS0/NSuwJoqvHYhdG5m
 LdvVGHyrfIioYze4PPuTJup5q4eJXZ7lNb5d/7iTEHA0v9YLatrakM3OBtG8io859o2x
 qW/59T+tg18jvuZwTzHgOHXtMzzk9DhCS1a154e+uP72Y67qLxBILp1BvF0SQz1Bijna
 efpjMo0lcwkH1pIK0pgKXqkevo41paGwVvLVWhaPHLucJo+QPCXfqhIVlhXZFodRVPJr
 BNljDnHDFoBlG8limqaRd2ecHtQn04cDVFq2rGlYtXYjJ4FDwKxPicEBsRmG4rzO0DH0
 B+QQ==
X-Gm-Message-State: AOJu0Yx3K1Bm5oJHR/c6XRsPnh7yC3i/xBm7mW6F0D8IXd+o6/gdOubG
 +Y8tHbRhl/01QBOPowztqtCl77CsY5fx7t5NWFIbCK/nuHCL0iFsePmwjMeEW2ATBF9GSaLfS2N
 pIVSS4QJ+
X-Gm-Gg: ASbGncs9o+AHvQtTSnfncBRuuekVFQTAtPbbc9IlZH11edMnIWnNRcUQ4TTSrKON2CE
 Xv47G+3wYB4QVhuQgFcgGCdpe4elzC2L9DA+zLfnfBGNdYPl1PkTrBI6ypYSdzgZGjei2WjXl12
 DnbHoTJE9CY7MzM4k1zvBY+9ZY0z8VGmjpzSOxaWVQep5pvb/ClypoDUBuTtZmKgCl6EQL6m23X
 azmR7OHxtOuvzFvrQmlPjZnAd9w2NXO/ZhwXV9GI2mLU1AglKp6aKtqgBK49FEDGWHVAL6LAf/0
 mG9G7oYpZBA4+n1G4JiIj6N8h22jtlnfaCZM62Meeow=
X-Google-Smtp-Source: AGHT+IHjhDiAY/5N9nuExvWtqsC0iIhgxwKu+bkugIODorwcEfI6UWf/dwyy8Ro9ly0ps+ifgsa1NA==
X-Received: by 2002:a05:6870:472c:b0:261:16da:decb with SMTP id
 586e51a60fabf-2a3ac5a4333mr5292032fac.11.1734289560596; 
 Sun, 15 Dec 2024 11:06:00 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2a3d2914ac6sm1423214fac.39.2024.12.15.11.05.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:06:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 15/67] hw/audio: Constify all Property
Date: Sun, 15 Dec 2024 13:04:41 -0600
Message-ID: <20241215190533.3222854-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/audio/ac97.c           | 2 +-
 hw/audio/adlib.c          | 2 +-
 hw/audio/asc.c            | 2 +-
 hw/audio/cs4231a.c        | 2 +-
 hw/audio/es1370.c         | 2 +-
 hw/audio/gus.c            | 2 +-
 hw/audio/hda-codec.c      | 2 +-
 hw/audio/intel-hda.c      | 4 ++--
 hw/audio/pcspk.c          | 2 +-
 hw/audio/pl041.c          | 2 +-
 hw/audio/sb16.c           | 2 +-
 hw/audio/via-ac97.c       | 2 +-
 hw/audio/virtio-snd-pci.c | 2 +-
 hw/audio/virtio-snd.c     | 2 +-
 hw/audio/wm8750.c         | 2 +-
 15 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
index e373f09d78..8033bbbaed 100644
--- a/hw/audio/ac97.c
+++ b/hw/audio/ac97.c
@@ -1324,7 +1324,7 @@ static void ac97_exit(PCIDevice *dev)
     AUD_remove_card(&s->card);
 }
 
-static Property ac97_properties[] = {
+static const Property ac97_properties[] = {
     DEFINE_AUDIO_PROPERTIES(AC97LinkState, card),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/audio/adlib.c b/hw/audio/adlib.c
index bd73806d83..c1d8faecb4 100644
--- a/hw/audio/adlib.c
+++ b/hw/audio/adlib.c
@@ -297,7 +297,7 @@ static void adlib_realizefn (DeviceState *dev, Error **errp)
     portio_list_add (&s->port_list, isa_address_space_io(&s->parent_obj), 0);
 }
 
-static Property adlib_properties[] = {
+static const Property adlib_properties[] = {
     DEFINE_AUDIO_PROPERTIES(AdlibState, card),
     DEFINE_PROP_UINT32 ("iobase",  AdlibState, port, 0x220),
     DEFINE_PROP_UINT32 ("freq",    AdlibState, freq,  44100),
diff --git a/hw/audio/asc.c b/hw/audio/asc.c
index 805416372c..452039418d 100644
--- a/hw/audio/asc.c
+++ b/hw/audio/asc.c
@@ -695,7 +695,7 @@ static void asc_init(Object *obj)
     sysbus_init_mmio(sbd, &s->asc);
 }
 
-static Property asc_properties[] = {
+static const Property asc_properties[] = {
     DEFINE_AUDIO_PROPERTIES(ASCState, card),
     DEFINE_PROP_UINT8("asctype", ASCState, type, ASC_TYPE_ASC),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/audio/cs4231a.c b/hw/audio/cs4231a.c
index 2d69372087..abc38720a3 100644
--- a/hw/audio/cs4231a.c
+++ b/hw/audio/cs4231a.c
@@ -689,7 +689,7 @@ static void cs4231a_realizefn (DeviceState *dev, Error **errp)
     isa_register_ioport (d, &s->ioports, s->port);
 }
 
-static Property cs4231a_properties[] = {
+static const Property cs4231a_properties[] = {
     DEFINE_AUDIO_PROPERTIES(CSState, card),
     DEFINE_PROP_UINT32 ("iobase",  CSState, port, 0x534),
     DEFINE_PROP_UINT32 ("irq",     CSState, irq,  9),
diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index 9a508e7b81..6170425a5a 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -868,7 +868,7 @@ static void es1370_exit(PCIDevice *dev)
     AUD_remove_card(&s->card);
 }
 
-static Property es1370_properties[] = {
+static const Property es1370_properties[] = {
     DEFINE_AUDIO_PROPERTIES(ES1370State, card),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/audio/gus.c b/hw/audio/gus.c
index 4beb3fd74e..dd5a5a3441 100644
--- a/hw/audio/gus.c
+++ b/hw/audio/gus.c
@@ -290,7 +290,7 @@ static void gus_realizefn (DeviceState *dev, Error **errp)
     AUD_set_active_out (s->voice, 1);
 }
 
-static Property gus_properties[] = {
+static const Property gus_properties[] = {
     DEFINE_AUDIO_PROPERTIES(GUSState, card),
     DEFINE_PROP_UINT32 ("freq",    GUSState, freq,        44100),
     DEFINE_PROP_UINT32 ("iobase",  GUSState, port,        0x240),
diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index c340a9481d..8bd8f62c48 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -857,7 +857,7 @@ static const VMStateDescription vmstate_hda_audio = {
     }
 };
 
-static Property hda_audio_properties[] = {
+static const Property hda_audio_properties[] = {
     DEFINE_AUDIO_PROPERTIES(HDAAudioState, card),
     DEFINE_PROP_UINT32("debug", HDAAudioState, debug,   0),
     DEFINE_PROP_BOOL("mixer", HDAAudioState, mixer,  true),
diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index 6918e23c5d..3e4a755228 100644
--- a/hw/audio/intel-hda.c
+++ b/hw/audio/intel-hda.c
@@ -37,7 +37,7 @@
 /* --------------------------------------------------------------------- */
 /* hda bus                                                               */
 
-static Property hda_props[] = {
+static const Property hda_props[] = {
     DEFINE_PROP_UINT32("cad", HDACodecDevice, cad, -1),
     DEFINE_PROP_END_OF_LIST()
 };
@@ -1215,7 +1215,7 @@ static const VMStateDescription vmstate_intel_hda = {
     }
 };
 
-static Property intel_hda_properties[] = {
+static const Property intel_hda_properties[] = {
     DEFINE_PROP_UINT32("debug", IntelHDAState, debug, 0),
     DEFINE_PROP_ON_OFF_AUTO("msi", IntelHDAState, msi, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_BOOL("old_msi_addr", IntelHDAState, old_msi_addr, false),
diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
index a4b89f1768..7a6b9f52d3 100644
--- a/hw/audio/pcspk.c
+++ b/hw/audio/pcspk.c
@@ -215,7 +215,7 @@ static const VMStateDescription vmstate_spk = {
     }
 };
 
-static Property pcspk_properties[] = {
+static const Property pcspk_properties[] = {
     DEFINE_AUDIO_PROPERTIES(PCSpkState, card),
     DEFINE_PROP_UINT32("iobase", PCSpkState, iobase,  0x61),
     DEFINE_PROP_BOOL("migrate", PCSpkState, migrate,  true),
diff --git a/hw/audio/pl041.c b/hw/audio/pl041.c
index eb96dc2898..6c66a240cb 100644
--- a/hw/audio/pl041.c
+++ b/hw/audio/pl041.c
@@ -625,7 +625,7 @@ static const VMStateDescription vmstate_pl041 = {
     }
 };
 
-static Property pl041_device_properties[] = {
+static const Property pl041_device_properties[] = {
     DEFINE_AUDIO_PROPERTIES(PL041State, codec.card),
     /* Non-compact FIFO depth property */
     DEFINE_PROP_UINT32("nc_fifo_depth", PL041State, fifo_depth,
diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
index fd76e78d18..143b9e71e1 100644
--- a/hw/audio/sb16.c
+++ b/hw/audio/sb16.c
@@ -1440,7 +1440,7 @@ static void sb16_realizefn (DeviceState *dev, Error **errp)
     s->can_write = 1;
 }
 
-static Property sb16_properties[] = {
+static const Property sb16_properties[] = {
     DEFINE_AUDIO_PROPERTIES(SB16State, card),
     DEFINE_PROP_UINT32 ("version", SB16State, ver,  0x0405), /* 4.5 */
     DEFINE_PROP_UINT32 ("iobase",  SB16State, port, 0x220),
diff --git a/hw/audio/via-ac97.c b/hw/audio/via-ac97.c
index 85243e6313..e43ddf37f3 100644
--- a/hw/audio/via-ac97.c
+++ b/hw/audio/via-ac97.c
@@ -459,7 +459,7 @@ static void via_ac97_exit(PCIDevice *dev)
     AUD_remove_card(&s->card);
 }
 
-static Property via_ac97_properties[] = {
+static const Property via_ac97_properties[] = {
     DEFINE_AUDIO_PROPERTIES(ViaAC97State, card),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/audio/virtio-snd-pci.c b/hw/audio/virtio-snd-pci.c
index ab58c6410e..b762d7e81e 100644
--- a/hw/audio/virtio-snd-pci.c
+++ b/hw/audio/virtio-snd-pci.c
@@ -27,7 +27,7 @@ struct VirtIOSoundPCI {
     VirtIOSound vdev;
 };
 
-static Property virtio_snd_pci_properties[] = {
+static const Property virtio_snd_pci_properties[] = {
     DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 2),
diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index c5581d7b3d..e2b112e059 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -77,7 +77,7 @@ static const VMStateDescription vmstate_virtio_snd = {
     },
 };
 
-static Property virtio_snd_properties[] = {
+static const Property virtio_snd_properties[] = {
     DEFINE_AUDIO_PROPERTIES(VirtIOSound, card),
     DEFINE_PROP_UINT32("jacks", VirtIOSound, snd_conf.jacks,
                        VIRTIO_SOUND_JACK_DEFAULT),
diff --git a/hw/audio/wm8750.c b/hw/audio/wm8750.c
index ec2c4e1374..19e7755060 100644
--- a/hw/audio/wm8750.c
+++ b/hw/audio/wm8750.c
@@ -706,7 +706,7 @@ void wm8750_set_bclk_in(void *opaque, int new_hz)
     wm8750_clk_update(s, 1);
 }
 
-static Property wm8750_properties[] = {
+static const Property wm8750_properties[] = {
     DEFINE_AUDIO_PROPERTIES(WM8750State, card),
     DEFINE_PROP_END_OF_LIST(),
 };
-- 
2.43.0


