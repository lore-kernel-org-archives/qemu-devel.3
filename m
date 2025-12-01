Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79FEFD116F1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 19:46:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ9ps-0000lM-T2; Mon, 01 Dec 2025 14:45:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vQ9pq-0000kq-K2
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 14:45:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vQ9pp-0005HY-0q
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 14:45:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764618320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1O0BXRrIJPVwTg1/xeUXTIzekqe2LsP3gkp2KvlAvC8=;
 b=ZGT5aPtKeBgGEQ/vPsEATwcoJ68bajOSy25A9Xpi0+OKJHXP6zVDl2uOPwinxr9S9IGqf9
 xjVpzmG+CORIv4TotMpUUN8dTDlYlGakGM3lJm00AtBGP2fN/MZz1cD1FmWEEHSFGneCGu
 WGe98rSJu2dbNzU/TB2GDQjtnNcO0XM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-v8_ecJvNOwWpUH_5vjbFww-1; Mon, 01 Dec 2025 14:45:16 -0500
X-MC-Unique: v8_ecJvNOwWpUH_5vjbFww-1
X-Mimecast-MFC-AGG-ID: v8_ecJvNOwWpUH_5vjbFww_1764618315
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-88234e4a694so161503976d6.3
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 11:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764618315; x=1765223115; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1O0BXRrIJPVwTg1/xeUXTIzekqe2LsP3gkp2KvlAvC8=;
 b=JGRZ9ZzVNetSIeZJEfqQppjua+lyKnG7TuSoPbNTwm8jVOthEwfoDkE6XUEdC8XahI
 5XYbPw7bvaiRoao0+D8AQTJJJUmtk3eSmc1P67uGuZX0Ks3dINyZhWdFK/vtcV21tEch
 dIw1W7OB5ebJN4TR9gqybTVkKBJZo9Mrc8/H5xMD/4HA+6KcrxTYFh7TTgl3EHFxreAf
 tNsLtUD7S1UO8mQDkqNVeS5i7lhfapn57wTOvBP8zsikkYFIdcXRtO49Z4FOhp6ZRTwP
 UVVmt53+CPhRiqP1VpKgKWhPQrccGyxU5VHZdsZThKT0ExYD4s2e4kH7cD3zcrl20EVD
 uEdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764618315; x=1765223115;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1O0BXRrIJPVwTg1/xeUXTIzekqe2LsP3gkp2KvlAvC8=;
 b=TW2JVkNQD972jyJkm8kt6OvJhNUNhUisKS2pe3R7x3VY9dF92www9KBZi5MDrMCC2w
 SKKIZK+fVykk8YB+uvjldjuhj9e/HFfM/WzxA1ozwWu5ksSFveq9N37Jv0pQ5qADz5dy
 fZyKMQxXGLtL4MVC8re9l9kCyYlIK7WdJCK6FhL70gH4KnyD2uv+e2ljvS8T/tgoH6Og
 RxCw9vczbh5VMfj3zeCSWrY50luda2G3BWj7TqBdf4CpScqSaHgrnuL26cpHV7+rEsT+
 dEX5h1g/LDv3weh8Ksje2sUDNyVx9u2NSc80RnKvmKZP80rjdckurVfUohnBZM0yguEW
 qzVw==
X-Gm-Message-State: AOJu0Ywxt2uRuHlsPol/H/RT8aO3QCLtYgh5/obnmZUpfSrIH1GZm72a
 LUO2nFcohd0+sMB/tLwmhdb+khd3+eW706ACiAd/mkT8h9HIsNdXEQu6xxdtWPAmSOJoCiOAhYz
 uaCpvy8blu7zaiZCx9autKa6Xz04cv8b/3KNG3lzyEFTf1uKlFPtCEN451+KLKtihfB856xNNc1
 geOsbG6ihD7mGdfGULnI8/1bxBuSg+M6O/E5XnAg==
