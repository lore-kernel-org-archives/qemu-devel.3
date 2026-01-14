Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D80D38FEC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 17:20:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg4X1-0007DU-Ix; Wed, 14 Jan 2026 12:19:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vg4X0-0007DK-LY
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 12:19:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vg4Wy-00057P-TV
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 12:19:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768411179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=G12U7HD1qt2fPICoBOKA56jEyJjkaqdG/Ug1Zr9+Wvc=;
 b=iVMbFuZME3iTe5LRa9kouX7TQKQK3VywuFOOyzX1pVhFw9QucKz4Rk1Wkf5GbbthDTJeAw
 JsNkw5Bid5QVy2JzT0UZQx140gRX/gcYbkiod4DNIXCo+INtJJ3vbS6SLOc4QIBsbJMgRJ
 SVlw8tz2H8SeMIkOho+R4nLjmP7U2dU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-yP0Y4LSaN6Sa40pB8lyWVA-1; Wed, 14 Jan 2026 12:19:38 -0500
X-MC-Unique: yP0Y4LSaN6Sa40pB8lyWVA-1
X-Mimecast-MFC-AGG-ID: yP0Y4LSaN6Sa40pB8lyWVA_1768411177
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47d62cc05daso347275e9.3
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 09:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768411176; x=1769015976; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=G12U7HD1qt2fPICoBOKA56jEyJjkaqdG/Ug1Zr9+Wvc=;
 b=kDoP7kRLau/kUAyUCXHCovTR45DPITkD2U4/Rf9JmtmXUhWoGLfTPYogqjUe0kbSEZ
 pEPWxylr45Z7oREkCP36lW6Wx/llBNivSGNS66KukVw0tK9myHfpgne8KTAHUE84Bv60
 OgahSnFEzc3MWylEf5KMvGOifkFKECnHBA9vqYD5Iqy0alWjWDUH4Pfca2JN1VxPTs3k
 bmeiYM39iFOIxqLPIpKlFejXCX/fm5V4k335xOjI0ALmvy2FHSZztsEDZc+A8hkvKVGl
 uO9s4ATR3s0osIEiUNTOoCTxlAyjkrq86xYMOZ+MNQmF3XB3LvvoCrCMuGAO1dnWAFBK
 ZPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768411176; x=1769015976;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G12U7HD1qt2fPICoBOKA56jEyJjkaqdG/Ug1Zr9+Wvc=;
 b=WZYlVWn5f3RSPX9PutOnbft4Ap0Rn+1DbABS2/iYVLlGQ9XpeEIcHDa5hkkZ4r8WFd
 v4jeEO9wqN9Om6EjoEhyijc+n2WJd22CWlGZvL08T8wGdSMwd4zlS3Nikr9P7Sb4zl8W
 wNp59PSLlysMmM9SIvhGq+7ScbYHwN1cHuja+xAJbC7ae73MlRgapjpm4j5qB45iNaNI
 +RAFdXRUmDSBTNFBdT0kuicPnwaFyEAva5YxJrQLn9t70CYcqD2sqvBBeTGmZCF8sJYK
 YemI4OSuPGwDdSW873yrqo2UAWmUqa35CVuOcVVaN3A2NqsAN3hOPPJDuMndFVM9zOy5
 4Jiw==
X-Gm-Message-State: AOJu0Yzq1dHKokKos0+HnCQ8iHtjI5ujHch5ASuDhaUMYYbFCCHBaKrE
 qeO+x+lE9Mz11tMxNl8ZkGDamjPfIoGoUsPCSrtfx/0wc+3KAYKYZf+onvYPfMGgQNoXTckQTXB
 KUnTveZVkOovkzWYXbZPX3wm0RPKZ/X8n7+RpQfokLm9BlKlrq47rlJ/luFxvB2SynxBdgcLD47
 D0CAD9N5LhHV0ZYWMx/JEJxpJ3YYpsSLLpBC2D7vv3
X-Gm-Gg: AY/fxX4CZ3u2R6WZenlrSVsgnzzBfxZ4UL1Gz+x8MME04RsEPh4wwBkd5157ZQ7aoVO
 kaByDsmrsAHdN3A618mMlgmDWkdf+4JmMWfOnN4H793JfsepsalR+wzSWxJMLBEDRiOUMcSEvRH
 7d0lF70RRd4b8belfNjr7Xh5/MB17TMDGBp0SHDxeE8Jn+xtnX0Cqrxo4cVRdMFiIXKcBPZfsB+
 Mpk4Jgdr8JCn5te9egvr/8f1hftlCDqAQ+iLruBMMvLwCUuwmFgKHigdXYAYIUkSEn9+nU6wmqP
 wkHtoycO2+v/EBUhbw/Wdkysq++yTdat9ZeCvPahWeSHjbh7bhMNhqmTJo4d1uc6FvXI/K+Y8ej
 HxIXhK+PNDBEhk3IlTMz7QXAvCNv7YVy5CPfH5hv6Ly4W0sDm9ljaOgkYPfz0kMOZJUUKZe0obn
 NR7oxXtVeSz6aJaA==
X-Received: by 2002:a05:600c:458e:b0:47a:7fdd:2906 with SMTP id
 5b1f17b1804b1-47ee32fd0aemr33348715e9.12.1768411175905; 
 Wed, 14 Jan 2026 09:19:35 -0800 (PST)
X-Received: by 2002:a05:600c:458e:b0:47a:7fdd:2906 with SMTP id
 5b1f17b1804b1-47ee32fd0aemr33348415e9.12.1768411175354; 
 Wed, 14 Jan 2026 09:19:35 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f428acd0csm2058085e9.6.2026.01.14.09.19.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 09:19:34 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH] qdev: add hw/core/gpio.c to libhwcore
Date: Wed, 14 Jan 2026 18:19:34 +0100
Message-ID: <20260114171934.1512674-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

While GPIO functionality is not used by user-mode emulation, it is
conceptually part of qdev - GPIO pins are included in DeviceState
independent of whether this is system or user-mode emulation.

For the Rust bindings, having GPIO functionality in system_ss causes
a problem because, for simplicity, all methods of DeviceState are
included in the Rust hwcore crate.  On Windows, rustc is not able
to do dead code elimination as well as on other OSes and this causes
an undefined symbol error, because gpio.c is not linked into the
rust/hw/core/rust-hwcore-rs-integration test binary.

To fix it, move gpio.c out of system_ss and into libhwcore.
Alternatively, it would be possible to define some DeviceState
methods also in the system crate, using for example a separate trace
SystemDeviceMethods.  For now, keep all the methods in one crate and
link 200 unused lines of code into user-mode emulators.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/meson.build b/hw/core/meson.build
index b5a545a0edd..8a96567de8f 100644
--- a/hw/core/meson.build
+++ b/hw/core/meson.build
@@ -1,6 +1,7 @@
 # core qdev-related obj files, also used by *-user and unit tests
 hwcore_ss.add(files(
   'bus.c',
+  'gpio.c',
   'qdev-properties.c',
   'qdev.c',
   'resetcontainer.c',
@@ -29,7 +30,6 @@ system_ss.add(when: 'CONFIG_EIF', if_true: [files('eif.c'), zlib, libcbor, gnutl
 system_ss.add(files(
   'cpu-system.c',
   'fw-path-provider.c',
-  'gpio.c',
   'hotplug.c',
   'loader.c',
   'machine-hmp-cmds.c',
-- 
2.52.0


