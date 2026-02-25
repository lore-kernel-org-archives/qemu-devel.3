Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ECEDF55449
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 03:17:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv5Oc-0000j4-5R; Tue, 24 Feb 2026 22:17:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv5Ob-0000ii-2o
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:17:05 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv5OY-000356-Lz
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:17:04 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48371bb515eso76878865e9.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 19:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771989420; x=1772594220; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HvL+keCK8WUamgr1IgGReHRJ2yPkltcWdwdHcSfKCiU=;
 b=oaKmFS6ocNFePxdtzC6fEJEfu3dJjVZUq0Kmij2yLXgrV2PRzRYv5H5TiGvDTm2dHK
 feNB+TJ7HK0xrBbL4tupUmw6PFmin7MJavUiet57ild6f6t9BEIP0kgiliDtqx+EK5mR
 k25Gi3dBDR9/rvrXIgfBy977/VblWcn5X8dpKo2T0lX6Zoar/U/x9LuIyIvECSOgK2DU
 gIuqmif7ty0m5h3mqs7SzAVS1hWWwN2GQA02cl9pHdjXKj9ys2ZocemGDakx8UXe0ckl
 Nt3jG9LqJu00Y6YtZ++UBFu+YR/9GOewu7SVdkaEwr/y91USKE0yAKytTW9vlQhc/E/q
 qTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771989420; x=1772594220;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HvL+keCK8WUamgr1IgGReHRJ2yPkltcWdwdHcSfKCiU=;
 b=Vx0hue8lI1uE0bUwtO/eiSVgAg/m4k/zwAxr0BT6aZ1QZrzU+CWnW9uRZguaw2ePf0
 vEH7e7qofnkHLqJL1KVJTTEQ/eSMKf0C83EApXDVXHnpFGCM1wlXidIuiIG4Z3aAJef9
 VYGXpKdFn8kn4LNKcp23JqfFCr40KoBwEI9anTHl1DeXxFVhp4l3glvh+TNpQc/PTXzJ
 /B0tdBgmExOxckGzVuBWQ4i3VnaIk7m7aJUr6nZ/yAHWq3UBGmSOLwgm/w+wdNlkB2hT
 ruj6SbwlMXgWXdSzPHf4JM++q7IjnZx+QD9HpmkZ1b5Cy0hrzU1LiA2WIwQQc5S/K4Gt
 /kjg==
X-Gm-Message-State: AOJu0YzZgJA5M2HRMlf8AG8m7FCp/+Bk/jbbHmaD/uYtMNy+jzkbXlwz
 nJnmhhiJdU9zsDHWCipKanQuzB/zNs/FwyUcm45BNJGJ6FXHjSfSKH+zJJTQqz2nwkxsOiu6Y3s
 ApXuwTAg=
X-Gm-Gg: ATEYQzw418CsNzpkcqB4re+MdASqDsKn7LpBRya1h1klDp8TR8vfrLMo5s5SvtBrPzU
 l5m3+gyGWt8c9FnIMCBArBfs+sJKwPfIsK3QxclM4tHJTdhgLgc9STv0IcEoD0E1c6ENV2GIYoK
 HcaFVjuY1BQ/idRhWfJwO1GY0gsy0ZLwI/UIbzQZRkZhtWZINKSif94U7/eBUgYsYu5dasHsIWO
 aAY+iWfkjnhfXNLIOS30NIAiTCuhoG219b19c472dlluguzMI/Vhy+8K1TFk9JcB3nYPHcOBTRr
 VKvKJubWVo0gBetPtvfYDRHcvCsdNP1aULkuMykM+LpWcI3Er0opVZxiDY29UzEG2wCQpAcAkx6
 sMhmAejPVEC0irXgSFgAoMKroiQJi7AURthKsnYS+isqnX7MJSFviYRr3T6+YEfylg+PTWMz7v5
 fr4m+rWAX+X4UC+o9LrW2oeoI4+2l/oFUcHRY65GvJkTkWDfH1ptV1UFWJdnt1uBphuTTXuD1Y
X-Received: by 2002:a05:600c:1d29:b0:477:5b0a:e616 with SMTP id
 5b1f17b1804b1-483a95eb521mr264765115e9.5.1771989420468; 
 Tue, 24 Feb 2026 19:17:00 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfb776b0sm1000125e9.1.2026.02.24.19.16.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Feb 2026 19:16:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/3] hw/iommu: Avoid including CONFIG_DEVICES in hw/ header
Date: Wed, 25 Feb 2026 04:16:55 +0100
Message-ID: <20260225031658.32095-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

By inlinining the stubs we can avoid the use of target-specific
CONFIG_DEVICES include in a hw/ header, allowing to build the
source files including it as common objects.

Philippe Mathieu-Daudé (3):
  hw/arm/smmuv3: Avoid including CONFIG_DEVICES in hw/ header
  hw/i386/intel_iommu: Avoid including CONFIG_DEVICES in hw/ header
  hw/s390x/s390-pci-vfio: Avoid including CONFIG_DEVICES in hw/ header

 hw/arm/smmuv3-accel.h             | 35 ------------------------
 hw/i386/intel_iommu_accel.h       | 35 ++----------------------
 include/hw/s390x/s390-pci-vfio.h  | 20 --------------
 hw/arm/smmuv3-accel-stubs.c       | 44 +++++++++++++++++++++++++++++++
 hw/i386/intel_iommu_accel-stubs.c | 37 ++++++++++++++++++++++++++
 hw/s390x/s390-pci-vfio-stubs.c    | 32 ++++++++++++++++++++++
 hw/arm/meson.build                |  5 ++--
 hw/i386/meson.build               |  1 +
 hw/s390x/meson.build              |  1 +
 9 files changed, 120 insertions(+), 90 deletions(-)
 create mode 100644 hw/arm/smmuv3-accel-stubs.c
 create mode 100644 hw/i386/intel_iommu_accel-stubs.c
 create mode 100644 hw/s390x/s390-pci-vfio-stubs.c

-- 
2.52.0


