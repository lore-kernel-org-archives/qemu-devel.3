Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D9D5D24469
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 18:12:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRDnX-0001RP-V1; Thu, 04 Dec 2025 13:11:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vRDnW-0001RH-PB
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 13:11:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vRDnU-0007lL-Vc
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 13:11:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764871879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=vkue+VHn2ePw24UhItsn434TwU+DFHbw15254AP7N/E=;
 b=i1YHyZY+8gZNTb34R0o3dx+OgaOwsg7ew1rV/HaPnb5mJ0tDMplATZXrNaz0aVMDd+h1SC
 Zjf3r89W+F0omx5V/ucRLRsM+tuZ7GUPbNOAEeS+eBm/PUuBU87c/duANTMGsG7noJY2wh
 V3yvECUuTzvh7kT1tt1KBIVP1702T7g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-lkQ8_pxUO5aw22_BYZg7Qg-1; Thu, 04 Dec 2025 13:11:16 -0500
X-MC-Unique: lkQ8_pxUO5aw22_BYZg7Qg-1
X-Mimecast-MFC-AGG-ID: lkQ8_pxUO5aw22_BYZg7Qg_1764871875
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477a1e2b372so9622995e9.2
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 10:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764871875; x=1765476675; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=vkue+VHn2ePw24UhItsn434TwU+DFHbw15254AP7N/E=;
 b=DhU9tVsPp0O5Lqiojdhdt/l3knSDEnC2CebKKYw72E8iA9slPz0GKEO6U9hc6JMZKb
 7ZUO0sXgU9ONpi+wQsdioUDPTH43yEewlFOzpGiwGm4soJiThBpkc5IEn0qutEjLbv2Z
 X/kc0CfVuPpl7YG5GE+lwaqUNO2wN0OXJdZ2e1EYu9NHHTAlOLVq7orItRE4Qm12vd96
 8hCNeMALsWI7a7uKEMgFrmWdC6gtFhrmVcqP0rI+gZvGDZjDk1YEl4PhZ2Oa5JwvwnS9
 WorvjGIoQPwZrdpeQoEPGWVdOU/vlbbC6iQ/l57Uno/tYJO+Xq3m9zRgMnfxI5ukCRPo
 j9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764871875; x=1765476675;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vkue+VHn2ePw24UhItsn434TwU+DFHbw15254AP7N/E=;
 b=JqH2cobYib8lGHF/PLBn5PN6Mv6tToGjwLI7H1hOBNBs0H1OZZk+u/rUQKNdwlUeav
 In8XjEneutj7+4k8NcTRXbhCfWmcSOklRwHhDhLMQn4EAMfuKnU9YZamMg8r7XtZAzaq
 HTFh+FD5/Kz8DCkAtWqqeadBxy95ifaxy36f4/RGVLLSvCTaRD91hdhd39Bahmbj9dEk
 ZPp7NtOnnm+qslyoUCBZaALU5VBxP4tm5g5GLOQux6N8ser5liISw36z+Wcri9iMG27f
 c4RvY3EbqukI2FmjtyyoDgNAURVUMjJsl3RWgFzRzm1LtoeW7RD1exGa4i/gw4Hb2CNZ
 Pz4g==
X-Gm-Message-State: AOJu0YwEZ1kq9J7gtJDSfyKuDf0jFxtMV0V4cxnJYJ0XsKEmnREbmNY4
 uiwPkCzpHyk5Re6JrjoV5ZQXaCOFuHIgZTeMp0LnTUE40NbPfkSgeNhhWCAzGw/5+7l6r4CaE3q
 4ky6dSHVgCoAznosxdLpDxWt8IsY2ztyDZ4Ulach9nu3H0dgeVRqJ2WLl4KD8xtGsSrRJd4rLr0
 t5tOdo/7jW2uzfTlK39QsEiRx+nUHnOJlMvfpvjoA/
X-Gm-Gg: ASbGnctimVNfgSwtaFcerygKCGArEScZlNk2hl8dmM7NutSlTGvq/b6P6+6qnSuzoCe
 m56xl0CUsWzFGlF6h3cY2BBLRMJI71/z/IwldcWk8KZI7toTG1fYtjjigaM0XuT27vnjqVOPW/b
 wimvKCpt6Tv8BGVEHWEWoanAudKnzy0J849Nl6GSqmkZj81vEqHr4qt4MoxYT9hLe8TbPltp8Xk
 IaGoLugtkXirPtHTQSeGeIOLqHIOFmHMP56tv3qoU5fb1Ru9elXjq7iHdUXxwPioVb1RtpZj0nR
 0YkeC16ZgDaX+OiGGfb0wgtXL6KSG9k7i1bRU98450K2eP7W8Sz3tasDqDyk0lI7Xx7Qcqr9r5d
 qaMLAYJ/EGfLBzk8rpy5fKIXBmiJIk3pZXJ0gt3637WSscO++AG+iGxhZEtR0JJ1mj8MTJytDcj
 Ur41LzFOn6h+0=
X-Received: by 2002:a05:600c:3ba8:b0:477:755b:5587 with SMTP id
 5b1f17b1804b1-4792aeeb522mr72362215e9.8.1764871875026; 
 Thu, 04 Dec 2025 10:11:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPqFM+bbGKTlqj81CNm8bBQsYTTXaWMqhWl3bKqYf/p4eCUAXJbtI1Jvg9e5xu5erZbiEBIg==
X-Received: by 2002:a05:600c:3ba8:b0:477:755b:5587 with SMTP id
 5b1f17b1804b1-4792aeeb522mr72361835e9.8.1764871874389; 
 Thu, 04 Dec 2025 10:11:14 -0800 (PST)
Received: from [192.168.1.84] ([93.56.161.42])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4792b02e84dsm43000865e9.4.2025.12.04.10.11.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 10:11:13 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] build: do not include @block.syms/@qemu.sys with modules
 disabled
Date: Thu,  4 Dec 2025 19:11:13 +0100
Message-ID: <20251204181113.36862-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
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
index e6a11cefdb7..df1067b4067 100644
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
+  link_args += enable_modules ? ['@block.syms'] : []
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


