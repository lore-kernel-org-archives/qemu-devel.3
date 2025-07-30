Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E24C87FCC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 22:08:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhEyj-0007Zi-0O; Wed, 30 Jul 2025 18:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhEwZ-0001S0-V6
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 18:06:40 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhEwV-0002c9-4Y
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 18:06:39 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2406fe901c4so2613225ad.1
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 15:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753913193; x=1754517993; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jbXLHmQQJw7qwZ2+SWP/dkFm2f03bsQgTb+axHNXMUo=;
 b=WpuCp3Bu/3UCu2OhC7k4PSr/y5dX2J5J22EvnPAFsD6GqYGRyZqxv8cB72Zxr+o8v/
 n2XLHKHg+6bvCPNgBhglKaPG+VgvOiR6BuR+xxcZLW/PemNxMqu44pyS08bFUAFaZqk9
 IK/7hT1jqljomWbLOVPxSCb5jlRvW/KzBrG3OCgBbax+6jja5PDa3sJsCwwrvASmxHSt
 QZiQtBuOylm7DUto0bSm+FdlMpp4lWx+YWXHOTamSerz6Z/MCa82awPEqzhQ/OeeROED
 SFuPkD6JQnWMksFaZ7yFTYJLGQdfndOj43Eob5Y4W1c7guReWtz9jPP80i0iUY/vfaFo
 j2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753913193; x=1754517993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jbXLHmQQJw7qwZ2+SWP/dkFm2f03bsQgTb+axHNXMUo=;
 b=ub+QwBcyBmeBizEV9el31C0qtHlWCwr/IsyGhhGy6vbJxjUBc8Qtff4DHqZPDWM9KA
 whGoP7y7v7hOFpB5/HEaTCaEkFFtSJXI/d1p6n3C/Ta7nufIZ0RY1Cg6sjV0U+AK4j2N
 Vcg4MmAjI6mzjDJ+FWnGbPJZdhCL1hBiRkemHIQl48H94XvuclNhF065TOQNPofmC5Hd
 Nm1e6Uof3ZxaPuTU5sfJ9puSk/KdQgWfs2s38U/8bjyLspZaZFqWWbVmbd4wwIcTkUZG
 mDoRBFI0uAzZl/kB5IfaMOA8qWXs/kIA6DR50iVtISIWz/s7g114wzR/jQ0kTWyrTZfo
 Jkow==
X-Gm-Message-State: AOJu0YygPWb/Dt9c5COLGveQQKzt5vB+hr5RRKUHGxrU69Cs/CZKuPcx
 2oUNOjWtFZ1buunlf6gv3wZASynSQcfFMHq1FSczAajn5DPUe+dgDVKkgoHKDuPcySKmt+NA/3h
 ajZhn
X-Gm-Gg: ASbGnctYifyqqIswzcuzDwKoKCPOk6AgHB7jF9T+BJVDz+alCGOiN7hEtUOPFvGELDM
 yQqyO2NwAQiZGMnSQwDngxtaP+Oheu2GllTVppQnXisUqdJqKisyCK9TY0fOYPKo9na9+BWRLm8
 Otfi9Hi1BrnjU/vaPvKVT6eGucf3SYHyI1XeefMab1SIxHraveyPQmbi2oFYXoGT+xq9e11oeST
 4FHUF8cWHL2rd/Z/uieKyu1vBrxvehG1NVihs9axs4b5WYG1SmX9wdjDo9FaOgP0LB6g0AqVbKr
 QB3V9RUQsEVC+wDJHxDmPP1FoXeNKplKmqUth3gjTmwSyj4uYlr7YpiMuTpHH0vaCeyGek8SId6
 dEJbc6/or6l8OvnAM8DiWBmIe6sDaR6Lq
X-Google-Smtp-Source: AGHT+IFoSoMOGjYHJDomwFFMKzj9lJw/pOTfpuFSUBCXqJUVExdQ12FyK25uLANeWRnctQ19TynBfQ==
X-Received: by 2002:a17:903:19e5:b0:240:75dd:3a3 with SMTP id
 d9443c01a7336-24096b1bf27mr72747965ad.28.1753913193564; 
 Wed, 30 Jul 2025 15:06:33 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e899d272sm981535ad.135.2025.07.30.15.06.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Jul 2025 15:06:33 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, philmd@linaro.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, richard.henderson@linaro.org,
 qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 06/10] semihosting/arm-compat-semi: eradicate
 sizeof(target_ulong)
Date: Wed, 30 Jul 2025 15:06:17 -0700
Message-ID: <20250730220621.1142496-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250730220621.1142496-1-pierrick.bouvier@linaro.org>
References: <20250730220621.1142496-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

No semantic change.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 semihosting/arm-compat-semi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
index 5a04ce55ca9..e5a665d604b 100644
--- a/semihosting/arm-compat-semi.c
+++ b/semihosting/arm-compat-semi.c
@@ -787,7 +787,7 @@ void do_common_semihosting(CPUState *cs)
 
     case TARGET_SYS_ELAPSED:
         elapsed = get_clock() - clock_start;
-        if (sizeof(target_ulong) == 8) {
+        if (is_64bit_semihosting(env)) {
             if (SET_ARG(0, elapsed)) {
                 goto do_fault;
             }
-- 
2.47.2


