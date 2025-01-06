Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED6BE7719B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 10:25:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUkHR-00072b-N5; Mon, 06 Jan 2025 05:24:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tUkHQ-00072O-Rr; Mon, 06 Jan 2025 05:24:16 -0500
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tUkHP-0008Pf-7M; Mon, 06 Jan 2025 05:24:16 -0500
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5401bd6ccadso14145931e87.2; 
 Mon, 06 Jan 2025 02:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736159052; x=1736763852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2t+dcKPCok4Zjokqd+bqhO4RtYJzZFAjpGFqWUTGAok=;
 b=L7rYc6XaqduNTQpu6ciXozqvd0O2VY6I2wTA4fB1MKYav0JI8PvINLJMK3cbLZE22U
 /OobZ+LGqITCd+Kzq6s1KpREV+jOEKwQV6a9DqTCToW5hdOnzeLWBaVOiTNhd9yOC09X
 qACiRjwhVgW/dJ5ByjvUqxlO2BJv6v+TYvO8dWq1r9551mNP+YJYrpIxXN91ejypyvHm
 7pJFqI+HQeWxA1KP0j2IwYSq5/E5qTC4OinKhB4qhmXx4oF8Xt9jQNko9i3q3P34j/c7
 RljWEsQsFqgff3qsi7gMKfkYgz1Kfglr4G/tr+1o7g7ON9CpmZEYeggIpp1b21S7qrRS
 iOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736159052; x=1736763852;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2t+dcKPCok4Zjokqd+bqhO4RtYJzZFAjpGFqWUTGAok=;
 b=VuaGMTU2BOuZjUrcTlWNtK6irZ0ABvu5D6/ZarMpyBhuCkCJSG83DgcRbWkxUg42Tm
 NA6WfIME3XZQ6GhMeH/zddabQ5+OGSapnw4cMdIe18+ur995tUcTHcd7uDYb7IGjQtnS
 MIxG/gOLkvBiNWzt1288zMycQ1rTLCv3M33Es+LdrurhxOOJQtGgVNrbQObd6Atcs2BY
 f7++X2VwpBWnzK+wnOEm7PyVc+4tk9yM9a47G/HnR5QIOSJInTNlHkveFXtFYPYNxmZa
 H4XRHS3whsvOpSliRumKeumbxmxMxEgKH0m0q7mQlhpNqhug+ROoKY1jftl1nujicF7b
 kzJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBndsbv89jdATZfDnnQanY0KiEnz6WJ+1JyI3f/jLnhToGWuE/kFUNx28WkJfj+ARt9OarnoK2ZrR6@nongnu.org,
 AJvYcCVVvjQGd9DuqEVlU2TBXdTAtPRPhsWYDA7uTNAKtbM9E398btQhaoma1L98TRMN4l5lPj49FMLGC5GmqA==@nongnu.org
X-Gm-Message-State: AOJu0YxgMyxQYlxx/LBsu+LyE9Pt9VU2/FWQu67P56rSuCRd/e2SS+T1
 T/5uvH9QFLOPgxOdoFcgErYmBBTCX0UB8yy0xYAFGDbRvEmJO1ES
X-Gm-Gg: ASbGncsOoezcYh66a01aGTJNlIJ1k6+5bSKX11DkqVwdsjMCPDZ1yRKuqXIgJ+J24yL
 mEvHoMwArAr5OhlgKTVXSQOKtM1kAmq08AMw1xaUPXDaxCmf1682MVOn8XCSH6fA+ODvYfXGzEx
 QLeBhQvFtua8HndvXKDXmJRWgyl2SrrMPndKPlB6FYP8a8rMjYtoU471MVaY6LgNXQYgLvpnGsO
 mxZ4bHynqMopPb7UBD76/l0rmBgDPxJoVY5Hr3HZXtIexGtBgKhsCASTTNX
X-Google-Smtp-Source: AGHT+IH/j6XHQiIH1cPfb412QpOthHXqEYSk0Rs6OxCUh0YK/+dbz9g0FBkBoQsMTkBUDAiktzpWng==
X-Received: by 2002:a05:6512:3a90:b0:542:249c:2156 with SMTP id
 2adb3069b0e04-54229530077mr18742899e87.15.1736159051942; 
 Mon, 06 Jan 2025 02:24:11 -0800 (PST)
Received: from vmdev.asgard ([81.200.11.243]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-542235fed58sm4811190e87.65.2025.01.06.02.24.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 02:24:10 -0800 (PST)
From: baturo.alexey@gmail.com
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org, palmer@dabbelt.com,
 Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, frank.chang@sifive.com
Subject: [PATCH v15 0/7] Pointer Masking update for Zjpm v1.0
Date: Mon,  6 Jan 2025 13:23:39 +0300
Message-Id: <20250106102346.1100149-1-baturo.alexey@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=baturo.alexey@gmail.com; helo=mail-lf1-x129.google.com
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

From: Alexey Baturo <baturo.alexey@gmail.com>

Hi,

Rebased against Alistair's riscv-to-apply.next

Thanks

[v14]:
Rebased and addressed Alistair's comments on code style.


[v13]:
Rebased and addressed Daniel's comments about the return type of the helper.

Thanks

[v12]:
Rebased and addressed Richard's comments about proper masking virtualized accesses.

Thanks

[v11]:
As suggested on the mailing list by Daniel, I'm resubmitting this series and keeping the original versioning number.
So that makes this one v11 and previous - v10.
Also I applied previously issues reviewed-by tags on some of the patches that were present in v9 series, but only for the code, that didn't change much.
For the others I'd really like to have them reviewed as there were a lot of comments on v9 series.
Also rebased on the current upstream.

Thanks

[v10]:
I've rebased this patch series and addressed Richard's and Daniel's comments.
Thanks

[v0]:
As Pointer Masking is finally ratified, these patches intend to update the existing code to the final version.
These patches have been submitted previously and I tried to address all the suggestions, but I'd suggest to review them from the clean slate and then finally push them to the repo.
Thanks.

Alexey Baturo (7):
  target/riscv: Remove obsolete pointer masking extension code.
  target/riscv: Add new CSR fields for S{sn,mn,m}pm extensions as part
    of Zjpm v1.0
  target/riscv: Add helper functions to calculate current number of
    masked bits for pointer masking
  target/riscv: Add pointer masking tb flags
  target/riscv: Update address modify functions to take into account
    pointer masking
  target/riscv: Apply pointer masking for virtualized memory accesses
  target/riscv: Enable updates for pointer masking variables and thus
    enable pointer masking extension

 target/riscv/cpu.c           |  19 +-
 target/riscv/cpu.h           |  50 ++---
 target/riscv/cpu_bits.h      |  91 +--------
 target/riscv/cpu_cfg.h       |   3 +
 target/riscv/cpu_helper.c    | 128 +++++++++----
 target/riscv/csr.c           | 359 +++--------------------------------
 target/riscv/internals.h     |  54 ++++++
 target/riscv/machine.c       |  17 +-
 target/riscv/op_helper.c     |  16 +-
 target/riscv/pmp.c           |  14 +-
 target/riscv/pmp.h           |   1 +
 target/riscv/tcg/tcg-cpu.c   |   5 +-
 target/riscv/translate.c     |  47 ++---
 target/riscv/vector_helper.c |   5 -
 14 files changed, 258 insertions(+), 551 deletions(-)

-- 
2.39.5


