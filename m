Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E1BBC369DC
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 16:12:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9R4i-0002OA-6V; Mon, 28 Apr 2025 12:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u9R45-00025k-Le
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 12:10:51 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u9R42-0008Pv-UE
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 12:10:40 -0400
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-223fd89d036so62339195ad.1
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 09:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745856637; x=1746461437; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=faK2QqFAYgv8BYf+WQYaPP11E1ZqL7Z8duqRRmq87aw=;
 b=SCDSR2ODBnKo6sQGq0cfMPL+mGTfzZQEO6EbqH1kaET4Var7FuugoVw1gMjiyvgkeo
 /t1cCXUJwQbcccHcI0qKP4O9aYMCF+EmyvSxQBB3lspflE1Yq+VDY81yoknDy/8HdvHJ
 yDTfNMr6OtcUw1Z8MwYSXzuaKk/D7KmNuQmjxO6NKbQFaOvmhqIcVtUMuUZRYMs/2ncx
 77FoaMlJ5SqKZUH+zu0lsGj0x829lCkm1p8DRmSi6HKfDW7G9/gO7WFuMGP5fsXqS/YW
 EUvmENDvbj8vAjfprjnEZVnc7QjCmWd9+ZutcwtA8J+Edx0egaDglnZgWuXMbkzRLc8X
 Kfrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745856637; x=1746461437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=faK2QqFAYgv8BYf+WQYaPP11E1ZqL7Z8duqRRmq87aw=;
 b=EMwAbycoFXXVXFXM3r2QvknUn1BuxzOSWVMse/7jnyQJqToZmyesZlH9WI5WDnSijr
 K9YgIpVk5CIIyPWFqImHrLDiaWvOs27XjFtxmasCtuh3zYuTMgPcnuBfx7xfocdcrDSv
 Nj3Hett2sdPJqD0RnwJ8Lo8LUeXgfSORPHezaTWEPEGvkrDxjasDKaVbzTXxxa8K1aOZ
 GzA0AF4nPo/zJJM3d20tCFPyAI0nrdv8bajD6eG6G+4RYNzN/CPVj//gu3u5OrxuIhgi
 JebNRxyTTVYXd7WQFLu7b5V+ARwDDq+8cS0wBqRmNQv/+0qNJd5dsKBZrNzdgeVkylvO
 hdew==
X-Gm-Message-State: AOJu0YyGqqw2VLKvFWgvnjT2vhKt+USYCTZYepDBXQ5UypgEgsNSR+p0
 J94oRp0F95HnOAV8KF0PKDZgtGvQm0Xm0qrpGIN7sGsz0JP4+Nk=
X-Gm-Gg: ASbGncsSW0EhE+Tu48wE+pccvOA55w8VXaTjSNEaLhW5JzX1nXMIbeXNUaSoS6iQimu
 Vndt/WJByE/5WkcgL0ENjoom+VB1We8sEMhwaP7R5h9lWbolySPzw/82gydLSYvKW7tcfUMZYj0
 yoJE3BVRul2NP2zfDlT9xt73gZRdwrcVAustFyz7eGFY0GVvqNuVNW1BsNY3Rm38hPl68wf77PO
 IUwBK7w7z02MT36NZlWj3n+2U1ujWiBWBWuyEajmgseJvVcGzb1syEhQdmorD/YY5YwaFmVHbbE
 cVy9KY9/Tbkngm+HVM9Wfr2JwPwY83Dm34YhNSnmDxS+USM5BL2kvThMTu21Dslv0j0=
X-Google-Smtp-Source: AGHT+IEg/EOmSTIYWdOYjAUqlu65/nnG0tTbAeJVcvtgUTkyoNWr727LxaM+vpQRX0Z7fOQ/dxWZog==
X-Received: by 2002:a17:902:f687:b0:223:faf5:c82 with SMTP id
 d9443c01a7336-22dc69efa54mr122543175ad.8.1745856637186; 
 Mon, 28 Apr 2025 09:10:37 -0700 (PDT)
Received: from localhost.localdomain ([139.227.182.191])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db5221677sm84357515ad.248.2025.04.28.09.10.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 09:10:36 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>
Subject: [PATCH 5/9] vfio/igd: Check OpRegion support on GVT-g mdev
Date: Tue, 29 Apr 2025 00:10:00 +0800
Message-ID: <20250428161004.35613-6-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250428161004.35613-1-tomitamoeko@gmail.com>
References: <20250428161004.35613-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x644.google.com
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

The Intel GVT-g backend `kvmgt` always emulates OpRegion for vGPU,
make sure the OpRegion is present for enabling access to it
automatically later.

Also, hotplugging GVT-g vGPU is now always disallowed regardless of
OpRegion to prevent potential issues. Intel has never claimed support
for GVT-g hotplugging.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index c6ecbefb35..496d3df598 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -684,9 +684,13 @@ static bool vfio_pci_kvmgt_config_quirk(VFIOPCIDevice *vdev, Error **errp)
         return true;
     }
 
+    if (!vfio_pci_igd_opregion_detect(vdev, &opregion, errp)) {
+        /* Should never reach here, KVMGT always emulates OpRegion */
+        return false;
+    }
+
     if ((vdev->features & VFIO_FEATURE_ENABLE_IGD_OPREGION) &&
-        (!vfio_pci_igd_opregion_detect(vdev, &opregion, errp) ||
-         !vfio_pci_igd_opregion_init(vdev, opregion, errp))) {
+        !vfio_pci_igd_opregion_init(vdev, opregion, errp)) {
         return false;
     }
 
-- 
2.47.2


