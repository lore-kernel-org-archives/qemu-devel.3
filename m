Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFFD0C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 14:17:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvy8S-00064V-CO; Mon, 17 Aug 2026 10:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wvy8E-000617-Ke
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 10:16:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wvy8C-00015y-F2
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 10:16:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786976163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=0sGxW77N1apK5FTIjQOUHP3l5zsQw09WjtabparSqCU=;
 b=WRhkhfgKC2fs7ADOeWyj4EeDmoWO33YRUzucBeFtmQV84h1/xNDv1lNVzbSG9RBEC5A9jI
 GrAyUEi0e9Tk6lec3uB7GMJdB5my0ZHz05w+QCzXl6uBkIUOWsjBOO2asPMCfcut5hbUbp
 NAkhRClmOaiQxE/a8vt65nPf1bRM13A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-zF3zfhc5PKiyT8g0tpl5lg-1; Mon, 17 Aug 2026 10:16:01 -0400
X-MC-Unique: zF3zfhc5PKiyT8g0tpl5lg-1
X-Mimecast-MFC-AGG-ID: zF3zfhc5PKiyT8g0tpl5lg_1786976161
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-495689bfcc8so23073955e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 07:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786976161; x=1787580961; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0sGxW77N1apK5FTIjQOUHP3l5zsQw09WjtabparSqCU=;
 b=qKQAn+N1tGdzlxI81kMhRk7NSNbPJhl3n7y5HV3/xN4gap4Th1YqJaMy1uPVdeCqUK
 uszXmDcx5bQz1LrVdrMRRRtC1BzQw0H1Q6Af+0Zi/Zoqp+eoQp2Aacip/7squ4hs0aTv
 62KGYeyBArlrd46XO+Vcz34nLzX9GC/+Q5v/RaVhkalrc6fXtS87m0/Vp+RBjuq2ZwN9
 tpXJBLkdxGKYCgm54gVOVv5pCVCizDObjr07XPLOJjnUUvDQIrzl1S9qe+1JeYPh8Brw
 s80KzOhp+XAUMHroTdmZQGvnilo9jhNCD2PSCfczaBX1MgM83rDADivdyGrELUkQX+lh
 TRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786976161; x=1787580961;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0sGxW77N1apK5FTIjQOUHP3l5zsQw09WjtabparSqCU=;
 b=SaMUxhLJMJxywFtOINgyHDEcK39+9dxrqxS6qeI+xmGA6jnschcEEwSsP8d9rrUOF4
 emO+T21TXiwBGP3otrotjw8mojuCK6sPpqUyVf5oGo7+Wn9Z6RiJWO/YYE7wFGSUiEVM
 NJujrZlKracOSuiYRyneYpoUrHEbymwJ0wlU29tAM11YCwQUDvlA0hYSSxFKwa8rEWAs
 LOmYY5QE6RrlcxlJ/aSIWWlFCqREQq08DxdaX6x3p0MsEZO4hMVLa9W1H2+RMala/ng+
 AtRN23YVtdbYoYDsaaHBlUeF+WLuz+03gS2jCE0aGec/ejiqpNcY7rY0D6IXLcvZOZax
 lcyg==
X-Gm-Message-State: AOJu0YyHJJtAzE2zq9JZOVl+ZNIP+yEntX+/ZrQs1BOH5kt9OtKW+wyh
 prGs516GXuCmiAudkjykViKzXHQCaRzpZuqXV3qSps7iUH0reUSlXM3frePwz/zG5ImCMhCVQ+F
 dmoxev3W8Z+yWftVQDKTKbOHjsjRhJpEv+M101IQ56izCs0mhsbmJFqlh15U8BuhuFxiirpxW9d
 M3qKMYhAVSQppSXbb57MjWMJh5chp4CsTsLQP5vPvf
