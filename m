Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B17FB44A6
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 05:06:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG8jB-0003uF-8H; Fri, 24 Apr 2026 01:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wG8j9-0003ta-F9
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 01:05:19 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wG8j8-0005ox-0x
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 01:05:19 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-c795f096fa5so2968332a12.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 22:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1777007115; x=1777611915; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CXMRdCy/jO5ji6VxuLOdP1y96Lz9QhuVwjAWmb6jNWU=;
 b=NnSzmkl25b7T6ywaHvKwmX8ltbe/8/5Xy3ZoMwsGCdCvBuwopp7siNNaYs7vUXATjT
 Gt+1cEkkBWSsRVz5m7kgL0PLFXpHNAYcng8sz1BZHnuLdSCbwkii1MDTYfHN2NwXEcTC
 UWrtT8BNHsyDjDquAV4ldR+3RH32548Z8QamRRquiwED/PlX3BBB+zir2kQmmriVY7Po
 KrGp0W+KL43R479BdHY+I4emF5t554hvQm/Cnv2iXaxLsSnKvG6MhCm7CbdzQr/JUIFV
 CAiNST3IEO2nbrbhzfjjE6Fga9WV7sv6q7C0dBAH2JX3kwagZgBHTttLZ1yV4+wnodzC
 vucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777007115; x=1777611915;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CXMRdCy/jO5ji6VxuLOdP1y96Lz9QhuVwjAWmb6jNWU=;
 b=ONNT4zMTJO+z9jM4DP0XYOFVsYyh0pX7jVJq660lvSZyLrYwQeKrRbIHvvhgdjOVsH
 QXgDyWZf4aYV3FPxX/ptpKc8ZJwefdbPvqbkxIiI0jT/Mqim8S974dVRuYJhiYmOK9lx
 8ut8VJTsG4f9DwVa2o6yDA/D93CtLbKsAky0+VXCkDn8118/0dXSKF5SsbZsgfmuewbR
 lFs0LpyyGOnNRyjnlcIs3F6UYOTQEvkKtgUnF51N63VCyA7IKRkRzVdOuYc6DzaNnlc3
 shGlj1LugJVYCXXuMdVRYAXhczJ5+Df1gIdMkUSO8M9NN+hSDaPvbPAZ+l6ZVcNOLIw8
 JB3A==
X-Gm-Message-State: AOJu0Yw/qIQTGiJUUr+E6MEUV2D7Cam+6fs03U7gl9q4HVKEqmCW/b9k
 ok7Syecm6GNTjGR9V4xGRegsrc1KOEt/i9jmerYsZHO9b1c2AK1FgNwdBH6KAMWq6j1GW3bfUfz
 gbRyWux5PJnprKb3noKUkO2tJOIV6LnJuWLGUW19HrGo9wanOZzzVP5xdPeSmp4SQWqi8D7Z9Nf
 9WNssQPE7tOAR7D76DB/jsbRfyFPRfxbDmLgIuykGoA5vk5Pb1
X-Gm-Gg: AeBDietgkRuVySP5WscXWnzwS98gbXKxEvM30h42g5ISRpklCTdCoMH103/99RUHy4R
 V5XPczyBM3Q2VAx8JJJomHlCWtXhSJrbw+Wm8cb6FZ6qaGkZlg699winTiUNdjZu6ZBWKdNhqT4
 kqwltN0qtZEEV9nPLhgP2wvxc9OA8Yltm3xJyJkRZ1s3OHiMyY6Wb7nKSqoWus4HoSJhjUcrYPC
 WTiHbS5k4UCK5EmTANtzZI5Y6aqVGR5oly4/jq5nfvpcUNq3/2sfGzrpOLou4PblBimXIvAapm6
 Fx4vQHREzk6Bok4SFREWndh+wFArOalyN9gZbYbIZaMT/X/6ylkHM6lLexfvgQVHYOrp6lRIAnh
 PAnrq4eCapasjvYPIB87tSvPGTfDXJxxgf1PAlb9M3nlRtFKmTOC/UNMAK2zBWYVVk+15P6/DRZ
 uhSgN5c00/lv/asfnSQjcwtajYEOIhWTGkM5xJQNkmBS8gbLlaLOt7ZgSqdByT
X-Received: by 2002:aa7:8892:0:b0:82a:60ad:874 with SMTP id
 d2e1a72fcca58-82f8c8b56c0mr33123903b3a.19.1777007114870; 
 Thu, 23 Apr 2026 22:05:14 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e981992sm26698554b3a.7.2026.04.23.22.05.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 22:05:14 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v4 0/2] Set MISA.[C|X] based on the selected extensions
Date: Fri, 24 Apr 2026 13:05:07 +0800
Message-ID: <20260424050509.3935180-1-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x52b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Frank Chang <frank.chang@sifive.com>

MISA.C and MISA.X should be set when the following extensions are
selected:

MISA.C:
  * Zca and not F.
  * Zca, Zcf and F (but not D) is specified (RV32 only).
  * Zca, Zcf and Zcd if D is specified (RV32 only).
  * Zca, Zcd if D is specified (RV64 only)

MISA.X:
  * When there are any non-standard extensions enabled.

This patchset sets MISA.[C|X] bits based on the selected extensions.

Changelog:
  * v4: Warn user if user disables RVC but RVC is mandated by Zca/Zcf/Zcd
        extensions.
  * v3: Rebase to the latest to-apply.next branch.
  * v2: Fix the missing parentheses bug.

Frank Chang (2):
  target/riscv: Update MISA.C for Zc* extensions
  target/riscv: Update MISA.X for non-standard extensions

 target/riscv/cpu.h         |  1 +
 target/riscv/tcg/tcg-cpu.c | 54 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

--
2.43.0


