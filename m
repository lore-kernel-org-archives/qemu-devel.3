Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB12FC02183
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 11:39:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXfFg-000575-Nm; Tue, 14 Jan 2025 06:38:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfFd-00055f-SE
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:38:29 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfFc-0005PI-C1
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:38:29 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-aaeecbb7309so1009884766b.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 03:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736854707; x=1737459507; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8J/ApKgPVXOVC7MF+COAj1wGpBADeRQ/mLFnBALjiW0=;
 b=skwqPMm2koecTia8Pn0PTTmmz+U6HycnkxEsEaAEKVyUbQh4I0Fz9BCQFFwoMZaqws
 YrlYIjrvqQrbiEzcMzt4Al+Gw+aOkDoO5CTx2j49zqumdOuEMDvnJmU8T9aWSPXUBuR9
 2PqFQG7Ks1wrU75OFksOfncVD6iM/xQifnRgwJaJN+BrD986Kh9ily1AcM+TIlY1jT5X
 3jCSMuoJuet4gpMSB+nMQwgX1i6R4Z6ZxSaPsej5pwl5ivofZqptbfPbAjLn2uWJjPkh
 ZqrrswjMhURBO+VOu6xOiJSdXtdyJPAD+IGgK7W0vmT7T6mcMtnVhSJYzfYgGTmC548U
 TuFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736854707; x=1737459507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8J/ApKgPVXOVC7MF+COAj1wGpBADeRQ/mLFnBALjiW0=;
 b=cw3y/WikX2BZbg+ShYJVjm0mooTTVckx2wFju5awp55lf8uT+dmL3VmCEOK+Vq+E/W
 2i3xamYimTqq/if1aLiNp8z2vVTTgqwD8+G/Fe/EXEcYVlWkM2PCcMbxr/M9K8brigz5
 P7riR+AvvquBK5JoSBf+VpeT0hcn+AigHaHv4P6I78fBoa+8vdURxXbxYrIwFBBPEdpq
 nNVGTACEAfzXjOWFM8ip7111QfYAPBnzudh0+xMbi463QXnpqW1RNpJb6gp1YhzDojPS
 b+GpzWqwSsACd5MvNxO+4zeG12HihbFy4TbTWyUx8wyaXdXKqBTaSG0H50+CGkF7W42k
 VIXQ==
X-Gm-Message-State: AOJu0Yw2+O0UZYQUv6eOLVPV/hDvQv/AaG++QJdqKyfDAJG4pRQlAJ6/
 enN+ItBMtOtqODN/xXOSogcbzlyCOoh8mR+W0IdLZPCspPZRXNH9IU91WsqYR1k=
X-Gm-Gg: ASbGncvaWT2S/ZcDFZeXrQvZwCZCwkzxAdhUCTk9gkYnDRFhYHeHXAKMPEL+F+QEih8
 5GC8KbyptGH3ZwsLv4oSaVbpY09rjE13wBqah1NjOU31qxo2x+pzE3iYrmfRohW8P1M1taEuBkk
 fnit4u8yaJjuXEEwNenGn7RiE0n+2qc/h/qZ2O6SSz1cpFopl93fcmphydOf5MeerbED7aC2Dot
 07SQ2smVBk7cXFVCHp2iqB50B45K6Eo0sEdnKvXt6ciVCOuj8xZDtk=
X-Google-Smtp-Source: AGHT+IFfmI2s0No3bDPqKMcwlnQ0CJSA9bK/ou8QIrCmdLdhry0hPg0BzbjdeEsv+pYtiqYnS/hnkA==
X-Received: by 2002:a17:907:9623:b0:ab3:3892:b943 with SMTP id
 a640c23a62f3a-ab33892f542mr205027366b.53.1736854706614; 
 Tue, 14 Jan 2025 03:38:26 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c906009bsm618348266b.25.2025.01.14.03.38.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 03:38:24 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3AA985F938;
 Tue, 14 Jan 2025 11:38:22 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 05/37] semihosting/arm-compat: Include missing 'cpu.h'
 header
Date: Tue, 14 Jan 2025 11:37:49 +0000
Message-Id: <20250114113821.768750-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250114113821.768750-1-alex.bennee@linaro.org>
References: <20250114113821.768750-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62e.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

ARM semihosting implementations in "common-semi-target.h"
must de-reference the target CPUArchState, which is declared
in each target "cpu.h" header. Include it in order to avoid
when refactoring:

  In file included from ../../semihosting/arm-compat-semi.c:169:
  ../target/riscv/common-semi-target.h:16:5: error: use of undeclared identifier 'RISCVCPU'
     16 |     RISCVCPU *cpu = RISCV_CPU(cs);
        |     ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250103171037.11265-4-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 semihosting/arm-compat-semi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
index d78c6428b9..86e5260e50 100644
--- a/semihosting/arm-compat-semi.c
+++ b/semihosting/arm-compat-semi.c
@@ -166,6 +166,7 @@ static LayoutInfo common_semi_find_bases(CPUState *cs)
 
 #endif
 
+#include "cpu.h"
 #include "common-semi-target.h"
 
 /*
-- 
2.39.5


