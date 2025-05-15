Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 167D9C3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 10:41:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVol-0007Bd-CK; Thu, 15 May 2025 06:27:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnT-0005HW-Cr
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:44 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnP-0008Dk-6g
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:38 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a0af41faa5so374083f8f.2
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304793; x=1747909593; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vTExqP4h4Cvg1NtSNAreZAjgeupAmJ+GTzTCQP5jTDg=;
 b=PdwIMsZyA8ZBdZSJDTQVlP0TYEWUDoEfCWXPbpHBVHZmbfQB+ZdEFSr3KOlInn/pju
 Zx7VC1cMPW2L471jOKjnbeGvdSZL1YDabvDalXTF8yL4m+GmzfH+qISpBMiqVY45k53g
 JwcZyG4xGSad1QcDGAVED7R697d7VHgENTlTgoXAH/4+tRO3e4OPUTvMz5JnFM6BooR4
 G+pDzNCij3KH93Mht1fmL4vUIHowJvGIKs7GRaJfAf9NtUqhSxNagPutxdhjiWi2z+lV
 Xbz4KyQ+NrpA29UC32aVOjJKwIozZSFaGfAf2eJcWSNAjwSXq+EULbpf8nzZB6UZLC48
 GZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304793; x=1747909593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vTExqP4h4Cvg1NtSNAreZAjgeupAmJ+GTzTCQP5jTDg=;
 b=TST4lJrKIrxCpsgylr071givXAblo5dEdllcIZKyVWV4FyGRUI+3zgj6kVPct8x+8F
 ggQ7acLEERBTN+vi5Jr9WyyChHORYt3C31fAmcXWhLSGOHRRI28OS3pRk+b1WMlAbRvI
 A/awx+V8EqNQ6x6O0rNBOgYYEpstLBX5jZI1RT2OdCM7QcGxgW9c0ko4E77h8RIH9xwJ
 nqroIbRgEoiLFZ3esbWA1jahJLan1RaMt4VPtJ0KCdHgwo4wkhm51X1NT5Z2Ka/R3fxv
 b5cRfUExD3IWgHweeG+TXdtG7R+BNO7yxgK9DRHHJhpbKU8vPRYp1Sw/faLCd19vD2j6
 GlSw==
X-Gm-Message-State: AOJu0YyTSJrWxI9oszPBFIiV2P4p/NJs4+yE0bf0Obv47HvpUNigQ8Wh
 ATwbSPN2SbijgzIMrtY6sKso32CXB+yONYD97UGncr52J49f1qU+4UCasNr1vFqEMq/CCLba7UC
 Q5Ac=
X-Gm-Gg: ASbGncsDIHBBm3keU2gAz9zFGY6SpRfy6ABlbP/MnO//LiFEZpPVov99uOUirX4BFMY
 onFOQGP2PQ62Y2afKMaB8+ICLeWzJkrsFOqdCvmLRMrrP/5gZpC4p2jTysxPNDZNynHyk7HPr+T
 NCqW4XlZPHzax09v6kF8mmQRPK3wgvYrYXoTRlVijBJkExJLn13oa682xols9y/9PkNDTKbX/FX
 UmGffKeTs/d1FreIw17g34erNmEboYkXONmsoqnz4oYgH41G4W9boZHo6zHIzhroAP63IpCVRpW
 u2fjaOWMb+55rMei2VjdpESAlIO+B1cIKmL9AOvFpmcqx14x1T7BURGbcA==
X-Google-Smtp-Source: AGHT+IHHQRK2o/cyBeyIViUemL9Px2JeaQ5y6aP19ut3GSf/pQv3yBjNaFIk6HvL7lxl9UP7nBS12g==
X-Received: by 2002:a05:6000:2511:b0:3a0:b5db:559a with SMTP id
 ffacd0b85a97d-3a3537b3d4amr1958947f8f.59.1747304793004; 
 Thu, 15 May 2025 03:26:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.26.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:26:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/58] target/arm/vfp_fpscr: compile file twice (user, system)
Date: Thu, 15 May 2025 11:25:22 +0100
Message-ID: <20250515102546.2149601-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515102546.2149601-1-peter.maydell@linaro.org>
References: <20250515102546.2149601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250512180502.2395029-25-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index c8c80c3f969..06d479570e2 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -2,7 +2,6 @@ arm_ss = ss.source_set()
 arm_common_ss = ss.source_set()
 arm_ss.add(files(
   'gdbstub.c',
-  'vfp_fpscr.c',
 ))
 arm_ss.add(zlib)
 
@@ -32,6 +31,7 @@ arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files(
 arm_user_ss.add(files(
   'debug_helper.c',
   'helper.c',
+  'vfp_fpscr.c',
 ))
 
 arm_common_system_ss.add(files('cpu.c'), capstone)
@@ -40,6 +40,7 @@ arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
 arm_common_system_ss.add(files(
   'debug_helper.c',
   'helper.c',
+  'vfp_fpscr.c',
 ))
 
 subdir('hvf')
-- 
2.43.0


