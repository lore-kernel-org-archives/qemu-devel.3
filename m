Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1600C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 13:53:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woLm8-0001tG-0m; Mon, 27 Jul 2026 09:53:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1woLlw-0001bm-Ut
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 09:53:37 -0400
Received: from mail-ua1-x933.google.com ([2607:f8b0:4864:20::933])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1woLls-0005ov-5y
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 09:53:33 -0400
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-9770e900464so2084776241.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 06:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785160411; x=1785765211; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qvOR5nWWCgPvi/atiGH4p7PiFZ0yjiwRhfadGgflXrk=;
 b=fmt0OIpLZDGyF2mNWF3OvAoU3M2ksf2BsTNM49XLQUBxBFixnfo25Knig0sUc8IPtk
 EzZD4KQOIH0F7MXccNAqoQd2GMhsZCGDZFrqPHuKozcyum220qEhOfotx4dG5GqSHeU9
 4gxisSJIfF74ytMo+o0Ck5wr+FCev2O0k9zyCq/0GlkUpOJSEviLK/uj6o8jJPkt1WNS
 E+wDSBiqhYuQHqrqsUOjr72wq7e0AJuixJXhSc1Uw/1oIVj8pQ2Jg2ODlUfzpTCByteW
 XmpINDmXbj1BKdDW6MtCDzgYFCkfPiULkKVQHPtoqIXFVCaEhYI1iDnA40MYVmx+0WXi
 hjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785160411; x=1785765211;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qvOR5nWWCgPvi/atiGH4p7PiFZ0yjiwRhfadGgflXrk=;
 b=UvZUrdclfCBhXEhShn/azwN1h4+cYa/QpsJXmB4hFwCw5rOQEfFXmQHV+0X0p1QW9/
 KrNKV4BDe/7/zFbcBjL58J/r/IUD0ziGYEjGd7YKcLjVbN8CMNQyPjPOqUfeobq8k+Ne
 mDpyHHRVdCiTUcG0n6QUKatr0Zy+JlT9LC9sp69HC6QSw8/7JDhpDj0FWnVR6ofYcylC
 YDAagIsT/P41zPK6twggse3LOwJ8HQYqCd0nesJhajsr4SwIBjgoI+J3/VzoUo6EmYTj
 Lj9dCieNAtTO9omC0V9kCez4eF9Dp0Mtv2qwumZ1c97CVeBYCfHVTAGp10GlHRk+O3jS
 5PKA==
X-Gm-Message-State: AOJu0YwAViXO3triwd1HhH7HAS5ZHwzcANEubAjkr+G+ZvpwRAv2nDiT
 EVG/TLcdlxk0JJd8C+f036USNs3+Gkp/62MtHTrdCdL4ahTcIO60MFosr6GgCQ==
X-Gm-Gg: AR+sD12nlY89T3+Ads3pgO38CcVjExzBxTnmuXZM78Lk1sOok1x+nsgE2eI1U2v5XHK
 4Lli725ohnctF7q2rwZYNk0RVwNX/tQ5tdfRsh5vYqf+pXAAHPW+vCZa6DEgtx58kqikU7lShwb
 WYnzbjuAfVL9yZgn7JUyJdfXbesT8lhFjprEz++LCRv5BdNjQWjUDipzyQPvSqS/daRcZsVoFSk
 bGBepT8zubB/YFenR8tDaPB3/69h7ybKRk0xhVkvw+R5oSfsbMHw9hfAPP0wS41PtaKqOUpes/r
 o7Xz2NXMntPfq+/zNh6Vj+EjBrjqXrEHeS9iY1SkPCw7pGgUif30c1i08v+fCJESlwJf3xT0dTQ
 Wa4YTymxTugjeNepZm9rDDmiuio3zu2UKGWbJvcLi77lxr/M2lQo9sVqL6YK4r6TOcFPaiaPZXM
 8yLOpZvQihM/jvIOKyJ8JD/aCbgM1GpJ6S
