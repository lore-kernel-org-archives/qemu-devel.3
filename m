Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82FDFCA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:41:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBoux-00018O-RB; Wed, 30 Sep 2026 03:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xBouu-00016S-Su
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 03:39:53 -0400
Received: from mail-dy2-x0d.google.com ([2607:f8b0:4864:36::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xBouo-0003pd-0w
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 03:39:52 -0400
Received: by mail-dy2-x0d.google.com with SMTP id
 5a478bee46e88-34ca54bfc48so509777eec.3
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 00:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790753984; x=1791358784; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bPrjtbYzmeEJemPPRkZ4crVJ0qzXGov83O1lfy6nOkA=;
 b=lFiL5R1WUOANM3rvdYKKe05ff4wYkZUv6WEDUHd+W5cQPti6N6WhPuC2buMqaXczD/
 DyfzbzqIP6K8F7K5yxga7uHPEqYiryz4/+EG9YhE4kpRTnsjYzcU9syrEtJuumezVrje
 2NELcb4YyxSHOwVpyJvTOJlIqDlsvMI+z8gQGQJaIdbzKQ3pN3pgG7KIfuluxFvGNJbS
 kpLaYPv3MONukP8kgr8nKMRXZKfyushQLsBUhIZYfG0J0I3oyPMfSLnO506b+cfNaf65
 TPYlqUzC4ApFU6wFIQsIpLfGl2leGOiuBz+j4S7WtK8aZGpyKyXdkOpCsVWbxkg0XsQQ
 bmYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790753984; x=1791358784;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bPrjtbYzmeEJemPPRkZ4crVJ0qzXGov83O1lfy6nOkA=;
 b=xDtGF9EYukd5rWmdnvrhdpII3+NNuGC6gnsl3YGc20craOryr7QOz8qxNfnAKTYtMJ
 An9Hs38sWk82Zuy2wvj+UGPkVG15DDu6V6O0wztJderIimbm38zKzMH0Yzjybap2p67p
 npn21P7FcTx/cOK8Vn1kcoKIdhL1YPrLoQYdNa7geKvkEMrLAjYVxuBJHOqmeNwFH7IN
 TGh+eS6oN66agt0bjQ6WF+rOi7RE4FVrN3eJ6Ht+yF8Ykdu9P+Gg8OP0l35EOM/kObM7
 KzDutzAmfvRn7vP2tVqXwWb6BOxoQ4xrs7LLwxsN9Im2otkZLFYStbUlSgyEPaRzoXj/
 mWww==
X-Gm-Message-State: AFq9FYKP12zlOmYWU4lgdlMfdIyS1UotsEc6RaKPo7kqRiWrXKsEU+nM
 3ZkAJP9Cs9+ZZ041DBMxGgoIjVYoGyZOGlqQ3NcPeaOhpYCHNtS2wpGMvMWq+3zz
X-Gm-Gg: AYBFou1UtLxdS9c51JQeyC8Q0I4dYG1xChFm37VUS36k0Swo7webtfuGcUCdYag383Y
 vSVzfstini7pR0RH1BNefGeAFgE3j9jDUBoRxwDWDwM5IeGcW8LLvio3I/a1dQYT5Wt+csxO6Jl
 93aT5voayxiLNXJKpXI7gCkviw0ATK8V8WQpvenUF/adpK2QkWlEo0/8851WNP/Tqnm+taKCnaF
 j+6KzM5TRLMZW0Jwr9A/LwJwR35M3EWVdltL71BIgBBlUoklocNXuMFhZ/UdmJARot43itsbLEg
 2nz9bAlIibCD1ilx/jEmiTiXiTlg326pLj4pVcOf25H59FOVldA9ie7AgTxvtUF9AlVYq9LCawT
 fwr8Hc6//+ZK9M9v7t+8UuvqRDs2RlAbmzBThhOwYwkRi+WgqxoMJzXl+axmBqe9o0UBd6pqWCx
 mbvie43YgGcb0V806ihu2ltF0WAVjxuu8WxAV+x8VTVrpdpcBt0BJnJB6H/sRVWduh70JPM4K8n
 apoEg/fkiYHYiLEPA==
X-Received: by 2002:a05:7301:2624:b0:34c:7d49:35cd with SMTP id
 5a478bee46e88-34cdbbd5d9dmr1003981eec.11.1790753984370; 
 Wed, 30 Sep 2026 00:39:44 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-34cf5b4349bsm1825773eec.25.2026.09.30.00.39.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 00:39:43 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Song Gao <17746591750@163.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu@processmission.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 0/6] treewide: uniquify colliding helper symbols
Date: Wed, 30 Sep 2026 15:39:27 +0800
Message-ID: <20260930073935.712-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::d;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x0d.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=no autolearn_force=no
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

A combined qemu-system binary cannot export the same C symbol from two targets.
This revision addresses the review of the original series.

Generated TCG helper symbols are namespaced centrally in the DEF_HELPER
expansions. C helper names remain generic, while target linker symbols and
metadata get a prefix; core helpers keep their existing linker names.

- Set TCG_HELPER_PREFIX per target and use it to namespace generated helper
  linker symbols and metadata
- Retain explicit i386 and ARM raise_exception implementation prefixes, with
  static inline wrappers preserving the short names
- Prefix virt_acpi_setup and virt_is_acpi_enabled on ARM, RISC-V, and LoongArch
  virt. Leave the ARM trace event virt_acpi_setup unchanged

v1: https://patchew.org/QEMU/20260926110818.1912-1-luoyonggang@gmail.com/
branch: https://gitlab.com/lygstate-qemu/qemu/-/tree/global_symbol_conflict_resolve?ref_type=heads

Changes v1 -> v2:

- Drop individual helper_wait renames on RX, Hexagon, and MIPS and RISC-V
  crc32, crc32c, and wfi renames; generated helpers are namespaced centrally
- Add target-prefixed linker symbols and metadata in DEF_HELPER expansions,
  with TCG_HELPER_PREFIX; common helpers keep their existing linker names

Yonggang Luo (6):
  hw/arm/virt: prefix ACPI helpers with arm_virt_
  hw/riscv/virt: prefix ACPI helpers with riscv_virt_
  hw/loongarch/virt: prefix ACPI helper with loongarch_virt_
  tcg: namespace target helper symbols for combined builds
  target/i386: prefix exception helper implementations
  target/arm: rename raise_exception to arm_raise_exception

 hw/arm/virt-acpi-build.c           |  4 +--
 hw/arm/virt.c                      | 12 ++++----
 hw/loongarch/virt-acpi-build.c     |  6 ++--
 hw/loongarch/virt.c                |  2 +-
 hw/riscv/virt-acpi-build.c         |  2 +-
 hw/riscv/virt.c                    |  6 ++--
 include/exec/helper-gen-common.h   | 26 ++++++++++++++++
 include/exec/helper-gen.h.inc      | 48 +++++++++++++++---------------
 include/exec/helper-head.h.inc     | 25 ++++++++++++++++
 include/exec/helper-info.c.inc     | 24 ++++++++++-----
 include/exec/helper-proto-common.h | 26 ++++++++++++++++
 include/exec/helper-proto.h.inc    | 18 ++++++-----
 include/hw/arm/virt.h              |  4 +--
 include/hw/loongarch/virt.h        |  2 +-
 include/hw/riscv/virt.h            |  4 +--
 meson.build                        |  6 +++-
 target/arm/internals.h             | 27 ++++++++++++-----
 target/arm/tcg-stubs.c             |  4 +--
 target/arm/tcg/op_helper.c         | 10 +++----
 target/i386/tcg/excp_helper.c      | 17 ++++++-----
 target/i386/tcg/helper-tcg.h       | 42 +++++++++++++++++++++-----
 21 files changed, 224 insertions(+), 91 deletions(-)

-- 
2.55.0.windows.3


