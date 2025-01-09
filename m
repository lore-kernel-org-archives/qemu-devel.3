Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31711E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 05:51:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVlRD-0001yS-RW; Thu, 09 Jan 2025 00:50:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tVlRC-0001y3-2c
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 00:50:34 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tVlR9-0002hQ-M9
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 00:50:33 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21669fd5c7cso7224185ad.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 21:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736401830; x=1737006630;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HrjmQS6sDIDwKO+UJvxDveSWdwDMaPIQvkl3e1u8m48=;
 b=Z+7LdDIFVseVaTWSWxj/GI1eecQJHhHi20VGdhG9z7vuPlCddnvg5ozx+23YBopP3r
 PffDdhMwVgQ6wj5V+TAR+0b3kBUeSQveXUJrTNdYAF86PXX/tKJD6nuHmcIs2odd1OP3
 i5HT7ad6zCA5aJiZGv7hq6x1lx2bN1vZXHa0qSxBy3qAOlZxeWP070DxRJTqk03HDu4/
 VSc/LTE+CiicFHlxfsGygXDsjmXjc0CADIHMUG9MUncuowFVrQe4s1C6CnYuHgFwg+dM
 pIetg53pDpSEURk3K9Bc2LCpaviHM3D9iUZszmx8/nwbXPd7dMoNDUrlqE8ZLQNcbzsB
 URhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736401830; x=1737006630;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HrjmQS6sDIDwKO+UJvxDveSWdwDMaPIQvkl3e1u8m48=;
 b=uSx7BoKnewqwci9jUMbp1PxhTXXBX++axRP9DVGO1h07UN8TIIpaxMAa6J/s4u8DVC
 A50Lr6j9d4OnAS47Yz63R4BphEHGUp1lLOPKbu35kQbIxDn1CjKTJug5swC04JEiAoXS
 JewRrokYt+syC0M7qEhlMC51ehO1hLdvyQJ9fO3CQzL8Pt9IkQBSLCtJDomS90R+Fute
 T+JOO1hbsSWB0fp5bOu4ay2ztRgxTTXbJY/d7L3C8WcOB6Kfxy+hdO4Tl1lUrSvMQbmn
 rGybc/yCEt7NVK5NCyIyRot8zKifqhgeDD+cdIeaf/zGDq4TE5u218tPsJpTZKuvHLsa
 Qyhw==
X-Gm-Message-State: AOJu0Yy6D/KsxPE0AjHNBxtafMIJw/XlJaX/PR/odaaeMWRQJKO64ywo
 quLOKq30DmAvgWo/le5dFoleWETVnxuxUJoEPVAvefebpMb2D3oy6M0kR1zlnx8=
X-Gm-Gg: ASbGncsQWXYsw2R2q5+WmfMEaTBZUOeNaUxkuYoiF1pzjJOPSDlCgXPBRmBQKZ0UB7Y
 HDy0fVR3Jm0XFcjTPIe7zWCA+PQiFRx7AZ2fbqov06SRy+Gdx0wel7lom4X/2Js1nSE3AvxEKVe
 ScAiGoFhAKz9/j5wV54np97GmrSj0VsYzZjMqma+5aYMbuh+mLXDdaKUnAP/Y4rwlIQoTEOcEvI
 IL0q0bmx0skZzjR3v1cpmiVqVRHOb5wnxBmcggqPgFbEcnfIojSDNwd31s=
X-Google-Smtp-Source: AGHT+IERQ54fABtvWgN2RTv17Jsfsr9C6EZNXHGFJO+/cvCXjplKNj2v8zUVi67Utytq796kQEHIfQ==
X-Received: by 2002:a17:902:f644:b0:212:40e0:9562 with SMTP id
 d9443c01a7336-21a83f69651mr82857365ad.25.1736401829884; 
 Wed, 08 Jan 2025 21:50:29 -0800 (PST)
Received: from localhost ([157.82.203.37]) by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2f54a26accesm2670174a91.6.2025.01.08.21.50.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 21:50:29 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v7 0/2] Fix check-qtest-ppc64 sanitizer errors
Date: Thu, 09 Jan 2025 14:50:19 +0900
Message-Id: <20250109-san-v7-0-93c432a73024@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJtjf2cC/2XQy2oDMQwF0F8JXtdFtuVXV/2PkIWfjRedKeNiE
 sL8e50xISmzvELnInQjNS0lVfJxuJEltVLLPPWg3w4knN30lWiJPRMOHEFxSaubKFjtssuYWeC
 kb/4sKZfL1nI89Xwu9XderltpY/fpw6vNN0aBZhECcgGcGfsZ3XUql/cwf5N7QeOvSA/EO9ISv
 AeLKvq4Q+KJNJiBREceRFaaBYSgdgifyHAxEHbkOAYVs8OQ/A7JB5LAAAeSHRmPAlDqfuL+PPW
 KxiOb6oixHIy03lqv/6F1Xf8ABb5XlaABAAA=
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
Changes in v7:
- Don't open code memory_region_ref(). (Peter Xu)
- Link to v6: https://lore.kernel.org/r/20250105-san-v6-0-11fc859b99b7@daynix.com

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
 system/memory.c       | 24 +++++++++++++++++++--
 2 files changed, 50 insertions(+), 33 deletions(-)
---
base-commit: 38d0939b86e2eef6f6a622c6f1f7befda0146595
change-id: 20240625-san-097afaf4f1c2

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


