Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC9BCFD2F6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 13:21:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vObwA-0006QA-3A; Thu, 27 Nov 2025 08:21:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObvS-0005MP-Vm
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:20:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObvQ-00023k-M7
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:20:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764249642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=u17RIjjVp6LXVD3gf84zUaaFlYVW+8dZ+Pm0JVHMJA8=;
 b=KBICXY5F1/LgK/ys0Dh14yMey41isa+70Wxrv1EroLhp0aeJD1Bt64hMG0fcAjSeZjXPES
 bVHe9oL6HuCB6tiBzGYZoIrERi9Fuuzm4bTVu9x6RFsfrIRZ2HIIxeYPdgd7C6cXwwlqe3
 iHQCfvPrC/lBCWfa9dwig9OOsADWCMw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-T529bIfVMQeUexJ5ynZCJQ-1; Thu, 27 Nov 2025 08:20:41 -0500
X-MC-Unique: T529bIfVMQeUexJ5ynZCJQ-1
X-Mimecast-MFC-AGG-ID: T529bIfVMQeUexJ5ynZCJQ_1764249640
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b7387d9bbb2so64018166b.0
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 05:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764249638; x=1764854438; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=u17RIjjVp6LXVD3gf84zUaaFlYVW+8dZ+Pm0JVHMJA8=;
 b=lVzGdxcw0YLMYoWkms9H4eQzvLtKwJtUNYaHz8pHMBq478JQzdW6m3hGEKh/BICsvw
 SkhXcFbgIInnk5Ua4g6jwmIj1ETZHN2OXW0fD3OSl29uae6yHLlmm0lsAgnuI4Oj+5lZ
 jdXYEykkCPAKmAXZBVlWNyN4Zd6KfSPFyqdUD70JX3xw+/zmqt+dqOzqh7+y3h12xXmf
 tLzv7dNWIeb/p+IuZ4dOeKNgPzVcsEotnu7/52HrA9+SXkq53rlxpD9Gzz5jArehG0wV
 FiyG+wCRMbDvffOoyO35hw1JxSgVxOAkgJ8RTN0ZapXQLstfotbSurcmsdaPJY11se41
 pmsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764249638; x=1764854438;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u17RIjjVp6LXVD3gf84zUaaFlYVW+8dZ+Pm0JVHMJA8=;
 b=B8l+ULDs5UVQorFXRhi5oceoiqyDTh8MmRjhwxWRqVTGuPDArBmxieGkoTlkKheQIA
 CWyA4j1LdA7YwhD+QCHqThMXgeTcbXB6uEguJ+FUkFuojC0EZgn3c7ft7tBHfrTNWJEv
 0JH0XW39WYHaLVJ6IeRQhNpNTid07S5X3e7/PiT5opQr75pt99SbSAeFHt6eKUWDGLUg
 TUBc6XcShZYg3++yaF03rn290NZA3Y6KkjjK7j9y2NPxT1e3mjq2eUrB4KH6WFLVl3S1
 e++MugpzQ+8xCNPXEIWq/Z9xcJ9XoiGJh0ZTPgPwTQXKoIXVKKpVN0+lmQc5UQIrlaED
 PQbw==
X-Gm-Message-State: AOJu0YybVJzjg1p9cPUfqROjMHhLaJmeGHtfnt0cf/GDl5gl1npvsI8n
 RiLUBI/YGZcwCtt/UIBdmyg/8gVUXwa90PUVkmz7M1p9hKWpkq5mxmPj4igfCiAVa7Ulk9XAnty
 zxoQfkVGzM+PdnHYR/hvzr/tPW/BApzRLN0MB3O/XYrhjn8grrZY4L/xHzw6FkkwTl8iMxUCt/k
 3y09aW2av5WMh7x/9MMZ38IcJW18c8U6dfCuJukrpB
