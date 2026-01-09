Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D121D26D6F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 16:38:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veFUa-0001Y5-EV; Fri, 09 Jan 2026 11:37:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFUW-0001Xm-IW
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:37:36 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFUU-0005Bd-OT
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:37:36 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-477ba2c1ca2so48626405e9.2
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 08:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767976652; x=1768581452; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=obcMqHv29tuGOI8j2lUF7M1ixYnUaj96ynlGm9xJmBg=;
 b=p4fTZI7lPtvIGJI/z86JTTXlxbVt/dq05g3ekspfBNx+EI3CHqVAwN6rB/L+Pg6v41
 WSU/qay7vFh+uobr7/wc+ABNuTbWTLdHJjZXur74qz280XBu8Kiel4EPDH0EHhJrmKVe
 qwqjAbiP/sy/XaO+uiTVQ1V5xiAZ20G2k96aqtabna/1aWhKBMLIBCTWOJkeM/iGCt1j
 MlZOkAAGdFpyxLHVAh9pTf4En5matsewm9W6Ud7aeLRNa3D4ZqBojYmldW3I9h9W0iCg
 1L8cvuLT2xYAWEc/RBe0hkYsYmtg8Sk9zwDk9KZUUz4jdYjTyM+dZMmyzNuCeh/pR/2E
 lJRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767976652; x=1768581452;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=obcMqHv29tuGOI8j2lUF7M1ixYnUaj96ynlGm9xJmBg=;
 b=bgDNv1aig3dDewXDD93BJsWKVK+cKR/3QasRHzPTUaNjXpdhtwFodslwGm0BikAbPU
 /KwFQxJA5t2BaAojMjCY1IWcg4qDXncaVL+504cijdjnmdh/7rlLwdQR3h2V4zX4rnJt
 z2YvfV8rTrr9x0R/TM7BmyzmjY02WHql0kOewVbYO8CxHkxjZacJV3DqNQz5wQlLyUhA
 zrhGn7Zjk6t7Mz763amb6C2JQ5UCxyuSuycehAYxe+wvNW5qILLNlBRS4Ei6IIn/E8Io
 pbZmx43tGLhPFDyQDrlEuBvEXM3eeXg21dLldSdEMrfG/UJQ5Uk4Z6b13KQacq5hIyrw
 Dqjw==
X-Gm-Message-State: AOJu0YyG51WrwiPh1tEoueoU6tqa6pxp38n2iLkMRWLf/ejIRUWUDHxX
 8Jpf7ivFMB4aLYye8LNKTNVMZ8mMfcHuBAg+7t24s9YJJLBIJnDyLFHh1mdTNtcRma+HNSDHsXQ
 Iolg7tWw=
X-Gm-Gg: AY/fxX5maEJvIrae+BzPxEA5FHQquosYntv8xOhpc8vzCljP9Rcp/KVukQRg/n0Soy5
 gQmxPDSwBGQpsPqC0T/foUPTw9bkiFs1J+nFgTT8sc1Fgdnl17qbXuUVjSEmwVnKynuOandE3uJ
 MDKXiYfvb7xNWpmANdhMoRfiBbGQuYJ6EP+6n9JNgid+HwHHoBjujjscIWt3hUnk2xs/IiVFUiJ
 EOnDAP0lKExA79sATK8IfcJ/9f7BMhvWjrnmX7tjuU4kKGKjcUn7BVkZCZHPl3afsIr51WQeKUu
 lR/7alw2rAF8INMQM0Dr46FipxL8aShZmwy3InbhpB65XQLhJ2cii1IIHceCUBGh0e0nBzRVi4v
 NwwkCiE0ymwMjQ1E6J9/jbqOofONTl5VWRElcvRQIkusnF34q0Cv2lPFCrlmn0VniaIM2iO/MHS
 32Wf0h/TDJmep4ZaKLHpbW27g3TR/wWnTDSOZwaFNGYMB8X8x+ewK8AkHvZpa1
