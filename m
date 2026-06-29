Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A5DC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:42:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weCF5-0008R6-RZ; Mon, 29 Jun 2026 09:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1weCED-0007lM-1m
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:40:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1weCEB-00055H-EY
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:40:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782740446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Oy3wGPh4kUyBTZuM9QPlhryw0n0/N/FFI0LCYRC2luA=;
 b=VqnUIigd3kzewMTUPIQhG2usxgj5e1pgbR5cMwjXoKx6+WxYJlYuDOT2yg3nILKzxRyX8Y
 X0uHcqGmNOgj1p65nkkx6jRLDS1CatW5gT34NUAB/723NC9/bsWNV0LSZ7E7rtTeWd7hBj
 iAlJQg3pwwoSpqyjrBU/1c3zEl8OZqA=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-oi9C76q3MN2KkTQiH768Sg-1; Mon, 29 Jun 2026 09:40:45 -0400
X-MC-Unique: oi9C76q3MN2KkTQiH768Sg-1
X-Mimecast-MFC-AGG-ID: oi9C76q3MN2KkTQiH768Sg_1782740444
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2c804e38c65so36806805ad.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782740444; x=1783345244; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oy3wGPh4kUyBTZuM9QPlhryw0n0/N/FFI0LCYRC2luA=;
 b=CE+rlkNdnd2w//4dlUuxddfNnTaVnxc9NXZ1qrdT+9jc7L2iKLCvuF3Y57HCfLLRec
 tTGFANrA+yKloJRZ8nK/VZOGs5ui/JPG8K7TvCTnTDXVXQ6ZldrLRdEyMR7wuS+eKjFL
 7pRNSxT0FPhhBO1FvGffHIeCy7KBLn52Y2wygW0fqX2zJQVsprdZ4I39vlSZ+6ZyfFw+
 no5xR2LJvscLLwQLE+2Lel+1TEuQ4BKxnpXxy4UZ2BS2WXPBTpO1W+kRCjRrlW4x7gVv
 DeP/gNSRrsK0UMdzYDB4J8tj+doqm5xp9zoi+KLX1qJrE6ilKnhVP2B6Mqcq1+3KC8JI
 4alg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782740444; x=1783345244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Oy3wGPh4kUyBTZuM9QPlhryw0n0/N/FFI0LCYRC2luA=;
 b=eSEPM+T0N0JSreD/SgcaDSpBEPq9bRkmVwTaHthFYeHy6Kw+maom9sOix1t47NvlF4
 IpPoL4YyObmFQyFyuXHdmD1MsJHkF/HkhRgZFSQI6YjRzggqRP5KaYe5QPLnIVpUVrde
 rS42RexoJY6aTlyJB2CS8ogeeLHvqCVWG70UX+X2gaJGNfd+jHZUn0CMKf5116nh7SKh
 0ExCIhwPEWc4UOjVszW7kSnSBzOB5ILx0nO4/+3D2YJzaGM2f3oBRWgJCQLLMSWx8ysP
 fBNkOE4H7NoyAK/U4AMCGbAMrINfYtVpi0FA7j0u6R5fvpcVr4wLsLgjZvtnODnHL1Ns
 ttvQ==
X-Gm-Message-State: AOJu0Yxwj0ho+0bE4h/mbZgTfoFNkjBcY+j7WtzVo7t/5IOjiApTFcia
 2es8eUYBIulZfri1r6NxD5PI9OL4AavHTI0/G7qpPyKT2LJfQeP8WprE2QvczzTnvgHqMCzScp2
 tJ+VBcg+U60xyvYgy1ffcUhvzC0gLEAboCq5OLKgrTHZfHDurdmWZ5u1ZrW6VgZsBy80j3McY+F
 yG29UwIciXJjh/25SI4OoaxGRr9obIzeKwMSnob/XM
X-Gm-Gg: AfdE7ck5JbkgZ96DUpu0W4KHQ6sHE9sEYdJlzTHN/C0Ask0K33gUt3okoLgt/Jix5Wf
 64Bq578CUijzqN9RxJQga+n1iLm6g2xnMwDTRF5+AEuKkyfcc8pKikbPsZigrVFdfv9CScPZe2T
 BwK32gAVLI+DDj1asdnusQuHee6Jkqne1EX/wsukoeJ0vtBOtvdewA7acWiw8HXeYMxJ28veiHD
 a3BdS3RFbwmRY2Uird4tpLMjpztAWH4X0BlcDt7RehVgMFM8fjs9TMGhSZuYL+Ji9wgKAIivnSA
 NeJaNQd4ufGe3YgHABrxsfWtuC25SFGVpeHSajfXq/t0wKFkjL4+cQfzmKwpgKO4KKaGSoiHBkB
 NfCazu1ZVS9uIEPhGMHaj0Q==
X-Received: by 2002:a17:903:46c7:b0:2c9:b3ad:7a39 with SMTP id
 d9443c01a7336-2c9b3ad7d67mr74932725ad.4.1782740443862; 
 Mon, 29 Jun 2026 06:40:43 -0700 (PDT)
X-Received: by 2002:a17:903:46c7:b0:2c9:b3ad:7a39 with SMTP id
 d9443c01a7336-2c9b3ad7d67mr74932305ad.4.1782740443170; 
 Mon, 29 Jun 2026 06:40:43 -0700 (PDT)
Received: from localhost.localdomain ([208.115.228.234])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c9a93d5ebdsm48626505ad.74.2026.06.29.06.40.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Jun 2026 06:40:42 -0700 (PDT)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: jasowangio@gmail.com,
	Jason Wang <jasowang@redhat.com>
Subject: [PULL 1/1] MAINTAINERS: update Jason Wang's email address
Date: Mon, 29 Jun 2026 21:40:32 +0800
Message-ID: <20260629134033.31893-2-jasowang@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629134033.31893-1-jasowang@redhat.com>
References: <20260629134033.31893-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PP_MIME_FAKE_ASCII_TEXT=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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


