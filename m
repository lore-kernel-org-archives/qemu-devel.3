Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA647C02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 20:11:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfPFU-0001Hx-6n; Tue, 04 Feb 2025 15:10:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfPFS-0001FJ-H0
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 15:10:18 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfPFP-0006gx-Ow
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 15:10:18 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-436202dd7f6so69615155e9.0
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 12:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738699806; x=1739304606; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8QL8+XGbALi7lAV6J9dziWD7k5k+pAUriFa2xxqtszY=;
 b=Tv57WkRG5vIOCOkGqriQBLXRQlfpNLx+x+yXU2nqlonIHQGn/yBvPR9glC59/+qEMj
 RYpk+noLEZio/uQgcjxFnxZEi2AMWlkUHmhqBfLV8MZLgoa9dp3GVGsAkuhG7C+NilMi
 jVYl95C+1NDkHmYg8Y3gjMEnynWKmpIAqV081qOQ49Pucc3Sql/ZM1/Akls8NRc9IUxX
 OLW8QVSjRjcm9VCkQh3lvtEew+MqvYnCK4+ChkycpurDYzpfoYOPrssK1khx9yg3RykB
 WRFFVbm2UzTCFo0u7avKBiUOxmml+E2jwPGQhe0Db5LCWreyyY0TTPxiR9tFHeWtG3+6
 OkAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738699806; x=1739304606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8QL8+XGbALi7lAV6J9dziWD7k5k+pAUriFa2xxqtszY=;
 b=A7YA8q8x6yyynGuHjhk1Tg9Bm3PRSgamdL22SxMrsZh4vgrBNaychpxq8LGQO/fxtG
 Uv/isfRs9uOSvy8OdJtpka4pJHDrHk6C1YER3ysr3ii6g8MnvgUzkTz1+3Jyb3Wc1yba
 dk8n3onGLvrnJBqmZ7KwCEzBFnnws2BQs7EdD2oPIl9bFA325207nTOQG64hkB1z91aJ
 fcnDucFznkOluzWD/BcD4ZqrlaohhwsejykWueRx3RIQpSNFRjpErc3KDh2HqxlNzFmH
 lgGjhatMqploknwEKnlSi+VJEP7cxyLj6I4QqB9T1SSYwoRxWz4YVTS/mCspY4M7vk5/
 K32A==
X-Gm-Message-State: AOJu0YzjZmJf/gSxkhoVmbtENUfTuDPwAoBLqh/WRtgiW2JdpkUW8571
 WP413OHLpyTAmbyeie0ffN6vtVVyP1/0pdBfj/QPxof4H1hnWJi6Pa+HRiI130ZkBZzZW5Exuy6
 b7nU=
X-Gm-Gg: ASbGncueldeo7kkacC9+3sF7lvhsVdbJsqz3Zlculn+Fg5nMqxH0Qwj+kjEdjOLBMxy
 Z7l7BFjcM5wYITg/PQOLytU8HyHAky/gPbara1xWtNpJQV+DmDZ4nKdO2x+W1lDu9Pn4cXft19x
 oJoLZr5On8EDrOzz9klHUhJIJsCQnnYcUZgTE1bZmf5YZiXzuDvGYzfOz+xxD8TbKhLgthKwIKn
 hTVa6cKfsPWFjWPpv7P6gUVqJ3N1begIoD+C6My0yOiNFnNJpg0xT3MRbDOtSzyDJwrTTB9B8a1
 qVncjEK0Et+uHWtXiDgM2jVhLzZIbEItOv+1FltAnhSDvYSr8E5wsmy/xT2KaUHodQ==
X-Google-Smtp-Source: AGHT+IG7xk19i5O0KddA7YquxDe0+9lB4jMnvd+dlygippxXHv9PNyleDfnmb+RBzKPohmepbjhpHA==
X-Received: by 2002:a05:6000:e42:b0:385:f0c9:4b66 with SMTP id
 ffacd0b85a97d-38db489ef33mr105755f8f.33.1738699806065; 
 Tue, 04 Feb 2025 12:10:06 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c1cf2eesm16499944f8f.85.2025.02.04.12.10.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Feb 2025 12:10:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v4 6/7] hw/riscv: Remove all invalid uses of
 auto_create_sdcard=true
Date: Tue,  4 Feb 2025 21:09:33 +0100
Message-ID: <20250204200934.65279-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250204200934.65279-1-philmd@linaro.org>
References: <20250204200934.65279-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

MachineClass::auto_create_sdcard is only useful to automatically
create a SD card, attach a IF_SD block drive to it and plug the
card onto a SD bus. None of the RISCV machines modified by this
commit try to use the IF_SD interface.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/riscv/opentitan.c | 1 -
 hw/riscv/shakti_c.c  | 1 -
 hw/riscv/sifive_e.c  | 1 -
 hw/riscv/spike.c     | 1 -
 hw/riscv/virt.c      | 1 -
 5 files changed, 5 deletions(-)

diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index d78a96c5354..b9e56235d87 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -121,7 +121,6 @@ static void opentitan_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = TYPE_RISCV_CPU_IBEX;
     mc->default_ram_id = "riscv.lowrisc.ibex.ram";
     mc->default_ram_size = ibex_memmap[IBEX_DEV_RAM].size;
-    mc->auto_create_sdcard = true;
 }
 
 static void lowrisc_ibex_soc_init(Object *obj)
diff --git a/hw/riscv/shakti_c.c b/hw/riscv/shakti_c.c
index efe814b5868..e2242b97d0c 100644
--- a/hw/riscv/shakti_c.c
+++ b/hw/riscv/shakti_c.c
@@ -84,7 +84,6 @@ static void shakti_c_machine_class_init(ObjectClass *klass, void *data)
     mc->default_cpu_type = TYPE_RISCV_CPU_SHAKTI_C;
     mc->valid_cpu_types = valid_cpu_types;
     mc->default_ram_id = "riscv.shakti.c.ram";
-    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo shakti_c_machine_type_info = {
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 164eb3ab83b..73d3b74281c 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -153,7 +153,6 @@ static void sifive_e_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = SIFIVE_E_CPU;
     mc->default_ram_id = "riscv.sifive.e.ram";
     mc->default_ram_size = sifive_e_memmap[SIFIVE_E_DEV_DTIM].size;
-    mc->auto_create_sdcard = true;
 
     object_class_property_add_bool(oc, "revb", sifive_e_machine_get_revb,
                                    sifive_e_machine_set_revb);
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 1ea35937e15..74a20016f14 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -358,7 +358,6 @@ static void spike_machine_class_init(ObjectClass *oc, void *data)
     /* platform instead of architectural choice */
     mc->cpu_cluster_has_numa_boundary = true;
     mc->default_ram_id = "riscv.spike.ram";
-    mc->auto_create_sdcard = true;
     object_class_property_add_str(oc, "signature", NULL, spike_set_signature);
     object_class_property_set_description(oc, "signature",
                                           "File to write ACT test signature");
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 2aa420f6e55..241389d72f8 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1918,7 +1918,6 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = TYPE_RISCV_CPU_BASE;
     mc->block_default_type = IF_VIRTIO;
     mc->no_cdrom = 1;
-    mc->auto_create_sdcard = true;
     mc->pci_allow_0_address = true;
     mc->possible_cpu_arch_ids = riscv_numa_possible_cpu_arch_ids;
     mc->cpu_index_to_instance_props = riscv_numa_cpu_index_to_props;
-- 
2.47.1


