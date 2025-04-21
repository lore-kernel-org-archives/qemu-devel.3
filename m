Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D69C369D3
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Apr 2025 16:36:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u6u5Q-0000Wz-I3; Mon, 21 Apr 2025 12:33:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u6u4C-0007z4-EC
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 12:32:26 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u6u4A-0003IQ-1I
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 12:32:19 -0400
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-2240b4de12bso60691035ad.2
 for <qemu-devel@nongnu.org>; Mon, 21 Apr 2025 09:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745253136; x=1745857936; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TRJ4J7IpcJlya+RhRcVzGp5oPkbToRhD/e6mfIMJDDc=;
 b=QABRCgrFNLT15BzCV0gc9CDnhsh+zUpxIcqY8ZbtxnBlT5tgDBhP0SR2ObPCdH/sds
 ZHqR+NmLRE842dU05KGTdtXJiudvRVt6YGWk+6Wv6Su2humkcKbzCwFZjP3jcbOuqQI+
 JsV5ux6LUVuXb+iOQGrQAgSMNyXl2dH62qgKBoWmC70G2A8q4GEew8gcs9LGgNuvsOqs
 D1hkpE5OGxeLu44azxoWJBq5myEmcAUHzEdZWt+JF/hp6DV7sqIGP1tKhcV0vIpQVtMN
 pDeiDdlIq/2RRI1qCf6rWvNQRiDjw9+jBKwUy5yCppfc73lUL6CjglZrYN1bQQ9Jioik
 v6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745253136; x=1745857936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TRJ4J7IpcJlya+RhRcVzGp5oPkbToRhD/e6mfIMJDDc=;
 b=HopCvG2cNTuU3+xompUZpsY/iCeUTDX04FZy8Bc4gnSVJwTuepSvKyF2OVxSkTM3QP
 3rL3e6gX7paeNl7ie2YN/xGEmyd8a3iKrSoagx51Hv88vFwHT1Jf6vCJ/MGnJWohVdBD
 0XUdTh6n8yOAofPi4il0cqM9SqO31n1X6sgbvAoAIPmQKYntvhvJ9bLPcjJWJqAKH+P0
 BjECPdZI9S2OXj6O8Vpo/AoW0czDGroSbSd5CEQQ9NxqsJGz8WBnk9Fw+7Vr8I91AGsX
 C+bEApZzWBkxfV88tMn4m+88KLqE+SsaKfWbCswXXAq1/UuVXSpOduht16sc0R2FC1NT
 ro4A==
X-Gm-Message-State: AOJu0YwGZtU3dpMprzR4NHcfMiRzLHTYAyTRjfRvxmbVd9SYDzCX+ab+
 2iDGVdaHZIZxP9lUazeG1ZnyOTleO4Els6osN1CHnuV2ULu0LhRSyBfF5LD4cQ==
X-Gm-Gg: ASbGncsyTRMJ/dMssfXEYcaWNTTE2JElDN4ddaFMf+IgRqUx9iRACExqTvuU/CgZu9T
 L32uD+t7Z+YXegQ64cPvMixLrDWwRfVJRvxZmqVa/rRnOizFZZuexx+qrfke8ytR97I45KadFcp
 PxYWT2MJlfY3bjLaCFdB6wfVBL7uhiY8JvKgiUfsrS4L3iLMVrbwU+Nt70VCM29lDY+dzj8m/mz
 2bSsSfK0CCRWCPHLjM0E/Q1dLLcQ0U6IfLP4h6wf8PSSJ4SwbzG2GUVTS1mY2/rP74w7higrUQ1
 /iU5vLv85jW0IOxaJd2HfOlwgni4nzolOtWtpEJnvoJcaFRtnI8o3eVMRbg+cgWo
X-Google-Smtp-Source: AGHT+IFOuJmmxzA+ReiRbRwypgKWzdA6gCQrhqdrcIm7Sa8UPoBwrHR0OJYs/WH39AmSpYnch5aLdQ==
X-Received: by 2002:a17:902:ef0a:b0:21f:85ee:f2df with SMTP id
 d9443c01a7336-22c5357f28dmr180645165ad.15.1745253136160; 
 Mon, 21 Apr 2025 09:32:16 -0700 (PDT)
Received: from localhost.localdomain ([139.227.17.39])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50ed1997sm67778725ad.201.2025.04.21.09.32.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 09:32:15 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>
Subject: [PATCH 05/11] vfio/igd: Check vendor and device ID on GVT-g mdev
Date: Tue, 22 Apr 2025 00:31:05 +0800
Message-ID: <20250421163112.21316-6-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250421163112.21316-1-tomitamoeko@gmail.com>
References: <20250421163112.21316-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x641.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Check the vendor and device ID on GVT-g mdev to ensure it is a supported
device [1]. This extra check is required for automatically enabling
OpRegion access later.

Note that Cherryview and Gemini Lake are marked as supported here since
current code cannot distinguish them with other Gen8 and Gen9 devices.
Since mdev cannot be created on these devices, this has no functional
impact.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/i915/intel_gvt.c?h=v6.14#n52

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index cc397f8829..e94ed7029a 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -654,6 +654,19 @@ error:
  */
 static bool vfio_pci_kvmgt_config_quirk(VFIOPCIDevice *vdev, Error **errp)
 {
+    int gen;
+
+    if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
+        !vfio_is_vga(vdev)) {
+        return true;
+    }
+
+    /* FIXME: Cherryview is Gen8, but don't support GVT-g */
+    gen = igd_gen(vdev);
+    if (gen != 8 && gen != 9) {
+        return true;
+    }
+
     /* Hotplugging is not supported for opregion access */
     if (vdev->pdev.qdev.hotplugged) {
         error_setg(errp, "Hotplugging Intel GVT-g vGPU is not supported.");
-- 
2.47.2


