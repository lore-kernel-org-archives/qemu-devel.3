Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E1C2C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 14:13:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9ldi-0000e4-N8; Tue, 29 Apr 2025 10:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9ldh-0000dO-9a
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:08:49 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9ldc-0006G7-UW
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:08:48 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-39ee57c0b8cso6956006f8f.0
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 07:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745935722; x=1746540522; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1rBTFzGlpmN0XM4Xhc9yiz4Q5nlS539l0QvdyVgqZAM=;
 b=cQpUk0XRCoVg0qk/yrI+21rLGJ5Mhc2s5Mg1MUBD+K4FtYrXRNWpfuPVrMQnRyj3iy
 EHOi+UUhcxbNp0mWKD02CQXR7MezCOXfChRy+zjCeCdNHcVLoRBFO/DAmSncmaSaV6mF
 TXHVMY2J0pqOU+pu4sLKFypztaR2FxsZLcG9XEAk8I7/39EmZlfw0VeTjsC5bd5Ueg2N
 YVo4aXdmf1MTojKReUa6rYan65KjPYdS6EnxzzpAj55kke2V02DWRDyNwQQqzhB7aQMz
 /KHmmNrV7k82doV29k1X2+5P1CuMVsev6sElsHdkc8dhidEk/1lkX+dUYqMF3sgPRLRm
 Te/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745935722; x=1746540522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1rBTFzGlpmN0XM4Xhc9yiz4Q5nlS539l0QvdyVgqZAM=;
 b=qfJaGXuQRc96W8he6XeuDeFnBhJ6sjbRDRTU8l04t7HHa7xC+ZhalHXJ2HE/Bf7pkw
 OVvOy9m755qp2tQfLHsLjE48xLMcl5IcnALNHvaPslQW5bM7pgQPBwx+HljWXyTkjEh4
 9YGHLBnK4h5yuaSMt0s1JmayGpISdpZLeGdFtPYOro80ocg6lDuugLZ9svt92Ba+8Gsw
 lMR45ePLkDFP/1HmvoNjdVXew/ArhDr1evMVuBsBr65Ib8BzbWrycjjof8R+r1l+kVAY
 64ILfmVHM0swSbFjLW5D4L6WkBVH1SxZrDXAPpoqOMXIBRbbUECRsxZ1PoGLBTKQ9L58
 zYxA==
X-Gm-Message-State: AOJu0YxZ2zu5eL4EUux6pw6bmM+24JQn6iYYC9GAnXyFMALMnx+8UbR5
 HDetiDn/zbM6QR6H4+KF/5V23Vv6m1rKxvr6lNjvG2thSgYrH0AIdlhMtMIoITupnQzzAsGH+fr
 1
X-Gm-Gg: ASbGncuw2lxALLZMLrm8SMRzYbcU6cmLo2A/fwOk9bxIeVYR5Mi5n5trcZwS/30joJY
 rdWQ3oSf5jxP6XKJ1uh+cr10B7PeLcgL71M8qyT91CMmuE9pQFLSrH3PLJ9YIEUftgMD2etcY/h
 UfnufhFPJrtjE6Tfn6aWTOnfHl9NHBT8H2uvuvEAIIZxA+POai8CU/Cb2fHlmIFcueGhK3+w/Tu
 dXEy486ucjZGJU5B2vekSF4fCPy+nQolQhkXR/yFv6HUZAXFT1JFh/6xIoJeiGbA8ZYSM04t3RK
 GH+qUXXOBY2D8cuBE4mJfsjtWyVdubmveCl7s3aEmJMpdbMAuvFf4eFkukYowrjcy4hOZctHQ0T
 mEZ3jL+7kDzAH5Cy5IDrp
X-Google-Smtp-Source: AGHT+IFnDrVcedbXHpcglRf3Zfr33IFFYKasSaoLQa9TB96b58tL9E1xh2++cLgtcB9Hp183gOayEg==
X-Received: by 2002:adf:f7c5:0:b0:391:3406:b4e2 with SMTP id
 ffacd0b85a97d-3a0894a17f0mr2414426f8f.49.1745935722255; 
 Tue, 29 Apr 2025 07:08:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073cbedc4sm13721492f8f.47.2025.04.29.07.08.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 29 Apr 2025 07:08:41 -0700 (PDT)
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
Subject: [PATCH v2 03/19] hw/i386/pc: Remove pc_compat_2_4[] array
Date: Tue, 29 Apr 2025 16:08:09 +0200
Message-ID: <20250429140825.25964-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250429140825.25964-1-philmd@linaro.org>
References: <20250429140825.25964-1-philmd@linaro.org>
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

The pc_compat_2_4[] array was only used by the pc-q35-2.4
and pc-i440fx-2.4 machines, which got removed. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/hw/i386/pc.h |  3 ---
 hw/i386/pc.c         | 19 -------------------
 2 files changed, 22 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index f4a874b17fc..b34aa25fdce 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -301,9 +301,6 @@ extern const size_t pc_compat_2_6_len;
 extern GlobalProperty pc_compat_2_5[];
 extern const size_t pc_compat_2_5_len;
 
-extern GlobalProperty pc_compat_2_4[];
-extern const size_t pc_compat_2_4_len;
-
 #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
     static void pc_machine_##suffix##_class_init(ObjectClass *oc, \
                                                  const void *data) \
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index c8bb4a3ee47..2b46714a5ac 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -262,25 +262,6 @@ const size_t pc_compat_2_6_len = G_N_ELEMENTS(pc_compat_2_6);
 GlobalProperty pc_compat_2_5[] = {};
 const size_t pc_compat_2_5_len = G_N_ELEMENTS(pc_compat_2_5);
 
-GlobalProperty pc_compat_2_4[] = {
-    PC_CPU_MODEL_IDS("2.4.0")
-    { "Haswell-" TYPE_X86_CPU, "abm", "off" },
-    { "Haswell-noTSX-" TYPE_X86_CPU, "abm", "off" },
-    { "Broadwell-" TYPE_X86_CPU, "abm", "off" },
-    { "Broadwell-noTSX-" TYPE_X86_CPU, "abm", "off" },
-    { "host" "-" TYPE_X86_CPU, "host-cache-info", "on" },
-    { TYPE_X86_CPU, "check", "off" },
-    { "qemu64" "-" TYPE_X86_CPU, "sse4a", "on" },
-    { "qemu64" "-" TYPE_X86_CPU, "abm", "on" },
-    { "qemu64" "-" TYPE_X86_CPU, "popcnt", "on" },
-    { "qemu32" "-" TYPE_X86_CPU, "popcnt", "on" },
-    { "Opteron_G2" "-" TYPE_X86_CPU, "rdtscp", "on" },
-    { "Opteron_G3" "-" TYPE_X86_CPU, "rdtscp", "on" },
-    { "Opteron_G4" "-" TYPE_X86_CPU, "rdtscp", "on" },
-    { "Opteron_G5" "-" TYPE_X86_CPU, "rdtscp", "on", }
-};
-const size_t pc_compat_2_4_len = G_N_ELEMENTS(pc_compat_2_4);
-
 /*
  * @PC_FW_DATA:
  * Size of the chunk of memory at the top of RAM for the BIOS ACPI tables
-- 
2.47.1


