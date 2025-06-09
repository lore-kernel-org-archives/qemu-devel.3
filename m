Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D172C5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 15:45:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOefq-0000MC-Gr; Mon, 09 Jun 2025 11:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uOefo-0000LL-Db
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 11:44:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uOefm-0007g1-Hz
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 11:44:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749483869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=L28jsPRClJo4OLLokxftqnXGEfNPrNBJD4KBjVYT1Gw=;
 b=FKmsD2MJc2q9N8U26jG7KWNYE+rPGd2rOoeNy/CHyHNycPUrET+gJ7M5Hsulhi1TsZ2CnM
 xrRdSxuJBfAZ66zwpXRsh9wBbqvfOaxv0Su18ZeUvsHbuqqk0NeqOj6B7VBBYRdy8CvjJT
 KrW/I26gZeMT9Vhc3vimBRbRkp3bCu0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-g0zGW6WdNTifX8LJuWcMNw-1; Mon, 09 Jun 2025 11:44:27 -0400
X-MC-Unique: g0zGW6WdNTifX8LJuWcMNw-1
X-Mimecast-MFC-AGG-ID: g0zGW6WdNTifX8LJuWcMNw_1749483866
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-441c122fa56so22381175e9.2
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 08:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749483865; x=1750088665;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L28jsPRClJo4OLLokxftqnXGEfNPrNBJD4KBjVYT1Gw=;
 b=PJxagJpVc91GBaEbllKGYUqskn1mdEjdobfcBpysR/khA0XmVnInuNgkurlnLNELcu
 5vkJ+eOio//LD9MumQtq0E96VmY0OhZZUlF13QoEdJ34jM3As92oPj5SsD9OVultcpTe
 oHP4AGeqH6hqDvcMmLfj44qPphQ7dBF8cHaSiBH6ICdq+Oxdcfh2fQIGTqPuSGHZllj+
 7qKzcgqAj7lVD1w2vY6a0vLiZ9OwQ56QUlm91HiD6SMq72jfPWCKcMlzhgBQOZQ2kPFd
 plqAyBic8yNrq+UZKeu4twlm4zR4w8QiLQgIIr/Q0KRcwOWJND9mA47vxa7ZRFJtl0l5
 fagA==
X-Gm-Message-State: AOJu0Yzdu3WDsIkvWveho/173vxVi/aHdUQxJ9qPbegHkIYIVJ+Zp1yy
 /739NZ0bgZbxnN2f5w2sFqENU02aYD0m5krE3+CbSM8/kGcLyEMuDv26k4nsM8AMzThHpWhyStu
 7rAAil4XAYgJoGNrCBOMDOirr+s38jk7sCcdOM0ebw7VjUU6MDWOLRBPGAmD43XboFVkSPcgWeR
 EaIzNw9uh7T7OnE/7iHMZnzdcRfRFECuWEHFs5AMle
X-Gm-Gg: ASbGnctfKk6Z+o9wwN1/BJ47vjtY9QZ6FEdUeflDR1wuZi8sLC7KSpAvOHQiz/axQNf
 jT0Y6fQbZXITPBBqODBnPLZvVhCoehKMH/rgyCdfRSE1H+C4wChjZ+tpY4X/aXri/D59AyM6zd0
 abaAzgKTDDLJ6x8ufeSHebKIvFQloozZUSXs28KEBBJN0GdIrAyJr8ZjEjwvPE9T+SBUzeKXAJ2
 cl6EwRlFvg+x3v8e6Sd+SUosllxT+MqieIgxRCL3KKUa7+4VYys/oLy3RNMYOA+la0M75sndFwv
 HX6vAgtThOTKrA==
X-Received: by 2002:a05:600c:3493:b0:43d:172:50b1 with SMTP id
 5b1f17b1804b1-452013ec5ebmr124974595e9.29.1749483865574; 
 Mon, 09 Jun 2025 08:44:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKkSc7lFSf+XdAfkz9I9Gcg7rsE2d5Ms93SZM7OJAZWbc14rkGxPKDD+EZMIpkkAEivl1MEw==
X-Received: by 2002:a05:600c:3493:b0:43d:172:50b1 with SMTP id
 5b1f17b1804b1-452013ec5ebmr124974325e9.29.1749483865032; 
 Mon, 09 Jun 2025 08:44:25 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53244d66dsm9777277f8f.70.2025.06.09.08.44.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 08:44:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 0/5] rust: make instance_init implementations use safe Rust
Date: Mon,  9 Jun 2025 17:44:18 +0200
Message-ID: <20250609154423.706056-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is a step towards safe bindings to instance_init: making the
implementation safe, though ensuring that *all* fields as initialized
is still up to the implementor.  This helps making it clear what we
want from crates like pinned-init (the Linux one) or its inspiration
pin-init.

This series has two concoctions that are a bit more advanced.

The one in the first patch is probably going to be temporary
once instance_init takes its final form, but it's very useful while
we're stuck with piece-by-piece initialization.

The fourth patch instead is an adaptation of the technique in
GhostCell (https://plv.mpi-sws.org/rustbelt/ghostcell/), which allows
to isolate an object within the invocation of a function.  This one
probably will stay, together with the ParentInit struct that (in one
shape or another) acts as the "proof" that instance_init has been
called on the parent classes.

Paolo

Paolo Bonzini (5):
  rust: qemu_api: introduce MaybeUninit field projection
  rust: hpet: fully initialize object after instance_init
  rust: qom: introduce ParentInit
  rust: qom: make ParentInit lifetime-invariant
  rust: qom: change instance_init to take a ParentInit<>

 rust/hw/char/pl011/src/device.rs |  34 +++---
 rust/hw/timer/hpet/src/device.rs |  56 +++++-----
 rust/qemu-api/meson.build        |   1 +
 rust/qemu-api/src/lib.rs         |   1 +
 rust/qemu-api/src/memory.rs      |  12 +--
 rust/qemu-api/src/qdev.rs        |  51 +++++----
 rust/qemu-api/src/qom.rs         | 175 ++++++++++++++++++++++++++++++-
 rust/qemu-api/src/uninit.rs      |  85 +++++++++++++++
 8 files changed, 341 insertions(+), 74 deletions(-)
 create mode 100644 rust/qemu-api/src/uninit.rs

-- 
2.49.0


