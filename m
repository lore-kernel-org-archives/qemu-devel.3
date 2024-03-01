Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8519AC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 23:07:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgBy9-0005Tr-Ql; Fri, 01 Mar 2024 18:07:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgBxs-0004vx-IN
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:06:52 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgBxq-0004GQ-W0
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:06:52 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1dc49afb495so26079125ad.2
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334409; x=1709939209; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vVQmqpHBlbE8lrIqY5LVT+yiAGVzo/DdsXrDpEqGU+A=;
 b=QC8u9SM7bNDosgwI+clfqLFG6VJp3t5zHlkUDPyhLdXIWBxmgmfFx6HcfW9Y5uWObJ
 ZidDUeBK/AxZhJb94PL4A9q/8QBRT3x0uHlcujHQl17T42U3cs8NRCmH2ezj7+YMFpSb
 POJdWKmP1W5LatBayGVIxeQjbMGoQafcKy9Yvd2nDMpRnnddrf55RCWM6Zr/0e15I8rM
 bKlofvtMUWm2s2+dZUHwrW4I7ZmI+lmpqqbV/ctgJfy4Ov8ZVVesQOr8oefmaZTdXwq0
 k2tcWh9qUNETx7ipgm5pp9musgOeL7wX4Xccc8jK9H3E7rlQpmPI2Hio6iSbeperP1Uc
 5/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334409; x=1709939209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vVQmqpHBlbE8lrIqY5LVT+yiAGVzo/DdsXrDpEqGU+A=;
 b=cSTQ1ui4uprUD518uIkktQhgZfKmX+vEiac1ZjvVLQCogxSZl95K1CJ3QnSnNOOPjY
 6DOPL7rz07N/9q2gdKd3eQ/DCdoCMz2fnJQzOcL2jwQ1ofblTSPn1ZBz7jKJMt48Dnnh
 jhxzih48euZhQ+OtmeeFbNIujX7Wu5wQgjgGqzFG8rIePisipzd7Mtde4UN+RNQNZ8GG
 QTkyaz7rfPgn6GqXRaZv2Xr8HYAsxxoA38vaQL6gAEn5jViZO36iP80Nll/Reg4L8xB5
 TbJAunoSSCJfU1LLcovEhIeLmzvn+tVtuenFrOqbxYoVnOhNXYTfUhvfiVyLNe6cddUj
 b+lg==
X-Gm-Message-State: AOJu0YwJxhJkKdcMBeXnkuOMU4Tmf/lV2oq+ifv+Ay6+jwFzHDBR5sAl
 JD1x849Pgr3xDX6zVcYeqhd3Cf6syT7iQofxNfCqD3PM4rPbljRUSlrmOeRHFA91dbDuJdvCell
 L
X-Google-Smtp-Source: AGHT+IGSZPtOem2Q8frHoyHCgITbNp2/a7AosA9nkJyXI6lKSLBLlrrvbh2mCuQk7NuJTtBio02fGg==
X-Received: by 2002:a17:902:ee42:b0:1dc:b16c:63fd with SMTP id
 2-20020a170902ee4200b001dcb16c63fdmr2947113plo.65.1709334409531; 
 Fri, 01 Mar 2024 15:06:49 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 lc11-20020a170902fa8b00b001dc668e145asm3988580plb.200.2024.03.01.15.06.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:06:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH 20/60] linux-user: Remove qemu_host_page_{size,
 mask} in probe_guest_base
Date: Fri,  1 Mar 2024 13:05:39 -1000
Message-Id: <20240301230619.661008-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
References: <20240301230619.661008-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

The host SHMLBA is by definition a multiple of the host page size.
Thus the remaining component of qemu_host_page_size is the
target page size.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-4-richard.henderson@linaro.org>
---
 linux-user/elfload.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index a51518f817..561c11ff37 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2893,7 +2893,7 @@ static bool pgb_addr_set(PGBAddrs *ga, abi_ulong guest_loaddr,
 
     /* Add any HI_COMMPAGE not covered by reserved_va. */
     if (reserved_va < HI_COMMPAGE) {
-        ga->bounds[n][0] = HI_COMMPAGE & qemu_host_page_mask;
+        ga->bounds[n][0] = HI_COMMPAGE & qemu_real_host_page_mask();
         ga->bounds[n][1] = HI_COMMPAGE + TARGET_PAGE_SIZE - 1;
         n++;
     }
@@ -3075,7 +3075,7 @@ void probe_guest_base(const char *image_name, abi_ulong guest_loaddr,
                       abi_ulong guest_hiaddr)
 {
     /* In order to use host shmat, we must be able to honor SHMLBA.  */
-    uintptr_t align = MAX(SHMLBA, qemu_host_page_size);
+    uintptr_t align = MAX(SHMLBA, TARGET_PAGE_SIZE);
 
     /* Sanity check the guest binary. */
     if (reserved_va) {
-- 
2.34.1


