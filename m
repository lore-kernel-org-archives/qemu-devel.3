Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58982D5B172
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 07:51:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV3LR-0000VB-BG; Mon, 15 Dec 2025 02:50:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vV3LP-0000Rs-IB
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 02:50:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vV3LN-0000iA-5d
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 02:50:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765785008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rhRgZBDZXKiwx46WkvcU17DF2Qqr8XZ4jHsnYPyyOuY=;
 b=KDfGDX3w34ZW4Ako+PcrjoYHLHb+m7ORtcDhZ3PBO9mOHL5GtyAyY2lh9v/9Q7o63nL5jA
 +yfluBW7qvD6nU3XNunHIFb/+nop5P3BHBiqY+HphW4p/IJ0N9toJ85I2KoZ2P/CX0AFh9
 yn28M2Nu1dv6ASS4Vg9DfB4OArx2QC8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-dzlsENvMMma6GIavcsQ4SQ-1; Mon, 15 Dec 2025 02:50:04 -0500
X-MC-Unique: dzlsENvMMma6GIavcsQ4SQ-1
X-Mimecast-MFC-AGG-ID: dzlsENvMMma6GIavcsQ4SQ_1765785004
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-430fcf10280so408712f8f.0
 for <qemu-devel@nongnu.org>; Sun, 14 Dec 2025 23:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765785003; x=1766389803; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rhRgZBDZXKiwx46WkvcU17DF2Qqr8XZ4jHsnYPyyOuY=;
 b=cUDfn6CB92rlH6mWTiOPYEItAqP2SzVBDjy5Gw/YhIj+cEoZ0OAraF+iNbbW7RdrEW
 Z25yFI6OnQgdBC/kWDp2c43As0jiVAqX8AL+32goMDQ/H7fvjrJFzstn5VTiBiIUUwKl
 YanjBnQax1J5FjnZ9ugVuZupZblL5xPNwE3fXXKe5t2e0L1KR7kmohN2C9Jhjyv4/B2K
 6AJzpNpG7ougv+asCPGAB5lzvwS2T8f+xCj54ILzxM3G9/pGhlZvPaS14HEZg97u6AyM
 F2MbksZTaM620Y1MK7qvEh2c0mKVv+JGJFZpwJqylxOOFJ3lhLb8OKO2k0YsSeafwJtn
 oN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765785003; x=1766389803;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rhRgZBDZXKiwx46WkvcU17DF2Qqr8XZ4jHsnYPyyOuY=;
 b=PDnrGiz9Tllr3FWEIQUhACRwyEhYLNEsrAFxchWUP9xtTF/ynwmuGrNpcZOJhjwdXz
 8/6lNBo/0DWT3tkL8QUoIFmOaCWIGqtJEqlRfoOvZ8az1hUFlyIH3yDS/9oSMyR0dTYS
 LRMbA0g2Bnk9UxM4txvvUvUnKWU49EdMLIPAVdmeIxKM//xqPM8IZrFfcb/ybqQfC4Cr
 7GESfaTZEqBUNnvuHZXELYJIV953sE0vlJ2Rp/VgSny3e2JhBD/L6m17HH7qu176MPm2
 UIlBgbk6CKHFHr+1DrRRbK+mGTIIUETE+MzMTzV3OfHuVFDhv4zzdRyDCHRai1QbQ6Xy
 87SQ==
X-Gm-Message-State: AOJu0Yzm1MknHI+A1Te0V/z4/qmoc6sf8xr0g8u/h815xD7WfNnAS8Zg
 CdlWVN/3utsLluZxcnQJuVSdPMB0xPkqjSs+YgJQHIQ30e98fKh98auGfFi/7012ilr4x2AVUV1
 eWxN9maeWA8xyGbGO4EPQRWTHoPD+cTEe6mqFOxlRMzYCykwniBMgXGqBGXeXCg9mvg+S0q9DSq
 SRGIoFjcPVT3tOpiPBb6C44NMkuzA/yAwv+vLvc2Tu
X-Gm-Gg: AY/fxX49uEsd/jiyfrMw9nljGsqv7jnuQBOewBxbfi4+W8s15k47KM2ejphNyHXkZie
 sp1teiCy6395DUBZZMN64uRvTygMvW2A2etLbJX+gf87ZjIZONyZraZteTqoNCGAya7i9wu83s0
 967LX37Bf17OUXDztZECum2kxCKyjUeiLbD1wdKn00mhvH82+DijFyCuVpLjoqCNHw00GWAxPRV
 i9fiFhRC+44iFpIkCihtS4h146Ira00QRHF0glHmmmS71Ry/wxhtHZ4LeLgd0ah0+7uiieX9jBM
 Ax1PcX3cbA9Tlf/hRPQxcg2rDBBUx/5dzP5LU9vL/KNdjS5vFH7BgEiWXKbwOO4vloqRrxZD58N
 QixXCBDbrEdA7T+XwxuJZCzH436M1TXG8YTQ7rkJYO/5tzvbGvR+y6k+swTWalIX+/6l+zvgP32
 +tcG+OxsmrZb8W7QQ=
