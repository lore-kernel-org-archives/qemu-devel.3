Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D5D9C04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 09:20:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1NAY-0004es-5e; Mon, 29 Apr 2024 05:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1NAU-0004dI-Fv
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 05:19:26 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1NAR-0003Fk-T6
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 05:19:26 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-343e46ec237so3604527f8f.2
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 02:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714382360; x=1714987160; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=g/ypmJsMDP6OR2hVug6pof3KoTfOSW3/JxQIlPDvPTM=;
 b=lePMoEm3zdVUzubpPRMhuP1PBu17VOemi2wIVjc5nFRn0NIladpUhke0RO7RmQ/49o
 OTvYh7ylESgNZIxk1QBVqaZMpYmoSCpZte1IMyMgqzD+vxRgsIaQ/kX6uQ5RiPM1bHAf
 18DVf4XJkyWyvVO1znDVSDDQsSakKabjbnaoSozqsuAetunrgf/CGEQ0dPh/Yc0R/Sod
 Z7+FxAFF75fp2M2BfHb8ayjeg0xht7tJjcjnRdPbsRjpdepqTIFhYLywhSuzNnDbjgi+
 iGA6AD/FN2ffkyQurRY3xIHerkR76hl0ft97NPEvwU3F4IwHpfukMlOl13efhG14G4gd
 K9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714382360; x=1714987160;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g/ypmJsMDP6OR2hVug6pof3KoTfOSW3/JxQIlPDvPTM=;
 b=qXAw9Jkv8iBd19c1JlyYSX80XgN4hqJtfXxQvbea0/LJpr/6YPgQDb0ZT6Q9u0Juou
 j1az8IDdynR53eKSYaIYDpHc5G+4YAbT+dGKpnA+f0DNIqBKGxbVSv7qikZrzE/4wFC9
 D/hoEWz7vPGjOFUPKJJZeXKCa7daKTIGnovDCkKmzaWuUSuVqe54ss1HIWhCumqx6jz6
 kCAKKf8Gm5m5rAZICysMARHuIMlZRESrjIXyPfslHYbQrnIQrLRmb18/bJsMM7Zhyxn7
 JTHbOEYOqf2Lu3k1EjPD4KR7MNBrQaE9ojVoJknC7LaYC1rjSRUcvURJAcSyyoYyFyUS
 YHyw==
X-Gm-Message-State: AOJu0Yxb4absrVsyfj91ykHfTObf3xEYWhnmrapiAyZVM57knOb+J+aK
 fet+5NK3Cn0UC5bUS68mnK25Br2/m5iZagx/46Pf6FXefIZRDbXuvl5vdkRWzg29MMvdnQLYaHH
 KdG0=
X-Google-Smtp-Source: AGHT+IEgL9ihZpUrPCSmWj7dSfOtAdozJGPHhITqw+59uQkdqtTuVxRk7wfzQhheC5mZjVlpJLY0tw==
X-Received: by 2002:adf:e512:0:b0:348:b435:273b with SMTP id
 j18-20020adfe512000000b00348b435273bmr4574393wrm.54.1714382360497; 
 Mon, 29 Apr 2024 02:19:20 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 o9-20020a5d6849000000b0034ca786b238sm5438477wrw.89.2024.04.29.02.19.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Apr 2024 02:19:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Reinoud Zandijk <reinoud@netbsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/2] accel: Fix NULL deref in NVMM / WHPX vCPU init
Date: Mon, 29 Apr 2024 11:19:16 +0200
Message-ID: <20240429091918.27429-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Fix recently introduced NULL deref in NVMM/WHPX
vCPU init() handlers.

Philippe Mathieu-Daudé (2):
  accel/whpx: Fix NULL dereference in whpx_init_vcpu()
  accel/nvmm: Fix NULL dereference in nvmm_init_vcpu()

 target/i386/nvmm/nvmm-all.c | 2 +-
 target/i386/whpx/whpx-all.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.41.0


