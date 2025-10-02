Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 321BDCAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 08:53:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4EuO-000701-2q; Thu, 02 Oct 2025 04:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4EuA-0006uF-Bd
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:43:15 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4Etr-0000vb-Jd
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:43:14 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-46e52279279so5091995e9.3
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 01:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759394568; x=1759999368; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qZW6KOJbHUgA0vcevzhPmMJNHgyRN0rHSvzpaRdIptI=;
 b=ZbqzvKPcbxNW2V3UFlcdE2OBhuJIK4eNkP7TwMZq5qdTtKxNkbWj5PfD9nlwoQF+WE
 nbEgBGGEVTN3RT0tRv4q0em/TH0mmDJ12qGjGmmm3KIc1G/UN8xTMohtXkLXNPnxGU8X
 FV5nV/gRbZb309Oy0sxaiH6BQW6N1VzQkuTPqcmz0nwWJbvNQhBo4enWapJO669b7qCz
 cVachjub32clkWl1xYXNvmLHeuSlEseHYrRfxuo+xEYZoR9OS0wwyUT6dPIMCZqQ3Qm8
 ZZ27S09D7PXhLepqE/XqoG3ra6NS1EEVyfJq0LAUQsJbfnRMKQ6CYG+LpxBHOuLV9e0S
 mbEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759394568; x=1759999368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qZW6KOJbHUgA0vcevzhPmMJNHgyRN0rHSvzpaRdIptI=;
 b=rJTQVMVslSKvWNY4/80pYZ+SWVGKI+sK/uKccWNYO72F/fAMVvJApgToUx7Ltt5/Lz
 Oa6Jfv9PMMoivwZbYHoro6fKm+j9d5w/60GO2Mpf5VJwPaq9m9nSdql38Cuh/bjow1Xo
 SOMvIjR0ehutJIDEIGfJyQcHyagBVhAM7aztQSWfSoVI+eAhJLTbq1Hv4V5pUnASuNvs
 PPp5P0E4yvtxjk90n/RcE5PBelpUSgcnsfCq3ic3SZ8umMNvbkVU2hFMlOpC9KjIonLQ
 VL/Vww5xhk3QoSusDfHjimHs9Tv0xnxfTYloHaTwhVZed8r9eShZs5jBsGcOsPvMH2Pe
 gKsg==
X-Gm-Message-State: AOJu0Yx/jnLc40/QMUJ7ZAJaA2v+J/3ejp0BcCoaav057BsdLMZyEcaq
 SXwUDqyj4dNDBX716DkcWzL0P53nMCi4foU8V6aqECO7sqmB8ZYcPkc70juTZ6/RisW48+XwrcE
 yc3dBZPp1ug==
X-Gm-Gg: ASbGncvMpPe7QTH90sdWVWvQJoXT9hxsO7dSI5PUI3VcOTZL+MfS+BWAnFIip46wRUW
 4R1Zseq8pRMvTkTZGGvuNDsOVXPEZqwg8lP1kspZXPtHTjJZWOhjoqu4gH8/cY7hYU9JdMMJUrI
 K/giO7CU1h19PbS0uyEcVl9MRBCKhfhoRYltlzsEC80OWFiBhwg+sDzP3QgZY4aOlyjNfCUnMv6
 JdoU1R2/fZxqrFUkCuLB1L/lw30erB9Xg0GPEv3le+FWljzyt+Bumca+8VgOXiX4hxzQGf/v0lL
 RW0N8Xi325B5nmiR8DbLta5zPjBG88uqkoOmXQhEFnIREZuTdEgSAewKqKlMCDN47Vc4kUvP6tA
 yBjAO5z8WtphH4fMsV06wb656GuROOuO9Zcb9q8ouOt5DM4Fg1ozbrdOTXMtmPix5Okywf1QSip
 nKh3YtPhQ6m/KtQQWkv1imDqBmSX8v3A==
X-Google-Smtp-Source: AGHT+IFq5U4u2A5oX9CLBB2lvkndRGUc5Ro2dPOckjD4hsAueX9T9m8XX4dTf+0cKHrb84/7PaVvaw==
X-Received: by 2002:a05:6000:420a:b0:3e5:5822:ec9d with SMTP id
 ffacd0b85a97d-425578154f6mr3598474f8f.41.1759394568264; 
 Thu, 02 Oct 2025 01:42:48 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f4abcsm2621643f8f.53.2025.10.02.01.42.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Oct 2025 01:42:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>
Subject: [PATCH v4 09/17] target/i386/whpx: Replace legacy
 cpu_physical_memory_rw() call
Date: Thu,  2 Oct 2025 10:41:54 +0200
Message-ID: <20251002084203.63899-10-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002084203.63899-1-philmd@linaro.org>
References: <20251002084203.63899-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Get the vCPU address space and convert the legacy
cpu_physical_memory_rw() by address_space_rw().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/whpx/whpx-all.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 2a85168ed51..82ba177c4a5 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -788,8 +788,11 @@ static HRESULT CALLBACK whpx_emu_mmio_callback(
     void *ctx,
     WHV_EMULATOR_MEMORY_ACCESS_INFO *ma)
 {
-    cpu_physical_memory_rw(ma->GpaAddress, ma->Data, ma->AccessSize,
-                           ma->Direction);
+    CPUState *cpu = (CPUState *)ctx;
+    AddressSpace *as = cpu_addressspace(cs, MEMTXATTRS_UNSPECIFIED);
+
+    address_space_rw(as, ma->GpaAddress, MEMTXATTRS_UNSPECIFIED,
+                     ma->Data, ma->AccessSize, ma->Direction);
     return S_OK;
 }
 
-- 
2.51.0


