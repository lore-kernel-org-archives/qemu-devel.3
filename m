Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2065C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:02:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiIFY-0002KJ-Tg; Fri, 10 Jul 2026 16:55:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIFB-0001iK-8B
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:54:45 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIEv-0000pD-0K
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:54:43 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-848882fdb18so343456b3a.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783716868; x=1784321668; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YQ0VkN+fXYkTd5pIzgNSNc34KFa66jXvc0dQc3T9c/U=;
 b=KgqfIWcbqIF700zUYkkmZ/bLYp3zfRy7TLSMgfSHIWNF07E8sN9CANMyoEIcL45MPh
 dFLbqiFj0wXk1jrfRw7ixN6rFz60YVY2TkOFOVa2o8oanbfdEvMTPUV+2ZmWDG3+YoHL
 0b/iNXCkRcDUMB1rzIZqphJBw8ZUFX1+i5BjGVj3Gau3hqXY5uF53bip/L0bv4+ttWlS
 PhCi5Az9j3XbeV014lbfljeoQdyhIwx+DmjeieR1gdECsKtLRyFPr4lNVqX1d+rZVnyI
 D6EOHlG6XJvJ5uoVqm5lzDuzgkFCK0IJH5cylDpa+I9P1zYFFfH4lOghUBKpUiOPqdFp
 wePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783716868; x=1784321668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YQ0VkN+fXYkTd5pIzgNSNc34KFa66jXvc0dQc3T9c/U=;
 b=Ko/e2RI+nW3uUatF9MLi/y6Hrg2LGtuvWFAjstvcX35c0XNHVtlkSIq/VCeh4SGq6q
 pc634c9bKJ4fQh8fqYEK565dVKiY3QNTMxNAI/9dVDO5hMiPA754dbPZbIbLzoIDfEMx
 BQ36MDzW+tYc75hfvoUiHc4c0XRzSDG3aJIN1l4kEQbZUIwmtx7dKhqT/TZhaTunnwYi
 xgXwEuuOhIMkkSgv8DsPIdNVJRX9V6uH8EYFEt19lvDeRZfPiwyOb51uurloTn0ro/wK
 D9U5niX2CfwnJ9F9QPYqERyHo/VYeRah6GFHX8KLtb83j46sH789GZmt7HkgfHS8aX6B
 HXrw==
X-Gm-Message-State: AOJu0YwZDQo9oG7vYm71nzTrlsb6LoAxhMHMdj6ifl2pmpmwewFOLRIr
 uht3c1EnISDPfAgDYUJtbOhezzc2WLrBaKrdeblMgC0jEKfyAlxo73yyB9Axb66bz2faKTN5Ksv
 jhQXB
X-Gm-Gg: AfdE7cmv2hNg0wrIWiEPdF9cs/xZWzFi2ywN0gwwVvGxb2EUIwzfD284rgTARXI+LEy
 VZvppPCXkBaQVJODtCoOHt4Nuj3KVaKyKJIDuT3ovZ+z2Q14hxENZqdm7oU8tN+1lZ/kW6xbvKb
 xhsCgX2FJfdZHNUZRghWd4RtsIYWSTHU2DoKBtBGpfmIJQNi8GyOkhiOVHUvdA/nEXB9OJh3c46
 E72JP/fJm4KQKEZ8TXlIFIdHompk9f/mjkYyixF9L9KWdor91kvpPEzlskiU0GsbU7cdP0w/dSE
 7dVNEHjjvqMxpdbocJ8623mTc30VYnuWXKhVNj57pP+5KIEmqMWSTpIxiaBthghyeFzcqdUMXMC
 FhUw+1LLoH0EEbPK+gF00W2SdcHGTiJg25mFUULEr7IrukrlcwG/sn4wV6jT0z71ncrk62RQFjx
 E7+OgblLwuphzgZiHbeQ==
X-Received: by 2002:a05:6a00:6c9a:b0:848:2f84:f42d with SMTP id
 d2e1a72fcca58-84889792beemr481182b3a.70.1783716867603; 
 Fri, 10 Jul 2026 13:54:27 -0700 (PDT)
Received: from stoup.. ([71.212.146.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6d76106sm10780574b3a.40.2026.07.10.13.54.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 13:54:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
Subject: [PATCH v3 23/51] cpu-common: Validate flags in cpu_breakpoint_insert
Date: Fri, 10 Jul 2026 13:53:33 -0700
Message-ID: <20260710205401.836304-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710205401.836304-1-richard.henderson@linaro.org>
References: <20260710205401.836304-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

Flags must specify GDB or CPU but not both.
Flags must not contain extraneous bits.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 cpu-common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/cpu-common.c b/cpu-common.c
index fcc9bc77a3..80a4a191f4 100644
--- a/cpu-common.c
+++ b/cpu-common.c
@@ -410,6 +410,9 @@ CPUBreakpoint *cpu_breakpoint_insert(CPUState *cpu, vaddr pc,
 {
     CPUBreakpoint *bp;
 
+    assert(!(flags & ~BP_ANY));
+    assert(ctpop32(flags) == 1);
+
     if (cpu->cc->gdb_adjust_breakpoint) {
         pc = cpu->cc->gdb_adjust_breakpoint(cpu, pc);
     }
-- 
2.43.0


