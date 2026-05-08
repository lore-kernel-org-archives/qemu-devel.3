Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19F1FCD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 15:25:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLN47-0000oW-3g; Fri, 08 May 2026 11:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wLN45-0000ni-G2
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:24:33 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wLN43-0005NY-FW
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:24:33 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-448528f4e69so1409613f8f.3
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 08:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778253870; x=1778858670; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gGcVDS2KrChP/NOgY2ubIbWBYZZKygC9GR/Cq1Lho8I=;
 b=pQSsJ/OJTkhEQ5E1+TRmDq7uU52E1zJT5rPmgHlX2st2GPkJLPj4jWMNZsr5oKHdjn
 3nUsB95yRHFHCwwHONFTcPcng5y+67oYwOZVJTX2Wrs1Vf0XZErHDqrLnf38jPk2lnf0
 AdyIFM/BTEBWbpNieAzuLgpaFZ22U71hGH49T8NYlh2+fhJjwyh6i5CaLc9/cN5uqQ4T
 CbihbKRFp+mY8WcmpwrovqA8LrtIw22rqpcw++aYPB6Y327jfgSYrosqihDrwqPWb2ca
 5CDegbi7ezVPg1mt46/wh4IurR55J2Jkjc82Bj5ZP8nTBuJ8xaujIPnOs8qC665xbW92
 sBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778253870; x=1778858670;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gGcVDS2KrChP/NOgY2ubIbWBYZZKygC9GR/Cq1Lho8I=;
 b=YU54I4K8TLuBMglFu6PHFGIwnIWijuyel0wEtAo/iGAN+msFLtTrmnbaVPgmJfBrq1
 ZsJM1h0fQwNhnq8P6xMLRZHJMACV7Wajeug04vKsmCXrAJtOm7ZS8kFB51XL8B9dDaSe
 b1CMcCP1zuRR9IL1Bp6zxOIZaBdVXS4MeECjyO1UFL0SIdekuZgsNfP5p/4wcsO2vb/3
 86Ema9ACX8CcmZecYk9tQ9zT8M1wSBzh5L1FGn3XDSWcfSZmK2l6uKQGP8hmvwxtoqLV
 LP8ntpnTjzeklfXGeCe2ASM0ZXPOhRn/h0eOqDRAg5g33L4fTETKmY7f7ZeEkH3yHoka
 aiBw==
X-Gm-Message-State: AOJu0YzlVZgq6MgZJwPmAg/LQ/vWFr6UPb7YqFTpwnBBiapxUeuOgcWY
 pgJY5SOc9Vh4W8c7bkUmsNxColKpsuwvs8/bYYguMzXw65HsGUhnfQoL5W61U6TArw7WRQ6JJDf
 kGRil
X-Gm-Gg: Acq92OFZYMfLid0XKxyc+Nlx8Ns3ybg8Y/8q3MumEWxl48J5Ts9C2LXB9GtZ93Az3DV
 2lK/LrP++9lKScttZMbrcfiJxiXvw4klgCJsKIkk1pzaZwtrUHY/Iz/KcUoYy6c44Vu1gnKVXg0
 VuFZRtvPkwEBN1NJ8t2ALgyx+lg21OdsXURdMQnW0VwVhroXJqZHxZhOr7b1+2XkDmdXnFV7jzq
 M2Aa06J7J4xG0BK0tqPKiixwpi4Ua6Z/RzO1W8z7eiweD9LuRVgaj9fWOTxGVY3QTBFA6yaVBeE
 N71BAcNnjTmJY0Wa/qsiQ0Zy5oTmFevmBs0al//zt2zb/SHH21Yan500ACDzRzBMmXk9s4Soxvg
 kvqdxUzki/1SI+2hDZD4InUANmr4sUPd0tkld5ehXHdCIxmo3aZEst4GbpAsgR62Bhq87Qc2vZS
 q8U8E7OK9kHPgbbr1r61Q/iluQehxk8IiHGuwoAdBvfh4gm6/F0z6+2AVJzVLrR8gsRyfvfiOTJ
 VeyBvY3WTDmmU3o4oNSjAEzgaWs/GQyJEI/JP5Ncg==
X-Received: by 2002:a05:6000:40ca:b0:449:d189:e79f with SMTP id
 ffacd0b85a97d-4546310a2fdmr5401612f8f.32.1778253869519; 
 Fri, 08 May 2026 08:24:29 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548ec6c221sm4940453f8f.13.2026.05.08.08.24.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 08:24:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Jason Wang <jasowang@redhat.com>
Subject: [PATCH 0/9] tools: Move more tools sources into tools/
Date: Fri,  8 May 2026 16:24:19 +0100
Message-ID: <20260508152428.2648560-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

We have a set of binaries that we call "tools": they're built based on
the --enable-tools/--disable-tools configure setting, they're
documented in docs/tools, and they're standalone executables of one
form or another.

Currently the sources for these are a bit scattered: many still in the
top level source directory, some in contrib, one or two actually in
the tools directory.

As an initial attempt at cleanup, this patchset moves the sources for
qemu-bridge-helper, qemu-edid, qemu-img, qemu-io, qemu-nbd,
qemu-keymap, qemu-vmsr-helper and elf2dmp into the tools/ directory.

The patchseries also moves the ebfp skeleton sources from tools/ebpf/
to ebpf/bpf-src/, because this isn't a tool by the above definition.

