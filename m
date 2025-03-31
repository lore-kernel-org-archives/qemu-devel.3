Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1994C36010
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 15:55:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzHTF-00018r-PO; Mon, 31 Mar 2025 11:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tzHT9-00017E-3v; Mon, 31 Mar 2025 11:54:35 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tzHT7-0005H8-Ig; Mon, 31 Mar 2025 11:54:34 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22401f4d35aso89417135ad.2; 
 Mon, 31 Mar 2025 08:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743436471; x=1744041271; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Rt/ioUkkPUjQR+2iw5GC491Fl0OLU5bSGtzijbvti0o=;
 b=RI5ifyoJblU/V/HiYJS2+G/Djf8VfAA2KH4DDRksWiHtttXjgFNIWXyDxWDM+UEgNR
 lh7kZp+4KHIqiVvLBIRI8hCbdrpNZB+IEHQeZyvDF7nSP6WiJjWYKkdEkdIokXoHHd+f
 RdDGTzzOr7ayE5kgXQN//8amfOR8Jb38F14fz4InVtG8Sh1R33nujudhg4sRH8r5FRJn
 nyRUuB18hTtqRH+cMFOhzL8cQwY1GUQRDebzAcAwzxDQ4S3Hj40WWqIwtbEiVXBVm8xg
 BQvluQn7ZVPVgIUQSKiXAREf0ukOSe3Xy4JGFVIBK35/0fedux/yxEUU/ZEevaZBBelt
 gfnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743436471; x=1744041271;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rt/ioUkkPUjQR+2iw5GC491Fl0OLU5bSGtzijbvti0o=;
 b=Hkav4I2BypANffMhjPAQ3OGb3di/mBpzgmsWrb6ZaDe9+YJm6WjftsfQOHfyg1uJf2
 uIpRy+9JZkpwEB2hLI8Kt/O60Eib4aNZ6bWC306HSKz7LSAoWyrkqES1K+Gy7y0V1a3N
 VBiy5xfbhM6AHYFeIokILLa+y0LkgzKGflv8Qvm7ly4SLEn3KQZuVu2hwhWecaPJ4U+o
 A9Xz3yNJAvfvGXv/H9uztWry+6FeqEl7YhGOxG24vcUytDeIM8+ThD6L31JGjIz7MZoD
 m8GCKAlTsB15vE5/+zeeJksDDpUenQwSiqRy/Y9kKuzE/8hTaKXV6mdBtYgtpzV0TwUc
 4hJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHA7A/5ckxcy52J8taNmXwIkM206iwtodUJLzGC//VzJDdmh824jg9tppzExW5X4IOYnKVIkxAlswL@nongnu.org
X-Gm-Message-State: AOJu0Ywk99uq9t+e9QVs80k8J59TlrRQilvQIqXiqY90P3ulnjRbDQiC
 LOJT4imT1sT8zTl38PBcA0FC7eSfCHuQ+y8GJojkySTBZ7zMPf4ml2gUjQ==
X-Gm-Gg: ASbGncuivzxfv1GH6j7jGXztE732BJp9YKLK1SmYeIn7X3Rsuwwv4+sGWF3aj3mMY/I
 Jzdga+C+3bMYZAv+GSGOlOoTSrSGHeKroo2FkPNmRNXi9/ToAMytJc0EDHCScEIjPiHoyXuJ8o6
 HJCHHsSQVfyFbz188qbDr8UWDRJ9V9twLfl7vXCDk/8kuJx/urO2mqg+LIpY/ddZb9uZto/+q6t
 8O6jvQBbve5ArBqbPDLS8uOoQws05oWv9O6mqbE1r02+bK2z19c1tdn4kmRHd4lyY+Rk4Auo03I
 kawjMCICobMIvJF1YJZb4Cs215TWvnoLaq9pHTCDk3pMppbxFQ==
X-Google-Smtp-Source: AGHT+IGCWy+3C6Siy0JfFAAGSuDhu7jleG5WfW84KfYSO9AM1rjWUMuT0JuLHLlpRLysvrtYZsB89w==
X-Received: by 2002:a17:902:d4d1:b0:224:1220:7f40 with SMTP id
 d9443c01a7336-2292f944d4emr154271935ad.3.1743436470781; 
 Mon, 31 Mar 2025 08:54:30 -0700 (PDT)
Received: from wheely.local0.net ([203.185.207.94])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291eec6fbdsm70742045ad.16.2025.03.31.08.54.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 08:54:30 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC PATCH 0/3] translation performance improvements
Date: Tue,  1 Apr 2025 01:54:20 +1000
Message-ID: <20250331155423.619451-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x635.google.com
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

I've been struggling with these couple of performance issues with
TB coherency. I almost thought deferring flush to icbi would be
workable, buta note in the docs says that exceptions require TB
to be coherent... I don't know what requires that, maybe it could
be worked around?

Another thing is PowerVM runtime firmware runs with MMU disabled
for ifetch. This means a fixed linear map with no memory protection.
Is it possible we can enable goto tb across TARGET_PAGE_SIZE for
ifetches in this mode?

Thanks,
Nick

Nicholas Piggin (3):
  accel/tcg: Option to permit incoherent translation block cache vs
    stores
  target/ppc: define TARGET_HAS_LAZY_ICACHE
  target/ppc: Allow goto-tb on fixed real mode translations

 accel/tcg/tb-internal.h  | 10 ++++++
 include/exec/tb-flush.h  |  3 ++
 target/ppc/cpu.h         | 16 +++++++++
 accel/tcg/cputlb.c       | 15 +++++++--
 accel/tcg/tb-maint.c     | 73 ++++++++++++++++++++++++++++++++++++++++
 target/ppc/mem_helper.c  |  2 ++
 target/ppc/translate.c   | 21 ++++++++++++
 system/memory_ldst.c.inc |  2 +-
 8 files changed, 138 insertions(+), 4 deletions(-)

-- 
2.47.1


