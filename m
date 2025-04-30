Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EAB5C3ABAA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 20:38:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAEBd-0003rL-Hl; Wed, 30 Apr 2025 16:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1uAEBJ-0003nr-98; Wed, 30 Apr 2025 16:37:25 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1uAEBH-00058Q-Ai; Wed, 30 Apr 2025 16:37:24 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-441ab63a415so2296005e9.3; 
 Wed, 30 Apr 2025 13:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746045440; x=1746650240; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0qFf3x0EfsGTQcaSveGZmVKx489IDI8mLEETROhYjMo=;
 b=Yh9eXw4yokrWZyWXrXegC1FhzFgAvB5908HhnNifQkvouuZmwWhajzQUFSjvEsB5dp
 BEHLnpbm8fo2yBwxINPrf4YaQqu70rOPatiH27NNrpIWodvGaKftEHIAfufuoessS3oD
 2/985wt7icqhzXvvROzkXe3nw7neMxQHQ6pMzRtaZCeumT4q7o6MOyzGiqHkiyBnfBwt
 Hst6DQ11z0LfDAApKfpxRH5RnoDjhqTe2YV5JDMnTujqsi+lRlph7tjuVMB7/AaysPQ/
 Yz1fefMOc5y9pqO8FPgymsWbesjdys6pNgro/BAyMmPkvWcgbYmzOjA3caGNZth62XB0
 x81w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746045440; x=1746650240;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0qFf3x0EfsGTQcaSveGZmVKx489IDI8mLEETROhYjMo=;
 b=Pq70R8eLHdeSk0QJPhrCmQxMBF973f7g3CzCvnKQ9QtzvMIKAxoTVwm/1IA/+EWOmO
 fmdpUQ5kSmh2dHN6WHQucux9LVzYDxi6fAaUx8XRjoDU3OFmRcIDAbZTcYoQMFm4SaDj
 wq3jcSrKE6FduJBzLFk+QwTewbGhpJ3awU97h6WWhyaZEPU4hYlL/U2/1khPWhnDTsO2
 7x84Mhl+GFQKNOL1+Rvpcpj2dl5kyI/iTR3gc5lVEXFGMQoRD4L9vyUN0ZgulYbtV5Em
 XZ0ftuvCWSHv5Us7Wv6ijJyfCWB/Qha+52hgTRpzg4Fd8H+5d27nOBKu2V6212rjKn4r
 GWjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5Wb+1r6AHX2qmpYFoCoIthi6bXt7soX1B1FHNaFIfcNMRJaYin4gWN5f+3idmOlekc9tkjXJXTCs2@nongnu.org
X-Gm-Message-State: AOJu0Yy1xtT91bV1oE2AX0Ad4XR1CJHMoHzh49yjcaWkcWRaqy0dUhuH
 iybWlVp+HbWG1Hv1Y84YhYgwQLyfrKhPOt7zo39IwTwA92gPncUZN+AJgN/s
X-Gm-Gg: ASbGncvCDpgKEF2hR/OUP4I/TDC9ddDs/pE4xs/VVsWWJFqzoLekJ/6zOT/L6SjD59C
 LMK4rt/13v3llh8v23yGlwEReWRAFynjQveW4/KS/HAG+sy+ZXVBgkHmHuzSD/BU4MB449W93zL
 WcQUYeXajRMx2Jxgwe+vADZaCoUhymPLtwhSHzwf3qoxmeD7YGmTv98i5FMo5K64u3lUqYz5SaR
 3Kq/t2MNNquSWl7izHtdqhha3hOk9TEfde/nWS4RRb7MF5AGi9uUgIrYJKqSVU2iJJeyQ3XMzf7
 2IWBb1oeC7XQb2/BuXoKZWyC/CoM2dkg2Nm+KPkiu0GBzrHrLLIaDR1HT+BPvHOFMowtgg5yHLr
 MAWstLJTIjBEN+aacqwAsplnhR43Xv4Rrew==
X-Google-Smtp-Source: AGHT+IGG5VYdGc/YZZq4I7qxMdZwgUJKCfMl6r4swjh7lEIGSlssmqEoQeIkYAtss/vMTj9Yp8NA5w==
X-Received: by 2002:a05:600c:c054:b0:43d:300f:fa1d with SMTP id
 5b1f17b1804b1-441b1f5fffbmr38989235e9.31.1746045440341; 
 Wed, 30 Apr 2025 13:37:20 -0700 (PDT)
Received: from localhost.localdomain (46-116-102-127.bb.netvision.net.il.
 [46.116.102.127]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2bb3f72sm35455665e9.21.2025.04.30.13.37.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 30 Apr 2025 13:37:19 -0700 (PDT)
From: Nir Soffer <nirsof@gmail.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <fam@euphon.net>, Hanna Reitz <hreitz@redhat.com>,
 Nir Soffer <nirsof@gmail.com>
Subject: [PATCH v2 0/2] block/null: Add read-pattern option
Date: Wed, 30 Apr 2025 23:37:15 +0300
Message-Id: <20250430203717.16359-1-nirsof@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=nirsof@gmail.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The null driver is very usefull for testing and benchmarking, but it can not
emulate an image full of zeroes or an image full of non-zero bytes. Such images
are needed for testing computing a blkhash via qemu-nbd or qemu-storage-daemon.

This change adds `read-pattern` option allowing emulution of image full of
zeroes and image for of non-zero bytes.

I used this for testing
https://lists.gnu.org/archive/html/qemu-devel/2025-04/msg05096.html

Changes since v1:
- Make read-zeroes and read-pattern mutual exclusive [Eric, Markus]
- Narrow read-pattern type to uint8 [Eric, Markus]
- Update the doc comment to explain that read-zeroes emulates a sparsse image,
  and read-pattern emulates an allocated image. [Markus]
- Validate that read-pattern value is within range
- Update secure-coding-practices guide with read-pattern option

v1 was here:
https://lists.gnu.org/archive/html/qemu-devel/2025-04/msg05098.html

Nir Soffer (2):
  block/null: Report DATA if not reading zeroes
  block/null: Add read-pattern option

 block/null.c                           | 38 +++++++++++++++++++++++---
 docs/devel/secure-coding-practices.rst |  3 +-
 qapi/block-core.json                   | 17 ++++++++++--
 3 files changed, 50 insertions(+), 8 deletions(-)

-- 
2.39.5 (Apple Git-154)


