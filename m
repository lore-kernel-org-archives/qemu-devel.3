Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F89C44507
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 10:34:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkfsx-0003Ju-69; Fri, 17 Jul 2026 06:33:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1wkfst-0003JV-S5
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 06:33:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1wkfsj-0001QG-Vu
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 06:33:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784284403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=5Qxu0KgocDPBXb/+Ky6eB98Te/jjicGmJp67/Iki01M=;
 b=Z03aV+IvBPdS9qgduJazPrNZ+oXwdtEM9oWBFan7Gy3PycbmrGTSgK9NfXpuXskQ5zf1gY
 km1clhn3MqegqN3qOnYExZk0zDPHtDmht4ZsBgamzOUSzOU2x5ZF2+T+Ezrdxc5KB/uKMj
 aUdUaBG2hoEMn7xvhWvPkvPMKHOED8o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-F3D6k1MlPZKVnxPCb32nDA-1; Fri, 17 Jul 2026 06:33:21 -0400
X-MC-Unique: F3D6k1MlPZKVnxPCb32nDA-1
X-Mimecast-MFC-AGG-ID: F3D6k1MlPZKVnxPCb32nDA_1784284400
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4954a960ed3so3910535e9.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 03:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784284400; x=1784889200; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5Qxu0KgocDPBXb/+Ky6eB98Te/jjicGmJp67/Iki01M=;
 b=ePI0anpgqq/9R4B1rzPmUN57aBJv3l6Q/+FAmscKYcUR8J+J9HpKHYgEWBFIEqPyFk
 2Ev1ZViHdJjA1BtJo95WYbtnT1/3e5YMcC+one+JmJfnUPEfgd5uwTxtWn4k0wo4fQST
 A7y9Uqq32wWEyBZ9ZVzc4GkINC1zdgvrbSkfAJJsja9nyqZ3+5vUtcLMAIRHPVryfQb6
 7VLe1jDWnbBjGxNPoO1h9UobE5LlwvW5DmxrTTg8tWW9v5/cbeD+JzBAUFZ7WMvyc2h+
 YMWgWLgNiWmHyj6GENrPW/KpeZIAIUX3OoEuC7toXV2FXFh0luVERM8GXf1jL25m4iew
 Ss+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784284400; x=1784889200;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5Qxu0KgocDPBXb/+Ky6eB98Te/jjicGmJp67/Iki01M=;
 b=TEoB4rwmr9Y/UayFRoA92/MzRHe68Ap5po7DQTkcILKMqJSvLFLFODUfqyZVjdHF4K
 XHCtEXq6CWL1S1aItzQsM3pzH+qOiwUlCYKkChN2+jco5BqCb1GiLOet86vjIFzNnwP6
 MRidfjndIptEGnx3fL/lbl8jYLHUiYrPS5/5/h/j+KbGlwVFzHoBvMDfq9ArVts2i/N3
 piPZxXrvMXjhAYm6MC+zwuEPXGgO3U30K5aMj5IM5u/KrzSXl1y1zBzetaMYw15L2uop
 +4xoRltu/qv+aohYcFmub6Xe5cegOlGBrfWfHJI6ZPD7v/w5pgKCXXZbNGcv3X6UkZHD
 e6Eg==
X-Gm-Message-State: AOJu0Ywz3KWitITkJlXAQIhfArH1nDezrylD0IO6DTgnVk1ODfIxu4gz
 VpxQHOlDAh6LTDTh78CqOWdxDEV7CwGFgsQJt6GjlKnLPYY4zU7Xrzgl5fVQSMi2532UhGc/hGZ
 yHGyyaglEo4e5cTUanOcpOV9TsjjO0lfOoemMF9T22Af8AsR4udXlxN0qJWkcQssFRfp4W3FuaS
 tKfz4VRzkO+xGW7VEws8ycESKsunmJzm3VoCQHeItVHhTI
X-Gm-Gg: AfdE7cl5PmvDeQNi0yZJXYsCq3hqdQZo1mhv5m5nTSbwR3cN6kfqWFwsdR2qycy8ker
 17RDT7ow9C5YHkMQmMkZGozacFXPrUGZpjycRFzLhRZ9cO9HkOJGoZSvqKQLIOn2q3PFDjo91yw
 PQI0nSLKW5/Zyt2lUwZe19MuoYkEWehr1Jg2xje6qYix6zN465fEYkSluH/A9CvsJuWhpjcWddz
 kJcssxVouTcgrDQHA1bsGr1TGu3Axjw6G+CHlTOZloEG3K9UEsKe3MQd/vNNiohf6c7UlCStCbd
 eAOa7LafkP5ow6XvSN52DodVw2rpXvjPIys4lHZowdFzBQXpiIjjURpiFGusN4BcHr6qA4DUmW6
 v812yxfvi5fp8GcpKxFSYPI/0XhICEhyA2nHSdUoNDAD7TTHxn60OkURuNVKWgk5rMyL6FFK4Iy
 om2iK8DFE=
X-Received: by 2002:a05:600c:3acd:b0:495:474b:a031 with SMTP id
 5b1f17b1804b1-495474ba11amr48776725e9.4.1784284399713; 
 Fri, 17 Jul 2026 03:33:19 -0700 (PDT)
X-Received: by 2002:a05:600c:3acd:b0:495:474b:a031 with SMTP id
 5b1f17b1804b1-495474ba11amr48776255e9.4.1784284399155; 
 Fri, 17 Jul 2026 03:33:19 -0700 (PDT)
Received: from fedora (cst-prg-95-48.cust.vodafone.cz. [46.135.95.48])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63ed2313sm2523298f8f.23.2026.07.17.03.33.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 03:33:18 -0700 (PDT)
From: Dorinda Bassey <dbassey@redhat.com>
To: qemu-devel@nongnu.org
Cc: mhrica@redhat.com, mst@redhat.com, sgarzare@redhat.com,
 manos.pitsidianakis@linaro.org, marcandre.lureau@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, aesteve@redhat.com,
 Dorinda Bassey <dbassey@redhat.com>
Subject: [PATCH v3 0/3] vhost-user-gpu: Add blob resource and shared memory
 support
Date: Fri, 17 Jul 2026 12:32:58 +0200
Message-ID: <20260717103301.228974-1-dbassey@redhat.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=dbassey@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Add blob resource support to the vhost-user-gpu device, enabling
Vulkan pass-through via Venus with a vhost-user backend such as
vhost-device-gpu.

Patch 1 fixes a deadlock that occurs when the memory region
transaction commit triggers ADD_MEM_REG back to the backend while
it is still blocked waiting for the SHMEM_MAP reply.

Patches 2-3 register a shared memory region for SHMEM_MAP/UNMAP
operations and forward the RESOURCE_BLOB and CONTEXT_INIT feature
flags from the backend to the guest.

Dorinda Bassey (1):
  vhost: Fix SHMEM_MAP transaction ordering and resulting deadlock

Matej Hrica (2):
  vhost-user-gpu: Add shared memory region support
  vhost-user-gpu: Forward RESOURCE_BLOB and CONTEXT_INIT flags

 hw/display/vhost-user-gpu.c | 17 +++++++++++++++++
 hw/virtio/vhost-user.c      | 20 ++------------------
 hw/virtio/vhost.c           | 10 ++++++++++
 3 files changed, 29 insertions(+), 18 deletions(-)

Changes in v3:
- Reordered patches: bugfix first, then features
- Added Fixes tag

Changes in v2:
- Reordered patches: shmem support before feature flags
- Use virtio_new_shmem_region() helper
- Drop explicit transaction begin/commit wrapping

--
2.52.0


