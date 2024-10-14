Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B66D16243
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 11:23:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0JA4-0006cb-Nc; Mon, 14 Oct 2024 07:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1t0JA0-0006bY-HJ
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 07:22:48 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1t0J9v-0002eT-Lm
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 07:22:48 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-37d533b5412so1864752f8f.2
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 04:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728904962; x=1729509762;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bs7mZGN57rwci/6WEq54tvzRiLyMQyqdFuQO/8gdTa8=;
 b=RWhftqtB9oAvT9jZRb7xvY/GV7SHXgfef4vqz0djLZDcWJhfBO7fjsJT4XSVFM//kf
 832teysxPLmoLDlmXwfuf+1JtBvo0YHICDhqJyLCTPlg/V3fbSZfF9oMGXhrg/1cdaOE
 YGWE0Kigp3X25LX/SxLBezKidBDW1dxQOZ+iNcjyTtVBZrGi2tNoAVuPuIuhArnO8oaS
 KIVqBuHBZT6DPMrcz4JImV8Vy9+zufWX2dNGCbOdG6cvTrTkQDMKFqJsOjpQmyufu/nq
 na2+DxZuuwK+nwtBxBAl5lhDayJS7FKItRjK8u9WmJ2P2hteV3UXGYP8AmL3jcB2OQrZ
 A08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728904962; x=1729509762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bs7mZGN57rwci/6WEq54tvzRiLyMQyqdFuQO/8gdTa8=;
 b=v5eXDyOgPGa/6lobkE5BqQ/XsJId5l8o30qyaCYiWRmDQLCN2re1J3K6g4VKKsl9oa
 2ADDK7+61P0Nq0qJI1FZrGGDuE5YN5axOrOGsemh4qN/yCcoZkqoLfLa/0oZeJjlPP4S
 igHRb6FRLXqLIV3qy9/wfA36XZcoL8MGinBiTYyEUaXs2IE+pSJTDsKwxtbxapvet0dj
 3bh+DvjFyMBa8W5dKfLOeVAUmmTrjtZICVu0wyJsBZbPbHfPNgT/HK/T8S4AT0ZisRhI
 rGDy/5LVYC88PYw+UZYcVKgDd8NqxWtqbKfrN0F83ULjsymKSMYfxzs95HoDswlcabxv
 R6xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWT+31SBxhKX4THabSaFdQhjjJw8TcCIfI9BKNMOBspCGyn4GHr4aYeGO2PLyiotBExo58B0t+d7mQ2@nongnu.org
X-Gm-Message-State: AOJu0YxY9rG/7YWTBjw62SwBCOI7ws5QUHHoMzLhR+n/awPLMH8RQwjz
 KAyCqX/vNSg99MGaYmKtrQRHcJKwafJcQZUEM4aC8NP6lFjHu7rtM2wX6M4JrAA=
X-Google-Smtp-Source: AGHT+IHVoszcHRSpck+Vri3JaU0HLDDM5ZRCPiA1+qUluW2CjBagWVV2HSZXY+QuixQzSBygvKPfIQ==
X-Received: by 2002:adf:e681:0:b0:37d:4aa5:eae5 with SMTP id
 ffacd0b85a97d-37d5531bc58mr7200031f8f.55.1728904961909; 
 Mon, 14 Oct 2024 04:22:41 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d4b6bd382sm11117303f8f.43.2024.10.14.04.22.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 04:22:41 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Ved Shanbhogue <ved@rivosinc.com>, Atish Patra <atishp@rivosinc.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v3 8/8] target/riscv: Add Smdbltrp ISA extension enable switch
Date: Mon, 14 Oct 2024 13:22:18 +0200
Message-ID: <20241014112225.90297-9-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241014112225.90297-1-cleger@rivosinc.com>
References: <20241014112225.90297-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=cleger@rivosinc.com; helo=mail-wr1-x436.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add the switch to enable the Smdbltrp ISA extension.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 target/riscv/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 53e3bb6b37..6e22bfe37d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -183,6 +183,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
     ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
+    ISA_EXT_DATA_ENTRY(smdbltrp, PRIV_VERSION_1_13_0, ext_smdbltrp),
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
     ISA_EXT_DATA_ENTRY(smrnmi, PRIV_VERSION_1_12_0, ext_smrnmi),
     ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
@@ -1492,6 +1493,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("sstc", ext_sstc, true),
 
     MULTI_EXT_CFG_BOOL("smaia", ext_smaia, false),
+    MULTI_EXT_CFG_BOOL("smdbltrp", ext_smdbltrp, false),
     MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
     MULTI_EXT_CFG_BOOL("smrnmi", ext_smrnmi, false),
     MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
-- 
2.45.2


