Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66DFACF042C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 22:51:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syJ2Z-0000Tr-A3; Tue, 08 Oct 2024 18:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1syJ2W-0000P2-Bg
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 18:50:48 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1syJ2R-000417-6F
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 18:50:48 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-20b90984971so63662795ad.3
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 15:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728427840; x=1729032640;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FLg+s4rzz0OrmKj4UlRhD/WmbjGBPBMHWdNHXxUKfXo=;
 b=d+Zd1zrpeB3JdrPG0nsnd0YC7iuT+fVECWv2Sm7uZtWH/TStHMQYLJ0bhwTLXQ4syW
 qc4sRHriCjJNJsFooX5Y46+wCfw0uax44JcxmbwXfHQFwJrm1ssgNaUIyyyKkQFmJdyS
 OIjY3XBymuPasDQRR4vNGnKvv/l5wqSmfBTvT7BN6PSS2EcF79GC8ZR/uVbWKq2DKV9/
 u0CPR4rObpuKJmJIliCRwo3DaH1I99SvByWAkZGaVSs/HbBwNbPyzuiseUi5/xMHCfug
 adtITCc209oMDqUqw4kYsWj+tHsHlWmTnLSY+isg+0vvEawi9tMW6ctiSQIsV6qXA7TN
 XgyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728427840; x=1729032640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FLg+s4rzz0OrmKj4UlRhD/WmbjGBPBMHWdNHXxUKfXo=;
 b=gMlT9HUBBUWmw+in8WNI60WFGyH0pzs7j+wsOuifLs2YqI8LzK903JzjXW82JqNwmu
 ZqjOXdkUa+Q0QkY8oDLh0YtNOOupaQaAL4YZ2HplZdRy84o7FwbOX5LJojV7rSCmBa9f
 pYoLLC9Bp7GesQEse05WrT7MAIxnmzX45mZZFfraML8fXpdaRySfi+SjPOCeAHdBKZS8
 3m7jskjJ7UU70N7kjqRq/pbt5S6hkar8eOvVCsxTpfFjlpnvGQiLefQRhNQXD4loAANk
 IJrWzIdzVlcdygOjxGUHBr23YsWK3FdG1TorOB3yUQp73aTNsEJK846vUksWgTU6Bj4n
 yKQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXJzlFafRnOlLZ9C474q7FCsFklFH0/F17BASA7r1+46s8oxtY7EfjHxVyfJdglBfrL0KXhiLmOeON@nongnu.org
X-Gm-Message-State: AOJu0YzPQ8jLECrk2echpJSwY+nsrP0vT5AVOUNAwjvxUNP9Qu3vcwPE
 Gi6CeFjgkPqiXZBqSVJf1WByzJMLdMHD0Rs1jEzpQI5eZz11a+gnZ/r0PnoeZVg=
X-Google-Smtp-Source: AGHT+IEWo+OwTN8wk7H9DcHXvWRcdB4QQeyPRO3aE5PjZR+n5lZst3NZv8jmD1LxE+0q2mwd+D+CAg==
X-Received: by 2002:a17:902:d3c1:b0:20b:57f0:b378 with SMTP id
 d9443c01a7336-20c63791688mr5523685ad.50.1728427839796; 
 Tue, 08 Oct 2024 15:50:39 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c138af962sm60006105ad.26.2024.10.08.15.50.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 15:50:39 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, kito.cheng@sifive.com,
 Deepak Gupta <debug@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v16 20/20] target/riscv: Expose zicfiss extension as a cpu
 property
Date: Tue,  8 Oct 2024 15:50:10 -0700
Message-ID: <20241008225010.1861630-21-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241008225010.1861630-1-debug@rivosinc.com>
References: <20241008225010.1861630-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x633.google.com
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

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ac5ad6fa9d..0751d08d85 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1473,6 +1473,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("smcntrpmf", ext_smcntrpmf, false),
     MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
     MULTI_EXT_CFG_BOOL("zicfilp", ext_zicfilp, false),
+    MULTI_EXT_CFG_BOOL("zicfiss", ext_zicfiss, false),
     MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
     MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
     MULTI_EXT_CFG_BOOL("zihintpause", ext_zihintpause, true),
-- 
2.45.0


