Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBDA8C83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 18:39:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc71Y-0006df-4B; Wed, 16 Jul 2025 14:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1uc71V-0006bx-Ri; Wed, 16 Jul 2025 14:38:33 -0400
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1uc71T-0003ar-Ro; Wed, 16 Jul 2025 14:38:33 -0400
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7e278d8345aso14142185a.0; 
 Wed, 16 Jul 2025 11:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752691109; x=1753295909; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iK3wEUdszccuj+IbFKOtkO6YGhoqkA3SO5bXtirFCok=;
 b=dmrerxqii/iGTQ9uve4OQDMnEbIFzVcQLWc7MRgIuFz9jz9lSg7Jm3Pta6Bnh0S5mK
 +DCRwGuklltK3pPEaQsTwVLak5OigcOUkA2vg6D4VQYSvwD9Z9xYfyPnO6CB2ksQ9W+D
 tUT1iKVpMpqiHxSVqS2IaVGmBn4gIASD1w/IeKORWZp/PhwGoYF2ZNi+hSg12yL0eHLI
 NYAwuQEhIFtEfGo6PkRI+LBu6ilMpMeG7kyHQZnBoo2YOycflcc2vGWQwHJqgxyAWOEh
 U33h5tnfofSnoupPSskxW6zLuxqhqFcSSBzTMRahJY40HMPu8PHCRTDT6+DWG50BVgqO
 r/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752691109; x=1753295909;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iK3wEUdszccuj+IbFKOtkO6YGhoqkA3SO5bXtirFCok=;
 b=Qp7fk0sm4h1VPM6IOj3Iv6K/KB8wl+eUFGPDjHA5LoCAtt6kPFxGCVmtvKcZyYv6Au
 JIgJxYnkqR0ElhSrLtuy1lcw/5GAZiXXO5sU1KAGxANXV/r8YNylhUlYXB/NiVUMg262
 KIixFX/N/5v4lyBouywDy7cS/FXMUg+r7nsFmEb275UK1vshDSt6P5v7hIwu7n/sHbgf
 DQiBqUanYGzXJB+Fht/0PnebF4yrCYEJ6vyg8Hr5aH9xmMA4t8nGikhZDkSlA6lkE2f8
 vScnAWUACNM08BaR8LTYuN9fzMcnvHd//ouFmaPSkmCMbAQTFLHkhGCrPjVJXYifL8P7
 LjGQ==
X-Gm-Message-State: AOJu0YxUzKrWoxw0vKmp5nNBRiLF/gkNC1bRY02JKEfcSlB2uiV+819s
 kE0rJfR5F4BMFBPk3IB8hGVgxCYXPUkd37rDGdN7H3gEeKMCrSJHgW2kJN0rag==
X-Gm-Gg: ASbGncvok9Y8EmtD6ksE4L6hd4XLhwe9lJYc5BvFL11c0y2+nk5VfYWgC4ilkSiMw4Y
 VSkCsnT3OOFPhG0iOCXrmOqWwOKQz0+QkV1/GGBlDOc/OpRYZgeiSE5+je94iIY8rp/7a5SahrQ
 zRL6XvDbQN1Gq6qqv0kvaa4mi1DZJug+6mjI/xnTigtVwgRqE9M2kisjjUNA7AwnQdMGgWr13l7
 mRSUMEusCbxZi2Q1oAOjI2VgpjLz1onnnRLLhyj9fMRtkipwb7IgA9mZZhpbQeVMj7P/53pXC1s
 oIdQPV7KokafvRo92m/6Qfv3G6jyqBaCzp5MxSAuPb5NvMptkxn4qUkjHF6axfz5wiUWZ5miu+/
 Xp3kajlw0/oRWMQHKhsRyVteC4mrgYN0+7pROngBtdvStyUlN3E7U70WoJZxAaaww5TXmB3ITbO
 vda12nXtc=
X-Google-Smtp-Source: AGHT+IG1cvLeqrYq4HI34ug1P29dkq2TEE+48pU3flKArmHg5r+G6x0riCOHSQWLPYjtXqQJKcgXTQ==
X-Received: by 2002:a05:620a:a50c:b0:7e3:4417:2b14 with SMTP id
 af79cd13be357-7e344173397mr596297085a.61.1752691109240; 
 Wed, 16 Jul 2025 11:38:29 -0700 (PDT)
Received: from zzzhi.home
 (bras-base-ktnron0923w-grc-12-70-50-118-45.dsl.bell.ca. [70.50.118.45])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e168b4e352sm494464285a.82.2025.07.16.11.38.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 11:38:28 -0700 (PDT)
From: Brian Song <hibriansong@gmail.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, bschubert@ddn.com,
 fam@euphon.net, hibriansong@gmail.com, hreitz@redhat.com, kwolf@redhat.com,
 stefanha@redhat.com
Subject: [PATCH RFC 0/1] block/export: FUSE-over-io_uring Support for QEMU
 FUSE Exports
Date: Wed, 16 Jul 2025 14:38:23 -0400
Message-ID: <20250716183824.216257-1-hibriansong@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::733;
 envelope-from=hibriansong@gmail.com; helo=mail-qk1-x733.google.com
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

This RFC patch represents an initial implementation of the FUSE-over- 
io_uring Exports idea proposed for Google Summer of Code (2025) under 
the QEMU community:
https://wiki.qemu.org/Google_Summer_of_Code_2025#FUSE-over-io_uring_exports

The implementation approach is primarily borrowed from how libfuse 
interacts with the kernel.

FUSE-over-io_uring (https://docs.kernel.org/next/filesystems/fuse-io- 
uring.html) has been officially merged into the Linux kernel. The idea 
is to replace the traditional /dev/fuse based communication with a more 
efficient io_uring-based approach. In this model, userspace registers 
io_uring SQEs via the FUSE_IO_URING_CMD_REGISTER opcode, and then waits 
for the kernel to forward FUSE requests as CQEs. These are processed by 
the FUSE exports implementation in userspace and then committed back to 
the kernel using FUSE_IO_URING_CMD_COMMIT_AND_FETCH.

To enable this feature in qemu-export-daemon, simply add the uring=on 
option to the export configuration.

As this patch is still in the RFC stage, it currently supports **only 
single thread**. Due to protocol requirements in FUSE-over-io_uring,
the number of FUSE threads must match the number of CPUs. Therefore,
this initial version only works on single-core VMs (i.e., QEMU started
with -smp 1) or single core machine.

Brian Song (1):
  block/export: FUSE-over-io_uring Support for QEMU FUSE Exports

 block/export/fuse.c                  | 423 +++++++++++++++++++++++++--
 docs/tools/qemu-storage-daemon.rst   |  10 +-
 qapi/block-export.json               |   6 +-
 storage-daemon/qemu-storage-daemon.c |   1 +
 util/fdmon-io_uring.c                |   5 +-
 5 files changed, 420 insertions(+), 25 deletions(-)

-- 
2.50.1


