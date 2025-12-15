Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB2EAD41D74
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 07:50:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV3LT-0000Yh-2C; Mon, 15 Dec 2025 02:50:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vV3LR-0000Uo-0v
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 02:50:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vV3LP-0000jT-GZ
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 02:50:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765785010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jkqwtBez6ruMhapFvtBLLST/9OLLA0Ok8S5sc7t4FZ8=;
 b=ApMG+wYD4bLDE3mQbs91HKVM/eLNy/e9o6l4jz5KGlMPcfW7nsY3qw6YVtVKFbBPw0Q/IE
 JtHsMfhGKyzRzJvlS1C+dGBWlWBRe94HGmthye+AWX7rIGVRGRZuKqq+ufxPsv2BwmwT4O
 GxcSXYNRYJLAzqESl0PK+Qn/f8TPKC8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-MQsDLTjGNgCwqd5pJaxvJQ-1; Mon, 15 Dec 2025 02:50:09 -0500
X-MC-Unique: MQsDLTjGNgCwqd5pJaxvJQ-1
X-Mimecast-MFC-AGG-ID: MQsDLTjGNgCwqd5pJaxvJQ_1765785008
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-430fd96b440so218936f8f.1
 for <qemu-devel@nongnu.org>; Sun, 14 Dec 2025 23:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765785006; x=1766389806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jkqwtBez6ruMhapFvtBLLST/9OLLA0Ok8S5sc7t4FZ8=;
 b=EvNO2/9+Bz2HX2ZbdvPECpVG5N1rh5RoXDIlRPcENYKwsEY6+3HXJ3M/ciyZzb/FKf
 3u7SYSVVj4OHCNOWIrO2WvlkFHQlgXWZwA+xMr0Xtr6dJcIjh0t5nU9NTkCjxBv9owUN
 jf3xiIYctm//XeS71ppnzp18mRCdhMDDoIOD43DVMj7I6U0OfIlyvwR5S1OWfPdWhqAh
 G35ecghwn3YFFoss7xoVw2YC+v+X5b6myhgaaNCqEn3FYkj1Ff9dhUEOin7bappfaYSl
 7IdBCgVF9+cjXefjovkPmR4EO9QKKMLTmMyRkMIruGAtmezoTYkmneU9N7jwqduK8qaD
 OgYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765785006; x=1766389806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jkqwtBez6ruMhapFvtBLLST/9OLLA0Ok8S5sc7t4FZ8=;
 b=UNkwbbJhPA3diYptKJK8GlDT8p3ZvJhq6cP4hFQOy+uopMFBeBMhSci4qTF5NbkpOa
 X08mYp81fz/fXHmW8XyY9E+Tt9PITmNPJy42IMPfqMpv+KMIatOfh0AE43c/HuuSeP2k
 ZGZGdmU/mgBsjyUJM36ZdoaplaF6+3LMwYGQacfVYdmFLDpLzVa3rSmMLqdhUzdUYPTY
 Y7qRg1FEfeL972/KWlty8cw5s1zVshtRIpQMXdzTgM4PgKBSmhOHK0cm7ttDfaqgKise
 rm37zqTBJMMDFgLu+CjgtyqlqFQFuvlbtqI6ggUeO0HysTZAk+wYCG8GNTlL9P77aaZk
 P8EA==
X-Gm-Message-State: AOJu0YyYHWbjZbxy/AcwhZPPxwf/ntQ/L1gGq3yEpyOEUnkbNDOblxcn
 rTIH7Lpn04Z9cppixFhHuSnm8EYPz9W25+EJiyREIVhhtkGzyqqBMYfhiXtPMsogfHBQCJSJw34
 +6tNlsBdSX3HZIOmT/CqxgjRjhigPsMkyOCJlk2b3EgWfRKgVJh8+FZX8OWaVvA4edHLLbTaep9
 OcOsIG7gmIa1Vdscjth3BR6Xa/CZg4rhdrm9bf/N3U
