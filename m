Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2747BE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 10:55:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNrhD-0000cQ-5U; Wed, 18 Dec 2024 05:54:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tNrhA-0000bl-1d
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 05:54:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tNrh7-0006mD-M9
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 05:54:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734519258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=t0lhJg/mvYw8fdRak6ZghlUJNMFCv8Se7K2CJkMME5Q=;
 b=XhCfRrbF4ROWURTRSlttEW8r45l7tNFmMcPTjEmWyaZRenvvGm2nxnRKrfDeuNyXbRPR/x
 EaVNuXemMlbWJo3yLGZpJcxaZXsznQxKspBKBFs8GFQIbuQDP4+nVM0KmJo+2I8/+HwKDq
 NGUymdJqBgZ0u6n9rPlGHKMvL6p9wEI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-aWtNE8_KO_iH6eOy6oEepA-1; Wed, 18 Dec 2024 05:53:08 -0500
X-MC-Unique: aWtNE8_KO_iH6eOy6oEepA-1
X-Mimecast-MFC-AGG-ID: aWtNE8_KO_iH6eOy6oEepA
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4362b9c15d8so28986505e9.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 02:53:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734519187; x=1735123987;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t0lhJg/mvYw8fdRak6ZghlUJNMFCv8Se7K2CJkMME5Q=;
 b=MOQq5ACHumwUeQq2OHX+aP9jF5admvVO8eoeMwFA3MPbJreG/5wV0S0mbzP7gIeBoZ
 +M1FClNHFaye6WuU83KX1OmfGx05wHmnmKcmXXhYQ3m2VyoFkXTONWdIoKj7KAcD5Jm5
 VdB1fMZZ9eUAnG1ljLQ0Cib8OkM0yoKxUzKonzTz7x3/MmjHmq/4rZyVwaybTjgJr1fI
 VweIPNbjcKOCh3Y+fd3F1Wiuk7Bd4AvPrIvgKqEgJtNxsTeQgNdo8QvDqsbT4uSTIoGG
 kErPkdf8nm0hJFlmwudZGzykA67r/A8CoByXTmT5gfRRJeQD2E1ZQ+no97KWs8EJRk9h
 OU0g==
X-Gm-Message-State: AOJu0Yy6mII4rl9oW859wbonkdvVdRJb772USUppmVr05fCo0rxff9dI
 3VBdOt5fZv2jcrigs5yGr2SXF863ZUHQJ4dHb3BGwdynOkIJpOqyzqSQPwig9C6nmvz19PdrYJW
 R0vZibFkYI4L4Orya1nx7RRM/IpaBtr0CYTdYqseAUQ5mOnF1p+sPLE7c6WY2qzJmIDGTOHPfgN
 KUVRvyeYDRYrPefGbg90dsNFBuo9Yl0N/rHUg=
X-Gm-Gg: ASbGncum8xbER5c5Uvqer2ASlBwBJh+aLJZpzubHujW6/uuPI2yv+Zh4uG2GsC0MRT/
 JKZv/wZtNz7g8KR41GrDbbQRhAOf1YjenwBnkDAdC8oouF2B2JC5IQ/ADlmd9ATQoctCAhz5wGP
 NYIVMfCp7hzsiqgJPZap0W5Fw6WuKT1/JZR5NUmAgur1tYhiyeZ6Ar6fe34vKXsLFYXt9za+BbV
 dzCVoikSb1WekAmlZ/09vo8ReY0Cqwo156MsvML7+PjZZDAsZRxo7fKrHTKDnv+oZLyF/J8bXkZ
 MEmy1eQSqOSZEkU49U4hZwuDmmkHgs+7A4H99tmMxQ==
X-Received: by 2002:a05:600c:468a:b0:434:9499:9e87 with SMTP id
 5b1f17b1804b1-436553fe17dmr15955555e9.25.1734519186821; 
 Wed, 18 Dec 2024 02:53:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGU6FOClPGPAy4B0xYMkACLZsqVugyK18upU6jqW8o/gMshW/5iQT7m8IsNYJ8/KH0/jXlKlA==
X-Received: by 2002:a05:600c:468a:b0:434:9499:9e87 with SMTP id
 5b1f17b1804b1-436553fe17dmr15955185e9.25.1734519186269; 
 Wed, 18 Dec 2024 02:53:06 -0800 (PST)
Received: from localhost
 (p200300cbc73f8300a5d5c21badd3cf50.dip0.t-ipconnect.de.
 [2003:cb:c73f:8300:a5d5:c21b:add3:cf50])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-43656af6c5bsm16439475e9.2.2024.12.18.02.53.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 02:53:05 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL 00/15] Host Memory Backends and Memory devices queue 2024-12-18
