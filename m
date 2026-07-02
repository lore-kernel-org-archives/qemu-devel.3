Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B492DC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 18:42:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfMLQ-0007e2-1M; Thu, 02 Jul 2026 14:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wfMLM-0007Np-0O
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 14:41:00 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wfMLG-0005Xs-2O
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 14:40:59 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-493b779003fso10668375e9.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 11:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783017653; x=1783622453; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VgzR+Zj58Y+E7ynljd+onQhIvfXDIAA7exg4nSgMcy0=;
 b=aoxwqMgE2Jb8R7d3C8CFuKvsiUuzTIA0feWkYMMfwhcoBxX+sRbRD6uKDC70y4E1Pc
 OsfJnzOfmURncoKYENo+2wD7homZzFwvQUO5lyWWR4NPUflq27341WpCsQjXdaOPYpE1
 QvWtC0mK3xvcYcIL8wuw/2S5RUci4hZ8AHu+LYlFy8EASm1GwKu9Ese+GkgmYAvSceds
 MYSykI5VorgTeShjDWOezNlaPO72gFMjewzORi5y9ovPJoh2FS0Ul4KRVLRf4pOI2/Zf
 jspET0yPK6+ItklsKG1QTQWgv3mHE4UYgI80X5rIUdXGJGi2L8CiMe7mf92IqgSQPFvj
 udbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783017653; x=1783622453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VgzR+Zj58Y+E7ynljd+onQhIvfXDIAA7exg4nSgMcy0=;
 b=UMo0N5WEeL4PJcbzy/wXUjeslUpQ3fe6x1S/kDO0Te0SueIBPIwDeBrqiPQbiy5Znt
 7V1uDbKlkF33WwKXHIicDUlJ7VLJU9pRQUhcliMt1mV7u03zWzQfqSlc8KW1pwkzYBMa
 k/JSl69OPYy+I4r/B3/EJkfmALIfBGiGZ5D5V0yqKMC9wsqJAyjvsVl479zOPw3xjD43
 Yl3YztDeyJ8a/HrXRYHTNy24CTnj9vegSMThv35KGziv8L9EvYd2PDbJPYW5wlOiR4wJ
 BRQha7axUm7lx9RpU9vUNYOsYCixGO8ATAwe7OOrwR6m35f4vIMLrCuSQqWFK7adDF6Q
 9LTA==
X-Gm-Message-State: AOJu0YyWKRvgXeAiK4JX/C38MBHalhMC0F82EhsIvPJdnxgp10L2gCkh
 Qrl0AWzlll8gNjzjM653HdzoDLXk91HWzHxvGFFmPrbqOw13ggabGyc4DYavSw==
X-Gm-Gg: AfdE7cnKEjUkbraW1DEDsxFtiaH06Ks5kr+tTmlPxlqLcAxNypRBSus5hnzeFfo/lV5
 SGf63YM2fRLg5wzuj4WrgTHRaDcUtjqrcsYru0Gf28G53E/fMsnjdHEHLVMTMsaFuE+0AEjG/Jx
 1FTNDOfWhBfyagcEMugMTqHXGtsuGwzECWNkCw7KxIMOEIYHYUcMv+pb5GnpELUywhmdElj+TXp
 xRK1+C/AQcZT3jZCpwCuKPCAFH9zFuWLvv9tDODQe8eSzIVTAkjNBRIF/pCzRgEOaen4KRQuKDK
 GkFTV9hqm8J/z+yJRLWPJziCqHp1mfiYxuNPdB9miiwkddQtptkN1GtcaG8Fxd4VDqL5zHdYTxR
 lX1fS8PuUzrTUbw3cGT0ra91C0BMdUa8xjWYUqSG0m90aaEXECDYFHP7vj8v3Bp6fO08tf/WVyn
 0UlL3ZdAWgiaJv9G9Z2LDhyLVdn5R3E5YTXhkT8Www3M3d/QKc1IGGMvWPXXoXBsOM2sMh6h1fP
 7pOz0i4R8J1zmS7T32GutdTe/y9PozsEI0t
X-Received: by 2002:a05:600c:5010:b0:493:c453:600f with SMTP id
 5b1f17b1804b1-493c453616emr70108775e9.6.1783017652489; 
 Thu, 02 Jul 2026 11:40:52 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-25c8-8a00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:25c8:8a00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bef1807asm120271225e9.1.2026.07.02.11.40.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 11:40:52 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Matyas Bobek <matyas.bobek@gmail.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Jason Wang <jasowangio@gmail.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Jason Wang <jasowang@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Francisco Iglesias <francisco.iglesias@amd.com>
Subject: [PATCH v2 3/5] hw/arm/imx8mp-evk: Open code DEFINE_MACHINE_AARCH64
Date: Thu,  2 Jul 2026 20:40:36 +0200
Message-ID: <20260702184038.178196-4-shentey@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702184038.178196-1-shentey@gmail.com>
References: <20260702184038.178196-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x332.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Open code the DEFINE_MACHINE_AARCH64 macro in preparation of creating
FslImx8mpEvkState class, needed for FlexCAN emulation.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/arm/imx8mp-evk.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/hw/arm/imx8mp-evk.c b/hw/arm/imx8mp-evk.c
index b84ac91a17..4a0c9df76b 100644
--- a/hw/arm/imx8mp-evk.c
+++ b/hw/arm/imx8mp-evk.c
@@ -113,8 +113,10 @@ static const char *imx8mp_evk_get_default_cpu_type(const MachineState *ms)
     return ARM_CPU_TYPE_NAME("cortex-a53");
 }
 
-static void imx8mp_evk_machine_init(MachineClass *mc)
+static void imx8mp_evk_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "NXP i.MX 8M Plus EVK Board";
     mc->init = imx8mp_evk_init;
     mc->default_cpus = 4;
@@ -124,4 +126,13 @@ static void imx8mp_evk_machine_init(MachineClass *mc)
     mc->get_default_cpu_type = imx8mp_evk_get_default_cpu_type;
 }
 
-DEFINE_MACHINE_AARCH64("imx8mp-evk", imx8mp_evk_machine_init)
+static const TypeInfo imx8mp_evk_machine_types[] = {
+    {
+        .name = MACHINE_TYPE_NAME("imx8mp-evk"),
+        .parent = TYPE_MACHINE,
+        .class_init = imx8mp_evk_machine_class_init,
+        .interfaces = aarch64_machine_interfaces,
+    },
+};
+
+DEFINE_TYPES(imx8mp_evk_machine_types)
-- 
2.55.0


