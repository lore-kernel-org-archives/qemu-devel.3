Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7795CC6B30
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:54:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJ69-0005hn-Tj; Thu, 15 Oct 2026 06:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xHJ5x-0005JA-Lz
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:53:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xHJ5v-0007w8-Ed
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:53:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792061634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=uN4f1KuqHGe2DuzdAee3ToHFFTYNLWgBakn8qHjmgW0=;
 b=I73maTKpqXvksSraU5e5RcXajaYz6dKCI/IkTME3vr21t2ePojdJYvjbOJqznyWoOiVUKr
 bNCskn4DjvSJ0zxZI6fiTy9fzNJlBqqI9PXhZrl7d/OfvVg4gSRd4nzaKyYbkfBsxk2kEz
 MEH4uTaNpSUeo6NpEy/AN5mPJ4jCkYs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-dE8xH-mlPIGBYwRHMyCiMQ-1; Thu, 15 Oct 2026 10:53:51 +0000
X-MC-Unique: dE8xH-mlPIGBYwRHMyCiMQ-1
X-Mimecast-MFC-AGG-ID: dE8xH-mlPIGBYwRHMyCiMQ_1792061631
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a027f2e364so35305945e9.3
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792061630; x=1792666430; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=uN4f1KuqHGe2DuzdAee3ToHFFTYNLWgBakn8qHjmgW0=;
 b=oHChQNMeWH7r5BQHeYD/0cBoSl6F1jJ0M7Obm+4/2fKdfQz1Fkp9wirNeGhGQDIdCV
 ZpVYrOmAP+PEQWxta/+qyfbUjwKSCyZNupLjKpDCU5v+eQEzFYvkC5kru+APjIGuGXdt
 Y8GznbcNALsRUprLbn5/JN6kJ1xpo3i+Ad+rNm05oZuR5IOyFHwnNgERWPlCpF1xR4Ta
 eGeJEQFNq49bpBkOog9PWAKjNz76V4dLkxYmI31EwlvavmGIe0O3lfJ2fcXr4ecCOi+P
 u6HueCxVa7itNSZpAjcUxKK6Vl44rTnaVEZgSdQBeE7HMIjNwkKCLr/zdK9zw/yuRC4s
 dblQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792061630; x=1792666430;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uN4f1KuqHGe2DuzdAee3ToHFFTYNLWgBakn8qHjmgW0=;
 b=wLPeUw0XIVcCtXPV9AaNCDJqZdkdC9H9g8IvTV3fsCEOxLBbsN4wZkYWYw6G3d+QMq
 Cl8zk2XC7jUWURzuEFwML17VYwuxyThIMVgk5QfQz35SwNFGuk58JulahtXZwMHoouU6
 hCqZc77Czvbg5LP1MohcMgEXO1Fqm+qS0GApFoOh5aRYKG9Qkj1Mc/L9Y2qrK4j+mUQi
 Ag8lsnUdgNPvn8YAbIFG6n8qspF2SNkjwEKuYUQIP9vQtoNCPXoNtNEZDMKVzqu/OJ2B
 8hNpxNJkJy+WquJKKjcDrEvHiUZZOYeC6rOvIgbF6q9RwxYQTzlvDyi93GWte2xDE2D9
 2tTA==
X-Gm-Message-State: AFq9FYKnnieXRLgCzjoI95pFHdVJlBA2RfVLuW1liqCP/Xz+8IXn7lTu
 lOi1hDtKpfpDMbznmo5kJ4ktbH11p2e8UpA+y5ijEWrv2kEYRupPJ2wnPrztbWWIB0EI+uaAmDd
 ivfyFUkMpBFQx40eGfaurDDOZ70GUqPUsgiUCxkHf0Sr8tIZ2vVRBreK6QaLMdICECnv1e+/0xT
 sxEcWHz4h4sUVWHTrtO8X6XYXpbnDBXZwzhZL7wC1h
