Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C36ECA1010
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 07:52:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuRDQ-00030Y-3Z; Fri, 05 Sep 2025 03:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uuRDJ-0002zC-Mf; Fri, 05 Sep 2025 03:50:30 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uuRDF-0008MK-Uu; Fri, 05 Sep 2025 03:50:28 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-772481b2329so2023555b3a.2; 
 Fri, 05 Sep 2025 00:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757058622; x=1757663422; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cuVQJVG8AFduxrpsLUWxQFTob1fSZFfaFdZeH8uN5UM=;
 b=juFFyYYnD8dpmMYVExe/L9WueXqzMt2Id+kvbYXCB3QZ58NlwaC7pfqaGOs2h1wkwT
 WStO+Trwg2p3vJ2UFXOVhUBTAS1o9yX3yPejJGy6wcLfVDfKv/X0OAzqdFqvXI5zifeh
 QDFk9V+CB+fxQYPipz241t8UdwPKuSfx7NU5ZHryVNg+UXzLj3sAY/3RcdYAiy4XD6yh
 viqJQZFP4ELZ7q/vltaB9ipcNjNgJLsDqzJyRodLHErtSR3+bf1OyENH+p9wirg5ceZv
 sy5yIEtRd7pBaQH4Fc+S6KxQpX04bFwMYD7KSYZeuTxCdTuRLdNUVqvWGUuds9ipO62y
 nLkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757058622; x=1757663422;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cuVQJVG8AFduxrpsLUWxQFTob1fSZFfaFdZeH8uN5UM=;
 b=xKSs4AD63gjQG3BFJ2ROV2T1KE/ewLP06IQHz2DTpIk3ojQnThQjVfsmQECm/4iadw
 McN/l0QqPsBNar4M6FFBcZeKrUqJB+ib+IOYcHh30hftwAslV+IpgJS4ReD5oH8Zj5WS
 gqfUeTydKPXgQP1lHRaryl9/Xp/ABGGcQRy0V0LSmtkPs69icnRYBP5N7+Uk3ppmiov+
 B3Qp5kKbbjeOHzOG9uBI3EQ8KpdhvL6awpQ1ReiL8l0/CYWW0/Rgp11hdhakqBHta4Ca
 e2qPRUOYmKgl654kzoK4BtQ6mDtjIpPWs35w+i++8w7Xkh6mI371qxtDyR8lle6PetOt
 KqOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJ49gwyPq7jQ71mPeyaS44rTTzQkGMA+5kC5xO42G/QttpgTHqqa2M7LhsBjWyO2c4LlMvhVMNJZZS@nongnu.org
X-Gm-Message-State: AOJu0YzPIlMrTdoL8dE0ZJ+XYKU5u9yzS1g4dJi4iTFbCm8BZdXW0Mye
 25VoaOMu1BRz6iObu0aW8K5QQrVpeCrvrxuxYBF5hTB9Y8jp0+0jRbJribx9//xv
X-Gm-Gg: ASbGncsMp69asHQHQhdX1p5qiqIQs96pAEcAhaKdykIw9k5IWV2NV0jn5g6WH6J9vHH
 ahwbs8qBkMjVjEpoVjFJMHNxRNGw73frGI0FNvfH6XUHeHzxg0nLdzLOz8BYgeTIzaTAP1predh
 3i399cNo/chisqS9bxXwAEm15h2BP2iBuSJtYxRRkMQJM4T7jg17/TfMsSiP1X7Lx7nFVaFdsoW
 fEmaRVDOqjAOqCXigjNx0msHScsk3xnsyT44JJX2LQ2gu0Uyu6SsvV9UdPaGbqr9WHlyJhvSye+
 nBCz71FJtQwLv5LJDcyki2ioe8z+7yFjf31STy+teM+Vl/7rPnpAEPYnvxuieEr959ndKD7i5s2
 fNAJW5vEy/o3OyUO2OHCFYu6sr+4DFT86m5CPhQ==
X-Google-Smtp-Source: AGHT+IH5mIQYz3cCkwiAAqcwghHmUpB/sRcpuVF8lZkiJisaMqtOAimd+9DQXN4C6G19IXKELugqLA==
X-Received: by 2002:a05:6a00:2e2a:b0:772:65b2:99b6 with SMTP id
 d2e1a72fcca58-77265b29bb8mr21378604b3a.25.1757058621959; 
 Fri, 05 Sep 2025 00:50:21 -0700 (PDT)
Received: from lima-default ([1.146.99.18]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a26ae02sm20967560b3a.21.2025.09.05.00.50.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 00:50:21 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-riscv@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Subject: [PATCH v2 0/3] target/riscv: corner case fixes
Date: Fri,  5 Sep 2025 17:49:55 +1000
Message-ID: <20250905074959.426911-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42b.google.com
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

Changes:
v1->v2:
* Added a tcg tests build-time check for vector intrinsics support
  in target compiler before building new tests that require it.
  ci images may not support these yet unfortunately, but upgrading
  those will be a separate effort.

There is ongoing effort to run generated test verification on the 
QEMU riscv CPU which has turned out a few corner cases.

I added some fixes for these, as well as tcg tests. The
interrupted vector test also catches a bug in
"Generate strided vector loads/stores with tcg nodes." that
I referred to in the v5 thread for that series.

Thanks,
Nick

Nicholas Piggin (3):
  target/riscv: Fix IALIGN check in misa write
  target/risvc: Fix vector whole ldst vstart check
  tests/tcg: Add riscv test for interrupted vector ops

 target/riscv/csr.c                        |  16 +-
 target/riscv/vector_helper.c              |   2 +
 tests/tcg/riscv64/Makefile.softmmu-target |   5 +
 tests/tcg/riscv64/Makefile.target         |  15 ++
 tests/tcg/riscv64/misa-ialign.S           |  88 +++++++++
 tests/tcg/riscv64/test-interrupted-v.c    | 208 ++++++++++++++++++++++
 tests/tcg/riscv64/test-vstart-overflow.c  |  75 ++++++++
 7 files changed, 406 insertions(+), 3 deletions(-)
 create mode 100644 tests/tcg/riscv64/misa-ialign.S
 create mode 100644 tests/tcg/riscv64/test-interrupted-v.c
 create mode 100644 tests/tcg/riscv64/test-vstart-overflow.c

-- 
2.51.0


