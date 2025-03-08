Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 808B9C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 23:13:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr3J3-0004tK-JV; Sat, 08 Mar 2025 18:10:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr3J1-0004ow-2u
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 18:10:07 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr3Iy-0001DW-0I
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 18:10:06 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso17975845e9.0
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 15:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741475402; x=1742080202; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+FGFHz50rlwowjsXAPUzEIGbHAi/y/Zg2M+gRe6JQAc=;
 b=XcbKvm+m277ZCWjkxQ7l8GTPTe6BAjpxbpC2za8Kp+oLcNCPaeqAUAPJIAc3f6P3fb
 Fd+e+xHtpEyf89KT9pDTSQsI/zf8whlxRuVXphdSsSiGr/7fjkrbN0uqyBGHjtR6rTWP
 LLxIodAS+VXq2hrPQjkQk3VGuzV73E9YQapEFt3FKzRfZLwVbStestCUOqm8TY6uCO5k
 mp1kFcfJuH1jboteyEwRVHgn28PEUny2PzKrK4toTgZJIqyTcx1UpWIntLdccu3+tk4U
 p8+CMI2hMp/HDEDHt/QH4nxZ8bGPkPR6Ak4uF9lUsVRVElh0+uqmZktIu2oqjM2h4giP
 4cUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741475402; x=1742080202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+FGFHz50rlwowjsXAPUzEIGbHAi/y/Zg2M+gRe6JQAc=;
 b=Lak/iXpT3uS3nrEARxEq8I/OsOapkzq1HtbDXU9Au+i1phzlxiCWafG1xa8WU2Qxqu
 FUq4H5fKwvYZhjTqMeI9kC0d+iCNlvIG6CDACqw7aGSyGzsg5wisG1xnu/ODFxQACY5F
 dDb9J4uMKUSNzlc/QxSL74LT1BjoYiMoYyNi55TYkf4G1Rl92nU6JmAn6LjncUN6qqO9
 TG24ha+/Oq9FocX/oNIlWQ/QZvMEodcRUXd+ecjRBOShtc13RvHiCIgkJK+E/I04Xpqw
 Kf0EbKMqOV52HyGV8ZmnsKtUKxF2OC7ViA33G1HMox7vhrjhpltZ/LD2aTmY2lZK3pJW
 LdaQ==
X-Gm-Message-State: AOJu0YwWb3DWNBGKZOdnIQX5cIa39kQMDXJ2mUHI/LylydpNJL/S7i0v
 ILcCc1II5+OIBSmK9Gg+4cyiGWv3bJEF0HROlEUCcsd5N5pfeSdgPSISJMlCmHG1RBya0Oa8wlJ
 F368=
X-Gm-Gg: ASbGncu9a/J15vnxh3DinSq0mPP9OjSoAkvWL6v37I3Hq3Tv59+e/ooNGR2Yimo8jT+
 InqY2jkHDn9tdjrM34mNNijqJTgtU7BJOXhiCU4jwPUWeR0ZsVE1OQB7eaYNhBEJizG7BGk7ls1
 YYCDA2kmvHBUkWO0heMz2PFxXLIVlbxhg7BeBdpYhci/M7ZhMw8Fw5aoCbUxoRw0F92q20DaWiB
 OhW3KxzbwzI9mryxbPaTi6b0gFtCCqDuSYAUehwCLbQ2j8cjJ6Tqld0KakFT9qtiv02etP+njpF
 O3S5BFq3rwQpmqgvR5e9dCbpRCKvp6fXBA/CyTEda4NZL3FcthfagVS8cbbtLTefYW+aQ0hdzgN
 cSucB7PtOdvUtjR44G2EecwQpaFj9eg==
X-Google-Smtp-Source: AGHT+IGIv7r4JVSN4fyIj3wYPXDmIoomS2e7/C3qLiVhv6Ql0EEJlV/5Due87/IgHr0O7LUJ20Gsaw==
X-Received: by 2002:a05:600c:4fce:b0:439:a1ad:6851 with SMTP id
 5b1f17b1804b1-43cdc7b6dccmr41459045e9.23.1741475401963; 
 Sat, 08 Mar 2025 15:10:01 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd8de4ffsm97892025e9.24.2025.03.08.15.10.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Mar 2025 15:10:01 -0800 (PST)
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
Subject: [PATCH v2 07/21] hw/vfio: Compile display.c once
Date: Sun,  9 Mar 2025 00:09:03 +0100
Message-ID: <20250308230917.18907-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250308230917.18907-1-philmd@linaro.org>
References: <20250308230917.18907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

display.c doesn't rely on target specific definitions,
move it to system_ss[] to build it once.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/meson.build | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index 5c9ec7e8971..a8939c83865 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -5,7 +5,6 @@ vfio_ss.add(files(
 ))
 vfio_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr.c'))
 vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
-  'display.c',
   'pci-quirks.c',
   'pci.c',
 ))
@@ -28,3 +27,6 @@ system_ss.add(when: 'CONFIG_VFIO', if_true: files(
 system_ss.add(when: ['CONFIG_VFIO', 'CONFIG_IOMMUFD'], if_true: files(
   'iommufd.c',
 ))
+system_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
+  'display.c',
+))
-- 
2.47.1


