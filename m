Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63003C36010
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 02:52:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2LXa-0000qZ-Np; Tue, 08 Apr 2025 22:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u2LXZ-0000qC-5o
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 22:51:49 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u2LXX-00018U-NN
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 22:51:48 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-223fb0f619dso63292865ad.1
 for <qemu-devel@nongnu.org>; Tue, 08 Apr 2025 19:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1744167105; x=1744771905; darn=nongnu.org;
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QPiY1prE7z9YET2feIy8aPCIDH6lUmFCJMHa3i6GVMA=;
 b=THPaneVXxITnFWPKSquoVqiNjg5eUzEXyYnDw+A74WF9DqeBH4u3IfydE5dl3x/89h
 wzcqj6xKbfm3zJcBe3u3nB/TOG+RVfMq8Mt5H2++0jAUhLhoas5fwr2bOdsXKaTVT/ko
 zC1fEPgi/6Re2C8Um6K9U/R109aLDq1fw/l8e3jijnSSXGa3LDIYRMYiDkf3pvhOQjy/
 5cGs3kpENqRqE0edI7ovgGLDubuubk3cYTh5tCPwyOBBtoSYLb7l0+YcAFR3/fj/HAf1
 Ved3d1sTKttcNcUS13bbUDJIJ7lOyb5pSjMbZWnacAqkvG9EXwMtP57zRPlwrdloCxGR
 paPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744167105; x=1744771905;
 h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QPiY1prE7z9YET2feIy8aPCIDH6lUmFCJMHa3i6GVMA=;
 b=mzvHyxPXSGYAFrF6aeB2Lm1Ga4SDiilZ7fmI8moeLn80+eF8xVtHbrSSSXsjuFI30K
 sx365Yy2Y6DJT69NKT2g7pKNP6myO2Goy/7JnCyTCfi6zTXqispE7sOtXZt7kA6qJcMn
 UFvrxn4paoLMvGeFr2S6ZRKofwrckb8V1oSnDwO3qAjJjplrQkZrs/JF4j1Giqk/W2Dp
 jgRh+ypcImGc3gK7H5sE7STJdB6vlzZDhsnywOqbECxZOszqzOqSj9KY1j+YfD8cY4uV
 rAs+AR8mATrwZtprysdyzVTowu4s7AWoLbQKSpdRFS7lOjLheAguvvpQOVuMTfGd5gE3
 SRHg==
X-Gm-Message-State: AOJu0YwXCLBHjJOe6uaVlrrqmzjXcUFYD0CSRd1Hw5sOlZRZm+NZZqlt
 f/YhRgIZ2yiqvNDeCqhJz6zOYXJGXIDrfgAcuSA51Rl3LeLgJcUKSx+Jil7VnycFWi9CH++obRZ
 npp2f3TEfhGf0kdgZhuerjETHPGhrNxpkSMlK7dM33S2nepV+ntsp3awO3g7JVhyNfm1+3v6e9v
 LlLEqK8X9iDwePFXRE9JrSnYoUAiwzBkVKOQ==
X-Gm-Gg: ASbGncvPcwXyiJzu5/qh2ThuNFU7hQzm0f3ZTRQ//6Mkj/DDvabrtXzxUA4z8Jr1mJn
 Oay1tyMMNAknYtsi4dbmTQywfwHiOZM1ae/qCaK/3sEeJTIUlRNqHD2wowg0PGG2HRqXEsdV6zr
 93hBcXv46kKEtxedcReTnjIkJNAkmvakyw+Bfwnd5gVC0kr3rEHh/myxw1nRo7Z0DW0TqguGLI6
 GY0dXfyZkxVrM+gDRtX4orXuGDPBD9bmmIDBNxyR3qbJY4EDiOU5b+DedNzQA49UMiQv1egsNx2
 uN1Xd+gLVBmmYGMw47RytMR4mjbaNiMRD0uzMDFdNdDQxu2WTKMNLVXC3krhS0KhFkI=
X-Google-Smtp-Source: AGHT+IGmvyG95mdgz9Ca/sM9ETWgF4AZxzp8VStWkQlVT8geD6HgdeFBkLTBfLMp3E5aEDbPkXKgug==
X-Received: by 2002:a17:903:2c6:b0:223:26da:4b8e with SMTP id
 d9443c01a7336-22ac296e291mr26583775ad.4.1744167105386; 
 Tue, 08 Apr 2025 19:51:45 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7cb5463sm665725ad.195.2025.04.08.19.51.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 19:51:45 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v2 0/4] Several sstc extension fixes
Date: Wed,  9 Apr 2025 10:51:27 +0800
Message-Id: <20250409025131.3670-1-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=jim.shu@sifive.com; helo=mail-pl1-x62e.google.com
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

This patch series contains several sstc fixes:

(1) Writing to ACLINT mtime should also update the period of S/VS-mode
    timer, just like M-mode timer.
(2) VSTIP bit of $mip CSR should check both M-mode and H-mode STCE.
(3) Writing to STCE bit may enable/disable sstc extension in S/VS-mode,
    which should update the timer and IRQ pending bits.


Jim Shu (4):
  target/riscv: Add the checking into stimecmp write function.
  hw/intc: riscv_aclint: Fix mtime write for sstc extension
  target/riscv: Fix VSTIP bit in sstc extension.
  target/riscv: Enable/Disable S/VS-mode Timer when STCE bit is changed

 hw/intc/riscv_aclint.c     |  5 +++
 target/riscv/csr.c         | 53 ++++++++++++++++++++++++++++++-
 target/riscv/time_helper.c | 65 ++++++++++++++++++++++++++++++++++++--
 target/riscv/time_helper.h |  1 +
 4 files changed, 121 insertions(+), 3 deletions(-)

-- 
2.17.1


