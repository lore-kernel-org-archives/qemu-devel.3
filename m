Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0733FCA1013
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 10:14:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvYrv-0001Ud-V2; Mon, 08 Sep 2025 06:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvYrt-0001U4-SU
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:13:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvYrk-0000tM-SA
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:13:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757326369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xDMh8Tj9XNE2pbl7SQeVp29Pr5x/uZR6F1csyzVp1gE=;
 b=b63aAu4EiPJE36MS2C4H4QNzQwD4t3QO8mJaY4qTSyT8YLMg88cJzSFoJUPPsSdjrowKxl
 n7FeDJEuSYnFmF7RSLa2Yyp+m0TZc0frwu5FQoUSx62WQCevoIcNZEDJ1O8nj6wn4G6BHD
 IhmTXkS+UIo5+YKatkXTmtEgRfHT7Rs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-qZfMMGy7N-uBLZi8gcCPSw-1; Mon, 08 Sep 2025 06:12:48 -0400
X-MC-Unique: qZfMMGy7N-uBLZi8gcCPSw-1
X-Mimecast-MFC-AGG-ID: qZfMMGy7N-uBLZi8gcCPSw_1757326367
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45ddbfd44aaso18518195e9.2
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 03:12:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757326365; x=1757931165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xDMh8Tj9XNE2pbl7SQeVp29Pr5x/uZR6F1csyzVp1gE=;
 b=RTtyyL+/R9qOis6K+TVzNGpL3iU/Il2YcPEJKQ/tE1LgeSCjEUAyHj2Rvja2jY1kJa
 WuAOkDMpLQL4kN41qPUunYjlNgYbnJhhZtZNdByf9syxsFn3L963mbT6xlWN5eDnFJOO
 nRkPLlGmmBQf9eFCAwDSZAE/IWAZMZtZZiG+f9XxOONppSekAyBXazrqULmkU7+4hnWc
 KxG0STpyFVyeU9+4Mp/NSd0GIZopozGWpGbBaEY+d9+1LXaAW4cA1UxnTLqaIM7Xq+Mm
 tEAMcheP0RhyQuB8xygY+VW/JT54VSTp45mLG4s6MrAfQMvu1LmXDlNdVPfL9BVddYc6
 2Zgw==
X-Gm-Message-State: AOJu0YyoBArYXbf85Td2IZ+/A+8j8191NKqF3e+LFh8qURS5v0Mrp0Fj
 df8GiFOpG355C50nCqinavopP0zpr2wNvmqK8/9F37jhKP3uBgT1sA2fu7q2X9vtOJlgOL5lUet
 ahLHnP1g3ANDLghHdlLyj2sqeJJTJyecUdZ7ntUOJ81I9OZ8XR0DMPsi+nhC+8Fm1QNSABEsjz5
 p0jgny0sDV3GEQZrjWjOI8Goi3nxi9up3C50D5vgvn
X-Gm-Gg: ASbGncvsaCLkhdxjtN/FrfQRbdGxMTT1zYNKMaZZPE/4cuAhMEpS61KegyUg0yaBJNQ
 mH5GatJQ8VRdT8jC6m03P8XZw+g2jj7kVlfIx8UyqikNgbmJ8Bw5ROUcKeRAJ8LARW6nrJSX6Ug
 D88OBVqUCzzZGTWX0CyNVNptyBtAcJHGJ4NN+tm49Y9ewyOO3H/mv3WaFurOrQWsnEAf2YYsXnz
 t9yMle7UE3lyUtFDEFcnBZqxdushfFOi0+tWVgk3mDw1dA8NV9+ZOuu4fwFlILx8FaUUnu5ZlYT
 TXQ9sk5CILypiDMXYktvTi2iS4Lzz67YijtMMnhNRxfckDYYs4YvNFqGaRt0fiCoYTptLpJ07Fh
 du9MzNWfFY9tcu9XM8PW3m47obHdACaDA0OQ7OMRoxJQ=
X-Received: by 2002:a05:600c:1991:b0:45c:b575:1aa8 with SMTP id
 5b1f17b1804b1-45dddeed95emr50676845e9.35.1757326365207; 
 Mon, 08 Sep 2025 03:12:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5kA4ZtNfoZF0xG1edGVELFWWNrBZbx2lf/NBUTrXIZuv4NNykJbpryLfgAlFNRPsXyZNT1Q==
X-Received: by 2002:a05:600c:1991:b0:45c:b575:1aa8 with SMTP id
 5b1f17b1804b1-45dddeed95emr50676485e9.35.1757326364730; 
 Mon, 08 Sep 2025 03:12:44 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45de229238fsm69836945e9.16.2025.09.08.03.12.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 03:12:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 01/19] target/ppc: limit cpu_interrupt_exittb to system
 emulation
Date: Mon,  8 Sep 2025 12:12:23 +0200
Message-ID: <20250908101241.2110068-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908101241.2110068-1-pbonzini@redhat.com>
References: <20250908101241.2110068-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

It is not used by user-mode emulation and is the only caller of
cpu_interrupt() in qemu-ppc* binaries.

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/ppc/helper_regs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
index 7e5726871e5..5f217397490 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -274,6 +274,7 @@ TCGTBCPUState ppc_get_tb_cpu_state(CPUState *cs)
     return (TCGTBCPUState){ .pc = env->nip, .flags = hflags_current };
 }
 
+#ifndef CONFIG_USER_ONLY
 void cpu_interrupt_exittb(CPUState *cs)
 {
     /*
@@ -285,6 +286,7 @@ void cpu_interrupt_exittb(CPUState *cs)
         cpu_interrupt(cs, CPU_INTERRUPT_EXITTB);
     }
 }
+#endif
 
 int hreg_store_msr(CPUPPCState *env, target_ulong value, int alter_hv)
 {
-- 
2.51.0


