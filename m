Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1038E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 15:52:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNwLS-0007HQ-1D; Wed, 18 Dec 2024 10:52:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNwLO-0007GP-KO
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 10:52:14 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNwLH-00061v-Vz
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 10:52:14 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-436341f575fso54360775e9.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 07:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734537124; x=1735141924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kxZ8S6BNxBYCXAaAnmTt3vBiEUUT4hLqLQ+uMOUlcis=;
 b=WD3kIeJqWLT0o3B8y4hRgsZi/JAzzAfLhnV1tbD5IK4hpT1PWSeKA1UB2sbZ6CO9XX
 NkUaPAVf7r0TnrQuyvAjxB0PJRPhXn3A20CNWLff9IvoMkAoX+4lE/OG9pI2av7W8yXl
 HuIAWFGAEm7F3gVQcwPxnCHyALy04lnmSDeWAo6lLfwb3+selaFPEX9O93TYZk77s6pg
 ihSmoQ1rY7e4vs/aJMNMMg45ZmHI88KdQ5nUEl6Xdjv5mbZ+gFjaO79yPqKMmq/6W0H6
 22eM59ACWBhNZjytk+8nOFiK83EXYvJCvW84w0b2/9qavUMWdgaaE7+Lo2xHJXtR9eUc
 X2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734537124; x=1735141924;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kxZ8S6BNxBYCXAaAnmTt3vBiEUUT4hLqLQ+uMOUlcis=;
 b=bWhkEoUyJFcB3y8/Kc9++N5ue5hXUq6/aUDosTmt/ib7lzy15rydt1Gfi4os9oejfQ
 YJmOiD9pPHW+zSefPDDkAZiwzpCBEAVI34IvyQ6jLQyf6VCsMF2rTCVWyIu9087enSXt
 3hOjvJd/Brci2yDBtYvcdQ03F0F2gIAg+mwStpyCIdGYPj+XFM4KFE/737v5+NEghZC3
 9n3DfgNdBGnyL4U3aDnDPI1UcyHeMtfE8QxnAFVUfnIt29N+iEt7F4kXAl8yQ+5h4z8I
 6mwni6jpf+RYSJj2vOg5PoyR5yDaTu66FT7H9kJRLqdAykB9vNnOMZo3UnjxCrRK10SV
 ownA==
X-Gm-Message-State: AOJu0YyyQ23p1lif8lMMKA/7DeJgwXkAPvPdKaGmwXDf6A7H33b1UnWV
 FGZ11BS7f0h2/cgseYK5aoLQDJkNQDMnu3k2yu+Uk1arqklQDf3nqZJoDP6/YxHgWiq9XAqGmoZ
 H
X-Gm-Gg: ASbGnctL76HDAD5aZBrk8DDHczJDMG3oTshBIARcqu9cMEdl37TwfRN+DlCZHfu0GTk
 8H+HHebJxWb892Blm/FOW5QmSC9s4ZEk+NxfogA1m/8NZkJp9Jd17TEbDuUR6dS5QRrEEtlx8PS
 FsD2V6d4bebMRpnL8UXNdXGY+f7pss2G1GMdggOVO12yrEqAkSah36xL1if+nIP2/DT72Ao0u0x
 hJqcSsnT3yPOcvsl4EMFaLJkjAzp+FgJgfvpi8391XZz/jtupRfXdJymh2ypRcyrEfNjUuQe5la
 GAaP
X-Google-Smtp-Source: AGHT+IFVg+Pgs3ksm/GXlKr5wni61GhjOloYeYYNC1eoli0UEMVYYQMvqOZU/OQOIMNW4IsYSgpW4g==
X-Received: by 2002:a05:6000:188c:b0:385:dc88:8214 with SMTP id
 ffacd0b85a97d-38a19b34d50mr83686f8f.43.1734537124430; 
 Wed, 18 Dec 2024 07:52:04 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b41904sm23760565e9.37.2024.12.18.07.52.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Dec 2024 07:52:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/4] include: Header cleanups around "cpu.h"
Date: Wed, 18 Dec 2024 16:51:58 +0100
Message-ID: <20241218155202.71931-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Few more cleanups related to "cpu.h" in "exec/cpu-all.h".

(I plan to merge that myself)

Philippe Mathieu-Daudé (4):
  target/ppc: Include missing headers in mmu-hash[32,64].h
  tcg/tci: Include missing 'disas/dis-asm.h' header
  exec/ram_addr: Include missing 'exec/hwaddr.h' and 'exec/cpu-common.h'
  exec/cpu-all: Include 'cpu.h' earlier so MMU_USER_IDX is always
    defined

 include/exec/cpu-all.h  | 5 ++++-
 include/exec/ram_addr.h | 3 +++
 target/ppc/mmu-hash32.h | 3 +++
 target/ppc/mmu-hash64.h | 2 ++
 tcg/tci.c               | 1 +
 5 files changed, 13 insertions(+), 1 deletion(-)

-- 
2.45.2