As per my thread from a while back, I would ultimately like us to
clean up contrib/:
https://lore.kernel.org/qemu-devel/CAFEAcA_5HvGriDsWnb1ALuA_dgG320eKv7yuM2kThv=rfOSZQA@mail.gmail.com/
But parts of that clearly need more discussion. So this is just doing
some parts that I hope are not controversial.

Annoyingly, meson doesn't seem to provide any way for a subdirectory
meson.build to say "the foo.c in this subdir builds into a foo
executable that lives at the top level of the builddir". And we have a
lot of test harness stuff plus user muscle memory that assumes that
qemu-img and qemu-io live there. So the build runes for these tools
have to stay in the top level meson.build (and tools/meson.build
remains an empty file). The exception is that contrib/elf2dmp/elf2dmp
is now tools/elf2dmp/elf2dmp, but I think the set of people who were
running that from the build directory will be small.

thanks
-- PMM


Peter Maydell (9):
  ebpf: move ebpf skeleton source to ebpf/ directory
  tools: Move qemu-bridge-helper sources to tools/ directory
  tools: Move qemu-edid sources to tools/ directory
  tools: Move qemu-img sources to tools/ directory
  tools: Move qemu-io sources to tools/ directory
  tools: Move qemu-nbd sources to tools/ directory
  tools: Move qemu-keymap sources to tools/ directory
  tools: Move qemu-vmsr-helper up a directory level
  tools: Move elf2dmp from contrib/ to tools/

 MAINTAINERS                                   | 15 +++++++-------
 docs/tools/qemu-img.rst                       |  2 +-
 {tools/ebpf => ebpf/bpf-src}/Makefile.ebpf    |  2 +-
 {tools/ebpf => ebpf/bpf-src}/rss.bpf.c        |  0
 meson.build                                   | 20 +++++++++----------
 {contrib => tools}/elf2dmp/addrspace.c        |  0
 {contrib => tools}/elf2dmp/addrspace.h        |  0
 {contrib => tools}/elf2dmp/download.c         |  0
 {contrib => tools}/elf2dmp/download.h         |  0
 {contrib => tools}/elf2dmp/err.h              |  0
 {contrib => tools}/elf2dmp/kdbg.h             |  0
 {contrib => tools}/elf2dmp/main.c             |  0
 {contrib => tools}/elf2dmp/meson.build        |  0
 {contrib => tools}/elf2dmp/pdb.c              |  0
 {contrib => tools}/elf2dmp/pdb.h              |  0
 {contrib => tools}/elf2dmp/pe.h               |  0
 {contrib => tools}/elf2dmp/qemu_elf.c         |  0
 {contrib => tools}/elf2dmp/qemu_elf.h         |  0
 .../qemu-bridge-helper.c                      |  0
 qemu-edid.c => tools/qemu-edid.c              |  0
 qemu-img-cmds.hx => tools/qemu-img-cmds.hx    |  0
 qemu-img.c => tools/qemu-img.c                |  0
 qemu-io-cmds.c => tools/qemu-io-cmds.c        |  0
 qemu-io.c => tools/qemu-io.c                  |  0
 qemu-keymap.c => tools/qemu-keymap.c          |  0
 qemu-nbd.c => tools/qemu-nbd.c                |  0
 tools/{i386 => }/qemu-vmsr-helper.c           |  0
 tools/{i386 => }/rapl-msr-index.h             |  0
 28 files changed, 20 insertions(+), 19 deletions(-)
 rename {tools/ebpf => ebpf/bpf-src}/Makefile.ebpf (96%)
 rename {tools/ebpf => ebpf/bpf-src}/rss.bpf.c (100%)
 rename {contrib => tools}/elf2dmp/addrspace.c (100%)
 rename {contrib => tools}/elf2dmp/addrspace.h (100%)
 rename {contrib => tools}/elf2dmp/download.c (100%)
 rename {contrib => tools}/elf2dmp/download.h (100%)
 rename {contrib => tools}/elf2dmp/err.h (100%)
 rename {contrib => tools}/elf2dmp/kdbg.h (100%)
 rename {contrib => tools}/elf2dmp/main.c (100%)
 rename {contrib => tools}/elf2dmp/meson.build (100%)
 rename {contrib => tools}/elf2dmp/pdb.c (100%)
 rename {contrib => tools}/elf2dmp/pdb.h (100%)
 rename {contrib => tools}/elf2dmp/pe.h (100%)
 rename {contrib => tools}/elf2dmp/qemu_elf.c (100%)
 rename {contrib => tools}/elf2dmp/qemu_elf.h (100%)
 rename qemu-bridge-helper.c => tools/qemu-bridge-helper.c (100%)
 rename qemu-edid.c => tools/qemu-edid.c (100%)
 rename qemu-img-cmds.hx => tools/qemu-img-cmds.hx (100%)
 rename qemu-img.c => tools/qemu-img.c (100%)
 rename qemu-io-cmds.c => tools/qemu-io-cmds.c (100%)
 rename qemu-io.c => tools/qemu-io.c (100%)
 rename qemu-keymap.c => tools/qemu-keymap.c (100%)
 rename qemu-nbd.c => tools/qemu-nbd.c (100%)
 rename tools/{i386 => }/qemu-vmsr-helper.c (100%)
 rename tools/{i386 => }/rapl-msr-index.h (100%)

-- 
2.43.0


