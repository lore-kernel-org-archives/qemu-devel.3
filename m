Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA46C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 18:40:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk71C-0003Tx-5p; Tue, 12 Mar 2024 14:38:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rk70z-0003Mb-14
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:38:17 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rk70w-0000cN-VT
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:38:16 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-41329b6286bso14727845e9.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 11:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710268693; x=1710873493; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rNmtdgrS8nqQbHwAjbW+CEcSMsj64qvynMqUvuKu6rE=;
 b=PVPqJ4/PF7J4rRdwOH7lbeGROHnwBpYnv9wFwIjeXrLyCx4LQvk6ZYO/p4M9NYS+/9
 cmkEpiNxF+RQkXCnFGT0wLmkdE061k9+/+pGFlh3rkk48xMsb1AThLhoj6+SmVDjog2c
 2/wgVkHakY3Og8t85uu34sZJtVNKStK5CQ9ftT8mpcSnft53mjZ77TOuF5mJlJAMzlmr
 FZqVxS8fckopWM2SkKUShRuIccxA7R+62Alu3AuiSCA/XQEmD/+pQSI4WhlaYeS5xQ9c
 ds73mbSC65uZl0QH2p0LZdV2VELEQbRC2pIlmOGMPTTXVNU86cRVT3fOlDuZwOgGr20H
 OKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710268693; x=1710873493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rNmtdgrS8nqQbHwAjbW+CEcSMsj64qvynMqUvuKu6rE=;
 b=cJ8ArTJXvUBGvmYMitjzKR3GztG17vTe/MA7GrNWYX7UHMAXpiZIrC8nq8tcVUaj9+
 2pj1HnJ9WjInJJ9yRGdoVqEFX4pOuQ1ekKzZjXK0CTDhRlvhiCh638gjbUiK67W+Wp1y
 lNMsLel0ag/neMn9uc/ttTx6IWzXFPVeHsSAxKXJHJkmvqQ6Yx79q3CEKlkr8vFQmbHR
 jnmUaBmTpdgOKFNEj/d88cQvABwT9lmerIVvhf9LRVIyVC4e/xAgycxRLHqFd7g5WYXj
 MYjYCEW6dubyY+4GVLkpug9KgwoYzDf0z1ri5O5DUPtXrAaYBuhLLJPOYKpPGRNnlYDP
 l96g==
X-Gm-Message-State: AOJu0YzJKppr4XVm5sOTEH5ep/Mrf+7bYAV/z5S+PJXmB3wAQ+O9x0pP
 tDQwBqb2H1a3GEi3eHXnCQTeZglhXWwREdZA90SJeiz+kgOqyhSCCOcCXp58zqnXK4K4g6EICB2
 n
X-Google-Smtp-Source: AGHT+IHkDzX/gjfiMm/bGYHoGySSAolaxSzvda/YmtVcoX3nzjjSqc/KC2K4LpHUXBTVw+qRzTQspw==
X-Received: by 2002:a05:600c:1f07:b0:413:1f58:9d15 with SMTP id
 bd7-20020a05600c1f0700b004131f589d15mr811421wmb.7.1710268693598; 
 Tue, 12 Mar 2024 11:38:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v17-20020a05600c471100b00412ee8e2f2asm19836337wmo.9.2024.03.12.11.38.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 11:38:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/7] hw/nvram/mac_nvram: Report failure to write data
Date: Tue, 12 Mar 2024 18:38:08 +0000
Message-Id: <20240312183810.557768-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312183810.557768-1-peter.maydell@linaro.org>
References: <20240312183810.557768-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

There's no way for the macio_nvram device to report failure to write
data, but we can at least report it to the user with error_report()
as we do in other devices like xlnx-efuse.

Spotted by Coverity.

Resolves: Coverity CID 1507628
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/nvram/mac_nvram.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/nvram/mac_nvram.c b/hw/nvram/mac_nvram.c
index 5f9d16fb3e3..59277fbc776 100644
--- a/hw/nvram/mac_nvram.c
+++ b/hw/nvram/mac_nvram.c
@@ -48,7 +48,10 @@ static void macio_nvram_writeb(void *opaque, hwaddr addr,
     trace_macio_nvram_write(addr, value);
     s->data[addr] = value;
     if (s->blk) {
-        blk_pwrite(s->blk, addr, 1, &s->data[addr], 0);
+        if (blk_pwrite(s->blk, addr, 1, &s->data[addr], 0) < 0) {
+            error_report("%s: write of NVRAM data to backing store failed",
+                         blk_name(s->blk));
+        }
     }
 }
 
-- 
2.34.1