X-Received: by 2002:a05:6102:a158:b0:745:36ea:415b with SMTP id
 ada2fe7eead31-74f9d08e737mr3505686137.5.1785160410957; 
 Mon, 27 Jul 2026 06:53:30 -0700 (PDT)
Received: from localhost.localdomain ([146.71.8.128])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-97774ce146csm5199734241.7.2026.07.27.06.53.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Jul 2026 06:53:30 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Marcelo Manzo <marcelomanzo@gmail.com>
Subject: [PATCH v2 0/2] hw/arm/raspi4b: fix guest RAM capped at ~1 GiB
 regardless of machine size
Date: Mon, 27 Jul 2026 09:53:27 -0400
Message-ID: <20260727135329.97190-1-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::933;
 envelope-from=marcelomanzo@gmail.com; helo=mail-ua1-x933.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

While working on unrelated raspi4b issues, I noticed the guest never
seemed to have as much RAM as I'd given it and tracked it down to
hw/arm/raspi4b.c's raspi4_modify_dtb(): it decides whether to add a
second memory node above the 1 GiB peripheral hole by checking
info->ram_size, but that field is the boot loader's RAM budget for
where it's allowed to place the kernel/initrd/dtb image, itself always
capped to at most UPPER_RAM_BASE - vcram_size by
raspi_base_machine_init(). Since that capped value can never exceed
UPPER_RAM_BASE by construction, the condition was never true for any
raspi4b configuration -- the second node was never added, and the
guest never saw more than ~1 GiB of RAM regardless of the machine's
nominal size. board_ram_size(info->board_id), computed one line above
in the same function, is the value that was actually needed.

Patch 1 fixes it (one line); patch 2 adds a regression test.

Confirmed via direct measurement inside the guest ("free -h" /
/proc/meminfo) on raspi4b's default 2 GiB configuration:

    before: MemTotal:  943524 kB (~921 MiB)
    after:  MemTotal: 1905824 kB (~1861 MiB)

Also verified against two real, unmodified Raspberry Pi OS releases
(Debian 11/Bullseye and Debian 13/Trixie): both now report ~1.8 GiB of
usable RAM instead of ~900 MiB, with clean boots, working SSH, and no
kernel errors on either.

I also looked into extending this to raspi4b's real 4 GiB and 8 GiB
hardware variants (real boards exist in 1/2/4/8 GiB configurations),
since board_ram_size()'s encoding already supports arbitrary sizes and
this same bug meant the necessary split-memory-node path had never
actually been exercised at any size, ever. 2 GiB now works cleanly
with this fix (tested above); 4 GiB hits a real kernel panic
(`kernel BUG at arch/arm64/mm/mmu.c:192!` in early page-table setup,
addresses landing in the BCM2711 peripheral region around 0xfc000000)
that looks like it needs the "high peripheral alias" real BCM2711
firmware sets up for boards with enough RAM to otherwise collide with
that region -- out of scope for this series, so I'm leaving 4/8 GiB
support for later and keeping this fix minimal.

checkpatch.pl is clean (0 errors, 0 warnings) on both patches, and the
series builds standalone from a clean worktree
(--target-list=aarch64-softmmu). All 6 tests in
tests/functional/aarch64/test_raspi4.py pass, including the 5
pre-existing ones (no regression) and the new one added here.

v2:
- Dropped the explanatory comment added in raspi4_modify_dtb() in patch
  1 -- the commit message already covers it, per Philippe's review.
- Picked up Philippe Mathieu-Daudé's Reviewed-by on patch 1.

Marcelo Manzo (2):
  hw/arm/raspi4b: fix guest never seeing more than ~1 GiB of RAM
  tests/functional/aarch64: add raspi4b full-RAM regression test

 hw/arm/raspi4b.c                        |  2 +-
 tests/functional/aarch64/test_raspi4.py | 51 +++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 1 deletion(-)

-- 
2.47.1


