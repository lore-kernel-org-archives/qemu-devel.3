Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5108C0219C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 10:17:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgLPv-0007OJ-Am; Fri, 07 Feb 2025 05:16:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tgLPX-0007Ih-Mc
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 05:16:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tgLPV-0003fZ-09
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 05:16:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738923391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=WfSf2kR+KPzGYZoZgRGQYLCZot2N1LSU/8KPAc59nEg=;
 b=RJpO4fjPjQSDAeVZTSVMruOtDru+LdHFb4NaJ9n2XemWaLwNT51529iPoQvtAuJXfVVkK4
 CnKXMiy6RFqomt2PrctoV+1Q69WFxbd/9r2JC4dFcIo8hjKUyPoJdqG+0Y54TqzDemzYLD
 GIeDpRuTIxq/+z/eR+jBWE5CyZYHDLw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-a6P5OZqmO3-pWpeoU-WclA-1; Fri, 07 Feb 2025 05:16:29 -0500
X-MC-Unique: a6P5OZqmO3-pWpeoU-WclA-1
X-Mimecast-MFC-AGG-ID: a6P5OZqmO3-pWpeoU-WclA
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ab78f08e32cso42622566b.2
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 02:16:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738923387; x=1739528187;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WfSf2kR+KPzGYZoZgRGQYLCZot2N1LSU/8KPAc59nEg=;
 b=VQZ8TXgFPVfw+LV6rU61bpdtUidRRaAXA6M6X16C8sfX3DpO7Y4sCN4NPJoE+CoL8x
 WpdMWKWdyU9ji3cyjidCtvuvgqfwm0nMirqVSgyekA1sYW8CCjzciSvCz78JKJ0Fr46w
 yEabDwOZA5WwsI4DHVrC0ipCDTtEPecaKQ4JmbV6ezMh3ctrhgNE5psqZIpDMGk0ESbd
 tps6K8w1QkzV9qW2tcrq/E/eAdP4pwx+R4oA2tgU3A1pNUSU44T2EGsezIYKFC1wfp33
 wMokEYj0L2HoH1cbiTCTHdidRWuNrnr1HkPYUVuZ124j99/s8HuwhPBCQo/5zc5AhM+a
 1e+A==
X-Gm-Message-State: AOJu0YzBADq8a6CNTYBS4Qd8seBM9pnUmXODa0bkItl2q5ztxZj6klpb
 OzzyMWbbLai/oAtH+3/vYg1khgAKo5L7mbfV0APuEDfvhaSEK+VCEDP6bmv/x5zA3/NCoqknxYN
 dDBjQtNUGkPERPnGaESqkuBY4Z7DvL+EqXSEQma7RFFGcPZAWWhIYxs27g+Si69wagLw6kOrksB
 nUW3hd7LsvB99yn+FBo7xe3tix5MK96RBFwTTZzpY=
X-Gm-Gg: ASbGncu4R2Io21nW7Ke5HtKIqLSs3Wgzw06zmw+9BMg5IeOa0kcTa9oxfEnsY+omKP1
 5yDzT2l7qbDbCQzAqPnD+iK3T/sR6KAFxHRSgZ6nAYInKBr2oBlbFIrBoSbI2Jg0SHf1MifvmSt
 UDT4xWykbG68wZFmVttdhOEIkjrBNMEB7Ql62fHZXggd/WV04ckpBifTgPWQ8719pgaNcPctC0X
 GAadGPVVNUVsQ1a3EzLwz13YrmpUG9zWr9VDQPJ+HnAoXdXFwZSp/G2SDb1V1CGSI/syVM33qx7
 PYs1yw==
X-Received: by 2002:a17:907:7b9c:b0:ab6:dbd2:df78 with SMTP id
 a640c23a62f3a-ab789c62da8mr266969766b.35.1738923386761; 
 Fri, 07 Feb 2025 02:16:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTL9U5CDgnSIv/7MajCE2s3sb7k8RK9tIeNNAZoR/G9cmHnAefxIlgeA+16DiCL+IsNCutuA==
