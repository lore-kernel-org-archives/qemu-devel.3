Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC74C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 10:30:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcMLl-0003Hs-7W; Mon, 27 Jan 2025 05:28:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcMKx-0002Gr-Oe
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 05:27:31 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcMKu-00022u-91
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 05:27:21 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-38a25d4b9d4so2245119f8f.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 02:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737973638; x=1738578438; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DgByrMylZY256tTsI6R1dbeQexynJICQtGDxrv9XG/o=;
 b=XclhAAx5iYc/JMv1HNBVm+WAElCQry64kkpmpoIV9SWGwZ0UBaZkfzD1OHB8hQc8gP
 BHyon7V7ui8TkSLXTy7hS04n4cMikc21gUGtkQ0iTDKqH3UWoZ3S3QZ9/zGimE06fchj
 lu2BX/OzSEQPLuBF9EmnToGF7qJsigC3fiXr+5z/3poVZ5o2LfwgPSPzR7RX/yz8vUb3
 APsX6LVdR6iJcW6BiMuc00yiihnkH5iTrzzuq5JcWrZtgF6NAs5f8hc4LaeUzkclPl0L
 //fLZN0VDRSUIrp0Ni3eoh12FbLuPrrPE8Te5q4FAa+40LnTtj+oNbjeGLHjkYgd7tI5
 25Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737973638; x=1738578438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DgByrMylZY256tTsI6R1dbeQexynJICQtGDxrv9XG/o=;
 b=pJZvDsqUwCbxHAEcuAgZMNNQ0CRT+QbgRPd5VEyjeeTVKFlqw5v+AcX33bBFfTxBdz
 7Cm1/kgbA4hP/jyOVzEc4W2sfVfLlOW3ipwqNe/lxgRDFwOwtHHmxG5DnrdAvTObUPsd
 6lzT1ItHFF3V6CT9tSHzrHtJRKB9l9Wv+X5XVu3esEbZrIBJckujT4JXdI38l0VXp3Sd
 UGTCGjWLRb3GNET6dXE6/RAGGbfXqrzeDb1KguK48XfQ0/rkImG/XffFzFvzZTyVUfed
 +uXg5NUOym3UwbW2591GCkHv/+f7NeaLUXwl15lvxtEtRpSr8nQAHddySV/Oa6eKZN68
 ltNA==
X-Gm-Message-State: AOJu0YxCaoK/Pmq+0mrL2wbXhAM3m1ysmOZVCRNCaUoRWR4R4KqKz1eD
 NVGQoop2mveJwHohM4rX28MsnzB32N5+ocNIyKUKtw/o+otQ4h258v27h++k7Cecy3oHJywS+Wt
 tcuQ=
X-Gm-Gg: ASbGnctcc/send8fRj/nhLb88/wM6LVT8IWEVcHdfs3MAYVS2HvTgpfFZL400hTcNEo
 Ui1FLV1vQB76QKR7YufrVoXo5qhLnmiOga5iI2MvgkFTHrkoIC8rwsmL/gHtxQBakbhf9P/SAzS
 5KDZI2NS2e9s6+QqzqhJ/SxUrYvP34tiph/3vHX3WBibXNDNa5cZMgkGMNdKoEQfF3NSWmoyazF
 9mcVfWT7Y4nPd2noZ7/yXjFjQr+2R9zUZ/qlTJ1esaaWwWIk1/wqHzSC0aHN7HBa/3KGCT0D2Z/
 387OzYLrrP0Mj59dUVUHUkYvzPhNfMzdaz9L3gUP0mgCe7HG5BdgyFM=
X-Google-Smtp-Source: AGHT+IF4/RAIOkmM+IPjWgnA4MxEALT9K24zm4+BA5WHdDTZFgDDbKvtiTWYO4urJgB/scXWNOxenQ==
X-Received: by 2002:a5d:64a1:0:b0:38a:39ad:3e2f with SMTP id
 ffacd0b85a97d-38bf565573dmr34239179f8f.2.1737973638429; 
 Mon, 27 Jan 2025 02:27:18 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1764c8sm10467726f8f.3.2025.01.27.02.27.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Jan 2025 02:27:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 12/15] target/ppc: Fix style in excp_helper.c
Date: Mon, 27 Jan 2025 11:26:16 +0100
Message-ID: <20250127102620.39159-13-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250127102620.39159-1-philmd@linaro.org>
References: <20250127102620.39159-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Fix style in do_rfi() before moving the code around.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/excp_helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 48e08d65bd7..661d9650d9f 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -2481,8 +2481,9 @@ static void do_rfi(CPUPPCState *env, target_ulong nip, target_ulong msr)
     msr &= ~(1ULL << MSR_POW);
 
     /* MSR:TGPR cannot be set by any form of rfi */
-    if (env->flags & POWERPC_FLAG_TGPR)
+    if (env->flags & POWERPC_FLAG_TGPR) {
         msr &= ~(1ULL << MSR_TGPR);
+    }
 
 #ifdef TARGET_PPC64
     /* Switching to 32-bit ? Crop the nip */
-- 
2.47.1


