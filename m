Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C875D65532
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 17:13:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFz7Y-00075u-63; Tue, 26 Nov 2024 12:13:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tFz7S-00075R-FB; Tue, 26 Nov 2024 12:12:58 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tFz7Q-0004G9-Rc; Tue, 26 Nov 2024 12:12:58 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-212a3067b11so50042945ad.3; 
 Tue, 26 Nov 2024 09:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732641174; x=1733245974; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nraLEcdRhzv800XFWmlyyEZTSQqqQaK9BuAuRo4hIeA=;
 b=cjVxBgR+qWAjP/SmZ7R0ClRGVpLNIINzShKerMl4Wcc9kWUQEhIcdAdLiQFquwxCpx
 KkUXzMmoVmO4nTSaZzukb1WHEumwcoBGU9OrldkgPPEHnDvd6InqtsYmUN+DiO0XD8FU
 vF71bS1F2v2LM3W1Y7akrj4Ex0DszCFPMBPf32ddHzif0TWEAQ32zZOXjunpsvhQqQ1J
 hI6wfWkJfIiZqxBQPoiJswyqgSN/k7ZdRaqq6WArrAo8CP88uyZIvkaZoTGRLyXa7Z2n
 ja+ccIX2EVERbDTtUFwF6YZUB1WuQLC8WmRzCq+bLzoYMzzwiO9pCt5FqBWI3ITYpPl6
 hH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732641174; x=1733245974;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nraLEcdRhzv800XFWmlyyEZTSQqqQaK9BuAuRo4hIeA=;
 b=Hcaj4oLywXOQ2LMxOuFgukBBVqrHY0z/qWywOFf8CpS2D+8A0P7kuWSSa0vsTGdk6c
 WVG3WeHq7X3tnOucGSuC9rXg9ODN6efkgXW1aii3hTIlapuJ+MfghsNUlum+0AYCnJv4
 aboa6GXDf9pL4X84CoWxpOud6ZW4dVUdBVIhs4qdNrKqyGi+9U7Q+j9L8sCpltn4SiAM
 puoz30P60us5JkdxqV7hZuNspTn/6uz8SpzPP02xUDQcNGh/7I6KMXHJnfgUsywVZZzE
 OPBWxoef3el+OgI7cRTnnB+V8+3S6Pojp2k0FYqVYjUXoUF+ns49KUePxQLN0kZKJRyF
 tGAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX15pmTB7hCPdJhAXgkJ02qz3OquSVjvcR+q3Zk9v6pneYBDFiJwiFiaZnS4uKJlxzBwVKdjefmzQ==@nongnu.org
X-Gm-Message-State: AOJu0YwFH3nUBliWhjq4vO87m6jr4w0eAZ92pKKrUMF6YmOfXtzKWT5i
 vIbh/wtu3N+D9dk58LozuoyUtdEB4KRzO9BooYCGBeC4EvLjhd8HOXjFXg==
X-Gm-Gg: ASbGncvGU6Ubn+ULL4hSItsswTMH0bJa2C5o9fkxVOCdPhWGqr3dOQa4d3A7ejglARO
 2yzAouE/C6QcTEPyVCj3uEEaMQAD87Zd8q+dqeOMfQvTIaAgPzKUO4H33IyiPXr1i6T1rUNfH/E
 yQHoCpkkymZ9PqiU7oqYpKeIFi6Nr3+L0HyadRywj9EyKbwoU3TUXNMenJJtGAv9I6aksxm1wPF
 8GVb/WuxJNy9pJBE0w9H161OJ9rScm4O2KMAQqh79f/bktvrzkpVsyZlsQrQRiF1aLlW78ZddqJ
 5Ci77g==
X-Google-Smtp-Source: AGHT+IF0ZLkF7XZHpr7ozucYl0lIbO4yRbkYy/JNdWxfI2lLpvi4qHnNfzBHAI15gAvcJak43yrbQw==
X-Received: by 2002:a17:902:c948:b0:212:5636:7923 with SMTP id
 d9443c01a7336-2129f6b25c2mr205584625ad.21.1732641173824; 
 Tue, 26 Nov 2024 09:12:53 -0800 (PST)
Received: from wheely.local0.net (124-171-72-210.tpgi.com.au. [124.171.72.210])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2129dc21c28sm87321175ad.246.2024.11.26.09.12.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 09:12:53 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-ppc@nongnu.org
Subject: [PULL 0/6] ppc-for-9.2-2 queue
Date: Wed, 27 Nov 2024 03:12:29 +1000
Message-ID: <20241126171235.362916-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62c.google.com
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

The following changes since commit ba54a7e6b86884e43bed2d2f5a79c719059652a8:

  Merge tag 'net-pull-request' of https://github.com/jasowang/qemu into staging (2024-11-26 14:06:40 +0000)

are available in the Git repository at:

  https://gitlab.com/npiggin/qemu.git tags/pull-ppc-for-9.2-2-20241127

for you to fetch changes up to 0805136a44d39adc2467f23ac3c65e680e45d0a2:

  hw/ppc/pegasos2: Fix IRQ routing from pci.0 (2024-11-27 02:49:36 +1000)

----------------------------------------------------------------
* Assorted small ppc fixes

----------------------------------------------------------------
BALATON Zoltan (1):
      hw/ppc/pegasos2: Fix IRQ routing from pci.0

Glenn Miles (1):
      target/ppc: Fix THREAD_SIBLING_FOREACH for multi-socket

Harsh Prateek Bora (1):
      ppc/spapr: fix drc index mismatch for partially enabled vcpus

Nicholas Piggin (3):
      target/ppc: Fix non-maskable interrupt while halted
      ppc/pnv: Fix direct controls quiesce
      ppc/pnv: Add xscom- prefix to pervasive-control region name

 hw/pci-host/mv64361.c       |  1 +
 hw/ppc/pegasos2.c           | 30 +++++++++++++++++++++++++++++-
 hw/ppc/pnv_core.c           | 11 +++++++++--
 hw/ppc/pnv_nest_pervasive.c |  2 +-
 hw/ppc/spapr.c              |  2 +-
 hw/ppc/spapr_cpu_core.c     |  1 +
 target/ppc/cpu.h            |  8 ++++++--
 target/ppc/excp_helper.c    |  7 +++++++
 8 files changed, 55 insertions(+), 7 deletions(-)

