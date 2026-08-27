Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B75F1C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:16:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzarN-0002cG-NQ; Thu, 27 Aug 2026 10:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzarM-0002c1-Cb
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:13:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzarC-0005eP-Ch
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:13:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787840009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YShCvgs5y/flDeRVs7TKOSqOFTuCBjlBJVFCEqRO1es=;
 b=bLK6IQXTwqcDrU6WZjwc7RmT4xUfzgxPdqwG+txzQ80SOhvgJVJys5c5vRlIYvMelYTScJ
 jDc9FgPWIg6QRwACvwcdYL0uX6oBocsqFJkbiG0Iqr9BFIby86FgqZiCnWCuUSeyIhzkyb
 B0DqbuKajD6/9ZxE8tdIpcah3SC3Iz4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-9s9sRBLoNQ6O7PAUKb_tDw-1; Thu, 27 Aug 2026 10:13:18 -0400
X-MC-Unique: 9s9sRBLoNQ6O7PAUKb_tDw-1
X-Mimecast-MFC-AGG-ID: 9s9sRBLoNQ6O7PAUKb_tDw_1787839997
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49a1b4ea633so9215685e9.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787839997; x=1788444797; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YShCvgs5y/flDeRVs7TKOSqOFTuCBjlBJVFCEqRO1es=;
 b=CSVR7nFkeMaR0o4KOrLergKgEHrTzpeFz/KrXaBWTXvkTwyrMfD5lw/bYEOltRe9zZ
 FbGXJcwb5chT/7mV2JCnXrpa9nj4QgI67H+xo4iEtbd5oGfdBPLkW3VqjpEeSg0NERUS
 UXgRvhLB4S0MU3XSGhdbBCdpMIjnKXs1wqhzPjqTYw3upj70ZdvzS9T9BJ+PIbCDY33u
 fEQD1lI0XiZ/1S6/z3BEa5ZMJcNDaGmOiS6xxrYe/G+XDdsPPjw0nrH4AP08rKl8+Ju0
 3OaXzE33K68+tUbvtlu48tmxPdokjhLY3Pkqja3cHTa+IsrCCyjhpQWR+Ba8w8ddVyU0
 4FDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787839997; x=1788444797;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YShCvgs5y/flDeRVs7TKOSqOFTuCBjlBJVFCEqRO1es=;
 b=Ep39exzyVNV0DVhQGLokBznYzfYImgxEwsHxzVWuAg1zCzCIuPJ3TQuqoyh7mVjp0A
 nfu2OT5urKwJ3VGadKl4QgRUpqpbYxLnoZPEt9A+9qMiHEsz356tc2zLsD29NRqzn0an
 fj2fg0+EiIH/1TiOZ/wjCqTre9FAcWmwl+jxu7epgZNOxvJyQ1eGi3yq1clYuLMkrtl1
 KQiAYRybBjWgdP4WVY0sUZR0MG1DBRAbtZYx/08JilULV/SUmHEmOnCM92Ij4iNucbI5
 ZaDDFnROxEmDNHub3IeP8Rz7J876sVYfZ/Q7SgITobwEjJIMSO+IOxIPy585owhqAIt+
 LyNg==
X-Gm-Message-State: AFuF++lrEUk1ECVFYMMXzIPoeIbTm6nfu81ZhdLSxap+5TWHdmkVUpDv
 u6lSZPxaKCVleomGvtAP1kmq4A9Q9uP8o4hpfINjbfr+lqLyz5GnUb0EKcQ7Czvf6PXjUA0OG70
 BMjzvCEz6vO/rM/oacG9aUNHetE1hE4S7+TfN01SroGNjtl/SkxkfZJMU1cpK9Voqfb0k0Krdij
 bW8VTNJVlgGpXTTWIRdw4t2n2RXTVa9PwBZ3/E+6xs
X-Gm-Gg: AR+sD133nVUnCfXbuc8OrnZbAsRDGugpdoXWoAG31i+ewnxcandQi6imAwiOatG8cMX
 AZ37k0QeM1DMKn6+KVIe21zE6z7sIzC+tyGZZO1YH9kz8lXNo1gWQguFKEKUqn9B5Gnhj/2jpBe
 wOoS79EKYzWXz9ONkXyr/q2FCkNnrK/E6KvVOCLsg3L/Vdcpuo4mb3cgKd+5f7rsg3cY026nVXg
 H2eF6xl5IcnmE/nGGdZyNZGqIM0Rl0kDVs3jk4Ad7pYeMni+040QSobPhzSex05Q6VugVXiOKfT
 428iDLUPDeoL2N+UHmzzxbRacDlNhnOTi/ysZxfEDcXg8t7OInBUnNSAzqtooVDjIY9Zq1mrap7
 +CkJWtVvdb5QdNDPr+B6PmUA85smllIWKGUWXLUQqEBVcCffugrZpwflw7YgJo7Z6y1ofPcUTNB
 +5baE=