X-Gm-Gg: ASbGnctk6qYhvnCAKlIAZiI9fEt8R39aZLAWIpIJUQlaGZ6zEx+L1BldrHkfUAsMJe/
 fYmn6+mnAJDGcsAClPB5qqc3+JoOytzXgnWBAvXOBhuomXbiVCdnCHvxeLOvylP4A0iBxH3c15B
 0ON+t4fOdavmz/6zTTnqG9bIZWdG3y+FI8QiaQRic98nIb8NOHabyLY6J1TLZP/7DzbDNH5csoP
 Ukibq93J+ld6F6hVtEjjTr/y1CF6VjY0ODtp+C8kwdTe5Nh1Kaw5r5pkvJscy7Y0eutuovoJ4fq
 pTFW2fLR6twCkvsPU0ns1YkrE11MDs13R2P1oGIWpBHelyprFPRycphMtU1QCUn1pNAdzuN02Rd
 bJY9e/p4gxz9w8OiYa+LwjQxOVB6eUNsmZ/GOCg8gbfMur8oI8K9IG1GE7xL8q5FXWPzM5LYXLc
 +p6ORk+UjCY1HP5A0=
X-Received: by 2002:a05:6402:280a:b0:640:93b2:fd0a with SMTP id
 4fb4d7f45d1cf-645eb296885mr9769231a12.20.1764249638541; 
 Thu, 27 Nov 2025 05:20:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEiwxgu70lAYL36dx9Gs9DhP+ATOKfmsqnXj1moZFmWErzSFwQXcoYyKjz1Z4DYeF2xauzGYg==
X-Received: by 2002:a05:6402:280a:b0:640:93b2:fd0a with SMTP id
 4fb4d7f45d1cf-645eb296885mr9769192a12.20.1764249638068; 
 Thu, 27 Nov 2025 05:20:38 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64751061e60sm1603926a12.32.2025.11.27.05.20.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 05:20:37 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 0/9] rust: build system and other cleanups
Date: Thu, 27 Nov 2025 14:20:27 +0100
Message-ID: <20251127132036.84384-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

A few small changes that I accumulated or received from others.

Paolo

Marc-André Lureau (1):
  rust: remove leftover bindings/

Martin Kletzander (1):
  rust: Do not link qemuutil into Rust rlibs

Paolo Bonzini (7):
  rust: remove unused --cfg arguments
  rust: remove unnecessary repetitive options
  rust/bql: make bindings public
  rust: do not copy the SysBusDevice
  rust: fix reference to MemoryRegion
  rust: move strict lints handling to meson.build
  rust: only link the Rust part of the code into devices

 meson.build                                   | 10 +--
 rust/bindings/src/lib.rs                      | 64 -------------------
 rust/bits/meson.build                         |  2 -
 rust/bql/meson.build                          |  2 -
 rust/bql/src/cell.rs                          |  2 +-
 rust/bql/src/lib.rs                           |  2 +-
 rust/chardev/meson.build                      |  4 +-
 rust/common/meson.build                       |  2 -
 rust/hw/char/pl011/meson.build                | 18 +++---
 rust/hw/core/src/sysbus.rs                    |  2 +-
 rust/hw/timer/hpet/meson.build                | 16 ++---
 rust/migration/meson.build                    |  2 -
 rust/qemu-macros/meson.build                  |  6 --
 rust/qom/meson.build                          |  4 +-
 rust/system/meson.build                       |  2 -
 rust/tests/meson.build                        |  1 -
 rust/trace/meson.build                        |  2 -
 rust/util/meson.build                         |  6 +-
 scripts/rust/rustc_args.py                    | 20 +-----
 .../bilge-impl-0.2-rs/meson.build             |  3 -
 .../proc-macro-error-1-rs/meson.build         |  1 -
 .../proc-macro-error-attr-1-rs/meson.build    |  3 -
 22 files changed, 32 insertions(+), 142 deletions(-)
 delete mode 100644 rust/bindings/src/lib.rs

-- 
2.51.1