X-Gm-Gg: ASbGncu7R7lv0dqC26PNEgtCXCRnQu+H8XwZJgbFsZjBybQT+bIdQ+iX9qwHN2abn43
 6UrY7Nw2QHp71sM76CcFQnmJlw9nIuwAp9YXZO6Zs4CxeCswblZOwPn2+k1uPeVEbLk1GexIvnG
 0qusPZodzyYXjzlePxjXSe63zUMQ7K9ZivaPqzlHX74+GHyEHrbP4K9+lVod9gTY5BcgbY8zjY1
 RxqYRRMZ00d9y6DV+gGB6h2YoWQfKzFe0VdSItmi84Keq86IZ09MMdCRQKZGvU2HLB7pEZwqEmY
 8PYjYWqKnJ0P/f4VT8HrgaiCGnmY5tRulI1JxYfpFKyzvi8lA6axMWxMUecyKgSGYAcsL3u583c
 t
X-Received: by 2002:a05:6214:4485:b0:87c:2206:2e3d with SMTP id
 6a1803df08f44-8847c4cb177mr552595416d6.25.1764618314632; 
 Mon, 01 Dec 2025 11:45:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3e5rct/6xPhTcH0xvtvABkLPIIrAlGsKTQOYaTwViBNg5TsjQHC3zy9RyzT3V7HOIIVaIng==
X-Received: by 2002:a05:6214:4485:b0:87c:2206:2e3d with SMTP id
 6a1803df08f44-8847c4cb177mr552594626d6.25.1764618314088; 
 Mon, 01 Dec 2025 11:45:14 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88652b91ba3sm88835156d6.53.2025.12.01.11.45.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 11:45:12 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH for-11.0 v2 0/7] migration: Error reporting cleanups
Date: Mon,  1 Dec 2025 14:45:03 -0500
Message-ID: <20251201194510.1121221-1-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Based-on: <20251125070554.2256181-1-armbru@redhat.com>

This series is based on Markus's recent fix:

[PATCH] migration: Fix double-free on error path
https://lore.kernel.org/r/20251125070554.2256181-1-armbru@redhat.com

v2:
- Added R-bs
- Patch 1:
  - update commit message on s/accidentally merged/merged without proper
    review/ [Markus]
- Patch 2:
  - Added a new follow up patch here from Markus to poison Error's autoptr
- Patch 3:
  - Rename migration_connect_set_error to migration_connect_error_propagate
    [Markus]
  - Add comments in commit log for both migrate_connect() and the rename
    [Markus]
- Patch 4:
  - Rename multifd_send_set_error to multifd_send_error_propagate [Markus]
- Patch 6:
  - Make migrate_error_propagate() take MigrationState* as before [Markus]
  - Remove the one use case of g_clear_pointer() [Markus]
  - Touch up commit message for the change

This series should address the issues discussed in this thread here:

https://lore.kernel.org/r/871plmk1bc.fsf@pond.sub.org

The problem is Error is not a good candidate of g_autoptr, however the
cleanup function was merged without enough review.  Luckily, we only have
two users so far (after Markus's patch above lands).  This series removes
the last two in migration code and reverts the auto cleanup function for
Error.  Instead, poison the auto cleanup function.

When at it, it'll also change migrate_set_error() to start taking ownership
of errors, just like what most error APIs do.  When at it, it is renamed to
migrate_error_propagate() to imply migration version of error_propagate().

Comments welcomed, thanks.

Markus Armbruster (1):
  error: Poison g_autoptr(Error) to prevent its use

Peter Xu (6):
  migration: Use explicit error_free() instead of g_autoptr
  Revert "error: define g_autoptr() cleanup function for the Error type"
  migration: Make migration_connect_set_error() own the error
  migration: Make multifd_send_set_error() own the error
  migration: Make multifd_recv_terminate_threads() own the error
  migration: Replace migrate_set_error() with migrate_error_propagate()

 include/qapi/error.h             | 20 ++++++++++++-
 migration/migration.h            |  2 +-
 migration/channel.c              |  1 -
 migration/cpr-exec.c             |  5 ++--
 migration/migration.c            | 51 +++++++++++++++-----------------
 migration/multifd-device-state.c |  6 ++--
 migration/multifd.c              | 30 +++++++++----------
 migration/postcopy-ram.c         |  5 ++--
 migration/ram.c                  |  4 +--
 migration/savevm.c               | 17 +++++------
 10 files changed, 73 insertions(+), 68 deletions(-)

-- 
2.50.1


