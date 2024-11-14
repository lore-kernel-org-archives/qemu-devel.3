Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08CCDD68B34
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:02:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcHw-0004x0-Td; Thu, 14 Nov 2024 11:01:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcHs-0004ud-LY
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:01:41 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcHr-0002Bb-37
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:01:40 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7245a9d0e92so810085b3a.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600097; x=1732204897; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oFR54WJ7Z7wCqfLri0LCaQ3ITtfM85rp0V8bo+nOxWA=;
 b=QN+Tt6rYXifuXSBZjImQwSCH4hazW2pmsUppYijDkooQppGCwF8Zeom+Tt87NCCknA
 PKTIb2SuDSnKU/TUZygzryUM7Ed037XquoyspZ1lyxr8cbg7RK+joHBQlvmiMIzRd7Wc
 KWAoemzFolfSxMiXqLkn+qaWF/4UsoNCzbP2Rtr12EbjzOP0sn/EdcoC8Oao/EL13nft
 Reu91QNLXdkfYjWsDwek1zh4hFvjKuVt5U48psoljF1LljP7tZAPY9kd35Uh9I8EQ2ZY
 XCDocsGMQfXnFKPSr9aDHxYI2hjnh9nn72NJSV6LPtKXGyAIJExg5gqe7+uhKNYG90iC
 nBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600097; x=1732204897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oFR54WJ7Z7wCqfLri0LCaQ3ITtfM85rp0V8bo+nOxWA=;
 b=RrXr5pGpoDs/ykzhJGayu12xCeJ0eFgk89jnKVqrZOz8UOwVvw9AuHFxdlNQT5A9nB
 2BmAA/3fDXFKhvuUK6OjA0kE/TT8jIMfAUvU3j8UbXxSYFtmiX1ypaujfOVrUQxqmX12
 GkzGjWC2Fdo4qLT4FW7wutxst/IKrXS6PYTGbiqH66Qu7YBszFaI53/YyssgIv61swGJ
 ES34XsL/SJaCBj31Gp99IbYaVzeeBgf1Oo9RjrkoyOXQ4d/RQt81+Y5t0ryLGGFETWn4
 W7Rydsx/eBDViJ/TZKUT+9QvcjZYlAs1MROuuGF2xSfIc3lH/KPiL9R/LV5usazAMyAu
 nNRw==
X-Gm-Message-State: AOJu0YzTcNvOZjuEczxq+oRsRBtV+1vyqE9ymmQUqFlU0PinsKNpCxiM
 YGH+QJmRqYExx4Us/UP8oTwkQIL121izuzBhuZOWiLN2KjsMWm7m4xAaQHDnPduiSo71+nO/x0a
 r
X-Google-Smtp-Source: AGHT+IEtgfnvE8wucOMCwWAfgCmZ8rB63917GWQJPZgDBTKLsxHXYSjWkH9si5U7nV6EibzRKcXRgA==
X-Received: by 2002:a17:90b:3948:b0:2e2:d181:6808 with SMTP id
 98e67ed59e1d1-2e9f2d5da6fmr8756010a91.30.1731600097110; 
 Thu, 14 Nov 2024 08:01:37 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024ec723sm1484438a91.46.2024.11.14.08.01.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 08:01:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 06/54] accel/tcg: Assert non-zero length in
 tlb_flush_range_by_mmuidx*
Date: Thu, 14 Nov 2024 08:00:42 -0800
Message-ID: <20241114160131.48616-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114160131.48616-1-richard.henderson@linaro.org>
References: <20241114160131.48616-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

Next patches will assume non-zero length.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 77b972fd93..1346a26d90 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -791,6 +791,7 @@ void tlb_flush_range_by_mmuidx(CPUState *cpu, vaddr addr,
     TLBFlushRangeData d;
 
     assert_cpu_is_self(cpu);
+    assert(len != 0);
 
     /*
      * If all bits are significant, and len is small,
@@ -830,6 +831,8 @@ void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
     TLBFlushRangeData d, *p;
     CPUState *dst_cpu;
 
+    assert(len != 0);
+
     /*
      * If all bits are significant, and len is small,
      * this devolves to tlb_flush_page.
-- 
2.43.0


