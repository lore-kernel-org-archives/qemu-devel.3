Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A030FC25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 14:37:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4Lt5-0003MF-HK; Tue, 07 May 2024 10:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s4Lsh-0003Aw-77
 for qemu-devel@nongnu.org; Tue, 07 May 2024 10:33:29 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s4LsX-0001Lz-8b
 for qemu-devel@nongnu.org; Tue, 07 May 2024 10:33:22 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1e4bf0b3e06so28302425ad.1
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 07:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715092390; x=1715697190; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=6Ivh+iW2TL4bdoBvztplsBVgAB2JEa9mEigo6dPoxo8=;
 b=ZLN2KNW/U8cuhg7jU1kWu2gepzkkBeyb+l/izm8mhdCCYb/tslpxbkNDT/SsrgodCu
 AQRGnLGzZqCLAPROBNQePY/H98wYoK0UAzTfW9QgdpRUQE089BXB81Rg6z1XkPIJ3CSl
 xxqA8r6c18ltMIrZ7ZO0fIOTpWAQPiAS66OGQZTUzxNKxmXBXDhGH7F4tL3gAfZD/CFt
 EmJ3kMexEG0l/akzCV7AAV7/AwQ1E8j2HJJ9yftDr59SZMNMFL8OKZ+8lo0wwtyIYwzc
 W4KVW2VEzgs3SjSWD63K6evayYXUM3M1aNvralfZS9B0Rd13Z8VtCz6OHbM2GEO23n7M
 sAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715092390; x=1715697190;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6Ivh+iW2TL4bdoBvztplsBVgAB2JEa9mEigo6dPoxo8=;
 b=rkdZL2rnrjgaDXYMM8hJCHPRQwbrJQfYF5p8Alee68wqeWVT99AZciEtT1OwspOZQm
 zNXTTvd3sljoxSxRRh4u9pM87vq/M0ayd4fdrShspmn29PGbfYeXxOhI/Q4KZhGDsIDo
 3rXBSjaTQ+InPZkTmr15UyQoxSw0cSrEZ9rE5ylYUqp/BpSwLY2SWSGU9MVZOEciF8n1
 EOszvuonrdlmY120S4KaVpuB0qMtLCnSJwpEr3VfuVzAvRQo765PeSMdD3XsbHG1ZGNM
 IIf/GiYa2t4nbsUK9Vfjq1ZLxnYkU8MUYb3UIPjJLhowhxPr9su6DzPQdIApqO4XRI+P
 SY2A==
X-Gm-Message-State: AOJu0Yw0oAX3Zx420vHh0Uq6N1VuGV/6NL5W06z2/W1SzMPQWGKCQZEe
 yHRGuzorK+s5Tr+V5ONG8W5w9r5oUocD4+6K5i70KUQd+wku1fJtRzq5ynFfnwtQm/2iTjxCf7T
 J
X-Google-Smtp-Source: AGHT+IHJsGsHagyPwk3i+w/EQ3MjvfqBw9ho37WEqbEwQ62h+NfB43MZbiehso5VcxgPmDcl8npgVw==
X-Received: by 2002:a17:902:ce87:b0:1e0:983c:d686 with SMTP id
 f7-20020a170902ce8700b001e0983cd686mr19566459plg.20.1715092390527; 
 Tue, 07 May 2024 07:33:10 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a170902780300b001ed2d84c1cbsm8690097pll.193.2024.05.07.07.33.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 07:33:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/9] tcg + misc patch queue
Date: Tue,  7 May 2024 07:33:00 -0700
Message-Id: <20240507143309.5528-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The following changes since commit d4c453f64824bbeec56c7e72aa83019a7db70d9e:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-05-06 08:34:34 -0700)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20240507

for you to fetch changes up to f578b66e8c70ddea71d44db6e2c7abbcd757d684:

  gitlab: Streamline ubuntu-22.04-s390x (2024-05-06 23:40:36 -0700)

----------------------------------------------------------------
tcg: Add write_aofs to GVecGen3i
tcg/i386: Simplify immediate 8-bit logical vector shifts
tcg/i386: Optimize setcond of TST{EQ,NE} with 0xffffffff
tcg/optimize: Optimize setcond with zmask
accel/tcg: Introduce CF_BP_PAGE
target/sh4: Update DisasContextBase.insn_start
gitlab: Drop --static from s390x linux-user build
gitlab: Streamline ubuntu-22.04-s390x

----------------------------------------------------------------
Richard Henderson (9):
      tcg: Add write_aofs to GVecGen3i
      tcg/i386: Simplify immediate 8-bit logical vector shifts
      tcg/i386: Optimize setcond of TST{EQ,NE} with 0xffffffff
      tcg/optimize: Optimize setcond with zmask
      accel/tcg: Introduce CF_BP_PAGE
      target/sh4: Update DisasContextBase.insn_start
      gitlab: Drop --disable-libssh from ubuntu-22.04-s390x.yml
      gitlab: Drop --static from s390x linux-user build
      gitlab: Streamline ubuntu-22.04-s390x

 include/exec/translation-block.h                   |   1 +
 include/tcg/tcg-op-gvec-common.h                   |   2 +
 accel/tcg/cpu-exec.c                               |   2 +-
 target/sh4/translate.c                             |   1 +
 tcg/optimize.c                                     | 110 +++++++++++++++++++++
 tcg/tcg-op-gvec.c                                  |  30 ++++--
 tcg/i386/tcg-target.c.inc                          |  78 ++++++---------
 .gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml |  16 +--
 8 files changed, 174 insertions(+), 66 deletions(-)

