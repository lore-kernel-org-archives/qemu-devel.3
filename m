Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EC0606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 13:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jHZpVCIv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTJNp-0006YE-2Q; Tue, 17 Nov 2026 08:38:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTJNm-0006X1-Cf
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 08:37:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTJNk-00035f-8n
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 08:37:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794922674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=oFBMsUI+Ucyzs+OoWLQ1u3Vywo6TgCrAeUy+LC9uL2k=;
 b=jHZpVCIvWfC/mJzeRVjlwhR8DOl33iHkppPZm1sgOkkx5AVhHLb280bZBi1hQtjHIk7uSR
 Pv3b5LgkhUwCq7wdeXKhDLhNfJBZaTCNTa1cn18Jk4TUpLxMib8V5GRS4sj+KDDbGdbpBl
 vMQ7V6i2Vg4Lnsvf5fmAJ1Sa4p3HIKE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-wOX_B_-KN1qsGcSBagh_lw-1; Tue,
 17 Nov 2026 08:37:53 -0500
X-MC-Unique: wOX_B_-KN1qsGcSBagh_lw-1
X-Mimecast-MFC-AGG-ID: wOX_B_-KN1qsGcSBagh_lw_1794922672
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 92185195607B
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 13:37:52 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E170B41F
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 13:37:51 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/15] i386, Rust for 2026-11-17
Date: Tue, 17 Nov 2026 14:37:35 +0100
Message-ID: <20261117133750.322253-1-pbonzini@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit 97c88c61d45dee6e1f9bc160a338048189846d28:

  Merge tag 'docs-security-devices-pull-request' of https://gitlab.com/berrange/qemu into staging (2026-11-16 15:48:48 -0800)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 5705f0759f17896ae60257af7fc7d23858777fc0:

  rust/common: rename IntegerExt::bit() to single_bit() (2026-11-17 14:35:23 +0100)

----------------------------------------------------------------
* target/i386/kvm: fix latched INIT lost in kvm_put_vcpu_events()
* target/i386/kvm: set VM ioctl KVM_SET_TSC_KHZ to maintain TSC synchronization
* target/i386/tcg: fix CPUID checks for TZCNT and LZCNT
* target/i386/tcg: reject VEX encodings of PBLENDVB, BLENDVPS and BLENDVPD
* target/i386/tcg: fix SETCC(zu) optimization
* target/i386/tcg: fix lea address calculation for CS register
* target/i386/tcg: Fix 64-bit RSP truncation on far transfers
* target/i386/tcg: all scalar instructions should be LIG
* target/i386/tcg: treat ENTER's size operand as unsigned
* target/i386/tcg: remove unused argument of decode_ops
* target/i386/tcg: remove unused operand sizes
* tests/tcg: fix load/restore for test-avx and test-mmx
* rust: fix failure with nightly libstd

----------------------------------------------------------------
Denis V. Lunev (1):
      target/i386/kvm: fix latched INIT lost in kvm_put_vcpu_events()

Dongli Zhang (1):
      target/i386/kvm: set VM ioctl KVM_SET_TSC_KHZ to maintain TSC synchronization

Mark Cave-Ayland (1):
      target/i386/tcg: fix lea address calculation for CS register

NickSampanis (3):
      target/i386/tcg: Fix 64-bit RSP truncation on retf in 64-bit mode
      target/i386/tcg: Fix 64-bit RSP truncation on far call in 64-bit mode
      target/i386/tcg: Fix 64-bit RSP truncation on far call through a call gate

Paolo Bonzini (7):
      target/i386/tcg: fix CPUID checks for TZCNT and LZCNT
      target/i386/tcg: reject VEX encodings of PBLENDVB, BLENDVPS and BLENDVPD
      target/i386/tcg: fix SETCC(zu) optimization
      tests/tcg: fix load/restore for test-avx and test-mmx
      target/i386/tcg: all scalar instructions should be LIG
      target/i386/tcg: remove unused argument of decode_ops
      target/i386/tcg: remove unused operand sizes

Samuel Tardieu (1):
      rust/common: rename IntegerExt::bit() to single_bit()

z Y (1):
      target/i386/tcg: treat ENTER's size operand as unsigned

 target/i386/tcg/decode-new.h      |  7 ++--
 target/i386/kvm/kvm.c             | 19 ++++++++-
 target/i386/tcg/seg_helper.c      | 15 +++++--
 target/i386/tcg/translate.c       | 22 +++++++++-
 tests/tcg/i386/test-avx.c         | 22 +++++-----
 tests/tcg/i386/test-i386-blendv.c | 51 +++++++++++++++++++++++
 tests/tcg/i386/test-i386-enter.c  | 42 +++++++++++++++++++
 tests/tcg/i386/test-mmx.c         | 22 +++++-----
 target/i386/tcg/decode-new.c.inc  | 88 +++++++++++++++++++--------------------
 target/i386/tcg/emit.c.inc        |  8 ++++
 rust/common/src/bitops.rs         |  8 ++--
 tests/tcg/i386/meson.build        |  2 +
 tests/tcg/x86_64/meson.build      |  2 +
 13 files changed, 229 insertions(+), 79 deletions(-)
 create mode 100644 tests/tcg/i386/test-i386-blendv.c
 create mode 100644 tests/tcg/i386/test-i386-enter.c
-- 
2.56.0


