Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC6A6E7718A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 11:43:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNsQA-0007Wv-0E; Wed, 18 Dec 2024 06:40:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tNsQ3-0007Vn-7l
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:40:48 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tNsQ1-0007tW-FS
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:40:47 -0500
Received: by mail-pl1-x643.google.com with SMTP id
 d9443c01a7336-2156e078563so47720235ad.2
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 03:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1734522043; x=1735126843; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0sZx4bsV4dy12hFPD+xtASoRcc3ak9I4hAiV86M8IqQ=;
 b=PBhI2oUd0oVmYa8CVhdO5EiGHrpcsmtEd5kVaptBCtsdAKThNUXJYW8rMwtMYkKFki
 fQDXfryJwGbcuPISeQVbs3/jmbYZeElDtFYh6dbTfP6iPuoCp7ZhxrGFF2gIUGI5EMhh
 oK4LSi1fxo/yMlVqGhwJ2KqkAtL0qOPLnt5FyGBpTd3NXqn0p+HJL6nN8aCgchSy8YC2
 MXCUaIMdmS5QNRtNemho2ZmbG70XtWBjHk6WJOvLinetE+g92Whn283evJRNpmA7Ymh8
 zczm5tbKDdw3eaPgHtBWZQXCojQdMzKyrgnM6RpYUubpTEuOwT7BPP46V8KHaCHJ/Drq
 dSvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734522043; x=1735126843;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0sZx4bsV4dy12hFPD+xtASoRcc3ak9I4hAiV86M8IqQ=;
 b=YHhYSCJe0SWOYrOOdho5uVOPqaS+9bAyv0Prshi1mzKTRRZRpIE5cNrjV7b7mE/FSH
 wcWSV6HYThMEvt5v3myv0twc01tVzznlbauZhAu66rBGOwxGYs1bKnM4BA0ewOl8CHe1
 ufdCIehXEvrIGcDmbT115GT6TIV5r7YYnOXl9C3lolCPnocbXO/TqunqINLqfPMW4f0O
 7mK6a30LHJII5eV6tkRIiaU7DA8/w3qLZo+QgzTX2hcOEZq2GXKLbDgYDlDFMPGYVFwI
 BwM1+KrYR9+f+kLoqVavogC4LakNuYfFS/VeF20QKr9J3ncMq4unmndUsFcd5uLVL0Gq
 hoJw==
X-Gm-Message-State: AOJu0YyYYwmtTEguL3H3+UG6R9wJ0JGXOL1VfCYxDKiZUac2tosRCV0L
 toAuEeAgLcQdaKblJ6SWRCPoKKiFAD5AQwUYdzUMpxooJl+BrBnkcfh0kFh3kn4+zaYGorom0Wi
 Ch+R3AA==
X-Gm-Gg: ASbGncv92yCqRStISlPttxEhjRX8G6KVDRJCrEcg/36yK8mxVAvgX/oeB6vDfn5nvo3
 8rxIOTjZoAfJU0HYlmEYxXfaQM4x3RnP72y8pgoCzzeeL6/iitPObtUSzwk5/DDd5ZNElHQl1/7
 6TdMqZU9ZP5ssHWYSdZcizlBvtEEvhAJiDljt8PaZOW0w441GKQnqX4jh7ZKgFf2iCfjGXsjqWh
 E3mjTZHZj5hcI9wBRO8qV4sdWPp7Ds1qG0fQ/zEzM0fj0bbB+KSaSXz4safuGZ7QiS16INcqQCT
 QQ==
X-Google-Smtp-Source: AGHT+IF4ww3OMXtaaWz/r4J6JyWGMPkhaklW4PtNJQ2sLVZfbrTaEnby34GsiRK68R9Z3+zHBvjj0Q==
X-Received: by 2002:a17:903:94b:b0:216:7410:7e14 with SMTP id
 d9443c01a7336-218d7237863mr31211975ad.34.1734522043278; 
 Wed, 18 Dec 2024 03:40:43 -0800 (PST)
Received: from localhost.localdomain ([2804:7f0:bcc0:51cf:9cf:d2f2:d49e:7bd9])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1dcb447sm74462285ad.68.2024.12.18.03.40.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 03:40:42 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 0/9] target/riscv: add 'sha' support
Date: Wed, 18 Dec 2024 08:40:17 -0300
Message-ID: <20241218114026.1652352-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x643.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi,

In this version the errors with 'bios-tables-test' qtest are fixed in
each patch that ended up breaking it. The test will break every time
we're changing the default riscv,isa DT from the 'rv64' CPU.

This doesn't happen that often so for now I think we'll bite the bullet,
but if this becomes annoying we'll have to consider another solution,
e.g. use a more stable CPU for bios-tables-test.

Alistair, I'm resending all patches, including patches 1 and 2 that are
already applied in riscv-to-apply.next. Feel free to keep the tree as is
and apply just 3-9.

All patches acked/reviewed.

Changes from v1:
- patches 3,4,5,6,7,8: change bios-tables-test to match the changes in
  riscv,isa
- v1 link: https://lore.kernel.org/qemu-riscv/20241113171755.978109-1-dbarboza@ventanamicro.com/

Daniel Henrique Barboza (9):
  target/riscv/tcg: hide warn for named feats when disabling via
    priv_ver
  target/riscv: add ssstateen
  target/riscv: add shcounterenw
  target/riscv: add shvstvala
  target/riscv: add shtvala
  target/riscv: add shvstvecd
  target/riscv: add shvsatpa
  target/riscv: add shgatpa
  target/riscv/tcg: add sha

 target/riscv/cpu.c                |  10 ++++++++++
 target/riscv/cpu_cfg.h            |   2 ++
 target/riscv/tcg/tcg-cpu.c        |  30 ++++++++++++++++++++++++++----
 tests/data/acpi/riscv64/virt/RHCT | Bin 332 -> 390 bytes
 4 files changed, 38 insertions(+), 4 deletions(-)

-- 
2.47.1


