Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AACE3CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 12:49:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRrCP-0001Gd-46; Tue, 26 May 2026 08:47:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRrCN-0001GL-Kt
 for qemu-devel@nongnu.org; Tue, 26 May 2026 08:47:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRrCK-0000zT-9B
 for qemu-devel@nongnu.org; Tue, 26 May 2026 08:47:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779799670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZRkbVNu2jPS8SBzPLkXhWf4fyarTBuO/jqcHYTOyI6U=;
 b=fkC/GcrxyN9nonozw6H2oB209sM4vEybt0IxZym4Yv9bXPcq4LOXugDF8H5YnmYyWowPrr
 bjpHVMiewh1A2BX8cyNpP2k09SOMI6phi1fSqxS3dDg2EUzylxR6ClTJaYD8RQyjMmbBsi
 LdsAd0nYLGQl4AuZjPgKT4tH/WcJRP0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-ls2C7N6ZOhCU8txA3jxIfA-1; Tue, 26 May 2026 08:47:47 -0400
X-MC-Unique: ls2C7N6ZOhCU8txA3jxIfA-1
X-Mimecast-MFC-AGG-ID: ls2C7N6ZOhCU8txA3jxIfA_1779799667
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-44ffa15dc8cso6507577f8f.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 05:47:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779799667; cv=none;
 d=google.com; s=arc-20240605;
 b=g3ifU1YOf2/eF9Na+IKEdFt8GaFpPhP1epBnRDg0wo1a4RgW9ZcfsMULdgpLPze5jS
 ehg4U9hang0Abp1ThoMhr7wyET8naF3J7Z6QfmGGV8kmqTiIwzhLobVNZoqjZ/4dP3TD
 aj/3wD6O/LwPlR6nm6rxBfyoVOLO55SHgMj6nPBlKvcO1FsvdP3LGXVMu7Kxzuv6jpXX
 5RB/V9ElC5uHbua4BDKCcYv2IxiipGBHgeeyRxy6VGhzXLAaNKWCMnQeVaSOHSkfTtd8
 mMnQgCiDMyopKsmug4CLrWyY4N4pM/B/sJuvPzmK0/i1VOtTzXClYcAVEFDo+HORduA5
 r3Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZRkbVNu2jPS8SBzPLkXhWf4fyarTBuO/jqcHYTOyI6U=;
 fh=iOEZvmt+DhTM8+Ha3ezCGH1p8eXqJFPRxAkh7KfFcvA=;
 b=gLyy2gb4KAGK20m0vPD5ZnE3kzKDoc6ns+LuwGNUL4KkRzwIYgJWYoyDS2pZt76P9A
 NfQDCJNhuz0OsJtyp6xfSeCJIX2Cqz8jy0yDUR0ZNnGCR6tkyi7H2sgHf0GhwFEJZJ2O
 xGHkhKyqbA8bLwPAA4hC2wjMx7Z4YrDJn+M4xEOuxyWldVcOpu7vukKzYwntepUrlABa
 YcYMRDpSVp4fjmBVDZax0cWwbSpl6Zd3T4TAsTwXzS+ItC/kcvzwcxx2vdygU9NOsKKM
 BO3OHURg4WokyICR9t5J8cDdQivHVVAxVbQeSgG8W93iPMqXrGJ0t7Bao9YOPeDrYKKF
 wUJg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779799667; x=1780404467; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZRkbVNu2jPS8SBzPLkXhWf4fyarTBuO/jqcHYTOyI6U=;
 b=eS6k7zmnwxXXo7PioPtVYTcu2T5fTMX2CKDLb1JAI1glH2MvoqvjBdJEohlGT1+Rex
 xUG9HDPVSUplLj8EIO6fzHcHDfXYPjqrs+CUeX9wb/iVJkFl0dLhP7yFESbGR9+Q6Hi0
 FCkwVlzesa+SxyZRVC9PyHfZ37R4XiUbWc3vj6KMvLW+VjzLnySRY/ycmCvAR7KBZF8b
 5fOx9KQCPlbN6zIshM1kAAlbDAe4XIYtymWaOoIBvHfslooiNJXyfSGQ6Hm3DPzpbFFA
 BSYPmjGNnX5WyCfXfcl3ml5JEFO9qOHOdVdJ3/JxIxCwvHgmpe6yOBcI/wLSFMG9lxOE
 XPuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779799667; x=1780404467;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZRkbVNu2jPS8SBzPLkXhWf4fyarTBuO/jqcHYTOyI6U=;
 b=fTX6Dt2SVzrh5CU75usJlNnuUxwP7K+HETTSOvMBIdT5MC+JF7Ly/GvsiXtbHrgext
 8zra4Z51/5fjV050ELECxS/xY8hwHLhckZ/P+fOKX6StRx2PE3wOTwcJPm6pCslvhQ73
 pDXqiZw/2AtJorFsY05h5OzebirYqvD3ZUPbVXWNxWROkTdiXG2s68iQefNNilmPimeq
 jgus0frxmv/AJg+FhgV+B8cruytDTZK+PQVAGZLXRuUaQAwoAiJcdHz0C9waFSsMfVBY
 gRtO3NQ22mOEuztWpfUf+iliPQM12u820bfeu3UU7spAXFRzeLNQrnBnHrVRwG6eYX38
 KrMw==
