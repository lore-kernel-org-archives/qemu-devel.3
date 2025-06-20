Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67179C71155
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 13:14:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSbUU-0005Ee-6P; Fri, 20 Jun 2025 09:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSbUR-0005Bq-JW
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:09:07 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSbUQ-0004sg-0Z
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:09:07 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a507e88b0aso1550102f8f.1
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 06:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750424944; x=1751029744; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jKb7+45W8wr+DNWypSxWBKVEj0bAIAzVgg/1Er2vy8s=;
 b=CiA5T6w/zk81PZR+KrkaOzyj3uc6dHoz7mTdlTsdMa6P0yW0IbevzOsFkcTeDye9LY
 E7IL2URf5/M4w80UeGuiIBz9OYgu6USE8AUDSPDcUANDY7AOoF/1wSDdBv27rd41zaoQ
 PFx/aqhwKPU/NVEftqPUJ70kknpX307bCUsAG7neewFvMkY2VoJs6E+maxUqZc94xSPx
 W1QACjwvfjuxy1QE6gOEjjeAAUMJQ50H0brRy0k6kYTSbohfwGRUjonbi8mdBOvI+4la
 75tbWmCsKTuxBfsYHddO8BkDMtr/c1ouw/bqaZ2om6lvN8FSExHErSepArPQa4oA+eDe
 iEuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750424944; x=1751029744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jKb7+45W8wr+DNWypSxWBKVEj0bAIAzVgg/1Er2vy8s=;
 b=avhbD4xbT13XQlsN6lOXMmoTHj3XrkkwPtWZB9w5tE6rkSjP2idQO65StADMfjunpI
 cWfHncH0Qqh46gjWsXKyhWgEnHgRDlLn706EGkItMtwkNj7txN2SVXhrkEviJqtcQ1vJ
 JSB9EX8Do0yoru6T/Anspys7Tpv00ANl0VXB5FNaDGavQBKEr+MGM9H7IJ0NWZbtQMkd
 GMhSa+TYp6DwgirhWnYEG1D41/YuOR3hl0NKZy3nEdbPBTifDylx2OW5Kitt3aT/pfY2
 g4L+9HaoC4ORLJbceTRhvd/ggbkpDG3TTfZSful3lreNbPFxZKKGKcGArpJow5Yr9u3C
 kxdw==
X-Gm-Message-State: AOJu0Yy0IUEPov3lKT1i3XSQulq6QuqxNzI16RBjLCTgjxYV3rypc5T2
 WORApC0WrUz3mqSoSHCBprwxE+9AXJa2yzH2iU5CeMPikHr18oMrV9RB7rtWlTSOIcNStVIObsy
 Kd2f8zsQ=
X-Gm-Gg: ASbGnctOSebsCjTI4+EcQGCo/FymJn/5UVmJu0C/r/vxWa6XUadBHCSmlj326v/YLfs
 /oHjvVATq6huwYLg5x4AHlaL1p8duq8tqwnVm23y/NofBMnEbLZAgRDA2bNNTaAqbmZP04TGhTj
 tsk2PUjqLunOOu6sT9wQCnDKE4/VXYmLrPiCfK9QRhAdp/x3uQkGhGkJ9bmu21+Lm2pRmC8YdWu
 s2dTCm/ysWjscGanyZw8jUiBlOdOatIcrLatxed/uM3QCBvXjrAVn7aat/mCjeoIaClZV+/n0f4
 c7A3BR87srISbpmfeBSBBV8Yim07v6qpl/vCREHU7zXpS7DCW2d2gz6AVrYcd9z35hJCVBLKM0H
 8/aEIZG+B4x1p0+/qIW4ozb9tcoFSBo45Chea
X-Google-Smtp-Source: AGHT+IGU/PISgWAUAam3cXO827+5Gf2StC7Q8MM7jO79fbKmCjBYcioqe0LeMR+lxX2cddMN2HDweA==
X-Received: by 2002:a05:6000:4109:b0:3a4:eb7a:2cda with SMTP id
 ffacd0b85a97d-3a6d13071ddmr2045022f8f.30.1750424944090; 
 Fri, 20 Jun 2025 06:09:04 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d0f1ac5asm2117585f8f.33.2025.06.20.06.09.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 06:09:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v2 20/26] hw/arm/virt: Only require TCG || QTest to use
 virtualization extension
Date: Fri, 20 Jun 2025 15:07:03 +0200
Message-ID: <20250620130709.31073-21-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620130709.31073-1-philmd@linaro.org>
References: <20250620130709.31073-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

We can not start in EL2 / EL3 with anything but TCG (or QTest);
whether KVM or HVF are used is not relevant.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/arm/virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index b49d8579161..a9099570faa 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2210,7 +2210,7 @@ static void machvirt_init(MachineState *machine)
         exit(1);
     }
 
-    if (vms->virt && (kvm_enabled() || hvf_enabled())) {
+    if (vms->virt && !tcg_enabled() && !qtest_enabled()) {
         error_report("mach-virt: %s does not support providing "
                      "Virtualization extensions to the guest CPU",
                      current_accel_name());
-- 
2.49.0


