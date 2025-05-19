Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D73C3ABD8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 14:37:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH1ae-0001hu-84; Mon, 19 May 2025 10:35:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1uH1ac-0001gl-7e
 for qemu-devel@nongnu.org; Mon, 19 May 2025 10:35:38 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1uH1aZ-0007Pd-5j
 for qemu-devel@nongnu.org; Mon, 19 May 2025 10:35:37 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-742af84818cso2362953b3a.1
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 07:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1747665332; x=1748270132; darn=nongnu.org;
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=40itAGysfNIjQ/fzPkWnlZm6Ucscvk9farBtstKM3UU=;
 b=BR4joDmEDv802Pr9fJ/9ibagX99jRxqu3v+YLdV87nVgB5DgxwlkqnufT9opF4125W
 ERBBJa8rI3I7YYnAst16pydV4mEQomLO/CaJT+vGz1mqIOFNnIMuqdxxdo7fXpHzCs87
 BkxoRf+EvTphvJ8LMgfraklzyJoIuDbVxo95zsbW1Nm/mDNmtZ8KUqZ/sEiGX2USG0/w
 rJvm1WTlilxLqqi4z9k05baOVq+e4MBlO5jgtzalDLCjWS3UkrJUHmSh1ajzzYCAzVn0
 1kaIYaB1hnSUYeplQkIIkvF5xGmYLaAWUpUJvxCyWEfHyUCoONoxnziH8uKYx34q/YzS
 n2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747665332; x=1748270132;
 h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=40itAGysfNIjQ/fzPkWnlZm6Ucscvk9farBtstKM3UU=;
 b=uVprZVN6l+YLnJEWhLiJJu3jUk4FbyLNGYWdiIKTWOUT+NK9DgC10bdm8TuoYWtplI
 lk4uPom9PRyvpVu0oh0JVrSAD2a004AVGpt2Ap+ld05zNTZ/NkqCQKXcWSmV0ylen1UI
 Ud+NNQu6i3pMS9e8YXIZWkaRoHkmWLo3wTCa88AGBmAYSvbrHHy1b1lOMii3hfcJdzMx
 PgoanvSngVQGOblqkhVXcu+HmBJW3dU5GTjPcG0whB1oZeO4tBDzTEz6FNuU/Rda03fc
 D71Zv3p+0/yMphKkPWTrFaHLRcnvg0bagVO1xYSWm3P8jo+PJjhlNjlVxq6cQw6DVM0r
 mPhQ==
X-Gm-Message-State: AOJu0YyaFDh4FMPRfTaJOVHYFK2jpyG17wZwFnY35jTPYCljuL1toZUL
 lFgPGrEPv0nAuGrIt5h4Je5nCwoZ+216mDxzxJ6Fv7HqZPKUEzGu0QrabFUwXfzZwm9oxHNvTdc
 r8UIdiFUDknjTg+KGqU3lxazVeaEpejIJYNSKMAOxrD1il//jMk16rsTG4gspmA7LJlCeC/8+le
 T1el2+5u6DHMkxQhD5wuK6wFg/QJXQ4As25RBLuw==
X-Gm-Gg: ASbGnct0lCYpMguoCFtYKVuz6uIMHeDH/Dru56kIhXb8CjkedNqV1M9mkaOH4RUmDqt
 1pe+Xh+khFBVchW4KVzQBOfLUJD+t6fOs2cnAIblydX+wiMVRbd2X/6MUDCLOhYpMWTDruRGfei
 F4y/nN+iY+1J3+mOfXNmUGJzygopp1Qk/OznfIGArtQZOEbrxEq0ItfmCf53cGsy2gVDJrhW34i
 /t7jYmbsa8gNbTkM7qbjkkeOffCQwsVLyAROaei+e7FUC1y9e5VFRQaQl2fLkysN5zjPfWH2h2K
 /gRsbZmZRTKAx9hiYJoicXSnJxCXDNzdCkmTR3fQFJrGtHC3pyjWGCPdBOtkfHv2Oxzkek7RyQ=
 =
X-Google-Smtp-Source: AGHT+IGB0MMkDMsUlLrVg2uQHdqGcIangQnghRhV442caTvr/+OcTNSr6IH0wM7pnYPP4fcbuIfgxQ==
X-Received: by 2002:a05:6a20:3d83:b0:1f5:80a3:b006 with SMTP id
 adf61e73a8af0-21621934388mr20108307637.21.1747665332368; 
 Mon, 19 May 2025 07:35:32 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a98a32edsm6297683b3a.162.2025.05.19.07.35.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 07:35:31 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v3 0/4] Several sstc extension fixes
Date: Mon, 19 May 2025 22:35:14 +0800
Message-Id: <20250519143518.11086-1-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=jim.shu@sifive.com; helo=mail-pf1-x432.google.com
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

This patch series contains several sstc fixes:

(1) Writing to ACLINT mtime should also update the period of S/VS-mode
    timer, just like M-mode timer.
(2) VSTIP bit of $mip CSR should check both M-mode and H-mode STCE.
(3) Writing to STCE bit may enable/disable sstc extension in S/VS-mode,
    which should update the timer and IRQ pending bits.

Changed in v3:
- Rebase to riscv-to-apply.next

Changed in v2:
- Remove duplicated code in riscv_timer_stce_changed() function
- Add sstc spec description in the commit log

Jim Shu (4):
  target/riscv: Add the checking into stimecmp write function.
  hw/intc: riscv_aclint: Fix mtime write for sstc extension
  target/riscv: Fix VSTIP bit in sstc extension.
  target/riscv: Enable/Disable S/VS-mode Timer when STCE bit is changed

 hw/intc/riscv_aclint.c     |  5 +++
 target/riscv/csr.c         | 55 +++++++++++++++++++++++++++++++-
 target/riscv/time_helper.c | 65 ++++++++++++++++++++++++++++++++++++--
 target/riscv/time_helper.h |  1 +
 4 files changed, 123 insertions(+), 3 deletions(-)

-- 
2.17.1


