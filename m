Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 639A6E7719A
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2025 07:35:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTyfM-0000hj-P1; Sat, 04 Jan 2025 02:33:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTyfK-0000hJ-LG
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 02:33:46 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTyfI-0004WZ-Fh
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 02:33:46 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21654fdd5daso169384265ad.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 23:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1735976023; x=1736580823;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lgRja/DVzyOVnndmZz+Ok0yizuVeDqwwy5vnVItCxQk=;
 b=az7WmJDbsYtTc2UFhlE0TizbyLZWIK3HnbQo8kvmx7tNcapAemLnGCSwBNAdli+Hql
 Ib1T+A99T0kYeR/xCm356+Xm52BI0UTIxXFV5jYO82otrkfGS/xamyLnuLyir73B7KBW
 E5mL7uu6uWlAoAPDpuRlAILbg1UBCChHg9DESSXaIIvMR3a4RokLgiKMRXICp5fgiMeV
 K1BWSlZ9z9CAegjDc7oTnRH35XGpQ/hdIAMPLSDELVMTlAF9INA+g61pg4pNGBQ6sZsA
 Ia+4WFnWMpHPQ0mjdDpwSajOt0yF/Ej+xeMRm+hfZkKTxuKwH2MAuLHIk3w36m3A37TN
 3HEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735976023; x=1736580823;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lgRja/DVzyOVnndmZz+Ok0yizuVeDqwwy5vnVItCxQk=;
 b=jLWPOUtJJ+fCEVa1lZcY9o6ecPw9MDTvwZSWjwPlV9dc259qPudc2elw/pMRCTvVwc
 kd6PCrQD/PKDol+6WfnHLKZj36coBcYMzfLhbOzEYZ41A6wSm2qyxNc+JD92FAC0dtxI
 Y+jd9ffNUbMB/Wq8aV2t2gxVIRbhlyguhStN4TEtG5NBxWvyBb8HH4UaLZBlKHAHpoHi
 f25C9hS7OKDUG/Bvd9U5BlexSkhJOAdgfdZoR0sS9uihXC8POvrPHURiLtaZgfAFn/Id
 ziis4+YaRjMlA+sAPQFaRE3Gz070hYYIGQMvw377Ozi5naXww9+pbVewbyAN5R7KrVIL
 NkVg==
X-Gm-Message-State: AOJu0YzomvGNxKTHM+pSfJbJLhosufPOUn7L3kmEOUDxd2zVqOL26oe3
 2ZS7CByk65WsA6DN0WV2vrWZfpIMtWQ8MJ2CziZqCvLTyKbsigvDM5bS2GE1aa8=
X-Gm-Gg: ASbGncslikbmD9HipLgetXcJ4Y+PfZlxv9Yx2n2wb71n8ynYnAcGvgppZkKjeL+NG9j
 9+5iK1l0Kcj5JGBtNxsJWqqBIAvo8UfpiZO5F1JyN3iPV/zyoVko4uW5KmSTO6Q8zZuqcpWE9FL
 F6oU/IST6V5pHQuGRM6jffqxAhDoMfQ0bpfF6bVCBK7a6YTAbwp09IJUNZjBN6zSjfyP/WPWkLx
 9xDf/Ckyo5mKCIYRlBo1T31UyI60z+6JLO8M/RYh7Z1zD970BLLO4pJnAsp
X-Google-Smtp-Source: AGHT+IFlGMVaXNDcB2jokx+XOkwZw5soEmpVJVYK8lVRQYcHWsg0HxS1YbJpxK8v0jUOS6nO5cPunA==
X-Received: by 2002:a17:90b:3d47:b0:2ee:ad18:b30d with SMTP id
 98e67ed59e1d1-2f452deb500mr71341065a91.6.1735976022842; 
 Fri, 03 Jan 2025 23:33:42 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2f447797bb8sm32931291a91.7.2025.01.03.23.33.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2025 23:33:42 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v5 0/2] Fix check-qtest-ppc64 sanitizer errors
