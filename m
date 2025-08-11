Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA4ACA0EC4
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 17:08:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulVyw-0004pm-GG; Mon, 11 Aug 2025 13:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulVyv-0004pK-2r
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 13:06:45 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulVyn-0001m8-0u
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 13:06:44 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3b783ea5014so2507767f8f.0
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 10:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754931990; x=1755536790; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EBVvp2mm8aGqZTUxsuL2RXTGufy667cu7GsFN8qW288=;
 b=gDUg2SdeuV/tcph5j2jA0hLodGspxiHh35xP3y/Lqx3XVLMGzcpTg3dnvVu2+BarsX
 gnsC0ZFwo1mBra4gZprPiaFRSFBkOv7BnCyrtSXMDNiwHE7z9nzS2UldBHKckrJYCC2u
 2WMeswT5m5tLchnzIODMTC/xfz5QPLyoUHVC7wkrPozuaUDkOYKy2dxM4HYYJkJnOO3r
 DZ7Oac78VwxWOdZ7ExbRrRZsrBM8UwYluQeCuR91W3tFlRMdU/axerB3LRZiIdt1kK7n
 c351SWQfVdoN5lKbo7P4s/Mnhzk99Vv17MJ1riYWA4/tOPL/RzixKY88unur+vjNMrov
 UR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754931990; x=1755536790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EBVvp2mm8aGqZTUxsuL2RXTGufy667cu7GsFN8qW288=;
 b=U1lcBoZ33p7plAVn3n/wNHoUtFwJMmzRNn2e8w0nxgGJ/V6uYYwG5dbSs97sQiCnb5
 o0kpVnU8aEpVzs5MYj2o+l/0oQxEvWSW9VP8yE+70du1DT30TsnqgI3/gwhb7sMvL1uH
 LfgDqPNl/MYlCV/dze2wP6Sq5I35NyKP9QqKvsR/3IyjBwUyQaRSQltrxC4nIFe6WxIv
 3ao8/tqb9JlqhHiJG9U2eW3g1ePj+o7gi7Q7dO3pbqBo6Ude4+IktNKVDKYB+36sZxnO
 OAG/o/uSllyLzdbC+8yzQ6KC34OBNdvOGYDlz3asFlJ+MI9/8FhU1HCgS3jOpl3c4/BO
 NByQ==
X-Gm-Message-State: AOJu0YzGniTydFOyTFuUw5Jq43djtTTX1/w2qE0qqaVqE6Ylp9G1ppJs
 V19QZ36sJHcT/GBxzDieX/awaIrCqK6L+H0Pp9nEdTmEoAQdPhpgXhV6/F0dfdO//JQhKrvElf4
 5+mg9
X-Gm-Gg: ASbGnct5NEnL12HxaEZKu6atr2CW8LHK4v+exoco1ew9MfiqhRljYQT7UxmfE5GhpZO
 QTGrslfEeXDL6QhpDYwSz+TbANAlZie/ZgJpFvDiHgYl2vIEQMMYCdcZAbMrXe0Daf3FQR78WLf
 /23zxsKwd+Fsqeq/yj+R6lOKLiHdFJjDWb8ujgPa4mV3fxU0cYm2TjWb5Q4Af4UZchCo3eSQnAg
 EtZErM53T84TQF+v/HFOdw04aOsduBoBYs/6ezdoSRSn8YSTqAWGoKpM+SnW/OE2mZ4vQmQmXON
 l3iP/sGZseTvE2oSkCyMyPJDAwAyU1g69K6nVV+YZ54LQ32paaDWdou6ebtmZ9ImcI8Fb6qwGVp
 r0kfeNiXD2yQ/dZhv7hFQoT1Qoe9e9gjpwEV4uKMpKFi++ckHZnmU0BgcdQO8kCjSw5s2oKXq
X-Google-Smtp-Source: AGHT+IGYtGd8rolKCFqRynOmaKKG7z81rdsXHVV5N9o+CH0wBtLo6sJkFR2p9cNAlJ+BSookmaVkUg==
X-Received: by 2002:a05:6000:1ac6:b0:3b7:7749:aa92 with SMTP id
 ffacd0b85a97d-3b900b6ab1emr10379986f8f.58.1754931990393; 
 Mon, 11 Aug 2025 10:06:30 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b8e04c7407sm31841796f8f.13.2025.08.11.10.06.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 Aug 2025 10:06:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Miguel Luis <miguel.luis@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Haibo Xu <haibo.xu@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Mark Burton <mburton@qti.qualcomm.com>, Alexander Graf <agraf@csgraf.de>,
 Claudio Fontana <cfontana@suse.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 03/11] target/arm: Restrict PMU to system mode
Date: Mon, 11 Aug 2025 19:06:03 +0200
Message-ID: <20250811170611.37482-4-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250811170611.37482-1-philmd@linaro.org>
References: <20250811170611.37482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


