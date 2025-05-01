Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3371BC3ABA9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 23:02:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAcuZ-0008M7-NV; Thu, 01 May 2025 19:01:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAcuT-0008KW-8F
 for qemu-devel@nongnu.org; Thu, 01 May 2025 19:01:41 -0400
Received: from mail-io1-xd2a.google.com ([2607:f8b0:4864:20::d2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAcuP-000273-FD
 for qemu-devel@nongnu.org; Thu, 01 May 2025 19:01:40 -0400
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-861d7a09c88so46001939f.2
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 16:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746140494; x=1746745294; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MH6wU6NDwqP76l8625bC5nY7u3bJflZcJnDNoiM4n48=;
 b=Nh6bHRLYWLNwWb2x52CE1PmvRHGS7QWtThANOzT0E0uyDrKU0/IxBb2MBqLCfSKbnO
 SNED8Wm5+Ns+SoDv57aiRh+b2Gp6DZg7SIEMVJJbhOS8rJw86KAGA4dAolyP6mWVQs8V
 QZeu1fZ2WyfS6ukzAtkpX40UwdkpUQFOCUVScnujZGLLHkyz0FkxwkB3KeAh0CriyKlM
 M/k5Ac1arAsAP3yf/iXpJfu6pJEqGmHzXQ1nUX6f+Fe5c4pKVOcldBA7w7AD6dmPS3h7
 vwxwmYG3zarmnXtM2YFGsIeJ0zGDf5ElPd4qz6i4pNb8vQZ47/2Wc4GAiXymTviuMNJ6
 Ppag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746140494; x=1746745294;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MH6wU6NDwqP76l8625bC5nY7u3bJflZcJnDNoiM4n48=;
 b=NbvMQiSWqdxhHfan1NzVE0YbIY5Cr/W4kJcDw/uvfb2OZGSUuc4iesC/KDkicwh9L3
 Hzq5+KRJkXrsBzbU2/bP/kaEnpJrTi/hMEBcTJeo6S9nf+yKzAY7AfvSFrBoT0rhyOHj
 BYG2tOIBeW4MiGH9dPis2bTPQfjPu92h3X3HYY1l7C0vyAVpVuKstXv3vz9kVbxty62L
 /maw5sR+cRWLrzGGcfeyXb3moy6QAPonlXzGAGly8IT2eSQnZsjbwhDCeFnYN6L6JfRu
 JMKDRt4kZu9CiXlKEkDaaxU0YZ01ItZxdMrLCfr2rffZE1uNlkBHjHuPolAan2fsJhJ4
 xAjg==
X-Gm-Message-State: AOJu0YyO/9cD7HViKiGEAQxtpsMWAxT1UMpfV7KGzY7u67uFRXuKHY7h
 FrJIMHFVy3aXKwYWcKByCTyzscbHuzQ/dOAiPt47/fdrsw50GvKn9xzkK/5QXMApgIIF4lej7Uj
 0
X-Gm-Gg: ASbGncssxONO1yddo4TgzuybCH2VIiozaJVXC4Wl7oi0qgBq0EjHMbAS2Y9SQ19a6+g
 B1RPkeMZP9J4Xl+Jg2s9orEaNuES9X6DwLnQqSLj/6d6zNIUHj3UuKGkUX32tBuDeEGS8QBnQkZ
 2/o95TCsIyMyi8eE64A641oGn3nurE5xJkkLbPv+nBMDswSRwFFm9t2pndZbjn85LASUwZAXDy5
 51a7kGwM8vXcs559u+OLH5Urt1JeTs/NBOlvtsnRSZ5ZdJ5iKxxbYNlsGcyjGmGKBEjHaDDtK96
 Q73h1yEcBzuimxv9zZmntYMVUfbwH5FVD0rWx2DnAzPGNzYxgAPvhFPDpB9V5XpKmGmnp9ob6tS
 vkvCF5WzxwQpE+D+5GP/o
X-Google-Smtp-Source: AGHT+IElcqZnjy9X7fU7YX7JcC3rrkJVuqh0P3WHhdtFzTwT4E+3FjjlKsShTYuamRWgvqGQOHzLPg==
X-Received: by 2002:a05:6602:3a10:b0:85a:eecd:37b with SMTP id
 ca18e2360f4ac-866b3490246mr125452639f.11.1746140494636; 
 Thu, 01 May 2025 16:01:34 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f88a9416edsm87510173.64.2025.05.01.16.01.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 May 2025 16:01:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-rust@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Eric Farman <farman@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH 00/10] hw/core: Remove hw_compat[] array for 2.10,
 2.11 and 2.12 machines
Date: Fri,  2 May 2025 01:01:18 +0200
Message-ID: <20250501230129.2596-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2a;
 envelope-from=philmd@linaro.org; helo=mail-io1-xd2a.google.com
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

Include Thomas s390x patches from [1], with the other x86 machines
removal in [2], 3 hw_compat[] arrays end unused. Remove them,
including unused properties.

[1] https://lore.kernel.org/qemu-devel/20250115073819.15452-1-thuth@redhat.com/
[2] https://lore.kernel.org/qemu-devel/20250501223522.99772-1-philmd@linaro.org/

Based-on: <20250501223522.99772-1-philmd@linaro.org>

Philippe Mathieu-Daudé (8):
  hw/core/machine: Remove hw_compat_2_10[] array
  hw/input/virtio-input: Remove VirtIOInputHID::wheel_axis field
  hw/core/machine: Remove hw_compat_2_11[] array
  hw/timer/hpet: Remove HPETState::hpet_offset_saved field
  hw/net/e1000: Remove unused E1000_FLAG_TSO flag
  hw/core/machine: Remove hw_compat_2_12[] array
  hw/audio/hda-codec: Remove HDAAudioState::use_timer field
  hw/display/vga-pci: Do not expose the 'global-vmstate' property

Thomas Huth (2):
  hw/s390x/s390-virtio-ccw: Remove the deprecated 2.10 and 2.11 machine
    types
  hw/s390x/s390-virtio-ccw: Remove the deprecated 2.12 machine type

 include/hw/boards.h              |   9 ---
 include/hw/virtio/virtio-input.h |   1 -
 hw/audio/hda-codec.c             |  91 ++++-----------------------
 hw/core/machine.c                |  23 -------
 hw/display/cirrus_vga.c          |   2 -
 hw/display/qxl.c                 |   1 -
 hw/display/vga-pci.c             |   1 -
 hw/display/vmware_vga.c          |   2 -
 hw/input/virtio-input-hid.c      | 102 ++-----------------------------
 hw/net/e1000.c                   |  58 +++---------------
 hw/s390x/s390-virtio-ccw.c       |  51 ----------------
 hw/timer/hpet.c                  |   9 +--
 rust/hw/timer/hpet/src/hpet.rs   |   9 ---
 13 files changed, 27 insertions(+), 332 deletions(-)

-- 
2.47.1


