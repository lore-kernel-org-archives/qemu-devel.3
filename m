Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F44C44507
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 09:40:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkf3P-0007yi-M7; Fri, 17 Jul 2026 05:40:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1wkf3N-0007yF-KJ
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 05:40:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1wkf3L-0002sV-Kl
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 05:40:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784281217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=rdfBV1c/0sH41nnJ4kvvSkE2Nj0EO8IbrcuG3QNsPVc=;
 b=Gxgi4t6BzUHIXhro7nRWwfOQTnH7kGy7/0Tmr5iOpNFXZk59loJIyYhxyDus3LQFFaQdkM
 nFPBYLGLGdcwUTqM0zS4fc/Z0En7gLvSvlzZmBSgKmqbeV8f+j/rSpHMHlTqgP5jZow8vF
 y8e8j8HgCXQnJWBwqwzpXpm0y5FTKls=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-F2EOy_r2MDSBPzMdvaCa_g-1; Fri, 17 Jul 2026 05:40:15 -0400
X-MC-Unique: F2EOy_r2MDSBPzMdvaCa_g-1
X-Mimecast-MFC-AGG-ID: F2EOy_r2MDSBPzMdvaCa_g_1784281214
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4926fa2cb17so11683525e9.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 02:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784281214; x=1784886014; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rdfBV1c/0sH41nnJ4kvvSkE2Nj0EO8IbrcuG3QNsPVc=;
 b=mP3o0s3xUvLHRvUbtqyXTbQW9pSCE8bdrEp1QJLo+9wryW+5x+1TSjE5NLMpV9v7Ut
 3Xv1S4tE38q+zeA2U2hnpsTmgWfIm/x/hz84it2Y8zHN+5iakVfI+LKlkZqWZRbu2uNM
 RwrDAqKSTm1uOBdEJhZStIR8mn4+HPOCeQyKiOIjDDjHyXQTI0uHNkLKd39IqfvDdq8T
 nJepsWUy91smWCwAZ6K1EOteYq2yvCjGWtio08lxCldk1z0w2YOQOtMZdE82L/SnaXEI
 pZzIzzKN0PzcYd/7nbx7sv3GTDveMXN6c3nI8yRZxPQBIlKQiZUMSLbVQljKWo2MOzs1
 Vbhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784281214; x=1784886014;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rdfBV1c/0sH41nnJ4kvvSkE2Nj0EO8IbrcuG3QNsPVc=;
 b=S9dnX49zXO9ndL9gMkPVJTp+IIl9ElNywaWdwFwDnn7j96ovgYwj7gCLfvE3ufWQPm
 pOMjN4iyJAtBbbC73Iz+b46SD0j5ZxKIsDjUqi7MvnHaf+DKF6N91bnh9lVPw+vp6F1J
 /TDLKFlKPe6YXgbTRdZZPoYjI2+OowaoETsnBt5H8mblpwyaKLpkXgcLapWreHdkiGKn
 X52Ra5Q0y8zMqL7vEVNIkA4j4Qy1gOmHa6v629nubkdcWLRZgl6quZaWX+uGrNPK9Mfe
 uMz2HcJybI6De9hbfJLS3WW+SnTOtNZxDoYsC/dbXZC4G1xB5w89zYIpBt8JTZFhFZHC
 ppOw==
X-Gm-Message-State: AOJu0YzjTbIg8WiTlNuBAxsqMBgphNKWl1Od6aO5QoyZqi8Nza6lQk+2
 iLBk5amjEm8QpIVULu93DtsWztzrKz+lVOTK5kpIpEbhNqoAs9ueUzT61abtCOCBvIc6qdAQCay
 2XvypdvpRls5fjF8WTV1NBlnbA7ztjCI5N82xxGMURrbWy9YPVobY60z7Zn/qMI+kwmMUdYA61h
 WLVew3dfR+mtKNyD+8IQEFE8ozC1tx6TFd+WI1o3QeeyLu
X-Gm-Gg: AfdE7cm+m3nMCnqX2gCW5w+/pPMaqWc7Eb29aY/Gn8B4/bWEwD4gqtP8vamAK6/J0Xg
 +vQ4I6Ke8Yos3REcvb1N61lTrkvzXwvjkiTLHTm3zXumfV27V7zI3ho7RYRLjUeTWQvLJKRLr2c
 qpwdIZmtaK0mQxV1ws4PvJ2Wxw8JnGJX8hd/MWaUQ1QqQYmZFldFpmuxA0zzt9o35qVFIroazz9
 bDQ6wyEui3mcwGjO+Ls7nDWK3fWXlj9Tj7NhOqPHCtgqnrhDgZrAE+QbE6NuRmZE6TenUqgWFWZ
 ZlvS0JfxcerdGxzQZN/RtxurWNBN+7drUPI4bYHzcCmIq1MqFRCZmDXeUJDpTSYStdrTzWYZgl+
 uOgK97gB4kVROQuhBdxfy1w==
X-Received: by 2002:a05:600c:3113:b0:493:f478:4c71 with SMTP id
 5b1f17b1804b1-4954a323b14mr19747765e9.7.1784281214257; 
 Fri, 17 Jul 2026 02:40:14 -0700 (PDT)
X-Received: by 2002:a05:600c:3113:b0:493:f478:4c71 with SMTP id
 5b1f17b1804b1-4954a323b14mr19747235e9.7.1784281213585; 
 Fri, 17 Jul 2026 02:40:13 -0700 (PDT)
Received: from fedora (cst-prg-95-48.cust.vodafone.cz. [46.135.95.48])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49549a35830sm38356565e9.3.2026.07.17.02.40.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 02:40:12 -0700 (PDT)
From: Dorinda Bassey <dbassey@redhat.com>
To: qemu-devel@nongnu.org
Cc: mhrica@redhat.com, mst@redhat.com, sgarzare@redhat.com,
 manos.pitsidianakis@linaro.org, marcandre.lureau@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, aesteve@redhat.com,
 Dorinda Bassey <dbassey@redhat.com>
Subject: [PATCH v2 0/3] vhost-user-gpu: Add blob resource and shared memory
 support
Date: Fri, 17 Jul 2026 11:39:22 +0200
Message-ID: <20260717093925.214023-1-dbassey@redhat.com>
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

Patches 1-2 register a shared memory region for SHMEM_MAP/UNMAP
operations and forward the RESOURCE_BLOB and CONTEXT_INIT feature
flags from the backend to the guest.

Patch 3 fixes a deadlock that occurs when the memory region
transaction commit (needed so the KVM slot exists before the
guest accesses the mapped region) triggers ADD_MEM_REG back to
the backend while it is still blocked waiting for the SHMEM_MAP
reply.

Dorinda Bassey (1):
  vhost: Fix SHMEM_MAP transaction ordering and resulting deadlock

Matej Hrica (2):
  vhost-user-gpu: Add shared memory region support
  vhost-user-gpu: Forward RESOURCE_BLOB and CONTEXT_INIT flags

 hw/display/vhost-user-gpu.c | 17 +++++++++++++++++
 hw/virtio/vhost-user.c      | 20 ++------------------
 hw/virtio/vhost.c           | 10 ++++++++++
 3 files changed, 29 insertions(+), 18 deletions(-)

Changes in v2:
- Reordered patches: shmem support before feature flags
- Use virtio_new_shmem_region() helper
- Drop explicit transaction begin/commit wrapping

--
2.52.0