X-Gm-Message-State: AOJu0Yx/06dTljCOTGDD4PTz7hUjRR5vU1eJh+LtO5sIOFbXyWU9E70a
 DAf/eby86QCmYwNo/B5JJSZqrfmS9rm09ohJ0eQRnDqylkOP3OqJjVxLct8Nlw3SY7lfpd5qKMf
 TER1kkMH4DBx7EcSWVizw839G3f0q8SNV1toqQZTYto9Nw2yHKqLUXQ4zos3yawSrvejcZlf74Y
 g0GTz2g0b3MUkTL3dEpxLsE89EPuCXZ1epU4ts9Qk=
X-Gm-Gg: Acq92OHnKKR8q+zWWQ3cjdBN3R/kjE4pgX+zbn5HP4WqbacFvvD9SBrPPNGJj3e0MFW
 xDkVWi7pjNSbC/KsOC7cpYjPOi/p2EZFPcQiguD1isaf0wZa9GI6548G0updFlcrg0JcOS1JMsn
 1LwfCViWVwhUDweOZAc0IXep1b5pGdAeeToO9roe0SoAaI5mVJmWLzLFAyLpJN9wXeYh/M4RuKg
 N4/XfiO8q7A8GeOVfbH038lZ+PBCmA4PRAVSzKBSBZg9WifutUilhLO3Q0xIEKU5mV5y73d9anL
 oL4TviK2AzsZOPZh+Q==
X-Received: by 2002:a05:6000:2883:b0:44f:f4de:a844 with SMTP id
 ffacd0b85a97d-45eb38c8ceemr30476270f8f.37.1779799666623; 
 Tue, 26 May 2026 05:47:46 -0700 (PDT)
X-Received: by 2002:a05:6000:2883:b0:44f:f4de:a844 with SMTP id
 ffacd0b85a97d-45eb38c8ceemr30476216f8f.37.1779799666195; Tue, 26 May 2026
 05:47:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260526092546.149241-1-pbonzini@redhat.com>
 <CAAjaMXaRijkxAWDFsQy_6wA0peWeCtfrRrFYYgO=3PM6d-s5GQ@mail.gmail.com>
 <CAAjaMXY7QnrygSJtTGU4DEOhC-ezSeBdTz4ZYOQz54TsKQtRwQ@mail.gmail.com>
In-Reply-To: <CAAjaMXY7QnrygSJtTGU4DEOhC-ezSeBdTz4ZYOQz54TsKQtRwQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 26 May 2026 14:47:35 +0200
X-Gm-Features: AVHnY4IpIfXJ32jRaUpUvrhoQenSGlqQR2J5vmhV4WFHX6VBQGP_YIEy5QIyD9I
Message-ID: <CABgObfZm=qjtm37YGY=e52aA0qDzLw-=HWJ47WsunRb1HQ-pSg@mail.gmail.com>
Subject: Re: [PATCH preview 0/6] rust: use meson automatic parsing of
 Cargo.toml
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000e019cc0652b7e696"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

--000000000000e019cc0652b7e696
Content-Type: text/plain; charset="UTF-8"

Il mar 26 mag 2026, 14:42 Manos Pitsidianakis <
manos.pitsidianakis@linaro.org> ha scritto:

