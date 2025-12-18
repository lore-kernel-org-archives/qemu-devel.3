Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58841D68BF7
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 08:55:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vW9nA-0003nl-1a; Thu, 18 Dec 2025 03:55:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phind.uet@gmail.com>)
 id 1vW9n6-0003iN-4K
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 03:55:20 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phind.uet@gmail.com>)
 id 1vW9n4-0004lH-I7
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 03:55:19 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7f121c00dedso556999b3a.0
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 00:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766048117; x=1766652917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fZj/ZyQxPKCEJ24LeSYxpiFOwipr9VF/m2tJIv9U54g=;
 b=Q0inPASpvG8WtufdYcIaypbm92CV3yrAvuM8JZ+SBaODCJxYyDn6UsWhEBFEbvqH04
 IYpaRnqYvbrrQATeIoO8FZuBEKSPIqWmUiP/B5fWJJAc62W/Lb/nS1jA+P1n4VBv07z3
 9FdNmRYThAboEwe5CjFWaaBog4WweRDfbGuwCci88cE7e6H7fcoG49MlgB3GvDnNgMiJ
 VARKccJGLLWQE9HQnTcyXE39Ot4zCeEOMVj4GYUANIHkzOLp3X7EtDbI3wnmR69uFK0O
 67uZ71LZtWihjaFVfcPlfwbm/idioAI6GEdpLtZVcXTBX2Q9Pbvkxzw01kzukv8fJamj
 0JRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766048117; x=1766652917;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fZj/ZyQxPKCEJ24LeSYxpiFOwipr9VF/m2tJIv9U54g=;
 b=sJ2fakp63Zh+OA67CzsP7HlXzPXZGpEvx8397hrjmDG1S9kTuXTuBG0BJxoD8MajdT
 Z4QV41TcNbHxCfK3R+J4t/22mVBTQ3M8AsqrCStiP54YLpwLAoikFIP0NvlVwSFjflfW
 sHDb+ITPYy/K6EFdPjuXTqsmwIpmCEoYnv1fAI1UWExzXlO2oBYfcDf+BdVKlNG9+i5C
 Z7ZUbq5gweErZyiJBHAKOhntxN0yw+u5koqmy08w0uPVTusZHLzlYUmCoYqk2n1kDMZG
 +3S7RYXc6MpC5rocAmI81UiF6SOPvsras4VQ5JSZvpIAbkwKYklNJ3ISQ9yT35nJytmC
 M8sQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUw94lI20nlokeGOwkqREo96FCbdMiYpLdQR4MhIdl6bAskkA4dQarVy2NSPMtFRNEXHkMd9zFt+wcg@nongnu.org
X-Gm-Message-State: AOJu0YyIAy0cse0zjMKHfa7vcz+Kof409ydHHtxUGRz74RmvcyRaZjPp
 QZXLDG4k0GQp93uLgsS9iNYSQhz8AGZnuJCmNfqoEgi6bySK6SQUgo69
X-Gm-Gg: AY/fxX6dp+uCXlOZW8vsbeRnlcS4NafV+cAMnCC4QYCthcN16tJNyRE0r3QiqkFwijB
 PuZKxGHSxguxsuveRgQ1cPwdrljRZ9dlCsUgcBRbrbWY1OJL5qO6UATDIDhfVj32WsALXgLX/RJ
 qV0Ad0XqKBYnnLztRy6qXyM9S+XeiBEoumeeeYfUfeea242YZbZCUZMN6o0CCNpSc8ajuyr4Q45
 VMdODg0UdinUjRWpFNFiQwCji/tYgwDavJxQHCIZYfR2xc0CUcgVNrke5XGf5CE4MUG+6VLC9Gf
 FpjUT+1hZadPrgigwVMNlQArSlU6SNbHLVkWFe3WitmsmyFRoQNYmmto9Bh94d6tpPdcPrOFc9U
 7jWcp6p2OXjVkfWp/Vv3Qdtf5j09SbBDcu1uKATrtWnpD9nC4ttl/bbTjga6CTXAKrOG7xM8RAs
 o3T0Y/JLIDYezxSckXn2p16Es=
X-Google-Smtp-Source: AGHT+IH/Bq+fA84+PgUYgmfgeJSsPD47Bcl4kzcaY2jXfCwJFq5jKxyiUOyeouJnMK8PLBmSHYrYmw==
X-Received: by 2002:a05:6a00:3407:b0:7e8:450c:618b with SMTP id
 d2e1a72fcca58-7f6691b2a96mr17963040b3a.34.1766048116887; 
 Thu, 18 Dec 2025 00:55:16 -0800 (PST)
Received: from localhost.localdomain ([116.86.160.247])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-7fe12128ea4sm1926218b3a.27.2025.12.18.00.55.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 00:55:16 -0800 (PST)
From: phind.uet@gmail.com
To: Paolo Bonzini <pbonzini@redhat.com>, marcandre.lureau@redhat.com,
 berrange@redhat.com, philmd@linaro.org,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Weil <sw@weilnetz.de>
Cc: Nguyen Dinh Phi <phind.uet@gmail.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] Fix Windows build issues with newer MinGW
Date: Thu, 18 Dec 2025 16:54:44 +0800
Message-ID: <20251218085446.462827-1-phind.uet@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=phind.uet@gmail.com; helo=mail-pf1-x432.google.com
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

From: Nguyen Dinh Phi <phind.uet@gmail.com>

This series fixes build issues when compiling QEMU on Windows with
newer MinGW-w64 toolchains.

Patch 1 addresses a redefinition error for ConvertStringToBSTR(),
which is now provided by newer MinGW versions in <comutil.h>.

Patch 2 relocates qemu_ftruncate64() to a more appropriate location.

Nguyen Dinh Phi (2):
  qga/vss-win32: Fix ConvertStringToBSTR redefinition with newer MinGW
  util: Move qemu_ftruncate64 from block/file-win32.c to oslib-win32.c

 block/file-win32.c        | 32 --------------------------------
 meson.build               | 12 ++++++++++++
 qga/vss-win32/install.cpp |  2 ++
 util/oslib-win32.c        | 34 ++++++++++++++++++++++++++++++++++
 4 files changed, 48 insertions(+), 32 deletions(-)
---
V2: 
- Use links() instead of compiles() to dectect the definition of 
  ConvertStringToBSTR() in meson.build
-- 
2.43.0


