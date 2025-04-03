Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15508C3601E
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 15:19:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0MLx-0007nU-3G; Thu, 03 Apr 2025 11:19:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0MLW-0007iF-Pd
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 11:19:12 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0MLU-0000U3-Iy
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 11:19:10 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-39c31e4c3e5so464166f8f.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 08:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743693546; x=1744298346; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tqcs/vjgWLBfW1Dulxq85k2YfPnbkRu1MyFMZFId7I0=;
 b=neEa2zC9Bn3KBmki588AAoRo9zJLvC4EMjP7kyYHothOaLNbmd7YNfE9sjq/A1D26l
 NPX2q3XfarvVOr+R4+cF+ZwqaFst9lJIhB7jUzd8alNn0USHYyvy7lo8q2qL3NLnJgsO
 gFyGSDdvi/W420Oc1j79mauwGpCSnnUdDNFIdooiB8QdzjI4fgjNu+vLyaVbTX4YeDZD
 r6se2gc58z2joHuVmqEaFiVa3rmroXRg4WOz1Nla1TXdqxVQf7Rwp8tuJc95KKmkxf9W
 w6wOH7HMAFitmXSr+e8LoBrem15AwryQ0WS/NjzH3GBIyeExDnh8eHfaVNi3KBnQ/qr6
 0Q/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743693546; x=1744298346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tqcs/vjgWLBfW1Dulxq85k2YfPnbkRu1MyFMZFId7I0=;
 b=hWEhCsPCzqxTGt1NqEqWIM7+3sN+kBvSdv3MGLaH2jfvC91J/LFyCwuPx4k7JQ54Mn
 1SJFDvGJJKGCvCn1MV0gzbXYSnOWDPcu7ml1EKSmIWB4ydOT2nM6bNWKhTymkJbEK483
 BrAp+IevqiRh6zNF9cusT9QTNN/HnV37APDVQLSkqymT5UeKCzegTiQ6zaKIr3828xqK
 MUUPOlA2CiIh3zbApKTRPkLB+nLLZ/MhkYfCtHevu/CwEECv4BnW09ex7yk/7iUZIhwl
 JmdXNUhkj7ark61sqcKqieS4x8AB7DoQLcjeBICDMfQty0wBYerle4DT9x/LOn57xe8+
 d7ug==
X-Gm-Message-State: AOJu0YxI0DxzdmRmH86m30ivPkbVjP2Clo6HszssK9y66RwweEr5CObS
 564Z6nEj92uerPi/YMwaO345yFXiLvH3eyxlCgY5t+O11E2JNssZInSMpP3wRqRUoWdRWlF5ZTK
 n
X-Gm-Gg: ASbGncukU/EWQ7nBO+DCR9MbAl1TI1Zrve9kNH25oZmuVpbJG1nOj5zzg7SAPu0VZoD
 fLkZ1h2VSI51TNH+cyEV9taqjfNvLEOVzXeQvforz10hI0MW6qJa7OA9sSnviUWeBNWVC7gLSAY
 5ZLpJAuKgvvwdXBxeaQZUO8Hl0KWZRYKdTIVV36O/e6ylBy0Jn32bRZgorXRtomRK5zNyPBMe1Q
 2JBKztdIDRD1yo7rsy9w46078yKUr/DsSU3dQCJdWuEZpnGWO7PtC/sEhpgRSOQbukVBWWVWwBr
 lRAfT6JpctWk3faYRTgN3/acHXsa0s4BNAkuYV+NVSzZspmaCHNBCCsZK1qL6kmHDBD1HUKt603
 F3T6AVlHYb8+mdNRdEsI=
X-Google-Smtp-Source: AGHT+IHM79vtkBMKrwSvTmbPoS3xdbBc/Ee74rmGb2o5mNZRfJz4rqKPJA31jHQP6Eldgb+r8LRRLw==
X-Received: by 2002:a5d:5886:0:b0:391:43cb:43fa with SMTP id
 ffacd0b85a97d-39c2f958db2mr2877374f8f.51.1743693545912; 
 Thu, 03 Apr 2025 08:19:05 -0700 (PDT)
Received: from localhost.localdomain (145.171.88.92.rev.sfr.net.
 [92.88.171.145]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301b69c4sm2040603f8f.43.2025.04.03.08.19.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 08:19:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Udo Steinberg <udo@hypervisor.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>
Subject: [PATCH-for-10.0 v2 05/14] hw/arm: Do not build VMapple machine by
 default
Date: Thu,  3 Apr 2025 17:18:20 +0200
Message-ID: <20250403151829.44858-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403151829.44858-1-philmd@linaro.org>
References: <20250403151829.44858-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Unfortunately as of v10.0.0-rc2 the VMapple machine is unusable:

  $ qemu-system-aarch64 -M vmapple [...]
  *** Terminating app due to uncaught exception 'NSInvalidArgumentException',
      reason: '-[PGIOSurfaceHostDeviceDescriptor setMapMemory:]: unrecognized selector sent to instance 0x600001ede820'
  *** First throw call stack:
  (
    0   CoreFoundation          0x000000019c759df0 __exceptionPreprocess + 176
    1   libobjc.A.dylib         0x000000019c21eb60 objc_exception_throw + 88
    2   CoreFoundation          0x000000019c816ce0 -[NSObject(NSObject) __retain_OA] + 0
    3   CoreFoundation          0x000000019c6c7efc ___forwarding___ + 1500
    4   CoreFoundation          0x000000019c6c7860 _CF_forwarding_prep_0 + 96
    5   qemu-system-aarch64     0x000000010486dbd0 apple_gfx_mmio_realize + 200
    6   qemu-system-aarch64     0x0000000104e6ab5c device_set_realized + 352
    7   qemu-system-aarch64     0x0000000104e7250c property_set_bool + 100
    8   qemu-system-aarch64     0x0000000104e7023c object_property_set + 136
    9   qemu-system-aarch64     0x0000000104e74870 object_property_set_qobject + 60
    10  qemu-system-aarch64     0x0000000104e70748 object_property_set_bool + 60
    11  qemu-system-aarch64     0x0000000104e69bd8 qdev_realize_and_unref + 20
    12  qemu-system-aarch64     0x0000000104e258e0 mach_vmapple_init + 1728
    13  qemu-system-aarch64     0x000000010481b0ac machine_run_board_init + 1892
    14  qemu-system-aarch64     0x0000000104a4def8 qmp_x_exit_preconfig + 260
    15  qemu-system-aarch64     0x0000000104a51ba8 qemu_init + 14460
    16  qemu-system-aarch64     0x0000000104f7cef8 main + 36
    17  dyld                    0x000000019c25eb4c start + 6000
  )
  libc++abi: terminating due to uncaught exception of type NSException
  Abort trap: 6

Disable the machine so it isn't built by default.

This is tracked as https://gitlab.com/qemu-project/qemu/-/issues/2913

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configs/devices/aarch64-softmmu/default.mak | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/devices/aarch64-softmmu/default.mak b/configs/devices/aarch64-softmmu/default.mak
index 93f4022ad62..ad8028cfd48 100644
--- a/configs/devices/aarch64-softmmu/default.mak
+++ b/configs/devices/aarch64-softmmu/default.mak
@@ -9,3 +9,4 @@ include ../arm-softmmu/default.mak
 # CONFIG_XLNX_VERSAL=n
 # CONFIG_SBSA_REF=n
 # CONFIG_NPCM8XX=n
+CONFIG_VMAPPLE=n
-- 
2.47.1


