Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7551C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 01:54:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we1CS-0004aj-8p; Sun, 28 Jun 2026 21:54:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1we1CM-0004a5-0I
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 21:54:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1we1CG-0006MP-5D
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 21:54:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782698037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Oy3wGPh4kUyBTZuM9QPlhryw0n0/N/FFI0LCYRC2luA=;
 b=QXp1/BcW4236vr3wz8KZtTpo2ZjtJMuSoBkryH9DoGJ0OF0kl5jSEfmOj6hlszssMtepaG
 ARVxcupeHiZgPaqHaX50bNMYOg3w39FGit9FzvCe57NHV2NmnZxL6sGJtN/21jXLeAjlVf
 32BirkKz4OmM/n3Uf2r1JrdvVVhR3dE=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-SF5qE1tXOnGbhbGG4SfbdA-1; Sun, 28 Jun 2026 21:53:55 -0400
X-MC-Unique: SF5qE1tXOnGbhbGG4SfbdA-1
X-Mimecast-MFC-AGG-ID: SF5qE1tXOnGbhbGG4SfbdA_1782698035
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2c8018f11fbso22732165ad.3
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 18:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782698034; x=1783302834; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Oy3wGPh4kUyBTZuM9QPlhryw0n0/N/FFI0LCYRC2luA=;
 b=nm2X8+a9ZC4UqWj6+0khOn5tl+G45CHQk9HWlECxxRHOAn1YrabuLHRK15jCEUrvkL
 oTnzuENZiGXDm7CCEwEyWH0u438X3B1NQehUUTdART+07OswTYr6jdWPIfFDnKneiU7I
 7C1zaWQ2c7IIt48lJz5rTojui9MRxqWuvH7LvJgtmddhLUoHA/N8zaKgD3IIpedo19O3
 TycZ94xzd74rTDp/DBFVHjYkVbtvNi2h1swJ5BAtjqVhc2Mz3njPPocZHuF7d8Y8ALYo
 ++SRG7bzMk6qXKfQhiaOkXwXX2qNgmYpigF0CD0VUNj1e3kDUVG7uBAiupA2KY+jU05n
 J1MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782698034; x=1783302834;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oy3wGPh4kUyBTZuM9QPlhryw0n0/N/FFI0LCYRC2luA=;
 b=Eny7vL60hpWLjmxN9vegShQa+viep2kf02qhTQH1N7wELKEButMxhBQJNbpnjOZQPI
 Yvs2qGRWlSP8H86GGPPHvAYYEMzELWMM3pnw3oYE9IFtYgoaI/uBHnoLrga5HSLOB4zt
 ucdOQLm+07FeovNu7h2R3gLEAghWIBnSSC3guc8j78UILkx5mXWrx6ftg+V5dznpOC8h
 NMi0LVKLWWPe21G/gJhZpwL6Zt9pZlGrlc+93g54LfuoEYxyLTdLidO+/Q9vX7xPq4Hu
 5z4R/YXBtDi0a/PxOwxAfzegmSkGHVJHtAxieJ8oLdEeq7BaL/wbpP1FA560/xbHQLzY
 mHMg==
X-Gm-Message-State: AOJu0YymF55ysmPygQfWnknGU02ZhgZd+GZ6Y6Xpa40sWaV1vl9VBZNM
 DAZTpdFcgKZlcl5zvJ9YMDoszpjBdoBx05kks9ecLsWaeD9QqUltAZYclvZaeJg+F6rfwLUK7pv
 FCFRJcOJpByWyPaPep6oh58/O6H0RG/FcNqgEmtzrPxC7dkXPbdBvwNzNYh74TE0bszD+Cj0e9D
 ahwRkCGIfi9ANYPcA+6t+OOruqGsZMfmzJW9SZzS7a
X-Gm-Gg: AfdE7ckQkW9sIkv0p7ZYUnfRM6etv+HYONTxCbkVSNB8+2R6aH+cEsX6Ha1GHB+kmIh
 o6KwhBxsP2YNmrDenufz3rjCwByTQGlUarRsWzLCKzTra5hawMkHIvm4kA7SkC9Kl/xeCm1S4YC
 6Z/6IFsmT3EfBnqbEgyj+QJ73qh4UcU0buGvX0CPs3HxcJcPzLYKiYPCco6lTAZB7RjbJq4fXpM
 VGhBkanBo7zJ+ABTwbyoWlXcPJF3liffF4Na3CoMYQ1HXjqhXHrL9OLdTQexxNdtZC++aBvTmZu
 EK9GqGOGVZRigfNrhxn5YqefP2dc/0me+RqonPh4+XYHnKaaThiYqKjRrhBC6mmd+jr8FImbduX
 XQm0mQx/GjC8R7M+3DjzY4A==