Date: Sat, 04 Jan 2025 16:33:34 +0900
Message-Id: <20250104-san-v5-0-8b430457b09d@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAE7keGcC/2XMQW7DIBCF4atErEs1DGOws+o9oixggIRF7chUV
 qLIdy+xVbmRl2803/8UJY45FnE8PMUYp1zy0NfRfBwEX11/iTKHugUCEhhsZHG9hM665BIlxSj
 q522MKd+Xyulc9zWXn2F8LNFJva5/3ix+UhJk0syEGlC13Vdwjz7fP3n4Fq/AhP+RXRFWZBvwH
 joywYcd0huy0K5IV+RBJ2MVE7DZIdpQi3pFVJFDYhOSI47+Dc3z/AvNINCeNgEAAA==
To: Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org, 
 devel@daynix.com, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

I saw various sanitizer errors when running check-qtest-ppc64. While
I could just turn off sanitizers, I decided to tackle them this time.

Unfortunately, GLib versions older than 2.81.0 do not free test data in
some cases so some sanitizer errors remain. All sanitizer errors will be
gone with this patch series combined with the following change for GLib:
https://gitlab.gnome.org/GNOME/glib/-/merge_requests/4120

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v5:
- Rebased.
- Merged four patches to update inline documentation into one
- Link to v4: https://lore.kernel.org/r/20240823-san-v4-0-a24c6dfa4ceb@daynix.com

Changes in v4:
- Changed to create a reference to the subregion instead of its owner
  when its owner equals to the container's owner.
- Dropped R-b from patch "memory: Do not create circular reference with
  subregion".
- Rebased.
- Link to v3: https://lore.kernel.org/r/20240708-san-v3-0-b03f671c40c6@daynix.com

Changes in v3:
- Added patch "memory: Clarify that we use owner's reference count".
- Added patch "memory: Refer to docs/devel/memory.rst for 'owner'".
- Fixed the message of patch
  "memory: Do not create circular reference with subregion".
- Dropped patch "cpu: Free cpu_ases" in favor of:
  https://lore.kernel.org/r/20240607115649.214622-7-salil.mehta@huawei.com/
  ("[PATCH V13 6/8] physmem: Add helper function to destroy CPU
  AddressSpace")
- Dropped patches "hw/ide: Convert macio ide_irq into GPIO line" and
  "hw/ide: Remove internal DMA qemu_irq" in favor of commit efb359346c7a
  ("hw/ide/macio: switch from using qemu_allocate_irq() to qdev input
  GPIOs")
- Dropped patch "hw/isa/vt82c686: Define a GPIO line between vt82c686
  and i8259" in favor of:
  https://patchew.org/QEMU/20240704205854.18537-1-shentey@gmail.com/
  ("[PATCH 0/3] Resolve vt82c686 and piix4 qemu_irq memory leaks")
- Dropped pulled patches.
- Link to v2: https://lore.kernel.org/r/20240627-san-v2-0-750bb0946dbd@daynix.com

Changes in v2:
- Rebased to "[PATCH] cpu: fix memleak of 'halt_cond' and 'thread'".
  (Philippe Mathieu-Daudé)
- Converted IRQs into GPIO lines and removed one qemu_irq usage.
  (Peter Maydell)
- s/suppresses/fixes/ (Michael S. Tsirkin)
- Corrected title of patch "hw/virtio: Free vqs after vhost_dev_cleanup()"
  (was "hw/virtio: Free vqs before vhost_dev_cleanup()")
- Link to v1: https://lore.kernel.org/r/20240626-san-v1-0-f3cc42302189@daynix.com

---
Akihiko Odaki (2):
      memory: Update inline documentation
      memory: Do not create circular reference with subregion

 include/exec/memory.h | 22 +++++++---------------
 system/memory.c       |  8 ++++++--
 2 files changed, 13 insertions(+), 17 deletions(-)
---
base-commit: 38d0939b86e2eef6f6a622c6f1f7befda0146595
change-id: 20240625-san-097afaf4f1c2

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


