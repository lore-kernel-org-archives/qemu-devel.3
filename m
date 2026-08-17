Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28340C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 19:00:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww2Yu-00061M-QC; Mon, 17 Aug 2026 14:59:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww2Yo-0005zX-U8
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 14:59:50 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww2Ym-0006Lv-IU
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 14:59:50 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-480033bdcf4so2287893f8f.2
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 11:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786993185; x=1787597985; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QQeJnlzaGsDwCThCrJ+RgTx9PkVtakU70eCIVxIn6VQ=;
 b=gYfRqxl6XMsRUQUuQuIABlTkxOyUS6gjvKM7DpAAetzlT3imp7fyO27p8DwNPBx6lQ
 4BQ+tO1HXNB0Uxy+66t8TshdibostQpd7z1K2sYYlKyxrpM14lJbVhQ6Ksv1u828vEWC
 oGVzuCbKsenQWCwiO+WCfs+swSysAQz91Z4LJYr53RU+SaqFPcjeGb5miEqTzvr+TgK5
 v3OUJQzsQiN7CS/r1v6gevdxCXlUI9WvEXCLCkcr/KcxUWx+7eSHlNRXv0mhbsnURjsr
 GRxSbuWOk3kFR6ahVjvyVC4EzFnavHxIvN8xhA8H3/zfxQAU6GnJtSGwLvLHOCQR5ExK
 oSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786993185; x=1787597985;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QQeJnlzaGsDwCThCrJ+RgTx9PkVtakU70eCIVxIn6VQ=;
 b=tYjUOaRxJuaasRmylE221wDWtmGdv5ZRT4wVrQOeqV7qtuZ8ESqJ8NAddFI+g7iHat
 uUFliOUiwOFeSHt18f4OEsfCmsy0gwZN/3NUopUA6T1TlwkkKiHo1fYZDJYNKEFjwCxZ
 9t3PJgvuguJ6hV/AK8vz2TzMMyPZUQDtn8wDoHDdYqALmYxQ3N4MWWYS7lmtW+nTF5FG
 RZteeZwDzOQJuDwyNcboOt9kLHWnKReGevTcP1YWEdaUfDwE7Uqt81Yf6rsDeM/cYnkC
 gbXfktav5+9jFmKdByUbFsFSzVBmfZJW+pSSAO4Mh+f17K1HicAyUK6xhn3SqyBPKwMY
 1C/Q==
X-Gm-Message-State: AOJu0Yx8I0Rp/EXWIPbSjRU5adBynOS67Hlo+FoYrrwZRuyMp7ImbyQh
 OdNHpYxrwI/7zyRrHBafT6UoCeMpxrT27Xh0/oaFlsX9ebXKAczVzKkcQ7utK4MW/HkzyuCip59
 xexT9
X-Gm-Gg: AR+sD11pkn9DZwArC2r2cTIFaTFmRpALTDGzSEPFpH2tjRsvkkn/v10ZmHdDOxsit8A
 MWbnhuBXJfSboyBzGchKQ/7FSm2EpQxzGglApjT9dPemkQ+5AGRORf9yvLCQQEIfgVEAg7/uboJ
 hE86TXZi1KbwZSR9n6uF/+G/g3BnWdVbh04HhCt94PcYDPRc/TO67IB/iGVmtKdo9cQQqrDz8PC
 YpA7q8db+AqPV9y9YlWRJMUdwxoym8QLYdUDgWod+/SRaYSVCi51xtEgQKzmaKxUZsaZzi0RaEX
 BHIWbpu5E2gEzWkpmSOQ6D0YRLo6FOeMgI5x1ObLKXgMm1/FS71z5YjAHGjQ60zneLUqhZF+71m
 jZZu1XUvdU/tU9X8kmuDh6uS5MFSSYRn1ENI4fJuLtkMNs+U7btwZWPqRTt9C3cSeXA6uzAY3eI
 7eIvlNOiFy0UCF3BJbms27zhCGQRlulm9jG3dpl5fnG539s/5JfZ+qxE+Gi8h7
X-Received: by 2002:a05:600c:1395:b0:499:872b:abd4 with SMTP id
 5b1f17b1804b1-4998797684cmr379847885e9.6.1786993185024; 
 Mon, 17 Aug 2026 11:59:45 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:f6f8:884c:b162:eaeb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996188217sm381011085e9.13.2026.08.17.11.59.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 11:59:44 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v6 00/25] parallels: Add full dirty bitmap support
Date: Mon, 17 Aug 2026 20:59:17 +0200
Message-ID: <20260817185942.1065143-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=den@openvz.org; helo=mail-wr1-x432.google.com
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

Parallels format driver:
* make some preparation
* add dirty bitmap saving
* make dirty bitmap RW
* fix broken checks
* refactor leak check
* add parallels format support to several tests

Alexander left the team, so v6 comes from me. v5 was:

