Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5772DF433D0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 23:39:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD9oJ-000397-LU; Wed, 15 Apr 2026 19:38:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wD9oG-00038O-Qm
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 19:38:17 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wD9oE-0003bD-5G
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 19:38:16 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-35da2d35eccso5413520a91.0
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 16:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776296292; x=1776901092; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QcnKwBt9815Xn9LSiKD/C5NHxwDsPf8fWRupq+/ZkXM=;
 b=GEFKKlVL4Vdw5esUXcfvTbCHiZ6BbB8Gv8udoAzxJQdx/JKX0DNH0ao7bs16O/brUr
 OzXn4lgKgH/tV3/XfbcvB+5YTfNyFqMlXCZm387Z5UdLFWHsAqgGHxpE1vHOEgyfIh7M
 U7Wz5Z7EWIkAvqDTLI7fK6D47zjpJfhYYK1p0tyH0NgdoLDpRk9Z5x4xHoGhOPQybFXE
 MnODnqtXZZGKRcgxtLmzdhpcl/VSlLVVZyVlOheMfCPMqF11z8KZgUvD48iiHdaJ7MBk
 8Ad2QpGfPqTapAm3f4PUK3u2V7K4Vji2NBY0NHSpHfDgkymR5W+XXvCZVk3iskJ+c/wA
 jonA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776296292; x=1776901092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QcnKwBt9815Xn9LSiKD/C5NHxwDsPf8fWRupq+/ZkXM=;
 b=FYvpwlfWYyLEFeX7GyDUQkHUvS1itwmB8XszLZrDbuF7j9SsdOuCwyunqVB8Yzl31c
 Dz4IvEExQDaeUt4K3eq2egEKQGTwUyNapp6GHE/mhp1LR94PAj0lcMmcEmWHFE4/VRS8
 0GVMUZAdt/IS9K0kj0FNJSDozAcJC51jGGdNd9WLyy4/17dN63R0raqYLz/ZgTOZcnyP
 6cm4fHoKVL4V1K9bSMkdBYXo3Ua2alDYNk6khAiOn1uclS/KFMDWVMABmas0ez7jgoUq
 QNx/GYfQNRcYwxXUtlVw66y2B97vaiKcwGhmzc5HBH0AvB9/Y+kFeSPUme1Y6gCxtBNm
 umEA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8LtI4SnajAKsrRR/cye/qIo3aXYWcYJwSY31cYzBz6rPPws1hmik/t8RCYv4uZNdRQNnKQ+w2NQPj3@nongnu.org
X-Gm-Message-State: AOJu0YzunMXPSc9TddZ1EpuQma0Csm2KhfXbGc8joVMlMFEM7A4i1lyy
 jfRIhaTUZaDy4K+ZSSZQGwbE0DwEg1T6Cn2BP/wdvrUnN4G1SoUqlhFa
X-Gm-Gg: AeBDietrukuBXx57kFoe1630aWwZ73vQKYEUIlLZSMoFYG4UG5jf2ytHvQZiVAWYowM
 XReKktXVDxduFLIz9pTF6coD9GNQG81RgdJKttpl/gRwcyIRAe8ragTChunZCn1EdTLlWhmsVYE
 k8FksJ//pHdQ5ASJvqf/tQespp7UnHhDpBCzl774EgOFNn21SN/rCjnT/ltGVndKbsgeevKSuOC
 1gE2hLnNmADsD9XmSUP/A9SwczUCPDdnFAkBwtbWFHmohTZ/NetpZsK0fc0qbOozgUaQeGFL8rZ
 d2NuNvPWE4wYE46pnAWAiL93wAxLY6ooutoc11btUtC5Lza1qaFqmSLAvrKsiozlxe0thrl2zoU
 wLPcbO6cioZAkERnco2j21Y0EP29eQW9RDc6Lc1t0mJybDPZ1i2kbLNypcVKwY9QbQ09xE7Zj6o
 inmf15H82gn8B/JZM+M1iPklUlqiCYq49vgR19z/Fo
X-Received: by 2002:a17:903:7cc:b0:2b2:539b:d2ad with SMTP id
 d9443c01a7336-2b2d5a90e96mr170139815ad.42.1776296292485; 
 Wed, 15 Apr 2026 16:38:12 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b47826ea53sm32341675ad.52.2026.04.15.16.38.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 16:38:11 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>,
 qemu-stable@nongnu.org
Subject: [PATCH v2 2/4] linux-user/strace: Use pointer type for read and write
 values
Date: Thu, 16 Apr 2026 09:37:38 +1000
Message-ID: <20260415233740.3027321-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415233740.3027321-1-alistair.francis@wdc.com>
References: <20260415233740.3027321-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Alistair Francis <alistair.francis@wdc.com>

The stack pointer is being truncated as 32-bits for qemu-riscv64, so
let's use %p to print the syscall pointer argument.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3238
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
v2:
 - Remove the custom read/write print functions and use %p instead

 linux-user/strace.list | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/strace.list b/linux-user/strace.list
index 35f001fecd..6162a407f9 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1114,7 +1114,7 @@
 { TARGET_NR_quotactl, "quotactl" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_read
-{ TARGET_NR_read, "read" , "%s(%d,%#x,%d)", NULL, NULL },
+{ TARGET_NR_read, "read" , "%s(%d,%p,%d)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_readahead
 { TARGET_NR_readahead, "readahead" , NULL, NULL, NULL },
@@ -1674,7 +1674,7 @@
                      print_syscall_ret_waitpid },
 #endif
 #ifdef TARGET_NR_write
-{ TARGET_NR_write, "write" , "%s(%d,%#x,%d)", NULL, NULL },
+{ TARGET_NR_write, "write" , "%s(%d,%p,%d)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_writev
 { TARGET_NR_writev, "writev" , "%s(%d,%p,%#x)", NULL, NULL },
-- 
2.53.0


