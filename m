Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C3E1C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:26:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGs3Q-0000ds-P3; Mon, 19 May 2025 00:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGro1-0006mn-Ng
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:08:50 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGro0-0004GW-3q
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:08:49 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-231fc83a33aso14466965ad.0
 for <qemu-devel@nongnu.org>; Sun, 18 May 2025 21:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747627726; x=1748232526; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z7fI81BtV/dAQsFt7V17GmQosWGaHjyzXgS42FWHJZ0=;
 b=bddNoG5Y8mBkzwgNHxvT792K0eG0fE64BLI2rYoCAZRk0pJyJFR3iAWW/IMgMB7B3G
 sUFIJRC1NKN778N/vXhqER3dV53zjYJ/x3jP/gAWCAJwjvRMCAQZfdjFwj+gBEpyvm0P
 zcyvGxXwdXwuiz9WR/KaJ/BO4syQXOf11BDx09qRFi/Tbpjw97lTIZZgr4TAo3hqbwuc
 ztm3MKa2BoIcMegXxLiF1cpSLP8v2sXxB3s72k6TabsUSYeq8kp/kN3f4UUnmVllnSYl
 p9nNsd8aq83SHIi+ClwDFjaEFxgkEnf+S/YcVuQzezOEJlDNR0YcaRmMbAI+Z865sRbD
 Uy0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627726; x=1748232526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z7fI81BtV/dAQsFt7V17GmQosWGaHjyzXgS42FWHJZ0=;
 b=FyCGeUicqhRU55FfRWGqAyv9as0mzOtkKDVVNVMaCxSoeN5QEdlTp8TxMb3lr/DM45
 ptZ3PHflliIVWQU/qDwK5PE5/dBfpTVy6NZ3P//8iaOAe5OdrVq8KL8u5YgzvFzqigij
 CJWogoWqg5GXlqwZrDzU8OiyPHn8AewkIIipWjDkfKXWFTVsqsieFaaZrLFArKr3Yx++
 hi458xAx+3VUDwcGCL7q6ZQ3sCMmuq8UbZq6KMJK3hQlS7B3GlvNgi3OFn1g60v8SSY4
 r0bRxMrz6Y+2EcAWlFHCwgcr2+12E8Tq9MZ70gFhcEsF183uXWIxp82SPyrv07X7Q7TB
 K2kw==
X-Gm-Message-State: AOJu0YwDk0gaF6ga6563lJc4uP/eAFjQwmjtRUvgMkDeaeJLiUvubOpH
 sQZQyDIlUVOB89I6+6hKuzmQAMkrjFlMzzc9FvQU9gAk+B0geMwwp9cEjrvHlQ==
X-Gm-Gg: ASbGncsYRDaQmZdNbppQJ1CQQP85KEocfzCGr5X5xDEFI7Gk+OqmnEAps8ma9T1sucZ
 vQuaxmY/AqhKIuaAp0G+q55Eak8ZWrs318ftzXUYst5SvyZfujCNMwTgv8bIpcK4YEg7AkkQh/T
 0h0uMbS/yRxE2ZziLDBgRtpo8Lm3p6CzYCkIJ+SDF6CEvkt3izAzw00XN3Z+oewOQ8n4iaX97Pb
 Rij8DFLVB+AFVfbzeTCQSBz9CPgY6dwnmLeQGH83P4fA/mR6MJOUdlojQpdhiy9TWXyAYV0wX+O
 uWnZ/rCHospFJzW6o6fBwZeIEdADrurhd1tCohZDmgj4Ubm1ETE+aE8S8YBTGYuEVfwW7FfOyyd
 D6+UJ26otI3Bwq/kAHpiw0GDqQkDOl/RpPA4FysdTNQzt/IvhSD+PCOPl
X-Google-Smtp-Source: AGHT+IGCYbKGOC95Q+rtvZTKDO4iEVllsv8WTWyAZyVEHiSjDUB4MfGrLlAx20+ylgGtdGCnV9vSnA==
X-Received: by 2002:a17:903:11c6:b0:224:e33:889b with SMTP id
 d9443c01a7336-231de35f32fmr167261495ad.12.1747627726546; 
 Sun, 18 May 2025 21:08:46 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231ecd5ea41sm41750035ad.228.2025.05.18.21.08.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:08:46 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 31/56] MAINTAINERS: Add common-user/host/riscv to RISC-V section
Date: Mon, 19 May 2025 14:05:28 +1000
Message-ID: <20250519040555.3797167-32-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519040555.3797167-1-alistair.francis@wdc.com>
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Alistair Francis <alistair23@gmail.com>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250422024752.2060289-1-alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 57dddcc80d..7060cf49b9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -328,6 +328,7 @@ F: include/hw/char/riscv_htif.h
 F: include/hw/riscv/
 F: linux-user/host/riscv32/
 F: linux-user/host/riscv64/
+F: common-user/host/riscv*
 F: tests/functional/test_riscv*
 F: tests/tcg/riscv64/
 
-- 
2.49.0


