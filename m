Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B49FCD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:11:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQjJ-0006Dh-Q5; Tue, 16 Jun 2026 06:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQj9-000636-AD
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:09:09 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQj5-0003kL-Bx
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:09:01 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-36bcf3d2565so3098259a91.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604537; x=1782209337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XaxxQ/2rudA9HGll1kBnOyEP3HxdMr2VQrPmX35dXjQ=;
 b=l/YJaFdXwdgP1Z+AyNkhALyogWGTHl/mbg3trBhjAN4EHi1avmKhkSX+5SdvzFD8m5
 QmPFUH0fHWfUH7VNSZXK67oz8mAKb2EM9ULnvssQVFR7M8KCsKXPjfBeQVohnAYqjn/6
 q2pDETlViqXX/bHe0syuN1Ar7hAjYzOLPglRedNQ+w1wpiHckBUocWLfztWLlqvCOcb1
 ytg+fH/rgSmW4Sd77OIAWej5nuZ/J1bVAlqlp12jpYlvZDuema0aPYgDXRhR4ZskgKcN
 TxIa/gh7VwZwE+9nuIB+indRNCLU9E6U84sJ7YAfiXSAlHiCyzba9MLh0xkp1CMt2NWS
 knIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604537; x=1782209337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XaxxQ/2rudA9HGll1kBnOyEP3HxdMr2VQrPmX35dXjQ=;
 b=hnmjbFZ2T1paGPtaRnbYTlGJ+sjBMkG1NcaIXT8RrGR/GntZuK7xr0JamGPZqUarcm
 aUIPIDZkx6JD/hskzwyHAXq3TaUWGnluSmFC3Dps6HU9prNp65TkaDVSdkfMxYH+sb6f
 MbNO7pWlPW5y0N76xBTo+VI/Zis7S8iUWKiHRyLk4iVEaktOGVQiyZD0VV2dRE4C1zb9
 nXw9VbH36rdG6x7ksA2DR1FItn7MqJz+JGu1LlGxtWTdGJi/dZCjnUo+B4ERLR9Ibn6Q
 gSmInDfi7WiS/M1ctEfwtGXuEkVuTnGDTa6eLkBk04cyh0tIz2AIhJv07csLGEUAv+iR
 Gxxw==
X-Gm-Message-State: AOJu0Yzeb4YbOvmqraRcP1varqvXz1/EXHDbfGWRUBO9wCKMo28ZWGxe
 6tNkcL+l5HuwBww6K1msaBhRThjsI80RQnF75fkw9+gP8ePSLhpNgMwhM1UysBWS
X-Gm-Gg: Acq92OHb9dYBTY79MD14ucapWG5g/gI+yXnH2rRg456BpHXLZ8Gkt63fVQ/zOaJWvVu
 Q4vVvJYeDJcPIJYfKXOb38T0aopxQpU3Vushp/06rHnA9Jv+xcpcV6Cu+keTW4g0d9UgQhggnvX
 1Gglcr4+i7dm4YdMkqKUx3LIWhlLHqTVVz77nv8z8hedzpi05vfdSi0enkL3TXEQPsTSlZJ5dok
 TVk2mjVxJ6DJyA38WoTqkBshZ0pdOIsIc4YNATy673bTj6Q8Tz3/WPLlz5riUBu9+pU3Cxmq3kf
 3FnnPkm6y8XJKT10R/u3A9C+U6cCCpzIqmCWYYtC9J48bZLOwVe3UAaLXs9xf5cDkL9sKQlZuvx
 poghgznscF17R5ykiniOl6EzRf8OQh+BIFB042pwl1z20laszq9asmLCchBdFqw7CrMYXwQgKOu
 mXW8yRBhBwg2zBadKMq7p2Tf6gO9baGxWNUVrGZkC3
X-Received: by 2002:a17:90a:6502:b0:37c:607b:2cd9 with SMTP id
 98e67ed59e1d1-37c607b3288mr535559a91.0.1781604537607; 
 Tue, 16 Jun 2026 03:08:57 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.08.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:08:57 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 58/83] target/riscv: Reorder Smrnmi CPU fields above CPU reset
 line
Date: Tue, 16 Jun 2026 20:05:01 +1000
Message-ID: <20260616100527.1939565-59-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Frank Chang <frank.chang@sifive.com>

Smrnmi CPU fields introduced by commit: #5db557f should be reset when
the CPU resets, so move these fields above the CPU reset line.

Fixes: 5db557f82bff ("target/riscv: Add Smrnmi CSRs")
Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260528060007.717307-1-frank.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index febd905389..eec5acea5f 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -491,6 +491,15 @@ struct CPUArchState {
     uint64_t hstateen[SMSTATEEN_MAX_COUNT];
     uint64_t sstateen[SMSTATEEN_MAX_COUNT];
     uint64_t henvcfg;
+
+    /* RNMI */
+    uint64_t mnscratch;
+    uint64_t mnepc;
+    uint64_t mncause; /* mncause without bit XLEN-1 set to 1 */
+    uint64_t mnstatus;
+    uint64_t rnmip;
+    uint64_t rnmi_irqvec;
+    uint64_t rnmi_excpvec;
 #endif
 
     /* Fields from here on are preserved across CPU reset. */
@@ -509,15 +518,6 @@ struct CPUArchState {
     uint64_t kvm_timer_state;
     uint64_t kvm_timer_frequency;
 #endif /* CONFIG_KVM */
-
-    /* RNMI */
-    uint64_t mnscratch;
-    uint64_t mnepc;
-    uint64_t mncause; /* mncause without bit XLEN-1 set to 1 */
-    uint64_t mnstatus;
-    uint64_t rnmip;
-    uint64_t rnmi_irqvec;
-    uint64_t rnmi_excpvec;
 };
 
 /*
-- 
2.54.0


