Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C714C3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:48:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCoQH-0000sW-1I; Wed, 07 May 2025 19:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPw-0000Fn-Hk
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:43:12 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPu-0002a0-Ij
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:43:12 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-30a93d80a80so378794a91.3
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746661389; x=1747266189; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3AGfH/it6XrbUjxeSHUy0wlg4nMt2R7aYVYgAEJcCXI=;
 b=QFY4r4wH0Du7+P9L8O96pfncP/4fVqilOPYTpUiFvC/rqdvq9MBfHA5uqLgC1U3qLG
 NuKLvMz1fqRykifBWFLsEucSy8p4OpCIJAat0kysHiMJv9QZQU8Y7qymK4p2vkOwwT8O
 gpxNx1X7m/5QhJRyOdGpepqVEBHJB1/dzFd3XZSjEq5ljhdQdyVlAXUnk2UxGyh/aCdp
 awrHBbxUb71dVkqYJJjJYriJqEbSsj91R7VAAczB8YX6uDOEbr2pK93g4/qhlYme38qg
 B7/Gdl/9AAplU1iGCTbJv0RXoSwHpERpChkaF2Y2U65BeGbqm19zNVjuwKOCSg4PpqJk
 7FUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746661389; x=1747266189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3AGfH/it6XrbUjxeSHUy0wlg4nMt2R7aYVYgAEJcCXI=;
 b=lDgq8HW3VIMr3MCotVkFNgaFSDehfKoQDrLBYrM+eCflqvFVulmDRnneEh5tFY3s0E
 wGpw81YX0RCH1hYFb3BK4uPiR04criVrUxNNBr49aL5JVDjhkA+dRWKVGGar72Xu7dld
 RmrD6XALibYnO0DWe6esWDy0F3v35+f4YgmzjlzfXS/mxwvxpXFRa8Dfep1wgoPsRUbJ
 pPVINadi7BqPbd9h6aJMtNDGd5Cr3Nkl1iiZkphI3TFcmZSLRTfx7dIIMlfHPLJXVwCn
 rTpIWNxDQofyzQuo9i3pXaJGOHnUIxLjROzTaql1yU2IPfWDDbLuzEgVYP5sqZHjCSs3
 iWiw==
X-Gm-Message-State: AOJu0YwTIQQygn6/lZm3iOp5Yv9RiraSl/AJnBEE4taDGXJsiK7ryV0t
 HoRQvnWJlnttr/tHrIVhC9j5JdLnkOf8yf+ioKH3JnP8UCKvWP23dz23zf4owwgquhikbJ1NDD4
 0BvsA6Q==
X-Gm-Gg: ASbGncvRHE6cwqpyrX7z9W6qesMQgS1ImG+1+kPt04S0o7oZKPapWiEOBcnDbaW6YYQ
 hrpjzLSzjYvPoMHiCSFyAiDH9q9KiKq1UHv9wB390KqN2GPGt51XSYQuPdPxM+DIBhec2vrl9zK
 QbonfbBYN3FZ9MGwyIRyLbjEMCvBPYFssstGWwDEPj+Nf9R0lmhcArYx/bE/QgpZbaQ4X+Lpt/T
 ucRxOLMYJdPriKwDsUzW+uHIdR2jYlQ/1MRXMTZuJegty5JqlKsem4qy0tlXK8vosonY+mvAgMs
 VpWaWPWwwG+/n25VGQiJw3NDv8FtSvP1YhG4GHC5mCw03RCjD1w=
X-Google-Smtp-Source: AGHT+IHfVFswkH2ailGEzkC8ZP8p7efGOpbhAQWb2RgZin6ra0kY9zWRj1hd1EERwyLNkO1zECZsoQ==
X-Received: by 2002:a17:90b:1d92:b0:305:2d68:8d39 with SMTP id
 98e67ed59e1d1-30aac19d869mr9690107a91.12.1746661389236; 
 Wed, 07 May 2025 16:43:09 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e815806fdsm6491325ad.17.2025.05.07.16.43.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:43:08 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, anjo@rev.ng, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 30/49] target/arm/ptw: replace target_ulong with int64_t
Date: Wed,  7 May 2025 16:42:21 -0700
Message-ID: <20250507234241.957746-31-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
References: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1032.google.com
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

sextract64 returns a signed value.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/ptw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 89979c07e5a..68ec3f5e755 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1660,7 +1660,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
     uint64_t ttbr;
     hwaddr descaddr, indexmask, indexmask_grainsize;
     uint32_t tableattrs;
-    target_ulong page_size;
+    uint64_t page_size;
     uint64_t attrs;
     int32_t stride;
     int addrsize, inputsize, outputsize;
@@ -1733,7 +1733,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
      * validation to do here.
      */
     if (inputsize < addrsize) {
-        target_ulong top_bits = sextract64(address, inputsize,
+        uint64_t top_bits = sextract64(address, inputsize,
                                            addrsize - inputsize);
         if (-top_bits != param.select) {
             /* The gap between the two regions is a Translation fault */
-- 
2.47.2