X-Received: by 2002:a17:907:7b9c:b0:ab6:dbd2:df78 with SMTP id
 a640c23a62f3a-ab789c62da8mr266964366b.35.1738923386303; 
 Fri, 07 Feb 2025 02:16:26 -0800 (PST)
Received: from [192.168.10.3] ([151.62.97.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab77365fc7dsm237097866b.182.2025.02.07.02.16.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 02:16:25 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	zhao1.liu@intel.com
Subject: [PATCH 00/12] rust: remaining parts of qdev bindings
Date: Fri,  7 Feb 2025 11:16:11 +0100
Message-ID: <20250207101623.2443552-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This concludes the part of the qdev bindings that is needed to convert
pl011 to safe Rust, with the exception of chardev bindings and switching
to the pinned_init crate.

It includes reference counting, object creation, clocks, Resettable
and MemoryRegionOps.  Documentation is at least decent.

The code is getting closer to the synopsis at
https://lists.nongnu.org/archive/html/qemu-rust/2024-12/msg00006.html,
except that it works (at least as far as CI is concerned) instead of just
compiling. :)  And since I'm citing it, a reminder that it may still be
worth asking your Rust questions as replies to that message.

You can find the code in the rust-next branch of
https://gitlab.com/bonzini/qemu/.

Paolo

RFC->v1:
- improvements and fixes for docs and comments
- fixed Sync/Send declarations for Owned
- prefer NonNull::cast (could use NonNull<> arguments too in the future)
- add Send markers too, not just Sync
- use impl_zeroable! macro
- add qdev_init_clock_out() too
- add comments about when to use Owned<>
- add Owned::clone
- add conversion of pl011_create to safe Rust for more uses of Owned<>

Paolo Bonzini (12):
  rust: qom: add reference counting functionality
  rust: qom: add object creation functionality
  rust: callbacks: allow passing optional callbacks as ()
  rust: qdev: add clock creation
  rust: qom: allow initializing interface vtables
  rust: qdev: make ObjectImpl a supertrait of DeviceImpl
  rust: qdev: switch from legacy reset to Resettable
  rust: bindings: add Send and Sync markers for types that have bindings
  rust: bindings for MemoryRegionOps
  rust: irq: define ObjectType for IRQState
  rust: chardev, qdev: add bindings to qdev_prop_set_chr
  rust: pl011: convert pl011_create to safe Rust

 meson.build                          |   1 +
 rust/hw/char/pl011/src/device.rs     | 121 +++++++-------
 rust/hw/char/pl011/src/lib.rs        |   1 -
 rust/hw/char/pl011/src/memory_ops.rs |  34 ----
 rust/qemu-api/meson.build            |   2 +
 rust/qemu-api/src/bindings.rs        |  46 ++++++
 rust/qemu-api/src/callbacks.rs       |  97 ++++++++++++
 rust/qemu-api/src/chardev.rs         |  19 +++
 rust/qemu-api/src/irq.rs             |  18 ++-
 rust/qemu-api/src/lib.rs             |   2 +
 rust/qemu-api/src/memory.rs          | 191 ++++++++++++++++++++++
 rust/qemu-api/src/prelude.rs         |   4 +
 rust/qemu-api/src/qdev.rs            | 227 ++++++++++++++++++++++++---
 rust/qemu-api/src/qom.rs             | 218 ++++++++++++++++++++++++-
 rust/qemu-api/src/sysbus.rs          |  39 ++++-
 rust/qemu-api/src/vmstate.rs         |  10 +-
 rust/qemu-api/src/zeroable.rs        |   1 +
 rust/qemu-api/tests/tests.rs         |  45 +++---
 18 files changed, 924 insertions(+), 152 deletions(-)
 delete mode 100644 rust/hw/char/pl011/src/memory_ops.rs
 create mode 100644 rust/qemu-api/src/chardev.rs
 create mode 100644 rust/qemu-api/src/memory.rs

-- 
2.48.1


