Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BDD8D729E9
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 15:44:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH39M-0005qv-HC; Fri, 29 Nov 2024 10:43:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tH39G-0005ms-S3
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 10:43:16 -0500
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tH39E-0001RV-Rb
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 10:43:14 -0500
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2ffa12ad18cso23163561fa.2
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2024 07:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732894989; x=1733499789; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1RLfsFXOEvBUdgrExJ9SmcrFI97co8aOxCFnt3D7XvM=;
 b=efSD+l3JYwUlla7tCHxrhTEqpZSASgkG/S4t+nJbYMOp3yNqSeMFWghOWb39MkdZm4
 +PM+vtEMhTmBKMo26WK8k3wM/EABNdywaE0TPbzC+JRRmjeS1tlKdMPToVN0isVZvK5M
 vU7BzVkBi/3RmhL1qyut9ARFIVIryyHGwnaUGldnVnxcZAWUQyW36FP1ku8dzBdUiZWv
 VyBGGetzYmmEOksZfKKqvyFOfZj/xz3/HDiUe/qLD3nCvJk/fG2rwgxNy/k72oycOoDu
 qSqXTd/2P9ltpZRacGWZTJHrv+nFUxHMiElh6tS1X1rBnzV+fqgo08zIa9sG8fl1D6TD
 NEFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732894989; x=1733499789;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1RLfsFXOEvBUdgrExJ9SmcrFI97co8aOxCFnt3D7XvM=;
 b=QKO6V+0BtROPuOU7a8sByC0uNVQBFbBWtWqHOIvFsHVdvKnEpxSlMaoPqEtFhJGywR
 i71rQogbA2dPUSkoFDojh75LJ6H2qkY1oHK2TTjZIC9YTmAB+TxJQ4sbE1c7fGUxAbLd
 W4v7RqDkLEqfHco4X+lAnIpzpj8vHVCStMtb9i6fJzkTSRNSJLXWqvXY6w/cpscce9R/
 8WZrKWzd7mUdch36Ktwd+pJCgdcy2khUqemZj1jLJIeMwMKKNJTeFZho2T14Kr/IIe5m
 qXw1sKsqLvtvfjtAMMEPxRNGxqA6+xdKyFpMRsebO+CqDKyEWmUwYLq+srH0y2AKXh0h
 NdhQ==
X-Gm-Message-State: AOJu0YwQIIPl9Zi3ETV0bZZVxwJMSkooe3aGIPKJG5FDIr9Uc6WCWK6w
 cpDdPSWXUWHpldrccpy6U0IMJORa/D0cxiiXeCXsw2i6oHXEx32+ypcUagjXN073pculOx3L7Kp
 U
X-Gm-Gg: ASbGnctFbN0Yk6sgKFWb+k+DPqKrPnejk57DItsnfOFQ4EzOkVjkT0ZF1AmHASlHJqn
 1+qbp/QnA6cvm07X3gIm8j1OalUXMqZABVZnmakVdXm4m1MhteWXepzEytWXqe2iOdkvgrIZYMz
 nH6997OfekNK4yJ51LQM/KATOitkrtVVMd6trYjhwc2qt9SbpmhVTvIOPjIxd31lzH4ow1a026E
 gEipyJvqO1F73+WRRZJc4E0pt9rcnpTD06H6YHd8HlSl9gxaRTG9LfHoo+l
X-Google-Smtp-Source: AGHT+IEpOnYt/eZCZsYHs2V714mgxm87yD+hi4xPO2EQGnjhmB7HBhFToVs7i2g0c1aA6Zlzvk5skA==
X-Received: by 2002:a2e:be0d:0:b0:2ff:8e14:30a4 with SMTP id
 38308e7fff4ca-2ffd6007861mr65847991fa.10.1732894988967; 
 Fri, 29 Nov 2024 07:43:08 -0800 (PST)
Received: from m1x-phil.lan ([176.176.147.124])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d097dd6af2sm1926150a12.48.2024.11.29.07.43.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 29 Nov 2024 07:43:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.0 0/3] hw/char/riscv_htif: Remove tswap64() calls
Date: Fri, 29 Nov 2024 16:43:01 +0100
Message-ID: <20241129154304.34946-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x234.google.com
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

Trying to make sense of these tswap64 calls I
figured this device could be simplified.

Tested using 'make check-{qtest,functional}'
on both big/little endian hosts, no failure but
I'm not sure the code path is covered.

Philippe Mathieu-Daudé (3):
  MAINTAINERS: Cover RISC-V HTIF interface
  hw/char/riscv_htif: Explicit little-endian implementation
  hw/char/riscv_htif: Clarify MemoryRegionOps expect 32-bit accesses

 MAINTAINERS          |  2 ++
 hw/char/riscv_htif.c | 15 ++++++++++-----
 2 files changed, 12 insertions(+), 5 deletions(-)

-- 
2.45.2


