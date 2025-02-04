Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3CE2C02192
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 00:24:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf6jM-0001E4-KT; Mon, 03 Feb 2025 19:23:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tf6j5-0000Tp-P5
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 19:23:43 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tf6j3-00076t-IE
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 19:23:39 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-385e3621518so2398786f8f.1
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 16:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738628616; x=1739233416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n6QDpRJ2FlSdxPQFjP8LoBbvp72nwEtWebL/3euq8gE=;
 b=PGsutE7YGyahRu/ZrVam/1rxYYq9dLJt5zsalWdRXju2kb9LzvJCNCzEbpX2gmyytM
 boJ/QXos+VvC1tm0fbYG0H1JernPboafglziiqWbhrQ6cNG3a8/A2ilR6jMjLVc9TP40
 VZcHYJ3lb0Lg53KY263Ua4PB4Tdeecfd6Rb+yorflLMgpUue74K/OlrpKyyRryG507/e
 W8CaFeip0f0Mb+GbUeoMxglG9yYa/P3qqLblujIolP+i8FKGGFyXfNep5nvNSkwkkL45
 /sj6aInoevmQSGyw5HYs46B4vldQnwvfiMP+dHT6CriBzZ4fvQUus7iQGM5jD+CLOfX+
 NZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738628616; x=1739233416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n6QDpRJ2FlSdxPQFjP8LoBbvp72nwEtWebL/3euq8gE=;
 b=Xxb761hJKIIM1HI6/zH6TLd9yIS2HCOvVNH3EfcPzdbqUMZ4ugPsk8HEkAvYIWseQY
 9vxcy2j5TeF43VUkau+HOUMTeWQWtNcxOLUbBNsIhzPWDs5iNwUfWyU1qiDACZ+wxFCn
 2b8/DaGhMV3R8N4qtbuhB0tpsETgbcFWnB7sN4ejXqPHvAilZ63BPW3WljL+Ko1vAM3K
 j05xictjcgrr5Yg0bmZKhzwASfOMGIwY/ekayuiKLD9LeimeBwX+p9g3aUWd8nKDougd
 +oZjI4o/0pwfvk1OBUjc+rjmfK7wzzYeefaL9l3bDAeO19I5yruH7epQ6EZBUtjrPCyI
 l4BQ==
X-Gm-Message-State: AOJu0Ywd3kSoKQmk8EpCE+Oy9xgufQ2rJR4iLg5BGxx9j5twmote3Xpt
 /japq2LZ8puMmc9FUs+/u+9Btq/F4TDS17RUzVtZfhOSwuArlV6ngbnhtphlrLK750+MwfgLwM3
 aeyc=
X-Gm-Gg: ASbGnctpGQH5tLEkZCU9BW4DHZJ1xWr/Lng+gvCjYICkiSWUf1WrSifBu1szPNftlkJ
 GKO5hhogCSsBgZuWaEaYK3zvdrmDDELPoiQyz/KHYa8qEopgsIrrugMunX+QodoStXjoRDV5+pt
 tg5HlzYcdrBhSdNTl60fR3LiE9aD5Msd3aH8JgUtEthTNZsaLl/OdVEzM/K2J8ykd53wy6Ti/sN
 Bg9v7N2+Lc12KMdcwKCVRM7DQ3+GtxfTSafl8jQpruWG/qOcRbznQV9Ju/057yBhdEwee09i4Cd
 wo8SeO1vxvxELGs5YlEWnAaPOXckwtrOrH4sKivquqiuWdSdIUYXuB4U1gJG1yPhfg==
X-Google-Smtp-Source: AGHT+IGvLfzTEpc1pBKpxxVeRx8k046du4w0Is2O3ClvlntW/6wwoH7wrL1zHpqYqwZUy/jy/wfwHw==
X-Received: by 2002:adf:f4d2:0:b0:382:5aae:87c7 with SMTP id
 ffacd0b85a97d-38c51b5d898mr15999565f8f.31.1738628615886; 
 Mon, 03 Feb 2025 16:23:35 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e244ecd6sm175409535e9.28.2025.02.03.16.23.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 03 Feb 2025 16:23:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Ovchinnikov Vitalii <vitalii.ovchinnikov@auriga.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jared Mauch <jared+home@puck.nether.net>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 devel@lists.libvirt.org
Subject: [PATCH v2 09/12] hw/arm/raspi: Have the generic machine take a
 'revision' property
Date: Tue,  4 Feb 2025 01:22:37 +0100
Message-ID: <20250204002240.97830-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250204002240.97830-1-philmd@linaro.org>
References: <20250204002240.97830-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Add a property to specify the board revision. This allows to
create a Raspberry Pi 2B with BCM2836 SoC (rev 1.0 and 1.1)
or BCM2837 (rev 1.2 up to 1.5).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/raspi.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 1dc41701efe..b184ac3c446 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -491,6 +491,10 @@ static void raspi_update_board_rev(RaspiBaseMachineState *s)
 
     model_index = FIELD_EX32(s->board_rev, REV_CODE, TYPE);
     proc = types[model_index].proc_id;
+    if (model_index == 4 && FIELD_EX32(s->board_rev, REV_CODE, REVISION) > 1) {
+        /* 2B rev 1.0 and 1.1 have BCM2836, 1.2+ have BCM2837 */
+        proc = PROCESSOR_ID_BCM2837;
+    }
     s->board_rev = FIELD_DP32(s->board_rev, REV_CODE, PROCESSOR, proc);
 
     ms->smp.max_cpus = soc_property[proc].cores_count;
@@ -517,6 +521,35 @@ static char *raspi_get_machine_model(Object *obj, Error **errp)
     return g_strdup(types[FIELD_EX32(s->board_rev, REV_CODE, TYPE)].model);
 }
 
+static void raspi_set_machine_rev(Object *obj, const char *value, Error **errp)
+{
+    RaspiBaseMachineState *s;
+    int rev;
+
+    if (strlen(value) != 3 || value[0] != '1' || value[1] != '.') {
+        error_setg(errp, "Invalid revision");
+        return;
+    }
+    rev = value[2] - '0';
+    if (rev < 0 || rev > 5) {
+        error_setg(errp, "Invalid revision");
+        return;
+    }
+
+    s = RASPI_BASE_MACHINE(obj);
+    s->board_rev = FIELD_DP32(s->board_rev, REV_CODE, REVISION, rev);
+
+    return raspi_update_board_rev(s);
+}
+
+static char *raspi_get_machine_rev(Object *obj, Error **errp)
+{
+    RaspiBaseMachineState *s = RASPI_BASE_MACHINE(obj);
+
+    return g_strdup_printf("1.%u",
+                           FIELD_EX32(s->board_rev, REV_CODE, REVISION));
+}
+
 static void raspi_generic_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -540,6 +573,12 @@ static void raspi_generic_machine_class_init(ObjectClass *oc, void *data)
                                   raspi_get_machine_model,
                                   raspi_set_machine_model);
     object_class_property_set_description(oc, "model", "Set machine model.");
+    object_class_property_add_str(oc, "revision",
+                                  raspi_get_machine_rev,
+                                  raspi_set_machine_rev);
+    object_class_property_set_description(oc, "revision",
+                                          "Set machine revision. "
+                                          "Valid values are 1.0 to 1.5");
 };
 
 
-- 
2.47.1


