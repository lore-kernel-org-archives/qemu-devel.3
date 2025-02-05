Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2718C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 04:05:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfWdy-0008Lw-Bj; Tue, 04 Feb 2025 23:04:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tfWdn-0008If-P6
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 23:03:56 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tfWdm-0007Dp-Af
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 23:03:55 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-21644aca3a0so147687435ad.3
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 20:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738728231; x=1739333031; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=K2WH4FlAMIZ4FEc2EEi85vRc1c0fQFd97dzVfYF6JEw=;
 b=ZeIM1yFRSYCMk4mrzYbhsn1Vl+XI4o6aG/iXwIiuJQehBZJTgxVQFjf/PRlcivd+av
 claCtfj0Vg6XZnUi9FLoeYcdXdqsQ0RB35yDibm9VxjHYczgTIhS7JpOul3DGM0P+b6w
 BZ5aEYdW1p+/Q5PHjf/HEhkNjYk4UKIj7kNomuFYQqsNWHy5dSRdXICEabeVCmXNl8Dx
 x7BpgEYMX3WpMynqLunVTWU2Fqg4BhPFmzWe2a/36gw4EI6Vjh69ETmhHlAsKOt8VEZh
 3DxMNMb0eFXw4xCuVEaFhxG6JIUUqVrjC4cdaIp3IUCHeFBFwdTMlm2q1ulrL1N4Rn1A
 +hZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738728231; x=1739333031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K2WH4FlAMIZ4FEc2EEi85vRc1c0fQFd97dzVfYF6JEw=;
 b=IhoBWslwDQ7ydQSd4GKtPhAEl14BweghYwVdmaphvU1xv7sVJGk5ZQGogSE4ziLWM/
 AOlkU0m17/DUgYft1GfLEkGUnj/tKaCQpsD5DKsGNhm4OyEEUwQxTbv1FXQhylfvJjmw
 IKiBUecweXpoIcR4HhvAbSi9z2naVr6s4po6DPtCl+6I7OSEykeLmQCyW6J3XavRcMNu
 GyWIrS1/DrzJfI6nXG7V64wbPNK8gl2JW6PAQfejN11YcKveA5pI7DpKl4jFlYaciirE
 Cu8hDDGUHGMkSvUdWwwxPwJAjozdYQrPges4WgLOgypOe+bMFWdRFCvZZ9ujLCwZeAVS
 kmSg==
X-Gm-Message-State: AOJu0Yz+iuvaB5mTWh2uCFEBNDCAtDYSKPANppuqmVBazFspLCyZRC0j
 cW3oyYM4MBUDHEZC4otpMGRNzp0DKy88PBThrhLyc8Et/4UQV7N9oShOquL9wr1p2hBCk4aWDZM
 r
X-Gm-Gg: ASbGncuy0OWwTXuwO/rJGCbAbUpAzscrlsoY/qbfymARCZrxy8+DX9vNUJ/guEDbh1y
 0qS+SvGUyge+qJKfyaIkbRtROLKg9owavvAixstckhOsvP6d94jiLDSfCsEPY47lP/1kUQLv5oK
 QcdBQMeu+3wgblCaCDoCAx2/0lgUEvPjSqVnuRaPyduOMCykeiG9LWE+c6yzYhC/wKNk9/XAwYw
 rHZrY4/oBoCugeiBe3bomFYJdm9+PnEiycIvI4MpQ8efC+MuHjsfb+vSPOdRlK83tiZKDb51k4r
 OMxLLkHTiVYc2F31NcdU+omE5y6uLZ1Xxs3VppV5EAj9VNI=
X-Google-Smtp-Source: AGHT+IG1UBZqAdxUg+66exJN1TkuvP8EzWRPlVZX08eM59jJzZGN16HZ86KYuhC9dQbsGXQH6FSWmA==
X-Received: by 2002:a17:902:cec7:b0:21f:1bd:efcb with SMTP id
 d9443c01a7336-21f17dde2bcmr19813825ad.7.1738728231571; 
 Tue, 04 Feb 2025 20:03:51 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f054eb89esm22380325ad.79.2025.02.04.20.03.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 20:03:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/11] accel/tcg: Fix tlb_set_page_with_attrs, tlb_set_page
Date: Tue,  4 Feb 2025 20:03:39 -0800
Message-ID: <20250205040341.2056361-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205040341.2056361-1-richard.henderson@linaro.org>
References: <20250205040341.2056361-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

The declarations use vaddr for size.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 17e2251695..75d075d044 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1193,7 +1193,7 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
 
 void tlb_set_page_with_attrs(CPUState *cpu, vaddr addr,
                              hwaddr paddr, MemTxAttrs attrs, int prot,
-                             int mmu_idx, uint64_t size)
+                             int mmu_idx, vaddr size)
 {
     CPUTLBEntryFull full = {
         .phys_addr = paddr,
@@ -1208,7 +1208,7 @@ void tlb_set_page_with_attrs(CPUState *cpu, vaddr addr,
 
 void tlb_set_page(CPUState *cpu, vaddr addr,
                   hwaddr paddr, int prot,
-                  int mmu_idx, uint64_t size)
+                  int mmu_idx, vaddr size)
 {
     tlb_set_page_with_attrs(cpu, addr, paddr, MEMTXATTRS_UNSPECIFIED,
                             prot, mmu_idx, size);
-- 
2.43.0


