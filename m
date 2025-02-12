Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B20FC02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 22:03:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiKo6-0006pO-Gp; Wed, 12 Feb 2025 17:02:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiKo1-0006n2-Fz
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 17:02:05 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiKnz-0004Sw-JT
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 17:02:05 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2fa8ada664fso410756a91.3
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 14:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739397722; x=1740002522; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7iYLnqu4pD+pMC95boMC9yu/CGb6NnBO0j8tMSFSt/A=;
 b=VyYsxyURNr296dWc2Htwfk0cQQwGkuUQ/WpAS3HCMunuLq130YnvXRskWtaTjSWrJH
 9v7z0HTMyVdJwLLCQmK+TUnZuc2eGB9SpctnLcML/GjgGJ1Hwn1oL61vTWO3nZvYkPeW
 j7qlMGJR4UoPiHtK4WnBe99n9q/5DUDjXAr2mif8DJmWYh1lvmmnq0vDwkX/+Wcj159s
 vYnJyZjdfAV9EtPosYQi0WGs0979EFQFxPaEvSmhPschFZjze4WqzMgv3OiOqpdZAlkE
 Z9w8eeenN/jddb/ressdO6s324LDeB06MpbGCZlS91bEWkCbm4jXKZJXS9Egq52xg8sm
 fjGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739397722; x=1740002522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7iYLnqu4pD+pMC95boMC9yu/CGb6NnBO0j8tMSFSt/A=;
 b=vUkCVhBkoKbbpMPZ0+iAqqumchBqbWvvPIff10LGQqW6ECGQQ0PDl0J6V+Flre84cQ
 vJijlKT7XweF0UPSoOwWwrc5n/K4GNV65Gxi964AwZrkKEi6tm+ODkJxbPbqGrwvhcPL
 GWsiWsMIy563sW0Ha2HYPKUNzKxAwruVHewytGhh+9PMJN/1iXYOIVG2VonCAxihJaAt
 9yiXUOeLhvdbG+WGpc4U009Vtwu7gI9m/bDhW1s3YDkfFbXE8HzjXdhz1qF3DbJll1PL
 qG5samZHaQOnvB7e53LUF58whljSscQ59y1PhPsuW1dRAUyh14SqhPnhsWUz5t/jxs0x
 eZEA==
X-Gm-Message-State: AOJu0Yy4hd4ENa+ArlDSLyr8Mupe7lLO32NNf1SF/W38JPJ+wmD3wbLs
 Ktvnt2mm1r0tDR57TwgrFG4z0umun7P8ga7WtvkVZQZJU6J/dNVACmo1rPMWteMsoHksOyrHlFJ
 m
X-Gm-Gg: ASbGncsc6yUHpywg9yz/ZugGv6diIdQtBscLFa1LY9pl5YYeil03nJQVfTl5u5qGIAw
 +JS6gufmzeh5cHm9uSY2s5qCZrxR0Dciqcu1kxL1thGFRJULc999fZ0znk52glq9h/OXoM7ZvZM
 GRhBCGy4y21kx/TPn1UcSkrDzWZxo5L/E0tIzFmb8vnDWUtG6RcIRmOA/ezbZyUMNmkgrQ9Os9u
 jzjyj4gnyyXOxajmeAclz2kZJ+Qx9l89Sh8Fkt/KrD/fLaVn4zUxEkibx6Zga7OPcsCVf+BF3wn
 Bopx0qo9jQCIhTxfdDy3lV2hiqH5vLDp6GvLHBybKy0m5iE=
X-Google-Smtp-Source: AGHT+IHFunovOgBZVZYGOmSQkHtca4ZBxnGP+Xye8GNOjcQpdG4GG+hJfo2y0zlRwYT1cD88YofSVw==
X-Received: by 2002:a17:90a:d00e:b0:2ee:7c65:ae8e with SMTP id
 98e67ed59e1d1-2fbf5bf4948mr7213685a91.11.1739397722159; 
 Wed, 12 Feb 2025 14:02:02 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fbf98b4c52sm1964837a91.4.2025.02.12.14.02.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2025 14:02:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com,
	philmd@linaro.org
Subject: [PATCH 7/9] target/microblaze: Use TARGET_LONG_BITS == 32 for system
 mode
Date: Wed, 12 Feb 2025 14:01:53 -0800
Message-ID: <20250212220155.1147144-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250212220155.1147144-1-richard.henderson@linaro.org>
References: <20250212220155.1147144-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

Now that the extended address instructions are handled separately
from virtual addresses, we can narrow the emulation to 32-bit.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 configs/targets/microblaze-softmmu.mak   | 4 +---
 configs/targets/microblazeel-softmmu.mak | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/configs/targets/microblaze-softmmu.mak b/configs/targets/microblaze-softmmu.mak
index 99a33ed44a..47e076af91 100644
--- a/configs/targets/microblaze-softmmu.mak
+++ b/configs/targets/microblaze-softmmu.mak
@@ -4,6 +4,4 @@ TARGET_SUPPORTS_MTTCG=y
 # needed by boot.c
 TARGET_NEED_FDT=y
 TARGET_XML_FILES=gdb-xml/microblaze-core.xml gdb-xml/microblaze-stack-protect.xml
-# System mode can address up to 64 bits via lea/sea instructions.
-# TODO: These bypass the mmu, so we could emulate these differently.
-TARGET_LONG_BITS=64
+TARGET_LONG_BITS=32
diff --git a/configs/targets/microblazeel-softmmu.mak b/configs/targets/microblazeel-softmmu.mak
index 52cdeae1a2..1b0e86c4be 100644
--- a/configs/targets/microblazeel-softmmu.mak
+++ b/configs/targets/microblazeel-softmmu.mak
@@ -3,6 +3,4 @@ TARGET_SUPPORTS_MTTCG=y
 # needed by boot.c
 TARGET_NEED_FDT=y
 TARGET_XML_FILES=gdb-xml/microblaze-core.xml gdb-xml/microblaze-stack-protect.xml
-# System mode can address up to 64 bits via lea/sea instructions.
-# TODO: These bypass the mmu, so we could emulate these differently.
-TARGET_LONG_BITS=64
+TARGET_LONG_BITS=32
-- 
2.43.0


