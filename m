Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A93CF884D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:22:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swl3n-0003HJ-NT; Fri, 04 Oct 2024 12:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swl3l-0003GQ-EE
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:21:41 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swl3j-0004GY-9b
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:21:41 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2fac787f39fso25978581fa.2
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 09:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728058897; x=1728663697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gAASx7TY8bTkB3/GQlruQrs3zPDMiizNhLdumqS8Pfo=;
 b=YYWsfRmrAUdvBE2fjC8u/A1UhNObiJZSO3DMLM5RKuqrC9CoeCK5fgG3CrBAaseTTj
 IW9/eS0h874Kf9J9ru64x9NV8AerkHYLKjndhd2mAvAMooTmStKYLnarDr6vIUzzakr9
 sq1NINsqNOeZxg0uBV3FMgnnIrneKhiBVHqvmwD8MdvWoave2PtDmprnDn3qWgYB7qxK
 GTsNB6FOq4oyAjM1bIHVwNxgeWdyPJfInlALA+o3Wfpzj4fYMs9bfunpm/e/9CRG3y3z
 OFoKPOzw/oWehykOQ9galj82qwf3Me242ztxg81b/nEjB90TzRYDNxvTwkzaHbEWq2jP
 sEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728058897; x=1728663697;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gAASx7TY8bTkB3/GQlruQrs3zPDMiizNhLdumqS8Pfo=;
 b=wJrgMyzsWIRiTXsEhotUqXlkZK570doqoBsPGXDQQIPXgTSuKwoftsyx5DSm9HpfSm
 6/9zY3EvyIiFsfiTMARDCNPwz/rirlAxbYdFNMTpJyvCJDvjjau7IexlqurMjghnGZRG
 LrtlNT6R9RkqB8Dr2l2VmMVkGfYWFC3oL27i2NxwZnmdvTEWUoh+840mZj1oqFSjcglU
 1bcjd5K7Pwbi5O4ZXKP9oWKxIgo9k+fIYVwIoPEm+8jLmeO8bc1rcu2/lRyVp4rU5om5
 onTeJpb5DzGovp1cPiYFImIMdoIEjAbyHwIY+dqmEdutWJ0oqnXcDECV1WA/AA5s5dKi
 xjCA==
X-Gm-Message-State: AOJu0YxMqo9z2BH8igUN3ZRkuVEUTCeox9LRJxmeb//EI16yuwpPKgqt
 AAkhv82eSD4nCLfZXhdcDFFfuWWQls0a06OM2cWbwJ3vyNYvdo+RzJiRstKc4mSK/TmB6NuCkfu
 bZBBQOp6Z
X-Google-Smtp-Source: AGHT+IG4rsOUDeEwekh1mNCbrJNmrKtoIT7l89Q4h1Vb2LKLefocvM0b0CourucrFDr0pkjGDrmYhA==
X-Received: by 2002:a2e:be9d:0:b0:2f7:ad6b:a31e with SMTP id
 38308e7fff4ca-2faf3d75b0dmr16935471fa.31.1728058896925; 
 Fri, 04 Oct 2024 09:21:36 -0700 (PDT)
Received: from localhost.localdomain ([91.223.100.208])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2faf9ab1564sm160281fa.7.2024.10.04.09.21.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Oct 2024 09:21:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-ppc@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 0/8] hw/core/cpu: Expose cpu_is_big_endian() method
Date: Fri,  4 Oct 2024 13:21:10 -0300
Message-ID: <20241004162118.84570-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x233.google.com
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

Introduce CPUClass::is_big_endian() handler and expose
the cpu_is_big_endian() method. This will be useful later
when endianness will be propagated in the slow paths,
allowing removal of various TARGET_BIG_ENDIAN uses.

Philippe Mathieu-Daudé (8):
  exec/tswap: Massage target_needs_bswap() definition
  hw/core/cpu: Introduce CPUClass::is_big_endian() handler
  target/arm: Implement CPUClass::is_big_endian
  target/microblaze: Implement CPUClass::is_big_endian
  target/mips: Declare mips_env_is_bigendian() in 'internal.h'
  target/mips: Implement CPUClass::is_big_endian
  target/ppc: Register CPUClass::is_big_endian
  hw/core/cpu: Expose cpu_is_big_endian() method

 include/exec/tswap.h          |  2 +-
 include/hw/core/cpu.h         | 11 ++++++++++-
 target/mips/internal.h        |  5 +++++
 hw/core/cpu-common.c          | 14 ++++++++++++++
 target/arm/cpu.c              |  6 ++++++
 target/microblaze/cpu.c       |  8 ++++++++
 target/mips/cpu.c             |  6 ++++++
 target/mips/tcg/ldst_helper.c | 15 +++++----------
 target/ppc/cpu_init.c         |  5 +++--
 9 files changed, 58 insertions(+), 14 deletions(-)

-- 
2.45.2


