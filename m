Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8240EE6C5F8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 03:38:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIJjn-0007t1-Je; Mon, 02 Dec 2024 22:38:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1tIJjk-0007sf-Uz
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 22:38:08 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1tIJjj-0005Xc-Cl
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 22:38:08 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2127d4140bbso47260805ad.1
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 19:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1733197085; x=1733801885; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/3TPIP1MGkGKOb8JzFkJI971Z6VFGcV7XVTJlNqAnrw=;
 b=VWm/wg6hzSq3dD8XxiCQO6X5uurLfyfzIhAqlj8j3rQ6KvxW/A8cS2pEa2UCKRzXOB
 uu52Nf+xUfbxuzXOsZHzJNWo2t2NjMa35AyKXme51QVM8+j+vmwRJKZ9Qa7u3U/z/Blf
 gQupzAZbP760CWVvUH08/cRwfI6/kTnYSpb+wBTAAScElW4jE3JnRmktw+coACi8on8u
 R7oD/H0ET9P4fbxRWKYntYtUAGAaQfhUOTdeiQpTfaMoJoOSOAAIs9ewCetgh1qoeABz
 IIqESe1S98TPjOf01Iyl7NEyxFVkD3iNYoWXz58Cpl4EKmlGHh26AUEUNm7dMZqm/8Ph
 dslQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733197085; x=1733801885;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/3TPIP1MGkGKOb8JzFkJI971Z6VFGcV7XVTJlNqAnrw=;
 b=h1J8GG/k9Ovtonq6vGlzk0hQwgg/CdDtrMYdMyxiZ7S6xJhht1lT8bAWlj32OcFigR
 HiZDVxgJZruxCQXa7JKXn5PjiHNiiJzGlFf1xObYONPUJo9gSx5lqvqJib2QUqfsE+db
 PvQAzS9MYVkJzqYsndP9HEQ9BAkYozkA/X/E39n0vF6jMqZNjgzoVEqk5ceY/AMjbkLc
 DEqygtGMK6f0ZsCFJePeVw7nyCx4pBJcH0uQvMCjzr0Kz962pYJvwco9txjJTD7vHf17
 MBxHlKZ+euu4+UT5q5UPvnRGNYUyB5cdRR1mhYxUF0R4Om3XCSMwlnLnCPOg9fZAxKx1
 1YQQ==
X-Gm-Message-State: AOJu0YyHPhVv5p94DpDPZqLTV9hyOG5WlAi0L05ns93TxCFy5zDkl5sI
 WOLG+XIyMlDgzKusBuGTY4jNM/IVZIJAg+SI6kbS68G5tWPe4chAvGpk/E2V+Do+KvdyHGYbfQH
 hcrMjWwDhET9z2D44/JP1VphILFjBBVv3gY89+M1hvvBOa4F9GVCxa/8IXBbWRy2FJbW69+2nLY
 a1AAe9TLsPLKx9/rK7vHkV0PRibi7omTMtBIQ=
X-Gm-Gg: ASbGnctqFA1SdufudToLt7DWOY7L9e5sKXYcdLApbGWaUzQgsjO9aE989Fp83wRO0gt
 0g0xlT0+XcLhlUirymiTe6nLAZyJfkYNgNFfwk6ToxBQg1VX3VvRFPaxVHVsw20z3M4K5X+0iFc
 hH0BwTjm9Ac8OFcRPq6OPbYOTekl5DKkpdqMnS72f4yofVJ5zLHc/f2dVM3N3YHloK7AqqzMO8Z
 TE7IDiBCGskJfMUrKoQ41bRtK8AeXilzSp08j2WBdmazEKuZWqGJTct8TDpmfC2zRMjPS4SGGN6
 8lKLKExr
X-Google-Smtp-Source: AGHT+IELX0Ll3gFDL/7CHwx3ZBteJw3RKl5qUgKPu9SncvBkus+155PrU4EWVsHuQCoJMtQZ4vAUWg==
X-Received: by 2002:a17:902:cec4:b0:215:6b4c:89fa with SMTP id
 d9443c01a7336-215bcfc4dc0mr11140185ad.8.1733197085175; 
 Mon, 02 Dec 2024 19:38:05 -0800 (PST)
Received: from hsinchu36-syssw02.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21566732e1fsm47111135ad.134.2024.12.02.19.38.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 19:38:04 -0800 (PST)
From: "Fea.Wang" <fea.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, "Fea.Wang" <fea.wang@sifive.com>
Subject: [PATCH v5 0/6] Introduce svukte ISA extension
Date: Tue,  3 Dec 2024 11:49:26 +0800
Message-Id: <20241203034932.25185-1-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=fea.wang@sifive.com; helo=mail-pl1-x635.google.com
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

The Svukte ISA extension has been approved for fast-track development.
https://lf-riscv.atlassian.net/browse/RVS-2977 
And there are Linux patches for the Svukte that are under review.
https://lore.kernel.org/kvm/20240920-dev-maxh-svukte-rebase-v1-0-7864a88a62bd@sifive.com/T/#mf70fcb22cd2987ad268c0efee9b8583197d3cb4f

Svukte provides a means to make user-mode accesses to supervisor memory
raise page faults in constant time, mitigating attacks that attempt to
discover the supervisor software's address-space layout.

Refer to the draft of svukte extension from:
https://github.com/riscv/riscv-isa-manual/pull/1564

base-commit: 2209cae121e5da3cfbdb9dd4b06d52d0ef66ea69

[v5] 
* Update the warning log and the commit message

[v4]
* Add a svukte extension check in RV32.
* Refine the code.

[v3]
* Fix some typos
* Refine code by separating a function into two dedicated functions.
* Follow the riscv,isa order

[v2]
* Refactor the code

[v1]
* Add svukte extension

Fea.Wang (6):
  target/riscv: Add svukte extension capability variable
  target/riscv: Support senvcfg[UKTE] bit when svukte extension is
    enabled
  target/riscv: Support hstatus[HUKTE] bit when svukte extension is
    enabled
  target/riscv: Check memory access to meet svukte rule
  target/riscv: Expose svukte ISA extension
  target/riscv: Check svukte is not enabled in RV32

 target/riscv/cpu.c         |  2 ++
 target/riscv/cpu_bits.h    |  2 ++
 target/riscv/cpu_cfg.h     |  1 +
 target/riscv/cpu_helper.c  | 55 ++++++++++++++++++++++++++++++++++++++
 target/riscv/csr.c         |  7 +++++
 target/riscv/tcg/tcg-cpu.c |  5 ++++
 6 files changed, 72 insertions(+)

-- 
2.34.1


