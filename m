Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCBE8C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 17:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNFPR-0005Yg-86; Fri, 28 Jun 2024 13:29:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sNFPG-0005Xo-Aj
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:29:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sNFPE-00029N-8W
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719595742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:  content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=stBd2S18ZwT/kxgCMJx9uft+mCMrsRZ50Me11DzoSNw=;
 b=UQ1ywhggFTkaGGICHLWBXpW4vz6pMo9qVC42V9sU7nr6uNRG0pssQFGGLgfxzJ0ZEfuVAY
 UMNVnSpPdqZbKbLvD2atGds/KRS9+uv0mv3uymsGBzMfsAPkrLq9r8aNI53w6X+/wz10yH
 xjFkBM7pHz+QAz8lNaTrN+FtC/Q9Mgo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-98HHWtv4OX-53pL2iA_R9A-1; Fri, 28 Jun 2024 13:28:59 -0400
X-MC-Unique: 98HHWtv4OX-53pL2iA_R9A-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-57d3d594107so628576a12.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 10:28:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719595738; x=1720200538;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=stBd2S18ZwT/kxgCMJx9uft+mCMrsRZ50Me11DzoSNw=;
 b=DObeN9z3n/149PGGNYTo7u2q3FR2Zl9/QQ8Eavp4t8XCSMtjCVoQafUxzRVzI8IFeI
 vykT1V9UQYIAusyDhmeYq+HHbO3d8vLoSedjOrsTQrxY7MGbnaBErmU5ndTvzTEAbI1m
 0wnHou19gi9aSP9wA8Qpsiu6rZy5SwnYy3544OCRzaDVrD7hmg7nHk4ehJSn4/oyJU9l
 19RfhfEHdPiu51BIDX8e0rkLMlrf8Xn4B1MelBBtYVhuCEd1cIZjtV3M14JaUO1fiRkq
 9hRlRVLmkLnfHNmtUlc+uiL1tG/hhI0V5JXXHd2aGF2x0o4aZ2PPzyFWmtSQxvcaLbsC
 NF6Q==
X-Gm-Message-State: AOJu0Yw6d19x6ZKlPMSHQTeE3ubZd4oFOT2yfXgQXwOqI7q+pNMb2zkM
 ut6aVXkSf2AFncYYOm73GZjQ3rBO7JYqqEyKIh/YfunfU5ZDSS7ArAOARm3kjey6G03mRboB00o
 V5nEIaUQtwkk/YsiewZRL1+gyC1/S9xTx1f6kaziVEZgIfn1RfKLHHqbp8GKYlwSdkcQnCjzxAN
 glPcQ6lhCZItQpWQhyQ1cOpC7AVehrIIA60YiC
X-Received: by 2002:a50:9e29:0:b0:57c:6767:e841 with SMTP id
 4fb4d7f45d1cf-57d4bd71015mr10789367a12.13.1719595737974; 
 Fri, 28 Jun 2024 10:28:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuTTa9G3qy5Q2Dy3Hv9HuRszbJ8dfOo03QT3ulE1icj3j20XE/SSvuVYuL5x5yvnL6r8Okig==
X-Received: by 2002:a50:9e29:0:b0:57c:6767:e841 with SMTP id
 4fb4d7f45d1cf-57d4bd71015mr10789353a12.13.1719595737338; 
 Fri, 28 Jun 2024 10:28:57 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58612c835b9sm1295886a12.3.2024.06.28.10.28.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 10:28:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 00/23] Misc changes for 2024-06-28
Date: Fri, 28 Jun 2024 19:28:32 +0200
Message-ID: <20240628172855.1147598-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.206,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 28b8a57ad63670aa0ce90334523dc552b13b4336:

  Merge tag 'pull-riscv-to-apply-20240627-1' of https://github.com/alistair23/qemu into staging (2024-06-27 07:36:16 -0700)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to b31d386781cf85c193f3b1355dd0604cd6a59943:

  target/i386/sev: Fix printf formats (2024-06-28 19:26:54 +0200)