X-Gm-Gg: AY/fxX7p8QHiHQbE0Ccuh+kwiBURawfO7WHpYq4gZoTMqZ9wVhJV0WGg0OJ+QsV1AXD
 9qHhNha45kf8NLdkrPpkePSOJRfwffqr30PKEXLac9v7mi2oWkBw6Z+XEFlLNo7cmjaFf8Nc7Id
 Ut8Ye4uIqir4zrjT416g/cQRtscKUQJanx9yjHTAWn9+Qu3WGN0riT22Kpfr8eRwoToEXLw0DlC
 iS+VwZ+oVg7Ge/2pkAaewfUA0bXKH54dpY/dRxyX1Vd2aNVMhVb/h5jLS939tHIjzcUpHWEjKa8
 7BifGJDin/wdEGeMcjT026ghRtxyPAUre0FhgU+8O4c2X3i3hsXuEIXRsClN0wk2Hyz4njFfLEe
 479XCXnlMLYiLAm6msYqVXKQ2TT8E0RgTbWBlDVgGPHd+KWA/IMsN84/2sYkjOKzMlw5EUZD769
 nYYIqigoJ8BFHF1GI=
X-Received: by 2002:a05:6000:1843:b0:42f:760a:7661 with SMTP id
 ffacd0b85a97d-42fb44ed4eamr10745120f8f.38.1765785006306; 
 Sun, 14 Dec 2025 23:50:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFk4kX/SIpFBJ6y9yNuduCLcQAXhQ0xCZpg2XdRSPw4uXX5qcx2fxE6WAxDCAvSC0YFRy0YJg==
X-Received: by 2002:a05:6000:1843:b0:42f:760a:7661 with SMTP id
 ffacd0b85a97d-42fb44ed4eamr10745006f8f.38.1765785004324; 
 Sun, 14 Dec 2025 23:50:04 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fb0fc8d5fsm20155160f8f.2.2025.12.14.23.50.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Dec 2025 23:50:03 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	marcandre.lureau@redhat.com
Subject: [PATCH 01/11] build: do not include @block.syms/@qemu.sys with
 modules disabled
Date: Mon, 15 Dec 2025 08:49:50 +0100
Message-ID: <20251215075000.335043-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215075000.335043-1-pbonzini@redhat.com>
References: <20251215075000.335043-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Including specific symbols used by modules is not necessary for
monolithic executables.  This avoids a failure where emcc does not
support @file syntax inside a response file---which in turn breaks
the WebAssembly build if the command line is long enough that meson
decides to use a response file.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/meson.build b/meson.build
index e6a11cefdb7..02738c9765f 100644
--- a/meson.build
+++ b/meson.build
@@ -4270,7 +4270,7 @@ foreach target : target_dirs
 
     c_args += ['-DCONFIG_DEVICES="@0@-config-devices.h"'.format(target)]
     arch_srcs += config_devices_h[target]
-    link_args += ['@block.syms', '@qemu.syms']
+    link_args += enable_modules ? ['@block.syms', '@qemu.syms'] : []
   else
     abi = config_target['TARGET_ABI_DIR']
     target_type='user'
@@ -4499,14 +4499,15 @@ if xkbcommon.found()
 endif
 
 if have_tools
+  link_args = enable_modules ? ['@block.syms'] : []
   qemu_img = executable('qemu-img', [files('qemu-img.c'), hxdep],
-             link_args: '@block.syms', link_depends: block_syms,
+             link_args: link_args, link_depends: block_syms,
              dependencies: [authz, block, crypto, io, qom, qemuutil], install: true)
   qemu_io = executable('qemu-io', files('qemu-io.c'),
-             link_args: '@block.syms', link_depends: block_syms,
+             link_args: link_args, link_depends: block_syms,
              dependencies: [block, qemuutil], install: true)
   qemu_nbd = executable('qemu-nbd', files('qemu-nbd.c'),
-               link_args: '@block.syms', link_depends: block_syms,
+               link_args: link_args, link_depends: block_syms,
                dependencies: [blockdev, qemuutil, selinux],
                install: true)
 
-- 
2.52.0


