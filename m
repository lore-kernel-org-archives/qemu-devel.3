Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89187C87FCB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 17:30:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulsnx-00043Z-53; Tue, 12 Aug 2025 13:28:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulsnt-00042U-Ot
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 13:28:53 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulsnk-0003TX-GW
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 13:28:53 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3b914a9c77dso588797f8f.2
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 10:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755019721; x=1755624521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EYt3XWa5JdTgcAHas+NCLzX0AYSjTul5kKCxbeujNLY=;
 b=Z2ihcJ1EAyCjFwgMy7IQlVLclK4UJiVtHBoNowFPUybzb45APK9Lbn0il0CFCf+aQM
 zKewH2inznIKjaGnFd8ZzwTBnp4SqfyEFJz26loE3Nz+vPqPto/z3nMSv7fyO2Gqi4V6
 SGVToK9XBGk7QEQKeHNQH2wqSuY9pdxx4FJY5pHv9Gn0JdxTezY6eBEK1dwlYsc+BKQR
 KSZ38jsVUGmcnkpKbyLEn5vqSId/gquPHzinj42EurcdX05dbzETUWdwK8Njl9SvGX3y
 bL2StaI7Rp4nTodnh4AkOArvL81RvjFS2eJkYwgnH7GxZOQbTBZJM+TQ953evT1KaDsZ
 ligg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755019721; x=1755624521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EYt3XWa5JdTgcAHas+NCLzX0AYSjTul5kKCxbeujNLY=;
 b=L0O6EvP+ip2F/MktEROQMdvnfO2GKhmiZBjn0OUvN6oPCa/vaFbvcdAQOvLh/7qWYK
 3+1yFQpXTLVTq4GOnCVnn5hBKwwEO6FJ9JroWeBs010XdKZhxZnlH5sxd9vkUtMvBy8k
 NB5VfUYP0GUNVKeSVxhZ1hAMi/q/s+8yEWSekpnIYvBhjFYecBpP8EkrbKHpCoo7Uk+/
 T+jrQc4BMu4WeomyTIAHF4rpjhXlOq+VX/1pWsbPM0BKfll6God4BR58kU7JNe2lxIxn
 +bqioeTFAg5XPKHeVJZQld+nms9s81XO/Yz4wkcnZO5gv4IlfYgiFTgQKBJrZJMHX5b6
 yDfg==
X-Gm-Message-State: AOJu0Yy/r2lG2dhdl7rCHEiwPrpzXssghXa8j0RcsgP9NpQqshSdunvs
 GnSR53iNuPjACWmvn8Sx/Nsj7ssiVVKl7pM/IggpapVXrLELadKCJK8+vXbQK8RSSPls3iRxBIM
 iVtVv
X-Gm-Gg: ASbGncu5+JvJqtaKITRXJ65zKJPl61K8aExiNPX68CUR2zd4GRNgxSBnXNoQN/zkR9q
 ATvj5EDV/ON6cyV8WDEDsxdByzAG+mRr55WPjLtcfXc23RXU7bYSfPBQL4UVgjYTPZzqNi0h5CU
 wPJNVzMnDIBuwht0x8ZJN2HheoeJ4vlXyyYsoUJTxLHG64z+D4KEoIz7TwreXx4ZsAN7DclGsXx
 tIAJ4uj5ybRb8qfZvdfdXV19PEoolCYfdxwDOlD/YYizFgQjYPnjIlLngOfljaBmY9M5PIZYinJ
 /y68mpONPs/OG7mLIWSi/pHRst0pNv1CB7Sf9BNcWHWo/I8NssL9jSRyaNo+AnrD5xU6NdvHyyb
 pSRjiA694/AGqxwJ8YXOZ3gM+owtNJdUXgFNdTEWfKd97LmkTrxpPRbk1+WgBgeIzAA4Qq+D0
X-Google-Smtp-Source: AGHT+IFKDzIxMpZiGj7vZDL7rXt0avmWUA3RyLwDmE7PF+XxnCDfzncjSb/8L6jk6S1QcyKG6JKIiw==
X-Received: by 2002:a05:6000:178d:b0:3b4:9721:2b32 with SMTP id
 ffacd0b85a97d-3b91724ec5fmr221527f8f.10.1755019720839; 
 Tue, 12 Aug 2025 10:28:40 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3ac036sm44716290f8f.15.2025.08.12.10.28.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Aug 2025 10:28:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Claudio Fontana <cfontana@suse.de>, Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, Mads Ynddal <mads@ynddal.dk>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Miguel Luis <miguel.luis@oracle.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 03/10] target/arm: Restrict PMU to system mode
Date: Tue, 12 Aug 2025 19:28:15 +0200
Message-ID: <20250812172823.86329-4-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250812172823.86329-1-philmd@linaro.org>
References: <20250812172823.86329-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index d9a8f62934d..1dc2a8330d8 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1551,7 +1551,6 @@ static const Property arm_cpu_pmsav7_dregion_property =
             DEFINE_PROP_UNSIGNED_NODEFAULT("pmsav7-dregion", ARMCPU,
                                            pmsav7_dregion,
                                            qdev_prop_uint32, uint32_t);
-#endif
 
 static bool arm_get_pmu(Object *obj, Error **errp)
 {
@@ -1576,6 +1575,8 @@ static void arm_set_pmu(Object *obj, bool value, Error **errp)
     cpu->has_pmu = value;
 }
 
+#endif
+
 static bool aarch64_cpu_get_aarch64(Object *obj, Error **errp)
 {
     ARMCPU *cpu = ARM_CPU(obj);
@@ -1771,12 +1772,12 @@ static void arm_cpu_post_init(Object *obj)
     if (arm_feature(&cpu->env, ARM_FEATURE_EL2)) {
         qdev_property_add_static(DEVICE(obj), &arm_cpu_has_el2_property);
     }
-#endif
 
     if (arm_feature(&cpu->env, ARM_FEATURE_PMU)) {
         cpu->has_pmu = true;
         object_property_add_bool(obj, "pmu", arm_get_pmu, arm_set_pmu);
     }
+#endif
 
     /*
      * Allow user to turn off VFP and Neon support, but only for TCG --
-- 
2.49.0


