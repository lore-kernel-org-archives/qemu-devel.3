Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40099FC619B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 15:14:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stTiL-0007Ay-1c; Wed, 25 Sep 2024 11:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1stTiJ-00077q-0d
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 11:13:59 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1stTiH-0000zF-GT
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 11:13:58 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a93a1cda54dso139402566b.2
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 08:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=embecosm.com; s=google; t=1727277236; x=1727882036; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GKy/CyRSVUaBnXxnNttl6Oo4OhYAsB0CU8IGh0o82+4=;
 b=F39FhoWIOMGB8gyO3Q07LybEG4UXHhBemZ9hBj9NLpBoHlGIC6ZCwd/6WWYM6DJPtV
 QkcC3kWEwgvNJiyFvEJH8ln8+Am+CVEZPZ2GRFYgbv1BXOFrGPsDyHrC9HVVRemr0yRw
 RTS/aAjtLQ3du8LFnLPPfOrwfvNqa3uPg3zpsmu3B1X8vez1mJeXCQ9TSxXJCFz/Ap9S
 EICr0FzFrr9eebZESIttGPI98r5L1C5zY+nE0UU9BHseOYgZxMD3UUKYvkrlP+RGZLZq
 vBPu8WrI2NCHGLgTB1bJ/i75QTdpa+UpyOb34qWp2jxNaZqlf7TOE3s4RzJj/tKrAOtK
 yHkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727277236; x=1727882036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GKy/CyRSVUaBnXxnNttl6Oo4OhYAsB0CU8IGh0o82+4=;
 b=moXKja0mq1+1exxC1DrY5GYaug6Rpx81YAcRlaUoqchs7zRQJAGTRXbmkqjgU7Scj8
 r3RN45dxteYZWGJCJujt1LZF9Ega7IFubMjM8F2ZOfAPycL9NltAMgmuVxGn95fGabl6
 3+rqQCeL7wNe3ttQp/XBDGwdzcPX72sTLf9by0Cu8nA3PGMNP1FsnzcxsQ6FqaQ5+/WU
 yE+KlR0TStCPUsP5Pf+0LXP2NWgsTa1kbrRr2uo3aDcCdrBHIf0XeVr3IQDtI8KCvtDH
 kZHi+lJwnYYvWMy0xQfTpLcm8AsSEzfL4S4rEpWh2etkFOw7hFoTe+Cs1LFsiC9qbdg5
 QaBw==
X-Gm-Message-State: AOJu0YyNQ97cSkJ4Dl2q910IMkoTJyhCv+/XRp31eWmsPBxq8/HR57Ky
 ibBzBRBBgwFFsFkGE/4aGzyECrPkGs4i8VF1omxFhGCit5WHZndh7s9HhtZRklj8lzu2NYqd0zm
 QRLU=
X-Google-Smtp-Source: AGHT+IFX8vn/C3P/lrh4VPZgXIMuYD9h7SXvjQbxfcVgmrwNly3VMwsOtUlOfYUPXWD2u3I09DJo5w==
X-Received: by 2002:a17:907:970e:b0:a8d:6073:2c13 with SMTP id
 a640c23a62f3a-a93a03b6d6cmr299279466b.33.1727277235574; 
 Wed, 25 Sep 2024 08:13:55 -0700 (PDT)
Received: from paolo-laptop-amd.sou.embecosm-corp.com ([212.69.42.53])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9393138af7sm217158566b.206.2024.09.25.08.13.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 08:13:55 -0700 (PDT)
From: Paolo Savini <paolo.savini@embecosm.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Paolo Savini <paolo.savini@embecosm.com>,
 Richard Handerson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, Nathan Egge <negge@google.com>,
 Max Chou <max.chou@sifive.com>
Subject: [RFC 1/1] target/riscv: use a simplified loop to emulate rvv
 loads/stores only in user mode.
Date: Wed, 25 Sep 2024 16:13:30 +0100
Message-ID: <20240925151330.50215-2-paolo.savini@embecosm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925151330.50215-1-paolo.savini@embecosm.com>
References: <20240925151330.50215-1-paolo.savini@embecosm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=paolo.savini@embecosm.com; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The simplified emulation of vector loads and stores that bypasses the memory
probing in the vext_ldst_us helper function seem to benefit only the user mode.
We therefore limit this approach to the user mode configuration.

Signed-off-by: Paolo Savini <paolo.savini@embecosm.com>
---
 target/riscv/vector_helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 9026661573..08f71abc22 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -648,6 +648,7 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
 
     VSTART_CHECK_EARLY_EXIT(env);
 
+#ifdef CONFIG_USER_ONLY
     /* For data sizes <= 64 bits and for LMUL=1 with VLEN=128 bits we get a
      * better performance by doing a simple simulation of the load/store
      * without the overhead of prodding the host RAM */
@@ -692,7 +693,7 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
         vext_set_tail_elems_1s(evl, vd, desc, nf, esz, max_elems);
         return;
     }
-
+#endif
 
     vext_cont_ldst_elements(&info, base, env->vreg, env->vstart, evl, desc,
                             log2_esz, false);
-- 
2.34.1


