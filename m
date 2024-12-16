Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7FDDE7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 12:19:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNA4S-0002vw-2n; Mon, 16 Dec 2024 07:19:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tNA4H-0002rB-Aq; Mon, 16 Dec 2024 07:19:25 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tNA4E-000081-0w; Mon, 16 Dec 2024 07:19:21 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-54025432becso4095006e87.1; 
 Mon, 16 Dec 2024 04:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734351551; x=1734956351; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cRq6rr7wZmOW+KSPAvJtzadVCHLGmScOaGl9z/2F8Dc=;
 b=jqGZALwvHzkWRspfRPxZVWFPKDq7qBYUUzOOfknHO3VXLkk30KY9moXQ7NMwyXyrfo
 XVVhoRrzs4yrgtNRy36bn7j8572/BHNe8h9kKuDZxGgJz5k9BSLFv9ZTt7zh+flA7flw
 m2DOi+BQ5qdzm/Y7GTe9ZDbNHFpxT+DqfPePfXxokoxR8bqeayWlHc85Rb7aHB17r/C7
 4BnQ+VlvEIQgCGfil2YCYexyhwv5LFDQrVPSJZX4d6IPFUV2LrS5NRzscw+9pyqw9YMu
 +J0NuBNriTRQp4tYR2Qh8op11RBvyVRcBZTtOSs7iO+kAXVw0efwIfssSx8IRv9q04QT
 iwqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734351551; x=1734956351;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cRq6rr7wZmOW+KSPAvJtzadVCHLGmScOaGl9z/2F8Dc=;
 b=YeVC+I0usZV0LYej2V45MNzR+KJcMPasQvEyEfkdb6EA0g7cBF6hdVmetSG+epK0Wz
 /UA5s7EG7JJwJr1dZnDPpS4bCE8CYVlMGdp0j8ehnYKBVDD6/l9W/AUiJ2xMoIE2hbox
 CImM2jRDHWPX8D5cDyZntW2XBV6Ofht8nxuUT8UyymDPu1bBefbw8NHRoJlYN1bvRI3O
 bMo+JwIDGHZcg+ruZjyC55TOJJDkNYLAcoy1JcNMlE83eY2sq4/sTN3Ly8WFdZ9COJeO
 wuO/2mZ2K1RwMkzW6eALEOyns5hT6sIgSkIpambCF3KfnHKomG0AfBwkyChiyWjb/H6V
 Ydcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDw+F3BST1tiXQ9guIC6qJw+XyWyI/2rOnZa5wgQpvHgIPbEs59DP3+5J6FEx/W/mwZPoGxyNXKpmn@nongnu.org,
 AJvYcCXJRwWB8Lgy/GFk0uPF+5YsYcWkLBJMSJm6PUxpg+tfTWLk7XUXHTtaaw7YIuazFlLevi8Qk8nfozjKmQ==@nongnu.org
X-Gm-Message-State: AOJu0YxWp2OhBZMeY9+ba0H0sRkxC+Rz+dnzaW4u8omqZkXTCM42nOc6
 DgPyxH9kI73mIqo+ParJId0gK+G9nREGKeTL7CY3Q4UEbmZk+SvE
X-Gm-Gg: ASbGncvRISdAFcg5sgY2IPYS9l/CFIjNRemP1c4flqe8spyepLmQVPyM0aHGVCgupmL
 PAMRr5tuhCsINF0mr2rhvJyBkhDsGHWdBoTR9/H61YDrYWD+Fw/drUgwtCwLHZKjfvvLYiZg0o8
 zBsZ3HRMcTQ1Fg+iNM0hADcK3LjF8fzclpabVYAJdoSl2UkmzWYgVpPt6oAQqEqXn8Pl3RdgKJa
 Fk6/3q2HsvT6FhNQjLMnzqiEyLH7SAi4FOtQRrQBs3G7SFaGsYbeySVQOkVPA==
X-Google-Smtp-Source: AGHT+IGhdY07bNswOPPF05RiUS71xdR/9Yy7x6zwyQIIw8Z6kqWG0DmiBV/yEVvW0uouxyXxSVrc9g==
X-Received: by 2002:a05:6512:2399:b0:540:1fb5:3f9f with SMTP id
 2adb3069b0e04-54099b696e1mr4397844e87.47.1734351550545; 
 Mon, 16 Dec 2024 04:19:10 -0800 (PST)
Received: from vmdev.asgard ([81.200.11.243]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54120c13d0esm827143e87.192.2024.12.16.04.19.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 04:19:09 -0800 (PST)
From: baturo.alexey@gmail.com
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com,
 liwei1518@gmail.com, alistair23@gmail.com, frank.chang@sifive.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v13 0/7] Pointer Masking update for Zjpm v1.0
Date: Mon, 16 Dec 2024 15:19:00 +0300
Message-Id: <20241216121907.660504-1-baturo.alexey@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=baturo.alexey@gmail.com; helo=mail-lf1-x12b.google.com
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
 target/riscv/cpu_helper.c    | 122 ++++++++----
 target/riscv/csr.c           | 357 +++--------------------------------
 target/riscv/internals.h     |  44 +++++
 target/riscv/machine.c       |  17 +-
 target/riscv/op_helper.c     |  16 +-
 target/riscv/pmp.c           |  14 +-
 target/riscv/pmp.h           |   1 +
 target/riscv/tcg/tcg-cpu.c   |   5 +-
 target/riscv/translate.c     |  47 ++---
 target/riscv/vector_helper.c |   5 -
 14 files changed, 241 insertions(+), 550 deletions(-)

-- 
2.39.5