X-Google-Smtp-Source: AGHT+IFvJaNWjqzeLgkX8XDogLVOcIP5oSgvm/MXU6joOTNaGg6mxX9aZoZXHuQW4452GHk2z7j06g==
X-Received: by 2002:a05:600c:4fd2:b0:477:58:7cf4 with SMTP id
 5b1f17b1804b1-47d84b09145mr105268665e9.4.1767976652389; 
 Fri, 09 Jan 2026 08:37:32 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f4184e1sm210434155e9.4.2026.01.09.08.37.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Jan 2026 08:37:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 0/3] bswap: Cleanups around 'qemu/bswap.h' header
Date: Fri,  9 Jan 2026 17:37:27 +0100
Message-ID: <20260109163730.57087-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

The point of this cleanup series is to avoid a circular dependency
problem between "qemu/bswap.h" and "exec/memop.h", since I want
to add a ld/st variant in "qemu/bswap.h" that takes a MemOp arg.

Otherwise I get:

    In file included from ../../util/qemu-timer-common.c:25:
    In file included from include/qemu/timer.h:4:
    In file included from include/qemu/bitops.h:16:
    In file included from include/qemu/host-utils.h:33:
    In file included from include/qemu/bswap.h:6:
    include/exec/memop.h:182:19: error: call to undeclared function 'ctz32'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      182 |     return (MemOp)ctz32(size);
          |                   ^
    In file included from ../../util/qemu-timer-common.c:25:
    In file included from include/qemu/timer.h:4:
    In file included from include/qemu/bitops.h:16:
    include/qemu/host-utils.h:236:19: error: static declaration of 'ctz32' follows non-static declaration
      236 | static inline int ctz32(uint32_t val)
          |                   ^
    include/exec/memop.h:182:19: note: previous implicit declaration is here
      182 |     return (MemOp)ctz32(size);
          |                   ^
    2 errors generated.

Philippe Mathieu-Daudé (3):
  bswap: Use 'qemu/bswap.h' instead of 'qemu/host-utils.h'
  bswap: Include missing 'qemu/bswap.h' header
  bswap: Consistently use builtin bswap() functions

 block/qcow2.h                         | 1 +
 include/qemu/host-utils.h             | 7 +++----
 include/qemu/int128.h                 | 7 +++----
 audio/audio.c                         | 1 +
 block/blklogwrites.c                  | 1 +
 block/export/vduse-blk.c              | 1 +
 block/export/vhost-user-blk-server.c  | 1 +
 block/export/virtio-blk-handler.c     | 1 +
 block/parallels-ext.c                 | 1 +
 hw/9pfs/9p-local.c                    | 1 +
 hw/block/cdrom.c                      | 1 +
 hw/block/hd-geometry.c                | 1 +
 hw/net/can/ctucan_core.c              | 1 +
 hw/nvram/xlnx-efuse.c                 | 1 +
 hw/scsi/scsi-generic.c                | 1 +
 hw/sd/sd.c                            | 1 +
 hw/sd/ssi-sd.c                        | 1 +
 net/l2tpv3.c                          | 1 +
 scsi/pr-manager-helper.c              | 1 +
 target/arm/tcg/arith_helper.c         | 1 +
 tests/qtest/acpi-utils.c              | 1 +
 tests/qtest/ahci-test.c               | 2 +-
 tests/qtest/aspeed-hace-utils.c       | 1 +
 tests/qtest/bios-tables-test.c        | 1 +
 tests/qtest/libqos/ahci.c             | 2 +-
 tests/qtest/libqos/generic-pcihost.c  | 2 +-
 tests/qtest/libqos/igb.c              | 1 +
 tests/qtest/libqos/pci-spapr.c        | 2 +-
 tests/qtest/libqos/virtio-9p-client.c | 1 +
 tests/qtest/migration/framework.c     | 1 +
 tests/qtest/npcm7xx_emc-test.c        | 1 +
 tests/qtest/tpm-emu.c                 | 1 +
 tests/qtest/ufs-test.c                | 1 +
 tests/qtest/vmcoreinfo-test.c         | 1 +
 tests/qtest/vmgenid-test.c            | 1 +
 tests/unit/test-hbitmap.c             | 1 +
 util/bitmap.c                         | 1 +
 util/hbitmap.c                        | 2 +-
 38 files changed, 42 insertions(+), 13 deletions(-)

-- 
2.52.0


