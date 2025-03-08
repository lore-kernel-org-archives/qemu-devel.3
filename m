Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A75EC282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 13:50:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tquYu-0002Qw-Np; Sat, 08 Mar 2025 08:49:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tquYk-0002QX-5K
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 08:49:46 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tquYi-0007Ai-1R
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 08:49:45 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43bdc607c3fso16499885e9.3
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 05:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741441780; x=1742046580; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GKR/odgagJQuc1hFFy3FVHW1+FYszYypBPa/N5O6e5o=;
 b=SUpeYONL8+9CgD9uUvFwCtN85bzxOAYd3h10cZV9rRz3dka64XilB7eoyG5oCesZbn
 nNYcvyP0HQ3Lj+HCwh/m5ppwmy3r4kVPpjbMZBoo52dNOC/fUhX9nFS4lgpuxyzWM5Bf
 uxQhWCVp3bDwl9k2Vc8FSHkmd2vLsU8cB/3CvSH08rtkY1ntOMVjDCegPxZXe7rRKDHr
 YiSOD+nB0//CYnqZtPthFlf9zfo6p/WVeyin/Fh62qb0FwpTMTBRwx5JuU9SSJwEELCq
 qUES/y6M2WYDUdWzpbbIjemjVABC2qs5gDUJA60CMnHF8AKMtnnajpG4u1WaYvvN4lLA
 OEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741441780; x=1742046580;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GKR/odgagJQuc1hFFy3FVHW1+FYszYypBPa/N5O6e5o=;
 b=eiWkajULpOku6wcY3aPrdvt87hEV9zkXBGY9tWpctFH36gdoB2c4xHJmR7bPxa1ME2
 gr66IFwml1ZIg9URtfcoGTtejz2dLw0r5ymaiFzKFFKpmM6Rx375HQIKcnxpsiltRALg
 vjvRwyr/z1oZjeToDwXAR1QmVhe2SGIR6/+KYhT5pGXkZSY0gqOtG+30E68YFhGOfZGN
 AYiv/kjmWHyJ5jjDikxJmNwMkPeE0UUgZmP//UkW3nYBkmbupi7eCGsSVGrLViVENFo3
 6A30oH1dav4Eg3N121YOfRGJzXrXXVdY9BxCOZ+xPvW0M111TRxrksUhJqhbtk7/Lz4C
 QnFA==
X-Gm-Message-State: AOJu0YxmmIlz63Z4so4uEGiw9y64UGaki0FsEumEthHVMgGgkT1AJriI
 034smfGksiK5mLFYdoQi2wS+57vEeaAs4lE8RE6BPieXVnvUPdm1Hz5xv7elX5SLnhlh7VDdi1e
 MiKE=
X-Gm-Gg: ASbGnctGhbTRp0iw6nfEmBBZXD+YBMrKlPgaj94fLBi/JFPoiULeYo0UQ7y4pZdZcAA
 FydOKcRg9+s9qrhp82fEde5P+YhAUqXmEbNUFO7jiLJkaXdwp4OMbFtVP8X9CkFZyso8bV8YSZr
 GongEAzonk4XKYAvA213HDRE06qx31pe1p5k8pVSrjtda+XsV4L3Xm2WwKGBT7LluirzgWarUyk
 eULgzEziutqJ2PM7hliuTJ9vqcU72flMKQ437d7XJlr1oWnlXX8hWccAoqGcKBFWwRU+d026vjw
 doPHJ8EWqrh2qdSAvPG5wWWAStLDEsbvbuw4bY/wFQNPSCHviEGLtOy/bWiox5Lkcl6uYtP56h+
 G9MmsvfGKs67rGkAbyKM=
X-Google-Smtp-Source: AGHT+IE9B974xtVH3iUUTzDLE7POblCHQTgvboCEYMZTWoWsR4yRLdYUkvfKRDyBnjDQdX6RtKxc7g==
X-Received: by 2002:a05:600c:1554:b0:439:91dd:cf9c with SMTP id
 5b1f17b1804b1-43c601d9492mr53733225e9.10.1741441780466; 
 Sat, 08 Mar 2025 05:49:40 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c103f57sm8873762f8f.91.2025.03.08.05.49.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Mar 2025 05:49:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] MAINTAINERS: Consolidate core exec/vCPU handling section
Date: Sat,  8 Mar 2025 14:49:38 +0100
Message-ID: <20250308134938.77267-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Some common cpu/exec files are listed under the 'TCG CPUs'
section. Move them to the generic 'Overall Guest CPU Cores'
one where they belong.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5df6020ed54..783885a84d8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -152,10 +152,7 @@ Overall TCG CPUs
 M: Richard Henderson <richard.henderson@linaro.org>
 R: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
-F: system/cpus.c
 F: system/watchpoint.c
-F: cpu-common.c
-F: cpu-target.c
 F: page-vary-target.c
 F: page-vary-common.c
 F: accel/tcg/
@@ -165,15 +162,11 @@ F: util/cacheflush.c
 F: scripts/decodetree.py
 F: docs/devel/decodetree.rst
 F: docs/devel/tcg*
-F: include/exec/cpu*.h
-F: include/exec/exec-all.h
 F: include/exec/tb-flush.h
-F: include/exec/target_long.h
 F: include/exec/helper*.h
 F: include/exec/helper*.h.inc
 F: include/exec/helper-info.c.inc
 F: include/exec/page-protection.h
-F: include/system/cpus.h
 F: include/system/tcg.h
 F: include/accel/tcg/cpu-ops.h
 F: host/include/*/host/cpuinfo.h
@@ -497,12 +490,19 @@ Overall
 M: Richard Henderson <richard.henderson@linaro.org>
 R: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
+F: include/exec/cpu*.h
+F: include/exec/exec-all.h
+F: include/exec/target_long.h
 F: include/qemu/accel.h
 F: include/system/accel-*.h
+F: include/system/cpus.h
 F: include/accel/accel-cpu-target.h
 F: accel/accel-*.c
 F: accel/Makefile.objs
 F: accel/stubs/Makefile.objs
+F: cpu-common.c
+F: cpu-target.c
+F: system/cpus.c
 
 Apple Silicon HVF CPUs
 M: Alexander Graf <agraf@csgraf.de>
-- 
2.47.1


