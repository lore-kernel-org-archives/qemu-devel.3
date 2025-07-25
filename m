Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D1F9C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 12:55:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufHwk-0006gQ-6B; Fri, 25 Jul 2025 08:54:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ufHwQ-0006Kq-0Z
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:54:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ufHwL-0007vk-Kn
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:54:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753448058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=HcsP+DKAx+d2yZXMZFx93ydecLEnUazc4oLS6lFAV8Q=;
 b=YVWG3yjPoReIceNLsd94tVKoF4WWLra9UW6xoFfv/kQwk34yzc7G1W0jo3wwlZUZYHi5pk
 iTCayURRb26zyA/i/O9v7ZKlFGMH12UPFTge29IAbYHpZmd51TTXT53Vnij31REyfXduoy
 X/1tY0pG9dVvbyWovcLQjUZ/ZqEZkhY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-XSEEDmYoN1em8UzGYOtdPw-1; Fri, 25 Jul 2025 08:54:16 -0400
X-MC-Unique: XSEEDmYoN1em8UzGYOtdPw-1
X-Mimecast-MFC-AGG-ID: XSEEDmYoN1em8UzGYOtdPw_1753448056
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4561611dc2aso16842835e9.0
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 05:54:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753448054; x=1754052854;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HcsP+DKAx+d2yZXMZFx93ydecLEnUazc4oLS6lFAV8Q=;
 b=A4fSc+m+68QLZO5T9a9z5/RfJvI9i/oKtyfZLcTa4FFC6krHYpxldCFR4sJ00LA0qs
 yv8QUn25gnrUzhNO+m7SD8ra/vbd1IVlbL3EFpRDf2lKsJVQW2Cdr0huTQFTIfEYYIse
 RjmuRB8SG7Zbv4pxtVpOFR1mkihv9hha5FcnzikCnNohZGrM0UGcxbTrju+TehGgrRNJ
 dMaVo/UCz50cfEF3OcnZE5CpVee4PIraQAhAcJPFSa8Fwre6XIr2V4UyPi0M2kb2kbOG
 qP7Hb9JRFqDGfpJpRYA7URlYWithw27u9AK1f5e0GlkoiYon6zSpecrUNFf8CTab4TXG
 uNtg==
X-Gm-Message-State: AOJu0Yz7ST4LrOd1pO2BLyw7lY0zQ1z3oYoRkt0vpB7fORp0XmDnIQLV
 2//sQi0LfT7eTl3V/+csAKatEe7zJ3R8+dErdaFO0a0EEPi2kPoR6KCw9XAmtsRGdiegJ5buljv
 BK7dc6Ue0yGno9bkihSBtg50zoYbaS66TN6nyaxVLiwRP4+zssis44VEFkrE3kkkKyqljyCAApG
 kgmhRnbfUDSoWuQbggRqWwPU1F9EP2Y75P7Bd6xlpP
X-Gm-Gg: ASbGncuPFDAOyUfvHun1isVqE0M+Y+TlNGDnHNYn8EoGWzBolzd9xRwLpcVq/20fGLO
 NPHDyhT1+zSjqa4TVq/Z4qG+Hxwy+ZsffN+iL2FWaBleKgMfnC8i9x/jeFeTH2XDd6zSgnamEX0
 oB+pS0ROnTGqxjpmo0bbf7OcGOVNmypIA9Lv4Zex13tpgK5VhNWMqZihTEnuTI8NcjF0bTEn1/A
 z7R+q7VzPdep2E8ULxg8kZNLuJ+ccprhRVBynLFniFsc3paE0MBC936/cT934+Q3ZLnrPFwpeS2
 C85UfSKKjaV5Ky2Rsfvxsfx7H4g00zV753u+KeAkRM17
X-Received: by 2002:a05:600c:35cc:b0:442:e9eb:cba2 with SMTP id
 5b1f17b1804b1-45875f73f0amr16698095e9.0.1753448054389; 
 Fri, 25 Jul 2025 05:54:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHaTPGogp+fW/mHLsZ5dEdd9d/dGzglCtiwidTgamvgSrKQHkzGwxiqqyspxCXgc3mPdX6OQ==
X-Received: by 2002:a05:600c:35cc:b0:442:e9eb:cba2 with SMTP id
 5b1f17b1804b1-45875f73f0amr16697815e9.0.1753448053826; 
 Fri, 25 Jul 2025 05:54:13 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.154.122])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b76fcc3c4csm5108091f8f.76.2025.07.25.05.54.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 05:54:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/4] Rust, target/i386 patches for 10.1-rc1
Date: Fri, 25 Jul 2025 14:53:59 +0200
Message-ID: <20250725125412.1128617-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.175,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 56a3033abcfcf72a2f4f1376a605a0b1ad526b67:

  Merge tag 'pull-request-2025-07-21' of https://gitlab.com/thuth/qemu into staging (2025-07-21 06:34:56 -0400)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to feea87cd6b645d5166bdd304aac88f47f63dc2ef:

  target/i386: fix width of third operand of VINSERTx128 (2025-07-25 14:51:11 +0200)

I would like to include this script in QEMU 10.1, after talking to members of
the Fedora Rust SIG, in order to experiment with RPM packaging and be ready
for possible enabling of Rust in QEMU 10.2.

Paolo

----------------------------------------------------------------
* rust: small cleanups + script to update packages
* target/i386: AVX bugfix

----------------------------------------------------------------
Manos Pitsidianakis (1):
      rust/pl011: merge device_class.rs into device.rs

Paolo Bonzini (3):
      rust: devices are not staticlibs
      scripts: add script to help distros use global Rust packages
      target/i386: fix width of third operand of VINSERTx128

 MAINTAINERS                              |   1 +
 docs/about/build-platforms.rst           |   8 ++
 target/i386/tcg/decode-new.c.inc         |   4 +-
 rust/hw/char/pl011/Cargo.toml            |   3 -
 rust/hw/char/pl011/src/device.rs         | 103 +++++++++++++++--
 rust/hw/char/pl011/src/device_class.rs   | 103 -----------------
 rust/hw/char/pl011/src/lib.rs            |   1 -
 rust/hw/timer/hpet/Cargo.toml            |   3 -
 scripts/get-wraps-from-cargo-registry.py | 190 +++++++++++++++++++++++++++++++
 9 files changed, 297 insertions(+), 119 deletions(-)
 delete mode 100644 rust/hw/char/pl011/src/device_class.rs
 create mode 100755 scripts/get-wraps-from-cargo-registry.py
-- 
2.50.1


