Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E1AFCFC518
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 01:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMcm8-0002Z8-Km; Fri, 21 Nov 2025 20:50:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vMbTM-0006Yf-HZ
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:27:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vMbTB-0003d6-5k
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:27:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763771221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DqqM2pSJyFfJuxmHvczNQV0JEpfBm/7SbwknLSOriN4=;
 b=cLWVMKOQgBDD7eCrf7xLrZejB9cPgV9xm2j4hcHfjhwCLsRdh117S10hzmNff38kdZIOUu
 xLYkyRvh7S3j9fO5BjZbnqHCm9RBm1WTdCYwxew2b8S1Tlj88Tu0kfEhjeSdllF9a1ktHN
 BNnoPwTif0K6Wgs0heSrABWbwH01h4k=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-yREBBwm_NCGjBrSASGP8Sg-1; Fri, 21 Nov 2025 19:26:59 -0500
X-MC-Unique: yREBBwm_NCGjBrSASGP8Sg-1
X-Mimecast-MFC-AGG-ID: yREBBwm_NCGjBrSASGP8Sg_1763771219
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4ee09693109so61359241cf.3
 for <qemu-devel@nongnu.org>; Fri, 21 Nov 2025 16:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763771219; x=1764376019; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DqqM2pSJyFfJuxmHvczNQV0JEpfBm/7SbwknLSOriN4=;
 b=X0ZQ6MV0443uYLD4D2jNyrAWhlckOf8gBBZoFXglMcnbRrHWIYtH0rTquck7f1D6EG
 GtZO6QqohWeDqNBb2LeaqBnyuFG3HhdHj5VSQDh3OnUJc+sFqRrYgHsEYFWBskNVnffi
 n5wuDMonaJojbNAMMeDhL5QJTgY+zm0Rec+UEmDBFfu4qOBl9Z8A0tQ4Ea7z+gg5HVM6
 P9cYW/mIjEb4P7gu1sD+wQnfA0kBhwJvGkHvnXxc+iBCwUgag8ABzzQU9UimeadbIVfm
 jx9jqfTIMw2qkGdTeaGwcAhzZVmWuaTWR03rDGclWIDgqNw3ijw10Z61eoOoJB+jUlk6
 lxmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763771219; x=1764376019;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DqqM2pSJyFfJuxmHvczNQV0JEpfBm/7SbwknLSOriN4=;
 b=q5VWRqbcneuYEcv3oJ9uxnkMDLu/yv4VgP+vPl1zEijad1FCNBD5JERDXpvrupfrM0
 UAnG3zgRMAL2DGYOaH55rzjB+I00vAYKcQc8hpKCWsvhmYqhNEOG89pMghyNq6OmFfMu
 muYlOqZ4gtr9Fzr0ZKVNakcGFSF6rPmM/cBwQn20ifAZ++Eg8WzFm2XrN8d2qpLegfrw
 OAnSeBFxMhc5B6KojstEwLwxagSDSfoyKbre/ypIbT/XvR7eQnDEy7gNvt6eV1BtxY0G
 K/KW4iSmN/QN1JjJ+30ADWjMo9kvGJvT9Z6lT2NK33TgtuugQYok3zlw4XTSOazPM//6
 Y/fg==
X-Gm-Message-State: AOJu0Yy50H9/cEWVu9atk+E00nTCx9nSQA/x9tXF45i0G2KMk19j5F03
 eqNM8l+OIxne1WtYsWPjXqJsRnayMd5wJwvEnlqeHM/MD0XOq+qAqwl6Wh4KqOtHb7J1wPkCf94
 kDK6u/QCPIOk18CQdqjeDN9Bh7DPeako9GPNIp/MjlZs/vkkdMLffzx8isX09AqsbdNcWHZedfR
 OJAQLDs54DT4+5MYuOJdkWo11BZGjniEU+iwHFvQ==
X-Gm-Gg: ASbGncs9f1vhI9ykZC7ujdvagJXl9jL5KctKRJR62DBv23X3eA9LA0P66xLMCJkZZ7k
 o32WLd7bxG849v6x8492f9hmN7jVxqAMaMzhGWlA4o9G70Ac07dM1CwQnBPV4GAOweqZ+S6EIK0
 CE7ak7dSG57tWZQGeWvg5ZnMGZ4yImnEq3Djbj1x9Dsz2lty8UQsGYdxtKhckffHc7zUi4MwfQ7
 i2iwRWJjmzA2Q+OC+Q9jDbJk/fSWVbK9D0+wjMlfn6y7tYXGevswJdkQwc5xRBNoKqoDd97Rdct
 cXJ9GyzToy2xAzi0nTJxFyLuBn/IhdE6TE2R4oW0/71+s2SheftYIef9lP/rFkRTkFxO94Ixvbg
 C
X-Received: by 2002:a05:622a:84:b0:4ee:1e63:a4e0 with SMTP id
 d75a77b69052e-4ee589136f7mr65638231cf.74.1763771218689; 
 Fri, 21 Nov 2025 16:26:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGBT8vCyoddv4Ps4SzNy/EpbL4++2ReuXB3UdS2ZsuTYWJpKhOnq2FR9sppsZDrSyxEKfivyg==
X-Received: by 2002:a05:622a:84:b0:4ee:1e63:a4e0 with SMTP id
 d75a77b69052e-4ee589136f7mr65637901cf.74.1763771218118; 
 Fri, 21 Nov 2025 16:26:58 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ee48e8df63sm43870291cf.30.2025.11.21.16.26.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 16:26:57 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
	peterx@redhat.com
Subject: [PULL 0/9] Staging patches
Date: Fri, 21 Nov 2025 19:26:46 -0500
Message-ID: <20251122002656.687350-1-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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

The following changes since commit 5a5b06d2f6f71d7789719b97143fc5b543bec07a:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2025-11-20 08:12:59 +0100)

are available in the Git repository at:

  https://gitlab.com/peterx/qemu.git tags/staging-pull-request

for you to fetch changes up to 6aef825073a751215de1ed410a5c94efa675f5ca:

  tests/migration-test: Use MEM_TYPE_MEMFD for memory_backend (2025-11-21 19:23:46 -0500)

----------------------------------------------------------------
Migration pull for rc2

- Zhijian's COLO regression fix (since 10.0)
- Matthew's fix to avoid crash on wrong list manipulations
- Markus's error report leak fix and cleanups
- Peter's qtest changes to merge memory_backend and use_shmem

----------------------------------------------------------------

Li Zhijian (1):
  migration: Fix transition to COLO state from precopy

Markus Armbruster (3):
  migration: Plug memory leaks after migrate_set_error()
  migration: Use warn_reportf_err() where appropriate
  migration/postcopy-ram: Improve error reporting after loadvm failure

Matthew Rosato (1):
  migration: set correct list pointer when removing notifier

Peter Xu (4):
  tests/migration-test: Introduce MemType
  tests/migration-test: Merge shmem_opts into memory_backend
  tests/migration-test: Add MEM_TYPE_SHMEM
  tests/migration-test: Use MEM_TYPE_MEMFD for memory_backend

 tests/qtest/migration/framework.h  |  26 +++++--
 migration/cpr-exec.c               |   3 +-
 migration/migration.c              |   6 +-
 migration/multifd.c                |   6 +-
 migration/postcopy-ram.c           |  17 ++---
 tests/qtest/migration/cpr-tests.c  |   8 +-
 tests/qtest/migration/framework.c  | 113 ++++++++++++++++++++---------
 tests/qtest/migration/misc-tests.c |   2 +-
 8 files changed, 121 insertions(+), 60 deletions(-)

-- 
2.50.1


