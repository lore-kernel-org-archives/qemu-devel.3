Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A90C9C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 14:46:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYRby-0004Ak-RS; Mon, 29 Jul 2024 10:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYRbv-0003xV-TC
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 10:44:27 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYRbq-0008No-4u
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 10:44:27 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-36865a516f1so2025736f8f.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 07:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722264260; x=1722869060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/v/k/yniP5nVbC0OuXzGFTLMBK/X3Q5pTmqVGs8gUbQ=;
 b=SzdKklmzyf7WP1srhXZZT5zSqzINWURblWDIr0y8H/CsfrkjTcAqBu1DwQ+4pZb7ZT
 /RZAgSGgRmsRLkAmO/NczNTi9W/IS07/2MPSoMAZo+xS5fYDekJD0uheeWp2BkGckafa
 xM1YN0kxAan2LJ0QcD1Ep5Eor0+EsoIeWYYZG0uPsnrTmi090w7miujpeva9oGmLJkxR
 BkYEh8quAh/rcMqTLUCt4jiV5y5Wey/ifVYfCnEVhZh5jTGB/6/oyoSL0K9DoLeuOP/Q
 XdVOlI4vLW2Y38mTOfpzZpnA6WBJhUxrMB7tycaEziqwLHB/SZiCxXB+BiyGfErLdrPA
 8RIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722264260; x=1722869060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/v/k/yniP5nVbC0OuXzGFTLMBK/X3Q5pTmqVGs8gUbQ=;
 b=hiRUHA1OgcewKCjn0wk+ky7ZFDBjvR0iFSE6l4PJ6Ktn/zDkoYFPCyI0uC4fUzRZYL
 28dLqAMEBuoFw0VjWBAvqROhYVPodvrkGuSE3szKq0tyXhTXZAGOwLq3wOaqxH5aXPOY
 2CURCI1hdH0B+ub1Sgicxdv1o6o3OytX5w691pgNq4ohWjeBdTmqkuk3Y9lVAf+nmquH
 ucMeACOAr81JO+HOHBMwN7zxNw8Q4/Td5lPXna5+2OZa71PMpdCtH7IpMIC3HzlHx5z8
 C8VX2b8cqYknDCYNKHLDmbP8Zh+5j4eF6YKIyoSkMt+cMHsEd8MgdoFYHGWauei5LelP
 5JJA==
X-Gm-Message-State: AOJu0YyQgxR/49PMQpzNpI/qIiX2p2jEqP4wfoZcByslme7Tka0IXAlB
 wlgf6o0sZkbBTUPmFMuhuWs4Yi0QbwsVUcg3LleVugh9CTUI1JOrHgm1hKyjEDM=
X-Google-Smtp-Source: AGHT+IEgeVGE/c3HbNhA+uFrQD89n8ygvnu1W/8UdExBBLwR3Otvv7+kSvxZWXQE7OnZqNjkBHF4PA==
X-Received: by 2002:a05:6000:1b91:b0:368:7e54:baaa with SMTP id
 ffacd0b85a97d-36b5cf254e7mr6122234f8f.4.1722264258943; 
 Mon, 29 Jul 2024 07:44:18 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab22bfdsm516374666b.34.2024.07.29.07.44.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 07:44:17 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6E59A5F94C;
 Mon, 29 Jul 2024 15:44:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org, Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-s390x@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>, Song Gao <gaosong@loongson.cn>,
 David Hildenbrand <david@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PATCH 04/14] tests/tcg/loongarch64: Use --no-warn-rwx-segments to
 link system tests
Date: Mon, 29 Jul 2024 15:44:04 +0100
Message-Id: <20240729144414.830369-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240729144414.830369-1-alex.bennee@linaro.org>
References: <20240729144414.830369-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Recent debian cross-linker for loongarch issues

  ld: warning: hello has a LOAD segment with RWX permissions

This is partially related to tests/tcg/loongarch64/system/kernel.ld,
but is not fixed by explicitly adding a single LOAD PHDR.
Disable the warning, since it does not apply to kernel images.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240724010733.22129-3-richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/loongarch64/Makefile.softmmu-target | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/loongarch64/Makefile.softmmu-target b/tests/tcg/loongarch64/Makefile.softmmu-target
index d5d5c1a7f6..6d4a20fde7 100644
--- a/tests/tcg/loongarch64/Makefile.softmmu-target
+++ b/tests/tcg/loongarch64/Makefile.softmmu-target
@@ -16,7 +16,7 @@ LINK_SCRIPT=$(LOONGARCH64_SYSTEM_SRC)/kernel.ld
 LDFLAGS=-Wl,-T$(LINK_SCRIPT)
 TESTS+=$(LOONGARCH64_TESTS) $(MULTIARCH_TESTS)
 CFLAGS+=-nostdlib -g -O1 -march=loongarch64 -mabi=lp64d $(MINILIB_INC)
-LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
+LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc -Wl,--no-warn-rwx-segments
 
 # building head blobs
 .PRECIOUS: $(CRT_OBJS)
-- 
2.39.2


