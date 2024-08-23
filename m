Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C30BCC531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 06:14:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shNYB-0001sD-K7; Fri, 23 Aug 2024 02:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1shNY9-0001qa-Aw
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 02:13:29 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1shNY4-00035l-OP
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 02:13:29 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-70df4b5cdd8so1226013a34.1
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 23:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1724393603; x=1724998403;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+gt0dYjLMSe2zFM5R7M7cc8Fe2txWxU+8nVV6tzM/0E=;
 b=g6o9X20mSojTQ/nJO/xUpOfU5oB5uZwL5zGzHpMiriMNTjz4sHCO45A0bmVqQd/6je
 EEip5dCACTNxj0h4mgzmNdqKx6TqRTDh1y96QkviNPbJ7HlNVfGiItD+GP4ooFqcuLsf
 vvr9rS3dravZjczMzMsvqZM7Q/fAgp7Ov/YsfDUoQ9Tu1mZtsW1iDaKlhyB0VPdYGsTM
 LkgvrJL9zR5+3eaT2oMlkUBMqbk+i9htHoVkONB0dRNC9szQMO+jwkyY5+L59oPtgiDN
 +zDcfy0aTMXCLnwNA3Tasd1ku59bUu40TcXY9a2eWL1jRiF5/SbuxDDhSI+9ecvXZPrm
 22eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724393603; x=1724998403;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+gt0dYjLMSe2zFM5R7M7cc8Fe2txWxU+8nVV6tzM/0E=;
 b=Vcu8o4XV3G6N8qnpXaLnAPlOepR4uOTwE5mok4Lz8ztQSMP/qA7k2y3bBGXfG3Qwqf
 MNcrAlS8zq21f5oygs49ILBbxgX4VIW6nF+5LWZ8iVynIKB6SmO+EK9FgwC63eJr/Ij0
 ZWpnXGdC+enU+r4zrdLbTwWdxA23S1RDNWWaaO+VQTPD3k2HjLA6eurf3tpc43EvHqzr
 Y7g+5OKRoDIWKSr4e4h1aWhALrJpLCPXs5q1OODypibWn8WMYapT/Dygdf7iAVrmnpve
 49LSbVhNcMSW/+hdeKPWDKO6pERwdHsWvf/ybsRlGg9DTjfhT9PfuCnu63tflLaecs7d
 Pl0A==
X-Gm-Message-State: AOJu0YzuTFhufdU8KFMEw2vGWKaomije+SdcNCaPV1UAR9eKGq3G1O6o
 zeWrLMxr4U6H+A8N/Ljb0g91EAVseZLPcALIzocIbFIXw2Uzt1ei+wru5wt9bCw=
X-Google-Smtp-Source: AGHT+IGgxHkc/Abd612tUVl1Wc6W3nDhA6fE+vjYQVuotgAoa0Bs1trFjNYjKhJth4aTR46HFVDd7w==
X-Received: by 2002:a05:6808:2395:b0:3d9:32db:e2fa with SMTP id
 5614622812f47-3de2a8b93c1mr1360552b6e.36.1724393602927; 
 Thu, 22 Aug 2024 23:13:22 -0700 (PDT)
Received: from localhost ([157.82.207.23]) by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-7cd9acabfe5sm2330029a12.25.2024.08.22.23.13.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2024 23:13:22 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v4 0/7] Fix check-qtest-ppc64 sanitizer errors
Date: Fri, 23 Aug 2024 15:13:05 +0900
Message-Id: <20240823-san-v4-0-a24c6dfa4ceb@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHEoyGYC/2XMSw6CMBSF4a2Qjq25fdCCI/dhHPQpHQimNQ2Es
 HcLxKhxeG7u988ouRhcQqdqRtHlkMLQl8EPFTKd6m8OB1s2okA5CFrjpHoMrVReee6Joah8PqL
 zYdwql2vZXUjPIU5bNJP1+vZi85lgwJ4ZwykDSpr2bNXUh/FohjtaA5l+I7kjWpCsQWtoubDa/
 iH2QRKaHbGCNDAvJDEcjPhBy7K8AA6sb8sBAQAA
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
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::332;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x332.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
Akihiko Odaki (7):
      migration: Free removed SaveStateEntry
      memory: Do not refer to "memory region's reference count"
      memory: Refer to docs/devel/memory.rst for "owner"
      memory: Clarify that owner may be missing
      memory: Clarify owner must not call memory_region_ref()
      memory: Do not create circular reference with subregion
      tests/qtest: Delete previous boot file

 include/exec/memory.h        | 22 +++++++---------------
 migration/savevm.c           |  2 ++
 system/memory.c              |  8 ++++++--
 tests/qtest/migration-test.c | 18 +++++++++++-------
 4 files changed, 26 insertions(+), 24 deletions(-)
---
base-commit: 31669121a01a14732f57c49400bc239cf9fd505f
change-id: 20240625-san-097afaf4f1c2

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