> pythondeps.toml points to 1.11.1 already, but if these new changes
> require 1.11 then I expect building to stop working with meson 1.10
> and rust enabled
>

They will require 1.12 for cross compilation but otherwise they should work
with 1.11, or at worst master. I posted now only as a preview, just because
(after almost two years...) they show an almost final shape of the build
system.

They are in the rust-cargo branch of my git repo by the way!

Paolo

>
> > >
> > >  configure                                     |  3 -
> > >  meson.build                                   | 13 +--
> > >  rust/Cargo.lock => Cargo.lock                 |  0
> > >  rust/Cargo.toml => Cargo.toml                 |  6 +-
> > >  rust/bindings/chardev-sys/meson.build         | 11 +--
> > >  rust/bindings/hwcore-sys/meson.build          | 11 +--
> > >  rust/bindings/migration-sys/meson.build       | 11 +--
> > >  rust/bindings/qom-sys/meson.build             | 11 +--
> > >  rust/bindings/system-sys/meson.build          | 11 +--
> > >  rust/bindings/util-sys/meson.build            | 11 +--
> > >  rust/bits/meson.build                         |  7 +-
> > >  rust/bql/meson.build                          | 13 +--
> > >  rust/chardev/meson.build                      |  8 +-
> > >  rust/common/meson.build                       | 10 +--
> > >  rust/hw/char/pl011/meson.build                | 22 +----
> > >  rust/hw/core/meson.build                      | 10 +--
> > >  rust/hw/timer/hpet/meson.build                | 17 +---
> > >  rust/meson.build                              | 32 +-------
> > >  rust/migration/meson.build                    |  8 +-
> > >  rust/qemu-macros/meson.build                  | 12 +--
> > >  rust/qom/meson.build                          |  8 +-
> > >  rust/system/meson.build                       |  8 +-
> > >  rust/trace/meson.build                        |  9 +--
> > >  rust/util/meson.build                         |  7 +-
> > >  scripts/qapi/rs_types.py                      |  2 +-
> > >  scripts/rust/rustc_args.py                    | 80 +------------------
> > >  subprojects/anyhow-1-rs.wrap                  |  7 --
> > >  subprojects/arbitrary-int-1-rs.wrap           | 10 ---
> > >  subprojects/attrs-0.2-rs.wrap                 |  7 --
> > >  subprojects/bilge-0.2-rs.wrap                 | 10 ---
> > >  subprojects/bilge-impl-0.2-rs.wrap            | 10 ---
> > >  subprojects/either-1-rs.wrap                  | 10 ---
> > >  subprojects/foreign-0.3-rs.wrap               |  7 --
> > >  subprojects/glib-sys-0.21-rs.wrap             |  7 --
> > >  subprojects/itertools-0.11-rs.wrap            | 10 ---
> > >  subprojects/libc-0.2-rs.wrap                  |  7 --
> > >  .../packagefiles/anyhow-1-rs/meson.build      | 33 --------
> > >  .../anyhow-1-rs/meson/meson.build             |  9 +++
> > >  .../arbitrary-int-1-rs/meson.build            | 21 -----
> > >  .../packagefiles/attrs-0.2-rs/meson.build     | 33 --------
> > >  .../packagefiles/bilge-0.2-rs/meson.build     | 31 -------
> > >  .../bilge-impl-0.2-rs/meson.build             | 44 ----------
> > >  .../bilge-impl-0.2-rs/meson/meson.build       |  3 +
> > >  .../packagefiles/either-1-rs/meson.build      | 26 ------
> > >  .../packagefiles/foreign-0.3-rs/meson.build   | 26 ------
> > >  .../packagefiles/glib-sys-0.21-rs/meson.build | 33 --------
> > >  .../itertools-0.11-rs/meson.build             | 32 --------
> > >  .../packagefiles/libc-0.2-rs/meson.build      | 37 ---------
> > >  .../libc-0.2-rs/meson/meson.build             | 16 ++++
> > >  .../proc-macro-error-1-rs/meson.build         | 41 ----------
> > >  .../proc-macro-error-1-rs/meson/meson.build   |  3 +
> > >  .../proc-macro-error-attr-1-rs/meson.build    | 31 -------
> > >  .../meson/meson.build                         |  3 +
> > >  .../packagefiles/proc-macro2-1-rs/meson.build | 35 --------
> > >  .../proc-macro2-1-rs/meson/meson.build        |  6 ++
> > >  .../packagefiles/quote-1-rs/meson.build       | 31 -------
> > >  .../packagefiles/serde-1-rs/meson.build       | 36 ---------
> > >  .../packagefiles/serde_core-1-rs/meson.build  | 25 ------
> > >  .../serde_core-1-rs/private.rs.in             |  6 ++
> > >  .../serde_derive-1-rs/meson.build             | 35 --------
> > >  subprojects/packagefiles/syn-2-rs/meson.build | 43 ----------
> > >  .../unicode-ident-1-rs/meson.build            | 22 -----
> > >  subprojects/probe-0.5-rs.wrap                 |  7 --
> > >  subprojects/proc-macro-error-1-rs.wrap        | 10 ---
> > >  subprojects/proc-macro-error-attr-1-rs.wrap   | 10 ---
> > >  subprojects/proc-macro2-1-rs.wrap             | 10 ---
> > >  subprojects/quote-1-rs.wrap                   | 10 ---
> > >  subprojects/serde-1-rs.wrap                   |  5 +-
> > >  subprojects/serde_core-1-rs.wrap              |  5 +-
> > >  subprojects/serde_derive-1-rs.wrap            |  5 +-
> > >  subprojects/syn-2-rs.wrap                     | 10 ---
> > >  subprojects/unicode-ident-1-rs.wrap           | 10 ---
> > >  72 files changed, 116 insertions(+), 1053 deletions(-)
> > >  rename rust/Cargo.lock => Cargo.lock (100%)
> > >  rename rust/Cargo.toml => Cargo.toml (97%)
> > >  delete mode 100644 subprojects/anyhow-1-rs.wrap
> > >  delete mode 100644 subprojects/arbitrary-int-1-rs.wrap
> > >  delete mode 100644 subprojects/attrs-0.2-rs.wrap
> > >  delete mode 100644 subprojects/bilge-0.2-rs.wrap
> > >  delete mode 100644 subprojects/bilge-impl-0.2-rs.wrap
> > >  delete mode 100644 subprojects/either-1-rs.wrap
> > >  delete mode 100644 subprojects/foreign-0.3-rs.wrap
> > >  delete mode 100644 subprojects/glib-sys-0.21-rs.wrap
> > >  delete mode 100644 subprojects/itertools-0.11-rs.wrap
> > >  delete mode 100644 subprojects/libc-0.2-rs.wrap
> > >  delete mode 100644 subprojects/packagefiles/anyhow-1-rs/meson.build
> > >  create mode 100644
> subprojects/packagefiles/anyhow-1-rs/meson/meson.build
> > >  delete mode 100644
> subprojects/packagefiles/arbitrary-int-1-rs/meson.build
> > >  delete mode 100644 subprojects/packagefiles/attrs-0.2-rs/meson.build
> > >  delete mode 100644 subprojects/packagefiles/bilge-0.2-rs/meson.build
> > >  delete mode 100644
> subprojects/packagefiles/bilge-impl-0.2-rs/meson.build
> > >  create mode 100644
> subprojects/packagefiles/bilge-impl-0.2-rs/meson/meson.build
> > >  delete mode 100644 subprojects/packagefiles/either-1-rs/meson.build
> > >  delete mode 100644 subprojects/packagefiles/foreign-0.3-rs/meson.build
> > >  delete mode 100644
> subprojects/packagefiles/glib-sys-0.21-rs/meson.build
> > >  delete mode 100644
> subprojects/packagefiles/itertools-0.11-rs/meson.build
> > >  delete mode 100644 subprojects/packagefiles/libc-0.2-rs/meson.build
> > >  create mode 100644
> subprojects/packagefiles/libc-0.2-rs/meson/meson.build
> > >  delete mode 100644
> subprojects/packagefiles/proc-macro-error-1-rs/meson.build
> > >  create mode 100644
> subprojects/packagefiles/proc-macro-error-1-rs/meson/meson.build
> > >  delete mode 100644
> subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build
> > >  create mode 100644
> subprojects/packagefiles/proc-macro-error-attr-1-rs/meson/meson.build
> > >  delete mode 100644
> subprojects/packagefiles/proc-macro2-1-rs/meson.build
> > >  create mode 100644
> subprojects/packagefiles/proc-macro2-1-rs/meson/meson.build
> > >  delete mode 100644 subprojects/packagefiles/quote-1-rs/meson.build
> > >  delete mode 100644 subprojects/packagefiles/serde-1-rs/meson.build
> > >  delete mode 100644
> subprojects/packagefiles/serde_core-1-rs/meson.build
> > >  create mode 100644 subprojects/packagefiles/serde_core-1-rs/
> private.rs.in
> > >  delete mode 100644
> subprojects/packagefiles/serde_derive-1-rs/meson.build
> > >  delete mode 100644 subprojects/packagefiles/syn-2-rs/meson.build
> > >  delete mode 100644
> subprojects/packagefiles/unicode-ident-1-rs/meson.build
> > >  delete mode 100644 subprojects/probe-0.5-rs.wrap
> > >  delete mode 100644 subprojects/proc-macro-error-1-rs.wrap
> > >  delete mode 100644 subprojects/proc-macro-error-attr-1-rs.wrap
> > >  delete mode 100644 subprojects/proc-macro2-1-rs.wrap
> > >  delete mode 100644 subprojects/quote-1-rs.wrap
> > >  delete mode 100644 subprojects/syn-2-rs.wrap
> > >  delete mode 100644 subprojects/unicode-ident-1-rs.wrap
> > >
> > > --
> > > 2.54.0
> > >
> > >
>
>

