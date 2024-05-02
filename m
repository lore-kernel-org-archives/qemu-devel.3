Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF5D1C04FFE
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 16:56:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Ziq-0000xe-GE; Thu, 02 May 2024 12:55:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2Zia-0000tH-Ag
 for qemu-devel@nongnu.org; Thu, 02 May 2024 12:55:37 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2ZiV-0005uc-AU
 for qemu-devel@nongnu.org; Thu, 02 May 2024 12:55:33 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6f44390e328so498928b3a.2
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 09:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714668929; x=1715273729; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jboQhdCbtWFTds253ujt0GVfvWL308kDLSJJ/VKt72k=;
 b=e9qqFwonp0+emfvk3pewX9nB2m3cufZ6lkrUniMt00krVPuQBVLKLXHN3kTcK3y6Dc
 BkAK3Kqv9D7+rGjdmOrCS9w0hBjXawTmGLZrI5RCXTcICISiPiZXBVx5ndf9Si8f0qZY
 3QR5dAyD9vyPqgiK95ZY8b9gwNyqP4GkrsEbsHq2AzPydxF1Tr6xVd66LqjETnXoh+el
 OOBXs/5CpXt/3GJ/caxK5MKdc3Q+/jyvCYwQVXrGLO4EBRRIOHAhNzOmLKuXzraMkoZA
 g9DD2GQtbY76lfH8+0Usx+w/HoVrKbuU/UwlC7Z/14WHk836ivbDL9c7uGsLwa4brgvW
 m9nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714668929; x=1715273729;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jboQhdCbtWFTds253ujt0GVfvWL308kDLSJJ/VKt72k=;
 b=mqRd8eM2eITu7gZZql/hPmahAxaBhzqTXpb5se2EZ86gGWRFcR9a19UPZrsmVwclw0
 AYeLc2ShORzl4hJH58qUl7aA2pZ5rh3ds4nU+6yyD7NyCUpSGHb+Jza8CYECex+zX9hA
 RrbEo2sdXIX5KFREae/CyQVx9Ncc1qeYEwjSIe81YBiEC3kB3oVXMlDm3zltBR0pC6TT
 1+C4VtaRypliUisDSlpUHkjuwKGh1ikrSI1JjvC9BXV6BLjI9M33MKi2mc/L87uangkQ
 /vohWLnAAJ5yCrnsNjokjj4Li+nD4aQjG/+j9YOnP9Ak0VY2VjfFxbKCUL1DVxY9rOnR
 NXxg==
X-Gm-Message-State: AOJu0YwvPqDiO5LbH05YNxOkgNblVw2BCAzrhEW99gCMW8MW+5EC49JK
 7m/w85PQZ1no22aVeMW9DyceR3Tpize3HDxt/C9tgsBr+SupjiB3PovD8j3+Erw8PzUapXAqQnW
 e
X-Google-Smtp-Source: AGHT+IEA5GtiSISWuusDmsEVaVzLY1f8O4ryy2k7BJCTLrgag0AClE4R2NNpPOQoBbdpJkbqTm3QVQ==
X-Received: by 2002:a05:6a20:a105:b0:1ad:1168:a417 with SMTP id
 q5-20020a056a20a10500b001ad1168a417mr350679pzk.28.1714668929636; 
 Thu, 02 May 2024 09:55:29 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 j13-20020aa783cd000000b006eb058b2703sm1464598pfn.187.2024.05.02.09.55.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 09:55:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 0/7] target/sparc: vis fixes
Date: Thu,  2 May 2024 09:55:21 -0700
Message-Id: <20240502165528.244004-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

Split out from my vis4 patch set, with just the bug fixes.
I've fixed the issue in patch 6, as noticed by Mark, but
include the follow-up that cleans up all of the macros by
removing them.


r~


Richard Henderson (7):
  linux-user/sparc: Add more hwcap bits for sparc64
  target/sparc: Fix FEXPAND
  target/sparc: Fix FMUL8x16
  target/sparc: Fix FMUL8x16A{U,L}
  target/sparc: Fix FMULD8*X16
  target/sparc: Fix FPMERGE
  target/sparc: Split out do_ms16b

 target/sparc/helper.h     |  11 +--
 target/sparc/insns.decode |   2 +-
 linux-user/elfload.c      |  48 +++++++---
 target/sparc/translate.c  | 129 ++++++++++++++++++++++---
 target/sparc/vis_helper.c | 195 ++++++++++----------------------------
 5 files changed, 207 insertions(+), 178 deletions(-)

-- 
2.34.1


