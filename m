Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF91E77197
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2025 08:57:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUMR9-0001Pv-P1; Sun, 05 Jan 2025 03:56:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tUMR8-0001P1-8A
 for qemu-devel@nongnu.org; Sun, 05 Jan 2025 03:56:42 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tUMR5-00030U-Vt
 for qemu-devel@nongnu.org; Sun, 05 Jan 2025 03:56:41 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2f4448bf96fso14724061a91.0
 for <qemu-devel@nongnu.org>; Sun, 05 Jan 2025 00:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736067398; x=1736672198;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DdQHVCGRQ4YyJ9R+YZQkvFlcnxLRMNqJtnvSOCQW0L4=;
 b=t6FNP0UoZVzPIZVPsyNiCIHT+8GFe8adJcwfkRCXNNrMNkE5DplD5wqad2iFZPqoda
 ev8u722t2n449hV7ueDPxGFKooZVniBs5nKCFYxt016pdSQFJQKC4rruTgmUqtNk55BA
 jrOclgRJDaJag5fvQBrvgBhUMnw3iaOw7raCQgrp/hbqmw2RDd3EqTANfayFiYrl45eq
 duAU6+RoPDY56T7Cy1mhgasCY3RhR0B+iUV5A2KlsKaKs1oGczr3th56jU8UV6lQ8xsi
 O4gpnP870tA1DjaGS1EtO2HXOdx/m5D5BNE143y+G+EImKGiSE6qn6cug5fOTTLtSzw3
 emmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736067398; x=1736672198;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DdQHVCGRQ4YyJ9R+YZQkvFlcnxLRMNqJtnvSOCQW0L4=;
 b=cHIHh8+PFKKDzagNXzxQX2cg5YH43DDC1RBq1Vp8lHlgNqUwB02HRSA3JkROXNoj0q
 j2l1jKSEImZQqQxeEg8jR/mWpnfECRfl3FAtgRfUORRa91Yc3v9AUIA9sbgUmFUTYlY0
 qy3qJ7b+SUgm67SiLUl9CkPpYLPuB0VMwyaXrCT7s7pudlY+OOWb8q0NAG3xXgpzxY/d
 xOCuuKuOLc9R/jNKrJRKgaEIeNn2MHr03RLZTz22xaxEFm40q3s3AnIToT6ejUSRNkKj
 32cxDhU8ZxLM86dwOCJyKI/20lC4A9AAAbtGPibsLAx4HOf1VTkbrCCcXwXf6tQb2lMd
 AAdQ==
X-Gm-Message-State: AOJu0YyLu5JRvhZLI3PzuHpr0xjS8XNXwuFP3ph5hs0jYOIcvTBsCLni
 0IohaKs5neIximNj6gDjeSwQtD7Grde7dfWi3oSRVUKLo/dYfPv5mbWVRJF+DJY=
X-Gm-Gg: ASbGncvPoX4BMfguwfn2tIj11fKmnafRMvUym7vtcl8iDjVnGx00HbgIOUJFGbYH+Tz
 vc8/aoHwAo59O93y9E/wty1ji6DwTlj/SiKGYwDiktydEkkEDW9jPyNoCvfDXiByDyvhK3I/FOv
 lUE12aYyeyiBAFeCza/0aT8JzpyYpZXxyDgWhk9orN1SM+HTPm7NwaMFJco84mg7WDBgo+P69qt
 Otr8bzKD4qSNvnKgQLK0dA8aSYRVzhLoG0cJEiEL8FYXh+aURlg2dnREXYJ
X-Google-Smtp-Source: AGHT+IGk02zg0e90qBycmPLubWxwi6gZBJB2jVWYVrmvgegLUqPcYqav7j1v8z4i/DniD+uiUcJJGQ==
X-Received: by 2002:a17:90b:3d43:b0:2ee:c6c8:d8a2 with SMTP id
 98e67ed59e1d1-2f452e11eb8mr79462465a91.14.1736067398188; 
 Sun, 05 Jan 2025 00:56:38 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2f2ed62cdabsm37082654a91.14.2025.01.05.00.56.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Jan 2025 00:56:37 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v6 0/2] Fix check-qtest-ppc64 sanitizer errors
Date: Sun, 05 Jan 2025 17:56:17 +0900
Message-Id: <20250105-san-v6-0-11fc859b99b7@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADFJemcC/2XOTWrDMBAF4KsErasyGo0ku6veo2Sh30aL2sEqJ
 iH47pnYhLR4+Yb5Hu8mWp5qbuLjcBNTnmur48DBvh1EPPnhO8uaOAsEJLBoZPODhN754gsVFVH
 w53nKpV7Wlq8j51Ntv+N0XUtn9bg+vV39rCTIomMk1ICq6z+Tvw718h7HH/EomPEvchtCRs5AC
 NCTTSHtkH4hB92GNKMAulinIkG0O0Qv1KHeEDHySNGm4inmsEPmiQwooA0ZRl0gDWQcT/w/b1m
 WO6GL1J5rAQAA
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

I saw various sanitizer errors when running check-qtest-ppc64. While
I could just turn off sanitizers, I decided to tackle them this time.

Unfortunately, GLib versions older than 2.81.0 do not free test data in
some cases so some sanitizer errors remain. All sanitizer errors will be
gone with this patch series combined with the following change for GLib:
https://gitlab.gnome.org/GNOME/glib/-/merge_requests/4120

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v6:
- Avoid referring owner as "the object that tracks the region's
  reference count".
- Noted that memroy_region_ref() and memroy_region_unref() do nothing
  if the owner is not present.
- Explicitly stated that memory_region_unref() may destroy the owner
  along with the memory region itself.
- Link to v5: https://lore.kernel.org/r/20250104-san-v5-0-8b430457b09d@daynix.com

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

 include/exec/memory.h | 59 ++++++++++++++++++++++++---------------------------
 system/memory.c       |  8 +++++--
 2 files changed, 34 insertions(+), 33 deletions(-)
---
base-commit: 38d0939b86e2eef6f6a622c6f1f7befda0146595
change-id: 20240625-san-097afaf4f1c2

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