X-Received: by 2002:a17:902:e952:b0:2c9:bd30:e6ff with SMTP id
 d9443c01a7336-2c9bd30ea60mr48334025ad.39.1782698034445; 
 Sun, 28 Jun 2026 18:53:54 -0700 (PDT)
X-Received: by 2002:a17:902:e952:b0:2c9:bd30:e6ff with SMTP id
 d9443c01a7336-2c9bd30ea60mr48333765ad.39.1782698033720; 
 Sun, 28 Jun 2026 18:53:53 -0700 (PDT)
Received: from localhost.localdomain ([208.115.228.234])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7f63b24a2sm82165225ad.50.2026.06.28.18.53.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 28 Jun 2026 18:53:53 -0700 (PDT)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>,
	Jason Wang <jasowangio@gmail.com>
Subject: [PATCH] MAINTAINERS: update Jason Wang's email address
Date: Mon, 29 Jun 2026 09:53:45 +0800
Message-ID: <20260629015346.17653-1-jasowang@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PP_MIME_FAKE_ASCII_TEXT=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Update maintainer email from jasowang@redhat.com to
jasowangio@gmail.com and add corresponding .mailmap entries.

Signed-off-by: Jason Wang <jasowangio@gmail.com>
---
 .mailmap    | 3 ++-
 MAINTAINERS | 8 ++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/.mailmap b/.mailmap
index 34c092714a..8ade2eed66 100644
--- a/.mailmap
+++ b/.mailmap
@@ -31,7 +31,8 @@ malc <av1474@comtv.ru> malc <malc@c046a42c-6fe2-441c-8c8c-71466251a162>
 Aaron Larson <alarson@ddci.com> alarson@ddci.com
 Andreas Färber <andreas.faerber@web.de> Andreas Färber <andreas.faerber>
 fanwenjie <fanwj@mail.ustc.edu.cn> fanwj@mail.ustc.edu.cn <fanwj@mail.ustc.edu.cn>
-Jason Wang <jasowang@redhat.com> Jason Wang <jasowang>
+Jason Wang <jasowangio@gmail.com> Jason Wang <jasowang>
+Jason Wang <jasowangio@gmail.com> Jason Wang <jasowang@redhat.com>
 Marek Dolata <mkdolata@us.ibm.com> mkdolata@us.ibm.com <mkdolata@us.ibm.com>
 Michael Ellerman <mpe@ellerman.id.au> michael@ozlabs.org <michael@ozlabs.org>
 Nick Hudson <hnick@vmware.com> hnick@vmware.com <hnick@vmware.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 72357df7c4..6160d86825 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2275,7 +2275,7 @@ F: hw/char/
 F: include/hw/char/
 
 Network devices
-M: Jason Wang <jasowang@redhat.com>
+M: Jason Wang <jasowangio@gmail.com>
 S: Odd Fixes
 F: hw/net/
 F: include/hw/net/
@@ -3448,7 +3448,7 @@ F: include/qemu/qemu-print.h
 F: util/qemu-print.c
 
 Network device backends
-M: Jason Wang <jasowang@redhat.com>
+M: Jason Wang <jasowangio@gmail.com>
 S: Maintained
 F: net/
 F: include/net/
@@ -4045,7 +4045,7 @@ F: target/i386/igvm.c
 
 VT-d Emulation
 M: Michael S. Tsirkin <mst@redhat.com>
-R: Jason Wang <jasowang@redhat.com>
+R: Jason Wang <jasowangio@gmail.com>
 R: Yi Liu <yi.l.liu@intel.com>
 R: Clément Mathieu--Drif <clement.mathieu--drif@bull.com>
 S: Supported
@@ -4480,7 +4480,7 @@ F: subprojects/libvfio-user.wrap
 F: tests/functional/x86_64/test_vfio_user_client.py
 
 EBPF
-M: Jason Wang <jasowang@redhat.com>
+M: Jason Wang <jasowangio@gmail.com>
 R: Yuri Benditovich <ybendito@redhat.com>
 S: Maintained
 F: docs/devel/ebpf_rss.rst
-- 
2.54.0


