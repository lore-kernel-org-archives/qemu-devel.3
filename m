Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94556109C04B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 17:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5RxL-0003p7-D8; Wed, 25 Mar 2026 13:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w5RxK-0003op-Cb
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 13:23:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w5RxI-0006o9-Pm
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 13:23:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774459423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KoJmKdc9lzgJbOe7eN67JyCu5oa6GHVM298rdQUySj0=;
 b=T4NixV57bz+BojKXof1GXGBIexMbxE8AADCHYYEMES+ZTTlgwxjBUM0OGnr96EzyCyCT5V
 HbvDUvwGlywQ7ZocZhmX847wyzpyx0em9snVqOpCsmi/8O/vusGb7EUkeK3DTYK1R1LGlL
 9hNQ03T62053SHDKG519gp1YZ8yWBRA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-OYykxLG1NEy5QrN5ZO6p2g-1; Wed, 25 Mar 2026 13:23:41 -0400
X-MC-Unique: OYykxLG1NEy5QrN5ZO6p2g-1
X-Mimecast-MFC-AGG-ID: OYykxLG1NEy5QrN5ZO6p2g_1774459420
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48534941525so4070065e9.2
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 10:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774459420; x=1775064220; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=KoJmKdc9lzgJbOe7eN67JyCu5oa6GHVM298rdQUySj0=;
 b=tvWUsgSIhHI95k0jAuxzsV6rVetATQ+wapLcL3aT4LbOc1+xtESs60AFG/VF1QW3p8
 8ZeX2d8JWsMzSM/Kwz7wYeKTP95sv5eC5ZlUCZDEuM395lFTFIBxWdRzREMb4HqkL2R9
 4Qud6/MGkF04Glp7XN5dRJCTDAqFetrz+bj9DBnWKeu+KII5cuEG6K6SFW7Z5c/kdNNg
 SNMtYkYylyj2zq2RZjQdc0qAg0ftdCTEtdAUmPHHMzai+oxF5e6rwYLwMZVpt454vOMs
 M/8ET6jnojBg61QO3ZwkFk+macKHEmAyLZg+lmHgNMiEkvmZNPLZ2vg1x2iRtGRadcQz
 FJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774459420; x=1775064220;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KoJmKdc9lzgJbOe7eN67JyCu5oa6GHVM298rdQUySj0=;
 b=MMW8YEIjxpkkPAmpVp/b+5U3CGwlatuwliUozWVO8ar3Jcv7Klf3eWFj6iL01caFDc
 SbkeeONJkvJYy9Fv79WYgvm5Cwqj0oGqRJYIixlDMmGxPmQrLb4a51l/9q/flPpMRcLL
 coxun2kEluUQV6EqK/no63WtQe8ga9E6QvVUSoTYxK/RHXaB20TyGF7nBwTCcGhQ65IQ
 kpGfG429JCCUyE2sbs1CJQ9RDYH0HQJRUATCLx6ERjbGBpZUu4/hGM0RsJlf9p99WtBu
 ArFROTOk/sZreWWqnBs1LjYhXtafX6+2qoz3zWmeHElIkggwAIzbF8JPd+LLdfsFcYBB
 Gm2g==
X-Gm-Message-State: AOJu0YzC4NGf9j6s88DWa+6chsfYbqjEXIouXGGOhMMqDqepyjDD5cck
 T04+Yx2Fw/v7sS7BcyOtusI788ZTwADAa0afSqvCCxjXpbr5KnUT3goU3CtJs89onExIRt51Cd8
 9HmmKM6W2c49c3jBp5ijLFGZJ2u9lV5ypokyRnFS0Z2Bd5y8GKqeOFB8L7J1eyUFg2DxxdKkuQg
 uG/v7umQMgH2ECYDDdRxIq9v2tThVE/3PdSo5TSofe
X-Gm-Gg: ATEYQzxbbQ1EuGR0lXPjxobBPif9pzntNgwuiV/oJP+6hZLsJZSJMvexufnQT0PFiYQ
 YhJqg8RZq0Lwe7/8Hz3K0f28nstmd2WiiXQVrBexkjDkOkxsVw0BaorPkLjfhsUsFvW/losTsJ2
 NV4rv/Y4a0V8iLZygruj28jV16FMKvtDUFz1cTaOUFSvRKIO1waZGDpkT/59czddyIxyXXTr+Gf
 JSX/zQ7+KLegKyiuPsHbfDn2FIUB3edbUrqFuUPqbCjbttM5JKzTknzDNNyfRcdSl4sZEoPw5SQ
 au94/k/23+CfvUQdgFH4JbFbLGJ0CVR26v31QDoJkkY1Dx+2jhlRvv2rjxtkZfuTnNth/U+67Pu
 QgE3rTcgDopS04lZn9iwSWH5dRQOkDy+Z+Giqmx1vU77015JGIGhHGHH/eUxlIWbtLU+oaZDAUW
 7YeadxNrM4GH4uMlpbFCjumI6r