I dropped the bit test instructions and the rest of the decoder updates,
because they were buggy and I didn't like any of the fixes I could come
up with.

Supersedes: <20240624135939.632257-1-pbonzini@redhat.com>

----------------------------------------------------------------
* configure: detect --cpu=mipsisa64r6
* target/i386: decode address before going back to translate.c
* meson: allow configuring the x86-64 baseline
* meson: remove dead optimization option
* exec: small changes to allow compilation with C++ in Android emulator
* fix SEV compilation on 32-bit systems

----------------------------------------------------------------
Paolo Bonzini (19):
      configure: detect --cpu=mipsisa64r6
      Revert "host/i386: assume presence of POPCNT"
      Revert "host/i386: assume presence of SSSE3"
      Revert "host/i386: assume presence of SSE2"
      meson: allow configuring the x86-64 baseline
      meson: remove dead optimization option
      block: make assertion more generic
      block: do not check bdrv_file_open
      block: remove separate bdrv_file_open callback
      block: rename former bdrv_file_open callbacks
      include: move typeof_strip_qual to compiler.h, use it in QAPI_LIST_LENGTH()
      target/i386: fix CC_OP dump
      target/i386: use cpu_cc_dst for CC_OP_POPCNT
      target/i386: give CC_OP_POPCNT low bits corresponding to MO_TL
      target/i386: remove unused enum
      target/i386: SEV: rename sev_snp_guest->id_block
      target/i386: SEV: store pointer to decoded id_block in SevSnpGuest
      target/i386: SEV: rename sev_snp_guest->id_auth
      target/i386: SEV: store pointer to decoded id_auth in SevSnpGuest

Richard Henderson (2):
      target/i386/sev: Use size_t for object sizes
      target/i386/sev: Fix printf formats

Roman Kiryanov (2):
      exec: avoid using C++ keywords in function parameters
      exec: don't use void* in pointer arithmetic in headers

 configure                                 |   2 +-
 meson.build                               |  54 +++++++++-------
 host/include/i386/host/cpuinfo.h          |   2 +
 include/block/block_int-common.h          |   3 -
 include/exec/memory.h                     |   6 +-
 include/qapi/util.h                       |   2 +-
 include/qemu/atomic.h                     |  42 -------------
 include/qemu/compiler.h                   |  46 ++++++++++++++
 target/i386/cpu.h                         |  13 +++-
 tcg/i386/tcg-target.h                     |   5 +-
 block.c                                   |  17 +++--
 block/blkdebug.c                          |   2 +-
 block/blkio.c                             |   8 +--
 block/blkverify.c                         |   2 +-
 block/curl.c                              |   8 +--
 block/file-posix.c                        |   8 +--
 block/file-win32.c                        |   4 +-
 block/gluster.c                           |   6 +-
 block/iscsi.c                             |   4 +-
 block/nbd.c                               |   6 +-
 block/nfs.c                               |   2 +-
 block/null.c                              |   8 +--
 block/nvme.c                              |   8 +--
 block/rbd.c                               |   3 +-
 block/ssh.c                               |   6 +-
 block/vvfat.c                             |   2 +-
 target/i386/cpu-dump.c                    | 101 +++++++++++++++---------------
 target/i386/sev.c                         |  71 ++++++++++++---------
 target/i386/tcg/cc_helper.c               |   2 +-
 target/i386/tcg/translate.c               |  21 +------
 util/cpuinfo-i386.c                       |   6 +-
 host/include/i386/host/bufferiszero.c.inc |   5 +-
 target/i386/tcg/emit.c.inc                |   4 +-
 meson_options.txt                         |   5 +-
 scripts/meson-buildoptions.sh             |   6 +-
 target/i386/trace-events                  |   2 +-
 36 files changed, 256 insertions(+), 236 deletions(-)
-- 
2.45.2


