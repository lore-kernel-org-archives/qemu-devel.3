Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E021CFF5136
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:20:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABXe-0000J4-Q9; Tue, 07 Apr 2026 14:52:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wABUK-0003zm-ET
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:49:24 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w9yDO-0007Hy-5x
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 00:39:03 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-35d971fb6f1so4018045a91.0
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 21:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775536741; x=1776141541; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oiFezQHOAaqMmcJKMFlY6nIZQsohwq1z122fNT7RHvQ=;
 b=DDGlJsY7JlvlmWSMLWt+t9Ukpho7fx4xDhJyaDaI9X/s/pyT8qpYt/42U7akQYGX/+
 TBb0+iXn38TRxOOIHZXwN37WrdlMH5DE3qvB6pEwaUNJxSq4pqbWwLwotGjai9AZG0rv
 3tcHXK16R1zaL7xfvjHzDRhVU2ArVqJoi9/5tAu7xqcBKZyKDnFoLqq/BZxyv+bOYLcd
 5RRI83zKFccGeo3vNZoBnoIy/YsjsfsrQXvJKUaHXpG1E2uMvvowBgEBc1hUFgHrcPMI
 nXJWFAbDFHsQc5/6lUNBWJnCyNOR1PKzkbsgsO0+NLOkGM7xzqEKCsvt67xM1uPxO3sN
 zrMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775536741; x=1776141541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oiFezQHOAaqMmcJKMFlY6nIZQsohwq1z122fNT7RHvQ=;
 b=bfPhdbSKS+4Ps26vdSdV4vNuIvrG5OqdHVgrELjsM1oW0GLl1terra4O3wqgSpxYvh
 62EZkfCHKj0IqFSeLIY6OeYyg70hLAPI/P7UlTV43t9/ylNpyAAxtZhyJM6Xmp+2lqFI
 O0kw1Kus5jGqqn10DlCUhUAuHFW7FnU2/PpZwTP6fJAxTcYOrNv7rJ6bo5XhvzC7qVbr
 Mj7EAGn4I/9DwixWQKOuzFQOsdpkO6rjj6D2xaFOsKYuyaXoidlgXQ2hWgXhRMA4dtSj
 xMssCXTLBG8K1wwqlWTROKFTN77WIWaiRmTDjCkBtXjdoyDp4LXZ307yOMAdg8SQd2yX
 u5iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNUhsCsi6ako7+jzTgxwO62v3NNlrcmto+BxSrAGALtmnrw0H8d7/m+GWoPAmkcYu6QHDwHqlS7vlL@nongnu.org
X-Gm-Message-State: AOJu0YzuDsO3otlfrFxB/jc8tLOIY8R3/9Fm3Ww9pOLutxOe0CXO7VqG
 BfrdtHfgDFQgMqPbw1rbUisI323APSsNL4/1DjrO7JIDfVPF2n9Hq/5x
X-Gm-Gg: AeBDieuE+wKfLwJdrAjFW8eu3q+bEZuf2HnJDChKQjixNHN44cPdPJZZCVEYJiaQNOf
 Txz0/nQf2NaW02CvRmyPkd+DeCSs0HW4s6nptRZznX5EU6pzEKPb9c4WXwycxwCpShybxQgD/eN
 qKH+cm6HLU48oUwGimIj9xXSa/nP/FYOHHWzS0m+UDnr6QlXyRM0M6N5A1YNO1DB9MPxHpgYKxm
 ZV+89ldk6cDf0heK1ZK85zFNLcBxdiFl8sDwi0B+iE7FmXehJ1KS2vC8ocVz33easaFZIJXL6G9
 rvjcnbOUzhFpsOAKGRXQpd68WW4H682mwb9X8IRH9xFIp1gY3+KQDVqf0HVFF5cRkOp3uDR2W+S
 mi2cCphifXbm0vPfmyz+tQNbtRUrAR2bQDve+joZgd8y095vZJ3LacxzWCUwAAa5TJvNVktbm+f
 Iq3sj8txS2WGvlcH+xpi64mddF9ybbcaYrYshA5v6B
X-Received: by 2002:a17:90b:350e:b0:35b:9682:51e6 with SMTP id
 98e67ed59e1d1-35de691ac13mr15140403a91.16.1775536740743; 
 Mon, 06 Apr 2026 21:39:00 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c6491fedsm15809963a12.8.2026.04.06.21.38.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 21:38:59 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 3/5] target/riscv: Don't OR mip.SEIP when mvien is one
Date: Tue,  7 Apr 2026 14:36:12 +1000
Message-ID: <20260407043614.372871-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407043614.372871-1-alistair.francis@wdc.com>
References: <20260407043614.372871-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1031.google.com
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

The RISC-V spec states that

"""
But when bit 9 of mvien is one, bit SEIP in mip is read-only and does
not include the value of bit 9 of mvip. Rather, the value of mip.SEIP
is simply the supervisor external interrupt signal from the hart’s
external interrupt controller (APLIC or IMSIC).
"""

From my understanding this means we should remove MIP_SEIP from the
alias mask.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2828
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index a75281539b..2a2f9497db 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -3796,6 +3796,14 @@ static RISCVException rmw_mvip64(CPURISCVState *env, int csrno,
         /* Remove bits that are zero in both mideleg and mvien. */
         alias_mask &= (env->mideleg | env->mvien);
         nalias_mask &= (env->mideleg | env->mvien);
+    } else {
+        if (env->mvien & MIP_SEIP) {
+            /*
+             * Bit SEIP in mip is read-only and does not
+             * include the value of bit 9 of mvip
+             */
+            alias_mask &= ~MIP_SEIP;
+        }
     }
 
     /*
-- 
2.53.0


