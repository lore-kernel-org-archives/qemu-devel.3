Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3397CCFA13
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Nov 2025 14:37:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vI6Vi-00027Z-SU; Sun, 09 Nov 2025 09:35:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vI6Vg-000278-KO
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 09:35:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vI6Vf-0001ls-7w
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 09:35:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762698914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kLrQ88WZDwAcR3Mzm912ehvptStqn0wqkOuGdl4uI/M=;
 b=YeVItanOk0TF4hK8sdOhusgeoaaH+yJEOHOAbGbTRM4z4EQzIldzAwH1uDaqGgvMRV9CU7
 dcwg+Y0HqjSqt0XeSdtrmAKMZsuakbYAOyFoWTlbRVb0Pe5SaQH1O4+N+bGIenKr5vcwEo
 XYp70qZlqOh33eFyblhVTi02xrBoAqU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-23kI1nTcNb2WzY1Cfeu55Q-1; Sun, 09 Nov 2025 09:35:13 -0500
X-MC-Unique: 23kI1nTcNb2WzY1Cfeu55Q-1
X-Mimecast-MFC-AGG-ID: 23kI1nTcNb2WzY1Cfeu55Q_1762698912
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47113538d8cso12068755e9.1
 for <qemu-devel@nongnu.org>; Sun, 09 Nov 2025 06:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762698912; x=1763303712; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kLrQ88WZDwAcR3Mzm912ehvptStqn0wqkOuGdl4uI/M=;
 b=tE6l6g3n16QU4YHIqdMGpiSRCWwmRXYfOll5IZ0/k7XwZ28sfI2t8aAZdoGl8rms0H
 kuuwCc3jQsCpnovMXfeYU5lBOKz6L22fd8tXZuLvLOxhZGp6MOG8QFeXQtGXbvl/8wEO
 lswvnLjABfCmVavA6fzl8RNMpKenRBsmsP5cEeAz/Tt6yCPFB4AW3inrA6Y2wveujySY
 z2g9eYxptFI+hlh9QLmgKCLBnJwT9pqM2X+9Psjp6GlMVihqSHwBHnq3co5DDGartLIM
 PDacRbu+9Zt8ILIbcPMdV46YySeyPfTzwNb22e8CuptvQtVui6lY2u3grjcHX2+42/UV
 MoVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762698912; x=1763303712;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kLrQ88WZDwAcR3Mzm912ehvptStqn0wqkOuGdl4uI/M=;
 b=v5dJ+xKazGi85zDGPHi+IMWAw9RB1aag0jC5L2/UVgVSY5gAw+4hlyi1OYE02D7bUX
 icQsLkmwDEMJWqVCTRoouKpjrxKktPQpr9ocd0bQHEM4qf7ytbYmQcFHDporbsoMtCal
 Zl+PFN2jfiGkr7oyvwCyA1/AjEsUzcsDAobWdkD4jqBfudNvnkQi8Nt+jVblUDs8bIXL
 4FVdRXqUCvlC0kx16vPR4HIRG/j5uEShbterKBxUrcnW96E068hYG0IT0OrP2GKsA26e
 ZY2YY0h+hkZeWRyginsjgiULcLHasoGnsRbKI65VGvksPeq929RHYB0RosoryZWvvXJP
 WoHw==
X-Gm-Message-State: AOJu0Yzo81CvgNbCU71EWJzhQ7xwtJw27ekIGFoX5/utuBmEbj9o5rjk
 YE9cc/CBzgnIACNqEwGWSF8grlLU/gpqliODhPylrNMAq1HuJ39zB9nwwb7W1F0vguouiAz+e6w
 BPGFVO2dvw3VXu56YJdxxA2cJwsaPRhugXFFkASAcdcQe/4v8O/dwYhHCBbSphYtDNTR883wFl8
 fuU6oimBWZHKo+L6CT1FphDbmyhYu4z5XcqQ==
X-Gm-Gg: ASbGncubbFl/J9/v1/fwLBOos2br7ceO1xvuNCds0ZojoJHhUAM/+RrYJJk3wpQ5gP8
 HxHPbb0FHLGiKNHInsCyZyecTA2dZeWwRKrox3+jBGTAYZaNURC8PTNFOWn8YOL7O+ios7ybfxb
 0NijTknS72o/HBR6v5981qcgvB4HG01mdO/c1F1wuMRxzLb5A/n96N/D6zQzB5wFkfxnaQ/CayL
 SFApDlyX3JZ2NQ4hAChLp+1Fpipfs/iHfNi3sBN9TMi8nBArUPAXTZcmnlIPrVcHsJLW37JPHGA
 B2o7cmQQsRNy3EGpVm+Zm+WtqhNQ74bHjrpL5ETpxHH3QhvcnISjR64qt+gRb+rkPD0=
X-Received: by 2002:a05:600c:5486:b0:477:be4:7a52 with SMTP id
 5b1f17b1804b1-477732ab255mr33995855e9.39.1762698911764; 
 Sun, 09 Nov 2025 06:35:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjnHZTt4hD/6t+a2dD4hhT+lY3dZX9tHEO+UR855BggP0AohsVGR3ab/BM2Hg3UM1UUGGVIg==
X-Received: by 2002:a05:600c:5486:b0:477:be4:7a52 with SMTP id
 5b1f17b1804b1-477732ab255mr33995605e9.39.1762698911216; 
 Sun, 09 Nov 2025 06:35:11 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1536:2700:9203:49b4:a0d:b580])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4776bd084d4sm191347015e9.14.2025.11.09.06.35.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Nov 2025 06:35:10 -0800 (PST)
Date: Sun, 9 Nov 2025 09:35:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Sairaj Kodilkar <sarunkod@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 01/14] MAINTAINERS: Update entry for AMD-Vi Emulation
Message-ID: <0f1f73bb37bb9e93d108e044224ecad9e4ecb3a5.1762698873.git.mst@redhat.com>
References: <cover.1762698873.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1762698873.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

Add myself as maintainer and Sairaj Kodilkar as reviewer.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Acked-by: Sairaj Kodilkar <sarunkod@amd.com>
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20251103203209.645434-2-alejandro.j.jimenez@oracle.com>
---
 MAINTAINERS | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index be6efff80c..9cb181e1da 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3933,8 +3933,10 @@ F: tests/functional/x86_64/test_intel_iommu.py
 F: tests/qtest/intel-iommu-test.c
 
 AMD-Vi Emulation
-S: Orphan
-F: hw/i386/amd_iommu.?
+M: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
+R: Sairaj Kodilkar <sarunkod@amd.com>
+S: Supported
+F: hw/i386/amd_iommu*
 
 OpenSBI Firmware
 L: qemu-riscv@nongnu.org
-- 
MST


