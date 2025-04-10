Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E37C369A6
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 12:27:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2qzg-0008NG-Ch; Thu, 10 Apr 2025 08:26:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1u2qzb-0008ES-E2
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 08:26:52 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1u2qzZ-0000bc-Bh
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 08:26:51 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ac2af2f15d1so102604866b.1
 for <qemu-devel@nongnu.org>; Thu, 10 Apr 2025 05:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744288006; x=1744892806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Y64k9s1g2R/VHp69RNkFoPp5VXosIY2NW5fvTyv1qvQ=;
 b=tAo+hF5zgjoJs5NHLmDllK4EyaHFiFpvj/tuSSAn+s/U9uQqVU/uZm+byKsCG6cfMJ
 kl28X5vLFm6NzZ1hGWypYoW6gIzXd5ZtsrKMzUkYQNK79dx3tZZHrHIAFLWXmikkWZ4F
 mIr4JPNEXrT/2xrswCxqlDfKD1b+XO2JqeOYupAVjKAkjHafCb6B+3o6Q/K4I0Y1rJDA
 2QhRamDuN8swAeLVMnqVayFbiINYnrYlUrCK4mqu+6VXy374so1AuFJmZXBe+FCBd1YL
 Yqx0Qbj46mRveX+mvgJkleiXH8FKCiPLR5axAodzX+Wpt7RdSj4yt7+buJKpBJd3TEBm
 eOLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744288006; x=1744892806;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y64k9s1g2R/VHp69RNkFoPp5VXosIY2NW5fvTyv1qvQ=;
 b=iTLct/t6P5chve8GxhHVFRTbQgPKe+Vad/GykfixDRbD1TuJgyaU9FAsLaueZ763He
 YcMw6SHcHhGxhtdpUGN9agATMKBmHO+4qXEeqnLgIlui7zLt6Wl98lizr31WXkY3/oSL
 xIJXHJhH8537KeHRyRDFal+3rkPwi/yxhYA5PbZc0xUZTfigTjjr00EK551Pzw07g3Lo
 PMZxseiNOn2BYO/8euc60mhRpn52Pg9Pnyf8oqZks9h3/nlB3Cb7PfvCfHxh+I+L8XoL
 R3dRlYlvGiiF6sRO5Ufdph1pOdUaF8cWKq3p3mdboakX0aq5ZwQ2GeQKXLPyhL8LPUZb
 MqtA==
X-Gm-Message-State: AOJu0YzuAOtJYkZ6+nwUANNLy4i1u+YrIHN4UjAdn+CXcrwggqwhPemF
 rQHcrDu3+UkQVBsV/nsgHdrINE3NEfuzPl7tC5DE/hWvz92bHsvMogpuA9EEdpdUAIuyB/RZmiT
 hSJE=
X-Gm-Gg: ASbGnctr2F6a2bkcJsyI5mr9Jh8VDkXvtAh8C6qD5riM/k6rCjZf8cnPZaQEOq8yU4Z
 Ig70YwVKWzBlbi/MspXLEMexQ1gOsYML6LyaOW0eAku2k6RavujSGGk8KnRp9IUrXt2C6JFdcGQ
 jW9Aw108Q31bK5MZzy/MgjXL/WMhcT18LyzLByDbvjhPGt16Gp+sVcMeA47tZpeBZSWcbm92RRI
 z0RJRjmAOT/35GfIJbDOFar3napiuKxADHezRRxfRQLWUY7ULCw2Y8rEySyLUA42ApFFk8PBDxl
 w6ZSl85ZVQ+qCfM1ZHhUFhMYbqX3C7yKzwk+enJ1Hhf9Z0BWGEopaviZjA8aamn1ymTfAIAbY6y
 pWIsg2+Z9pAT2+HXNFpUYCG8=
X-Google-Smtp-Source: AGHT+IEb+ROmonG1DJbG8uI0/igD7KOiFject8vl2tbFH0tDEjRBHrFybXX2ebmTahBpCjGrn0isGQ==
X-Received: by 2002:a17:907:3c93:b0:ac2:49de:3969 with SMTP id
 a640c23a62f3a-acabd4d2ee7mr235353166b.47.1744288006143; 
 Thu, 10 Apr 2025 05:26:46 -0700 (PDT)
Received: from localhost.localdomain (adsl-194.109.242.94.tellas.gr.
 [109.242.94.194]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acaa1be98c9sm271794866b.65.2025.04.10.05.26.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 05:26:45 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 0/3] virtio-gpu: fix blob unmapping sequence
Date: Thu, 10 Apr 2025 15:26:35 +0300
Message-ID: <20250410122643.1747913-1-manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

A hang was observed when running a small kernel that exercised VIRTIO 
GPU under TCG. This is an edge-case and won't happen under typical 
conditions.

When unmapping a blob object, its MemoryRegion's freeing is deferred to 
the RCU thread. The hang's cause was determined to be a busy main loop 
not allowing for the RCU thread to run because the kernel did not setup 
any timers or had any interrupts on the way. While fixing the RCU thread 
to run even if the guest CPU spins is a solution, it's easier to fix the 
reason why the MemoryRegion isn't freed from the main loop instead.

While at it, also restructure the 3 stage cleanup to immediately respond 
to the guest if the MR happened to have had no other reference.

PS: The hang can be reproduced by running this unikernel with TCG 

https://git.codelinaro.org/manos.pitsidianakis/virtio-tests/-/tree/8c0ebe9395827e24aa5711186d499bf5de87cf63/virtio-test-suite

v1 to v2:
  - Add patch by Alex to prevent double-free when FlatView is destroyed 
    from RCU thread.

Alex Bennée (1):
  hw/display: re-arrange memory region tracking

Manos Pitsidianakis (2):
  virtio-gpu: fix hang under TCG when unmapping blob
  virtio-gpu: refactor async blob unmapping

 include/exec/memory.h         |  1 +
 hw/display/virtio-gpu-virgl.c | 60 ++++++++++++++++++++---------------
 2 files changed, 35 insertions(+), 26 deletions(-)


base-commit: 56c6e249b6988c1b6edc2dd34ebb0f1e570a1365
-- 
γαῖα πυρί μιχθήτω


