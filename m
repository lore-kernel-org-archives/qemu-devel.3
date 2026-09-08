Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90FB9C79F9E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 14:56:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3xEz-0007l5-TZ; Tue, 08 Sep 2026 10:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x3xEx-0007jM-IX
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 10:56:03 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x3xEu-0005wd-Je
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 10:56:03 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4956869750eso42386885e9.2
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 07:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1788879357; x=1789484157; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6G6uh3FqyFsdzc2NAryw9YSG0mBKe1DruOssrne6QkM=;
 b=ZbnS7a6URq+ccPx7zJC5SPK5A8tv6E+y3+LQX3+v11RT3+nJCgP1ICa4OUAihr8ncd
 nWQZLlwjWN0dXR0gLvGrF2kdZo5jff5YCAP9B5d8srjF41h3x42gc2t4Vec56KAQtQcm
 jWNCpp+Uk0Z9LPBq1qyLjadUpKtDoUyePsxu3zyWlMsNN1R2ry3kXprrV58siYkGBbaw
 z7TKzInqVzbCcm5OU6zQS1u/pD5FBrWuj26nsGmV1//NbBWyDK1bx58P1ibHOU5jM2Y7
 2/NRJtxTt1XwGLxrt3O5vAUbSmleHy8BJRVLennfI6LkzWj+tVcDYcVy/jKNX54ym48v
 +FZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788879357; x=1789484157;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6G6uh3FqyFsdzc2NAryw9YSG0mBKe1DruOssrne6QkM=;
 b=c4V6S984kFNOnQcoVuAMCTlezBHnv72Z0MbSsubD+GsKAkri6rApo4IVP2e93t+k7M
 u4lkdYjIkGxfw8eleD1aNmukKwX99jtHl22M0pWn8BmOIp8ywYnwTBV2gG7gUlVT8bAZ
 asEvqk+MQG/ACl9tFG9wk7t3tQ/ufAZ3ybB5TjZBUn1lRiWmHXnZCJNyBbCCQMhoU+Lg
 MYDy5PS/N23jKv6iEJjlWKzteoOPLBbb67YvYq7TgqBSnFJM155vHAuionp9UlTTNoM5
 7E56zntV8vut8egqifcl1JlI0z8bMdSnWdz+oh9wZVTU/4sNRgp0MgqN8SDN1eb6sjql
 vKaA==
X-Gm-Message-State: AFuF++lxt//kM+J2qEUPFgIHHRMl2YnQQL2p+AyLReF673MEUnHqFhlP
 4Wr+PNvkEdsjDmhoF+0R1j7XVdOGjXtDlkmPXVHf8nOEIl/SPKpzqvNZzcglv7QKRDhm9cuHwgl
 +QRNf
X-Gm-Gg: AYBFou3JBRybDdmPeNu9RBsxW7BRS9c325512jJ0VLSMTfwLYD1Pf65H6K+19z+FjRG
 MXuAJuJSjwoW2V3cPA9rttjZAQUlhRrMiBGas7WM7ATnwXzrlv22WqcZ9wCtKQqDQ6yaYPBqoH8
 uYEL6PYF0eIJdFELTjGIDZPldcSwqSuRo5O2nNFs7S/tMM5RfHupGaMLryirGcrXTKyYCzlwkaY
 yenFKrE6DCBYKF3UpfmDiynLddTUyCCYhYyWRqdCCv6GOVEm1OpbtVhxQxEVKuiMa7t3voM9vSs
 tsfeCHrFCmtGTiftYdiBSSVJOM0px0cLq1ymHkNGp6JdYBqSHCAX2+mPXm94+5nCKmIlPbVWoJB
 mD1nP25SSqkkA76CUCRrhW7ScSOAJFJojZQrgHA7RqFAq/JJF7jB3jdsjFBTmbv5ck1/Fc9BYtL
 Rs+0vatLBTgocUlLfyN6runMqMYur/d3Fkfw4s2mU8Iqeu0UgwtkvVdqFrZgP2WubftffN
X-Received: by 2002:a05:600c:3f08:b0:49c:fa20:cc04 with SMTP id
 5b1f17b1804b1-49cfa20cd10mr251761295e9.27.1788879357035; 
 Tue, 08 Sep 2026 07:55:57 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:695d:ab39:8b90:f8d6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cff81c9b5sm275342355e9.4.2026.09.08.07.55.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 07:55:56 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org,
 "Denis V. Lunev" <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Alberto Garcia <berto@igalia.com>
Subject: [PATCH 0/1] block/throttle-groups: fix a NULL token crash on group
 creation
Date: Tue,  8 Sep 2026 16:55:52 +0200
Message-ID: <20260908145554.3215221-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=den@openvz.org; helo=mail-wm1-x32d.google.com
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

Applying I/O limits to a disk that is already serving requests from an
iothread can kill QEMU:

  #0  throttle_group_next_tgm (tgm=0x0) at block/throttle-groups.c:185
  #1  next_throttle_token (tgm=..., direction=THROTTLE_READ)
  #2  throttle_group_co_io_limits_intercept (bytes=8192, ...)
  #3  blk_co_do_preadv_part (blk=..., bytes=8192, ...)
  #4  blk_aio_read_entry (opaque=...)
  #5  coroutine_trampoline (i0=..., i1=...)

throttle_group_register_tgm() publishes tgm->throttle_state before it
takes tg->lock, and the group it points at is only filled in afterwards.
A request that samples the pointer in between and wins tg->lock finds
tg->tokens[] still NULL. The ordering is as old as the throttle group
code, 76f4afb40f ("throttle: Add throttle group support").

This was found from a production core. The group in it was brand new -
name matching the disk, refcount 1, empty member list, both tokens NULL,
a zeroed config because throttle_group_config() had not run yet, and
tg->lock owned by the crashing iothread while the main thread sat
blocked on the same lock inside throttle_group_register_tgm(). The
trigger was libvirt applying blkdeviotune right after attaching a
volume, while the guest was probing the new disk.

The window is a couple of instructions wide. To see the bug on demand,
widen it by hand:

    --- a/block/throttle-groups.c
    +++ b/block/throttle-groups.c
    @@ -584,6 +584,7 @@ void throttle_group_register_tgm(...)
         tgm->throttle_state = ts;
         tgm->aio_context = ctx;
         qatomic_set(&tgm->restart_pending, 0);

    +    g_usleep(1000);
         QEMU_LOCK_GUARD(&tg->lock);

With that in place, any I/O against the disk during a
block_set_io_throttle that creates the group crashes at once, and the
patch below makes it stop.

Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Hanna Reitz <hreitz@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>

Denis V. Lunev (1):
  block/throttle-groups: fix crash when enabling I/O limits on a busy
    disk

 block/block-backend.c   | 12 ++++++------
 block/throttle-groups.c |  4 +++-
 2 files changed, 9 insertions(+), 7 deletions(-)

-- 
2.53.0


