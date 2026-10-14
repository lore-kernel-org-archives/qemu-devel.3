Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 436B4CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:24:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGpaz-0001RY-UU; Tue, 13 Oct 2026 23:24:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xGpav-0001PZ-T1
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:23:57 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xGpau-0000Ae-CA
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:23:57 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-3ac6971aaebso31092a91.3
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 20:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1791948235; x=1792553035; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nrYsENVD8zdMhtoEX6QKCVYJtOjayshuscETwfnfCfs=;
 b=LaziUpmCWsSCxH4uPDfisZy7sOlw4CFG6JakPTn/QmU8IYf7C5zkmLLUBSG3CTp8LY
 I5p6bnHklIwazV5ZpTKy/iaiJWQpOZOFQnwoZ1aqyqBpkhml5AyQB8xDQDL56E4lD24i
 39XurYItr57JYN2SLfG8O3195xJlYPF7IbYuqN3L1nkW8ntvGGreAjwB7XNTMa10ov2c
 wjysrYdQVaecc5jRDLyuPB9M3369gPN4RnPtaDGTQlP+6LcklHMhx1Nq+LVoqVIpai9A
 nuIiFlWLi038iFI/6+AR/bj1mIGYxwh4alIg2QHO5HAqG2PuTqNKoeLHY5EizkGwehMd
 UB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791948235; x=1792553035;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nrYsENVD8zdMhtoEX6QKCVYJtOjayshuscETwfnfCfs=;
 b=cmzXAtLsVbGS9bXk8Klg0RCWyk4YlRr4Ls5nls04yqV+tH785szqP+Hn4wsQmtuoUx
 IX+hd+5o6vC/ghke6SeXoWm3KG7SFljIlfNcXRfeKUffnVQdWxjQiWpOuQcQXouCSUv6
 AH20DtowvOhhyEfoHhaX9Sx3lsM34yTWrH4y5wa5nrZH/eJvr+mv8b6j9jkysbUhtYGb
 7vOdRWIMupOuzrKwoPJgRbK/Z/x8NCYB6lscgYiCZsjPXR8LxUuJz2lMQHjzp4Gvv3HU
 229or/C9rQcGB/9yqKHSs5UA/swl7g070eGnTDLdMUgVFJBpopmWVfNuz6LROeEaGpF0
 lB2g==
X-Gm-Message-State: AFq9FYLyabY/vMPEt5oOXUGuihilQsdLl1HvM5UgghGtbzuqqFX8cuzf
 3TYUd5A5t0/xKW6Lcyu73PaBdd6rcqiyL6x1WZXO1AgSaZTLcHvWIfRiMIe0dftw/KxOA3M25lD
 ipO7GAXc=
X-Gm-Gg: AYBFou3/+QC/Kw4KaY6o8buHjsV1vZwE3bfvjIjbJMJ+wzyFYGLSx4jWTtw6ffxjSRH
 QR4orr39hLvAeKGg5Pi0DK92xqkpEHcUV6gcZBXzxDFeyHj9H30rVByEy659CUiNMTeEPUzpUhF
 QBBegznKoXh+01BF2YyUl9lc26x/MzYbLd9BbfoXcGBl1cm4+NxPucJcNjwQVGPUEIBybvL+P9M
 sWxa8cukdYAfLz65PpmENliOTcSzlU65JIVFbBGQ6j7HvWkCNFNct3huSCKAJNnzRLKlGSKWy9t
 tLuCUYBSSaTpT4vTSFUhXdRIgzLs+nZ+g3xkUnSkD/0LRPzbsJ93rrIraXC3ADcuG5wXTIY0I6K
 q28IB7ZM6yapmCQJ94uOQQG31GyQ3y/8P+5FB5YURSq1yAVBsRVb9l6diwPSxMVva5FbJY8BkDI
 oegTCDP0jkRitjoSnJMEBgMFpnvTh1yuo+aVUQmT1/RJOVg5avF2jK6UwdpegtaVlxhQeOXGZ1n
 Qnp0+t0Tw/E/5434ko3Wx9K8bHh6S2DByCsssLGDHm1iTM=
X-Received: by 2002:a17:90b:5343:b0:3a7:a463:54bb with SMTP id
 98e67ed59e1d1-3ab3a9f73damr19048686a91.5.1791948234856; 
 Tue, 13 Oct 2026 20:23:54 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac6069ca15sm2211261a91.11.2026.10.13.20.23.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 20:23:54 -0700 (PDT)
From: Portia Stephens <portias@oss.tenstorrent.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu@processmission.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-riscv@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Joel Stanley <joel@jms.id.au>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Michael Ellerman <mpe@kernel.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v4 0/3] Improve modeling of the Atlantis UART
Date: Wed, 14 Oct 2026 13:23:43 +1000
Message-ID: <20261014032346.732257-1-portias@oss.tenstorrent.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=portias@tenstorrent.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

 docs/system/riscv/tt_atlantis.rst |  7 ++-
 hw/riscv/Kconfig                  |  2 +-
 hw/riscv/tt_atlantis.c            | 83 +++++++++++++++++--------------
 include/hw/riscv/tt_atlantis.h    | 13 ++++-
 4 files changed, 61 insertions(+), 44 deletions(-)

-- 
2.43.0


