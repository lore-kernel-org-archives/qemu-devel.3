Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF89C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 03:00:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi1Qr-0002bo-Ax; Thu, 09 Jul 2026 22:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1QV-0001iC-1w
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:57:24 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1QR-00006M-Gv
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:57:18 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-c89636920a3so260450a12.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 19:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783652234; x=1784257034; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=epjIeIoo3qO8AeUMEkh0+2XLO4Va9XPOC03KmUycfEc=;
 b=H5NJ4rKNqJO6C7rxpZoOR368P2VOzbHD7GdtO2sXPME5rkgixocxafM+5zSsAF4QR7
 RRTvYEargNnq/W3O0rY3ZODvkI0dcmuZ5nn8oRDlyoXZcyxcxdrPQj5kutPr9iRF5/NG
 MEKBC3605xExIM8cFDJRCM+5/n6hPwNwwBtTw2gjpdnvvRzldv8UlP20N1qhTZcE5j+p
 dH/puzZxv6ivBrezeBqjTjRKsrH6gebKHV3sllu55LUAn6xf2DCVKQlT4OxEqvkSt1L6
 l4Fq9pTzKK/E7BTOw9PB+NAFAHFrGGLUYQkqoNnRw3TeqHkmyFNx8QJGiSSm1uo/sJES
 UdQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783652234; x=1784257034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=epjIeIoo3qO8AeUMEkh0+2XLO4Va9XPOC03KmUycfEc=;
 b=YKjf5T2IVtANWu10/Wav3ht9HLXANhrBR1NZhxtSMr8p1Kqe6lh98TL2JIMdsJcdUd
 RTLHn9WiPc46sMCf6o1OtdM8BwWWHWyrGuuH6mo89NMX9GA0TnCSUbSW3F88oRVV12jj
 ZPl22v0xetdTa51vHAB4l04NoW1+0xuWt1fb5GCeo5s/iBnv44sZQ8HoRfAtpdkmjIYv
 /gUh5KetkaU+hgT2XJJ7bvmAIzzKiADjO+6pOaR0poYnA4zbvolf64eSEUpIb/HXGkmz
 L3TkTlLrGMAf0mEiBv3KGJh5TOI+dh2qVQzB2NtPKydQaFZvk48vFAC1g57OSUxg0mJr
 7y1Q==
X-Gm-Message-State: AOJu0Yy15FeJKss/UrsVt4uKdw8RpmTLJ4JwkS16uQXbUIl+F71GxX9E
 s9jM0vlp5aIwuPiyNDj9DsN4p/YtZlbMm/WVviOvMyiCpgLcHx+pZj/7oc0EHA==
X-Gm-Gg: AfdE7cmdgzBoVg7NLlu/9/yEDPYH3ZVW/kgU1zfaERlljMwx/BT3Q/oILYEcs68YdJL
 fWhrZ8gBfsdgySrTTNBmIDcCRM5r/sEx2PvS2oaqBvUr4UzypM+MbI8aufilF8tdXDJkNU6AZgS
 xu5bcUGm8nTpaUWOWRhDMk4NqygLGX2i/SRwAWFVa/2MjS7TICHIZ8dnz4uOmVuddRuTt61iB10
 jfMjMPLMIn/NcsuouFFYOZ104kBxmBAGx4BwdpW+TlDzBTGFT4PDbI1BwgoRwu1MFUx7/87iLTT
 w6G+5oIZTSlQk/2UyghLXuPv2MohT3SgK25dpTFttQ47BjfEUx9Rarfdel7YDR4EVtL169A4FUS
 ZaexF2tXUvWkyWS1QYocA3w2aygLUbUFdpwvMCXdkVm1hu8FC0nre+ab87IJU9Jaw9ML+dBCuwo
 pg2elIccAFyJo2eluwNYTqMuNNB/mmpsM=
X-Received: by 2002:a05:6300:2288:b0:3b3:241f:66c6 with SMTP id
 adf61e73a8af0-3c0bc9562ffmr10353704637.26.1783652234107; 
 Thu, 09 Jul 2026 19:57:14 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5af6e04fcsm4576769a12.4.2026.07.09.19.57.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 19:57:13 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Zephyr Li <fritchleybohrer@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 30/40] gitlab-ci.d/crossbuilds: add riscv64 KVM-only build job
Date: Fri, 10 Jul 2026 12:55:15 +1000
Message-ID: <20260710025525.1704417-31-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710025525.1704417-1-alistair.francis@wdc.com>
References: <20260710025525.1704417-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52b.google.com
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

From: Zephyr Li <fritchleybohrer@gmail.com>

Add CI coverage for a riscv64 --disable-tcg cross build. This ensures that
RISC-V no-TCG/KVM-only builds keep working and prevents TCG-only code from
being accidentally pulled into common RISC-V sources again.

The cross_accel_build_job template enables KVM by default via
--enable-${ACCEL:-kvm}, so the extra options only need to disable TCG.

Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260703180538.3346781-25-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 .gitlab-ci.d/crossbuilds.yml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
index eaeeb533ce..a823aaaa21 100644
--- a/.gitlab-ci.d/crossbuilds.yml
+++ b/.gitlab-ci.d/crossbuilds.yml
@@ -59,6 +59,14 @@ cross-riscv64-user:
   variables:
     IMAGE: debian-riscv64-cross
 
+cross-riscv64-kvm-only:
+  extends: .cross_accel_build_job
+  needs:
+    - job: riscv64-debian-cross-container
+  variables:
+    IMAGE: debian-riscv64-cross
+    EXTRA_CONFIGURE_OPTS: --disable-tcg --without-default-features
+
 cross-s390x-system:
   extends: .cross_system_build_job
   needs:
-- 
2.54.0


