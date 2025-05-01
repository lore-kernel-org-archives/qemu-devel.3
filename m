Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3827AC3ABAA
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 18:40:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAYok-0003EB-NS; Thu, 01 May 2025 14:39:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAYnX-0001B5-Qz
 for qemu-devel@nongnu.org; Thu, 01 May 2025 14:38:15 -0400
Received: from mail-io1-xd29.google.com ([2607:f8b0:4864:20::d29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAYnW-0008Fw-2O
 for qemu-devel@nongnu.org; Thu, 01 May 2025 14:38:15 -0400
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-85de3e8d0adso31612839f.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 11:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746124692; x=1746729492; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZeBP6SMx5HnWyi7uG5Jn5cSUUcBtF9s2f1+jGOqbmJs=;
 b=Ba+PDTxDjB5Pf1sFZBTI2oJqVxnYTTTXDXmewb8BqJFT9RvYvizs4xjKzIrVm6xCs8
 kPG34otRFOlDfYX6D/ft69djf4RTRJA+WBWAxHgGR0rXPXMvbRhuyrtmLL2vQ0gL+Erl
 yQP4czC/kh0klie7h27XNNIIEL0BWNfAxjr2TbqOoddlbzC9j7JoXm61nTk+vNPcGe+o
 EjhwJ8T+7h6lC0+jyTb4jPD6sqPsl4540BvhWrvalY/H6l1t6ZzkXjIsFHihQIWTTDcM
 g/ORgPMm/uxf3OpRZcw/Z8dFhJNVezQPHY2nKS27XjzB3p7dPGFCUsvtovLb0eCCPV2E
 Y0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746124692; x=1746729492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZeBP6SMx5HnWyi7uG5Jn5cSUUcBtF9s2f1+jGOqbmJs=;
 b=Czp/GQeBsDuE8a5AxupVZKXbio/lZ1vC+HibXnBPDjhd8VKDnbWFHGCczPPyVyVJlY
 fyOS46Hr21BYfVnzaKGA23HGqOT5ZLQgeIOQ0H5NpwdSrYyBsMLkwAtsOL04PUEtGYKb
 1nS2duywM/DtBkcC0g/vncU9ol21EXQrmOcMXQfgw+A7PwtwZ/nFAObtYQ0AulRACCGP
 jgyvuZQZFVNtmtSld+jhAAg/o0IA4wowL1ghd7EUrveQn+PIyPg8qKaZZdQr2QWKNLN/
 LSGZWdkuZSALaXPHOfKAFqVR/nhvvl9wgxLpIwo+JkAXX/zIpIlgoGyY3KKXNISkv8wg
 0cpw==
X-Gm-Message-State: AOJu0YzU6VKjGp4sdwMjJYmRrk8JwOUyak0gy1pdEJtQGRV5h3IQ6uDp
 ZkVB+u6Pb6TUMndxamb51XXSuWNronq/VpZfYPKZL9LGSoCU7iN56RgnoaCYWfV4PXtin6zOnLd
 a
X-Gm-Gg: ASbGncuzZa8qtyPi4ITFGyOyTctB9nAqPTQ6WgZWIIXpZkA9CJ1+wG0be6ewm/Fl1Yv
 WaPIcFvkD4D0aNyfWSyC15MLx98GmBUFtvI1dZSOyyVb82dx72YpNeOxXhWzWpEk2xUHsvETcK6
 W8NO5vhsTP65s2hRzzY45JxsUZePomx3iqCEZ2daqD4OqIEfgMyjT2cU3K5AMtZGkQNs12gaVCK
 Jlpe88Waj2OY3K7RwbdcBUEkoZ5D2AqMiTMC345ZOG8syZjWbd001KmN7EbOXYD8FSCZVhVq6+B
 J0hySzeGger1x6xZUT62vLAiCdfiplUNync3CbCm8vjc+vh8Vj5tMol+LhM3TYuHtheX/t+GCpi
 hGx9yBiX2AsAkfVH7LD03wT7Z6vkO1Qo=
X-Google-Smtp-Source: AGHT+IE3BUgksOVi+kqWOWHw9l86MQT2SOl30YQrrBZN8TQXLLk74sy7jedFfndCuzCVknrjUW7FLA==
X-Received: by 2002:a05:6602:401b:b0:864:68b0:60b3 with SMTP id
 ca18e2360f4ac-866b42504e4mr37684339f.12.1746124692487; 
 Thu, 01 May 2025 11:38:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f882eaee47sm306869173.2.2025.05.01.11.38.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 May 2025 11:38:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Yi Liu <yi.l.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Amit Shah <amit@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 11/16] hw/core/machine: Remove hw_compat_2_7[] array
Date: Thu,  1 May 2025 20:36:23 +0200
Message-ID: <20250501183628.87479-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250501183628.87479-1-philmd@linaro.org>
References: <20250501183628.87479-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d29;
 envelope-from=philmd@linaro.org; helo=mail-io1-xd29.google.com
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

The hw_compat_2_7[] array was only used by the pc-q35-2.7 and
pc-i440fx-2.7 machines, which got removed. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/boards.h | 3 ---
 hw/core/machine.c   | 9 ---------
 2 files changed, 12 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index a881db8e7d6..77707c4376a 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -838,7 +838,4 @@ extern const size_t hw_compat_2_9_len;
 extern GlobalProperty hw_compat_2_8[];
 extern const size_t hw_compat_2_8_len;
 
-extern GlobalProperty hw_compat_2_7[];
-extern const size_t hw_compat_2_7_len;
-
 #endif
diff --git a/hw/core/machine.c b/hw/core/machine.c
index ce98820f277..bde19a2ff67 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -266,15 +266,6 @@ GlobalProperty hw_compat_2_8[] = {
 };
 const size_t hw_compat_2_8_len = G_N_ELEMENTS(hw_compat_2_8);
 
-GlobalProperty hw_compat_2_7[] = {
-    { "virtio-pci", "page-per-vq", "on" },
-    { "virtio-serial-device", "emergency-write", "off" },
-    { "ioapic", "version", "0x11" },
-    { "intel-iommu", "x-buggy-eim", "true" },
-    { "virtio-pci", "x-ignore-backend-features", "on" },
-};
-const size_t hw_compat_2_7_len = G_N_ELEMENTS(hw_compat_2_7);
-
 MachineState *current_machine;
 
 static char *machine_get_kernel(Object *obj, Error **errp)
-- 
2.47.1


