Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D85D116E8
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2024 13:06:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t52xl-0003mv-Iw; Sun, 27 Oct 2024 09:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t52xj-0003mh-Ce
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 09:05:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t52xh-0005Ss-RC
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 09:05:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730034340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=chMhRQaxogGMnqR5MaOMUkx139qHo2hGdaN+p/obxoo=;
 b=BTxrIH0fQ7hITLUUscwSB2DSlrHLYjlYpfkPa5NZpeaaRT3NrLueJQ2QkiMl0+hj94toZb
 h8oyrz39e2e1vayu5KnNY6oUquHn5SJrovZEiQsR48ylG4tRwhQonCXtf4i0RT0Pa2jLRg
 aFQ4ATM9O2rkZ/l6dg3EFS8BS9E/qiY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-theZ38GlP-e72lH7Pz51KQ-1; Sun, 27 Oct 2024 09:05:36 -0400
X-MC-Unique: theZ38GlP-e72lH7Pz51KQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37d3e8dccc9so2077777f8f.1
 for <qemu-devel@nongnu.org>; Sun, 27 Oct 2024 06:05:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730034334; x=1730639134;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=chMhRQaxogGMnqR5MaOMUkx139qHo2hGdaN+p/obxoo=;
 b=gdKejLkQbfjlI51Oxjq3F2djiwbl2o/qU5veXYZAb3vYzk8Ges+oqqjK7cxDdtxVaL
 BzpTpXJUlp61YbY41IM/NSifbgacesrXHzAEiOayORZw7bDM06KBJ49eqyOyi8l8Uq5o
 Gdtg+FrtkJif5W07HnGeMsRJGkvME4xDkxzXp2hQhyvyhaEtEBohvwHsNqMdxnPQhtm7
 f96FuIgeP2K/rQlddY87U6l+XTmFxQL7MpZNyV9XRUb5kt8SHakoLalSfG8i8Fjmg4Bs
 1BidQOdRAmI41NqXD/My9/pYPTyz4v4/ASfjfgA5zDkAnZxSIcshE0Xp8wN1LEL+4JjA
 ssSQ==
X-Gm-Message-State: AOJu0Yxg5Lhm0gH1ogHWQYrE8yEQQAQRgFqEczKrWz30E+sRktLsr0tW
 maBwX4FjuA4KvLNN7YHULlMtGxtSQNr3R6wRLiF7DJChPU5ueJSqQutz0a9INMG7aBvdAArAYRG
 1az3pCxtjB5bwPzkic3iLCSwv0pPyZwt4HPm/XCKmctffqjCYNAYEvjGnQbbBaKfNtQUP129l+T
 LRM39FnFn2MefR9HNehv+FDzWtKMfz/JOpuK7ahnk=
X-Received: by 2002:a5d:4f04:0:b0:37e:d965:4e1e with SMTP id
 ffacd0b85a97d-380611ee9ccmr4121387f8f.42.1730034334588; 
 Sun, 27 Oct 2024 06:05:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHboW2mmoINdX3R6hmWb8arsnoSDEf1cmDqIloGKCmthnnu4J3ic1x8hVmJeKOhVRGKHGmmwQ==
X-Received: by 2002:a5d:4f04:0:b0:37e:d965:4e1e with SMTP id
 ffacd0b85a97d-380611ee9ccmr4121354f8f.42.1730034334008; 
 Sun, 27 Oct 2024 06:05:34 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b3b57bsm6782864f8f.26.2024.10.27.06.05.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Oct 2024 06:05:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH] configure: detect 64-bit MIPS
Date: Sun, 27 Oct 2024 14:05:31 +0100
Message-ID: <20241027130531.244145-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.287,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

While right now 64-bit MIPS and 32-bit MIPS share the code in QEMU,
Rust uses different rules for the target.  Set $cpu correctly to
either mips or mips64 (--cpu=mips64* is already accepted in the case
statement that canonicalizes cpu/host_arch/linux_arch), and adjust
the checks to account for the different between $cpu (which handles
mips/mips64 separately) and $host_arch (which does not).

Fixes: 1a6ef6ff624 ("configure, meson: detect Rust toolchain", 2024-10-11)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index 97bd4495f86..c0ba649d309 100755
--- a/configure
+++ b/configure
@@ -395,7 +395,11 @@ elif check_define _ARCH_PPC ; then
     cpu="ppc"
   fi
 elif check_define __mips__ ; then
-  cpu="mips"
+  if check_define __mips64 ; then
+    cpu="mips64"
+  else
+    cpu="mips"
+  fi
 elif check_define __s390__ ; then
   if check_define __s390x__ ; then
     cpu="s390x"
@@ -1230,7 +1234,7 @@ EOF
       fi
     fi
 
-    case "$host_arch" in
+    case "$cpu" in
     arm)
       # e.g. arm-unknown-linux-gnueabi, arm-unknown-linux-gnueabihf
       write_c_skeleton
@@ -1278,7 +1282,7 @@ EOF
     test "$rust_arch" = arm && test "$rust_os" != linux && rust_arch=armv7
     ;;
 
-  mips|mips64)
+  mips)
     # preserve ISA version (mipsisa64r6 etc.) and include endianness
     rust_arch=${raw_cpu%el}
     test "$bigendian" = no && rust_arch=${rust_arch}el
-- 
2.47.0


