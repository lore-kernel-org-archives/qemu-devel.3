Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A5DC369A4
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 12:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u28L7-0007pf-SS; Tue, 08 Apr 2025 08:46:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1u28L5-0007iL-S9; Tue, 08 Apr 2025 08:46:04 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1u28L3-0003sO-GB; Tue, 08 Apr 2025 08:46:03 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3012a0c8496so4241084a91.2; 
 Tue, 08 Apr 2025 05:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744116359; x=1744721159; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2eFMEzvBS6bZqvN75o4ZCN5c048s98s3EVdXK9JnA5U=;
 b=XrQJgLc+lYl8mGCVGUUHmteYROn6nFLXa+Swv22dSAly+t9WXnUto+rPlY9k+2fbie
 T52ZfK+XFHk/W6Tt1CSneaGtDct8bF7470r1rNRTr07FLCZlEIWUI2v7SvCks2Bowf1g
 h+3fK16aZ3CEl/kETjoj/IqGQqcw7W+loRs9YJzbjWtDEK4CIlci8phX0Ix5XGbxAHCX
 ry/kYkyKDEKzh0QAPx7OiSSIdreBlqwVNq7eMZgbxIlovEg8rp3D7KLzF0qAPbSL6Wq1
 ugVTZsatoU7vwZMnq9ORdeq6MwbAEY6KGubWxT5nLJX49fqhztycDDe/fpRg4iXfBK1H
 9hcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744116359; x=1744721159;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2eFMEzvBS6bZqvN75o4ZCN5c048s98s3EVdXK9JnA5U=;
 b=EYEEiBIgymVwS3mlERtLnu1enp9lghH/07jHlYRGwOkXJOzI4s562WDOkaEtLuQ40Q
 k3mNHhnQuXuPi8J0GoVB/mxXYI+TeS0yKShx9PerD8PCx9NkR8DCQwXolYC6L2X1DpZ1
 s6KV9+/aQrASCTVKHCIRLOisxmQ77BifvbgMC/rAiDvXZmQNcrJm0pKYsqgwpvAfjmkD
 gmv4s+H/+j60q0MeiYuZm5/mghxZXqdtDCmtgU+IqUP2neul7vBbKiQizYM6gCnAkZnq
 0RPbXZnFf3pfDUyN4jrEwE+PucOS5/sn/R5OUyn9KMmnNUwn887I226zVTO6aO9NZrmy
 IinQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjyMCHJyMJrqN1V9Bm/nygN2Hl13tR1uzk6uZFbqy8dBgrLID8U/GFv09+HfVhAja+M9d1wzFmxA==@nongnu.org
X-Gm-Message-State: AOJu0YzKjJqEeUUs1f1YsSsc/bf99hUbEQmw0DwcCf6DM5bMyC5yc8X/
 ejkBBxA+xkRP/495DQYs7dwEDuaEut3tfY0GgM8TpHQ7nKrOsy9LUjjvtQ==
X-Gm-Gg: ASbGnctScidVHK6Yh5uct0etlxEVicJVRx28iYvLBlPriQiYbL3Ecs0vIDOOilZ2A3t
 6G9biYFhFC2GQghQjgWVDHgibF6H664+bydQc1ZOoQqHxE7phzgiO+KEA4ca/a5WjTRwI19Jm4M
 iB0LvKUTFtRMEFX7jCWzemVKTIX3ZfHwZCHC/LujRMBufM3iJDU/XYc6WqKRCcut69pKhSwga1i
 Tg/1IV/GUAbnoYnu9NOFvLWWf7jzrEhDB7fEyp1vh66f7jxKgquIznu1qicEzgF1TUGoP2BsIXq
 N0o61gMl7/3v0hC0ibjHD+gk/8I0tVE3IYkCbzDGcevHKoiK1KZhCGueH8obCOYXbajllxs8Bjn
 tWOZm4w==
X-Google-Smtp-Source: AGHT+IH2tc/TRxuDg9Y0n8T/Ba0ixLFPIgbJLdJtEUc5RMjPQgyub+irGr/5gaACtORgR4YYUjxzQQ==
X-Received: by 2002:a17:90a:d450:b0:2ff:5357:1c7e with SMTP id
 98e67ed59e1d1-306a48a4b94mr21724666a91.20.1744116358691; 
 Tue, 08 Apr 2025 05:45:58 -0700 (PDT)
Received: from wheely.local0.net (27-32-255-92.tpgi.com.au. [27.32.255.92])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3057ca1f07fsm11036235a91.6.2025.04.08.05.45.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 05:45:58 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-ppc@nongnu.org
Subject: [PULL 0/2] ppc-for-10.0-3 queue
Date: Tue,  8 Apr 2025 22:45:47 +1000
Message-ID: <20250408124550.40485-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102f.google.com
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

The following changes since commit dfaecc04c46d298e9ee81bd0ca96d8754f1c27ed:

  Merge tag 'pull-riscv-to-apply-20250407-1' of https://github.com/alistair23/qemu into staging (2025-04-07 09:18:33 -0400)

are available in the Git repository at:

  https://gitlab.com/npiggin/qemu.git tags/pull-ppc-for-10.0-3-20250408

for you to fetch changes up to b3d47c8303b8be2c3693c5704012b3334741b7ed:

  target/ppc: Fix SPRC/SPRD SPRs for P9/10 (2025-04-08 20:52:49 +1000)

----------------------------------------------------------------
* Fix a couple of recent regressions in powernv SPRs

----------------------------------------------------------------
Nicholas Piggin (2):
      target/ppc: Big-core scratch register fix
      target/ppc: Fix SPRC/SPRD SPRs for P9/10

 target/ppc/cpu_init.c    | 23 ++++++++++++-----------
 target/ppc/misc_helper.c |  9 ++++++++-
 2 files changed, 20 insertions(+), 12 deletions(-)