X-Received: by 2002:a05:600c:1913:b0:485:9a50:3384 with SMTP id
 5b1f17b1804b1-48716071753mr63518115e9.25.1774459419611; 
 Wed, 25 Mar 2026 10:23:39 -0700 (PDT)
X-Received: by 2002:a05:600c:1913:b0:485:9a50:3384 with SMTP id
 5b1f17b1804b1-48716071753mr63517665e9.25.1774459419035; 
 Wed, 25 Mar 2026 10:23:39 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48717342048sm24040585e9.14.2026.03.25.10.23.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 10:23:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/19] Fixes (including big i386/emulate performance
 improvement) for 11.0-rc
Date: Wed, 25 Mar 2026 18:23:36 +0100
Message-ID: <20260325172337.87212-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 007b29752ed06e467d3c830bc2c17a8851f8bcd3:

  Merge tag 'for-upstream' of https://gitlab.com/kmwolf/qemu into staging (2026-03-25 09:16:13 +0000)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to ba41e525413906473ed004b3a45f565783f3533f:

  target/i386: emulate: follow priv_check_exempt (2026-03-25 18:22:27 +0100)

----------------------------------------------------------------
* tests/functional: preserve PYTHONPATH entries
* target/i386: show GMET feature
* target/i386/emulate, whpx/i386: on-demand access to runtime state, MMU fixes
* tdx: fix use-after-free in tdx_fetch_cpuid
* treewide: replace qemu_hw_version() with QEMU_HW_VERSION
* sb16: detect invalid migration stream

----------------------------------------------------------------
Alyssa Ross (1):
      tests/functional: preserve PYTHONPATH entries

Jenny Guanni Qu (1):
      hw/audio/sb16: validate VMState fields in post_load

Mohamed Mediouni (14):
      whpx: i386: workaround for Windows 10 support
      whpx: i386: enable exceptions VM exit only when needed
      whpx: i386: skip TSC read for MMIO exits
      whpx: i386: skip XCRs read for MMIO exits
      whpx: i386: don't restore segment registers after MMIO handling
      target/i386: emulate: add new callbacks
      whpx: i386: add implementation of new x86_emul_ops
      target/i386: emulate: indirect access to CRs
      whpx: i386: indirect access to CRs
      target/i386: emulate: segmentation rework
      whpx: i386: fetch segments on-demand
      whpx: i386: fast runtime state reads
      target/i386: emulate: set PG_ERROR_W_MASK as expected
      target/i386: emulate: follow priv_check_exempt

Paolo Bonzini (3):
      tdx: fix use-after-free in tdx_fetch_cpuid
      treewide: replace qemu_hw_version() with QEMU_HW_VERSION
      target/i386: expose AMD GMET feature

 include/hw/core/boards.h          |   6 -
 include/qemu/hw-version.h         |  18 +--
 target/i386/emulate/x86_emu.h     |   6 +
 hw/audio/sb16.c                   |   7 +
 hw/ide/core.c                     |   2 +-
 hw/scsi/megasas.c                 |   2 +-
 hw/scsi/scsi-bus.c                |   2 +-
 hw/scsi/scsi-disk.c               |   2 +-
 system/vl.c                       |   4 -
 target/i386/cpu.c                 |   2 +-
 target/i386/emulate/x86_helpers.c |  83 ++++++-----
 target/i386/emulate/x86_mmu.c     |  27 ++--
 target/i386/hvf/x86.c             |  11 ++
 target/i386/kvm/tdx.c             |   2 +-
 target/i386/whpx/whpx-all.c       | 284 ++++++++++++++++++++++++++++++++------
 target/s390x/cpu_models.c         |   2 +-
 util/osdep.c                      |  12 --
 tests/functional/meson.build      |  12 +-
 18 files changed, 343 insertions(+), 141 deletions(-)
-- 
2.53.0


