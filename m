Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16165C4451C
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 13:50:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkix4-0004GU-Mc; Fri, 17 Jul 2026 09:50:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1wkiwn-0004FE-96
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 09:49:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1wkiwk-0001XO-SQ
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 09:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784296185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=lZBZPNLhjCDSLe+l9dGorEQW0aTecu4Xl6LsTO76fCw=;
 b=dGGCqPWnNbWKiMp93WNd7P4yrsd8s0jm+V5LaciVV+yGQBiFE2jBgE0zTfcmZSuxAn5zHC
 +QEUEXSRdkpFxpz6y8+M24BufVZ9w6LgTKqvuxn8uzql9GxAsBooDr/MTv2QCpp7uy4fq0
 HKHuizSLm8Y4OAotowp4OwDkJCBDMCQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-lOBqcOfvOFWFwrijvF29Qg-1; Fri, 17 Jul 2026 09:49:43 -0400
X-MC-Unique: lOBqcOfvOFWFwrijvF29Qg-1
X-Mimecast-MFC-AGG-ID: lOBqcOfvOFWFwrijvF29Qg_1784296182
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-493b0a5e636so71777305e9.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 06:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784296182; x=1784900982; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lZBZPNLhjCDSLe+l9dGorEQW0aTecu4Xl6LsTO76fCw=;
 b=iURqURCpkWHQYppJ7Ae8SzFnwHYOoo5btuRTNB9Yxml9tGHh0w82f/eIT1TSVLY21M
 gTK8SNO8D46mgnOmWAx42OZk/Qfc+pPaEetW7JqNM7dmC3HQnfom9p15qN5lelcEQ+ZT
 hHEUOd5x6axqu+KThxfl4mkGbBe5xA7f/4hwn5qOJEZ1ufLdbnkSJf3Ubkp8TGTpCK+3
 7z+rYippbRWlKKuqgGIhxi9PzdqBaUiiJngpujF+SYRbXDkYVp249LoD2raIzcwHGChn
 vj5xDfTpakaeeeLYe2n6sdGV6mXIR/mET1qeUyGz58HafP1+v2c9O+LORadvw5XLR2MG
 GLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784296182; x=1784900982;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lZBZPNLhjCDSLe+l9dGorEQW0aTecu4Xl6LsTO76fCw=;
 b=HCDPSfbpUYI50Artg27GZg176MjkWfoaIymY0bVYOg23mMYe1Y+C/I0sruEM7IJssu
 +yD0KIshO0Oc/zF9QpbMLkosPlKPHIVv5KiaFxU8YJKN2rBhEqze7FO586dUtKpySEvZ
 kk5DoNwYvTqFzGHz4Ts39yCCHNBXV18sH0gr4dcI+2rEJ+XB8kRerU3HLn2Jh5pwljVM
 qc9gYFbzpn12Hfq0ormbDObyM+zeUIsEiTWgdFuZwwmeGoNsgfYdZHk+d/RlKVqtmcSz
 BpcfWHtzOIVmYC9IGUsNEjIqYCETe9SVkJc1Cd8lImo9t344tr8/G2Xs6kohUJ+VzNIZ
 FMeQ==
X-Gm-Message-State: AOJu0Ywu27b/VKe68csSH3oAsaM2+ee5V2MDXJRuM2wEskmHAE6ub90L
 Sqyr/ewSjKRdmQvL1qoHx3xsJxXoOxOX4JoUOV2RYY12rmzD/9rLzy/2aYmXZ1z0nlZWHtjjIB4
 1Y47cRku1igOaZPmrwqME5izTGo1t8KZGX25gB1McR5LOcpONFHsO7Qa2WyeTpsUJRqajV9STGE
 Ojn9d8OLkU4/4EMl7rZ+H2oatcN1COzTY2dgj4tyk/Wvad
X-Gm-Gg: AfdE7cn5sTCjfdI5FqQlbktYE9iD7+YYshPSHQ7RyJ1OG8vMI79yDq99jcFqv8ZVNr6
 8o7nQmA0jRkSHqEkwo9DG95f0Lt/viAPT+cYp3LF3MUi8U/rO+yM8+2uhX0M3U/5LTco5szTCrn
 5uii2V1r7QXteFlTSqHjLnl/9LC0c8mvBfUnorFGnSbI6O9HMFkJE9m8ec8luLGxMsFQ6bu+ylj
 OAq6vfwZghOYrc8mTabfwT4OQ32Pvgor9FsL2tfKTiVzxwDhyW4V+K+GqhCBBsCsWotpmhR7mqd
 tjGWQhUbcmVdmog8pLh8hA7NTcRNZXio31gd3bRvyNzrBIdAUs965Hg4iWv6JJFsLB0AJvBr3aV
 4VSbxsBm113h/XUyT9QngwBuTmrBFMSFSjcwuFmL6EkIeg1fA74ZpdFDAsyVttZydud0ZlESX7Y
 BQjfl5lFE1rw==
X-Received: by 2002:a05:600c:3586:b0:493:e504:cbef with SMTP id
 5b1f17b1804b1-4954a38def9mr35829845e9.0.1784296182181; 
 Fri, 17 Jul 2026 06:49:42 -0700 (PDT)
X-Received: by 2002:a05:600c:3586:b0:493:e504:cbef with SMTP id
 5b1f17b1804b1-4954a38def9mr35829405e9.0.1784296181675; 
 Fri, 17 Jul 2026 06:49:41 -0700 (PDT)
Received: from fedora (cst-prg-27-253.cust.vodafone.cz. [46.135.27.253])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954ba2abd0sm30049525e9.15.2026.07.17.06.49.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 06:49:40 -0700 (PDT)
From: Dorinda Bassey <dbassey@redhat.com>
To: qemu-devel@nongnu.org
Cc: mhrica@redhat.com, mst@redhat.com, sgarzare@redhat.com,
 manos.pitsidianakis@linaro.org, marcandre.lureau@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, aesteve@redhat.com,
 Dorinda Bassey <dbassey@redhat.com>
Subject: [PATCH v4 0/3] vhost-user-gpu: Add blob resource and shared memory
 support
Date: Fri, 17 Jul 2026 15:49:17 +0200
Message-ID: <20260717134920.265128-1-dbassey@redhat.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=dbassey@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Changes in v4:
- Document map/unmap ordering in commit message

Changes in v3:
- Reordered patches: bugfix first, then features
- Added Fixes tag

Changes in v2:
- Reordered patches: shmem support before feature flags
- Use virtio_new_shmem_region() helper
- Drop explicit transaction begin/commit wrapping

--
2.52.0