X-Received: by 2002:a05:6000:1848:b0:430:f97a:6f43 with SMTP id
 ffacd0b85a97d-430f97a7049mr3814573f8f.53.1765785002653; 
 Sun, 14 Dec 2025 23:50:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqzWkYCtIQMI05pCrS1XC2FNK/o+lp8XHVZDoel7bKB7gBh1YsDB/HKtBXjnGc+4FKCfjVyg==
X-Received: by 2002:a05:6000:1848:b0:430:f97a:6f43 with SMTP id
 ffacd0b85a97d-430f97a7049mr3814541f8f.53.1765785002097; 
 Sun, 14 Dec 2025 23:50:02 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fa8b9b26fsm29771952f8f.40.2025.12.14.23.50.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Dec 2025 23:50:01 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	marcandre.lureau@redhat.com
Subject: [PATCH for 11.0 00/11] First batch of Meson/Rust build system changes
Date: Mon, 15 Dec 2025 08:49:49 +0100
Message-ID: <20251215075000.335043-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

By bumping the minimum supported version of Meson to 1.10.0 (at least
when --enable-rust is used), C objects can be passed to Rust targets.
This allows to simplify the build process, and possibly also to link
the executables dynamically linking to Rust's libstd which makes them
smaller.

The major snag here is that QEMU wants to be very explicit about the order
of libraries on the command line.  rustc has a normally useful feature
where it records dependent static libraries and adds them to the linker
automatically, but for us it messes up libqemuutil.a's stubs mechanism.
This is fixed (or worked around depending on how you see it) by patches
4 and 5.

Meson 1.10.0 also contains some bugfixes such that Rust can now also be
added to the Windows and macOS CI jobs.  This reveals a few more bugs,
such as the ones fixed in patch 1 and 8.

Finally, Meson 1.10.0 improves Meson's embedded Cargo.toml/Cargo.lock
interpreter, but those changes are still mostly internal and the
interpreter cannot be used yet.  The required changes are planned for
1.11.0; Marc-André already played with them for his GStreamer audio
backend, and a couple more users are hanging out and helping on the
#meson IRC channel, too.  Once this functionality is merged, it will
replace a few hundreds lines of meson.build code and will make it simpler
to add new devices.

I still expect that the --enable-rust option will require bleeding
edge Meson for a good part of next year.  However, as was the case for
the original switch to Meson, this will smooth out and Meson will have
improved much for the whole ecosystem.

Paolo

Marc-André Lureau (2):
  cirrus/macos: enable Rust
  gitlab-ci: enable rust for msys2-64bit

Martin Kletzander (1):
  rust: Do not link qemuutil into Rust rlibs

Paolo Bonzini (8):
  build: do not include @block.syms/@qemu.sys with modules disabled
  tests/meson: do not reuse migration_files variable
  bump meson wheel to 1.10.0
  rust: only link the Rust part of the code into devices
  rust: Meson now adds -Cdefault-linker-libraries
  meson: let Meson handle mixed-language linking of Rust and C objects
  rust: skip compilation if there are no system emulators
  lcitool: enable Rust for Windows cross targets

 configure                                     |   4 +-
 meson.build                                   |  36 +++++++-----------
 .gitlab-ci.d/cirrus.yml                       |   2 +-
 .gitlab-ci.d/windows.yml                      |   7 +++-
 python/scripts/vendor.py                      |   4 +-
 python/wheels/meson-1.10.0-py3-none-any.whl   | Bin 0 -> 1057029 bytes
 pythondeps.toml                               |   4 +-
 rust/chardev/meson.build                      |   2 +-
 rust/hw/char/pl011/meson.build                |  18 +++++----
 rust/hw/timer/hpet/meson.build                |  18 ++++-----
 rust/meson.build                              |   7 ++++
 rust/qom/meson.build                          |   2 +-
 rust/util/meson.build                         |   4 +-
 scripts/rust/rust_root_crate.sh               |   1 +
 .../dockerfiles/fedora-win64-cross.docker     |   2 +
 tests/lcitool/refresh                         |   5 +--
 tests/qtest/meson.build                       |   6 +--
 17 files changed, 64 insertions(+), 58 deletions(-)
 create mode 100644 python/wheels/meson-1.10.0-py3-none-any.whl

-- 
2.52.0


