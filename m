Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9741C021A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 14:33:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiaGT-00006e-Mi; Thu, 13 Feb 2025 09:32:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tiaGR-00005Q-Nw
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 09:32:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tiaGN-0007aP-Pg
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 09:32:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739457142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qea6yNYTrWjUz32+OocmHw0yh1KpywotTecZ1bXmvrw=;
 b=TBR+A+s69OyZnMtTeM5U471R3NyXInWmg/b0Uc7lMRw8+RZY5PuDqXenho3JNvqUMxQsT8
 ru2eQpaMJ2CPvaVXxOoZ60NBtzFKbriowWuqObj5qeKfWQB17d/HV/YbU8GNpMorCLegEe
 SuH8GRGQiP2zQhC96qSaMAQQCGxxmXQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-X7Sq_Zh3MeCOcL7O0w0RMg-1; Thu, 13 Feb 2025 09:32:20 -0500
X-MC-Unique: X7Sq_Zh3MeCOcL7O0w0RMg-1
X-Mimecast-MFC-AGG-ID: X7Sq_Zh3MeCOcL7O0w0RMg
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38dfede57feso797318f8f.2
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 06:32:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739457139; x=1740061939;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qea6yNYTrWjUz32+OocmHw0yh1KpywotTecZ1bXmvrw=;
 b=F7fcmKWW/rvDLH7zt8yC4m4gRBYNbPIuHkYOVLfdoR+l2T5TAWVrm/Yi38/gdU5Sd6
 vuhSxmrRhHw8aXZyYZZPuaF+0Ih97rsUzkrI7cAq2iogOLHKXwQfUSjzGgvKHxIKdgG/
 tvq0Wkb65JLzH8QM2xFGOYca5KRqRONfy7GJQKsuufdJdlEZI+VmTuSrMAMaO7uoac0Y
 59f9drGX6wHG69ZKHHjgPHn9NS1ue6LIrCfn5XxBnK4lSNftc0Un+8tmGA+2eNWp3qHT
 aHIQj7AXXsSt2WoyXfhE8ax+1dEGVl+/mjpmypeV68w83LN1VN7xdEce2d60SflTEhJ1
 purg==
X-Gm-Message-State: AOJu0YySu3PHwnbCsJo1PHzWOv6U218wtbu8ghtxYVVHgA1z6+D0zPS4
 JA0upb2Klnl0W09ab4qGlxzfFPA0I0Rthhsev9lREyqLQTLuabIqXbU6GsietHv7wIiRz4bhAuG
 EIyPijkfdBaCFL3QKpfRHaO0F81AT2V3/JNXveUirIQ7iW6sNCxhLkvTRZvPnqHyjl+qdANBLWG
 l0RXMavVYhs0FcVFB4INj7aIHsrnnjOO0yyZIFpFY=
X-Gm-Gg: ASbGncvSTtLbAmHkvxxDY/XYT2KGF9FQssgfWXFFzlL6g0qOVaXSbWMH39nMXKEAm5b
 m0+QMkIY1+wkBWdQzENzLqwegO7n6x7nn63MOdqiqNs9/5XXdNIlHff8LsgU2kJ5V4HU3lalOwu
 w9L5s4ZtUBJe4AAibVEX0M6rY34fh8cs7XwyvvKL4YlftDc8zXuxkbX6X9zkIwIt4vhKFAgZ2ZL
 dC4rV69oxilniVqpyLjRLb0jpk8XUu2hOtdp0Bt0mPLKPktOKzrZSPMco0EEnlXZFNDlH5GLWrw
 vMYxUPOMb7rqehuVEeB6Lpu0gb+24Ntdd+SJNwRGCHc=
X-Received: by 2002:a05:6000:1a8b:b0:38d:d8b2:cf14 with SMTP id
 ffacd0b85a97d-38dea28cffemr7169885f8f.30.1739457138792; 
 Thu, 13 Feb 2025 06:32:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFulb0e/UcHB1fD7u4l2gM6zcc/xErWRd9Hf2cdUaOy8xp7y+2KZbiE8tT4DYoEfT47bqK3ww==
X-Received: by 2002:a05:6000:1a8b:b0:38d:d8b2:cf14 with SMTP id
 ffacd0b85a97d-38dea28cffemr7169837f8f.30.1739457138401; 
 Thu, 13 Feb 2025 06:32:18 -0800 (PST)
Received: from [192.168.126.123] (93-40-58-165.ip37.fastwebnet.it.
 [93.40.58.165]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258ccd95sm2049929f8f.25.2025.02.13.06.32.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 06:32:17 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	kwolf@redhat.com,
	qemu-block@nongnu.org
Subject: [PATCH v2 0/2] rust: add module to convert between -errno and
 io::Error
Date: Thu, 13 Feb 2025 15:32:14 +0100
Message-ID: <20250213143216.3910163-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Wrap access to errno, for use in the block layer and character device
bindings.

Supersedes: <20250212093958.3703269-1-pbonzini@redhat.com>

v1->v2:
- use the libc crate
- provide separate From<Errno> implementation for io::ErrorKind
- hide GetErrno trait inside a submodule
- add into_neg_errno() and corresponding tests
- add more doctests
- make Errno field public, so that Errno can have other From<...>
  implementations (e.g. going from *mut Error to Errno).


Paolo Bonzini (2):
  rust: subprojects: add libc crate
  rust: add module to convert between -errno and io::Error

 rust/Cargo.lock                               |   7 +
 rust/qemu-api/Cargo.toml                      |   1 +
 rust/qemu-api/meson.build                     |   4 +
 rust/qemu-api/src/assertions.rs               |  28 ++
 rust/qemu-api/src/errno.rs                    | 342 ++++++++++++++++++
 rust/qemu-api/src/lib.rs                      |   1 +
 rust/qemu-api/src/prelude.rs                  |   2 +
 scripts/archive-source.sh                     |   2 +-
 scripts/make-release                          |   2 +-
 subprojects/libc-0.2-rs.wrap                  |   7 +
 .../packagefiles/libc-0.2-rs/meson.build      |  36 ++
 11 files changed, 430 insertions(+), 2 deletions(-)
 create mode 100644 rust/qemu-api/src/errno.rs
 create mode 100644 subprojects/libc-0.2-rs.wrap
 create mode 100644 subprojects/packagefiles/libc-0.2-rs/meson.build

-- 
2.48.1


