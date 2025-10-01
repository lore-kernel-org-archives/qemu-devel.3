Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD0FCAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:09:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3yQ3-00015u-Fq; Wed, 01 Oct 2025 11:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3yPR-0000re-Cl
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:06:25 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3yP0-0000eI-4Q
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:06:23 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-45b4d89217aso49632785e9.2
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 08:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759331147; x=1759935947; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DLGQVBAj1rcgUspN9zx226A8KWyP7OIjQQo0oxF48cU=;
 b=xjSGLFp0nFTZwfMteRih/6OdBfiSGkQ7W8LnftadynpMQ8H7LgvnFGkFwQFizg/070
 s1EmKcWkrgNgRlpnmpzFff+VuEJWgX+LKz94b75veoj6sVspuEYB9wj/7Jr9iiCmwzzZ
 1SSXuJbx3HvZzawGsfvQb77FTZrqehGoJaPZHd8qk53q2gGGZSGSgmY/CarrIt7NzIxl
 ulo7LAyi1AKchVIPfjutaWvkjWSvJVeA6bUOJ0HRy8WMSGM6fvPRgklibv09jUbLcFQq
 weABXPNGK/ceEJgqy7bq0G3xDWYEVrhn/0av9n6I1Vue+Le6MWGyNrQ6BTHM3kRcY2at
 BD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759331147; x=1759935947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DLGQVBAj1rcgUspN9zx226A8KWyP7OIjQQo0oxF48cU=;
 b=VMSTfWtq4dc85Nv7Y6fZ2BEFhXGm7gyf+oltx/xrXKPfONlgZYqRABUMmZs5Ag6zZR
 YM9CCkr9FlyUepOKheuuO6ATeaRuEPIAJdH8nPpoYIdFTXMkBqyMhFExdod5dLsUcQeB
 D6VHG3m5QB68XpnSUP8SPmN5u8fYxpjXI/+V2TAfeLxuNrwinlA0L4sIQ3FS53HGH2ns
 jQ3J7I5Kkgu8b849nyPEtiZSthxdKcMEenS/H5Oyq+k+mAez2FBvMvxA1cpcybzkIp8r
 TP7EZ4osfLPnrWCPpfDEDxzPnbanSLvv36098106ccmjJ8f0Op23lkzvq76DuCO4sYEX
 1qzg==
X-Gm-Message-State: AOJu0YzAFfoPLVyVU3nW36jO0kuMFDPT83u+YmFthAYA3PDSUE9XqS51
 B4FVjI3Uac+bUz8U+itHhZuu80Y0RXFZoDJjg+0OrjlLvUzDH5S2y4UWU4dXRtc5NwSW/ymEz9k
 Kawv4OrwByg==
X-Gm-Gg: ASbGnct0HFyncfJHuiz7Bqf5pfJcVhAwgJ1zgjVv8cYDx4cgv/2BfwaTEyP1kt8PQOd
 3EFVGLUcBvHJVqRFZOPDr8DdCgBO4ebVp1W6TZdr51q1U67gxokHv93P+awpZUPlkUMY+7LfZp+
 bRQxjDHe/DWfptO7EWVbTP0CliRkXp300W1TTxbBcSlH1DrWud41gekjpZgDs/KIZlO8FtwmJ8s
 nhVL/Hnf9G55Uls3X/RzAT3HDbVF3SxIdXqEd4V1kuMB2B7ZZBb3cPfcxVCyE1i3d/TvolBkGoI
 b+IS9WToKi6re6MN5N9LpGuHfTBtUtHJ/Mv27eR+BBNsdqhwDCPtJgucxtl2duFx7jsxb1EQNoX
 2SPxXKcamd7lwYDUNu6fKe6usWj/NjV3+LmTiBP8ZRBc+N1PNyjoh/MTPFxCo9YZa0fGbS6Mk+E
 FYNYO3WAkx1M6gyWr1AdlN
X-Google-Smtp-Source: AGHT+IEw/I3t/hR+beu96KQ4fixPA/nLDOj6cWuw5ZTikLMncMzZdCbTPA0H/HICehs2+NTOrJVv1g==
X-Received: by 2002:a05:6000:1842:b0:3ee:1586:6c85 with SMTP id
 ffacd0b85a97d-42557a1be4emr2862405f8f.57.1759331146611; 
 Wed, 01 Oct 2025 08:05:46 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc5603365sm28488541f8f.37.2025.10.01.08.05.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 08:05:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH 03/22] monitor/hmp-cmds: Get cpu first addr space with
 cpu_get_address_space()
Date: Wed,  1 Oct 2025 17:05:08 +0200
Message-ID: <20251001150529.14122-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001150529.14122-1-philmd@linaro.org>
References: <20251001150529.14122-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

In order to remove the convenient CPUState::as field, access
the vcpu first address space using the cpu_get_address_space()
helper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 monitor/hmp-cmds-target.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
index e9820611466..602af851328 100644
--- a/monitor/hmp-cmds-target.c
+++ b/monitor/hmp-cmds-target.c
@@ -128,6 +128,8 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
     uint8_t buf[16];
     uint64_t v;
     CPUState *cs = mon_get_cpu(mon);
+    AddressSpace *as = cs ? cpu_get_address_space(cs, 0)
+                          : &address_space_memory;
 
     if (!cs && (format == 'i' || !is_physical)) {
         monitor_printf(mon, "Can not dump without CPU\n");
@@ -174,7 +176,6 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
         if (l > line_size)
             l = line_size;
         if (is_physical) {
-            AddressSpace *as = cs ? cs->as : &address_space_memory;
             MemTxResult r = address_space_read(as, addr,
                                                MEMTXATTRS_UNSPECIFIED, buf, l);
             if (r != MEMTX_OK) {
-- 
2.51.0


