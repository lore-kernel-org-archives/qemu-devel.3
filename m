Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B03CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 13:56:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBvna-0004iR-7m; Thu, 23 Oct 2025 09:56:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mkletzan@redhat.com>)
 id 1vBvnW-0004dL-LG
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 09:56:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mkletzan@redhat.com>)
 id 1vBvnU-0005Dy-Ju
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 09:56:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761227762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=8wea7NK5QlWnIzDozQt/I5YMLo/WNbD+ENI9kZgAa7E=;
 b=ila7ShoJDim/IczsrgXWAeH/tV8uAv6nzqQ7jE1Hu75Xi4HkvNu/OW7jR7PDXLtKp4QIvb
 0eZVwUhPwe+a3gQGM0aAu3PbJXT9ZpnKFXdNWExi9/3/C8B+yiaW4H6LRiq1umFPt1YOU7
 eI5HJIufM79s5Wgjkl8dIaoQTF6cEoI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-F2zES-BtMuasibbWJWQobw-1; Thu, 23 Oct 2025 09:54:22 -0400
X-MC-Unique: F2zES-BtMuasibbWJWQobw-1
X-Mimecast-MFC-AGG-ID: F2zES-BtMuasibbWJWQobw_1761227660
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-470fd92ad57so8249385e9.3
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 06:54:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761227660; x=1761832460;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8wea7NK5QlWnIzDozQt/I5YMLo/WNbD+ENI9kZgAa7E=;
 b=IRgcsjVWBorqJb6VgdIhKt1JNCEE8WDoH0nmYfFMXW1o863NNmh0IgshxF/gOCtCn2
 OX46BDj2s2dA3aTCSgHN+wazXIDZw+hKZhsCVxvxMLxoLnZxd8nJ8o5b03YT1CO66TUM
 l/Sui7pDy0LXzWqZ3K+K6juRhrpjvnFLUuLXFPeTh1kj6wcihEv05ELw1yr6Q+UG43GY
 3kgPvGl2HORO8QwlZR0QT5qp6TwJdgGBLYDh6hUQ7SUjoyUIL4xl/Ly08WPMwg2972hB
 5H8gcSzvX+T3N0M8Lyja5OJ+bUhqhXpY/quMH4c+cqAGYfQcJCXakeqmhVFKxvmJy0bv
 w6Rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSZ2q/lf4grXGZCi+IeOGEaj5hpU+fZQuUs7nnSU5PnRT26prMr/VQezOQ6njbqhlSYKv8Tb5YioJp@nongnu.org
X-Gm-Message-State: AOJu0YwmzIngDvsOKYyDQ6X5lYXFf3dVxpehkK5Q9Nye+gn6f1QWll7T
 eh4E47Z8TQPeglkO0KtbCdLsd1S0YtfaktIE/ewMHISTuVbXKgPDJJyhlAcwlIS5rl1t8z61WoF
 6M3x4PfzFERSzFy1C//A7cZEkPpGCPSs75MaJzv830TwFRc7udenGBMU/
X-Gm-Gg: ASbGncv+Z3hN95ySk+eCShw4XnkmeZ0gVQtYeyaf/ahKuaT0pQV5s3iwKC01NB7iHxn
 KMtBcypomU0HbjOyksdNaEAP4yPS5Sbe9zyW6lEphlBwLx8YxcHr0F6mw/IhioY4X1JDYV+0zK7
 GcP430MhH9BCSzb5ud/u7P+nRrv9j8R/VfcBnlGuDLvFJOVyI2rtTZIkOmac8rX5vrhM+vYU1+P
 lKnZwqUYujBlzYa8QtqC/B462eQOC6ld3cQiArvTHjLkGXk5HsNC5ybtkPfRYLlYNtcIDuN/URz
 OW3IVCkUKTTca8YJ+Rwdgc6GCrKMmdaq6ztBDDBhVjsUx3+AC/H/gGIQJICEnFp0eUP4zMV9GL0
 bw0tAeUFc
X-Received: by 2002:a05:600c:470d:b0:471:12c2:2025 with SMTP id
 5b1f17b1804b1-471179140abmr211589015e9.32.1761227659837; 
 Thu, 23 Oct 2025 06:54:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwULW8h0Re8+kXSlcx2urbXcMc8wv1br0odV4oLSeuM1EMpO81fWvMOBhF/bVr62Y/qdGKlQ==
X-Received: by 2002:a05:600c:470d:b0:471:12c2:2025 with SMTP id
 5b1f17b1804b1-471179140abmr211588845e9.32.1761227659418; 
 Thu, 23 Oct 2025 06:54:19 -0700 (PDT)
Received: from wheatley.localdomain ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c4378cbesm95123025e9.16.2025.10.23.06.54.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 06:54:18 -0700 (PDT)
Received: from wheatley.pinto-pinecone.ts.net (wheatley.k8r.cz [127.0.0.1])
 by wheatley.localdomain (Postfix) with ESMTP id 5EB16DC7C866;
 Thu, 23 Oct 2025 15:54:18 +0200 (CEST)
From: Martin Kletzander <mkletzan@redhat.com>
To: 'Manos Pitsidianakis ' <manos.pitsidianakis@linaro.org>,
 qemu-rust@nongnu.org, qemu-devel@nongnu.org
Subject: [RFC PATCH 0/2] rust: Make common::Wrapper work with non-tuple structs
Date: Thu, 23 Oct 2025 15:54:07 +0200
Message-ID: <cover.1761226974.git.mkletzan@redhat.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mkletzan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

As part of my "investigation" [0] into safer object initialization using
pinned-init, I found out that pinned-init will probably not work with tuple
structs for some time [1].  So I figured out how to change QEMU's Wrapper derive
macro so that both tuple structs and classic structs (still `#[repr(transparent)]`
and having only one member) are supported.

The second patch is there just to show that it works, I also checked the result
with `cargo expand` to make sure.

This is just to see if the patch makes sense the way it is.  I'm still trying to
see the best way forward with this pinning effort.  Many thanks for Paolo's
patience with me.  I'm using what I learn to also try and make a proof of
concept of something similar to the RustInQEMU effort (although way smaller in
scope) in libvirt, so it takes a bit more time.

[0] read: learning QEMU internals and possible Rust usage
[1] https://github.com/Rust-for-Linux/pin-init/issues/85

Martin Kletzander (2):
  rust: Make common::Wrapper work with non-tuple structs as well
  rust/util: Change Timer and TimerListGroup to normal structs

 rust/qemu-macros/src/lib.rs | 49 ++++++++++++++++++++++++++++---------
 rust/util/src/timer.rs      | 10 +++++---
 2 files changed, 44 insertions(+), 15 deletions(-)

-- 
2.51.0


