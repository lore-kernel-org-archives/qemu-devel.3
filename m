Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51618CA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 03:17:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBOKw-0004ec-N0; Mon, 28 Sep 2026 23:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xBOKt-0004cr-3D
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 23:16:55 -0400
Received: from mail-pj2-x2b.google.com ([2607:f8b0:4864:39::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xBOKr-0006u7-1y
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 23:16:54 -0400
Received: by mail-pj2-x2b.google.com with SMTP id
 98e67ed59e1d1-3a49b3e7bc3so88125a91.2
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 20:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1790651811; x=1791256611; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wQRpqb30JdS927aEFmUSHnoj4SoVnjZFUmdr6PiqntE=;
 b=OmOOnhrrVO4dRFCneSbl59C+RFH79Sw8GTnOXkB8OHJwK/L22kIoYg4trnuqy2XMYC
 9Le6CLv/bZzPsbM1UGuO0TB2ZAtxBKpZvhm8J0PFUpPusPDnkz9pYQaxJgGIq0zysZIC
 nXDAM2pU9b3uLylQ8Q92Aaj6s2aQyKrzI3QmjBY1rTix5LfT78FQLfTHEddokieiRgQF
 I2kkwP7YW3d/TDU8yWBXbLxeFFYM57Z/EPN0lhKDIhoejjYf1pCR5EHFPwFNCf8x5Lxl
 x38Wuv340rjCYT3y7x9sg5cTJhqGL3DD8l7kDhxNgrndfO0i/G3bF03gOF6Y1MGtIqYE
 ojMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790651811; x=1791256611;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wQRpqb30JdS927aEFmUSHnoj4SoVnjZFUmdr6PiqntE=;
 b=VK5oyFb6wvQUBm3V+VIjo5woDv8djwNU7W1QeYXN8tCtqA825OSht3cyOuvyO6HFl3
 JG2X6LZXm1ntteCyRHIT0oz2dkQVeqT+fduOL+Ion7TgSuOqlYMXpwgQtAPPEFG021Q3
 sN1JseGrBexNo5U7uhbS2tAlAI7LyijgZb+6xaU47FjQfvs/0H0DxHw4f6THo/nvGt/U
 iUDWgLtRujM5OZAaJ2Hs6CY/kHuVTPhGYPPEZW1UYx7fuYql3BmLBCOFq8TniO+W4JwL
 oDPYJ5mQNPVXeTG/AuXx6Mj14w5oatFSJU35VHVdJpC8zzL/mxpS8hhSUWxEbinrLK2P
 2U/g==
X-Gm-Message-State: AFq9FYLkDJoEl4qE83MRQPjqXkURBmHC85hj5M3CE2xp3SyJXa5Fgxu4
 Sg+MQdi9Bl5NeT4T/Fc28BmtcxIElXZKsjQDZGCg65KYVtHFLr3TWyFc8iMzv3SLrt8vDLtQML/
 gR+4aHR4=
X-Gm-Gg: AYBFou0tZ0Nb/sBRHQgBTiwiNz17GhYIwfccI3K7k8wC1WzUePCxWEDTzIchpdGsP/7
 70rY7g0M2f87n4vMA0HfBT4JM5T8wTXsEqrTX5H3LQ2KKbqKRNwtV7L30ZQqhiD402VJMl0crT1
 C9QTRluOxjCGrLUIxkDFBwvL7BKanlqB+GyA3aXsjkh+4pagc9xfrzn81JA/isZbwvKQMnQPau/
 D61c8vcCIBNgIPXL7bsk1VlPvDWo6o9jPjhNu4foa9kh9ZJ2oX1BVzVLDmdHmQM9syMfy+L6jDj
 QMflrFHM4k8Z5ctmKd0o+HmRLFhE+G+PvJr04Gt0InsOTFCU0cGXx6OB1YETXVidildVDhxOnpH
 V3goe7UvhK4eeMHWAVuNrf8BmGcU7cUt14Ae1RFl2EM39rBcQBsZfU14QcvT9XcaggSGWye1hIt
 VZoPOMH9rOEkd2GSMcUZ/3R4niSFXjI38cI+jqmebVa9Y2bpPpisAkYr927Bi3YYEB2LjXPauo8
 xOSD6ktTwfJV6/rvjSrHgxQVswib6fswKkIkcgts1qj1SA=
X-Received: by 2002:a17:90b:4c81:b0:39e:3728:3b11 with SMTP id
 98e67ed59e1d1-3a0b2507f4cmr17299719a91.3.1790651811235; 
 Mon, 28 Sep 2026 20:16:51 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a492dfc5absm1563641a91.3.2026.09.28.20.16.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 20:16:50 -0700 (PDT)
From: portias@oss.tenstorrent.com
To: qemu-devel@nongnu.org
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 Joel Stanley <joel@jms.id.au>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 qemu-riscv@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 0/5] Improve modeling of the Atlantis UART
Date: Tue, 29 Sep 2026 13:16:39 +1000
Message-ID: <20260929031644.1016354-1-portias@oss.tenstorrent.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::2b;
 envelope-from=portias@tenstorrent.com; helo=mail-pj2-x2b.google.com
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

From: Portia Stephens <portias@oss.tenstorrent.com>

The Atlantis SoC has a DesignWare UART compatible with DW8250. Previously
the Atlantis machine had used the ns16550 UART with an unimplemented memory
region backing the DesignWare specific register space. This updates the Atlantis
model to use the now modeled DW8250.

It also adds the remaining 4 UARTs that were not originally included in the
machine along with a machine property, console. console allows the user to
which uart is being used at the console and will be mapped to the first
serial interface.

Portia Stephens (5):
  hw/char/dw8250: Fix leak when creating child device
  hw/riscv/atlantis: Use dw8250 UART model
  hw/riscv/atlantis: Add all UARTs for Atlantis SoC
  hw/riscv/atlantis: Add machine property to select default uart
  docs/atlantis: Update Atlantis UART documentation

 docs/system/riscv/tt_atlantis.rst |  17 +++-
 hw/char/dw8250.c                  |  11 ++-
 hw/riscv/Kconfig                  |   2 +-
 hw/riscv/tt_atlantis.c            | 130 ++++++++++++++++++++++--------
 include/hw/char/dw8250.h          |   3 +-
 include/hw/riscv/tt_atlantis.h    |  14 +++-
 6 files changed, 132 insertions(+), 45 deletions(-)

-- 
2.43.0


