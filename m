Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D3FE8FDD5
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:50:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQvK-00050p-4C; Sat, 27 Dec 2025 04:49:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQvI-0004ox-AM
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:49:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQvG-00070W-Sd
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:49:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766828958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jkqwtBez6ruMhapFvtBLLST/9OLLA0Ok8S5sc7t4FZ8=;
 b=XHXuhX/rz7Pb7Aq5+rZLxz3Ac79/KCiOReb01PhcXxojb7shxpYfDzw9IkxuKcKwdqqtRi
 vO0yBYhncx4AiIC3pBPzgNQ5Rbz3HwPqJ4Taq92WfXGGfCtDyFofD4u4IfkFhK003f0+Hf
 vNUNqxZj2le3JNZU9HdnsqgDLTDj200=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-x_kAw1gYNDScCCTCcYwV2Q-1; Sat, 27 Dec 2025 04:49:16 -0500
X-MC-Unique: x_kAw1gYNDScCCTCcYwV2Q-1
X-Mimecast-MFC-AGG-ID: x_kAw1gYNDScCCTCcYwV2Q_1766828955
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-43284edbbc8so552203f8f.0
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766828954; x=1767433754; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jkqwtBez6ruMhapFvtBLLST/9OLLA0Ok8S5sc7t4FZ8=;
 b=DWLVIHAHn4lYuyqTJAId0+5IdA2v/qXpVlZqNc7tUhwMqK69uHryWUAM/Z0898RxX5
 TCzTJA28cuZm73xbQ2PuBc5HT229GR9SjiCq+iN5QFII/Yz/REqMJ4MRmCYOwH4/+SAS
 Eu3/8PP0nYTxNgcrfXGAUFPaUxkV1rRVd9Ej72zKYYgrIIYQb+u9Nmi/qYMDlSDOvGvv
 11stxZNoxlhQif1ETJQwTB+tzhtwMWlQsDknfHwqIrB0zlbvwZn3TDt3K7RbZR73oA79
 JL6DDHlxu5Qq6Dwf+XPhqKmBz6aBVscuZ+qNPzE+KP7qLHEvXJSr4hmOwZVU26swS3st
 VJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766828954; x=1767433754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jkqwtBez6ruMhapFvtBLLST/9OLLA0Ok8S5sc7t4FZ8=;
 b=COoIiPLJUgh2lfjsfc1N/pCEce3tlgKZuVzrAYLkovWy1YG21L88+kb6gr5hVmirGb
 Sqf3UFBSV9pVAEC+4ZFfEU21VkcMnazaVnh31cdx656kke8pmuAvFuoEfICr2NMAqQaw
 jrxDODfagp+0LXYgyLYZOW04g37JNv3OxmI22yqizZJ/4bnnj8lBu6OXOuvMzWtiBf97
 e9jAJ56YGHR5DwEfLem93wr6sL2GjJxRbXoZhPmbAASP2Fkqz6/MIzmcHERHMiL/W6+w
 pNVD7aoCZZPSeGiN2TTCRDI0FAVldpyEGWbRaahu7LGDfYKhV9jRvQ9rQQBiGgrW9JOw
 tIfA==
X-Gm-Message-State: AOJu0YxDGjkvN3CUB8UYfokiC3Q8qogRRUWG7AT9KMI6N7yFArNoKeMR
 I+rKquwCXCXJei7de9z/hfXZOQEhsRYURevPiy/VSy/GsHmbwcbJTqmSjACzilviguLEnbnvRlB
 g1zOGmnvcRXZTRndBlT9PUBkGAgGjuIXLuwPfaOD/BXPf2460KPkCsGm9rD19xPHy4/DpOzjw4v
 huhzq+f9kAU+nIvBwECd9ugkZJxsb45BwWVCY6Nyn0
X-Gm-Gg: AY/fxX6516vHYxieN/XyFIuvAXeBae4H/QAYg3ENBgkGdBpsmXBJflw9TFAAZnQZXeW
 0zK2yRy45DYdej5F/g6pip5zrBxWNE9iXhlJMiKqU8ySm5QHoQUQkZN9hoQGfcRy9P3Q3MUgcPG
 rMDh7ufT4m6xhI86ryDlDOyhjz8LULoNNMms2u9dn1q50Mc7GLyaS8OwKkiq7IT0HoZDqAAWlc5
 ZfJANNFgEy9gSnYG+efTKX0lKw+hU9ZZoIYtyfEhOQZ59308nvzD9PWz1mfD10T8M8IbXrMdw1M
 i6IrlGCOM4GRt0f/JuPVhbeb22oUxxsRS7S7B+kxQFwMVwhCp0trdTj7g4NAeAG+LTNVl4xgyVk
 wGQFKJKs543P/YjvUAcoTLJx00LmyUVzpnjI+3RjTxT41mDnzApbz1dSlt4qRsERYIMjMV3gLbj
 dgSlIofn91Qfsgsss=
X-Received: by 2002:a05:6000:420c:b0:431:855:c79a with SMTP id
 ffacd0b85a97d-4324e4d3497mr30805390f8f.27.1766828954373; 
 Sat, 27 Dec 2025 01:49:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZnQi5tAiBHeXCWDImYWjbjobYpsux3c9+8TSXbKgiHckqS/lPlJEu8CNyBdEO2yi9EAs8cQ==
X-Received: by 2002:a05:6000:420c:b0:431:855:c79a with SMTP id
 ffacd0b85a97d-4324e4d3497mr30805363f8f.27.1766828953848; 
 Sat, 27 Dec 2025 01:49:13 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea1afbfsm50784861f8f.9.2025.12.27.01.49.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:49:12 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 104/153] build: do not include @block.syms/@qemu.sys with
 modules disabled
Date: Sat, 27 Dec 2025 10:47:09 +0100
Message-ID: <20251227094759.35658-30-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


