Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 666F6CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 06:18:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDd2L-0000WB-Ny; Tue, 28 Oct 2025 02:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDd2I-0000QF-8t
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:18:26 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDd2G-0007g8-6v
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:18:26 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3f99ac9acc4so5072143f8f.3
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 23:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761632301; x=1762237101; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sx+RfHJPAkCCNFsR/UKQOGpOYoVY+g6J3iIkCTCbk20=;
 b=yFTBjAR9aT2v+wDEl9zyhsKsw96Zc6P/czVPkUoECZIbmSPuQEhmaNXWWIHnSXZYfk
 t14Qz4SEM36SXWBVC+MxdKAkJfWk/t6awtdX4t65Mj/IXWDQ20EKzPJ+5CzPlGqBnipU
 FaJ/9p5E0FoUXyw3/+1fNEMtMzd9yuba0IkyQajTXt+/xzqLE8X37lQjYMarQTBGjeON
 CSVeeNGPCqg8aCZ16I5uhDt0iPZdGGprH0X/vgSSHYFiuXEHuzb4L83rfGFro9dDtcw9
 FjTful7xMm5n5fklvPylvN4+58rRBUzXxEOVRhQGOdrD2G++h8tjfjzTRgwDex4xljy+
 7NxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761632301; x=1762237101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sx+RfHJPAkCCNFsR/UKQOGpOYoVY+g6J3iIkCTCbk20=;
 b=rASSgrtudiG/rbUl8QZb+WsPoAFm/Oj9wqniEBkXai4p4nwKDPWIoThFO5uQ89tCQ5
 Ty9GtWYCQsfPF6UMe9Dex4S6q+uilrpdIxObvah9xQ47D5ZAa/ERQIWKIzX91JQXckgX
 PAYhJqYF4OwYMVYG9irswtCE8N0UE24YoDlHDfv75egg9iFz+1q2IWIOTB0nM8/9m+Pj
 f+Ajz4sAKDvzK+9W736WPqlUFKC71wfQ5VFP3wsj9coOEXZShlKseXD384Tc4WycWKgi
 6vYt9lijqVGiTwum5fqJuTEtmvPp5IEbP6MQv0qo8yan9UcGJd4W9h/5CWB+Yq+mhRZM
 Hbow==
X-Gm-Message-State: AOJu0YyEvS7OBlvOi1Ygkjyum67Rrrs0se76ZYdl7irrKJx6ldN//Mjg
 3wTVG1T6szHhPD4xl2mzNVHdMhDZH+cFsqC1n5Mt5j04GZKSm3GXE4I4Rw897/bIIrsdOBlBp/A
 RV814ABE=
X-Gm-Gg: ASbGncvsHgDgfud8ArJwk7CwxNMAkg27dBCzi55nx6JcOUYmdQiQzXvh+ebwtsdAMg4
 N+YWfdVIQqj7d1ChsFA28FXJKADBybcCQ3BfMfAAXYARTjNvqwFmc09Zkc/awcDa6m0JqSV4N5M
 sSy4VItA20pKhQ3dA8uHwPwcW7LKJzQSxWZ/LWBzqAJXUQmb6VJtAmh4/uGmNDoDCpZ3PbWjbcE
 3s5z3appFGT+wxY1kITXs8tNzT/2T9AQnMJzdb1zGnIjV1CFRghKhKFYXkBhXuODwDLpcu1Z+9b
 dKxFRytAY67BlPWa8ESrzdp5Ykjy1GxZPLZiXCzNkv+QiQkRPa/JOKD7y5GMjh/3OY7w6Tf6l1z
 UrVuBUwMXvOWwAHPQCEIqT5TGGf5+4v6ZaR4tn780ICGP2d0Jo5rQbrHL3ehhwGoAcLeyLjGgGN
 j4TZ/KWFFqGX62ORgunOniyMlaNSziW8OXqLQXIsAIRxOnaE4CTdwWQz3zvxkgTHOmoQ==
X-Google-Smtp-Source: AGHT+IGcDVJfBgBjeEoxnP4yAO/9tATx3Cj29mWlv4EIeDNus6K9r3Ef9LxlILDJLQ5hASiGuK3myA==
X-Received: by 2002:a05:6000:1788:b0:428:4004:8226 with SMTP id
 ffacd0b85a97d-429a7e82097mr1638268f8f.34.1761632301541; 
 Mon, 27 Oct 2025 23:18:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952df62dsm19882578f8f.45.2025.10.27.23.18.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 23:18:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Collingbourne <pcc@google.com>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 50/59] target/arm/hvf: Do not abort in
 hvf_arm_get_*_ipa_bit_size()
Date: Tue, 28 Oct 2025 06:42:26 +0100
Message-ID: <20251028054238.14949-51-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028054238.14949-1-philmd@linaro.org>
References: <20251028054238.14949-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Do not abort in hvf_arm_get_default_ipa_bit_size()
and hvf_arm_get_max_ipa_bit_size() when the IPA can
not be fetched. Return 0 (and document it).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf_arm.h | 11 +++++++++++
 target/arm/hvf/hvf.c |  8 ++------
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/target/arm/hvf_arm.h b/target/arm/hvf_arm.h
index ea82f2691df..21a69e7d105 100644
--- a/target/arm/hvf_arm.h
+++ b/target/arm/hvf_arm.h
@@ -22,7 +22,18 @@ void hvf_arm_init_debug(void);
 
 void hvf_arm_set_cpu_features_from_host(ARMCPU *cpu);
 
+/**
+ * hvf_arm_get_default_ipa_bit_size:
+ *
+ * Returns the default intermediate physical address bit length or 0 on error.
+ */
 uint32_t hvf_arm_get_default_ipa_bit_size(void);
+
+/**
+ * hvf_arm_get_max_ipa_bit_size:
+ *
+ * Returns the maximum intermediate physical address bit length or 0 on error.
+ */
 uint32_t hvf_arm_get_max_ipa_bit_size(void);
 
 #endif
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 0788b20cc05..5b077744720 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -829,24 +829,20 @@ uint32_t hvf_arm_get_default_ipa_bit_size(void)
 {
     uint32_t default_ipa_size;
     hv_return_t ret = hv_vm_config_get_default_ipa_size(&default_ipa_size);
-    assert_hvf_ok(ret);
-
-    return default_ipa_size;
+    return ret == HV_SUCCESS ? default_ipa_size : 0;
 }
 
 uint32_t hvf_arm_get_max_ipa_bit_size(void)
 {
     uint32_t max_ipa_size;
     hv_return_t ret = hv_vm_config_get_max_ipa_size(&max_ipa_size);
-    assert_hvf_ok(ret);
-
     /*
      * We clamp any IPA size we want to back the VM with to a valid PARange
      * value so the guest doesn't try and map memory outside of the valid range.
      * This logic just clamps the passed in IPA bit size to the first valid
      * PARange value <= to it.
      */
-    return round_down_to_parange_bit_size(max_ipa_size);
+    return ret == HV_SUCCESS ? round_down_to_parange_bit_size(max_ipa_size) : 0;
 }
 
 void hvf_arm_set_cpu_features_from_host(ARMCPU *cpu)
-- 
2.51.0


