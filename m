Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2CB7C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 10:00:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPJEK-0006Rj-MB; Thu, 04 Jul 2024 05:58:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sPJEJ-0006RX-L8
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 05:58:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sPJEH-00085j-R2
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 05:58:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720087097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kId3BsrX4Ck23yi00sPWp4rXEyQ/RKL0+nMr7yxJA3E=;
 b=BdYSh3ps764deqnFQRdEMV6yoEzAG5ys3zDK2cdRxuq8yYHA0J8gpF+oyt16igR/zAmPwM
 5LuzMrZ2m9vO1gcQTkpDJ7iNC846f0OVr4tFelVbGTiedhvtvDY2+GXikcZkOx4t+mK+fW
 XG7qNPEedRbQUg8KK5x93x1KWp12zrw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-3HPYNIgbNuGeESIIJ7SiPw-1; Thu, 04 Jul 2024 05:58:13 -0400
X-MC-Unique: 3HPYNIgbNuGeESIIJ7SiPw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-36789dfcc8bso315917f8f.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 02:58:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720087091; x=1720691891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kId3BsrX4Ck23yi00sPWp4rXEyQ/RKL0+nMr7yxJA3E=;
 b=qsjZu+jJ7NaXq4IUwPm2PBaGqmoK0xBvCfN+Hre621B5bwPJvrus/a0fqGeQS34X6H
 wO+8SAO6FBPHqb/Me6ppSdFxOWbqwcHH5bIW+qb3uf4L5vLo3V4T/XjHuQl1oZ0UNNee
 eTwdMwX9wF4WLmsE1Y2nOK5GA4JucZ/H0Z7pdBTSTNwpsTeRjnhILMLci1eP1XM0jXw3
 uPQRXozBpObmjqNnlwxdFecLs/tHQZg1ePdIo+npb4lsv/WZH2ADhAmMwD3ygI9bPP+h
 1Ky+QcZSa+eS26d3i6UmTckHnA2AfB1Nkn9JdQjTSJfSRYsMo+R+Z7bMmQFn826ceEXu
 LnIw==
X-Gm-Message-State: AOJu0YyCrA0EngQNghEcHqXmN+lPQ9m2g4D3iqEaxzm70V9R7PEDNSl6
 beZbtapO4cPIJ0az8du0XIF6XBhExiZ6VGhF3yrR5n21TvnOvRURbUixvp9A9quMGuJsjX/fAh1
 J0mIs4lO/IE2LTC+kOV7SBkL66GMtl706Fc91tRg8ue3xnL6A/Q27V+rk2oUmyRvd+5SYDTbFE5
 lLrYZTjzzNhHAiK9pJ2iYb99FHPtTZW+i3A+AT
X-Received: by 2002:a5d:5265:0:b0:367:9ce3:1667 with SMTP id
 ffacd0b85a97d-3679dd3c4eemr790905f8f.15.1720087091646; 
 Thu, 04 Jul 2024 02:58:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeIBN4e10hTzkoF1vYyI+5msU11MqQiDjJ4Cx/B+73man6fZLx1eAV1rhWa2HBeFQ5Zo3YoA==
X-Received: by 2002:a5d:5265:0:b0:367:9ce3:1667 with SMTP id
 ffacd0b85a97d-3679dd3c4eemr790891f8f.15.1720087091198; 
 Thu, 04 Jul 2024 02:58:11 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367956ca37asm3443591f8f.75.2024.07.04.02.58.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 02:58:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/16] meson: move block.syms dependency out of libblock
Date: Thu,  4 Jul 2024 11:57:52 +0200
Message-ID: <20240704095806.1780273-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704095806.1780273-1-pbonzini@redhat.com>
References: <20240704095806.1780273-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

In order to define libqemuutil symbols that are requested by block modules,
QEMU currently uses a combination of the "link_depends" argument of
libraries (which is propagated into dependencies, but not available in
dependencies) and the "link_args" argument of declare_dependency()
(which _is_ available in static_library, but probably not used for
historical reasons only).

Unfortunately the link_depends will not be propagated into the
"block" dependency if it is defined using
declare_dependency(objects: ...); and it is not possible to
add it directly to the dependency because the keyword argument
simply is not available.

The only solution, in order to switch to defining the dependency
without using "link_whole" (which has problems of its own, see
https://github.com/mesonbuild/meson/pull/8151#issuecomment-754796420),
is unfortunately to add the link_args and link_depends to the
executables directly; fortunately there is just four of them.

It is possible (and I will look into it) to add "link_depends"
to declare_dependency(), but it probably will be a while before
QEMU can use it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                | 5 +++--
 storage-daemon/meson.build | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index 8909f8c87d9..df9a64302f0 100644
--- a/meson.build
+++ b/meson.build
@@ -3759,12 +3759,10 @@ system_ss.add(migration)
 block_ss = block_ss.apply({})
 libblock = static_library('block', block_ss.sources() + genh,
                           dependencies: block_ss.dependencies(),
-                          link_depends: block_syms,
                           name_suffix: 'fa',
                           build_by_default: false)
 
 block = declare_dependency(link_whole: [libblock],
-                           link_args: '@block.syms',
                            dependencies: [crypto, io])
 
 blockdev_ss = blockdev_ss.apply({})
@@ -4033,10 +4031,13 @@ endif
 
 if have_tools
   qemu_img = executable('qemu-img', [files('qemu-img.c'), hxdep],
+             link_args: '@block.syms', link_depends: block_syms,
              dependencies: [authz, block, crypto, io, qom, qemuutil], install: true)
   qemu_io = executable('qemu-io', files('qemu-io.c'),
+             link_args: '@block.syms', link_depends: block_syms,
              dependencies: [block, qemuutil], install: true)
   qemu_nbd = executable('qemu-nbd', files('qemu-nbd.c'),
+               link_args: '@block.syms', link_depends: block_syms,
                dependencies: [blockdev, qemuutil, gnutls, selinux],
                install: true)
 
diff --git a/storage-daemon/meson.build b/storage-daemon/meson.build
index 46267b63e72..fd5e32f4b28 100644
--- a/storage-daemon/meson.build
+++ b/storage-daemon/meson.build
@@ -8,6 +8,7 @@ if have_tools
   qsd_ss = qsd_ss.apply({})
   qsd = executable('qemu-storage-daemon',
                    qsd_ss.sources(),
+                   link_args: '@block.syms', link_depends: block_syms,
                    dependencies: qsd_ss.dependencies(),
                    install: true)
 endif
-- 
2.45.2


