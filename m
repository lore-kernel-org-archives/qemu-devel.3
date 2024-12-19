Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 741FCE7718A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 17:47:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOKcE-0007aX-6H; Thu, 19 Dec 2024 12:47:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tOKcA-0007RH-Ir
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 12:47:10 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tOKc7-0003Hz-K2
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 12:47:10 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21628b3fe7dso9880395ad.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 09:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1734630424; x=1735235224; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=22kRF8HdXYOmdtlNEd3I3IH68t3XkiVPSwqysQLAxG8=;
 b=dp841ASpDVRTr55aWACfV4o1gdXPcedUWGb03kLXPgp3ZZkKZnwoCpsmDTKglanReE
 1zdy2V2koqb3aTqPidUzxBgRnajj2BnjohkjCHda8MQc6HmlT03ietTufKz7w4Uchztr
 Chsri4JkmstZU2xiPJ5UJee3ovyHkYAqOUVO76LLce2pr+QOC6af8K9Mzpb9vtpUJl24
 c714NkSQe5ueIDcTgnVQ+JAUYF4NOwnDYm0bmEfZZbVkHSKekOifNP0EfR/SYV/lDRkO
 BCkAYFUPXEacqs8RznzMBcaEIzhlNc0r/fBVTzsN8mD5i4zVWae70EE8VmfWKQ/Zi6mf
 5IBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734630424; x=1735235224;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=22kRF8HdXYOmdtlNEd3I3IH68t3XkiVPSwqysQLAxG8=;
 b=LWLsH4mkPhCzoTt/aQ9U91f+nm11MjWWb62aLwMWjnYUkbfqn+9RjG04FW+OFoeCHH
 Tc9i0zkjPHBy/0rbu9L63JW8qLFPQOdwZdlogzTr6eajgS8xPBPHTc9kmZTQy2Z8hCrO
 P9eVDX6HuOEtrl+t4SR1G5CkcAXa27SzfvdDu/x26Xg4+CZo7APK1grbH61iT91Mxwo8
 ku99Ot8gky38hkjuYnc85bVapGaw3DUrXUzqqNwfMF7CF+WSztVxgxXSQw3KgvjPtRKS
 IikftgCI/o76s2ocD5RVSW4C2sOzCq2sl1Tnf39whX3AzEFr6jg9d37FTPM2U9HuhEJy
 1pdg==
X-Gm-Message-State: AOJu0Yx5B+yokW7DbGJKwPz2/YshNbK0lPTIfL1NLRJWzvlGi5jKT/hp
 Iv1OxDeFvH6JPm/9irRZE/HkZP4BKnS2NOJ2a2BwzUN7+eEYbhWhMfz3jv7Fej3RRhXxlNx6GFN
 fP8NAWQ==
X-Gm-Gg: ASbGnctMqUdne3nvq8C04N27muzA2eQQtxjhrK1MOPJVZ0soX40DGYl43SobiyliUYw
 iWI6A4LXI5VBa7BpnC6mI3DjhwmfmJVyL9isyZyJDNdEyFwt9qmyqyX2pz6hzwWfN7UVGRM2I3p
 jfIQ7aYD/h+/IgTK6kkLKJt8am3JXxUuaL6Il5YTWA1DrMzaaoaWhIMMnvTf9F8OrUbX82QP1Dl
 p5mHhU44xFx+6Rx6tgAnraS5gai5fZ4pRKlLkgwm7A9ybGAFE4xabduyfpvHhI/sByQKqYu4cnq
 b1a2KJk=
X-Google-Smtp-Source: AGHT+IEjQ4BfJdNclFHSY36LWqwYqva6qotQNTWUkR37XLQcttPKJVSM6b5bVuVuoi0pcn+BcJ3Lvg==
X-Received: by 2002:a17:903:2287:b0:215:72a7:f39f with SMTP id
 d9443c01a7336-219e55d7debmr5077685ad.36.1734630424018; 
 Thu, 19 Dec 2024 09:47:04 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([187.101.65.72])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9f7307sm15099505ad.195.2024.12.19.09.47.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 09:47:03 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 0/2] target/riscv: add traces for exceptions
Date: Thu, 19 Dec 2024 14:46:55 -0300
Message-ID: <20241219174657.1988767-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62a.google.com
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

Let's add trace capabilities in riscv_raise_exception() to allow users
of qemu-riscv(32/64) to have a little more information when a SIGILL
occurs. This is done in patch 2.

Patch 1 is a "look and feel" patch that I figured was worth doing.

Daniel Henrique Barboza (2):
  target/riscv: use RISCVException enum in exception helpers
  target/riscv: add trace in riscv_raise_exception()

 target/riscv/cpu.h        | 3 ++-
 target/riscv/op_helper.c  | 9 ++++++++-
 target/riscv/trace-events | 3 +++
 target/riscv/translate.c  | 2 +-
 4 files changed, 14 insertions(+), 3 deletions(-)

-- 
2.47.1


