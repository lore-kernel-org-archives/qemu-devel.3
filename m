Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 786EBC61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 14:47:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzxqG-0002eE-IW; Fri, 28 Aug 2026 10:46:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzxqF-0002dp-5I
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 10:46:03 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzxqD-0000dJ-FJ
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 10:46:02 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-49b8be0409fso5702725e9.2
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 07:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787928358; x=1788533158; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hhZt7ihNiJiEiFAnLnB5rZOpdZLwyBaqicPsPLbR04s=;
 b=eH5wx5y95hVlgeoBgOnojLkqLdz5i5b56kVsb5aReVwQmZa90vMnb7T8yAxSB2zexI
 QTdtxgZn3q2+ErgO/leU9Nb84KOxPTEZZR0PEBdP73Qm4MqHyM9zraYydiLPdYeMvTe4
 AzqXe/CWKeUmDZSv885l49Z+zQeOPMou3hzV+BJ/ZUFpy5ucW3SgWPldHU/ollqcWmBL
 dOqEg+s3DoZpLRiW8fZjZoSityNG0GrFgw3QTcWqvCzyWuN218CwpvICzVbARazqr8jd
 zJ4MXIZGsqQqNZ6/8Th0FtDS3yHuQyhPygJMNr1BQVFahyoLjdZpcbQ2jWbiDcS/F8W1
 3BNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787928358; x=1788533158;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hhZt7ihNiJiEiFAnLnB5rZOpdZLwyBaqicPsPLbR04s=;
 b=pNwZrW2CnA9ifuOXh+mfA1aP3m7AS/mtf+YEJvnKj5G+TggY8/j1c7BkQ+3NsU4giz
 80+KJeu6f4Nu2ec0wcg0rlB5DfUC2vxvUWWcn7jyJ8wYRG4hsYxXzB2cIxOG+YQ0Wm/S
 0StqBzG2mLJTFKfp5hYbEyzpUQuZAZLSVyOoo5Peayf+/VuS9UnvwrNPgjBBjmAf5P8n
 szb8Vym5JJyI+QzpWmjKs5mI1qp2ZtjJ2SZzXYdYenurEY3E8Y8Y4/PfgOWh8mAwZ1iN
 GFxnM2FCg7kc1h/q4Z5X1iCTRCyS8xoXvQyp9WdFSzKNDImduomj8Bn3QGfO9Sh1jwGW
 AlYA==
X-Gm-Message-State: AFuF++m08DogsDidX6EVNpgF1S7gjcBR1k15ReCj8IPEoy2BNp3ATlbO
 gqQ9bPR4QZlrifZ9zgL+KXyQG0kUhHLTgKq8gtvc6moZh0P/PhVHd1ODfDLzA3oiV2B3gYWTNkJ
 Gcs1N
X-Gm-Gg: AR+sD12txunLyPXyWy2mslDUMxh56u3RpvWXVQj7COfxtEtt9ytYxe4U+HEwkB1joVi
 NmZrL6wK8Gwz8QJNBPrzu7rXVBHzhFqkuOvhfSAICr9VHIdrS/s1YNW/OpARNkMzcBgUjqzjuvM
 uEdXkQXacokJCSmZnBgF5ekXGmPPqsh5OrmsIbLrP9XcEQKxHGFBwuHT5yoTzeQG8AI0QmOHcQc
 aIxvHVWlXMYW0mwsmZXXDt4uqYAUz3y/sZtEV8SGT4jADzCD5cfQ/jjk7l3kqA2Hk4kYVME/1Gh
 odX+dOAPK1p5E9V6xFx9lfD/EINXh3pm6zX34VFgMiX1s9Eiz7SNJRknQvFSPeMJCzTvGQdBjgS
 cr7SfNJ63QaArGA3qsnxCHcLfYxMyIQrCvtIozW0K8EMtzhc14GVsjULoHtFYCh/hKL/kFJD6tQ
 JFcn92NZfqCs+mI9quwdVV0JR6hiNEKSd6UEms3dW0yTViA3frURzts0Yukw==
X-Received: by 2002:a05:600c:870c:b0:499:dc34:bdc with SMTP id
 5b1f17b1804b1-49b91c1c401mr136228045e9.1.1787928358201; 
 Fri, 28 Aug 2026 07:45:58 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:9458:da19:ab04:373a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b94dcaf61sm53730925e9.4.2026.08.28.07.45.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 07:45:57 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH 0/9] block: cheaper zero handling in backup and commit
Date: Fri, 28 Aug 2026 16:45:45 +0200
Message-ID: <20260828144554.1741910-1-den@openvz.org>
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

Backup and commit re-query the source block status for every task and
size a task by the copy buffer, so a long run of zeroes turns into a
crowd of small write-zeroes requests. This series reuses what the
up-front scan already learned and lets one write-zeroes task cover a
whole run.

Backup of a 16G qcow2 image holding 1G of data, the rest never
allocated, sync=full to a raw target on ext4:

               tasks    time
    before     16384    1.6s
    after       1088    1.0s

Such an image is the normal case rather than a corner one: a guest with
discard enabled on a disk which is mostly free leaves exactly this
shape behind.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: John Snow <jsnow@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

Denis V. Lunev (9):
  block/commit: pass BDRV_WANT_PRECISE to block-status
  iotests/040: cover large and fragmented commit runs
  block/commit: batch block-status queries
  iotests/124: cover backup of zero clusters and holes
  block/block-copy: don't reserve memory for zero tasks
  block/block-copy: extract block_copy_set_task_method()
  block/block-copy: track known-zero source clusters
  block/backup: pre-fill zero_bitmap for full/bitmap
  block/block-copy: coalesce write-zeroes tasks

 block/backup.c             |  93 ++++++---
 block/block-copy.c         | 239 +++++++++++++++++++---
 block/commit.c             |  50 ++++-
 include/block/block-copy.h |   5 +
 tests/qemu-iotests/040     |  95 ++++++++-
 tests/qemu-iotests/040.out |   4 +-
 tests/qemu-iotests/124     | 402 ++++++++++++++++++++++++++++++++++++-
 tests/qemu-iotests/124.out |   4 +-
 8 files changed, 811 insertions(+), 81 deletions(-)


base-commit: 0a1ebd448b38afaa118597cbb633dbec24ef74d3
-- 
2.53.0


