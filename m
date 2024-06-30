Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B1CC27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2024 03:53:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNlcN-0003E2-9l; Sat, 29 Jun 2024 23:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1sNlcL-0003DM-AA; Sat, 29 Jun 2024 23:52:45 -0400
Received: from mail-qk1-x732.google.com ([2607:f8b0:4864:20::732])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1sNlcJ-0004i3-Kv; Sat, 29 Jun 2024 23:52:45 -0400
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-79c072af217so151610285a.0; 
 Sat, 29 Jun 2024 20:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719719561; x=1720324361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NmwbteCfpO3uyJdEmrJc8x7ZEsVLqBwAMO3T2LOhdJU=;
 b=CXsRy2UJDKLE3a3m8BGwPwxLz26h0VBqp0mgWYSHxs9d2HVXUNWR7s6tBZk+o6rnUN
 MFQglhzdU4Xg7651pzmB1XLmGWz1qkqPa/+zXu9qWQfWI24TBeLYz/Kk+TDgEPhSLQ/o
 W+0Q50SdDqUq0Qja2zD0lEGCBQZrjW6Yhj86JiC2Xkr+pkGy7SMZtIPHTkpAYVC3BEpy
 Ksm5PipdhX3ykMO2y5be9K9C6wFOq/NTO30VUY+o14w8bTZ13NOIF6etGRNzsNGMTmJZ
 lzKehEaq4idqsCSV4T00t+J2TmGBDCMJGobo80bMs77ObAHB5J8uqZJ+ZB9KkMw4qpF4
 kEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719719561; x=1720324361;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NmwbteCfpO3uyJdEmrJc8x7ZEsVLqBwAMO3T2LOhdJU=;
 b=DH8OPleWsZMcyWpweCc/nLBkZZHhSEX28TbThTJxRAPOFlauA6asN/4T/Xu4qhsNcq
 nUzj6aaSIa5HZ97XVHAQEf2XouMsIA5lls8nnoCOx57ZhGuCa6xY1Tn3u6aTymGxZMOh
 OyPzhPvk0ok4GyCTqJ6nR1vHRdF6jc9HHGlL5oWqOUxArLYFOwVZhPQRQIrPPjn+5nQN
 ACkGMW+68bCBcGORdZ4bxYeHX7s4m2L6LJuLReE6hOmJQJJtNqxDuzxe/PGmk8CxucVb
 cYQ8URYmW9nqcPX34okL8mDj2QaY/OgPrWtOseYYrLgHAjUwT1Z6YoFtM+hp/+tDKmIN
 Hkvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaSthNiV0vI26W0iY973BE4QXLZO/AaY8qIOarcFHlz0PMxEV4+l5tAdwp1uEUvGnvkU70Vhn4/aW1847AcEyetlmliAo=
X-Gm-Message-State: AOJu0YzbA0bvVM/OIsZ/9LrVO6PeCdO4UO366ZB79jELa0pBJ4WqgBQn
 odk9oOo1WYvBGvbwV3pRwC8OGRgJx3ime+iyUhAUcwHQBMMNXUg7Eiee7V6U
X-Google-Smtp-Source: AGHT+IFqYygfK7FzU892RYa2S17Uc2lrNT/rVBwWJsjtV5Tb2QCR+kciIrpqppCD4RUJxHdBlYnsOQ==
X-Received: by 2002:a05:620a:4408:b0:79b:f10e:118b with SMTP id
 af79cd13be357-79d7b7f8841mr435660385a.0.1719719560929; 
 Sat, 29 Jun 2024 20:52:40 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([210.223.46.112])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac1538f5bsm39213055ad.152.2024.06.29.20.52.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Jun 2024 20:52:40 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: fam@euphon.net, pbonzini@redhat.com, qemu-block@nongnu.org,
 jeuk20.kim@samsung.com, j-young.choi@samsung.com
Subject: [PULL 0/1] ufs queue
Date: Sun, 30 Jun 2024 12:52:20 +0900
Message-Id: <cover.1719719120.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::732;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-qk1-x732.google.com
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

From: Jeuk Kim <jeuk20.kim@samsung.com>

The following changes since commit 3665dd6bb9043bef181c91e2dce9e1efff47ed51:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-06-28 16:09:38 -0700)

are available in the Git repository at:

  https://gitlab.com/jeuk20.kim/qemu.git tags/pull-ufs-20240630

for you to fetch changes up to e12b11f6f29272ee31ccde6b0db1a10139e87083:

  hw/ufs: Fix potential bugs in MMIO read|write (2024-06-30 12:44:32 +0900)

----------------------------------------------------------------
hw/ufs: fix coverity issue

----------------------------------------------------------------
Minwoo Im (1):
      hw/ufs: Fix potential bugs in MMIO read|write

 hw/ufs/ufs.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

