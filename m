Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7161AFA1FCE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 16:13:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFaBd-0000Pz-LU; Wed, 22 Apr 2026 12:12:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1wFaBZ-0000PG-RP
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 12:12:22 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1wFaBX-0005P1-3b
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 12:12:20 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-82f8b60e54dso3743296b3a.2
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 09:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776874335; x=1777479135; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XkwnlAaIhmzRWKnpfKUMWyjcWDJ6wWPYevSxB2grds0=;
 b=cPkWmns+ER0PU3gWQU4st5iCvQouQtBk8Pb1K7E6hXOcYNhlB482Cy8cKuBL5q9NQt
 pwmARcGBy5WVk8bbqNTKpywOEc5OIoxm/6pw/P51SjogkmOndV87pY8cb0zQtbsWptFF
 g8gN2cE9rLdz+6td5fnS2lcHt8EndrfjiGWdgX4CPjGWFvgb85aqqzAyzVlclEC+dnWX
 fiZCc8gUXbvjZ5gAhFDVQmjjV3pMreUA3ha3Sy/t8Y0ec5QoD0qZmsC2ZxXBTLiDttXc
 S6keIpYqj5Mt0G0vu/sd7KkqT7ZjC+m04Rx7YUwfT41J2e/Z+AMaYgNFDCeXE4gGLgYk
 raOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776874335; x=1777479135;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XkwnlAaIhmzRWKnpfKUMWyjcWDJ6wWPYevSxB2grds0=;
 b=L2oWLIdQhc6qHu8C4N+ZkOQ6bqZeXk+n/U2WEtOubuBwUQGokr7iHjXE6UjhJhTc5F
 93Om+fLIsWf7BZTKjKbyEyXMza0OWrB9jpiYw+nl3D76kmc88BqkXpVJ6YxViVaS2Qj0
 eP+rq7dGfy2hfdMLbdj+6ULhSe/jJmgZfiH8TU0+QeSJPGs62aw5WpyD28jGhmOW6tEJ
 rXdFxUj8Cgq9zXgXMuRAINj5mlEHB1HAKEVKqYefxEs0YKRd5O1IYDOjgNdMWzr7S5qu
 oAGYQi60M/PnA5VU1HmfpdW5DouQ67P3CqIG+dRbBUSv4QFtg7d15lGDAo9+Q9MNXrtb
 1Q4w==
X-Gm-Message-State: AOJu0YztzxbyEdqgqLBibzNQuiiCgIC/km3TKe2dHoUQEn7NZE37h1DB
 ylpLJHf5en/YSe85YASauD88TN8dCLhMLOi9UWV/QV5rwwOakfZzXz14c5DLxw==
X-Gm-Gg: AeBDiesqWeMwsBu4cyY85BmTHEL30KGKECMCQvbL47Ix8Ucbu/57asVP0SznDZn6Fol
 C7potUqadeS3g62IftxN01txibtK1qMmCJQ9KSmxe0FI30JKVXoR8hAvp/TOnjL/V9ik73c8Jlx
 KoKrJl/mJJ615mhHQWOKAv64qROfpmut4iK7MwAXuqRkiTM2dYAyVsh4k8zG0TwKYCdqK/kKsLE
 J5K4ahvipbGb1DNlCyW+WIzhcGWiee0mYcsI73TcLDJj/oA1QECPGIdIl1y77tQpKFkdebI6WXs
 8djQNXfGfsf87ARCfPrBZHmbQmhojaWCDezfwYnq2B76+tV8V7UpSi7CbfmohNJREcUt5kb5bMq
 WsUtqG2X1UOeB4QmuKXFAh4OecZlT0U//zSQSyu3yNCBQTX4elS3ZDtL3WoKrcK68tILiaWnXAz
 COQj78gDahuPyXH7HmJTTBsdsnQfwWaibuexPr06+CDiQk4FdtExSO3vgwiA==
X-Received: by 2002:a05:6a00:2da2:b0:829:8942:2c85 with SMTP id
 d2e1a72fcca58-82f8c86b594mr23653843b3a.17.1776874334657; 
 Wed, 22 Apr 2026 09:12:14 -0700 (PDT)
Received: from localhost.localdomain ([42.114.219.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e9cbb28sm16558138b3a.13.2026.04.22.09.12.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 09:12:13 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
X-Google-Original-From: Trieu Huynh <viking4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Trieu Huynh <vikingtc4@gmail.com>
Subject: [PATCH 0/1] migration/multifd: fix channel count TOCTOU race on
 cancel and retry
Date: Wed, 22 Apr 2026 23:12:01 +0700
Message-ID: <20260422161202.34150-1-viking4@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=vikingtc4@gmail.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Trieu Huynh <vikingtc4@gmail.com>

QEMU aborts on src during multifd migration when multifd-channels is
changed after migrate_cancel:

~ # qemu-system-x86_64: ../util/yank.c:107: yank_unregister_instance:
Assertion `QLIST_EMPTY(&entry->yankfns)' failed.
Aborted (core dumped)

Below is the backtrace:
#7  yank_unregister_instance (instance=0x7fffffffd870) at ../util/yank.c:107
#8  migration_cleanup (s=0x555557649d10) at ../migration/migration.c:1338
#9  migration_cleanup_bh (opaque=0x555557649d10) at ../migration/migration.c:1345
#10 migration_bh_dispatch_bh (opaque=0x7ffe500051d0) at ../migration/migration.c:350
#11 aio_bh_call (bh=0x7ffe5006d670) at ../util/async.c:173
#12 aio_bh_poll (ctx=0x555557649210) at ../util/async.c:220
#13 aio_dispatch (ctx=0x555557649210) at ../util/aio-posix.c:390
#14 aio_ctx_dispatch (source=0x555557649210) at ../util/async.c:365
...

Steps to reproduce:

* 1. Start VM on src
./qemu-system-x86_64 \
  -<other_options>

* 2. Start dest with -incoming defer
./qemu-system-x86_64 \
  -incoming defer \
  -<other_options>

* 3. Enable multifd with 4 channels on both src and dest
{ "execute": "qmp_capabilities" }
{ "execute": "migrate-set-capabilities",
  "arguments": {"capabilities": [{"capability": "multifd",
                                  "state": true}]} }
{ "execute": "migrate-set-parameters",
  "arguments": {"multifd-channels": 4} }
{ "execute": "migrate-incoming",
  "arguments": {"uri": "tcp:0:4444"} }

* 4. Trigger migration
** dest:
{ "execute": "migrate-incoming", "arguments": {"uri": "tcp:0:4444"} }
** src:
{ "execute": "migrate", "arguments": {"uri": "tcp:127.0.0.1:4444"} }

* 5. Cancel migration on src while status is active
{ "execute": "migrate_cancel" }

* 6. Immediately change multifd-channels to 2 on src
{ "execute": "migrate-set-parameters",
  "arguments": {"multifd-channels": 2} }

QEMU aborts as shown above

Trieu Huynh (1):
  migration/multifd: fix channel count TOCTOU race on cancel and retry

 migration/multifd.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

-- 
2.43.0