--000000000000e019cc0652b7e696
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mar 26 mag 2026, 14:42 Manos =
Pitsidianakis &lt;<a href=3D"mailto:manos.pitsidianakis@linaro.org">manos.p=
itsidianakis@linaro.org</a>&gt; ha scritto:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">pythondeps.toml points to 1.11.1 already, but i=
f these new changes<br>
require 1.11 then I expect building to stop working with meson 1.10<br>
and rust enabled<br></blockquote></div></div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto">They will require 1.12 for cross compilation but otherwise =
they should work with 1.11, or at worst master. I posted now only as a prev=
iew, just because (after almost two years...) they show an almost final sha=
pe of the build system.</div><div dir=3D"auto"><br></div><div dir=3D"auto">=
They are in the rust-cargo branch of my git repo by the way!</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></di=
v><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
&gt;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 configure=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 3 -<br>
&gt; &gt;=C2=A0 meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 13 +--<br>
&gt; &gt;=C2=A0 rust/Cargo.lock =3D&gt; Cargo.lock=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 0<br>
&gt; &gt;=C2=A0 rust/Cargo.toml =3D&gt; Cargo.toml=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 6 +-<br>
&gt; &gt;=C2=A0 rust/bindings/chardev-sys/meson.build=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| 11 +--<br>
&gt; &gt;=C2=A0 rust/bindings/hwcore-sys/meson.build=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | 11 +--<br>
&gt; &gt;=C2=A0 rust/bindings/migration-sys/meson.build=C2=A0 =C2=A0 =C2=A0=
 =C2=A0| 11 +--<br>
