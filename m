Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7147E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 15:29:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVuSz-0008F0-TC; Thu, 09 Jan 2025 10:29:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <craig.blackmore@embecosm.com>)
 id 1tVuSr-0008Ds-Gh
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 10:28:54 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <craig.blackmore@embecosm.com>)
 id 1tVuSm-0006sB-Jj
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 10:28:51 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43634b570c1so8585595e9.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 07:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=embecosm.com; s=google; t=1736436526; x=1737041326; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=c6WJpUs4643oGwxH6y7zuN4dJbGbFyPImupCGr0ate8=;
 b=bDIqZINdUVxuDg+yfVGGr/vZjnXFMGrFkv1LZzV58KaoIx+tWWqvJ+DtzPaixRSNlz
 rDlO+M0tkInu7pDUppQU7MhxRyv/dILCjCkX5JVG7a9tQ4alKq39YhZGN5/EjHuvhEKQ
 Y8Er8KGMxPhayIwrm5Ys1OOPyjXJt9XBnV7UDNSTxJMTjJBc6nzSa1FdFjg6H9ve7/Sv
 ZzApK+/TVJARfTYJJwjG6Tnbj55nqWFG1K9HVae6LzorNHFYSgglMv6faxyTf8rZuLnx
 hNEjW55WSJTifXQ8mZ5jYuykvSyzF3vt2MjSeTs1saIH7Ft2YzuRZRk5L4e1q6vVAB12
 yRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736436526; x=1737041326;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c6WJpUs4643oGwxH6y7zuN4dJbGbFyPImupCGr0ate8=;
 b=u+3F8Nzg2CwrWE9E3cOEFg7OQYAaFZiTZJpCtvCpmKzoQRTHeO+LDD3WKvx+Td6eyv
 Wd2A90t3gvCPlRNv9QDqs/d+u+zKEayKm5YDXapHUAGsqYd5adAq0+/8O8VtGMrjy41X
 L0aY88IH9a9WdgRmma2c2KEFIRalffRUjWgo+ZpD+da2CWFZutbOAYwK/GNQe+X3hIZg
 PY1Z4DBGPtJac4bcGTrqO2gjhkM7NZzgtIcb8aYmzBntW/OkgoWZxvqPBIh2WNQJ5L/Q
 Q/RwOqi+ZWAYHytGNlU8j/Lmyb/0hSsWBhc7fJ7WI74ee9tIJCgUed8MxwtReHzXR1oN
 rCWQ==
X-Gm-Message-State: AOJu0YyVEnmLuwnw+p3sNwJ6KsezqJmh9XBwcGzicLGD8HiDZ+dpJ7uk
 PAleDBor+FO93foxXLy22rX31Taw+ppxrl/fvrmwxrjXuVdsp3a5rGwLXMCDIX7MQzAnqEdhejN
 cEuU=
X-Gm-Gg: ASbGnct7zIwDuAw3F9P1dLqefIUTOXSqO6b24pr20tJRbBYW6Ph6Wmq+8gLiExD/dED
 yxZSoZEN2eVUFp4btxsm57+FwC6hhrB4fzB1SgPBAFSHh6uisYfy7ZDies/ywh3QWMZHZIkLeBU
 qsTigxjwoZjYpSsKUfMLZtocfz92SThZmSXWw8k2QLDMBFGmLFmD9KkMQwxyuEDV7QpOp89TOBG
 mO6hVQiOrL/7A+SfpHc3XTQhlIzJO8mQWfcEZEWGtwZq9srmheowJFUXvon79TmETUzf7jaWQ7c
 WfTiH0ySfYZd
X-Google-Smtp-Source: AGHT+IHEycFJQjTsq6l4eiTjwRcOrJBPYNwtPSYMh1f55P2vtlqlk/7oehIN6kvopQj0qEiO9msPNA==
X-Received: by 2002:a05:600c:4449:b0:435:192:63ca with SMTP id
 5b1f17b1804b1-436e26f481cmr57297475e9.21.1736436525753; 
 Thu, 09 Jan 2025 07:28:45 -0800 (PST)
Received: from dorian.sou.embecosm-corp.com ([212.69.42.53])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2e92f7bsm59226775e9.38.2025.01.09.07.28.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 07:28:45 -0800 (PST)
From: Craig Blackmore <craig.blackmore@embecosm.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Craig Blackmore <craig.blackmore@embecosm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, Nathan Egge <negge@google.com>,
 Max Chou <max.chou@sifive.com>
Subject: [PATCH v9 0/1] target/riscv: rvv: Use wider accesses for unit stride
 load/store
Date: Thu,  9 Jan 2025 15:28:32 +0000
Message-ID: <20250109152833.75385-1-craig.blackmore@embecosm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=craig.blackmore@embecosm.com; helo=mail-wm1-x334.google.com
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

Changes since v8:
- Add missing CONFIG_ATOMIC64 guard.

Previous versions:
- v1: https://lore.kernel.org/all/20240717153040.11073-1-paolo.savini@embecosm.com/
- v2: https://lore.kernel.org/all/20241002135708.99146-1-paolo.savini@embecosm.com/
- v3: https://lore.kernel.org/all/20241014220153.196183-1-paolo.savini@embecosm.com/
- v4: https://lore.kernel.org/all/20241029194348.59574-1-paolo.savini@embecosm.com/
- v5: https://lore.kernel.org/all/20241211143118.661268-1-craig.blackmore@embecosm.com/
- v6: https://lore.kernel.org/all/20241218142937.1028602-1-craig.blackmore@embecosm.com/
- v7: https://lore.kernel.org/all/20241220122109.2083215-1-craig.blackmore@embecosm.com/
- v8: https://lore.kernel.org/all/20250108143523.153010-1-craig.blackmore@embecosm.com/

Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Alistair Francis <alistair.francis@wdc.com>
Cc: Bin Meng <bmeng.cn@gmail.com>
Cc: Weiwei Li <liwei1518@gmail.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: Helene Chelin <helene.chelin@embecosm.com>
Cc: Nathan Egge <negge@google.com>
Cc: Max Chou <max.chou@sifive.com>

Craig Blackmore (1):
  target/riscv: rvv: Use wider accesses for unit stride load/store

 target/riscv/vector_helper.c | 92 ++++++++++++++++++++++++++++++++----
 1 file changed, 84 insertions(+), 8 deletions(-)

-- 
2.43.0


