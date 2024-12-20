Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9741E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:19:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfge-0007Bc-2h; Fri, 20 Dec 2024 11:17:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfgP-0006aF-B3
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:17:02 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfgN-0007dR-VB
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:16:57 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-385d7b4da2bso1845852f8f.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711414; x=1735316214; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ecFdipVlI8n6aAnFnO/zttIrvre50huV9K0yy01C4GU=;
 b=oA2l+mBoNneLerXc2gq9ma2G/hoP5COXer351ZWDuId6qeZacjA3GoQ+cpgNR2d20P
 Zri29eK47UscQiA3g8KzJUR6DMsUfU0Sf8YvTrg9y1nOvlIa3wwl+2nrEJIGqZhlZyZL
 QhmBF9S/w/JaBSSHo4F3DATRWPPwPece80eKpS4N3VDfnG+ReJuzjM+JUR50pcCmf2pC
 6s2Peuyzdm+qlUoIKNV/x/Wv0/ZHqpurAeGnsIiMidhJ323nOLbxkygjx63lnuEzOhXX
 YwvshK01iI+QfBmDUunZ8fi14itUyK2xIboECV3ylk7liEc4JmUTt+SKxwfD/59qAT67
 Hb9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711414; x=1735316214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ecFdipVlI8n6aAnFnO/zttIrvre50huV9K0yy01C4GU=;
 b=WoYXe9swRQeEk29wU1JWoPMTuf0Ka1V5NWwhho2in1ntVw2OnDhlCWlzek4Nzr9l+h
 OtcqUc568nG2VlBLx2Cx7sbdoyi3CQM/jdzYG5sfeKpLRku12gf4QQTVladDL8A7UrRG
 FB5VAa8R+/MfqMhytnfGYZlRvTO2Ex0m5iw2JmAUYgZOnOl2hbt0BfKXjNF0M79ObOh8
 MEW/cjiLMiUgkPxf4F0GMSNsDtEB5J7wH0RyotEkLA9D1T6EUtCS+RRjh7LU6iaY61bW
 gpeI9pPQpWjGVqeuNW+ctjXCNotEeuEgVq+h/d6Orz/jzytE3+c+pS9aMXBdsqlXVHH6
 TByw==
X-Gm-Message-State: AOJu0YzU6Q9SN9JIpW53F+gAcvEdJgifoWD5r1zcj2XcsbIo1bEK4OLe
 fSwNd3FSwiCGK8Do8BuygsGAAcfiSwbP0eqsmCXU6lxiI0XlBHIsDOmGv21NBER4hufeyP7D3hh
 K
X-Gm-Gg: ASbGncvtSMMZckutLvlfvJTRGsPNxk22vpG7LqXUqADa4TtFcXZZQF7oYBlQ7G4qBcc
 5zhzIQ0otP+hrjSRD6Z1PSM0SFvlJvG+CnFucM1jcyJ/cy0Z3htyFpoUKayBu3T7VQHXK8KQEuk
 KM7cZCMkgkZVHaA51JB8pL42CLhtpolHTeVfaM2YBGsk8f3VP7BX34qoqgHZ5o/JkblJtv6zl+2
 W47BXfIB9kZZMGGZ3cO1PV7D+My8z+8z9Rgge8DpyBtTukaoyk4Cx7BzktLNyykrwQh0FaYGlo=
X-Google-Smtp-Source: AGHT+IHn0TRogDYlMpyiT5CTlMYuFox3aAoK5BlVwhWVJ4ukYdKRZNnSqM4gyzZoRWMUc4lkT6qVjQ==
X-Received: by 2002:a5d:5f4f:0:b0:386:375a:8322 with SMTP id
 ffacd0b85a97d-38a221ea68cmr3660809f8f.13.1734711414209; 
 Fri, 20 Dec 2024 08:16:54 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8acc02sm4336929f8f.104.2024.12.20.08.16.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:16:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 13/59] tcg/tci: Include missing 'disas/dis-asm.h' header
Date: Fri, 20 Dec 2024 17:15:04 +0100
Message-ID: <20241220161551.89317-14-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

"disas/dis-asm.h" defines bfd_vma and disassemble_info,
include it in order to avoid (when refactoring other
headers):

  tcg/tci.c:1066:20: error: unknown type name 'bfd_vma'
  int print_insn_tci(bfd_vma addr, disassemble_info *info)
                     ^
  tcg/tci.c:1066:34: error: unknown type name 'disassemble_info'
  int print_insn_tci(bfd_vma addr, disassemble_info *info)
                                   ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241218155202.71931-3-philmd@linaro.org>
---
 tcg/tci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tcg/tci.c b/tcg/tci.c
index 3afb2235285..3eb95e20b65 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -21,6 +21,7 @@
 #include "tcg/tcg.h"
 #include "tcg/helper-info.h"
 #include "tcg/tcg-ldst.h"
+#include "disas/dis-asm.h"
 #include <ffi.h>
 
 
-- 
2.47.1


