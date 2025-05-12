Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C130C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 08:42:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEOjW-0008Sq-BP; Mon, 12 May 2025 04:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEOiP-0007QN-L6
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:40:52 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEOiK-0001jf-3A
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:40:46 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-442d146a1aaso38305325e9.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 01:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747039240; x=1747644040; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dgVjgshxMDRG01s8Sek8b5MTSBVel00zSJP/aBMNpxE=;
 b=KzPhWzu53tqJBMggcxvdvwBTarACrw0DanT/WZSyZFaeKoKXgmtwWYbIcNSedFmBBV
 p4gVmBFCQ+krS0zi2wcUL+RdkEZ1Lurq3Rzq3/lErQ8x3bZCoHhpWfX52S6xNUAKayrQ
 3NvtvbO/9CYNOM7ySgk0A6rLFOd0IXx43JOu03Jk7qdCgNLr1aEaHc03HblP1CcpHyzb
 MrEuYj2QXALqh0FHAcR5/G7LAm50lZ6sjz8o4fJO8yQluxkzaRLSJRu1KxF4kIJTWwnE
 bCAAoS0RtL+ObMk/+llGvHWA1XzucnTpkUABRkm8liaVbxDcDo/sGjK/SESHiu8NsKbK
 ORiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747039240; x=1747644040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dgVjgshxMDRG01s8Sek8b5MTSBVel00zSJP/aBMNpxE=;
 b=mkKUhDUllwgFqSZkAV3/5GkxM54BFKjKQSJeicvIgLpdWZddQkIjQldn4xonHOgOuz
 agszDgSIBJif1VeV++LBZVAtp+RH12D8yp7fsgTrO0tKU3sqZRfL5fusmyOo2ZJ3MBGK
 9iBoeaOE08Pf9/bAwUv4t5L1YpTah4IaAouE0J3Agyn8gYN1iY8a5QB4/Zygwb4nCZPx
 1JJt8wigKOQqek1zEptWw6UvsNQ5aJOfTX6qKoOs+8o7OEPp+8IbUv+P4pIQ3GoYrCgo
 Ur7BDf/3AIv3AR0vhQwzEiA1tpieZVgD00tUqlp387L7rcNzJJi60zHSVNP3XRGMVu8w
 y3Pg==
X-Gm-Message-State: AOJu0YzlvrgxSVLSPz7jE7+wEBURarWzej142j10/G8RSZtYsxGsBVkS
 MKEc6JAoI26S908KhHd39Arsixylt9aAyBpzsh8ySddIymw7rgsYUn9A9iBSaYFo9Bz/T5qkxm5
 L8BA1vA==
X-Gm-Gg: ASbGncs+2OnwIjB56iLLrLft+95dPFDWKk7+8Nw2HOOeijf7T5zFsf0d+G1Hhu/qGFX
 8e9/C18IPmTS63ElLLxujzeAmsRwB4br45O2s2qMy5aapsORDZHy9q0ZUSEm177reMJkSkj1lU7
 gKXcBm3m+qN41tRuYgtzIxYJZFMWQLjARBid5islo7X1fghbOzBHdaEtqSlTMWrnrNt4qpNO0mq
 ZFdUsgqdLBmpDeqf5vgDHNQXzzxEAlaCmXXDGEGqiw3WqHblxopfH6t5apBLD3b6d2Wjgtk03EI
 7PhwWSKZXGpjtY2PUVlyGCGAHX8L2uYCqiJlXxSTvTVLMOMhjHzZx+O8nHn4UTsV9mrQi7QQC5m
 u/tGhdcSPaKMxq+yUfHEOHQ0=
X-Google-Smtp-Source: AGHT+IFhAmWfLlhHCMEKog9+mMsGFZRlWrFB7zf4CUDzkCuiVgu6b4RKfORSAw/IT87EK97rH1fYsg==
X-Received: by 2002:a05:600c:820e:b0:441:b3eb:574e with SMTP id
 5b1f17b1804b1-442d8ffb0c3mr90500265e9.5.1747039240419; 
 Mon, 12 May 2025 01:40:40 -0700 (PDT)
Received: from localhost.localdomain (129.163.185.81.rev.sfr.net.
 [81.185.163.129]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442dc6f1a51sm84734705e9.22.2025.05.12.01.40.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 May 2025 01:40:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Hanna Reitz <hreitz@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, John Snow <jsnow@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 05/19] hw/core/machine: Remove hw_compat_2_4[] array
Date: Mon, 12 May 2025 10:39:34 +0200
Message-ID: <20250512083948.39294-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512083948.39294-1-philmd@linaro.org>
References: <20250512083948.39294-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

The hw_compat_2_4[] array was only used by the pc-q35-2.4 and
pc-i440fx-2.4 machines, which got removed. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 include/hw/boards.h | 3 ---
 hw/core/machine.c   | 9 ---------
 2 files changed, 12 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index a7b1fcffae3..03e7cbeae82 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -866,7 +866,4 @@ extern const size_t hw_compat_2_6_len;
 extern GlobalProperty hw_compat_2_5[];
 extern const size_t hw_compat_2_5_len;
 
-extern GlobalProperty hw_compat_2_4[];
-extern const size_t hw_compat_2_4_len;
-
 #endif
diff --git a/hw/core/machine.c b/hw/core/machine.c
index ed01798d37c..d66b02b564c 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -292,15 +292,6 @@ GlobalProperty hw_compat_2_5[] = {
 };
 const size_t hw_compat_2_5_len = G_N_ELEMENTS(hw_compat_2_5);
 
-GlobalProperty hw_compat_2_4[] = {
-    { "e1000", "extra_mac_registers", "off" },
-    { "virtio-pci", "x-disable-pcie", "on" },
-    { "virtio-pci", "migrate-extra", "off" },
-    { "fw_cfg_mem", "dma_enabled", "off" },
-    { "fw_cfg_io", "dma_enabled", "off" }
-};
-const size_t hw_compat_2_4_len = G_N_ELEMENTS(hw_compat_2_4);
-
 MachineState *current_machine;
 
 static char *machine_get_kernel(Object *obj, Error **errp)
-- 
2.47.1


