Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE6EAC7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 17:22:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTkrQ-0004Qw-71; Mon, 23 Jun 2025 13:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uTkrJ-0004Pv-U9
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 13:21:30 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uTkrH-0006Ce-Ep
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 13:21:29 -0400
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-23636167b30so41443195ad.1
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 10:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1750699285; x=1751304085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gI+dIkhmMbZjzwWaUE/wQuMEVtNYADLma5F4gjIEl9M=;
 b=CoRnpBAW/v8j34POemc5lGFyxFrSxxCGQKv1BdUceRB1S6PMdMhFYbvIseLU6Sdn6a
 sNFlgbhWvuR8oMDjxtFWDSy0SK3ritNDFfMy7jUhBIIFqGp1D0PAgczSt5gLOcL7WLIh
 jwsZcMHwdY7A9kFNh2fSP96hTUDhVvimHD+tNxKPwVqiWDFBS//CmobbrGIeTDAdnr5p
 jw4Z75s0CLRLf5gfjaBDhiFo4V8bi24p/x/yg59LCgAm81+pLwnp1iLrSg81oDBGUNxM
 OUa8+/UYMkyTDonpYxzupZ/UsQ/DGy9VchPtbcXPwA1DhbmmWyLyGVLeLDpv0+HcdOyC
 dP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750699285; x=1751304085;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gI+dIkhmMbZjzwWaUE/wQuMEVtNYADLma5F4gjIEl9M=;
 b=HhXVzCGY4GndUXNCvvQqCGpfKXJPGB65jZWzO+0xLjgsuN+OlhTagI7PddOFxMo4Ye
 UACrPlJjFl+JMkKuP2+SEUDQXGHTR3sx+7Z/YLav5My0cbxqR8UTrxQVjkzcE+S7pNY/
 fx5bS6jz1D/BlH9awCOYM2ImI+tA3alUwQ2MGbLJj9DysrxADGdatPlvyT0YtOwpj0DB
 qMHrQpHkWWiBoNOjKpq59uJuJxklzJEOJ62leN6XOqp69IgA+OBqSTGVwHXZCx9TgbWV
 otRrwLJ0rPlESVSikh73Z3FvfD5LztPpimwWEmj3wyj38E11WNsBwL7KyYmON/3F43Wj
 sJ8w==
X-Gm-Message-State: AOJu0YyMFo2X8yH9vqKxhu0KFfqec0fiPlY/17Wsz6Hoerrq5ym+GEsr
 Srlz6eXCQe7X89Q/fVlISEOWu2lZrTQRPQkOtt6GpEi1frL5QVyWWo0X+oMPQHE4OhEM0dyVHlf
 yM72/DEaOXg==
X-Gm-Gg: ASbGncsu62PySlVfag9MkhkL0vfIXJz/0r4Eh1amNmPGoSGyy3e+WpMM076dpHGDoDN
 C5FfhAth2P9Sec/cWK1Y4kasnIoQxKEsbONwf+dvacoNbHS6M9dWorGnobRShs+iylmMSmexLM6
 j3595RPQRPVkvSbmQ3rAKGjFlBDr3W+W27fP6T5Rl/qLqECPTh1kKFxesz12ZqonuP4rlnQcnVn
 kTX/66/8qjmVUqdnszMS/qRtSQEEIJrOL2ZoxKhVcJezdP6cHYi6+t+Jg+NBl5dCIvpLXDVhx+1
 l6Zo057PYM2PzrQac7zsRQKtGPVSDMFY3LB3r6emctlMIaEFrf+PeDwyCUWzMvnt
X-Google-Smtp-Source: AGHT+IEoWFv7DmrgwAMVFkjBW3NJ25nOmpDkgiXHs4tNX8qNLO/LFa79IPLWkVj63UhKmKQ4yXbLyA==
X-Received: by 2002:a17:902:dace:b0:235:f3c4:b884 with SMTP id
 d9443c01a7336-237d9779d68mr200979395ad.11.1750699285152; 
 Mon, 23 Jun 2025 10:21:25 -0700 (PDT)
Received: from grind.. ([191.255.35.152]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d873845esm90847525ad.243.2025.06.23.10.21.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 10:21:24 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 0/3] riscv: add all available CSRs to 'info registers'
Date: Mon, 23 Jun 2025 14:21:16 -0300
Message-ID: <20250623172119.997166-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x644.google.com
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

The output of HMP 'info registers', implemented by the cpu_dump_state
callback, returns way less CSRs than what we have available in the
default rv64 CPU with default options. 

This series changes the callback to add all available non-vector CSRs
when issuing 'info registers'. The vector CSRs are being handled by
another patch [1]. 

Patches based on alistair/riscv-to-apply.next.

[1] https://lore.kernel.org/qemu-riscv/20250623145306.991562-1-dbarboza@ventanamicro.com/


Daniel Henrique Barboza (3):
  target/riscv/cpu: add riscv_dump_csr() helper
  target/riscv/cpu: print all FPU CSRs in riscv_cpu_dump_state()
  target/riscv: print all available CSRs in riscv_cpu_dump_state()

 target/riscv/cpu.c | 107 +++++++++++++++++----------------------------
 target/riscv/cpu.h |   2 +
 target/riscv/csr.c |  18 ++++++++
 3 files changed, 61 insertions(+), 66 deletions(-)

-- 
2.49.0


