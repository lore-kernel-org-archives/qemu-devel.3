Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F81C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 23:13:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr3LN-0002f3-GX; Sat, 08 Mar 2025 18:12:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr3KI-0000ZX-2L
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 18:11:28 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr3KF-0001dg-EP
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 18:11:25 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-391342fc148so1080070f8f.2
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 15:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741475481; x=1742080281; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=prGg0Jp93h0bTm2Rvsy5eDeK3CFMwhrsFj/MryWjJGE=;
 b=sYYhYi+Nq8tAEi6Sg2/cM1k/118jecdG2eR8XYOvYZCxthNMIoML9nTeQtm1Vryc9o
 oUPkKQR8V3vQzs+5bCVpA9QY0gCwC1Zuz6G9SrtvjejJBt6yiSUa2sm6hvytN9zysXDe
 9FFPvcOfKrt3ckAr7a1UXNCFuClOD4UhtLcytgWLFb5NqZOs2Eg6v3MVABXgskeWt7Rh
 QqCC0BC7hDGsO6e2cYynWbcbmcczyB6nm3qyJcF01bgbs1cTo1s7OnBkd91u//7LIwWK
 p/Pi+A3bSi3yJPo7MfJ+Cq6IjhLV9QF7g6/zs78Ci35fkIhFqwB0nsmPRq/k56v4EJh2
 8Isg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741475481; x=1742080281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=prGg0Jp93h0bTm2Rvsy5eDeK3CFMwhrsFj/MryWjJGE=;
 b=RCyU18YSBcavm0aajS7eOxtbB4A8u6yJ3dfJuSydRwxYG3bsnUY/LdjbC83mI32KmA
 1xGFVGA4yW12ONmCeVQUxrVd8Z/ZA2UG11g/aZgELXCvjF3N/iDBNkk7OT/xCuqooSSd
 FY5O0G1tQTG1W/REYHkc6FP21xlTGYTze/6bLtiSJzW6+f1QkIkCtKANGSXA5vB5Kt4j
 LjgHypITzR0ds0zHR44pmqWvnvYx5dLYUrc0JiFYflf7ivhxDPyZ74+j2efUFLANAaue
 abGbE2xYRbZBjOVEa0xPhsbLbIaT+vqjCIvt7pV8qvwsgo6NwrJfPy1SYNgPGI7XUm6x
 Jt8A==
X-Gm-Message-State: AOJu0Yw0JLO24689Tuj8EyXXUKr9FsKubT8hTqKvDIcOn4ExhX/IKwJl
 yvJJgf2As37sCDIUonR+7xA7wJgIHbv1f76BvK5XZD/Ke3pb8JfjJ4ew7X7LVoiNkWgbfi3iwRf
 W/Jw=
X-Gm-Gg: ASbGncuT6R/TCoavvTfTZEY7tElPqUxwO9AyglkY1mrcy8XTin2ySmwoN52hxA95PF5
 Ple2Ivh2oz03zTTEHSbHQoIXFvQmTiMAUBCh/9kMxbROHhRSrU7Ft6h0C5cR59T2z8IuVU4Zwlu
 iEl2AsPamR5QqRplIqieNsWIJXi14Mp51AXi7oHzuOWLrj6AX6N9eGrCwVHGcBgpacaBlxLqnIP
 uVpN3x07KPkB73UVJSsSLKldX60A/qwsOgAHGm6NQOm0c1pKl0aWQ9dhn8O0JT1d3AoSAJlX1pw
 yMV4VrZCtE3C89oKELePhlYsc9MS12InVaskHmtJyjytysMzcFSKH2uTx+DDdqnUWafMT/yvjd2
 qaVe0QbVoV89ERIBNst8=
X-Google-Smtp-Source: AGHT+IH0XSNDzdAllhDd7qyOz0D5nItYuKr/ugMkLxptVro68gJqgXVXVwkqEYkZomhnl6ZBZh9Tiw==
X-Received: by 2002:a05:6000:178a:b0:38f:210b:693f with SMTP id
 ffacd0b85a97d-39132de1c59mr4682001f8f.52.1741475481571; 
 Sat, 08 Mar 2025 15:11:21 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c01d81csm10221905f8f.58.2025.03.08.15.11.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Mar 2025 15:11:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eric Farman <farman@linux.ibm.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-s390x@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 21/21] hw/vfio/platform: Compile once
Date: Sun,  9 Mar 2025 00:09:17 +0100
Message-ID: <20250308230917.18907-22-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250308230917.18907-1-philmd@linaro.org>
References: <20250308230917.18907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Since the file doesn't use any target-specific knowledge anymore,
move it to system_ss[] to build it once.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/vfio/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index 3119c841ed9..2bcbd052950 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -4,7 +4,6 @@ vfio_ss.add(files(
   'container.c',
 ))
 vfio_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr.c'))
-vfio_ss.add(when: 'CONFIG_VFIO_PLATFORM', if_true: files('platform.c'))
 
 specific_ss.add_all(when: 'CONFIG_VFIO', if_true: vfio_ss)
 
@@ -27,6 +26,7 @@ system_ss.add(when: ['CONFIG_VFIO', 'CONFIG_IOMMUFD'], if_true: files(
 ))
 system_ss.add(when: 'CONFIG_VFIO_AP', if_true: files('ap.c'))
 system_ss.add(when: 'CONFIG_VFIO_CCW', if_true: files('ccw.c'))
+system_ss.add(when: 'CONFIG_VFIO_PLATFORM', if_true: files('platform.c'))
 system_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
   'display.c',
   'pci.c',
-- 
2.47.1


