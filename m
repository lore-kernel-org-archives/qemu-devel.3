Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D55CBC25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 17:26:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEuLo-0005rB-Lb; Wed, 05 Jun 2024 13:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuLn-0005qc-7I
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:03 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuLl-0003o3-GT
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:02 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-6c8c880f526so17009a12.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 10:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717608180; x=1718212980; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iPN2ZXnJH67ylasvW5ASBChVEwpUinMe7ale/dDDPYY=;
 b=Q/My9hHURSGBjNLv2krIBbn9hZ4BI9ajElMopQpFttHcb2Qjqkv2sg8LB1TjL43qRh
 +vbUYfcQCJrMXegoui7Q0bJZookymYWuFaBuxjgFx2PlKiUB4d5HG6htA/rX6jdRzlto
 meqKa1y7NzhjPlBJWgPKsKo7YPf23QYzUpAdWCTlbGObXP0pr77D/2yFAM3TzbExgnEA
 jTZ/C00is3ebYfMVzCR2reLnci0bJX3yK3h2fVgQaE7Ma8ECkl2DL5SzK7iL2qL5lRlB
 lYmOIpSrP/5Mc1t7FC9EjPc09yTgERtSmHfd5/vPuH0f5lcnJCazCLQDQ8nrCCsPnCVy
 b6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717608180; x=1718212980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iPN2ZXnJH67ylasvW5ASBChVEwpUinMe7ale/dDDPYY=;
 b=DbqmY4DhHdxpLZBr9vrr8kZseErCcS4s6WsQygmnnX5g9kIOUzde40n2A3E4if1CfL
 3g8OUTovaKv/sIHvnmBiW3oF7xMzXIfVDlaz3/pblK/O0UmwBWXhGvdRN8pKnJROu77x
 5h0CX5X16VppK3tMwdRqGspwzmAnDcH1y/t0aZJ9bl/7rKfrMBkBp85kl1lFZ5AAF0L1
 F04+wzErLkoBmHbfsAQ4BAlVbHyeKobEuwPbumdc3jlGPzrXvKQhrCp5onjYuUTlfuov
 mFSYqIl0lUOzpKxwGUuapDZTgNxNylVWek9UKA5KD1VpZdz0Xhz+XbmBrhAo5Hnvu0n9
 Zn3w==
X-Gm-Message-State: AOJu0YyP9Q6gFyhf1+QF2xApt/1PqIbGI/KB/qZTpZV+6xr1GTjvddfP
 Ok9HdYbfRjZtP5IUF0pac51lWKW+odQ34ALO02cDiULxUvnuXZhQD0aMSQlo8/NXwjCBDJu9cU7
 Y
X-Google-Smtp-Source: AGHT+IHEOo0M1Q2UADoyDTzWo/CC0zMgHaBgVNHevYKa0XyA4EBjBGJgIeq0w36TzEpMCvt27VWMDQ==
X-Received: by 2002:a17:90a:aa95:b0:2bd:dce4:8f90 with SMTP id
 98e67ed59e1d1-2c27db00325mr3020735a91.6.1717608179984; 
 Wed, 05 Jun 2024 10:22:59 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c28066d511sm1720915a91.9.2024.06.05.10.22.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 10:22:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/38] target/sparc: Fix helper_fmul8ulx16
Date: Wed,  5 Jun 2024 10:22:20 -0700
Message-Id: <20240605172253.356302-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605172253.356302-1-richard.henderson@linaro.org>
References: <20240605172253.356302-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

This operation returns the high 16 bits of a 24-bit multiply
that has been sign-extended to 32 bits.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/vis_helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/sparc/vis_helper.c b/target/sparc/vis_helper.c
index f46fcf1f6a..41312deda4 100644
--- a/target/sparc/vis_helper.c
+++ b/target/sparc/vis_helper.c
@@ -174,10 +174,10 @@ uint64_t helper_fmul8ulx16(uint64_t src1, uint64_t src2)
     s.ll = src1;
     d.ll = src2;
 
-    d.VIS_W64(0) = do_ms16b(s.VIS_B64(0), d.VIS_SW64(0));
-    d.VIS_W64(1) = do_ms16b(s.VIS_B64(2), d.VIS_SW64(1));
-    d.VIS_W64(2) = do_ms16b(s.VIS_B64(4), d.VIS_SW64(2));
-    d.VIS_W64(3) = do_ms16b(s.VIS_B64(6), d.VIS_SW64(3));
+    d.VIS_W64(0) = (s.VIS_B64(0) * d.VIS_SW64(0) + 0x8000) >> 16;
+    d.VIS_W64(1) = (s.VIS_B64(2) * d.VIS_SW64(1) + 0x8000) >> 16;
+    d.VIS_W64(2) = (s.VIS_B64(4) * d.VIS_SW64(2) + 0x8000) >> 16;
+    d.VIS_W64(3) = (s.VIS_B64(6) * d.VIS_SW64(3) + 0x8000) >> 16;
 
     return d.ll;
 }
-- 
2.34.1


