Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8DA9CC6B30
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 00:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH9LG-0001c8-6X; Wed, 14 Oct 2026 20:29:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xH9LC-0001bL-DC
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 20:29:02 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xH9LA-0000wC-BR
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 20:29:01 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-3ac6971aaebso171929a91.3
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 17:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1792024138; x=1792628938; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/UEZ48QC3Os0vi1kIg7gMtuvAmT1VrIysmcWwHvMwVQ=;
 b=eLxeYRuAkSJa+MCphjCkgkCzt4sGEU1UMkZyl3fep9yM57bw+U1ND59XwdYbThuQsO
 oZEwC9qAaJXxvPRCUrLZWKfzu0Y1PJYYqmkuwasCFeLxgBL17lRzfiiwOZ4qQ2+2uW03
 39zjZ5tjXWg2Lw33wkg3fsMO6phBtdKK44z/BUAB7XoMW3gj0d6JEQXywVKOWidjvyQD
 WXaUiaFPOJ4zrYuwNdH6HXe4JCBDvCV/8MtJSnHa4HrFtrKuSc2TmYmUJC0zd7y3ksH9
 w8Axhp2XWYKXTY9O6NP+IJRuOimyA9urEecKR8vC0t8XVeVAMW7F7oiedU0f2NiJwg2s
 0guw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792024138; x=1792628938;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/UEZ48QC3Os0vi1kIg7gMtuvAmT1VrIysmcWwHvMwVQ=;
 b=Stt10gEJFRXQmhKZXF3l/FfiIorjXUBEm0CQUkNr0pblXUxc15vusS2fYqE/ny9qZS
 30oiidBe9uvkaSlm0jzUmU71hzd9a7NVqE6nbi4E1OPgPzD0umgjuXD0NUqpN3sbvIGg
 euInsS++QLKjx9Zwfn1AD19mjO9skm6ibCqBYYY+pPIUrqe0ToTPjM6a/m+g3oBd1cnh
 tBfQRLaCIXBKZ95rTQpf2UZb+8MWItriMzF8AOyczEs4katJUQoFZiG0bzTUKm/+Tmnj
 Ne5acx87BVhJ4wl4TW/FdJfDDOr134UPBP6YNLvgDgR6NE9Yg7VV8nC8aTTnzoa1dCrT
 +uCA==
X-Gm-Message-State: AFq9FYK8K12Iyj20P7YoCodFqvvl+FL/kr4uenabIl+68qoYemSXWVe8
 okInIp4o2ClvPD/cLgL/b7S3peRsQMxdt93xP2Bi9ABYHQQNG49KeJNP/9V3PvrBSYKUvnKdWvc
 5GNj5
X-Gm-Gg: AYBFou2LgE9W5a6QGfi3OBv3yBNSzUg2ufEbKHl0be0/LtJkN5LSkdlEVZrZHZ9aKyV
 BUyeSctEKAFAx+EFq4juj2RipyDv5vD6SJkOell775Cp3cgWrn0YkybTEioF8bFko5beBgb8qNi
 bwbz+18owPr4Fn7SpMOLPa138YR1MnahA0gYhqdRZ/xqApzGO+Q6b5KaLWRmwvHSYlFqppNPts9
 vZLFQacw8Kp4fC9IF/avxXyVuWqA+dFD0TCMmcGJd3tytYF/xXcBYA2I3DBQtgwc/dh4v1Ho2SC
 BxXcIKpAp1nPZLfZrOFvwaea3W79v9HS8JFWrziYnA2IUhds2MlkOv8B/BubckfKEqdmZ9poBYR
 3OaJR6hQAHkIH5lcHBNb7496eHb/WkN5hku+J0Q6D8jf3HNAFQlAGi9ElJAQ9UfmMOQmdQFie8m
 ZPRpv7vs1wG7GKN+5fLaxd/836AttnxZXzoUFyHkZpa8EVbteeryvpyV6s9/KJoKxH1nWUJu2x4
 g98/q+6zuueTaKSpXVNdSzvKXWVdJO6Pm0RjagXYdKwDH8=
X-Received: by 2002:a17:90b:224e:b0:3a8:9db2:a59 with SMTP id
 98e67ed59e1d1-3ab3a0f0a2amr24973833a91.0.1792024137899; 
 Wed, 14 Oct 2026 17:28:57 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac92a49d7bsm795730a91.0.2026.10.14.17.28.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 17:28:57 -0700 (PDT)
From: Portia Stephens <portias@oss.tenstorrent.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu@processmission.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 Michael Ellerman <mpe@kernel.org>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Alistair Francis <alistair.francis@wdc.com>, Joel Stanley <joel@jms.id.au>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v5 0/3] Improve modeling of the Atlantis UART
Date: Thu, 15 Oct 2026 10:28:46 +1000
Message-ID: <20261015002849.1640109-1-portias@oss.tenstorrent.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=portias@tenstorrent.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The Atlantis SoC has a DesignWare UART compatible with DW8250. Previously
the Atlantis machine had used the ns16550 UART with an unimplemented memory
region backing the DesignWare specific register space. This updates the Atlantis
model to use the now modeled DW8250.

The Ascalon console, uart1, remains on the first command line serial interface. The
other 4 uarts are not added to the command line interface yet. They will be added
as modeling is added that produces output on them.

Changes from v4:
- Rebased to include PRCM changes.
- Dropped uart2 through 4 from device tree, this should of been done in v3 when they
were removed from the command line -serial.

Changes from v3:
- Drop machine property which changes the ordering of the serial devices on the
command line and update documentation with the change.

Changes from v2:
- Fix typo in documentation
- Fix white spacing issue in machine help text

Changes from v1:
- Drop DW8250 fix, to be squashed into original patch which is not applied yet.
- Use qemu_fdt_setprop_string_array for creating compatible string
- Change machine property,console, from string to uint32 and set default value.
- Documentation fixes

Portia Stephens (3):
  hw/riscv/atlantis: Use dw8250 UART model
  hw/riscv/atlantis: Add all UARTs for Atlantis SoC
  docs/atlantis: Update Atlantis UART documentation

 docs/system/riscv/tt_atlantis.rst |  7 ++--
 hw/riscv/Kconfig                  |  2 +-
 hw/riscv/tt_atlantis.c            | 68 ++++++++++++++++---------------
 include/hw/riscv/tt_atlantis.h    | 13 +++++-
 4 files changed, 50 insertions(+), 40 deletions(-)

-- 
2.43.0


