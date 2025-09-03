Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC9FFCA1007
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 04:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utf3y-0005cQ-RZ; Wed, 03 Sep 2025 00:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1utf3u-0005bv-By; Wed, 03 Sep 2025 00:25:34 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1utf3s-00044A-78; Wed, 03 Sep 2025 00:25:34 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-b4c53892a56so5325339a12.2; 
 Tue, 02 Sep 2025 21:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756873529; x=1757478329; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dH4j7hWiGl6J+eOSDraAdf88k8xdTBcdGBajv5DBJp8=;
 b=MuA/Wd0roamlcNuhFTnOKWBYouKmjAsh8VEoZrVVLFnOJoOxhi1nV/jPmDE86ojhJJ
 I35t/fSMLuNB5/UN6KUhau3sXXExLtHiB4BHWLKFhavpc9wsNZhSZ3wIHYs7YJK0ywVn
 ipBGZfnosKRDiUik/krZCv2hXKNw9bcKTRR3VUEI9zzPxtvSUrj1wLGg3up1ykWZAvyP
 JDXsyGTZIOZJ1LymVNRzqOBNSAwshruxH6nVVrjW/Vzj8koM3xre1g8ibpcDAeMNtyfT
 5ecqVR/SToMqQSqr+nPRgcXBkoY0wayf50EG1nDH6fp7kZRizrJC/Bd6YbaVts9uthd3
 DVBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756873529; x=1757478329;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dH4j7hWiGl6J+eOSDraAdf88k8xdTBcdGBajv5DBJp8=;
 b=opQVXGXIig+YReDOoBK6BvG63w5dnZR+B7U94rdp4Cpam6WjIWJyUFdZZX2+pOtKv2
 TRwe4HtU+ELJA9Knv1Dy1zLVCtfR+8L1k7mmzvUNWn5Q+VTL0yUmi5uFWDnx6z3iULcq
 gcoLmX98smuN+CxdaWdpbxTjt1FT0j6F/DauvXwvPamgTcj9XaYWXab5odvVUfC3C3dO
 9im98k/zbmsoqFpq12EgSZLx/3mAsrALGlfyAUY7fuxiG+L7T0VkHNhXdewPlK/QepCO
 zKpjv+Bp9jYfJB3pmMap64JIaSmikUbGklgznOHLbtUS7q3f/dH6+sEknv10QZ2Uw05k
 rqgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3ZyPvl8k4D/tWrOmXaPABCyr4k0fha+HgFwALVv45fG6JzCgS0gXlZnqY60EGxpWK5KQhJWuG6Trk@nongnu.org
X-Gm-Message-State: AOJu0YxlrqZs0ki+BglOogwHtw1kGn1q9jV3Jjl28bJmnKVVUpRWkqPQ
 /cmr7wRLgxsNPNVmx7FEzFngl7wwh/2zB3X+3ebio5N36V5Xb/fWtccrpucyyA==
X-Gm-Gg: ASbGncv2SQoX9XfXdzAgYGx1V3r+1i2XvFatX3zhM9QxmE+HifuEALITBM/d/pIItL/
 yp83RUpKW624oCC6KDt+ue+2aXlJF0arrnz4e/0lntYG17v/jMdQ5INaLo0QTTAYZUc5b3XPtuj
 3NZ6BSg2fZYjgKakAnSkDFLjxyHpU9TDscPSDcOLprbToe/DkTYM/jr0VWyj5Y2hTBRUunpSoe1
 MRH5IGP6mv9nVCULOO0b3PQsqvj8ROxemRvoEZNtcC50g5gWlHmKrsRfKkOR1JdcRzMbeyACIiU
 eF5vPYRat3ch0vaxGJmhazPifpCTdJM8ys2GzYOmS1zKREBhYAwsxkC15vNlV18ZEPx6qGG2tB7
 n0AVX66rlAvK1ZrdGwR1t6F+UqiGStAfTsSVyUIwlmxzasY1QQISwd01BfAFqeJ+W8UvLmetecy
 ICyqiqMqTa
X-Google-Smtp-Source: AGHT+IE5YYd7Om+3CUbaajgST0npR9GYcUyDqcBWuzJD8srUUMa/SsILPrmfAhwZhAKgVW4AYnkdUg==
X-Received: by 2002:a17:903:1211:b0:249:3781:38f0 with SMTP id
 d9443c01a7336-2494486f59fmr211830005ad.12.1756873528723; 
 Tue, 02 Sep 2025 21:25:28 -0700 (PDT)
Received: from lima-default (123.253.189.97.qld.leaptel.network.
 [123.253.189.97]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2490370298dsm149002635ad.4.2025.09.02.21.25.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 21:25:28 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-riscv@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Subject: [PATCH 0/4] linux-user/riscv: add vector state to signal
Date: Wed,  3 Sep 2025 14:25:06 +1000
Message-ID: <20250903042510.279954-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52d.google.com
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

This series adds vector state to the linux-user signal handler,
and adds a basic signal handling test case. As a sanity check, I
also verified the signal handling test works in the same way when
run under a real Linux kernel.

The signal handler test has some gross header hacks in it to make
it work for me (debian arm64->riscv64 cross compile environment),
I would not be surprised if it breaks in other environments, any
ideas or breakages let me know. May just have to define the types
by hand for now if it becomes intractable.

I couldn't find much in the way of previous discussion or work on
this, forgive me if I've missed it.

Thanks,
Nick

Nicholas Piggin (4):
  tests/tcg/riscv64: Add a user signal handling test
  linux-user/riscv: Add extended state to sigcontext
  linux-user/riscv: Add vector state to signal context
  tests/tcg/riscv64: Add vector state to signal test

 linux-user/riscv/signal.c                | 195 ++++++++-
 linux-user/riscv/vdso-asmoffset.h        |   2 +-
 tests/tcg/riscv64/Makefile.target        |   5 +
 tests/tcg/riscv64/test-signal-handling.c | 506 +++++++++++++++++++++++
 4 files changed, 696 insertions(+), 12 deletions(-)
 create mode 100644 tests/tcg/riscv64/test-signal-handling.c

-- 
2.51.0


