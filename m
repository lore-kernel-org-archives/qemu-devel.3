Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93149FD88DF
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 02:28:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w09J0-00011l-Cr; Tue, 10 Mar 2026 22:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w09Im-0000rP-Ih
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 22:28:01 -0400
Received: from mail-dl1-x1232.google.com ([2607:f8b0:4864:20::1232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w09Ik-0003up-2U
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 22:27:59 -0400
Received: by mail-dl1-x1232.google.com with SMTP id
 a92af1059eb24-12732e6a123so209865c88.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 19:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773196076; x=1773800876; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CxuOuoUY3iwzSsldpIcUNFZN7AX7v7/Bj/Eb/x0JBd0=;
 b=CM/CVMJTzg0DbmUfooSfq65rX4rfaIaj602iolYzlalAY54UAlMcbQujRQ7yKpJyAO
 UAEs/k0PYAcTDqPpbUP2eHudOTW8qV8w+B7eSO8QSPTDCNNAEj84LzEfkS1Ffwkas6pI
 9cIEIsFbsTeTibJZE9zk8pBrjGHYjREYvzDzSQrMLljxQ75Cmfi5o2nqvuSW37dGy0oP
 +iLa0TEkrhQnRlyMnhGIGxMy1Cq4yzCAxKgWXW0IJszgH6rlSl/+9LmQCySaULmeCGKH
 XK5dGqclb8rgVazwCO3qCFHbpNK2+myJTUT+LDqYcOXBTXWZWztRJm29yDVEn5u4jb0q
 wrOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773196076; x=1773800876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CxuOuoUY3iwzSsldpIcUNFZN7AX7v7/Bj/Eb/x0JBd0=;
 b=JzD5nJdv213MLHYybkaSrCge0a022C7FfvuI/mNZ0qYhtEr93qqrHnBxFIK28S581r
 85RZjhASU9AoDcRzFoxUKuVQLwjRjlT1ov4KXYMD0MFlo8jWBGFfKaiI2ALttwYWiAA+
 wsZKnxagjDzJRvxX4c66+2JMJyqdCt6Er2gPkf5vmXDkseDeaJCGN39UWecYhueD3p9I
 AEzi3SotUCKVZxqGMNNBw1zmcHxPOS/B9Ig/j46bbtYl75MDFGXIR0Mr5SO6OLZlmgwm
 QmAOff3CNMOC+OLPeeQh0Z8Cy3tIOsn/Ax+T7UyVZtZ5JnYCIqpv2W5TotsdZG/mm/Cp
 uvBw==
X-Gm-Message-State: AOJu0YzDXq3OIwhSIykaJB7nBAtBMpwnBYt09IIR+e/bUmIH715inbz2
 ugxgBvUQRWQE9Gyj7I3gaYFH35cophGmvBBqh/SJBmd5+gzzmNx7y7ffhy3o+A==
X-Gm-Gg: ATEYQzzVh1qtNyajS5Mizd9IvG4nzvcm8UsmulUaHppWiDPRUvrHRZizMR1Vqay4fYW
 NtRJSoES/kKKDIf34G/JdeG5vrgggGh3vdJSOJOnFOWrgJQR+TBWuet4PpJ3v75zi7L5q2UNgNC
 ceJ3wc4Shp3mLmp/MNYMoXnKs+c2L0f0AEEqawQXaZtaTQDkavzkaUMi5zCeq6sKQzstIYhTQOS
 YhC4EDf/CPAUtDX+YYCCcexq9X8rprIt5HhcKIRfZSaffCGpb+1/6lTn0M5Q9hQUrHA4xjiGkh5
 51Ahw7mJqcOzNwqzGI318ZhffsJSEeeMB1D7Iqy0R6UfXOesUmP5yfsAjWRDrmiI+rga0FE4ZNH
 qCbLeOK64d64C3Dx6F7IAIAWSdzdZChdiXI+LEDFLsybvE0UzOi9CgM/KnE45WvTNrkC3wAdqMF
 lWzLxNOF/cRwbB8fqmA5CEXJxjENjuuBGkO2geXhcS7zc9A9DULRk=
X-Received: by 2002:a05:7022:30d:b0:127:9c10:446c with SMTP id
 a92af1059eb24-128e77aae60mr475766c88.7.1773196076228; 
 Tue, 10 Mar 2026 19:27:56 -0700 (PDT)
Received: from 192.168.0.29 ([2804:14d:4c71:86dd:80a9:8ba1:b664:ae3d])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-128e7cd6aafsm915123c88.14.2026.03.10.19.27.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 19:27:55 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: qemu-devel@nongnu.org
Cc: Lucas Amaral <lucaaamaral@gmail.com>
Subject: [PATCH v2 0/3] virtio-gpu: enable Venus/Vulkan without OpenGL display
Date: Tue, 10 Mar 2026 23:27:49 -0300
Message-ID: <20260311022752.64192-1-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260309214930.92616-1-lucaaamaral@gmail.com>
References: <20260309214930.92616-1-lucaaamaral@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1232;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dl1-x1232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_BARE_IP_2=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Venus (virtio-gpu Vulkan context) currently requires OpenGL display
support due to build-time and runtime coupling with the GL backend.
On macOS, no OpenGL display backend exists (only Cocoa/SDL2 without GL).

This series decouples Venus from OpenGL:

1. Define GRAPHIC_FLAGS_VK for future Vulkan scanout support.

2. Remove opengl.found() build requirement for virtio-gpu-gl module
   (virglrenderer provides Venus independently of GL).  Gate GL-specific
   code paths behind CONFIG_OPENGL and display_opengl checks.  Route 2D
   display commands to the software renderer when Venus runs without GL.

3. Define VIRTIO_GPU_F_BLOB_ALIGNMENT (feature bit 5) in the virtio-gpu
   header per the OASIS virtio specification and advertise blob_alignment
   in the device configuration so the host can communicate its page
   alignment requirement to the guest.

Dependencies: none.

Changes v1 → v2:
- Remove hvf_get_map_granule() Venus safety check from this series;
  the check moves to hvf-map-granule where the function is defined,
  so venus-nogl compiles on all platforms without cross-series
  dependencies.
- Extract GRAPHIC_FLAGS_VK into its own patch.
- Fold standard-headers addition into the blob_alignment patch.

Lucas Amaral (3):
  ui: introduce GRAPHIC_FLAGS_VK for Vulkan scanout
  virtio-gpu: decouple Venus from CONFIG_OPENGL
  virtio-gpu: advertise VIRTIO_GPU_F_BLOB_ALIGNMENT

 hw/display/meson.build                      |  8 +-
 hw/display/virtio-gpu-base.c                | 15 +++-
 hw/display/virtio-gpu-gl.c                  |  6 +-
 hw/display/virtio-gpu-virgl.c               | 84 ++++++++++++++++++---
 hw/display/virtio-gpu.c                     |  8 ++
 include/standard-headers/linux/virtio_gpu.h |  6 ++
 include/ui/console.h                        |  2 +
 ui/console.c                                |  6 ++
 8 files changed, 119 insertions(+), 16 deletions(-)

--
2.52.0


