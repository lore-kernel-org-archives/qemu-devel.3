Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02973C25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 10:49:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5Nol-0001b5-Ur; Fri, 10 May 2024 06:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5Noe-0001O9-Bs
 for qemu-devel@nongnu.org; Fri, 10 May 2024 06:49:29 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5Noc-0001V8-Cl
 for qemu-devel@nongnu.org; Fri, 10 May 2024 06:49:28 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2e0a34b2899so27370091fa.3
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 03:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715338164; x=1715942964; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WG6hHvxHnsfDLBmoixzqYQgPTY2J5n6T9oUHauE6pdQ=;
 b=vNUWPEL137vpjkzPtZF64LgBDtsJHfrQ4caQX8a9BfK0hB60QVQhFzs9qnfepcTFhJ
 v75LtWMSYAlcusxKQwYDdg2iDZyROIIV9hIFrIOEe4zvxx4nKYxx9td6o+xKYF7cioqr
 MUCFS2r1NfS6hkphAHFncAiJnYI5+yOcZK2rSBQQOoH5IzoyqP0Cff1uyRGh4IDPGd8F
 1wYk164FDp4RD0XwbvBfTFmOGNPGSkn+o4qEuCgu9ZNOTzpf2cQ/2OHdqvkoFaC62lsx
 +mzmLS0tW2Qxz5qXHExorVToMX0Dfhd+VIrEjv1IdKGFtloWJGRSvPRvaj7mUevZteDx
 NgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715338164; x=1715942964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WG6hHvxHnsfDLBmoixzqYQgPTY2J5n6T9oUHauE6pdQ=;
 b=j8iuJHBrqC/OpByFuVo6+QHpdMb87AEsTbvLkfisLKmjarU5XV/Wgq7sbJlWQhJ+yo
 ums9yBL1xVCfh2/8QpoISAVUSjzEW+Gt+D9yfnDXysYZZ/zCkOtKlD5tA1zJJzq4QGc1
 KTvSqwefK41fvM/6tfle0KvUHNilOPLd69jX0nT190YL490ciYdYWHaR1R/t69SHhBkJ
 wen0QikOhGAF2/YmDLtYvh1XkSDCoff4cvysGOEYbJ/gz5j0812u0aehjCpuzY0wGhY9
 uQ2xmDAnQ2dPnzg3GLOudFjUlErN47bu2HyuLWPTBEpe5gQ7hFR6xGV84RRz4hz/hnF4
 xb8Q==
X-Gm-Message-State: AOJu0YyZkEH7Y5npHTQrsF5DhMt6N5DZqKAPKbpAZKxiH03teHdqF90M
 7SoPqZPmTMG8jzd2jNeb5zN3BNclpTH/ohtEa74qe42QUOmT8R2EU5mZkqUJh/ckpJo1igfORRo
 b
X-Google-Smtp-Source: AGHT+IFmnZ+GsRWrg13UBzYocLVh19CoDwULJS52v4mItPwgRYVUMX2l1wSejvKjHmjEdqsBZaZvSw==
X-Received: by 2002:a2e:859:0:b0:2e5:4171:1808 with SMTP id
 38308e7fff4ca-2e541711898mr7342581fa.51.1715338163501; 
 Fri, 10 May 2024 03:49:23 -0700 (PDT)
Received: from m1x-phil.lan (sev93-h02-176-184-17-152.dsl.sta.abo.bbox.fr.
 [176.184.17.152]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502b896a06sm4231043f8f.27.2024.05.10.03.49.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 May 2024 03:49:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/7] hw/xen: Constify XenLegacyDevice::XenDevOps
Date: Fri, 10 May 2024 12:49:03 +0200
Message-ID: <20240510104908.76908-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240510104908.76908-1-philmd@linaro.org>
References: <20240510104908.76908-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22d.google.com
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

XenDevOps @ops is not updated, mark it const.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/xen/xen_pvdev.h  | 2 +-
 hw/xen/xen-legacy-backend.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/hw/xen/xen_pvdev.h b/include/hw/xen/xen_pvdev.h
index ddad4b9f36..fd9a33e6ab 100644
--- a/include/hw/xen/xen_pvdev.h
+++ b/include/hw/xen/xen_pvdev.h
@@ -53,7 +53,7 @@ struct XenLegacyDevice {
     xenevtchn_handle   *evtchndev;
     xengnttab_handle   *gnttabdev;
 
-    struct XenDevOps   *ops;
+    const struct XenDevOps *ops;
     QTAILQ_ENTRY(XenLegacyDevice) next;
 };
 
diff --git a/hw/xen/xen-legacy-backend.c b/hw/xen/xen-legacy-backend.c
index 124dd5f3d6..35f2b57560 100644
--- a/hw/xen/xen-legacy-backend.c
+++ b/hw/xen/xen-legacy-backend.c
@@ -170,7 +170,7 @@ int xen_be_copy_grant_refs(struct XenLegacyDevice *xendev,
  */
 static struct XenLegacyDevice *xen_be_get_xendev(const char *type, int dom,
                                                  int dev,
-                                                 struct XenDevOps *ops)
+                                                 const struct XenDevOps *ops)
 {
     struct XenLegacyDevice *xendev;
 
-- 
2.41.0


