Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE6FC79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 15:57:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Kf9-0001dt-MP; Wed, 09 Sep 2026 11:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x4Kf7-0001dN-FJ
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 11:56:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x4Kf2-0002q0-Uh
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 11:56:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788969391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=t8j65Yvqnsm6pnOqWMHetHUqmxqVJ9XH3si7h7ek6bU=;
 b=Qj++7IyUMSOopKgRyvs0mzPbuQ5+kIES2aVrDlvaOXEZAbbc9LZXTfA2r8Bn6ObQuuZ0B4
 aHFwJbVKyFdkhXxdSe84ufJPFyGgxYliX5u8U6oV4OBqh2yge7RVg0eilDEafadhfDw4+Y
 Sb/7xKbCyAPYnjMUTtjuVOC0t6kI8/w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-FIeldD6WPOW6MBn2c6LNOQ-1; Wed, 09 Sep 2026 11:56:30 -0400
X-MC-Unique: FIeldD6WPOW6MBn2c6LNOQ-1
X-Mimecast-MFC-AGG-ID: FIeldD6WPOW6MBn2c6LNOQ_1788969389
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-485835753caso4898610f8f.3
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 08:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788969389; x=1789574189; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=t8j65Yvqnsm6pnOqWMHetHUqmxqVJ9XH3si7h7ek6bU=;
 b=RTnczbRQg14qMUFH5053Q6Tl3gQDRyFXSKlTVi30O28P5PB2tUypfwuIlzQhBiWzAs
 z/I5uac4V2/tI8BV7xxaM5TApQ6y6Ah+JhLPH00zUW8T23L0VeTo4xRUh3vgXcwZEUy0
 fgQjjljlV+3ApfUVFQrcbmSLvhk8jQE/l1k1OLyawzruHgrB7ntP+yGdpHXUt7M8swe9
 /xGw5txj6klrwwwGVC5p+uiPUZftPbPFBjMGU47U8HjsKLbivphAa7g14I590mKEHE1D
 RvhPyqT1FRlcr/Xh6xXhzAj0hDzLF0hbzVuw9js2DVTvGehU1lpU1il7GVRjDJJEHX5R
 61gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788969389; x=1789574189;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t8j65Yvqnsm6pnOqWMHetHUqmxqVJ9XH3si7h7ek6bU=;
 b=sKzl0ynF27c3A4X9u05WCMUAs3RDMMD9XsGEpGphzAbuQhFWc+Jp9Es1M5/ZVIPbnQ
 3T0erCM84iJXh+Y4MGBkF1CpiSiYcYjlMHgYQiXDnUTrbtq6E8QuSpDAikDokClzjNT1
 g0jRTjuL4JTL5uX9KFacY9VsMaHzDl6/v4qieyxn0pZiqI2I5n2BVSU8LWrf7v2WlJmw
 btF/YrDyvdfKeXcmMQMIYme2kQ8a3CvvzBRq/ke1Wqjvl2KOo0FhwcPskU5JdCIXifH6
 0QvRssfapWafn4nOfoaWcnMjPIfHuM4Tj3P53LyFfEzywGcHjIWNk5cJBNUzUq8ACNJp
 7eqQ==
X-Gm-Message-State: AFuF++ly4JBZ3paRfo802jrI7SVddVfk3GLGKSxg1l28aDPAvbdxGclh
 s0UNr9z3h2DMBCXuO3npWLTCjR3xbUHp1p4muM4mD88T7xT7rz+4LMjpRd7zM187L4+g/WXIp/p
 ToqMxHn+WhWNBasP3Nh4VC9+V4bq8nwun9odNfNdRH/rHD98noR5rTn2rKeJo8geNfE2WEtUUMC
 NoEMxrBz0NKcAZhjZU8Pg5iH8K0lbH+1OyYB5J0s5d