https://lore.kernel.org/qemu-devel/20240311181850.73013-1-alexander.ivanov@virtuozzo.com/

It does not apply to master, it goes on top of "[PATCH 0/8] parallels:
fix Format Extension parsing", which applies to commit 3e3ccab106f8
("Update version for v11.1.0-rc3 release"):

https://lore.kernel.org/qemu-devel/20260811173857.396571-1-den@openvz.org/

v6:
Reworked, so the numbers have shifted.
2: Made it .bdrv_inactivate and armed the in use flag on activation.
3: New patch, inactivating a read-only node.
5: cluster_end is uint64_t.
6: Absorbed the mark_unused helper, fixed the used bitmap growth.
7: New patch, the check no longer dies on what it is meant to report.
9: Absorbed the three parallels_check_leak() patches and the truncation.
10: Dropped the redundant bdrv_pwrite_zeroes() of the reuse branch.
11: Refuse a bitmap which does not fit, report a lost one, added ext_end.
12: Absorbed "Make a loaded dirty bitmap persistent", drop a broken one.
13: Bound the search by the region rather than by the cluster.
14: New patch, the Format Extension against the leak check.
15: Skipped test_reopen_rw, the bitmap name is a UUID.
16: New patch, a bitmap L1 entry has to point inside the data area.
17: Mark the bitmaps inconsistent instead of skipping the load.
18: New patch, block-dirty-bitmap-remove reaches the image.
19: New patch, qemu-img info reports the bitmaps.
20: New patch, renames parallels-read-bitmap to parallels-bitmap.
21: New patch, covers storing a bitmap.
22: New patch, covers the qemu-img bitmap sub-commands.
23: New patch, covers a broken Format Extension and a combined repair.
25: Added a comment about the bitmap name.
Dropped "Preserve extensions cluster for non-transient extensions" and
"Reverse a conditional in parallels_check_leak()".

Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>

Alexander Ivanov (4):
  parallels: Set s->used_bmap to NULL in parallels_free_used_bitmap()
  parallels: Make mark_used() a global function
  parallels: Create used bitmap even if checks needed
  tests: Turned on 256, 299, 304 and block-status-cache for parallels
    format

Denis V. Lunev (21):
  parallels: split inactivation out and add the activation counterpart
  iotests: cover inactivating a read-only node
  parallels: Limit search in parallels_mark_used to the last marked
    cluster
  parallels: Move host clusters allocation to a separate function
  parallels: do not let the check die on what it is meant to report
  parallels: Drop unused clusters at the end of the image
  parallels: Remove unnecessary data_end field
  parallels: Add dirty bitmaps saving
  parallels: Let image extensions work in RW mode
  parallels: Handle L1 entries equal to one
  iotests: cover the Format Extension against the leak check
  iotests: run the persistent dirty bitmap test on parallels
  parallels: reject a bitmap L1 entry outside the data area
  parallels: do not trust the bitmaps of an image which was not closed
  parallels: implement removing a stored dirty bitmap
  parallels: report the stored dirty bitmaps in qemu-img info
  iotests: rename parallels-read-bitmap to parallels-bitmap
  iotests: cover storing a parallels dirty bitmap
  iotests: cover the qemu-img bitmap operations on parallels
  iotests: cover a broken Format Extension and a combined repair
  tests: Add parallels format support to image-fleecing

 block/parallels-ext.c                         | 433 +++++++++++++++-
 block/parallels.c                             | 455 +++++++++++------
 block/parallels.h                             |  23 +-
 qapi/block-core.json                          |  40 +-
 tests/qemu-iotests/165                        |  18 +-
 tests/qemu-iotests/256                        |   2 +-
 tests/qemu-iotests/299                        |   2 +-
 tests/qemu-iotests/304                        |   2 +-
 tests/qemu-iotests/tests/block-status-cache   |   2 +-
 tests/qemu-iotests/tests/image-fleecing       |  14 +-
 tests/qemu-iotests/tests/inactive-node-nbd    |  14 +
 .../qemu-iotests/tests/inactive-node-nbd.out  |   8 +
 tests/qemu-iotests/tests/parallels-bitmap     | 471 ++++++++++++++++++
 tests/qemu-iotests/tests/parallels-bitmap.out | 106 ++++
 tests/qemu-iotests/tests/parallels-checks     | 236 +++++++++
 tests/qemu-iotests/tests/parallels-checks.out | 185 +++++++
 .../qemu-iotests/tests/parallels-read-bitmap  | 231 ---------
 .../tests/parallels-read-bitmap.out           |  39 --
 18 files changed, 1827 insertions(+), 454 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/parallels-bitmap
 create mode 100644 tests/qemu-iotests/tests/parallels-bitmap.out
 delete mode 100755 tests/qemu-iotests/tests/parallels-read-bitmap
 delete mode 100644 tests/qemu-iotests/tests/parallels-read-bitmap.out

-- 
2.53.0


