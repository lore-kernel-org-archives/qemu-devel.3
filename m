Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F41F0FA0C22
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 04:08:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCrXj-0006nV-IY; Wed, 15 Apr 2026 00:07:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elirazamumtaz@gmail.com>)
 id 1wCnee-0008Ez-5R
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 19:58:52 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <elirazamumtaz@gmail.com>)
 id 1wCnec-0003Wy-LU
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 19:58:51 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488965a9ca1so7324555e9.2
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 16:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776211128; x=1776815928; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UWDbxBPK/BZFXhhwQFxLsVfyB0Qk54iF0W/vZfXiw+U=;
 b=APWli2AMy/vYJrwwKbMcQhylBlwdb81l7JwO7DNg6Am7gNZKtuyYd0bJ5d+yDmXxHf
 gkPQGHxl7gv2+LS0e4Akd4A92ohalSIVpGR7TV+U5LETRKGYMwDr/bteZXsZh/lDkYyc
 W93A0gqfBzsZG1FsEhRLCNqUsYjoJ16tRSYXhUMnyC/RR2iWYRWYg2fft8ofFnThIrqi
 gZxoMZ781xVn2KSMqxrDTPuytHJEYeQCCRdGWoZOnUThNd/L4I6iawJEIohpWR47xnCT
 4SacI1FeoGjviOchIXhaU8CQih/rnQ5ydtPJTOvNLH0a7FgoAADz3wq6rc9wxilOthZN
 AkaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776211128; x=1776815928;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UWDbxBPK/BZFXhhwQFxLsVfyB0Qk54iF0W/vZfXiw+U=;
 b=TaJTRpDQMw7E6tQ9ZNRWu/YxyXu7cDnaL/jDPUx2swuku+Er5RbQkubCwdrGkqu2OE
 rn8DIdp6bw/RhNPJ9v9KCT9xJgSj7EKcGtPzb8wH4pwASg+IRPRjYlmewNl1zb5nFFcN
 A2UsuLyn4/XKx19Ei4znR4uoqIipLROLnj76y40tmRkvJH987omw1Gru4Nu0ffguwcEY
 9xS2IuUN+lYkV3k5y1kvNJfXEQglKWQEnEpaomY00JTPM6RYYbaeniTSbbX6VgDijyzf
 33TpMnGqJvqECPRu3Rc1rZbVSUOqA0mcQk3MDx2i3zgqIGAB18S6DN7Jupgts5nYR39E
 eTYQ==
X-Gm-Message-State: AOJu0YzTQg6zaHOLCHCDxW6xVR3avYWy7cLOvk19Ai2zIAenA8odyaZb
 PQvGzLP3XrOLLWV3V7aWSv65WTWfTdpo49SBrLqlfB5nSkPWt+OVzDikMUeu3Ba9
X-Gm-Gg: AeBDietJryFKxuz+lCmh7ESS2S+MVzXUM0KyF9Q+FXJe/GhuG+sYmU/vOmSWEYElwRx
 8KhUiQ/gn02qITikga11zSAvxc8rMTE8/Cfwt8Fw8fvYelVzSnoyD9Qqv6kRas2CFCi8bJCOwrv
 RIHMqlSHallB049qxY2agbQJ7KEFuZ3FLE5WHzQlxdF39F6/zMtPdDo0+4tvS3H+XSUioxXlZRO
 brgEYcSCasCYdHxjgJrQlvhDrUad1M1ux8HWQlR2LSy6tWa/Kbj4IjOt9rBBMWA7Frn4zeX3btL
 an94Wx1ALnDhzm5Wy4+lEIXoOKSk09AoDMV3VSzQ2PXEAadCXhWCiP6C4zJSZe3TQIN8LndA8Pj
 3m5iG72LbMLg+YAFbsThOJ8OemN/tW0EPfUktlCBByXSzd/H+vGpBgG2yX7vIRFEMLa0dh/O+T7
 F/x+c1G0ICFiHFITsYkKnfnsPddaDZkaJV
X-Received: by 2002:a05:600c:1c04:b0:488:7fd3:5cd5 with SMTP id
 5b1f17b1804b1-488f212990dmr1214565e9.1.1776211127351; 
 Tue, 14 Apr 2026 16:58:47 -0700 (PDT)
Received: from [192.168.10.11] ([182.181.137.32])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead3d5f11sm115535f8f.18.2026.04.14.16.58.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 16:58:46 -0700 (PDT)
From: Ali Raza <elirazamumtaz@gmail.com>
Subject: [PATCH 0/3] linux-user: Filter /proc/*/task/ and validate tkill
 targets
Date: Wed, 15 Apr 2026 04:58:33 +0500
Message-Id: <20260415-master-v1-0-8dd2ef111eee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKnU3mkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDE0NT3dzE4pLUIl3jRIO0RKPUpDSjFFMloOKCotS0zAqwQdGxEH5xaVJ
 WanIJSLdSbS0AYRMj6GoAAAA=
X-Change-ID: 20260415-master-3a0fa2ebf2d5
To: qemu-devel@nongnu.org
Cc: Ali Raza <elirazamumtaz@gmail.com>, morgan@kernel.org
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=elirazamumtaz@gmail.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 15 Apr 2026 00:07:55 -0400
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

This series fixes a problem where QEMU user-mode exposes internal
host threads (RCU, TCG workers) to guest processes via /proc/*/task/
and allows the guest to signal them via tkill/tgkill.
 
Patch 1: Filters getdents/getdents64 on /proc/<pid>/task/
Patch 2: Validates tkill/tgkill targets against guest CPU list
Patch 3: Adds a multiarch test exercising both fixes

Signed-off-by: Ali Raza <elirazamumtaz@gmail.com>
---
Ali Raza (3):
      linux-user: Filter /proc/*/task/ to hide QEMU-internal threads
      linux-user: Validate tkill/tgkill targets are guest threads
      tests/tcg: Add test for /proc/self/task/ filtering and tkill validation

 linux-user/syscall.c                        | 114 +++++++++++++++++-
 tests/tcg/multiarch/Makefile.target         |   2 +
 tests/tcg/multiarch/linux/linux-proc-task.c | 178 ++++++++++++++++++++++++++++
 3 files changed, 292 insertions(+), 2 deletions(-)
---
base-commit: da6c4fe60fee30dd77267764d55b38af9cb89d4b
change-id: 20260415-master-3a0fa2ebf2d5

Best regards,
--  
Ali Raza <elirazamumtaz@gmail.com>


