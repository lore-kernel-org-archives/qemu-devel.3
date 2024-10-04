Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04587CF8840
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:22:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swl4Z-0004vF-1a; Fri, 04 Oct 2024 12:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swl4W-0004r7-LV
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:22:28 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swl4U-0004LK-9E
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:22:28 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2faccccbca7so21896121fa.2
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 09:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728058944; x=1728663744; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ebEqKdyGGyobi2PRRQ6OMJlevfLMnU19pPI1rOWFDYg=;
 b=QeOk1omeyi60bBcIQ8fFXbIOsEtajeYXVHvNf/ZvXGDEQVqiA9e3eOVhtCuoieRgfW
 pXfR5ojRGVXq30WFIY+n9uUf6Q+CKPMRXd45/crn/BYmZvy2SDrgnitmImYGXGhxFuWK
 PQNaLNqkCyynv4VW8hyF4dIFufKKrG9qm6byjyxUD4vycaOk5KVf6B+pD+YYf46VyMkh
 b+K0fTw7SJqTwaWk2BU3ZgecbQ4jAiCqkybYpglqakkb9YE9VngeDzdhwuvLahHQt+4O
 Wrjb3jkEeUscCm12ThSFXXaI9tZ7zDHfIyQmaAI6CeVri2PkPY+2ANKEHC0mV7P0S5IG
 7Wqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728058944; x=1728663744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ebEqKdyGGyobi2PRRQ6OMJlevfLMnU19pPI1rOWFDYg=;
 b=ER0bccNMsrgkhD31HNbbX7UZQaLdPd2CKwnf4T2Pg82tC35lnGLZgEyXJTQFmUOBDB
 D3FyAykrFCxyZDMl7M2Q/yPAQOV5bfH3e9gkNi7/jRs8/Ljjf8WpO7sxF4y0Efiq+H/1
 0j093gv59m586ymVecBfi1I8AbdZOnHVT5+OTmR7eUhcfKy1d1JmjnZThFp5bUIxB604
 +EVtFh2jA/FXFVQLffV3lRCdOovWCMIcjtvNqUk9Ow3qevrTUwcadNDQLiCYiB2YJbVv
 R2l3kpR6LEMFVe4xOcECsz2Wsk0RnN61zJaL8WLi5a9uCNZA00EriRfw9Hg2fVqkBSmf
 I2Tw==
X-Gm-Message-State: AOJu0Yy+TNBYA29B+EjV+iRToDMiQTGRGpeZiTsD/PdAK0i6yaVjr6qT
 uAezXeVzHb+aDSJMr6NsqThijJNdBgrzFRiy9LgHHUo2JULbN3IsLQAI8NPR3px7xQBVLhVHFgj
 mgCdJ+A==
X-Google-Smtp-Source: AGHT+IHnzVu5caSnTRwtmMQBdLBYvQKhdYxM2GW+30HiKyNW0uitZ/UP7lJ7j00E/xoLoSSMEuJPAA==
X-Received: by 2002:a05:651c:a0b:b0:2f7:4ccd:8918 with SMTP id
 38308e7fff4ca-2faf3dac918mr20555041fa.43.1728058944270; 
 Fri, 04 Oct 2024 09:22:24 -0700 (PDT)
Received: from localhost.localdomain ([91.223.100.208])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2faf9ac4415sm164741fa.34.2024.10.04.09.22.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Oct 2024 09:22:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-ppc@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 3/8] target/arm: Implement CPUClass::is_big_endian
Date: Fri,  4 Oct 2024 13:21:13 -0300
Message-ID: <20241004162118.84570-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241004162118.84570-1-philmd@linaro.org>
References: <20241004162118.84570-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x234.google.com
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
 target/arm/cpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 19191c23918..2bb87a9299f 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -122,6 +122,11 @@ void arm_restore_state_to_opc(CPUState *cs,
 }
 #endif /* CONFIG_TCG */
 
+static bool arm_cpu_is_big_endian(CPUState *cs)
+{
+    return arm_cpu_data_is_big_endian(cpu_env(cs));
+}
+
 /*
  * With SCTLR_ELx.NMI == 0, IRQ with Superpriority is masked identically with
  * IRQ without Superpriority. Moreover, if the GIC is configured so that
@@ -2692,6 +2697,7 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
                                        &acc->parent_phases);
 
     cc->class_by_name = arm_cpu_class_by_name;
+    cc->is_big_endian = arm_cpu_is_big_endian;
     cc->has_work = arm_cpu_has_work;
     cc->mmu_index = arm_cpu_mmu_index;
     cc->dump_state = arm_cpu_dump_state;
-- 
2.45.2


