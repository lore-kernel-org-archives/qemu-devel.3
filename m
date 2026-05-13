Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E590ACD37B6
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 07:09:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN3i9-00079t-B9; Wed, 13 May 2026 03:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wN3i7-00079c-Fe
 for qemu-devel@nongnu.org; Wed, 13 May 2026 03:08:51 -0400
Received: from mail-dy1-x1342.google.com ([2607:f8b0:4864:20::1342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wN3i5-0001jf-SR
 for qemu-devel@nongnu.org; Wed, 13 May 2026 03:08:51 -0400
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-2f3c623322bso10757522eec.0
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 00:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778656128; x=1779260928; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=W7RmiyqkufH8faptTWJNNDfEchSyFv6XKkn60TvC9DM=;
 b=R55a4x/lIK8EkSUfBh3m4v4FVdUfj5j0/qJQRF72DAEiKgpBn7qBPg9zRiBqM4hf8H
 LzqJV1IvKBM7bMeSIGffCUoxMrirAh1mcVz8B1coHKba1kO8CrLZD9ytJM7Kb/fr2uzs
 DWT286gZT49iUQeG0nwiE0VPhm2MShw3r4Kl6ITkTpiH5q/9omzT/YKFXSPX6RgnAV1V
 UlgnnU+yiQsPwEL5iQToGW1j8EJjMDG7xt6mKtw/BfsFHts2Qk4TBT4WaFk/LLRVLr++
 /YqxhtPRfhPQ+v+eiXlnAQHy2JXyeGdsVi8j1ivK5B61/oHdKatMW6Rrpgq5MwKTDG+N
 BsOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778656128; x=1779260928;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W7RmiyqkufH8faptTWJNNDfEchSyFv6XKkn60TvC9DM=;
 b=F20o/nUYzekJwVWXLAxPWAdGGKsZkTlWdwUbzW5oGFCPM3XG+233g+eaqC2Weou0Bc
 88W6etXp9J4FwsmnI4gqUSLrzWY+ZH5b90WYmmXVt0VnIvLGd3CDJksO4NwMSFC03qWZ
 tfq/QyRXYbWDHJ2Ep2Wn1pe1BMFj2cX1e3DjIcseNzUuxZsu4DIByp98mukJshhbavUl
 BoMDSveAukmUuqE6wURJfc+yTdgDdxFP8LL7iD6Dkn8guDFYQCyM4/sBKTJcFtUsbYFK
 ErD2YhueluJybzu3nY9nwbaYsata/3PMY8Ebarx4QeYh0/BTOYv3pVlG32UE37IVPeMm
 etzA==
X-Gm-Message-State: AOJu0YxMR16tpmqe0UKr+vnj7yrxx2VeQxmIZLJHcJnIcniQShPgw734
 zzQBPG25ut+iQYGC9tq9Z4xAE5Int1idNH6CGUqHlyyGXU2O9GkCNEUN
X-Gm-Gg: Acq92OEYSA7WmG/g0Kc8F3hifqYk54LQOVS6/8YfXOk/t2gpfhWisurnLnOowiNmruA
 HmrSY5VGWBtyLaLj54CK0PPI4ThdfcekuOUqiRSiggQWcrtD/vPI3phQzFjuSU2upddJ+OU4vtM
 4W2wsBcaB+aSWm1pd7U+Lz71Gb/usmAPb8dJln6jDQCWunBsQ5UICd+zta1NLm3HRcvfFuZzqH1
 ylAeWdbs5G+4hGUXHqI0Ko2AHQYX1paLcr4eXiwLa/HpsnX8ppzhpvADnZOAuvYfrfybsHPBwxl
 vcDJRflUZvI9ZddNSL6vXt81Gis+VSJBe/38JeHGOdn7o6jIuSclg31khnkuA7Y0CKJe2axgr5R
 S+CyV5pEqCi3QTgMoBzm2BA3h/eO1oP6rOGJnzXyb+SxWMWwX2v2ZiY2EChJso1k8XUz4mNcJce
 rz2xhyFimYDQpzxcFnzB4G/fDmIMyftuXP5jzS7CIrU3TY1IJ0+IPWifoYAdwvFEh7O/lYG2nmS
 eaUyI03EVWxKScWD+HD4flJL8DVUjj9AnKiHnk=
X-Received: by 2002:a05:693c:2b0f:b0:2ea:5057:a304 with SMTP id
 5a478bee46e88-30153adf667mr848827eec.2.1778656128020; 
 Wed, 13 May 2026 00:08:48 -0700 (PDT)
Received: from ZEVORN-PC.tail6b0429.ts.net ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f88885b820sm20744532eec.20.2026.05.13.00.08.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 00:08:47 -0700 (PDT)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: armbru@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,
	Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [PATCH] MAINTAINERS: Add myself as a reviewer for Checkpatch
Date: Wed, 13 May 2026 15:08:30 +0800
Message-ID: <20260513070830.851842-1-chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1342;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1342.google.com
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

Add myself as a reviewer for the Checkpatch module, so I can help
review related patches and continue maintaining it.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 93a1e4e482..4914fa02a3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3739,6 +3739,7 @@ F: hw/pci/pcie_doe.c
 F: docs/specs/spdm.rst
 
 Checkpatch
+R: Chao Liu <chao.liu.zevorn@gmail.com>
 S: Odd Fixes
 F: scripts/checkpatch.pl
 

