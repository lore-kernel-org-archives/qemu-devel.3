Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F7C8CEDDA3
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 15:10:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syYJI-0001NE-Pa; Wed, 09 Oct 2024 11:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syYJC-0001JH-PN
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 11:09:02 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syYJA-0007wA-IR
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 11:09:02 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-71e050190ddso2546056b3a.0
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 08:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728486539; x=1729091339; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EYQWI5p9vUhtvQFXm2oStjAmXC4f4vQZGym/5HmIo8g=;
 b=Iao1Wkfu2M8xasCmE/DzKD/uKaGXsrXmrwEp3Bj8fyKIk7FoD+UEtFggCSF0iuiTmk
 OomA1Bx5GYXZWEXOUEZvx7BBBFj/hGIFo4B9vLxyqKkMyQtz0cDn9NRqEeDQWcuPtPNR
 Ptxubl5rn8oQI9F4TVr7mFc2Ar6LBfjTMyW1f3uT3ZC0EGo9zq572DDpPE9jj8lgV+E5
 Htz1D8mS4DZHAz+1J67X21Ch+zzT9v8q7mRTpZBAroj0I3apQlhOBbbJjA29XEobQ7eM
 w2hn8ZvDHladdQAylhd257DbnKKy02MJ7nCWyXR14jO05wX3RJCYRUc3xo8gxMOPBPvv
 OsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728486539; x=1729091339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EYQWI5p9vUhtvQFXm2oStjAmXC4f4vQZGym/5HmIo8g=;
 b=ClFs8EqlATh5OmiqCrSQFOqHrGAWzltokudX8AgbBUFUoPDFIGwoZwnfyUA93Xr1TJ
 X5KT6aJQRHymWYhVA4bulls3hbw4fryaAVxrUpSRaWjnpPRuunsFlApr5oqmYWwehFY9
 YTeRQRgnNLXwD1QEsvPeAXdN9Qs0wW7xrmtd12722Ih7Sbl3gwBAp8ySpbcy2fdwOGL7
 HcpTW/CFcofheylCjNPvQJ3A3tKGj+PIj8OngrszGbqCEe06Wtbl3nKigvxH4mYNciXJ
 p+FVK9XJyPoj6a5Zh2sClemhm9fDReJ5Ksws5McNotchraEt4ZilJN+NQbcygEDnfGdJ
 EcjQ==
X-Gm-Message-State: AOJu0YwS9qc0cbJ9DpHcXfWrzYJtNNOA4GuhNRQl/1HB9tJwRHFPBq9x
 eYTN9bI4D88h2RmwLQ3lbTpU8DnsHd3CgG5L/zyTehZnQEvpe3c1oQlU7X04u/4nnLaLAvtBgMy
 p
X-Google-Smtp-Source: AGHT+IFQVDWjqNKg3SS2WqohmyaQE9gv0goDMBxuaYFfHbX5oWTOHysYXJEKXuEP/SUeGvWSwk527w==
X-Received: by 2002:a05:6a00:1810:b0:71e:f14:869c with SMTP id
 d2e1a72fcca58-71e1db673ffmr4519349b3a.6.1728486539163; 
 Wed, 09 Oct 2024 08:08:59 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0d65278sm7881094b3a.160.2024.10.09.08.08.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 08:08:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/23] accel/tcg: Split out tlbfast_flush_locked
Date: Wed,  9 Oct 2024 08:08:34 -0700
Message-ID: <20241009150855.804605-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009150855.804605-1-richard.henderson@linaro.org>
References: <20241009150855.804605-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

We will have a need to flush only the "fast" portion
of the tlb, allowing re-fill from the "full" portion.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index b76a4eac4e..c1838412e8 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -284,13 +284,18 @@ static void tlb_mmu_resize_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast,
     }
 }
 
-static void tlb_mmu_flush_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast)
+static void tlbfast_flush_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast)
 {
     desc->n_used_entries = 0;
+    memset(fast->table, -1, sizeof_tlb(fast));
+}
+
+static void tlb_mmu_flush_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast)
+{
+    tlbfast_flush_locked(desc, fast);
     desc->large_page_addr = -1;
     desc->large_page_mask = -1;
     desc->vindex = 0;
-    memset(fast->table, -1, sizeof_tlb(fast));
     memset(desc->vtable, -1, sizeof(desc->vtable));
 }
 
-- 
2.43.0


