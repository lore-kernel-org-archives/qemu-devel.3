Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A0BC5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 13:43:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvxcb-0000ac-Fg; Mon, 17 Aug 2026 09:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wvxca-0000ZP-2H
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 09:43:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wvxcY-00016z-Kv
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 09:43:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786974201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=fAdVwaPl1fZHOcjgIcKyMeXvmnx17ndvcy79jXHZR+g=;
 b=KFpvINxyCCWIIsYnBP4Sl6Ui9NED3xE9E7EaR1QpCgc/psuKG21Xg+H/mgpLqVO/xOwja/
 IC1A5swdsGzC0dT2M3Yj4Zuz1/21wZUqVAz/oug1SmoLzV6Y6+FeLga0w9E4sFKJ99H3kF
 M0RxW138GEuIecTmd9C/NZuKK5Hf4x8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-D0FIPxaOMammeCx18lk2_Q-1; Mon, 17 Aug 2026 09:43:19 -0400
X-MC-Unique: D0FIPxaOMammeCx18lk2_Q-1
X-Mimecast-MFC-AGG-ID: D0FIPxaOMammeCx18lk2_Q_1786974198
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49571407d1dso21908485e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 06:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786974198; x=1787578998; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fAdVwaPl1fZHOcjgIcKyMeXvmnx17ndvcy79jXHZR+g=;
 b=GfxOO0xOODTLqI/VZaoEG+9zvWW6dAjK/QQAltFnH3jkCNUUS7Z9aVPHxi697heOw9
 4QdHilxEmlSQiS+TikMIAfwetFuY23Uj4Gd5h3b+7mkbzjCO0GFFXWh+9GBM7vT3vs0Z
 SM4jZ5sMK1cQvudqUlF0TA63D+BGQOfkyRFSK8elgjhC2oP03YsIP6OPI/UGQf6s0JZ3
 nGEufFCG/ZXcetAiEWSsm89EiXS8ZzB94gEEaJvdUv+QS7LYNtuOorJg++toxVTKUytF
 Tj/qFzhOhuHN1YF3rEKp5d8jlAIWmVgKgtxy3djJSW94PDuO5h0XQcEz68QENqFUx0P8
 j7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786974198; x=1787578998;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fAdVwaPl1fZHOcjgIcKyMeXvmnx17ndvcy79jXHZR+g=;
 b=AGm7UqWDgX5QiAz0GgL1AVFxrYDP+hEznarqyTMa13q7V5zp+NKHYJtazjRnDg3ssp
 sxgP3FIpkWmlCb3EUV0tr5lw3CVnP1gUZLjp5oeviJ91MJw1bWlaT0VfhbHu4dhYlx2W
 e/0uPkt5SHma5rslcf7Xotqv24sOaeQxWcKUPz8jgHrVXSjUD6LKBbYmyB7VmW5Q/tVd
 Y7SQmQUzPG4lhV7IavVdhVBDU9/lfZEcIRQG6NMeIFPr0Lm7H1bAibTWR9Gmq100XqWV
 WbIyJZBCjInV8mBbw8tJQFSRtKYIjLvrW84CkojponWxIYGz1Oea09cQZOn6z42l1Bci
 DdFA==
X-Gm-Message-State: AOJu0YwY9xtTppVAovEN59UJvYsxkLQKwXvXZ3Bp3Ruc1dlMs2scOTL7
 ePACUPDUIBZC3iemm+zUL6mKX2tD85P+4T+GwKgiCTcIJL08c5atuFKZ8YCkyiq+9MeJkcW4S0o
 ZEuApkByDH0lSs5pfIr9qrRyCo/9VdpBN0O/hypVApyOTiX1C4B9sq1lIkUjgG9O+ItriLbEiZR
 9XI5TV9Nqverw5BD/avSC8YruK3ztiOFYKQ55aPEou