X-Gm-Gg: AYBFou3mb+OWR9Gv3ykDyZU2OpRxW8ZWiAj/A8YZ1gQC8KPxvmwpji08lE1mc2KVo0N
 L+1iHBYqE5eVIhDi/gh1UpHFuMrHpe/CngyBkZ8YGLFvbi7XWJDEUXX4z7+KDMiPCwrQNqElhqr
 mxperFSd9dRxZ8Uk7OwokeWrvsUY6BaltQO1dCG9ioqljJWLNzI571pBGX4CJh7w48mgvK7/OEX
 GaBMjuotbpJH3Mb5bos/oqyY39lt2au3bieTVCfOHsPNK7xz2lR6IBIbVaqOPYSvgjeAk0tk4ZT
 P9VA7PZNdYzlN/IEKdduFhbwb7/aabHXznnt+0WBd1pQkm0LQRuFcoBf4V0yqqsS0+nJOW5symQ
 IDne5eMs3zi+LaUws2o6tsCNWwROgqKOo3NU5CHcjastwbobui3CIChJppwq2pvjBSQBXELO42R
 zM5mYq
X-Received: by 2002:adf:e18d:0:b0:485:8a46:7060 with SMTP id
 ffacd0b85a97d-4858a46720amr34813051f8f.50.1788969388915; 
 Wed, 09 Sep 2026 08:56:28 -0700 (PDT)
X-Received: by 2002:adf:e18d:0:b0:485:8a46:7060 with SMTP id
 ffacd0b85a97d-4858a46720amr34813005f8f.50.1788969388322; 
 Wed, 09 Sep 2026 08:56:28 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485885b1320sm43577978f8f.27.2026.09.09.08.56.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 08:56:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/12] Misc patches for 2026-09-09
Date: Wed,  9 Sep 2026 17:56:12 +0200
Message-ID: <20260909155624.1082893-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

The following changes since commit d2843fbf80260e4346c856819e8cea11768c9d0e:

  Merge tag 'pull-riscv-to-apply-20260904' of https://github.com/alistair23/qemu into staging (2026-09-04 09:43:27 +0100)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 0937f8a26c159d710ac6a122cc99f9661e739950:

  rust: bindings: disable more clippy warnings (2026-09-08 19:36:25 +0200)

----------------------------------------------------------------
* AGENTS.md: basic bare minimal guide
* target/i386: TCG fixes
* scripts/checkpatch: warn on duplicate trailers, self-review, crediting AI
* docs: link to website for IRC and mailing list
* rust: qemu-macros: remove redundant clone()
* rust: qemu-macros: silence more warnings for bindgen crates

----------------------------------------------------------------
Alex Bennée (1):
      AGENTS.md: basic bare minimal guide

Andrey Polivoda (1):
      target/i386: Mark MOVNTI as not valid with prefixes 0x66, 0xF2, 0xF3

Marc-André Lureau (1):
      scripts/checkpatch: warn on duplicate trailers and self-review

Paolo Bonzini (4):
      docs: link to website for IRC and mailing list
      checkpatch: reject trailers that credit an AI agent
      rust: qemu-macros: remove redundant clone()
      rust: bindings: disable more clippy warnings

Simon Scherer (5):
      target/i386: Fix FXCH to unconditionally clear C1
      target/i386: clear C1 for all x87 compare instructions
      target/i386: Update FPU tag word for FXTRACT's old ST(0)
      target/i386: Update FPU tag word for FSTP
      target/i386: Update FPU tag word for FXCH

 docs/devel/conflict-resolution.rst |  7 +++---
 docs/devel/index.rst               |  4 ++--
 target/i386/tcg/fpu_helper.c       | 34 +++++++++++++++++++++++------
 target/i386/tcg/decode-new.c.inc   |  2 +-
 .claude/.gitignore                 |  2 ++
 .claude/rules/agents-md.md         |  1 +
 .gemini/settings.json              |  5 +++++
 AGENTS.md                          | 40 ++++++++++++++++++++++++++++++++++
 Cargo.toml                         |  1 +
 rust/bindings/chardev-sys/lib.rs   |  1 +
 rust/bindings/hwcore-sys/lib.rs    |  1 +
 rust/bindings/migration-sys/lib.rs |  1 +
 rust/bindings/qom-sys/lib.rs       |  1 +
 rust/bindings/system-sys/lib.rs    |  1 +
 rust/bindings/util-sys/lib.rs      |  1 +
 rust/qemu-macros/src/lib.rs        |  2 +-
 scripts/checkpatch.pl              | 44 ++++++++++++++++++++++++++++++++++++++
 17 files changed, 134 insertions(+), 14 deletions(-)
 create mode 100644 .claude/.gitignore
 create mode 100644 .claude/rules/agents-md.md
 create mode 100644 .gemini/settings.json
 create mode 100644 AGENTS.md
-- 
2.55.0


