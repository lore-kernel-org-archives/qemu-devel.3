Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0103BC3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:46:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJWA-0004Xy-P1; Tue, 06 May 2025 10:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJSj-0007aV-81
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:40:02 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJSg-0001Yk-CO
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:40:00 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-39149bccb69so4504843f8f.2
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542396; x=1747147196; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q1RXK9TNZCyuKZFLBANjjuVrJLcCqvX//mQ8ZqVm0L0=;
 b=lPIn0sznahDZDDe7BYqabLiBKAA9ymwoqngRDLGU8Lo3V0UQEcTAoz/TbMOypck8h9
 SKHlX4DnNSARGTpzXc7X/5lYJy0UANPlMj7jgv0+Hlzd2Pao0NnT6Zzeo/vWpaTxnfRn
 7/9OtU7kdRjrBvOFYwM4PD+pKqRDLr2eT2z77LJu+nzl6besAlNDSNKmcucl6HWgolK3
 277Fhb9uHUbDNEuqG+i9CFZetwFoer2GvEPtzee0Rb6m2gLwB77fOMtwVmm+XjGtMQjU
 pOR47P5IqZv0yULdjrdskkP+AjXE/Unx7WwpFtA/0l2JXacw5WeAIcrY+D1ud3S36TGz
 X2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542396; x=1747147196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q1RXK9TNZCyuKZFLBANjjuVrJLcCqvX//mQ8ZqVm0L0=;
 b=LoHlU/YkEZ2hU1H3IbKTvyHqIIsLijx2+daCkHgMX9fnV2LjBPuU5KeRv6V05guySg
 T/yahFave8nLQFKS+fgouV0UCZOBzptUOibxetxqU/6C7VeezQ+F9dHhvg1+DSLIPfd2
 ohAwDdI0lYaaXkMCbWYS1NID2QI4it/BX7A8qy+ffIP/HaPcRiBoVfaoPdXFgFheD8mC
 LyL06tdVgLXR7vp9MnVjGxd3NzVUrP1ikPajbWE8P9ztcAibra3mSsPOouIesSKefahm
 6m/N8vrnXx4ywVzWLzFnPAFT7LwytOPN1dUu+mg1YVgv8FromokZpdf15j5yzKZd9666
 Gxig==
X-Gm-Message-State: AOJu0Yz8yeJsst5wF1UOtK/sbYcS19mxN+/4bNuWcKipGzbHRJKuGIYM
 LoatlmFew3ngcmcfiArNKcoNWmJTmkHjByuwmsvWWPTV+xfIn2LNxGJtmmqcG+QjQg+8JdjyOuJ
 h
X-Gm-Gg: ASbGnctTQ93OqybAq+4hMEQPzZk4bCDzgbhSvFNEy++/bRFBAuVKPrV6EllhnblxheU
 FpqQwJ4uiAyAqaOO2+j35Y36tg9hN+LVih9/OFjEzw/whpVQAxx8qJoZBX9otpyKttpWTiwyt0x
 ds37L5wgxtuqpN5RFihkuV/EaBJKX1XtPqLV3cqWPPisQIezFUK63oLOquUjrpihDpJ/AezC9ld
 jtlGckbpZ52vIItop6OhQdj5XzH8dYL9d3y16rywY+0khTEBn+XJiFwocGWjMI+NiqsHQ/e8Xhr
 GG5eAGcK1+bCkQVCLz7EbNATJU9wLHM0ZPjBj3ZVCb7A0YYTt8WD8IktP+MYZc4Q+SUsyIwNKWe
 l4oMX+7GQxKeYgcIMeLCL
X-Google-Smtp-Source: AGHT+IERyC0ULigXCVdHbeKVZ0qq8iqab9YgQ8oItk0SniydPvtZ5WXB89avLZL/ZEmQSdcPWbu1iQ==
X-Received: by 2002:a05:6000:200d:b0:390:e62e:f31f with SMTP id
 ffacd0b85a97d-3a0ac0cb822mr2943505f8f.3.1746542396130; 
 Tue, 06 May 2025 07:39:56 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099b16f9dsm14155699f8f.93.2025.05.06.07.39.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 May 2025 07:39:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-block@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, John Snow <jsnow@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 10/19] hw/i386/x86: Remove X86MachineClass::save_tsc_khz
 field
Date: Tue,  6 May 2025 16:38:56 +0200
Message-ID: <20250506143905.4961-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250506143905.4961-1-philmd@linaro.org>
References: <20250506143905.4961-1-philmd@linaro.org>
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

The X86MachineClass::save_tsc_khz boolean was only used
by the pc-q35-2.5 and pc-i440fx-2.5 machines, which got
removed. Remove it and simplify tsc_khz_needed().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/i386/x86.h | 5 -----
 hw/i386/x86.c         | 1 -
 target/i386/machine.c | 5 ++---
 3 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index 258b1343a16..fc460b82f82 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -27,13 +27,8 @@
 #include "qom/object.h"
 
 struct X86MachineClass {
-    /*< private >*/
     MachineClass parent;
 
-    /*< public >*/
-
-    /* TSC rate migration: */
-    bool save_tsc_khz;
     /* use DMA capable linuxboot option rom */
     bool fwcfg_dma_enabled;
     /* CPU and apic information: */
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index e2d04092992..f80533df1c5 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -382,7 +382,6 @@ static void x86_machine_class_init(ObjectClass *oc, const void *data)
     mc->get_default_cpu_node_id = x86_get_default_cpu_node_id;
     mc->possible_cpu_arch_ids = x86_possible_cpu_arch_ids;
     mc->kvm_type = x86_kvm_type;
-    x86mc->save_tsc_khz = true;
     x86mc->fwcfg_dma_enabled = true;
     nc->nmi_monitor_handler = x86_nmi;
 
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 6cb561c6322..dd2dac1d443 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -1060,9 +1060,8 @@ static bool tsc_khz_needed(void *opaque)
 {
     X86CPU *cpu = opaque;
     CPUX86State *env = &cpu->env;
-    MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
-    X86MachineClass *x86mc = X86_MACHINE_CLASS(mc);
-    return env->tsc_khz && x86mc->save_tsc_khz;
+
+    return env->tsc_khz;
 }
 
 static const VMStateDescription vmstate_tsc_khz = {
-- 
2.47.1


