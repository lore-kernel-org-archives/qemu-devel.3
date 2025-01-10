Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD9C5E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 09:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWBBo-0007jX-C0; Fri, 10 Jan 2025 04:20:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tWBBT-0007QV-LM
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 04:20:10 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tWBBP-0007LL-BW
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 04:20:02 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2166f1e589cso36254595ad.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 01:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736500789; x=1737105589;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Jk+07lK6VDS/396dsk7WIotgNr7btU0M8GRf8joHSLM=;
 b=Owyv1QIhLYLMJfOqt+E+XPF6tGlXQ7qdqGefGiRrTe2iskgIiSJ0MN1WejqFbR3hET
 jpo2Ba62jog32mGVgZRM44jAm2TDM+dj4UA06i1KQy595x7nsY0M0D4CC2RSymmrxLUe
 EE58JxLKWWb/iJtskhM6TvsKVlHQoKndSNjiOFf+UWSjM8GGGR2dBUXYNAeM4auy6/ub
 iS8Ji6YdSKsTg/WfFJHo/Q5FD5vGdXtgdEFtiP483Q14ugl31KjLLliLB5tFbHRVCb9N
 mpFd1+8aLH1RXpWOYIQ832QMdvzowSeUhVryBRxCl/J3JCs8W2711e9mdPy+bjGsHPUs
 g8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736500789; x=1737105589;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jk+07lK6VDS/396dsk7WIotgNr7btU0M8GRf8joHSLM=;
 b=FDh5m8ekoIqxlE6tvs3AiL9JAQAijfbNWtqe0NoZLWeekYQcqD+3NymTuD6eTDoaQG
 KwDKpZPwe2oEkDZxIPWQWyR1NWEwJk4p8WQ4swT/7EqcCVsNgXBhOZpqSKse8bw7Y0kn
 973sTRZ1GBO3CMahUWRMcw+E/JWanBKy8Lvc9YN5WwdlhHxx0H5lymyjp+pmf7lJJL1z
 A5dkpFUjskyCLpRMii/VhDu3VvDhi9P3WKSj5kKqeVDUQaEJgipnk+2VmIqzmeHmdMRe
 7H5sJVDKa6WtDUFUAt1VrOVD+AJhEZiUOpYRh2QHeq646ZN1lI1thcAF+8wiiDe7wpGg
 mMwA==
X-Gm-Message-State: AOJu0YwDEq/BZYBt78r9ZU6KlEAZ97tQZtyv34zgQkqqF4Xz0LfMfjRj
 aOYkSvJT0JNqQUahqiryaz9y7/NBIei49N8Ya/xGkXYHIcO5O0dlOKfoxQzO+aw=
X-Gm-Gg: ASbGnctgurcwuuxpy/hJtehI6V+Ni1F5OXhZY05kkoxPdwhSoaHZteTpl9mDJK/d/VF
 TQW80V7QiQW1kbT7yJ7vzbniZHlFOpG6TemPHsEr4/305unrb7BAo7RWd6nDtr9U5JSTn65eEcs
 SxMJ91DKOKQy2byCjDZye20nd8hkdwXJ47boA0Uyl6V2b7f7gseGmoCafr2M9lNP78doRUT7zRc
 SXKDspMM1JeQIIAm6lamU9EpxKzy6JMFgxqIFV0few0gB0fA8f8NJcoS4g=
X-Google-Smtp-Source: AGHT+IGaJgpZPJPWEt+tsKs5qOiR85m+0m/bNR9gncVIIpAFKsKZhV6L6D+naawSNulLX5kGJb3/kQ==
X-Received: by 2002:a05:6a00:3e01:b0:725:e057:c3dd with SMTP id
 d2e1a72fcca58-72d21ff4b72mr14983503b3a.22.1736500789527; 
 Fri, 10 Jan 2025 01:19:49 -0800 (PST)
Received: from localhost ([157.82.203.37]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-72d4067e682sm1145831b3a.125.2025.01.10.01.19.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2025 01:19:49 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v8 0/2] Fix check-qtest-ppc64 sanitizer errors
Date: Fri, 10 Jan 2025 18:19:33 +0900
Message-Id: <20250110-san-v8-0-57a5a1be1bcf@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACXmgGcC/2XQz2rDMAwG8FcpPi9DluV/O+09xg62Y68+LBnJC
 C0l7z41pjQjx0/o9yF0E3Oeap7F2+kmprzUuY4DB/dyEukchq/c1Z6zQEACg7qbw9CBt6GEQkU
 mFLz5M+VSL1vLxyfnc51/x+m6lS7yPn14s/lFdtAVlRKhApTOv/fhOtTLaxq/xb1gwT2yDSEjq
 yFG8GT62B+QeiILriHFKIIqxspEkMwB0RM5VA0Ro4CUTF8CpRwPSD+QBgnUkGbkIikgbfnE43l
 mj9ojF8NIypKc9tH7aA/I7pFvyDLyKpHCYPl/9A+t6/oHfZ90S9UBAAA=
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x635.google.com
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
Changes in v8:
- Clarified that the memory region should be passed to object_ref()
  when creating a reference internal to owner.
- Link to v7: https://lore.kernel.org/r/20250109-san-v7-0-93c432a73024@daynix.com

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


