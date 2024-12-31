Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6642E7718F
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 00:25:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSQ3E-0003Pb-4j; Mon, 30 Dec 2024 19:24:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tSQ3B-0003Ny-CN
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 19:23:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tSQ33-0001xX-1N
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 19:23:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735604626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=20JLlnKhVGNyGf1xgIyZoN4lgjdqIel1uxoMLonmRjI=;
 b=h9IRf+poFMFo0PckmISkT6mL+i9KcqHDbCGmMKyUBvA0hQ5xV46Y5pyczUI6ojko0OrDlF
 XLCm2fzuIfPbLBqNrQx3Q8+L8YXGscs+6LYO5Hu4jKm+9VfD+aBx++5sVc1IgnxKzHdYxb
 8Uq0Nijs3MN7wvcUb8dTbw3rgwJtGYk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-8PmQITZjNjmbjoI60xCQiw-1; Mon, 30 Dec 2024 19:23:41 -0500
X-MC-Unique: 8PmQITZjNjmbjoI60xCQiw-1
X-Mimecast-MFC-AGG-ID: 8PmQITZjNjmbjoI60xCQiw
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4362153dcd6so9976915e9.2
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2024 16:23:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735604619; x=1736209419;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=20JLlnKhVGNyGf1xgIyZoN4lgjdqIel1uxoMLonmRjI=;
 b=v6MJ1QI7cypKoDieQEJMX8ZAjqN0cNP/4LhyF0jLFQ+qJxVQ1BS+Z99ZmAVNd6rLYt
 LPwZG959XkiMsYLzmcArhJj72pg/7CtkT5/HaAtALarSW2jrI+3b96Rtuc0HRKK1Eu0o
 ADGRrYkiBUAU7MEEJ3Cf4Br/LUgyr/LTpy/hHtsXFqrr/pb+hreBJVWmji2TGoJVu1Sl
 kue191N9BTrndPoqHiBekMY4tQ3ZVXk+oYJvxGDAA9wUKmBLIm7c3AWox+3Lyp2Eqrnu
 dG6DZidOnYf7AvZDaDYBwyi4a0CjFdxXXgdadfR9pQVWWAlFbUXs/QAlVkzd4kqXqNuE
 pyIA==
X-Gm-Message-State: AOJu0YxHY7bFY+XOXrmbOuGfcP3BesHVhdJz2Dg0QtogKfE3BBrf3IyO
 iSTpZEnzBEGUBKesKbSHXhnJmqxleccs54ZMTMOVUtMDzfR4eZLuL7G9CoDQhloNyPDsCNueGEO
 OiGMgDx9IElBt/PyWXktdD148BzT5x6XJgBudk4K9NQcgMNmuRDxrdheE8h726b7e/hFxi4H4CH
 Q/t0FD8IkPRwPKhvOQRb3uCNmoyCAkquDY1nLA9PY=
X-Gm-Gg: ASbGncuORSZXCSxUk+oiRLGxMf3eD3055M7HTU5K5aKIQlNZ6tVl8jlUo4g36iEbGOg
 CSBQ23BXbtqxyGXk2sXbIopUEL/H0qExPRfSfaT79EKcUWlKxic8dCziqWaXD2bVZQWf0Yftdwn
 ncyiaA8J0uby8GKkgnlT55gRdpbh0BH5WrYSFOTNn5JuC7LSTRe4LOyP6c43YBYNxJDbA5APVRp
 mMTSjA2xpSSIko8iaPZsOaiegWkBiHlzOz7seV+MAED9WC2daOC4tnDIAo=
X-Received: by 2002:a05:600c:3505:b0:434:fafe:edb with SMTP id
 5b1f17b1804b1-43668b5f326mr286831175e9.24.1735604619243; 
 Mon, 30 Dec 2024 16:23:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJDir+9oM2746BzqIGIR55h8Jcc3q+74tzCVMJaCQfmht6jkQUz9kA/lc2WpcBx7beQkEw8Q==
X-Received: by 2002:a05:600c:3505:b0:434:fafe:edb with SMTP id
 5b1f17b1804b1-43668b5f326mr286831065e9.24.1735604618797; 
 Mon, 30 Dec 2024 16:23:38 -0800 (PST)
Received: from [192.168.10.3] ([151.62.105.73])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b11aecsm403171205e9.23.2024.12.30.16.23.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Dec 2024 16:23:38 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	zhao1.liu@intel.com,
	junjie.mao@hotmail.com
Subject: [RFC PATCH 0/9] rust: (mostly) type safe VMState
Date: Tue, 31 Dec 2024 01:23:27 +0100
Message-ID: <20241231002336.25931-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.187,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The existing translation of the C macros for vmstate does not make
any attempt to type-check vmstate declarations against the struct, so
introduce a new system that computes VMStateField based on the actual
struct declaration.

Macros do not have full access to the type system, therefore a full
implementation of this scheme requires a helper trait to analyze the type
and produce a VMStateField from it; the trait stores the VMStateField
as ana associated const.  Then, a macro "vmstate_of!" accepts arguments
similar to "offset_of!" and tricks the compiler into looking up the
trait for the right type.

Structs and cells have their own sub-VMStateDescription.  This poses
a problem in that references can only be included in associated consts
starting with Rust 1.83.0, when the const_refs_static was stabilized.
So for now structs and cells cannot be done in a type-safe manner,
but arrays, pointers and scalars can.

Technically, scalar types have the same issue in that they point to a
VMStateInfo.  For this case however there is onlyya limited list of
VMStateInfos, so I am placing them in an enum, and going from enum
to &VMStateInfo only when building the VMStateField (i.e. in a static's
value rather than in an associated const, and in a macro rather than in
a const fn).  This isn't great, but it's easily removed when QEMU starts
accepting a newer Rust version.

The series also introduces the pattern of applying changes to a struct
using methods with a fn(mut self) -> Self signature, for example

    pub const fn with_version_id(mut self, version_id: i32) -> Self {
        self.version_id = version_id;
        self
    }

This is not quite the builder pattern because there is no need for a
final ".build()" call, but it's similar/related.

The unfavorable diffstat comes half from the const_refs_static workaround,
half from new documentation (so in that case it's a plus rather than
a minus).  And also, there is more functionality and extensibility in
the new mechanism, whereas only a subset of the C macros was included
in the previous implementation.  The exception is "field_exists", which
may be added later if needed as a modifier, similar to with_version_id().

Paolo


Paolo Bonzini (9):
  rust: vmstate: add new type safe implementation
  rust: vmstate: implement VMState for non-leaf types
  rust: vmstate: add varray support to vmstate_of!
  rust: vmstate: implement Zeroable for VMStateField
  rust: vmstate: implement VMState for scalar types
  rust: vmstate: add public utility macros to implement VMState
  rust: qemu_api: add vmstate_struct and vmstate_cell
  rust: pl011: switch vmstate to new-style macros
  rust: vmstate: remove translation of C vmstate macros

 rust/hw/char/pl011/src/device.rs       |   3 +-
 rust/hw/char/pl011/src/device_class.rs |  36 +-
 rust/hw/char/pl011/src/lib.rs          |   6 +
 rust/qemu-api/src/prelude.rs           |   2 +
 rust/qemu-api/src/vmstate.rs           | 673 ++++++++++++++++---------
 rust/qemu-api/src/zeroable.rs          |  31 ++
 6 files changed, 481 insertions(+), 270 deletions(-)

-- 
2.47.1