X-Received: by 2002:a05:600c:c0da:b0:499:83f1:398 with SMTP id
 5b1f17b1804b1-499dc820705mr171530065e9.9.1787839996962; 
 Thu, 27 Aug 2026 07:13:16 -0700 (PDT)
X-Received: by 2002:a05:600c:c0da:b0:499:83f1:398 with SMTP id
 5b1f17b1804b1-499dc820705mr171529005e9.9.1787839996309; 
 Thu, 27 Aug 2026 07:13:16 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.151.49])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b4c321184sm69911785e9.11.2026.08.27.07.13.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 07:13:15 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/23] Rust, i386, SCSI changes for 2026-08-27
Date: Thu, 27 Aug 2026 16:12:48 +0200
Message-ID: <20260827141314.1099352-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit f57fc2f7ce667b6527582862e69d526edd3ee0e2:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2026-08-20 16:01:59 -0700)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to cfa6e2c52ca8f756461fe41f4ce40e61a82fd914:

  i386/vapic: unref MemoryRegion if vapic_map_rom_writable fails (2026-08-27 14:02:31 +0200)

----------------------------------------------------------------
* rust: introduce script to update crates
* rust: update dependent crates
* target/i386: tcg: small cleanups
* target/i386: tcg: decoder cleanups around VEX prefix
* scsi-disk: disable MODE SELECT block size change by default
* scsi-disk: fix out-of-bounds read in WRITE SAME
* hw/i386: harden vapic against mapping the writable region over SMRAM

----------------------------------------------------------------
Paolo Bonzini (23):
      scripts: remove dead variable assignments
      scripts: print build.rs diff
      scripts: rename variable in scripts/get-wraps-from-cargo-registry.py
      scripts: do not assume the new version of the crate is present
      scripts: prepare for introduction of CrateSource class
      scripts: introduce CrateSource abstract class
      scripts: add functionality to update wrap files from Cargo.lock
      scripts: add the possibility of a quick update of the pacakge
      scripts: rename get-wraps-from-cargo-registry.py
      rust: update crates
      rust: hpet: fix clippy needless_range_loop
      scripts/feature_to_c: avoid SyntaxWarning
      target/i386/tcg: do not reuse cc_srcT
      target/i386/tcg: inline gen_ext_tl
      target/i386/tcg: simplify return value of gen_prepare_cc
      target/i386/tcg: move check bits out of validate_vex
      target/i386/tcg: treat VEX as disabling high-byte registers
      target/i386/tcg: fetch modrm early
      target/i386/tcg: move VEX validation early
      scsi-disk: fix out-of-bound read in WRITE SAME
      scsi: hide MODE SELECT block size change behind a quirk
      vapic: confine the VAPIC region to 0xc0000..0xe0000
      i386/vapic: unref MemoryRegion if vapic_map_rom_writable fails

 MAINTAINERS                                        |   2 +-
 docs/about/build-platforms.rst                     |   2 +-
 include/hw/scsi/scsi.h                             |   1 +
 hw/i386/vapic.c                                    |  18 +-
 hw/m68k/q800.c                                     |   2 +
 hw/scsi/scsi-disk.c                                |  17 +-
 target/i386/tcg/translate.c                        |  93 +++----
 target/i386/tcg/decode-new.c.inc                   | 146 ++++++-----
 target/i386/tcg/emit.c.inc                         |  15 +-
 Cargo.lock                                         |  60 +++--
 Cargo.toml                                         |   2 +-
 rust/hw/timer/hpet/src/device.rs                   |   4 +-
 scripts/feature_to_c.py                            |   2 +-
 scripts/get-wraps-from-cargo-registry.py           | 184 -------------
 scripts/update-cargo-wraps.py                      | 285 +++++++++++++++++++++
 subprojects/attrs-0.2-rs.wrap                      |   9 +-
 subprojects/foreign-0.3-rs.wrap                    |   6 -
 subprojects/foreign-0.4-rs.wrap                    |   7 +
 subprojects/libc-0.2-rs.wrap                       |  10 +-
 .../packagefiles/foreign-0.4-rs/meson/meson.build  |   3 +
 .../packagefiles/libc-0.2-rs/meson/meson.build     |  20 +-
 subprojects/quote-1-rs.wrap                        |  10 +-
 subprojects/unicode-ident-1-rs.wrap                |  10 +-
 23 files changed, 528 insertions(+), 380 deletions(-)
 delete mode 100755 scripts/get-wraps-from-cargo-registry.py
 create mode 100755 scripts/update-cargo-wraps.py
 delete mode 100644 subprojects/foreign-0.3-rs.wrap
 create mode 100644 subprojects/foreign-0.4-rs.wrap
 create mode 100644 subprojects/packagefiles/foreign-0.4-rs/meson/meson.build
-- 
2.55.0


