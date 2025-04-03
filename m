Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E371C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 08:17:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0Fl3-0002OC-UR; Thu, 03 Apr 2025 04:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prantoran@gmail.com>)
 id 1u0Fkr-0002Lw-Gd; Thu, 03 Apr 2025 04:16:58 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <prantoran@gmail.com>)
 id 1u0Fkp-0002ky-P7; Thu, 03 Apr 2025 04:16:53 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2264aefc45dso9058845ad.0; 
 Thu, 03 Apr 2025 01:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743668210; x=1744273010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=s22xc8a7/LMS7AdVZEhGMSNTlbtCtL8y6XcLvc6taQw=;
 b=TYwt1ZGIVAFKyVm0D55h2DK0Xdba4Lvo4U+7oXdSA9MY2KDY8Gmwq+YDkBLV/8PWQW
 xXM4qtNAffh3ONlXwo82iB0zxVAOtxfjpmiKnHWV6U3eJa36gxj4i4ds49wnQUaKzoNy
 01Cxj4IJinjjZbdQ90PfTAdalrMsGSgPbSqCDpmxhmTXyz9FAXz8cSEh8X42STZbAIlU
 nwROA3w52EDxclVq0hgX9ignBADxU1vVnscihuKBkZXkUiFot/+oR85zrp1+A7O6Mem4
 SSkZuha9OKfzBxHJCdJU3l8AlPjkUAaW3Lfc7+Zymoc1NV2FyWBUSN6qxHY5R7koy/Ga
 zwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743668210; x=1744273010;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s22xc8a7/LMS7AdVZEhGMSNTlbtCtL8y6XcLvc6taQw=;
 b=YTsQv5rxrvejM4awa7iRbauebPfSCRovu6WqPbejHbx1Ym0+8aKm7MQ6bk+TkW3NOt
 d0H179/hFVX1b+4xSry3+DBeCiTReu9q81BTMMdaxoRAE0rQtkzayniJIofsn4he1xBS
 lZQ/THx2JibAR0HrWocjCYKUtJTLpyDH1VMSSy61BmIdyBqankE2eIwxey0KCTYbaseo
 5PG/nJ+rkRtGR+YPlPvyDjyWFXYigYGgyoGphUFzDLRsHMahSiHSe19tNlYueuFVQzMe
 HHpUsmsaS/96o6vfpsHOqKdSVtlO/2sLhEJ0Jvybei7o6jbPF/k9ku1KKpFtR2erZvqq
 Fj1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/kjUXaeeKuPEAgM8ImeVW/kcyd3Y8ECaSuhx1G4mmSIS10BQcS7A9tM2zs16qK4DRx2QZ6v9xByrz@nongnu.org
X-Gm-Message-State: AOJu0YwDPzm7Xq4KOP+lBPn3Ej7GjWiVKnx8pcNfGChkKaTgpTtbxuEU
 xqUr599caAdpMs4LBgPjwRYx8HhVmyxWc2UQpxEz3PIggVc/g0Ai
X-Gm-Gg: ASbGnctFp3zwOOR3SaGUUoKXIqV8UdDR8aRVjulhLfgPeF403hLRqR7m0Slj9MpI/FF
 pertrO3iUY5w4SRl9Puim5jKqAgrD09VXIvMI9jO4ddi7hy9mConUN00x/qszNaxM59k8oCsi1u
 V7GXUXzKrpHCb+Of3ebjJO2wYfWuFV0TYHV23WYHXd4Jm0HNElV3x7Qc8Zr27pJmBt/o8sYr5Z8
 d9U8uRO50f57740gmOVM9AY1K5IKfKvXd0fGrt1kQTjAuy3AbdMTc7lrfJNgZfXBBQKDxTpaBAA
 wVCxshb3MipR2LSlCl5hRfbAnjcpzLo/0WYZPZL/Yg==
X-Google-Smtp-Source: AGHT+IH+yj8Dy9fuQZd1p9yiMdu51O70uAW8WE/q3EhU1x4yuMgDFzVEsThamA4w07kXY175yrJ8cQ==
X-Received: by 2002:a17:903:1a10:b0:224:1c41:a4bc with SMTP id
 d9443c01a7336-2292f96114cmr362522795ad.12.1743668209509; 
 Thu, 03 Apr 2025 01:16:49 -0700 (PDT)
Received: from queen.. ([2604:3d08:7485:e900:a9bb:524:486b:23c8])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d9e9db78sm895308b3a.97.2025.04.03.01.16.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 01:16:48 -0700 (PDT)
From: Pinku Deb Nath <prantoran@gmail.com>
To: Kevin Wolf <kwolf@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Pinku Deb Nath <prantoran@gmail.com>
Subject: [PATCH v2 0/2] [PATCH] block/file-posix.c: Use pwritev2() with
 RWF_DSYNC for FUA - update
Date: Thu,  3 Apr 2025 01:16:31 -0700
Message-ID: <20250403081633.158591-1-prantoran@gmail.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=prantoran@gmail.com; helo=mail-pl1-x62e.google.com
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

The testing with "-t writeback" works for turning on enable_write_cache.
I renamed the function to qemu_pwritev_fua() and fixed any typos.

I moved the handle_aiocb_flush() into the qemu_pwritev_fua() and
removed from the previously todo seciont. Initially I thought
of only passing aiocb, but then I was not sure whethe I could
derive buf from aiocb, so I added arguments for iovec and iovcnt
into qemu_pwritev_fua().

For handling buf in handle_aiocb_rw_linear(), I created iovec
and passed its reference. I assumed that there will be only one
buffer/iovec, so I passed 1 for iovcnt.

Signed-off-by: Pinku Deb Nath <prantoran@gmail.com>

Pinku Deb Nath (2):
  block/file-posix.c: Use pwritev2() with RWF_DSYNC for FUA
  block/file-posix.c: Use pwritev2() with RWF_DSYNC for FUA - update

 block/file-posix.c | 54 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 42 insertions(+), 12 deletions(-)

-- 
2.43.0


