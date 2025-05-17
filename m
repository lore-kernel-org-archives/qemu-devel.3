Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E40C3ABDD
	for <qemu-devel@archiver.kernel.org>; Sat, 17 May 2025 20:12:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGNt4-0005RA-Qv; Sat, 17 May 2025 16:12:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1uGNt3-0005Qx-Fb; Sat, 17 May 2025 16:12:01 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1uGNt1-0001zj-Oz; Sat, 17 May 2025 16:12:01 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a0b9c371d8so2778106f8f.0; 
 Sat, 17 May 2025 13:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747512717; x=1748117517; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BmIn30CLgvHNMRb0we3UJOXvGtozu64nyv3bzf4pteI=;
 b=lwmcqz0kbc7IP64PRaVqGSSTTQ7QeGu7fkfXrpaqLnwwsb4m+WWXceT22kViDT/fTR
 cnWTc+hSqTU7oqE3wldbImzKXF98HgUpLGBEy08mbP2Pei1CFOU2M8Ak9NkD+b8P4um1
 M7OTuD2YpK7udlhpDfwwKDjOtU0b/Ae9qrgPS64YH4m/1KMHGNcRzmzDIx9ji8etSoZC
 MXh8ZIEhxn+Ktz0w0wznh9tguYvg+6aE7T+kCSJ9HTpVQK4v7pKK37HLziZWVhjx9aXM
 Ft7eQNpT3CW/f0co2j9PAhbvkyTFwa40PgCb/9aF0QTrS75QYU6z4YqxDW4BPy+SpjGo
 mgVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747512717; x=1748117517;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BmIn30CLgvHNMRb0we3UJOXvGtozu64nyv3bzf4pteI=;
 b=rSEGXovJRprh5irYHiWEV+IYxsmu2IPwjioAk6UJHZGzZflW87RziIr1wJOz2MiN/3
 E7aFs0P1H6f2Qbt+jmkHDiodtTa/FQe0QwqC1spT2oT0Ak6TBLQptsHElhUR6LIj5tDc
 Rgn9S8PyPnxM4Rgm/ERI5IhjLT54IMGf5RBloG+WlpJ655dv/Hozv8q/L/De/z6YgSNc
 lbui809Rh7dlij/wSO8vK2R3lV9ZrYYHX43lRZhqwCXurx5FKWJOZgyG1GXGM0SERHOy
 xtoqtyAZT0RSZU7cqVJED4mECNds/km4bRQq7qTNxvzEVEBTHVUg/of0+6xvmX3hJYnm
 sVqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVF38l53k/ZuLOlOM83MIoyi9IfCz4cqm74N74Q4+gevdic1fKcBg28HzosnvFs0bv0ZmmIarkFIPlS@nongnu.org
X-Gm-Message-State: AOJu0YzVSUnFS7xq1Np9e5ykIj2QH5LnGHs3RAZU63tu4lQE7PtKSO32
 0c1BgV9C9j+GzVgH4IybsNImey+RMJLgVDoYRP9+9MFnFBcdWLeADKeqKupVTBnx+Hk=
X-Gm-Gg: ASbGnctC4dxGZyqOjLWfmsazhYPyeGe2CsWHCprbVnHNae1P0eY40E+OjHyMs2EV32Q
 JBkuMhoezJySFUWzPWxypA5CZeeKaiH44IZsJVz/fNxDlUOQ0XwdnBiitoUymM8dVp39D1ftr3l
 4C5tROQMFhTHJktiQlmg9hVFK9wBUPFiIZHkibsOuHlXb3yRSJ4qefx4wxCZLjc5PgpliI33dDG
 kKBxcGbaSUX/H7OVGawTjIOB0gPL8CyyzUyV761G4Fq7zVo9Ry/p7CzmqfduWYbW5kEoFhrfTmK
 LXZHLERgfaL6/9Rw98TLM18W8K4jg7ohPnGgdjj4KwimgJypp0yi5HUC2eu3HpiEEMhK4o5xZQh
 TkpTe1qksHGAOxYRU8xfgryDOTH8YVRD8zG7g5BPg/g/2
X-Google-Smtp-Source: AGHT+IF2BHBSnYrKPjxocAQ5R0Goa86yhT5jX+pOADE+FF+XKYoG8NlPLIPU6jcl59/OP8HVHZV6FA==
X-Received: by 2002:a05:6000:438a:b0:39c:2665:2c13 with SMTP id
 ffacd0b85a97d-3a3600dbbcbmr5776159f8f.54.1747512717034; 
 Sat, 17 May 2025 13:11:57 -0700 (PDT)
Received: from localhost.localdomain (46-116-102-127.bb.netvision.net.il.
 [46.116.102.127]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442fd59ab21sm78714715e9.38.2025.05.17.13.11.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 17 May 2025 13:11:56 -0700 (PDT)
From: Nir Soffer <nirsof@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Richard Jones" <rjones@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org, Nir Soffer <nirsof@gmail.com>
Subject: [PATCH v4 0/3] nbd: Increase unix socket buffer size
Date: Sat, 17 May 2025 23:11:51 +0300
Message-Id: <20250517201154.88456-1-nirsof@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=nirsof@gmail.com; helo=mail-wr1-x42b.google.com
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

On both macOS and Linux, the default send buffer size is too small causing poor
performance when reading and writing to qemu-nbd. A simple way to experience
this is to compare TCP and unix sockets, showing that TCP socket is much
faster. Programs like nbdcopy partly mitigate this by using multiple NBD
connections.

On macOS the default send buffer size is 8192 bytes. Increasing the send buffer
size to 2 MiB shows up to *12.6 times higher throughput* and lower cpu usage.

On Linux the default and maximum buffer size is 212992 bytes. Increasing the
send buffer size to 2 MiB shows up to *2.7 times higher throughput* and lower
cpu usage. On older machine we see very little improvement, up to 1.03 times
higher throughput.

We likely have the same issue on other platforms. It should be easy to enable
this change for more platform by defining UNIX_STREAM_SOCKET_SEND_BUFFER_SIZE.

Changes since v3:
- Modify only NBD sockets, since not all sockets need a larger buffer size, and
  the fixed memory overhead per socker may be a significant amount of extra
  memory overhead on a host. (Daniel)
- Add qio_channel_socket_set_send_buffer() helper to set buffer size from nbd
  code.
- Remove the check for SOCK_STREAM since NBD does not support SOCK_DGRAM.
- Warn if we fail to set the socket send buffer size.

v3 was here:
https://lists.gnu.org/archive/html/qemu-devel/2025-04/msg05096.html

Nir Soffer (3):
  io: Add helper for setting socket send buffer size
  nbd: Set unix socket send buffer on macOS
  nbd: Set unix socket send buffer on Linux

 include/io/channel-socket.h | 13 +++++++++++++
 io/channel-socket.c         | 11 +++++++++++
 nbd/client-connection.c     |  3 +++
 nbd/common.c                | 26 ++++++++++++++++++++++++++
 nbd/nbd-internal.h          |  5 +++++
 nbd/server.c                |  2 ++
 6 files changed, 60 insertions(+)

-- 
2.39.5 (Apple Git-154)