X-Gm-Gg: AYBFou0BoJCmRJrcn1qM04uqREEyx2Ry9SbDkZRbGmVYa9COwTX5Or7JlzV3bGc65I5
 IdQ2+44eWetCSokeNwbwcKurdPQ/GE8UJ+aJ1gm/v5HAsRuCbQRWiQ4QP3BFsXZq7F7sWYYcSzq
 CYf/c2o3IfPsEzBgIFgZUuCKNLOlz6cTaMVuuZ8ueesXVeYCxr7sce916xlia9YXGuT+4YN8XrF
 LRwWLVmU2Bop2YJiNVEPJvoB1w595tetPWoxzAv9sdIrewptO6jXROJiwx+10OESwXMp8ukXe/+
 W6MADesL2ASvu1VmUpOwRg/CzUOT8fWc3yPe0FE41Zd5b7P+kyRbRj1VZ1fwjn1CqgPF6UTwNdm
 YjDuQgXO5A6bnA6MnFxcnc+24/qz2xoxAk2jBhZR9t0ss7bJM7gytD3HsLvaqTkuMxznDmpM0m/
 3uW6jq
X-Received: by 2002:a05:600c:5249:b0:4a0:1b14:e846 with SMTP id
 5b1f17b1804b1-4a18e446905mr363862175e9.4.1792061630540; 
 Thu, 15 Oct 2026 03:53:50 -0700 (PDT)
X-Received: by 2002:a05:600c:5249:b0:4a0:1b14:e846 with SMTP id
 5b1f17b1804b1-4a18e446905mr363861655e9.4.1792061629940; 
 Thu, 15 Oct 2026 03:53:49 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.82.153])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd648fd8sm26998385e9.1.2026.10.15.03.53.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:53:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/13] target/i386/tcg, SCSI changes for 2026-10-15
Date: Thu, 15 Oct 2026 12:53:34 +0200
Message-ID: <20261015105347.827029-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

The following changes since commit 615ece3c406b262996e569f29ea6eed0d81c4d8d:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2026-10-09 15:49:53 +0200)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to eec2d0c16d4a2541a14f5a1867812a508ba7b95e:

  scsi: document PR_HELPER_CLEANUP command (2026-10-15 12:05:44 +0200)

----------------------------------------------------------------
* target/i386/tcg: zero FXSAVE FOP and reserved slot bytes
* target/i386: fix immediate stack adjustment for RET and RETF
* target/i386/tcg: remove unused operand types
* pr-manager-helper: fix sense buffer overflow
* scsi, pr-helper: clean up multipathd PR state after migration

----------------------------------------------------------------
Artemii Mashanov (2):
      target/i386/tcg: zero FXSAVE FOP and reserved slot bytes
      target/i386: fix immediate stack adjustment for RET and RETF

Paolo Bonzini (2):
      target/i386/tcg: remove unused X86_TYPE_L
      target/i386/tcg: drop X86_TYPE_A

Stefan Hajnoczi (9):
      pr-manager-helper: fix sense buffer overflow
      scsi: increase sense buffer size in scsi_SG_IO()
      hw/scsi-disk: move MIG_EVENT_FAILED into a new function
      qemu-pr-helper: add PR_HELPER_CLEANUP for live migration
      pr-manager-helper: add PR_HELPER_CLEANUP command support
      file-posix: forward PR_HELPER_CLEANUP commands to pr-manager
      scsi: clean up persistent reservation state after migration
      scsi: use REGISTER AND IGNORE EXISTING KEY for robustness
      scsi: document PR_HELPER_CLEANUP command

 docs/interop/pr-helper.rst       |  16 ++++-
 meson.build                      |   2 +
 include/hw/scsi/scsi.h           |   1 +
 include/scsi/constants.h         |   1 +
 scsi/pr-helper.h                 |   3 +
 target/i386/tcg/decode-new.h     |   2 -
 block/file-posix.c               |  18 +++--
 hw/scsi/scsi-bus.c               |  10 +++
 hw/scsi/scsi-disk.c              |  45 +++++++++---
 hw/scsi/scsi-generic.c           |  64 +++++++++++++----
 scsi/pr-manager-helper.c         |  23 ++++--
 scsi/qemu-pr-helper.c            | 146 ++++++++++++++++++++++++++++++++++++---
 scsi/utils.c                     |   3 +
 target/i386/tcg/fpu_helper.c     |   3 +
 tests/tcg/x86_64/fxsave.c        |  66 ++++++++++++++++++
 target/i386/tcg/decode-new.c.inc |   7 +-
 target/i386/tcg/emit.c.inc       |   4 +-
 tests/tcg/x86_64/meson.build     |   1 +
 18 files changed, 361 insertions(+), 54 deletions(-)
 create mode 100644 tests/tcg/x86_64/fxsave.c
-- 
2.56.0


