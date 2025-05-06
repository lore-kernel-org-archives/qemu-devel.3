Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE816C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:41:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJSm-0007am-Md; Tue, 06 May 2025 10:40:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJS1-0006gx-ID
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:39:21 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJRz-0001Ld-3U
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:39:16 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-39ee57c0b8cso5208844f8f.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542352; x=1747147152; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t7YKbHq/LJts8Dl4vIFPRVyvpe2WYzTjo0E70rc+Vt4=;
 b=dvsfjv8yU9V8QDOYHZMMLZytgeHyZOx9QjPDHp9VQUc6GNLWdSPqYDbauPCHDhTL4C
 qcdIhshQq55+d4/G1GesfZor6I30yFfqCZL6WdKttA8PTqvonq0OtaqCREe8IKXx958o
 PsYrsD3QULcG1crg1Tqnv9FfU13m25BwLvg4qPgVIBFcA1/YGPQp4EXm1G6pIDgKs8V6
 V9hMuj7qpN5EYAU2ZdqjAfTSsX+ki1gWkyHuPz0Exqp0tmt48c5+Gg3JllrTIEaJb4Bi
 YbveJUkWFg+RzJwsQaUelId3OmpKdvrrZQiv9jiN40LbltRk1dGwcm1tW3WoW307YSsq
 5inQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542352; x=1747147152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t7YKbHq/LJts8Dl4vIFPRVyvpe2WYzTjo0E70rc+Vt4=;
 b=Qwqb+nyTHpleTgKjY0+IlenGPGA4OWDGetViLqiwfivcK2cFJqRDuYdm5q8E36GCn+
 RYts3PSqSOMNqg7ky2uHSHrKvdXN7n8dwn5ifQ2Bsn1lqbeP2+vaM8qSEs4Hr9TPlpQO
 r0vjQQiQOmmmW4Ds9mD4mzK0S9w3HPuLaXbPflhIDAOQ3fUiRUuRjRdkoEMUkX9h2tVq
 h2rarZA9qEYfSdiY2dHqQhOGZb4kqoKV91T/Z8NNYlNrkF6+pyopu3DT69q91UU4CS8A
 gPt3eMzxARnW/35P8U5YITJfuDYniADPekddUl12LfFOOdjB1UvPyxuEEwLWDNXsSHK5
 QHHA==
X-Gm-Message-State: AOJu0YwXU0n6zeSGAMI+Ca0CHODFWz2OxGy4mf111g/5oL9QWL9awagQ
 /m9vhDuPBemMQ3hR8ojz+jD40KnKQ7/IMRowb1/GPOlrQ2sxOcSThiUWId4qnBOSBht2+xNf9lf
 N
X-Gm-Gg: ASbGncuMfFaqDDp/ia39U+IdhxCeqQrdJMdb8HZ47d6PhLouMMt5GfKd2MXRwubXexH
 W2WRt2K7vqTB0lJSp0ZzVWdwCYFsakUTIa+ujbhO3Pl9qaJNKMxhyptcbiV2pKcys/RURtHazEI
 vxOYv5wDx2blIrvyxU62w9C5KkefTByUUmfqWDgUPZoVMb0bgtGhQA8Ip6zoSiabXlj9nBESUVE
 6E3n6NxDl1EX+Fd3dy6355f1U6mvzL078EL0UuEx/ioH4xZoPMoNd/1zr24XebbFM7BiceeBGUi
 PYR0UjTFsEAsloEIBhTDOZS7wxyuOHtJwSU/ufoYzftHRIpX9yU6U1TCd4TmqyYmmKCnfDQczl8
 4xpjLCwdb4xWgZv7Qq1ZY
X-Google-Smtp-Source: AGHT+IFmq+XZqSsiOz4np4n396oyQeBqPQGtCakGZfIwRLPxccgH+7y7uToOpFDsrM2PfqdfEkaRxA==
X-Received: by 2002:a05:6000:40e1:b0:39c:1257:cd3f with SMTP id
 ffacd0b85a97d-3a09fddf14cmr9646174f8f.57.1746542352423; 
 Tue, 06 May 2025 07:39:12 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae3441sm13696073f8f.26.2025.05.06.07.39.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 May 2025 07:39:11 -0700 (PDT)
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
Subject: [PATCH v3 01/19] hw/i386/pc: Remove deprecated pc-q35-2.4 and
 pc-i440fx-2.4 machines
Date: Tue,  6 May 2025 16:38:47 +0200
Message-ID: <20250506143905.4961-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250506143905.4961-1-philmd@linaro.org>
References: <20250506143905.4961-1-philmd@linaro.org>
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

These machines has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") they can now be removed.

Remove the qtest in test-x86-cpuid-compat.c file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/i386/pc_piix.c                   | 13 -------------
 hw/i386/pc_q35.c                    | 13 -------------
 tests/qtest/test-x86-cpuid-compat.c | 14 --------------
 3 files changed, 40 deletions(-)

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
diff --git a/tests/qtest/test-x86-cpuid-compat.c b/tests/qtest/test-x86-cpuid-compat.c
index c9de47bb269..456e2af6657 100644
--- a/tests/qtest/test-x86-cpuid-compat.c
+++ b/tests/qtest/test-x86-cpuid-compat.c
@@ -365,20 +365,6 @@ int main(int argc, char **argv)
                        "level", 10);
     }
 
-    /*
-     * xlevel doesn't have any feature that triggers auto-level
-     * code on old machine-types.  Just check that the compat code
-     * is working correctly:
-     */
-    if (qtest_has_machine("pc-i440fx-2.4")) {
-        add_cpuid_test("x86/cpuid/xlevel-compat/pc-i440fx-2.4/npt-off",
-                       "SandyBridge", NULL, "pc-i440fx-2.4",
-                       "xlevel", 0x80000008);
-        add_cpuid_test("x86/cpuid/xlevel-compat/pc-i440fx-2.4/npt-on",
-                       "SandyBridge", "svm=on,npt=on", "pc-i440fx-2.4",
-                       "xlevel", 0x80000008);
-    }
-
     /* Test feature parsing */
     add_feature_test("x86/cpuid/features/plus",
                      "486", "+arat",
-- 
2.47.1


