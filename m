Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A09C52D7D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 13:22:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sewuL-00059y-E1; Fri, 16 Aug 2024 09:22:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sewuI-000581-PV
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 09:22:20 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sewuG-0007jw-9B
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 09:22:18 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-428f5c0833bso16161095e9.0
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 06:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723814534; x=1724419334; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pgqsoRr6u7uYuDiHRia4sFMDUVvp3Aw+9Kef5/KmriY=;
 b=k5pn8HlCex2RU8AYOlDKrgrEdbfasAKz9OKBHP9ABjcTz7gOzqqqj3NCQqTAIMzH6V
 liS+e4zNMLEqpqO1EM7xvxnFdjJma/m83Zadfcfv9P/RUZaX4AGEvINHCJJz9QNBZ1D0
 CfQOHGFctldfWGs2d8trQRr0tF03emlVcJTU18W8WLLWvKsKtD0pMr90JkWqG/J1S6f4
 j6c7r+7ePqt4kbE9Yz+G3+FLrrX34ci8faedKhUGga+QKffal9tIY6K+F0RiXmv+4tpu
 Rrwh/zEwzDAJi8u3XCzh/2W4vhikfjrbPuCWSkLXMurM6RUZdi0nQyOHGtq0L+tQ+mJy
 p8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723814534; x=1724419334;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pgqsoRr6u7uYuDiHRia4sFMDUVvp3Aw+9Kef5/KmriY=;
 b=p0YVmeqOQtjx2C31mb0AYYYCNZL5+VAEgIRTbO9dd43c+gOl0qF8wu91EtyjnXl2PV
 dZADlOUit3QyRFmfzVB3EKgawuc2D1aqUK2BofMVTj3osxfwgweebQUyZu/IZRE/Iblt
 cBB03r59L7MQifnLviW1J8CpCYYPqmrIFguySE9hctE/i2GckZZ1MNvMuorV6YrtTVUp
 P6SVptisNajdgeLIUS5nTjrqOlD0UpTHsyyS3IOFZA8KOD4UylscbxYxdXoyQr4CneCt
 GPYBB+pVzEzFPZhWJDgSy6MhvaVh2knBxmeuzFp8gMwHQ6KMNFS2fJuxDNgn8Zv9zx2U
 Dxyw==
X-Gm-Message-State: AOJu0Yyc26BjmzAl4zvEcVzQJiJ0omSBjMcmye+PCPkuy24oYTI4TsBO
 kPFBR/8PBpzqmMFvp0Vja0qG3RspNTJ1v4fsr6B/IgnzW6HMyb9hH/7UcOp8HDiNgLMS6SFOUd6
 8
X-Google-Smtp-Source: AGHT+IGO0rB7ggvvS3A1nUT2spW5kigyBKKzvn5QT6GzLKP+tRvCnHO/3C+FSHQufhYHTGSPgt+suQ==
X-Received: by 2002:a5d:6481:0:b0:367:8418:fde4 with SMTP id
 ffacd0b85a97d-37194b956bcmr2137199f8f.7.1723814534273; 
 Fri, 16 Aug 2024 06:22:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-371898ab855sm3631948f8f.105.2024.08.16.06.22.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 06:22:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH for-9.2 0/7] docs/devel: Convert txt files to rST
Date: Fri, 16 Aug 2024 14:22:05 +0100
Message-Id: <20240816132212.3602106-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This patchset converts a collection of the remaining txt files in
docs/devel to rST format. At this point in the release cycle
I'm targeting 9.2 for these.

Patches 1-5 are simple conversions.  In patch 6 I move the
QemuLockCnt APIs to their own header file; this is so that we can
include the kernel-doc generated APIs in lockcnt.rst (since
kernel-doc works on a per-file basis).

Paolo: can you confirm that you mean GPLv2-or-later for the lockcnt
code?  There's no explicit license comment in either util/lockcnt.c
or include/qemu/thread.h.

(There's one .txt file left in docs/devel after this, but I don't
think it's very useful so I propose to delete it and will send a
separate patch for that.)

thanks
-- PMM

Peter Maydell (7):
  docs/devel/blkdebug: Convert to rST format
  docs/devel/blkverify: Convert to rST format
  docs/devel/lockcnt: Convert to rST format
  docs/devel/multiple-iothreads: Convert to rST format
  docs/devel/rcu: Convert to rST format
  include: Move QemuLockCnt APIs to their own header
  docs/devel/lockcnt: Include kernel-doc API documentation

 MAINTAINERS                                 |   8 +-
 docs/devel/blkdebug.rst                     | 177 ++++++++++++++++++++
 docs/devel/blkdebug.txt                     | 162 ------------------
 docs/devel/{blkverify.txt => blkverify.rst} |  30 ++--
 docs/devel/index-api.rst                    |   1 +
 docs/devel/index-build.rst                  |   2 +
 docs/devel/index-internals.rst              |   2 +
 docs/devel/{lockcnt.txt => lockcnt.rst}     |  89 +++++-----
 docs/devel/multiple-iothreads.rst           | 139 +++++++++++++++
 docs/devel/multiple-iothreads.txt           | 130 --------------
 docs/devel/{rcu.txt => rcu.rst}             | 172 +++++++++----------
 include/block/aio.h                         |   1 +
 include/hw/core/cpu.h                       |   1 +
 include/qemu/lockcnt.h                      | 130 ++++++++++++++
 include/qemu/thread.h                       | 111 ------------
 accel/accel-blocker.c                       |   1 +
 hw/core/cpu-common.c                        |   1 +
 util/aio-posix.c                            |   1 +
 util/aio-win32.c                            |   1 +
 util/async.c                                |   1 +
 util/fdmon-epoll.c                          |   1 +
 util/lockcnt.c                              |   1 +
 22 files changed, 608 insertions(+), 554 deletions(-)
 create mode 100644 docs/devel/blkdebug.rst
 delete mode 100644 docs/devel/blkdebug.txt
 rename docs/devel/{blkverify.txt => blkverify.rst} (77%)
 rename docs/devel/{lockcnt.txt => lockcnt.rst} (75%)
 create mode 100644 docs/devel/multiple-iothreads.rst
 delete mode 100644 docs/devel/multiple-iothreads.txt
 rename docs/devel/{rcu.txt => rcu.rst} (73%)
 create mode 100644 include/qemu/lockcnt.h

-- 
2.34.1


