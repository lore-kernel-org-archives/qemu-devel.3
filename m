Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D36E6C3ABA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 14:15:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9lda-0000XU-Gl; Tue, 29 Apr 2025 10:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9ldX-0000Ti-5M
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:08:39 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9ldT-0006Dd-IB
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:08:38 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3912fdddf8fso4533615f8f.1
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 07:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745935712; x=1746540512; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nr7yCouV+uxMprE88tWLr3G085FcChByOcq/6H66h8U=;
 b=Uk7DFXXc5PmobtU4sF1Dk9QMcVJ6cyESFGpYAXzWLEYMjWlhDsXelSDSibeqQU85u4
 S4TANXGpBFXMONucS3/rXmRXhHS/MZ4pK6DLHvoW7L9Xnx06Unlf6Iix+Uh+E9v6Ot4j
 2n4LXKorQAmkGz2/tESeI+XlE3bNQKYfuiMEPgIAkaJzwOFTXi8P3hG3JQOSxyaQPJ71
 0qKASg5o5vKr36vsMQQ2Uqas+1JLaizT3Ns7m754NBh7oWU3iNPJFUApYF9Pea3HsAWV
 bqicqbNKMTaUM5eIdIN83tVOHo/WFy3ggC0+Np95dhNxgIcW5qAsM6HdcsH8MjxAJQEY
 CxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745935712; x=1746540512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nr7yCouV+uxMprE88tWLr3G085FcChByOcq/6H66h8U=;
 b=YPO/wYAOydWFP3y8W6O1Ixaj82IgqYnp0AllC6m+hHhgyFlZJUDhQE34jFozCrD0q0
 q31BHxft2jw4vmR1XEMrRWQ+1e4Ia8O1sk4ge4F8AeRHe+JiJYYVo1O9SqWlgKM9S2Vr
 f3Ejzg24h3PMKn2AOLdOhggc9L9iw9fD6FY0T7maxohXKnVjaxCXaQ3ft/NZne835Nkt
 C7uIGyRxaevWGAIwhTdOwvKdXGsyLWdd1LjgivtTqF7GaRJsvXyg7zsEwvInSjBvHZVt
 Xk1Ec6EQhWqeTfmdRgHVCShWEEd9tHT76ScrlVjxtYaI0ghQcr+1L9m4O9SIxJchSvwr
 E1rw==
X-Gm-Message-State: AOJu0YyMyzC8kZGtdILNfo5EwoNNkw0P49olz+YkKssdplWX1SmSxEI/
 +LC2E9zPDpnSsVnmsq/mHbSq6BNHaRiQtlDDrAq7gmoIDxN9a4z+vD/O30V2cg2gIQSmeTdKTJ5
 J
X-Gm-Gg: ASbGncvOr3p/h+UvkL7F17dwdV7ONrS8LaGjWQuRvfUJ/iycjBqYpexrihyVxSslSKE
 1ZDv6qhpPgIV9yr6rO6bsryoco5NSHAcduDpprGDVGpdax5mM/kKy2g3PcxdmtFb7TfySJpreYH
 yuaIUGLM/pzX2ZsNJdEMPMICn6myHpL+T81dGzeAgt9sKO0btf9/buROyKvdYCoBgfkz7oTrCsa
 NzCeh6CphAfpMtoJCjiwPmcVO9Z13B9x6itC7fNa65yTpFQoEGitrGWycybC62XjtBYitI1CnFR
 49m5apM3umhM6VuCPCHRlwfVKaLlPz40IXcWg8iZiS666ore4yS2aoYtyJ09etxF/60kLvranPX
 vwVjNIg5xv+hPxIf8GOsQ
X-Google-Smtp-Source: AGHT+IGa4UVSXkeUt3y53K1WAL1xW9fIP8sPyPpScSQA4plpTkHdn4UnKEotXO2gSmxwHyHUTBrDNQ==
X-Received: by 2002:a5d:59a7:0:b0:39c:30f7:b6ad with SMTP id
 ffacd0b85a97d-3a08a520647mr2915829f8f.18.1745935712417; 
 Tue, 29 Apr 2025 07:08:32 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073ca556bsm14155091f8f.37.2025.04.29.07.08.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 29 Apr 2025 07:08:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 01/19] hw/i386/pc: Remove deprecated pc-q35-2.4 and
 pc-i440fx-2.4 machines
Date: Tue, 29 Apr 2025 16:08:07 +0200
Message-ID: <20250429140825.25964-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250429140825.25964-1-philmd@linaro.org>
References: <20250429140825.25964-1-philmd@linaro.org>
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

These machines has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") they can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/i386/pc_piix.c | 13 -------------
 hw/i386/pc_q35.c  | 13 -------------
 2 files changed, 26 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 0dce512f184..04213b45b44 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -791,19 +791,6 @@ static void pc_i440fx_machine_2_5_options(MachineClass *m)
 
 DEFINE_I440FX_MACHINE(2, 5);
 
-static void pc_i440fx_machine_2_4_options(MachineClass *m)
-{
-    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
-
-    pc_i440fx_machine_2_5_options(m);
-    m->hw_version = "2.4.0";
-    pcmc->broken_reserved_end = true;
-    compat_props_add(m->compat_props, hw_compat_2_4, hw_compat_2_4_len);
-    compat_props_add(m->compat_props, pc_compat_2_4, pc_compat_2_4_len);
-}
-
-DEFINE_I440FX_MACHINE(2, 4);
-
 #ifdef CONFIG_ISAPC
 static void isapc_machine_options(MachineClass *m)
 {
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index c538b3d05b4..47e12602413 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -685,16 +685,3 @@ static void pc_q35_machine_2_5_options(MachineClass *m)
 }
 
 DEFINE_Q35_MACHINE(2, 5);
-
-static void pc_q35_machine_2_4_options(MachineClass *m)
-{
-    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
-
-    pc_q35_machine_2_5_options(m);
-    m->hw_version = "2.4.0";
-    pcmc->broken_reserved_end = true;
-    compat_props_add(m->compat_props, hw_compat_2_4, hw_compat_2_4_len);
-    compat_props_add(m->compat_props, pc_compat_2_4, pc_compat_2_4_len);
-}
-
-DEFINE_Q35_MACHINE(2, 4);
-- 
2.47.1