X-Gm-Gg: AR+sD13pVjBN9iD4he5zTIVpqucNsQIPpovnzTTklbH14TT2JbBVD8szUzZVGYNq3xQ
 Ub9rRpn4vu16oT3LBbp17OMyqwiAMiD50rSIbBpRicwLmV58QseYOF5piCE2Gg/yBJxEDzFA6OL
 RARkNgbLpqv6YbNmObbY8umFSBZgc6jQqVaSyjr0pAl5yIYqPrmj+EpCAvQf3rZHnQeP7YKa0U0
 rGNcpTFzrn9hLV5nfNXxiFmNtrC9gWSKoeA99hVxzcM2EzxP27maVQckTab4RS6Uw1nOa+Kj2sp
 Lq8yuuNwliVMchWQ0dkiEcV2kt4dbgI9r2PnFupamFo3GDB/K2F8ioH83T0JJRxY4gxbUktFwIg
 hSio1eAtPlC0I4TEY+NoPLZT5m3T8groqERIHTX/PeLwKovC010C+iLotAea1D8mSR0e5AvTNI0
 8TJbM=
X-Received: by 2002:a05:600c:468c:b0:495:52a5:8829 with SMTP id
 5b1f17b1804b1-4999fb6d4d8mr3037465e9.11.1786974197971; 
 Mon, 17 Aug 2026 06:43:17 -0700 (PDT)
X-Received: by 2002:a05:600c:468c:b0:495:52a5:8829 with SMTP id
 5b1f17b1804b1-4999fb6d4d8mr3036545e9.11.1786974197416; 
 Mon, 17 Aug 2026 06:43:17 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5a3b487sm3983107f8f.10.2026.08.17.06.43.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 06:43:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru,
	alex.bennee@linaro.org
Subject: [PATCH 0/2] dockerfiles: update CentOS Stream 9 to Python 3.11,
 Meson to 1.12
Date: Mon, 17 Aug 2026 15:43:10 +0200
Message-ID: <20260817134313.922754-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Meson 1.12 has been released and allows removing almost 1000 lines of
meson.build junk for Rust.  However, it also requires Python 3.11 which
is newer than the version available in CentOS Stream 9 as the platform
Python interpreter.  So adjust it in tests/lcitool/mappings.yml, similar
to how it was done previously for CentOS Stream 8 and OpenSUSE LEAP 15.

However, Meson 1.12 also makes werror apply to linker warnings as well,
which hits us negatively for static builds, due to glibc warning about
usage of getpw* functions in statically linked code.  Work around that,
and make sure that will be in QEMU stable releases too.

Paolo

Paolo Bonzini (3):
  meson: make linker warnings non-fatal on Linux
  dockerfiles: remove packages required by Avocado
  dockerfiles: update CentOS Stream 9 to Python 3.11, Meson to 1.12

 meson.build                                   |  5 ++++
 tests/docker/dockerfiles/alpine.docker        |  3 ---
 tests/docker/dockerfiles/centos9.docker       | 19 +++++++-------
 .../dockerfiles/debian-all-test-cross.docker  |  2 +-
 .../dockerfiles/debian-amd64-cross.docker     |  6 +----
 .../dockerfiles/debian-arm64-cross.docker     |  6 +----
 .../dockerfiles/debian-armhf-cross.docker     |  6 +----
 .../dockerfiles/debian-i686-cross.docker      |  6 +----
 .../dockerfiles/debian-ppc64el-cross.docker   |  6 +----
 .../dockerfiles/debian-riscv64-cross.docker   |  6 +----
 .../dockerfiles/debian-s390x-cross.docker     |  6 +----
 tests/docker/dockerfiles/debian.docker        |  6 +----
 .../dockerfiles/fedora-rust-nightly.docker    |  6 +----
 .../dockerfiles/fedora-win64-cross.docker     |  6 +----
 tests/docker/dockerfiles/fedora.docker        |  6 +----
 tests/docker/dockerfiles/opensuse-leap.docker |  4 ---
 tests/docker/dockerfiles/ubuntu2404.docker    |  6 +----
 .gitlab-ci.d/macos-14.vars                    |  2 +-
 .../ci/setup/debian/debian-13-ppc64le.yaml    |  4 ---
 .../ci/setup/ubuntu/ubuntu-2404-aarch64.yaml  |  4 ---
 .../ci/setup/ubuntu/ubuntu-2404-s390x.yaml    |  4 ---
 tests/lcitool/mappings.yml                    | 26 ++++++++++++++++++-
 tests/lcitool/projects/qemu.yml               |  4 ---
 ...ensuse-leap-15.yml => centos-stream-9.yml} |  0
 tests/vm/generated/freebsd.json               |  4 ---
 25 files changed, 53 insertions(+), 100 deletions(-)
 rename tests/lcitool/targets/{opensuse-leap-15.yml => centos-stream-9.yml} (100%)

-- 
2.55.0


