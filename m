Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 286BBCAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 11:04:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvZTR-0006xB-Gk; Mon, 08 Sep 2025 06:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvZTO-0006vI-VT
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:51:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvZT9-0006Cz-30
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757328686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mxvf/JAkYelSTZETYkXyIfdcO2Wx1B9vDdDIc3VMLwg=;
 b=DiXYc5Im8dkLjMTKDiVeH7/wEG8FYmDDK27SaLdV0jMRQLjvvMbFbwqL6P/ZdUX1j+T0xw
 nkNef/eVJ9xi8OsdQcwqsY2v6Lk4XVuL7QceHAoTtxwpNaZ+p6UYYBmjlT8idwbRrtY+Eo
 nIx+5hwfIcLTfTJ5y2EOidUcmUaREYI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-6sIqnsdGPtqP7D3GMJsRVQ-1; Mon, 08 Sep 2025 06:51:25 -0400
X-MC-Unique: 6sIqnsdGPtqP7D3GMJsRVQ-1
X-Mimecast-MFC-AGG-ID: 6sIqnsdGPtqP7D3GMJsRVQ_1757328684
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3e40057d90aso1419476f8f.0
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 03:51:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757328683; x=1757933483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mxvf/JAkYelSTZETYkXyIfdcO2Wx1B9vDdDIc3VMLwg=;
 b=cWLh728r+ZaOcyv594jc6ptE4O/ygBp1K7sfMnJe4vRuIFzKgbGmP/p7KbCsaei+Xx
 xofhvqGtWMQlYnyLv52fQ44Z7IZukrCmvV+XnuhSFXYR5ZqetSui6jbzfSo4U7jNlTF/
 VEfEDdj11PZxemnT9Wc9IwzyWqBgXsxx2oNmIgCF4nQaG75GkdLI38sAEHVGxROio3V9
 1jOZmAq4D69Qydk9g/DZ+k64Sk2xsTEuLVxqnql0SznGXrdguqhd+nuLRBAhwjO4Gnnb
 NnMS1tGqlCVXEDzxt95U836VgW+WIhSOkJq20h2Fp90L4wp9mTaZhMkkJ6eCapvtzjM/
 V+Fw==
X-Gm-Message-State: AOJu0YzqhJmPrJnp7Mo2qvyef1Uj9RZW8QNT6WqCj6uo+EmXWReFyAjo
 97irDisaRE/A3G7ENqTv3qRCy8cXZaN2m9cwDdJz6Sa1eOQHbd019g/q/vgM+5r/Ak7r3S0tf06
 7MaNdaSOso4y7WI2/SQqIahxjKAaqCFO5f/zWdY2vEurCHWLpmuEjgIZX2PO1YJFUEQU7NmUwqC
 tgfvd6HYbameHmPY5BgD85nbMlVfWm3XTDLj2k13a/
X-Gm-Gg: ASbGncv5oN+U/zJOadXrSzOu2PTK7YGa3QajXNWiSOTIgln7tdoDYTGOhTR6ZMqade1
 FWdsbDHSPd9aNVxwwOxZ028ZpesXSnRBXJaObZT3kLjMQkrcVoeppwH3Ft+88biuKU7ZDt7UiQO
 wju1Dsk+OGHFM0yc4CN/MRJkTX4luzEypJ41tI5C0MCnAkeOzeDxFYZ7RIOwKHYDnespHPiTIsh
 R3QMTBcqpHp++UpslWLDvwe0SgHr3PxWmohozGeuUqiVXtq8o20aT5JNi1RCajfOmh5PrQ2P/GF
 uUqkcGFzdys2WNTD13OVRwydJ183MLAjBeOsQbLwRzNO4yiBE221uS5HomQ7SQhiIPulAQp5LaP
 e/lxt4xGdFd5VPZWMxGGsF0sL8FrzZhyl9RGiA9nU4K8=
X-Received: by 2002:a5d:5d05:0:b0:3ce:f0a5:d594 with SMTP id
 ffacd0b85a97d-3e641e3cba1mr6718259f8f.13.1757328683087; 
 Mon, 08 Sep 2025 03:51:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFl4LGqNIWRvWJ5HHY/7bF1bcHn1LJIPfXb28/11U3xHuUCFuBKM6JD75yuRhKza2KTHiMqCA==
X-Received: by 2002:a5d:5d05:0:b0:3ce:f0a5:d594 with SMTP id
 ffacd0b85a97d-3e641e3cba1mr6718223f8f.13.1757328682577; 
 Mon, 08 Sep 2025 03:51:22 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45dda4f2a0dsm133048215e9.2.2025.09.08.03.51.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 03:51:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 32/33] rust: meson: remove unnecessary complication in device
 crates
Date: Mon,  8 Sep 2025 12:50:04 +0200
Message-ID: <20250908105005.2119297-33-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908105005.2119297-1-pbonzini@redhat.com>
References: <20250908105005.2119297-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

It is not necessary anymore to explicitly list procedural macro crates
when doing the final link using rustc.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/meson.build | 3 ---
 rust/hw/timer/hpet/meson.build | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/rust/hw/char/pl011/meson.build b/rust/hw/char/pl011/meson.build
index 628a5238702..ffdc8af53f1 100644
--- a/rust/hw/char/pl011/meson.build
+++ b/rust/hw/char/pl011/meson.build
@@ -44,8 +44,5 @@ _libpl011_rs = static_library(
 
 rust_devices_ss.add(when: 'CONFIG_X_PL011_RUST', if_true: [declare_dependency(
   link_whole: [_libpl011_rs],
-  # Putting proc macro crates in `dependencies` is necessary for Meson to find
-  # them when compiling the root per-target static rust lib.
-  dependencies: [bilge_impl_rs, qemu_macros],
   variables: {'crate': 'pl011'},
 )])
diff --git a/rust/hw/timer/hpet/meson.build b/rust/hw/timer/hpet/meson.build
index b6bb9477f0c..bb64b96672e 100644
--- a/rust/hw/timer/hpet/meson.build
+++ b/rust/hw/timer/hpet/meson.build
@@ -16,8 +16,5 @@ _libhpet_rs = static_library(
 
 rust_devices_ss.add(when: 'CONFIG_X_HPET_RUST', if_true: [declare_dependency(
   link_whole: [_libhpet_rs],
-  # Putting proc macro crates in `dependencies` is necessary for Meson to find
-  # them when compiling the root per-target static rust lib.
-  dependencies: [qemu_macros],
   variables: {'crate': 'hpet'},
 )])
-- 
2.51.0


