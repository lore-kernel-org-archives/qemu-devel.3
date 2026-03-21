Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D811099B56
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2026 00:50:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3kWT-0005PB-BK; Fri, 20 Mar 2026 20:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1w3kWR-0005OZ-OV
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 20:48:59 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1w3kWQ-00024V-8q
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 20:48:59 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2b0484a6de4so10778105ad.3
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 17:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774054136; x=1774658936; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=367A7gjnidl94AwJUEeEzr/iNwJvl/tKsKW7HZ54Csk=;
 b=Vy0dQMGTssaD1BWnE/XdS7k5GQEpvxGZqSyzMce7gNWA/uG4gMTe9Is3JaBpe7cuVM
 LiT22L7wawg45oGfCm48qA+EgXZ6K/Od2zKCL7/1/P6yD0Elw2iCa6zDJ4sreKM5u7Ck
 YAPOTmNbZrmTlxWhh1kpZJPUwfszquwaL330LdeIo/x7ewZwNjI6ftwRF1FYsuSyyqNU
 MOvJD0CUlwx8n9dODKUJ2KURBmua2Mtczwqss6dp0zx7FMJObhnMzK71vcAe1b9yadvs
 RMu+wJuOkdr9gZS6WxKftMx+pWYXuQJZKKkKPZqM3rODi73qh9JI7Rc7ZmZCVmuRgKjR
 xWjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774054136; x=1774658936;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=367A7gjnidl94AwJUEeEzr/iNwJvl/tKsKW7HZ54Csk=;
 b=oQ0rvVPw19dEh4qrzXAvlqhPmXxPxypgiXL/azkA6IZFZno7GVe/TIZ0xzCg8wrpRK
 1Bsf/XBLV4iEEFymdQP1g6a93tj/hf9ts0pMe5hUd7KAK3IBF7G9wN2o9EIyveh39VwK
 o1L2a2w1tqqqpN/GbwkASszpJAx/y/7/Y9PxbkK7zATZb+lch0NuUzjMJzQXOsGWo/xE
 W4wXbpNW2VwEILUYsujUcY1ViX/Q3yCn2OW5u7ZhuaN2SAjcFhXmD9+1xROGPNLv/4yR
 kOx5ebCvG1EcQ/a7LdmSjQ1OLVJWlaN/ekdtUm/OBlInuM/8MLUyoekE3hxcw6Gk2XXs
 h0WQ==
X-Gm-Message-State: AOJu0Yzal3HJAGc1Az1qooTvd0PzH1JTHSulfi0jxAlFKptBaBeYA7S7
 hQIdD5g1qC06rj+kbOpuNEb1ndwTXg1Z4afncJ5uzaZP65/jcBeiBQYOOns2lg==
X-Gm-Gg: ATEYQzzCX3cfZPkgS/LJO5Mac/vgaKOBwlAZaFhHsHAlf5XnWtMK2soI879Yw+us+rY
 OgLlljrrqo2Zni9uPT8PKgyAGqrmFcDqaMy2IfoLsEirZhTqFMO3a+fJgmpFuKtlGGFI9fPlhO5
 7Y1WP/EplrM8n2rJ15x6JMSBRcjzi/4quYXkq1Hpk2sWewoNaIBwbmcm9VZCgqGR/vPzZxzBQ3f
 l2WNfhlto55ef5RGN8vawSBruxCRH2I7nviLP5T5INZnrFyeIznymNgabgiMpaSe0MxN1SDhZ9S
 h84JUhxXcCIOAnzSoPOw2u5Ta91HFn500pYvhMaRQesdvo+6y0S96p/NSUStvQ1L1ieh51xucAw
 cj5G+fgAgPqfz3bE+kuaooMsjanCR2K7qz3pW3TMdmwdily5bbIyYe6OWHc4SqIyM2OtyArKYWk
 9B5DnzCKrpG8+oaVOdNVOsqoIPLCaAaBOe6ny+s5tdyiPQValyj0OpLJf6fgulFTpF42RL
X-Received: by 2002:a17:902:d2c7:b0:2b0:4eeb:f807 with SMTP id
 d9443c01a7336-2b082729c2fmr48605695ad.13.1774054136335; 
 Fri, 20 Mar 2026 17:48:56 -0700 (PDT)
Received: from lima-default (103.95.112.190.qld.leaptel.network.
 [103.95.112.190]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b083527f84sm34637685ad.18.2026.03.20.17.48.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 17:48:55 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
Subject: [PATCH 0/3] Fix missing and incorrect unlock_user calls
Date: Sat, 21 Mar 2026 10:48:33 +1000
Message-ID: <20260321004836.500390-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This fixes a few tree-wide issues I found when implementing
vector state signal handling for riscv.

Thanks,
Nick

Nicholas Piggin (3):
  bsd-user: Fix unlock_user API usage
  linux-user: Fix unlock_user API usage
  linux-user: riscv: Fix signal frame user mapping

 bsd-user/bsd-misc.c       | 2 +-
 bsd-user/bsd-misc.h       | 2 +-
 bsd-user/bsdload.c        | 2 +-
 linux-user/linuxload.c    | 2 +-
 linux-user/riscv/signal.c | 1 +
 linux-user/syscall.c      | 6 +++---
 6 files changed, 8 insertions(+), 7 deletions(-)

-- 
2.51.0


