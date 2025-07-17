Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E67C83F34
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 06:45:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucIMR-0006kZ-FQ; Thu, 17 Jul 2025 02:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ucI5l-0008Ab-8q
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 02:27:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ucI5f-00085n-Kq
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 02:27:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752733654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=A7MqYkErdty9uD7TbD+Z+ihMDFjNt79Yru60c119ORA=;
 b=aRpVK4qz+cPNY6r44N4f7YvN1zxoCPaafx2x6ctPjjnvquNIqVXp+DQBtB6+Lz9i+FzGpE
 3sauzbY4ldBKWJJ4b75kDA0LmaPxOMQiq26lKNNYqn0NMzTKQ3bC2CZvE8DwiCak2Dc8yg
 qVEzMCUQ3pCszqDyHMQMKNOP0TottbA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-xTF7riB3OKKDlWTIZphV0g-1; Thu, 17 Jul 2025 02:27:32 -0400
X-MC-Unique: xTF7riB3OKKDlWTIZphV0g-1
X-Mimecast-MFC-AGG-ID: xTF7riB3OKKDlWTIZphV0g_1752733651
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4eeed54c2so335857f8f.3
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 23:27:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752733650; x=1753338450;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A7MqYkErdty9uD7TbD+Z+ihMDFjNt79Yru60c119ORA=;
 b=AhkQ2gwv4CiGU0ZYsnsmJ7OBIVIzheBHlmdCwLYTF4C6mVj5j/tX53qaZuOdY1qoWT
 WmuF4dwDXnHMWWzj2uFN+EP/dsEOg553EEk0ZABfBDog8GXFCSXtNwRQVOLOX4AwpWA8
 VQyFAbKWyjki40eQR6vg30iUcSlzxNU/CmqT625tR47WiHGX4ufhPVL1zQxaUIiuybTC
 yHTxfGuJbjUks0HjrAK1UeHzodDbFXCTlm6xn9m645yTIbXN4Otw0BIHZBqZs8yjzUAh
 taTcQBvUcdLLjShkWNmlaOcFkr+J1OcdyAPRIPY8DSa/0GoUkHlbT71CpydeTza5zK2J
 pXSA==
X-Gm-Message-State: AOJu0Ywqdc2cC/4bd5lZpp2EIjYzhec8jiE+dWNp9NBfXcOp8SkDmcaA
 wLjtMA0PVGP4sdgX9Q7tZcU9IXr1JZaWvBMKeKYn4/3Qzqyvqp4Q21btAAZ9s7XssWoFCaaH/CC
 akOPwBsaTb4yo74Os7h5/nTemooWIi58lLgzqowqSPWdcdfqQil7AKMfPH3sfc1PfcQNypVip5A
 jXa38nMaKNSwBJdYpzyjU1q8WuWMRXcLy4pg73FFLq
X-Gm-Gg: ASbGncvPWifX3gmFznMfn5C8ZzvnRG+pc7PbcL+Hr0cO3wtYmEUJbm6PNhtazvgmGGv
 3W3NlGqVaQyMUROHaMSJtMVksEzfvH5OBCI2un4tvz2pAAiFRw9esL3DKO2y5Oj4x1gUAgHl2p6
 hQsI5a+KBGEpVX70I/d1CPvggmCVpB8VJZXVhqEC3bRP3Ed88Y3hgvX4aVAR573rB31/L7SmggL
 j/8tXWdTvOvSLN3N3ayu+YYpxYPIEkRRs5U8cCG+wqpTxKvSSN3by3xlPCKBuk12jxw/lcS9ZQi
 j1Siuxj8P0temvX/qaJph5oztQZXOYIYtggyko2tXnE=
X-Received: by 2002:a05:6000:4b1e:b0:3b4:b4d:6861 with SMTP id
 ffacd0b85a97d-3b60e50fe9cmr4084180f8f.27.1752733649928; 
 Wed, 16 Jul 2025 23:27:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUa4aOXbChYUxWv8JWA15fCsaQUq72srX4VLGiAhq9NwptUicuvnABzKx0c9GffdNfBTkSmQ==
X-Received: by 2002:a05:6000:4b1e:b0:3b4:b4d:6861 with SMTP id
 ffacd0b85a97d-3b60e50fe9cmr4084160f8f.27.1752733649446; 
 Wed, 16 Jul 2025 23:27:29 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d719sm19981527f8f.54.2025.07.16.23.27.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 23:27:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	manos.pitsidianakis@linaro.org
Subject: [RFC PATCH 0/4] rust: use attrs crate to parse #[property]
Date: Thu, 17 Jul 2025 08:27:23 +0200
Message-ID: <20250717062727.305466-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
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

This needs a bit of preparation, but it simplifies the handwritten parsing
code down to approximately 10 lines, and slightly improves the error
messages too.  All the scaffolding will be shared by future uses of
procedural macros.

Thanks to the author of the attrs crate, Aatif Syed, for accepting to lower
his crate's minimum supported Rust version to 1.83.

Paolo

Paolo Bonzini (4):
  subprojects: update proc-macro2 and syn
  subprojects: add attrs crate
  rust: qemu-api-macros: support matching more than one error
  rust: qemu-api-macros: switch #[property] parsing to use combinators

 rust/Cargo.lock                               | 19 ++++-
 rust/meson.build                              |  2 +
 rust/qemu-api-macros/Cargo.toml               |  1 +
 rust/qemu-api-macros/meson.build              |  1 +
 rust/qemu-api-macros/src/lib.rs               | 84 +++++++------------
 rust/qemu-api-macros/src/tests.rs             | 14 ++--
 scripts/archive-source.sh                     |  2 +-
 scripts/make-release                          |  2 +-
 subprojects/.gitignore                        |  5 +-
 subprojects/attrs-0.2-rs.wrap                 |  7 ++
 .../packagefiles/attrs-0.2-rs/meson.build     | 32 +++++++
 .../packagefiles/proc-macro2-1-rs/meson.build |  2 +-
 subprojects/packagefiles/syn-2-rs/meson.build |  2 +-
 subprojects/proc-macro2-1-rs.wrap             |  8 +-
 subprojects/syn-2-rs.wrap                     |  8 +-
 15 files changed, 111 insertions(+), 78 deletions(-)
 create mode 100644 subprojects/attrs-0.2-rs.wrap
 create mode 100644 subprojects/packagefiles/attrs-0.2-rs/meson.build

-- 
2.50.1


