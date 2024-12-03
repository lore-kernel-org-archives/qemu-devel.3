Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08A0E74AD0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 20:09:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIZCK-0006Re-DL; Tue, 03 Dec 2024 15:08:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIZCG-0006Nr-C1
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 15:08:36 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIZCE-0003DT-Qb
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 15:08:36 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-385e5db74d3so2701499f8f.0
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 12:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733256512; x=1733861312; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=k3ec28toM0ExcpIaS6qGzhnP7uN1HiA2sQ1YWBmAsU8=;
 b=fdcT3WYfHrFvNGHE7wFA0/8AqDdce/W+cHqCQIhT0weR5DsBc2kjUCHzRVZ5crms4b
 sPe60Sz6pUJ0vDzWsuSTy7NJQgre+0+wVekH0U9/FXVLzeVsWYwqaoff9CAbwvfcQDbQ
 ZEJCRPM8OaEtx17HcVDXabdub8JsDjicjx9il4GJWvPjun4QF5VCxmJkHRYXpvc/NY7U
 yw/N9ZJ+bR3d7OFlIBampvY3blVWdvhkTgZ1E3j2EdV6uZMmFeScNGQeiVIi9Rb956tV
 LomEGz08nV9VG3PUCJoeBm/uE4UFQejBkzmx+rGhrGG6cluMD7horPDx5XqCnY9ad/zY
 wLlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733256512; x=1733861312;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k3ec28toM0ExcpIaS6qGzhnP7uN1HiA2sQ1YWBmAsU8=;
 b=VP8vWUDj/K7OQ5Gzc/mdHDdcT04irF+yHZxXMJ1nocAoiw178KMwPNz2x6ElQaH++9
 rBgLr0cOcvxGlS39E6coMqG8kmr6QSVhwde6JVF3vXfkOZP91KCuaSAuTe8Tpz9PUVVl
 kHiKoKQ95tVBj0FkJHLD5iI+J765aT0+tt3nXVXXymbpgF8b2p6KDY0Dtmh2VZ6gLbK9
 ajDG6fvth3a6kbSARKBZwehr7lYbm/DBhZnDoKcY/vq/rqfX7oby9UqdNXBpJonnnMUE
 SNmEsAa500XBlqmD8ej5qPfxKimCHJzPyZqlwclp4DR0N6/Db/sJHKcUiKEjt7kVPuD+
 s9Dw==
X-Gm-Message-State: AOJu0Yx1oHuD6W7xkaNK3Lg9Nk2qIf2UGTMSBOYcO63sSudQhOAPbuw3
 R52MbyKv/BbCD90SEBzMCY/R/PeVBVkBSkYs4+/vTNS3pOTYnG03zoU4kegeLlivL1PuioY7diY
 L
X-Gm-Gg: ASbGnct77/L2hfsVXTRdyAWDvRw7p2oPfId32BLHss8SjWv6u1Zp9YEdDGHrWVErUMu
 SJ20XtIpuQwopoqX7b5aGIyo2L3bYOyuRkhAr9mDz0SE9l+mSwD7Bb/83TnKO54yAx3+KZSpo7s
 yMyW73WGSgqxWSGSc+vqUDG/XsfKcB/IF7Ocibq0YVeFtr1VKzbilVGu1TkkNYlUI9Pi4Spg6Ay
 khXSbwbt0yMYbvyRQLQ/3WO3ZagCSIH2CRzGnRTqK/ZqW0TwnFDJMQZL86OvuVXp5759Cm0EISI
 FA==
X-Google-Smtp-Source: AGHT+IHvgrG+Vxh80aESNK0fAoUiCqDs2x5KkfWQpFmbuQ13VFeS9UXuUUm3mkhFv7zgGZelF326cw==
X-Received: by 2002:a05:6000:490a:b0:385:f821:e97e with SMTP id
 ffacd0b85a97d-385fd3c5a6emr3479698f8f.9.1733256511602; 
 Tue, 03 Dec 2024 12:08:31 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.146])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385e940fef3sm10043546f8f.42.2024.12.03.12.08.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Dec 2024 12:08:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/2] target/riscv: Include missing headers in '*internals.h'
Date: Tue,  3 Dec 2024 21:08:26 +0100
Message-ID: <20241203200828.47311-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

2 trivial RISC-V oriented patches extracted from a bigger
series which refactor include/exec/ headers.

Philippe Mathieu-Daudé (2):
  target/riscv: Include missing headers in 'vector_internals.h'
  target/riscv: Include missing headers in 'internals.h'

 target/riscv/internals.h        | 3 +++
 target/riscv/vector_internals.h | 1 +
 2 files changed, 4 insertions(+)

-- 
2.45.2


