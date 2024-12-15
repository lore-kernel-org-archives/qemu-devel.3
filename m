Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B39A5E7717F
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:17:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMtzx-0002bD-Q5; Sun, 15 Dec 2024 14:09:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtzq-00022a-Jn
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:09:42 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtzm-0001UH-Aq
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:09:40 -0500
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-71deb3745easo616230a34.3
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289776; x=1734894576; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nDIqzhxjX27ujrlP0ogrbhD8JXX/OV81ic1l65WtKDY=;
 b=v6lqW67Jgx6sWTd7FmesBxUDgYUkCoL8befvHfpB0c+zebJnrKXpwzmwbMiSf2QMUz
 RZLDgHtwFHOiYLVkcz+iF4IUBRY5HAqZaA4mHGCW1obt0b64HgF/bpLJpX7CGwvHtli4
 e6MGFKxM58t0/CMZoQk+E77uLnN6Kaq5tIjWCxohjExsWzxJzDZo+NtIw9y/jNj9Zkjc
 rQ0SSpiDdYh6shuESWav9oOgPBeUSv7DfwNE/7kcZ5GdrePRhtaY664sUToG2ro4Ze/1
 XvrcG8pHask+0OzBQww/qhNyzm1UQkL+C43wmBinTIXLRdEZpCmg+HyjYLaCXsO/5bnz
 ZKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289776; x=1734894576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nDIqzhxjX27ujrlP0ogrbhD8JXX/OV81ic1l65WtKDY=;
 b=C2hgK/ceHbJJPEgOMmqMIEMOG/gl4DmoDsJcpdSUPzWGiOgiDfVEY+Ri+4T48uDrVh
 Sgtj8oXc/4eXwyk6hcsH/82xxFeqnyCQh3Z2Hudiag0U52/LniVG9TuDfnKUwXt/kBJw
 dHxPTbgmh8IKhiPEQbzkq/Vz+Z79s2o23lUMf7FYzbKdvt0WigvwuqVazM1+Ek49m7x0
 7pjI64EL7ERnE2FB6D3vda3Ii1LLy9RmkNvmkIuiXfJBgQEjNOeArlK7mJGvBJr9RERg
 7TZa6gANXTxvJM08Fn9mlAi9VSvZfgHpz9PtPxcO14m+GoyxWJBxJUZmLiOO77OaG8K2
 lAZg==
X-Gm-Message-State: AOJu0Ywtt+4s5pKBVm52DaWWnh7xE5LkzJXZziVQaYMDfspK/enQYkxq
 nJsQXsoUbG9RBFigPxzJ8PI170Us59miD2KMJDQaxcwPqt0osa5WAfFMQBm9kVZAvgZ4lCjaV5e
 eZu4zhlz5
X-Gm-Gg: ASbGnctgGUYz79+nwD5U4jJBVq8Yq+2K2t7988N2pPMIWjd5a3wqUE0LGcGMQW3cx7w
 /Weey8kk+4aCKfMlTLXC/8BR3p137pco0Qn3DCr/gsrAVEQkZ33xrAvka1zHkEuxyI0DZrHqgYe
 LdRln/Utb954oLaTbjDs4cwxOGEFcIh2nnJQD/uxNRZMW713YRlyisiftu/7wciK5DRwmuu0Tuj
 Otr9l1zrLz7+4FP7FF5Dg0m00/O9sMOLDM1gIiYPmVRW8ztz2yxu2oH5/ghumG+4K708qI+SYIA
 9+bVgBkqJ6q4No3POkK1dpkOlonPPHPsxNDsxVAJ4XI=
X-Google-Smtp-Source: AGHT+IGLowUD/RQCVv+pN35mQRARNAb6pKBpT1dzVFHohicFrv4NZ2EaBrVRLZI84nhEUsiUKOcjtQ==
X-Received: by 2002:a05:6830:6a91:b0:718:6da0:72b with SMTP id
 46e09a7af769-71e3b84c434mr5638387a34.7.1734289775525; 
 Sun, 15 Dec 2024 11:09:35 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4836f8c2sm1015316a34.34.2024.12.15.11.09.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:09:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 42/67] hw/nvme: Constify all Property
Date: Sun, 15 Dec 2024 13:05:08 -0600
Message-ID: <20241215190533.3222854-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32e.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/nvme/ctrl.c   | 2 +-
 hw/nvme/ns.c     | 2 +-
 hw/nvme/subsys.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index ec75419566..33a3062466 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8927,7 +8927,7 @@ static void nvme_exit(PCIDevice *pci_dev)
     memory_region_del_subregion(&n->bar0, &n->iomem);
 }
 
-static Property nvme_props[] = {
+static const Property nvme_props[] = {
     DEFINE_BLOCK_PROPERTIES(NvmeCtrl, namespace.blkconf),
     DEFINE_PROP_LINK("pmrdev", NvmeCtrl, pmr.dev, TYPE_MEMORY_BACKEND,
                      HostMemoryBackend *),
diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index 526e15aa80..192b80f18d 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -799,7 +799,7 @@ static void nvme_ns_realize(DeviceState *dev, Error **errp)
     nvme_attach_ns(n, ns);
 }
 
-static Property nvme_ns_props[] = {
+static const Property nvme_ns_props[] = {
     DEFINE_BLOCK_PROPERTIES(NvmeNamespace, blkconf),
     DEFINE_PROP_BOOL("detached", NvmeNamespace, params.detached, false),
     DEFINE_PROP_BOOL("shared", NvmeNamespace, params.shared, true),
diff --git a/hw/nvme/subsys.c b/hw/nvme/subsys.c
index 77deaf2c2c..3171c3888c 100644
--- a/hw/nvme/subsys.c
+++ b/hw/nvme/subsys.c
@@ -216,7 +216,7 @@ static void nvme_subsys_realize(DeviceState *dev, Error **errp)
     nvme_subsys_setup(subsys, errp);
 }
 
-static Property nvme_subsystem_props[] = {
+static const Property nvme_subsystem_props[] = {
     DEFINE_PROP_STRING("nqn", NvmeSubsystem, params.nqn),
     DEFINE_PROP_BOOL("fdp", NvmeSubsystem, params.fdp.enabled, false),
     DEFINE_PROP_SIZE("fdp.runs", NvmeSubsystem, params.fdp.runs,
-- 
2.43.0


