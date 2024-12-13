Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28CE3E77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:37:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMBO0-0000AE-GR; Fri, 13 Dec 2024 14:31:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMBNj-0008WN-8b
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:31:26 -0500
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMBNh-0004Ke-7T
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:31:22 -0500
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-3003d7ca01cso19830361fa.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734118278; x=1734723078; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D9NZJMUMihYF2f/RMgHkdbty8GjEbXThSHvmpYC5Oh8=;
 b=tREhw7sqW9nyi7zhpSA1DDgbgdWxy0FYnor4UnB9kghH3+JUMN66XYDvSlrplcvsze
 PUZJTfsGS3DfaJfruj8k1m4dgVB/qxuuBZIb/EOVVxCVvs98gry09jHJ6plofKTmLHmw
 T5cJP5hpTKHyF6UDDcBwV/zB3l4C8uE1CQhV1nmqu2oqq/NxijpWaTWOxsSbgrQof/8L
 r+/jdjMqn29dqE/qfuV+OLzMTjbWcInmWoqeevy3dVSAw9swaZ29kI7bPvLf4gUiOyCa
 Izgxus521KlhugtfbIY81BwoXVEWtVzH+hEPLt/5G5xWgZhnPzPWT3i5Dkt0/fSt9+d7
 7a6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734118278; x=1734723078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D9NZJMUMihYF2f/RMgHkdbty8GjEbXThSHvmpYC5Oh8=;
 b=J8iYRhwnXkV/yzB5B3kLkBDNGMPD5mCemCK9LONuEEm1OxyNXZKLD4W01kH1aBo2vi
 kjmpP5yBEiB9zpmQxtJX/uWs/92CWCn5a5xTcXzVVjFwewFbJu9YuY21NPOxdwOu5k5F
 vTMDalc7LFS3AuGt1gfhzzTGD4GwuJ0fg71yAFJl3rVBwiMdzYLcluLHL7b/y7sOiTok
 azW3Uf49jUt5031hDvQzgO02nZAI31L7/kDOaw06uN09oh+AqasAtFlYy7ijZloZ5VBo
 do4I5greqQz9csp/RvLtDbBIC4tEQHwj2KLpMvE90MPigFg1a4AzzbCd/YiPPMkgMKyd
 vk7w==
X-Gm-Message-State: AOJu0YzC56+CriHv7r6BJaX5S99XcM6baoTpAqlw0PFieME7hQBOpF3Z
 Qn+Y++sIS7HTkHDG1rwHJCGGaP3I12PWxd4GLu8e8NV7GniEkgUQc4f/IWrDr65ayE1O6offK9F
 TFITpTcSJ
X-Gm-Gg: ASbGncuBQ5i21V5itmyj9HpaEDmefxmdIS5Mtv7rrH5kkvPujpObgpy/E/o0Ies2S3y
 +swlCCZHXwnAwKuFAY4iJxql7NOc2pcioBBCMEXdD2cfDdmyew1KJrEU2u5q5LC2KXVxD8JTcjL
 ROZgDQx2n0qCg0NauybrFSfVyDvD+IX9RTsL9Lg3TY3CuTw6Y5HN4SOQKfeY6qIG3AAa3Szm0BZ
 uPQzJRpV7CitspIfPAsv8ZkX7PAt2rkutr9CGFNmbgxI8t9dIlF8D1Rs4X0Zg==
X-Google-Smtp-Source: AGHT+IEMNKkQnrRflo+yxGeX4qGXLN4U0wyX2tu5dVCJqJyfEoB7JGYnONT272yxGUDy9/0Yk6qcCQ==
X-Received: by 2002:a05:6512:3a91:b0:53e:37a5:4cb5 with SMTP id
 2adb3069b0e04-5408bcc53f3mr1536668e87.4.1734118278231; 
 Fri, 13 Dec 2024 11:31:18 -0800 (PST)
Received: from stoup.. ([91.209.212.67]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54120c204ebsm6723e87.250.2024.12.13.11.31.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:31:16 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 71/71] docs: Constify all Property in examples
Date: Fri, 13 Dec 2024 13:31:04 -0600
Message-ID: <20241213193104.2515757-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213193104.2515757-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
 <20241213193104.2515757-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x22b.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/devel/migration/compatibility.rst | 4 ++--
 docs/devel/virtio-backends.rst         | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/docs/devel/migration/compatibility.rst b/docs/devel/migration/compatibility.rst
index 5a5417ef06..c787f53738 100644
--- a/docs/devel/migration/compatibility.rst
+++ b/docs/devel/migration/compatibility.rst
@@ -198,7 +198,7 @@ was done::
 
 The relevant parts for migration are::
 
-    @@ -1281,7 +1284,8 @@ static Property virtio_blk_properties[] = {
+    @@ -1281,7 +1284,8 @@ static const Property virtio_blk_properties[] = {
      #endif
          DEFINE_PROP_BIT("request-merging", VirtIOBlock, conf.request_merging, 0,
                          true),
@@ -395,7 +395,7 @@ the old behaviour or the new behaviour::
     index 8a87ccc8b0..5153ad63d6 100644
     --- a/hw/pci/pci.c
     +++ b/hw/pci/pci.c
-    @@ -79,6 +79,8 @@ static Property pci_props[] = {
+    @@ -79,6 +79,8 @@ static const Property pci_props[] = {
          DEFINE_PROP_STRING("failover_pair_id", PCIDevice,
                             failover_pair_id),
          DEFINE_PROP_UINT32("acpi-index",  PCIDevice, acpi_index, 0),
diff --git a/docs/devel/virtio-backends.rst b/docs/devel/virtio-backends.rst
index 9ff092e7a0..a6f9df4845 100644
--- a/docs/devel/virtio-backends.rst
+++ b/docs/devel/virtio-backends.rst
@@ -101,7 +101,7 @@ manually instantiated:
       VirtIOBlock vdev;
   };
 
-  static Property virtio_blk_pci_properties[] = {
+  static const Property virtio_blk_pci_properties[] = {
       DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
       DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
                       VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
-- 
2.43.0


