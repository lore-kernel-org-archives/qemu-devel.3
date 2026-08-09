Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03127C5B561
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 22:46:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtC86-00017C-Cu; Sun, 09 Aug 2026 18:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtC84-00015J-Af
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:36:28 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtC82-0007TM-T1
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:36:28 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2cc7ef7ec27so14609205ad.1
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 15:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786314985; x=1786919785; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EJLPAArjo+b4mZX0YUBGxbAKFsWVbs3HKJdLpQDgENw=;
 b=A8OnpKz8GCw+GxVBF1KFFAn7DkIrpqgCU9Hwk1r994LPvgFe2yge8jgS48Y/vVnNqj
 Hb69yRMeucfO+lATjrGYHLoRXHdfzV2mflbMyn3xEVD862KLyWxVOKfZ8Bwksuywu45l
 vNJqJrbeuhNcsRMM+UkmXmfgdLs/UPG1DhK+IgPMEyOJWlVvW9eMJxPtbStUo+qY1W1I
 dwepP/4rwiDS114l0GDYXHIKAop4Pk90otHRYus6snQPXEYvz1Mr7EWz753KsU9BSSXA
 YkkTn7rrzOZaKvjw7ZQjqbQ7+sbz/X0mO3K0rRwD/3CdDU5jxoalLYut1zfavPR/BKEy
 ZozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786314985; x=1786919785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EJLPAArjo+b4mZX0YUBGxbAKFsWVbs3HKJdLpQDgENw=;
 b=rQAwI0EGAb3Yc++jSwGyzcvsw7AtjTd0VCThoXPunezZkNlMNZCcZt1I1vxzI9aJdg
 T4w79AM9r2lN9rO4Am8gxw9G7IJW2bPYFL4dfbd9f6+VrsrQ0bt6yeVuNwcaJ8M8xKNi
 UXMmkwB6mpVw3w/PhpK2Cmr+mbRkbZGyz7E8WelOJgcr8FEmAJqhiF0tT9aFO7Ft2+t3
 oiB71wHwxaSA8HWMjO4Lern1rwTMPF3mENEaWWK1mZcr+nUxaIaannkX1WFLvsdw2htL
 NWFxv9f0IJor1K/N4ypIev6lzn1QV1pHr35ITUHKCSlRfRIXaIfKayvnKg64Yu0GrE0U
 TbJg==
X-Gm-Message-State: AOJu0Yyxq9uOFXui78xx7Ws1F9fQSwFc6OdhDOWPjJqGTLdLhUM7qHN3
 XKdjjwblQHjEQPUddeSAiDmVK+1swX2r8iLP9PmXzWTZ607hN83+rP1WYoAQgiUQz3foqad+Nbb
 PSi0Z
X-Gm-Gg: AR+sD113W8eB5IY2oE/qFEjcSUud+yH8JQ8b5x8zms1xWqdq9951ZR2OTHF5V43RsQQ
 DTaXVKkvp9f3lE5qNWHR1Ih+34924FlqMrYZMIBV/tolajugL9u2vbY+WDCupxgQn3B0Z9XloM7
 LfY52flaKWCWEq2ybASAZ3XY9ZAAtw7RwIqCzMxGy3sWZMG3PWKR85N1x0RDeAeJBRGDsYMF9p5
 jIFtQT6MaNxy0Wq36EPhN5/mSCKa8p5HccNcmCEgm3E4puq5WS8Ssj09WfdkKlc5JG1zdsDZ4qN
 PZ85FTaHjKiXHhickB20qYNeWi+E2p5pBITOSAeOT7oKMWnPNaITeNwBOFg9hQRaD4Cr1J7ezFu
 Zv3+oHaS1g0jnsqXLUqaFWc1zNtr1yAFEBR7aQamfH2y1kZQnEG+JGqtZKnu4x5AVE/6nvuZzVF
 gfvkFRtDtDGKAmJdjFx0NuoSKyYCRjJd56A+0t55npjpZn9oF47oVibE/coi6VwysWE5zmFRpqC
 /gLaX/pHy8yclzHsGe/
X-Received: by 2002:a05:6a21:9104:b0:3c3:9a7f:7307 with SMTP id
 adf61e73a8af0-3cbce8e599amr16121758637.24.1786314985300; 
 Sun, 09 Aug 2026 15:36:25 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbe8f19ace6sm2998102a12.2.2026.08.09.15.36.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 15:36:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Subject: [PATCH 31/56] disas/riscv: Allow decode_inst_lift_pseudo to loop
Date: Sun,  9 Aug 2026 15:35:20 -0700
Message-ID: <20260809223545.730664-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809223545.730664-1-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Allow pseudo expansion to proceed in multiple steps.
Assert that we don't have simple loops.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index fe503b6cae..b8e5b124a5 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -5259,9 +5259,9 @@ static const rv_opcode_data *decode_inst_lift_pseudo(rv_decode *dec,
     if (comp_data) {
         while (comp_data->constraints) {
             if (check_constraints(dec, comp_data->constraints)) {
-                dec->op = comp_data->op;
-                op = &dec->opcode_data[dec->op];
-                break;
+                const rv_opcode_data *new_op = &dec->opcode_data[comp_data->op];
+                assert(new_op != op);
+                return decode_inst_lift_pseudo(dec, new_op);
             }
             comp_data++;
         }
-- 
2.43.0