Date: Wed, 18 Dec 2024 11:52:48 +0100
Message-ID: <20241218105303.1966303-1-david@redhat.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=dhildenb@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 8032c78e556cd0baec111740a6c636863f9bd7c8:

  Merge tag 'firmware-20241216-pull-request' of https://gitlab.com/kraxel/qemu into staging (2024-12-16 14:20:33 -0500)

are available in the Git repository at:

  https://github.com/davidhildenbrand/qemu.git tags/mem-2024-12-18

for you to fetch changes up to eb5c5f1ab479e9311d8e513e3eeafaf30f2b25b3:

  s390x: virtio-mem support (2024-12-18 09:50:05 +0100)

----------------------------------------------------------------
Hi,

"Host Memory Backends" and "Memory devices" queue ("mem"):
- Fixup handling of virtio-mem unplug during system resets, as
  preparation for s390x support (especially kdump in the Linux guest)
- virtio-mem support for s390x

----------------------------------------------------------------
David Hildenbrand (15):
      virtio-mem: unplug memory only during system resets, not device resets
      s390x/s390-virtio-ccw: don't crash on weird RAM sizes
      s390x/s390-virtio-hcall: remove hypercall registration mechanism
      s390x/s390-virtio-hcall: prepare for more diag500 hypercalls
      s390x: rename s390-virtio-hcall* to s390-hypercall*
      s390x/s390-virtio-ccw: move setting the maximum guest size from sclp to machine code
      s390x: introduce s390_get_memory_limit()
      s390x/s390-hypercall: introduce DIAG500 STORAGE_LIMIT
      s390x/s390-stattrib-kvm: prepare for memory devices and sparse memory layouts
      s390x/s390-skeys: prepare for memory devices
      s390x/s390-virtio-ccw: prepare for memory devices
      s390x/pv: prepare for memory devices
      s390x: remember the maximum page size
      s390x/virtio-ccw: add support for virtio based memory devices
      s390x: virtio-mem support

 MAINTAINERS                        |   5 +
 hw/s390x/Kconfig                   |   1 +
 hw/s390x/meson.build               |   6 +-
 hw/s390x/s390-hypercall.c          |  85 ++++++++++++++
 hw/s390x/s390-hypercall.h          |  25 ++++
 hw/s390x/s390-skeys.c              |   6 +-
 hw/s390x/s390-stattrib-kvm.c       |  67 +++++++----
 hw/s390x/s390-virtio-ccw.c         | 165 ++++++++++++++++++---------
 hw/s390x/s390-virtio-hcall.c       |  41 -------
 hw/s390x/s390-virtio-hcall.h       |  25 ----
 hw/s390x/sclp.c                    |  17 +--
 hw/s390x/virtio-ccw-md-stubs.c     |  24 ++++
 hw/s390x/virtio-ccw-md.c           | 153 +++++++++++++++++++++++++
 hw/s390x/virtio-ccw-md.h           |  44 ++++++++
 hw/s390x/virtio-ccw-mem.c          | 226 +++++++++++++++++++++++++++++++++++++
 hw/s390x/virtio-ccw-mem.h          |  34 ++++++
 hw/virtio/Kconfig                  |   1 +
 hw/virtio/virtio-mem.c             | 107 ++++++++++++------
 include/hw/s390x/s390-virtio-ccw.h |   4 +
 include/hw/virtio/virtio-mem.h     |  13 ++-
 target/s390x/cpu-sysemu.c          |  15 ---
 target/s390x/cpu.h                 |   2 -
 target/s390x/kvm/kvm.c             |  18 +--
 target/s390x/kvm/pv.c              |   2 +-
 target/s390x/tcg/misc_helper.c     |   7 +-
 25 files changed, 866 insertions(+), 227 deletions(-)
 create mode 100644 hw/s390x/s390-hypercall.c
 create mode 100644 hw/s390x/s390-hypercall.h
 delete mode 100644 hw/s390x/s390-virtio-hcall.c
 delete mode 100644 hw/s390x/s390-virtio-hcall.h
 create mode 100644 hw/s390x/virtio-ccw-md-stubs.c
 create mode 100644 hw/s390x/virtio-ccw-md.c
 create mode 100644 hw/s390x/virtio-ccw-md.h
 create mode 100644 hw/s390x/virtio-ccw-mem.c
 create mode 100644 hw/s390x/virtio-ccw-mem.h
-- 
2.47.1


