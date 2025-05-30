Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B5F5C54F30
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:15:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtvR-0008F0-Mg; Fri, 30 May 2025 03:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtvQ-0008Eh-3B
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:13:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtvO-0006oA-Cf
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:13:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rt0eddSET8TsQkzt6gddNyhEsfEq4B60hTzxAZmgf9w=;
 b=Z5np2JR/RX6PvxaH2EcIOGM4j40fLBuIKcTYcBeok0BdESp8v0jpv6Uaa+LrYkV7EzpcHQ
 eB9rFDcB0bbownLBG6v7JwHi4ulMyzMDdP9DQC+qKg1PRIacC6ufWWAoxABxsg4hdCf7og
 pqXO1Q3hAuzNM58NTvgR133Mobh+rGE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-VM40-wheNuOTXrT1UxptbQ-1; Fri, 30 May 2025 03:13:03 -0400
X-MC-Unique: VM40-wheNuOTXrT1UxptbQ-1
X-Mimecast-MFC-AGG-ID: VM40-wheNuOTXrT1UxptbQ_1748589183
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ad9a8a5ecc6so186260066b.2
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:13:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589182; x=1749193982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rt0eddSET8TsQkzt6gddNyhEsfEq4B60hTzxAZmgf9w=;
 b=Kxet+FNf0sLehT8Q+9osBCz7hNY+B8RW5x/kEqjnKl2W9MnNWs5b3QnbID/UcIqRqK
 eOaAE535/ou0K3FDt3Gdk9RBwXtOFipm5G36Br3Fm9jibpMJQkS6DKNuYgFUbXscQZEU
 RvqPvudblQvpP1dVrkIgV2gptUFBmc58YaZ1hFcgsvHb+af8nRkTkXNNHBn9wpFG0J50
 qdjiQwUugvQxuhZuz05P1PfAyZcnI2z2/RKUVGcij+p8vkqyFImjkUSi7f+mXbwB1EtD
 aScnDSMfWogvpo8RE4xEEszYWSEmcsgTxkjLxB3aJQmSeYXF62VEvIEbHzMVGhADb5d5
 JqNA==
X-Gm-Message-State: AOJu0Yx0lKTaBITzEgVUTL+Z6PO4bjpU92IiVmokyiUBMTRhkiivz6L0
 96CHZYT6NKqidAyO9CqrSl83kV2mYLsnI2MO4JaL2e3lTerv4T4VtSph7hqZd5+XZRXfWjmtQvL
 2EOTevpGP0wwNh5jFMo1dvAt584OUBLrVsYmS0M1HKzajhcXCHpqxxVPvyASw6dWhwX/ZMeXzeo
 RQ+cr8cXn3k/3RrNTsIY5MAY26414KTXVTh+ZMiqX8
X-Gm-Gg: ASbGncvVophqsYAg/PgZbQmYX4BnHpkYEBV2m+Sy6Qy5DUBnQDlQF4GRl/lU1tRyKWU
 IMEgSzDPLRmbxM7uiCCSxvbwANrby5LGiQfxg7YhCkAJojGlxa8Q/bHFNzcEHWU6tfQQ8T0TE98
 AxDrAf78oC66ytT0iwlBAtFm0/ZscXv4mcyBiA75+gZMn+Szmlm+vOvWh9a2AZ+ZvCDOnI8C1M3
 4MxB6GZRwfNCsW8bRFrYv8qXByCe7M5mSm1M7OegxesyqACm3/PCXsbYqwGkw9G7B8e8PqTkCfy
 7hzkCuxob3qn7Q==
X-Received: by 2002:a17:907:3d9f:b0:ad5:6928:1492 with SMTP id
 a640c23a62f3a-adb3242f4e5mr193474366b.45.1748589182304; 
 Fri, 30 May 2025 00:13:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnpWZkG/TAdsFZ54tO0tl39CZunnjAO9caz6k9BTQkVhgdMDsGAu/HT/GYiT+jabx54+6ZiA==
X-Received: by 2002:a17:907:3d9f:b0:ad5:6928:1492 with SMTP id
 a640c23a62f3a-adb3242f4e5mr193472066b.45.1748589181852; 
 Fri, 30 May 2025 00:13:01 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d7fee13sm274322966b.26.2025.05.30.00.13.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:13:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 04/77] meson: apply target config for picking files from
 lib{system, user}
Date: Fri, 30 May 2025 09:11:34 +0200
Message-ID: <20250530071250.2050910-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

semihosting code needs to be included only if CONFIG_SEMIHOSTING is set.
However, this is a target configuration, so we need to apply it to the
lib{system, user}_ss.

As well, this prepares merging lib{system, user}_ss with
{system, user}_ss.

Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/20250521223414.248276-5-pierrick.bouvier@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/meson.build b/meson.build
index cbb22f60d1f..79d123c50ee 100644
--- a/meson.build
+++ b/meson.build
@@ -4081,27 +4081,19 @@ common_ss.add(qom, qemuutil)
 common_ss.add_all(when: 'CONFIG_SYSTEM_ONLY', if_true: [system_ss])
 common_ss.add_all(when: 'CONFIG_USER_ONLY', if_true: user_ss)
 
-libuser_ss = libuser_ss.apply({})
 libuser = static_library('user',
-                         libuser_ss.sources() + genh,
+                         libuser_ss.all_sources() + genh,
                          c_args: ['-DCONFIG_USER_ONLY',
                                   '-DCOMPILING_SYSTEM_VS_USER'],
-                         dependencies: libuser_ss.dependencies(),
+                         dependencies: libuser_ss.all_dependencies(),
                          build_by_default: false)
-libuser = declare_dependency(objects: libuser.extract_all_objects(recursive: false),
-                             dependencies: libuser_ss.dependencies())
-common_ss.add(when: 'CONFIG_USER_ONLY', if_true: libuser)
 
-libsystem_ss = libsystem_ss.apply({})
 libsystem = static_library('system',
-                           libsystem_ss.sources() + genh,
+                           libsystem_ss.all_sources() + genh,
                            c_args: ['-DCONFIG_SOFTMMU',
                                     '-DCOMPILING_SYSTEM_VS_USER'],
-                           dependencies: libsystem_ss.dependencies(),
+                           dependencies: libsystem_ss.all_dependencies(),
                            build_by_default: false)
-libsystem = declare_dependency(objects: libsystem.extract_all_objects(recursive: false),
-                               dependencies: libsystem_ss.dependencies())
-common_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: libsystem)
 
 # Note that this library is never used directly (only through extract_objects)
 # and is not built by default; therefore, source files not used by the build
@@ -4343,6 +4335,16 @@ foreach target : target_dirs
     objects += lib.extract_objects(src.sources())
     arch_deps += src.dependencies()
   endif
+  if target_type == 'system'
+    src = libsystem_ss.apply(config_target, strict: false)
+    objects += libsystem.extract_objects(src.sources())
+    arch_deps += src.dependencies()
+  endif
+  if target_type == 'user'
+    src = libuser_ss.apply(config_target, strict: false)
+    objects += libuser.extract_objects(src.sources())
+    arch_deps += src.dependencies()
+  endif
   if target_type == 'system' and target_base_arch in hw_common_arch_libs
     src = hw_common_arch[target_base_arch].apply(config_target, strict: false)
     lib = hw_common_arch_libs[target_base_arch]
-- 
2.49.0