X-Gm-Gg: AR+sD13/rKNHe20iny7IKIJHjjqgNu8DO0XOnlLncq7EcEbAWfQgFMqHwIGganQZr11
 xJVFlIEMhNfArh3Vy1DBqbHeaTF9Yl5yWEd/K3P3LF0HtFE60P1n+elX2zuoaTYxVClc+Q1De/1
 /yRWSEskI5BbDqT6YnFObo2Wb1Kc/i0i4w8FiOGZsMGHY3pL6gAJe5TIV9Tl3cJhA8R0COOv3Ro
 Af8D7Bl1rd8wVDnvvXRkiIBMMlzkDwPmQK/jz+3A1gJljLkPRT8J9oJ/X/7gEZVPlrVQmXSCIv2
 crq+FmMIwkAW2Y6F3pcKm9wA0iP1VbJyFHpp7KiuvJ978Gu094MEV0lv9HBvwWEAxwHfCbyPm+4
 iMw+0YcAl1obqpZa7Pg4iDI4Eq33jd+30wWSg11wb4j64iWXeIHA/GNbKC/GE4BGG/igG1S9QZC
 z/Iks=
X-Received: by 2002:a05:600c:1f91:b0:496:bffb:fb7b with SMTP id
 5b1f17b1804b1-4999fb3c2e1mr6781075e9.10.1786976160644; 
 Mon, 17 Aug 2026 07:16:00 -0700 (PDT)
X-Received: by 2002:a05:600c:1f91:b0:496:bffb:fb7b with SMTP id
 5b1f17b1804b1-4999fb3c2e1mr6780285e9.10.1786976160179; 
 Mon, 17 Aug 2026 07:16:00 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999618acafsm124202635e9.14.2026.08.17.07.15.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 07:15:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 0/2] rust: switch from bilge to bitfield-struct
Date: Mon, 17 Aug 2026 16:15:57 +0200
Message-ID: <20260817141559.940844-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The bilge crate is heavily reliant on traits and, because trait functions
are never const, it does not work well with const; also important is
that bilge's support for the zerocopy crate is tied to an older version
and has never been updated.

The bitfield-struct crate, instead, is built from the ground up to
support const, and has much simpler code with fewer dependencies.
Its use is pretty much the same: device code does not change at
all, only register declarations do.  So, switch to it before it's
too late.

Paolo

Based-on: <20260817134538.924615-1-pbonzini@redhat.com>

Paolo Bonzini (2):
  rust: pl011: switch from bilge to bitfield-struct
  rust: remove bilge crate

 Cargo.lock                                    |  71 +-----------
 Cargo.toml                                    |   1 +
 rust/hw/char/pl011/Cargo.toml                 |   3 +-
 rust/hw/char/pl011/src/registers.rs           | 108 +++++++++---------
 rust/migration/src/vmstate.rs                 |  45 +-------
 scripts/archive-source.sh                     |   7 +-
 scripts/make-release                          |   4 +-
 subprojects/.gitignore                        |   8 +-
 subprojects/arbitrary-int-1-rs.wrap           |   9 --
 subprojects/bilge-0.2-rs.wrap                 |   9 --
 subprojects/bilge-impl-0.2-rs.wrap            |   9 --
 subprojects/bitfield-struct-0.13-rs.wrap      |   6 +
 subprojects/either-1-rs.wrap                  |   9 --
 subprojects/itertools-0.11-rs.wrap            |   9 --
 .../proc-macro-error-1-rs/meson/meson.build   |   3 -
 subprojects/proc-macro-error-1-rs.wrap        |  10 --
 subprojects/proc-macro-error-attr-1-rs.wrap   |   9 --
 17 files changed, 71 insertions(+), 249 deletions(-)
 delete mode 100644 subprojects/arbitrary-int-1-rs.wrap
 delete mode 100644 subprojects/bilge-0.2-rs.wrap
 delete mode 100644 subprojects/bilge-impl-0.2-rs.wrap
 create mode 100644 subprojects/bitfield-struct-0.13-rs.wrap
 delete mode 100644 subprojects/either-1-rs.wrap
 delete mode 100644 subprojects/itertools-0.11-rs.wrap
 delete mode 100644 subprojects/packagefiles/proc-macro-error-1-rs/meson/meson.build
 delete mode 100644 subprojects/proc-macro-error-1-rs.wrap
 delete mode 100644 subprojects/proc-macro-error-attr-1-rs.wrap

-- 
2.55.0


