Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC3DC83029
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 16:42:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWHZi-0002PC-PJ; Mon, 30 Jun 2025 12:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yodel.eldar@gmail.com>)
 id 1uWHZg-0002Oe-1I
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 12:41:44 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yodel.eldar@gmail.com>)
 id 1uWHZb-0008N4-2E
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 12:41:41 -0400
Received: by mail-pl1-x642.google.com with SMTP id
 d9443c01a7336-2352400344aso43536525ad.2
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 09:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751301697; x=1751906497; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9vQbvlL9fIWW9bQO/KEAkdOpGoZVSyBdFCgcfBK3Ofw=;
 b=YcwIqU89eSE7t+twrVC8uU7CRPk5RenJqijk7oZxkH7635DpMqfH2Rg2VqpR5vELUK
 OD35O6ckaaMZeAhWbzNTS/pAivGG/Nz4i23AqS2nsaEtvXmF0afIq1c9/efLXNz/qVeS
 fGc0OizT/m4xExCW/+LplTDyr/3cr7LamhdJKDZkyIFkQWHJFM2ja54t7GNMDPoHEVAl
 Xo6oyT6Ls7XdY8OWvrHe7uPnIbJvCuhDQqvQJS1TqnpY8TXWGjIcQCKB3jvX8pwZqMe6
 LL86O18dSueMvxkXfxP6JfFa0dzFBJR6/CUbs5rm+2Xc/f+GVx7sK3dMgKseIoPvAzac
 ISkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751301697; x=1751906497;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9vQbvlL9fIWW9bQO/KEAkdOpGoZVSyBdFCgcfBK3Ofw=;
 b=JEhcCdX3if+YWKTCE9YOM/7OMOqDLt9u4wXuzJu2r6xVoMKsgPoqQ3QrhW9x0ZTAeV
 TfoNtU7dlXcRKWe3dIkn1AB1MqK15COjN3MTmhlF0KeiJIWMJpiM/eyTQyhSgMLfmlRw
 XE8Xg0c1UPbMbS0yI8LN4L8mQ+rC66iptzc3PeYUrLRwSXC5jmhlcNTH7GBNlYZ87U8y
 WkED+HoTH/yPnIHbDbl4pj1i0soOyeddztYuuwHYAsa7JDBc3ucxgg9E0ynzK48uV78q
 vidPJZrwWetBAdyV+/FEoWFBOt4sD10Gk+e36epYCxin2wyQKRWEYopLycoCdjvStAQw
 4Iow==
X-Gm-Message-State: AOJu0YxM4WoLHNeNTqxpJz/a2E6RBOsEFEtCCHGsJXjpZmN1L172iikR
 bOK0LMUh6+/ofCDPSksa4eZhTWwvBAWhBwRRi4iEAKiOl+o+hyM7k1imNSsWkEIx
X-Gm-Gg: ASbGncsePt8nF5SJ57W8rrxaVL+rxpcpvYZ9spRXVhIlZZktFqnde4TZhlSCHpHPoVO
 TLHCavINt01rVx3N58wtL3s3TVMNdMLixX0fmL2zzxLEVfjD7g31pMT89MCThHmkLqN5d1ILFEV
 XqmQ0dB9ixVZvHtqkYIjZ5yIWmCMxfRmuFXvTzb3SedL/C12krlOPcFqmJAInd7UXHhcNrwvUim
 WY2T8k3vqnpXj2Ob1JV/3U1J9XhhJ2v1jtn9t9iKYAcWV/V85fR25xYaCFpXuDdsPJ/iXvC2tTL
 VjoO8VHH9+h5HG/rGdvSvDJ4VgTE0CK7AmbMIWg2uW88QJDL0c7z/2GwbP9zRjsEQ0Uq
X-Google-Smtp-Source: AGHT+IGKDKgcqUhzrlnn2YTSotzMjXg3OiLRlGcf2o1Tl9Kh43rAgdsHRaBbi8Yrk0NqYDVhgJlbMQ==
X-Received: by 2002:a17:902:eccd:b0:224:76f:9e4a with SMTP id
 d9443c01a7336-23ac3afd3c5mr222565955ad.14.1751301696827; 
 Mon, 30 Jun 2025 09:41:36 -0700 (PDT)
Received: from darlin ([89.187.185.165]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb39b9fdsm90082595ad.108.2025.06.30.09.41.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 09:41:36 -0700 (PDT)
From: Yodel Eldar <yodel.eldar@gmail.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, richard.henderson@linaro.org, laurent@vivier.eu,
 Yodel Eldar <yodel.eldar@gmail.com>
Subject: [PATCH v2 0/2] target/alpha: Add TCG plugin register tracking support
Date: Mon, 30 Jun 2025 11:41:22 -0500
Message-ID: <20250630164124.26315-1-yodel.eldar@gmail.com>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=yodel.eldar@gmail.com; helo=mail-pl1-x642.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This patch adds TCG plugin register tracking support for the Alpha
target and resolves gitlab issue #2569:

  https://gitlab.com/qemu-project/qemu/-/issues/2569

As mentioned in the bug report by Alex Bennée, the register list is
built using the target's corresponding GDB XML feature file, but the
Alpha target does not have one. The second patch introduces the missing
feature file and the necessary plumbing for it.

While testing the second patch, I noticed the following error:

  qemu-alpha: GLib: g_strrstr: assertion 'haystack != NULL' failed

when running:

  ./qemu-alpha -d plugin \
  -plugin ./contrib/plugins/libexeclog.so,reg=*,rdisas=on \
  ./tests/tcg/alpha-linux-user/linux-test

and discovered an issue with execlog.c that the first patch resolves:
a missing null check after execlog searches a disassembled instruction
for a space separator between the mnemonic and the operands. Execlog
assumes that disassembled instructions will contain a space, but some
disassemblers use tabs (like Alpha).

Besides adding the null check, the execlog patch also adds tab to the
separator search by replacing the g_strstr_len call with a call to
g_strsplit_set, so that the plugin would operate as intended for Alpha.

A pointer in the immediate area of the changed code is converted to a
const pointer in keeping with the QEMU Coding Style. Also, as a trivial
optimization, I took the liberty of adding a break statement to the
register search loop that immediately follows the separator search, so
that it breaks out of the loop as soon as a relevant register is found
in the instruction.

Patch Series History:
v1 -> v2:
  - As suggested by Alex Bennée, replaced strpbrk with g_strsplit_set

Yodel Eldar (2):
  contrib/plugins/execlog: Add tab to the separator search of insn_disas
  target/alpha: Add GDB XML feature file

 configs/targets/alpha-linux-user.mak |   1 +
 configs/targets/alpha-softmmu.mak    |   1 +
 contrib/plugins/execlog.c            |  15 +--
 gdb-xml/alpha-core.xml               | 136 +++++++++++++++++++++++++++
 target/alpha/cpu.c                   |   1 +
 5 files changed, 148 insertions(+), 6 deletions(-)
 create mode 100644 gdb-xml/alpha-core.xml

-- 
2.50.0