&gt; &gt;=C2=A0 rust/bindings/qom-sys/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| 11 +--<br>
&gt; &gt;=C2=A0 rust/bindings/system-sys/meson.build=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | 11 +--<br>
&gt; &gt;=C2=A0 rust/bindings/util-sys/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 11 +--<br>
&gt; &gt;=C2=A0 rust/bits/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 7 +-<br>
&gt; &gt;=C2=A0 rust/bql/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 13 +--<br>
&gt; &gt;=C2=A0 rust/chardev/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 8 +-<br>
&gt; &gt;=C2=A0 rust/common/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 10 +--<br>
&gt; &gt;=C2=A0 rust/hw/char/pl011/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 22 +----<br>
&gt; &gt;=C2=A0 rust/hw/core/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 10 +--<br>
&gt; &gt;=C2=A0 rust/hw/timer/hpet/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 17 +---<br>
&gt; &gt;=C2=A0 rust/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 32 +------=
-<br>
&gt; &gt;=C2=A0 rust/migration/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 8 +-<br>
&gt; &gt;=C2=A0 rust/qemu-macros/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 12 +--<br>
&gt; &gt;=C2=A0 rust/qom/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 8 +-<br>
&gt; &gt;=C2=A0 rust/system/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 8 +-<br>
&gt; &gt;=C2=A0 rust/trace/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 9 +--<br>
&gt; &gt;=C2=A0 rust/util/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 7 +-<br>
&gt; &gt;=C2=A0 scripts/qapi/rs_types.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
&gt; &gt;=C2=A0 scripts/rust/rustc_args.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 80 +------------------<br>
&gt; &gt;=C2=A0 subprojects/anyhow-1-rs.wrap=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 7 --<br>
&gt; &gt;=C2=A0 subprojects/arbitrary-int-1-rs.wrap=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| 10 ---<br>
&gt; &gt;=C2=A0 subprojects/attrs-0.2-rs.wrap=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 7 --<br>
&gt; &gt;=C2=A0 subprojects/bilge-0.2-rs.wrap=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 10 ---<br>
&gt; &gt;=C2=A0 subprojects/bilge-impl-0.2-rs.wrap=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 10 ---<br>
&gt; &gt;=C2=A0 subprojects/either-1-rs.wrap=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 10 ---<br>
&gt; &gt;=C2=A0 subprojects/foreign-0.3-rs.wrap=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 7 --<br>
&gt; &gt;=C2=A0 subprojects/glib-sys-0.21-rs.wrap=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 7 --<br>
&gt; &gt;=C2=A0 subprojects/itertools-0.11-rs.wrap=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 10 ---<br>
&gt; &gt;=C2=A0 subprojects/libc-0.2-rs.wrap=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 7 --<br>
&gt; &gt;=C2=A0 .../packagefiles/anyhow-1-rs/meson.build=C2=A0 =C2=A0 =C2=
=A0 | 33 --------<br>
&gt; &gt;=C2=A0 .../anyhow-1-rs/meson/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 9 +++<br>
&gt; &gt;=C2=A0 .../arbitrary-int-1-rs/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 21 -----<br>
&gt; &gt;=C2=A0 .../packagefiles/attrs-0.2-rs/meson.build=C2=A0 =C2=A0 =C2=
=A0| 33 --------<br>
&gt; &gt;=C2=A0 .../packagefiles/bilge-0.2-rs/meson.build=C2=A0 =C2=A0 =C2=
=A0| 31 -------<br>
&gt; &gt;=C2=A0 .../bilge-impl-0.2-rs/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| 44 ----------<br>
&gt; &gt;=C2=A0 .../bilge-impl-0.2-rs/meson/meson.build=C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 3 +<br>
&gt; &gt;=C2=A0 .../packagefiles/either-1-rs/meson.build=C2=A0 =C2=A0 =C2=
=A0 | 26 ------<br>
&gt; &gt;=C2=A0 .../packagefiles/foreign-0.3-rs/meson.build=C2=A0 =C2=A0| 2=
6 ------<br>
&gt; &gt;=C2=A0 .../packagefiles/glib-sys-0.21-rs/meson.build | 33 --------=
<br>
&gt; &gt;=C2=A0 .../itertools-0.11-rs/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| 32 --------<br>
&gt; &gt;=C2=A0 .../packagefiles/libc-0.2-rs/meson.build=C2=A0 =C2=A0 =C2=
=A0 | 37 ---------<br>
&gt; &gt;=C2=A0 .../libc-0.2-rs/meson/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| 16 ++++<br>
&gt; &gt;=C2=A0 .../proc-macro-error-1-rs/meson.build=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| 41 ----------<br>
&gt; &gt;=C2=A0 .../proc-macro-error-1-rs/meson/meson.build=C2=A0 =C2=A0|=
=C2=A0 3 +<br>
&gt; &gt;=C2=A0 .../proc-macro-error-attr-1-rs/meson.build=C2=A0 =C2=A0 | 3=
1 -------<br>
&gt; &gt;=C2=A0 .../meson/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 3 +<br>
&gt; &gt;=C2=A0 .../packagefiles/proc-macro2-1-rs/meson.build | 35 --------=
<br>
&gt; &gt;=C2=A0 .../proc-macro2-1-rs/meson/meson.build=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 6 ++<br>
&gt; &gt;=C2=A0 .../packagefiles/quote-1-rs/meson.build=C2=A0 =C2=A0 =C2=A0=
 =C2=A0| 31 -------<br>
