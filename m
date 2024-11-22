Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 168A6E65D29
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 07:48:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEOOc-00056s-Bf; Fri, 22 Nov 2024 02:48:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tEOOb-00056i-0Y
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 02:48:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tEOOZ-0003Oa-G7
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 02:48:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732261682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=6bOTsY7bya2Tl46qnI16BZyl6bMSIUCIWNqzd/uE6UU=;
 b=NZ7M00ZjHwoogMTTLcx0AwmudF1F2G7UO4fHdNlWq8DJ/GVF3+/7s0T0+7QKrvcaEslP2P
 WbFUJy89U8j5ZocTVZejIee5gZyZmqMHbg4bhbgCOLfeDzmgJndkCn9qqlzX/eNSO+vL6h
 u7SQ/lO3ONKaP3AHr0YOHU9A9P+J76M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-Uh1GvY24PhGWYAXMU4vZXg-1; Fri, 22 Nov 2024 02:48:00 -0500
X-MC-Unique: Uh1GvY24PhGWYAXMU4vZXg-1
X-Mimecast-MFC-AGG-ID: Uh1GvY24PhGWYAXMU4vZXg
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-382450d158fso994300f8f.1
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 23:47:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732261678; x=1732866478;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6bOTsY7bya2Tl46qnI16BZyl6bMSIUCIWNqzd/uE6UU=;
 b=SbUoYbujF0m8XLGqPCeuWHBvC4VT03kBxjxOEfBXn2OrSzae2lqbUJ5BEqIu7euN2w
 5WbCg3H45/+gpRS0tFDacjS46cIwpcHc/gb+tyCWnBKk16J/3smustFWknmzpjr1D5VE
 YQ/EyUK63uXRnYT6/CUFjXL0NsqPd5HnHE4kUEBgB8OmXWjqs47nC34tkiEPQtH7L4YR
 nOT0nMD76TxMdk1IXMwRT3s1/LfzYIphDpH2h8uedopVgMvbmupDiqeB96Vvb49h5o3T
 aqtWTcokqxzqRRG/hviiuPeCgq78Cieb02Zj+K2AUpX357rRHP4tXYnRk0fx9UuVf0Zt
 vl8g==
X-Gm-Message-State: AOJu0YwbvjlCJxvOcXn8iUtoYHED/I5JMLHbt+Q/9RpCaxyIC848FYzb
 K5O3u4Ub88p8/g+uG5Wa8HiCpD8+ViAlKNd5pj8sLTHu9wDdcKeyarLaH84O8rn41/I+G5V+nHd
 EBXEDmsOuO1po+/KYPHLfa5bgLiiGGZaU21mcZ7lyxU970EfZko3Bi0qtYy/aVGJuw4LLH26TeZ
 ATQgA3R0ACQhxLLnScOLrRX4CnCy3KkKPDRjFw
X-Gm-Gg: ASbGnctwabaduSR7nAU6+HhMU28fSlka6ZxRIw1MsBc65NfFPPbo0hzYNsDTvfGJZ8Y
 1OyPVqwkt5qrAD2XR/xRviphvcl/UaZWVjuzl03XlFtye4W8di5kPs/U9nY3bDK7mlrBbHLnrWr
 XvIuBwqFsFGJvXHE5+7FpKlqTPLOr61xCP0yQNXSQw+xunMAJEZ0eCwjV//n92Os425MlPUmfQr
 NCFZ2ZPS4ZcfOwkihutphfvSsuY636HgvoDq1illffxRzvmzahL5g==
X-Received: by 2002:a05:6000:18ac:b0:37c:d1bc:2666 with SMTP id
 ffacd0b85a97d-38260b502dcmr1459582f8f.4.1732261678201; 
 Thu, 21 Nov 2024 23:47:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIWEOmbM7/QP9wjrlRul43Jb8S3MU9ctVgLtPfFhq2y/5gq7NyIVUq6/Vrep2S9DcE7a+62Q==
X-Received: by 2002:a05:6000:18ac:b0:37c:d1bc:2666 with SMTP id
 ffacd0b85a97d-38260b502dcmr1459568f8f.4.1732261677784; 
 Thu, 21 Nov 2024 23:47:57 -0800 (PST)
Received: from [192.168.10.3] ([151.49.204.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbc4173sm1708062f8f.72.2024.11.21.23.47.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 23:47:57 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: junjie.mao@hotmail.com,
	zhao1.liu@intel.com,
	qemu-rust@nongnu.org
Subject: [PATCH 0/2] rust: safe wrappers for interrupt sources
Date: Fri, 22 Nov 2024 08:47:54 +0100
Message-ID: <20241122074756.282142-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Interrupt sources, qemu_irq in C code, are pointers to IRQState objects.
They are QOM link properties and can be written to outside the control
of the device (i.e. from a shared reference); therefore their Rust
representation must be an interior-mutable field.

This make interrupt sources similar to a Cell<*mut IRQState>.  However,
a Cell can only live within one thread, while here the semantics are
"accessible by multiple threads but only under the Big QEMU Lock".

Therefore, this series adds to QEMU a specialized cell type that checks
locking rules with respect to the "Big QEMU Lock".  In particular,
qemu_api::cell::BqlCell only allows get()/set() under BQL protection and
therefore is Send/Sync.  It comes with documentation and doctests.
I am not fully satisfied with the solution I used for mocking the BQL;
I have a prototype that runs doctests from "meson test" but that may
take some more time to cook.

Likewise, qemu_api::cell::RefCell would be a RefCell that is Send/Sync,
because it checks that borrow()/borrow_mut() is only done under BQL;
but this is not added here because there is no use case (yet).

The interrupt sources prat was previously posted as RFC at
https://lore.kernel.org/qemu-devel/20241104085159.76841-1-pbonzini@redhat.com/,
while the BqlCell is new.  The code is a bit long but most of it is
lifted from the standard library and almost half is documentation.

Please review!

Paolo Bonzini (2):
  rust: add BQL-enforcing Cell variant
  rust: add bindings for interrupt sources

 rust/hw/char/pl011/src/device.rs |  22 +--
 rust/qemu-api/meson.build        |   3 +
 rust/qemu-api/src/cell.rs        | 294 +++++++++++++++++++++++++++++++
 rust/qemu-api/src/irq.rs         |  66 +++++++
 rust/qemu-api/src/lib.rs         |   3 +
 rust/qemu-api/src/sysbus.rs      |  26 +++
 6 files changed, 404 insertions(+), 10 deletions(-)
 create mode 100644 rust/qemu-api/src/cell.rs
 create mode 100644 rust/qemu-api/src/irq.rs
 create mode 100644 rust/qemu-api/src/sysbus.rs

-- 
2.47.0


