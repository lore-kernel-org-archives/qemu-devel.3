Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A5FDCA1012
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Sep 2025 05:21:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uulKa-0000WS-TE; Sat, 06 Sep 2025 01:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uulK9-0000MK-MD
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 01:18:54 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uulJt-0006pB-2I
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 01:18:53 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3db9641b725so2755142f8f.2
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 22:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757135910; x=1757740710; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=39nNiJA/IKE7T/FfjUB4iuqZYKXZFDWxmUchhyElphg=;
 b=aDbx/DvGHj5Nq58nWaFSsOkIaga8HSArs78P8fSD62u74sDaLcnYA63cS/tXQ9t7gO
 8foXKJ3v7k1CqGQcUVWraJLDM2xiWkbtZttqDIkIIpwE1cszzrPswTM9B/K2Y15JmwCd
 lM5ZjrBQLwtSR2d4jDMGYrbaLGUPyH4DJxzN8tc22MplxBYW5tCuzU8uJorGgGASq7vB
 hXj8K2Mur+slc4vyE694MMp8PguPiZLOd01BHdOWwIGfUWDhnTAWTHlLcxnxQgp/G0T3
 Px2BODmVY3ZdjjX+YDKov3Ji4Nbea+eruQNz0DFk6UWSUs6FUKAPC+l4N+QBB15zBy2C
 P7rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757135910; x=1757740710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=39nNiJA/IKE7T/FfjUB4iuqZYKXZFDWxmUchhyElphg=;
 b=rGdG71+grlXB253usTl8Il9lSgHVm9/dV4BfDORqybgJCl8CCgHBFepIW+XhdLVHMw
 rpINc4i66irlqwO7yrsorIeiISZiQAJkYH/kzx3a78kcbYl6Cjsya/7/ljyHoiyuQ0Cb
 ZCjp8Jr9RpkPmauEUALFMIx0aDHkZ5wh0fsXcpMRoZrBYtJ1yekfmV5BMNvXNubOZu+V
 J9xl0+irsO4WBYHlGbqMwonwvCuEQLSW4O1TKyheQ7XfAsEDEVtzDrAGj/ruvPV5ozQp
 CsisJXEN71J39hVMfQqPXKSYnZqODnfD4cqE7ATxNa81h/Y7jSZaKUrCkPXRQymeBytJ
 Qhkw==
X-Gm-Message-State: AOJu0YxXxtjj2LWjQhbWlbha4BgFg56QmX+OBxxQzli8pvI7DSfwigyw
 YTTiJT722RBgZaDr1Bl6vNCNIIldmZmbvUzveTxof6ORp89N43hITIBHXcr/g9vAW5lSPLJ+xZJ
 hsmxRRmo=
X-Gm-Gg: ASbGnctHEAuhaQ+sP1qp/lCXeAid9uEh04OYfSP9oORm18Y3a3zXrkXBQTOugi7bd6P
 +DojS2778gHrw3nkQdRQVhEXZ/IRuOTwH2i67X6bgknVPUMZqJ2GkYV2cfV7MFT4Z6kWL68Llhc
 Qdc2AdwZ+nSNsrK6EDQOklaljkRcO1yTx8ZCPlxXV9TUjE/aerodUZU2EFjlsMhC0Qi7VJr/jAw
 dRiW/0fpxVOxroYDZ3t0DjWntTqfVPCQGS3fPUer3PjnIY7IFPDNDbSF1YL7iVEuF0wrHwpXUqB
 +cE4bXHfcWi+qgRO4gAooRkbcIUS5ucd8tOAgvPE0J1k2bOKfiPoKSvWtQw16klqt54//eR8Yte
 V2gLe3CFL6Ag62xfpm2crtY2R7SccrNEQLokYVHwHeA0XZlyWtmOGXx95Dl1tzo+QPG5iXc0/
X-Google-Smtp-Source: AGHT+IFeXpSU6PbUz7BFdRqx6nB7IJQnnZzwrICjQlcuCClhdgmjSK3KQQq9RkOgYD16/npluLjaQA==
X-Received: by 2002:a05:6000:1acd:b0:3e4:f194:288f with SMTP id
 ffacd0b85a97d-3e643e09089mr605125f8f.62.1757135910317; 
 Fri, 05 Sep 2025 22:18:30 -0700 (PDT)
Received: from stoup.21wol.it (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f306c22sm441197735e9.13.2025.09.05.22.18.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 22:18:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	philmd@linaro.org
Subject: [PATCH 10/11] accel/tcg: Use EXCP_TB_FLUSH in tb_gen_code
Date: Sat,  6 Sep 2025 07:18:19 +0200
Message-ID: <20250906051820.160432-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250906051820.160432-1-richard.henderson@linaro.org>
References: <20250906051820.160432-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x436.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index d468667b0d..d7cc346414 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -288,11 +288,8 @@ TranslationBlock *tb_gen_code(CPUState *cpu, TCGTBCPUState s)
     assert_no_pages_locked();
     tb = tcg_tb_alloc(tcg_ctx);
     if (unlikely(!tb)) {
-        /* flush must be done */
-        tb_flush(cpu);
         mmap_unlock();
-        /* Make the execution loop process the flush as soon as possible.  */
-        cpu->exception_index = EXCP_INTERRUPT;
+        cpu->exception_index = EXCP_TB_FLUSH;
         cpu_loop_exit(cpu);
     }
 
-- 
2.43.0