&gt; &gt;=C2=A0 .../packagefiles/serde-1-rs/meson.build=C2=A0 =C2=A0 =C2=A0=
 =C2=A0| 36 ---------<br>
&gt; &gt;=C2=A0 .../packagefiles/serde_core-1-rs/meson.build=C2=A0 | 25 ---=
---<br>
&gt; &gt;=C2=A0 .../serde_core-1-rs/<a href=3D"http://private.rs.in" rel=3D=
"noreferrer noreferrer" target=3D"_blank">private.rs.in</a>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 6 ++<br>
&gt; &gt;=C2=A0 .../serde_derive-1-rs/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| 35 --------<br>
&gt; &gt;=C2=A0 subprojects/packagefiles/syn-2-rs/meson.build | 43 --------=
--<br>
&gt; &gt;=C2=A0 .../unicode-ident-1-rs/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 22 -----<br>
&gt; &gt;=C2=A0 subprojects/probe-0.5-rs.wrap=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 7 --<br>
&gt; &gt;=C2=A0 subprojects/proc-macro-error-1-rs.wrap=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 10 ---<br>
&gt; &gt;=C2=A0 subprojects/proc-macro-error-attr-1-rs.wrap=C2=A0 =C2=A0| 1=
0 ---<br>
&gt; &gt;=C2=A0 subprojects/proc-macro2-1-rs.wrap=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| 10 ---<br>
&gt; &gt;=C2=A0 subprojects/quote-1-rs.wrap=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 10 ---<br>
&gt; &gt;=C2=A0 subprojects/serde-1-rs.wrap=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 5 +-<br>
&gt; &gt;=C2=A0 subprojects/serde_core-1-rs.wrap=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 5 +-<br>
&gt; &gt;=C2=A0 subprojects/serde_derive-1-rs.wrap=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 5 +-<br>
&gt; &gt;=C2=A0 subprojects/syn-2-rs.wrap=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 10 ---<br>
&gt; &gt;=C2=A0 subprojects/unicode-ident-1-rs.wrap=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| 10 ---<br>
&gt; &gt;=C2=A0 72 files changed, 116 insertions(+), 1053 deletions(-)<br>
&gt; &gt;=C2=A0 rename rust/Cargo.lock =3D&gt; Cargo.lock (100%)<br>
&gt; &gt;=C2=A0 rename rust/Cargo.toml =3D&gt; Cargo.toml (97%)<br>
&gt; &gt;=C2=A0 delete mode 100644 subprojects/anyhow-1-rs.wrap<br>
&gt; &gt;=C2=A0 delete mode 100644 subprojects/arbitrary-int-1-rs.wrap<br>
&gt; &gt;=C2=A0 delete mode 100644 subprojects/attrs-0.2-rs.wrap<br>
&gt; &gt;=C2=A0 delete mode 100644 subprojects/bilge-0.2-rs.wrap<br>
&gt; &gt;=C2=A0 delete mode 100644 subprojects/bilge-impl-0.2-rs.wrap<br>
&gt; &gt;=C2=A0 delete mode 100644 subprojects/either-1-rs.wrap<br>
&gt; &gt;=C2=A0 delete mode 100644 subprojects/foreign-0.3-rs.wrap<br>
&gt; &gt;=C2=A0 delete mode 100644 subprojects/glib-sys-0.21-rs.wrap<br>
&gt; &gt;=C2=A0 delete mode 100644 subprojects/itertools-0.11-rs.wrap<br>
&gt; &gt;=C2=A0 delete mode 100644 subprojects/libc-0.2-rs.wrap<br>
&gt; &gt;=C2=A0 delete mode 100644 subprojects/packagefiles/anyhow-1-rs/mes=
on.build<br>
&gt; &gt;=C2=A0 create mode 100644 subprojects/packagefiles/anyhow-1-rs/mes=
on/meson.build<br>
&gt; &gt;=C2=A0 delete mode 100644 subprojects/packagefiles/arbitrary-int-1=
-rs/meson.build<br>
&gt; &gt;=C2=A0 delete mode 100644 subprojects/packagefiles/attrs-0.2-rs/me=
son.build<br>
&gt; &gt;=C2=A0 delete mode 100644 subprojects/packagefiles/bilge-0.2-rs/me=
son.build<br>
&gt; &gt;=C2=A0 delete mode 100644 subprojects/packagefiles/bilge-impl-0.2-=
rs/meson.build<br>
&gt; &gt;=C2=A0 create mode 100644 subprojects/packagefiles/bilge-impl-0.2-=
rs/meson/meson.build<br>
&gt; &gt;=C2=A0 delete mode 100644 subprojects/packagefiles/either-1-rs/mes=
on.build<br>
&gt; &gt;=C2=A0 delete mode 100644 subprojects/packagefiles/foreign-0.3-rs/=
meson.build<br>
&gt; &gt;=C2=A0 delete mode 100644 subprojects/packagefiles/glib-sys-0.21-r=
s/meson.build<br>
&gt; &gt;=C2=A0 delete mode 100644 subprojects/packagefiles/itertools-0.11-=
rs/meson.build<br>
&gt; &gt;=C2=A0 delete mode 100644 subprojects/packagefiles/libc-0.2-rs/mes=
on.build<br>
&gt; &gt;=C2=A0 create mode 100644 subprojects/packagefiles/libc-0.2-rs/mes=
on/meson.build<br>
&gt; &gt;=C2=A0 delete mode 100644 subprojects/packagefiles/proc-macro-erro=
r-1-rs/meson.build<br>
&gt; &gt;=C2=A0 create mode 100644 subprojects/packagefiles/proc-macro-erro=
r-1-rs/meson/meson.build<br>
&gt; &gt;=C2=A0 delete mode 100644 subprojects/packagefiles/proc-macro-erro=
r-attr-1-rs/meson.build<br>
&gt; &gt;=C2=A0 create mode 100644 subprojects/packagefiles/proc-macro-erro=
r-attr-1-rs/meson/meson.build<br>
&gt; &gt;=C2=A0 delete mode 100644 subprojects/packagefiles/proc-macro2-1-r=
s/meson.build<br>
&gt; &gt;=C2=A0 create mode 100644 subprojects/packagefiles/proc-macro2-1-r=
s/meson/meson.build<br>
&gt; &gt;=C2=A0 delete mode 100644 subprojects/packagefiles/quote-1-rs/meso=
n.build<br>
&gt; &gt;=C2=A0 delete mode 100644 subprojects/packagefiles/serde-1-rs/meso=
n.build<br>
&gt; &gt;=C2=A0 delete mode 100644 subprojects/packagefiles/serde_core-1-rs=
/meson.build<br>
&gt; &gt;=C2=A0 create mode 100644 subprojects/packagefiles/serde_core-1-rs=
/<a href=3D"http://private.rs.in" rel=3D"noreferrer noreferrer" target=3D"_=
blank">private.rs.in</a><br>
&gt; &gt;=C2=A0 delete mode 100644 subprojects/packagefiles/serde_derive-1-=
rs/meson.build<br>
&gt; &gt;=C2=A0 delete mode 100644 subprojects/packagefiles/syn-2-rs/meson.=
build<br>
&gt; &gt;=C2=A0 delete mode 100644 subprojects/packagefiles/unicode-ident-1=
-rs/meson.build<br>
&gt; &gt;=C2=A0 delete mode 100644 subprojects/probe-0.5-rs.wrap<br>
&gt; &gt;=C2=A0 delete mode 100644 subprojects/proc-macro-error-1-rs.wrap<b=
r>
&gt; &gt;=C2=A0 delete mode 100644 subprojects/proc-macro-error-attr-1-rs.w=
rap<br>
&gt; &gt;=C2=A0 delete mode 100644 subprojects/proc-macro2-1-rs.wrap<br>
&gt; &gt;=C2=A0 delete mode 100644 subprojects/quote-1-rs.wrap<br>
&gt; &gt;=C2=A0 delete mode 100644 subprojects/syn-2-rs.wrap<br>
&gt; &gt;=C2=A0 delete mode 100644 subprojects/unicode-ident-1-rs.wrap<br>
&gt; &gt;<br>
&gt; &gt; --<br>
&gt; &gt; 2.54.0<br>
&gt; &gt;<br>
&gt; &gt;<br>
<br>
</blockquote></div></div></div>

--000000000000e019cc0652b7e696--


