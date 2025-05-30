Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB4B5C54F30
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:17:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtvY-0008GJ-C0; Fri, 30 May 2025 03:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtvV-0008Fs-3Q
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:13:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtvT-0006ob-Ed
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:13:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x9Qiw9/YXri1KnMzbUzTnIRkOWa6GS585f0+J5lbOu8=;
 b=HFwebqxLbYt/Fz9PP4czzYdRVMWMySVNMvvRh2FBHhvsnKXwoxqCc4F5pfJ4HO10uSrfO6
 xZYwtEW7spMNP0QHO2LhaWBlT46gq8xGW5YwzjwAr6JgUrkwbUGCvAT6eSCuNcMrW+AbSs
 tNkRqaBPjOAec3y9G12/D2yeUpV7lx0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-FuwmfpuyPhOJ7l3m8YTpVA-1; Fri, 30 May 2025 03:13:09 -0400
X-MC-Unique: FuwmfpuyPhOJ7l3m8YTpVA-1
X-Mimecast-MFC-AGG-ID: FuwmfpuyPhOJ7l3m8YTpVA_1748589188
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-601f3f35b88so1668360a12.1
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:13:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589187; x=1749193987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x9Qiw9/YXri1KnMzbUzTnIRkOWa6GS585f0+J5lbOu8=;
 b=l/EgbM6ejWiXXoJBubRVVIWxhVBn+UnakazpUU03FY5oXEfZzj6z9UrjcmXDjiNU+N
 LffCSCtPTd4CtBZnrQmaMlgrcVqY+xGDJL4dzpXA5FZFu+5FEifpCJirm7/p09DonmNP
 T6rwTxBtnt4dLz25fjtkfvP/7NeoXCgr2RebeZ2vwcihb96BdXamcyG9QCo4jmKhGyB+
 RDmDGZaMZM/KtObqi1lhcyU1GhHUhkMOrKT8Dtr18KXPoUJTtgS3U7xZf6aA08L84SVT
 5eeRJl3QS88Bk4YVlk8wfktKnsNvAngvq3mElxSS4jmTb5Nnd0LzSuNw5q52WYfGIQAR
 JzGw==
X-Gm-Message-State: AOJu0YyhRO9ABTwRYN/t8ZDGf+xglvVH0laMhY0WhhZYSo7gxFC1S4Or
 tfI4Dz6F4kG6vpgsRGxaxo6LZi9QIN5hid69H2NqR+80FyY88FGcNlHOiLkTGtkNbQ82FuNySqf
 /7RNG0CR7xYBKqwUDO1zSeRoUZqAGTGEnxzVlqnznOssubuK8XT2U2qlquSusZ9sFiMbqyda3Cj
 t/xzQnpuR4ppU717/BgyPvMlNXhX/otuQhzIGXxjUq
X-Gm-Gg: ASbGncv1ORoNDTh5LjblO41KYpZ+CBiXWmFfPp7oHHqSm52DznSevPETlqrvHYMfYb8
 atoYNMBORLlXrq35ikfabUnzgGf6l/xm93G1bqEwVYArD1//N5hGj3i2+V3s7lp6pXJsGDXAmBl
 RcCXTz7Ihh/Wy2VPtW5mk5Jq/BxuHFoTR9L3ppaJPNgcn20jv56ewB2zwVFdvFz+uUT+uMGz/G9
 fbN2TPCxnoNzNgovWE1PsaBEWeOZxK0f4ZoXLyg8R29zI85XYPzYGccGXVkA3ajqB4qaaO0FB5z
 iVUzaU80WQdhNg==
X-Received: by 2002:a05:6402:4313:b0:5ff:abf8:3563 with SMTP id
 4fb4d7f45d1cf-6056db32012mr1814547a12.14.1748589186977; 
 Fri, 30 May 2025 00:13:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZBk7FO0z+s1iE8DMTZGPvlGv3oxKwCNuTlYiSWnz7Rn3SjHcJwHTRDDA3qYfxQyfXKjexaQ==
X-Received: by 2002:a05:6402:4313:b0:5ff:abf8:3563 with SMTP id
 4fb4d7f45d1cf-6056db32012mr1814520a12.14.1748589186512; 
 Fri, 30 May 2025 00:13:06 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60566c2a0d2sm1187414a12.5.2025.05.30.00.13.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:13:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/77] meson: remove lib{system, user}_ss aliases
Date: Fri, 30 May 2025 09:11:36 +0200
Message-ID: <20250530071250.2050910-7-pbonzini@redhat.com>
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/20250521223414.248276-7-pierrick.bouvier@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build           | 2 --
 accel/tcg/meson.build | 8 ++++----
 gdbstub/meson.build   | 4 ++--
 hw/core/meson.build   | 4 ++--
 plugins/meson.build   | 4 ++--
 system/meson.build    | 2 +-
 tcg/meson.build       | 4 ++--
 7 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/meson.build b/meson.build
index ea54d15f4a6..1c9f1aa91e7 100644
--- a/meson.build
+++ b/meson.build
@@ -3694,14 +3694,12 @@ io_ss = ss.source_set()
 qmp_ss = ss.source_set()
 qom_ss = ss.source_set()
 system_ss = ss.source_set()
-libsystem_ss = system_ss
 specific_fuzz_ss = ss.source_set()
 specific_ss = ss.source_set()
 rust_devices_ss = ss.source_set()
 stub_ss = ss.source_set()
 trace_ss = ss.source_set()
 user_ss = ss.source_set()
-libuser_ss = user_ss
 util_ss = ss.source_set()
 
 # accel modules
diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 97d5e5a7112..575e92bb9e8 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -18,15 +18,15 @@ if get_option('plugins')
   tcg_ss.add(files('plugin-gen.c'))
 endif
 
-libuser_ss.add_all(tcg_ss)
-libsystem_ss.add_all(tcg_ss)
+user_ss.add_all(tcg_ss)
+system_ss.add_all(tcg_ss)
 
-libuser_ss.add(files(
+user_ss.add(files(
   'user-exec.c',
   'user-exec-stub.c',
 ))
 
-libsystem_ss.add(files(
+system_ss.add(files(
   'cputlb.c',
   'icount-common.c',
   'monitor.c',
diff --git a/gdbstub/meson.build b/gdbstub/meson.build
index b25db86767e..15c666f5752 100644
--- a/gdbstub/meson.build
+++ b/gdbstub/meson.build
@@ -5,13 +5,13 @@
 #
 
 # We build two versions of gdbstub, one for each mode
-libuser_ss.add(files(
+user_ss.add(files(
   'gdbstub.c',
   'syscalls.c',
   'user.c'
 ))
 
-libsystem_ss.add(files(
+system_ss.add(files(
   'gdbstub.c',
   'syscalls.c',
   'system.c'
diff --git a/hw/core/meson.build b/hw/core/meson.build
index 547de6527cf..b5a545a0edd 100644
--- a/hw/core/meson.build
+++ b/hw/core/meson.build
@@ -26,7 +26,7 @@ system_ss.add(when: 'CONFIG_XILINX_AXI', if_true: files('stream.c'))
 system_ss.add(when: 'CONFIG_PLATFORM_BUS', if_true: files('sysbus-fdt.c'))
 system_ss.add(when: 'CONFIG_EIF', if_true: [files('eif.c'), zlib, libcbor, gnutls])
 
-libsystem_ss.add(files(
+system_ss.add(files(
   'cpu-system.c',
   'fw-path-provider.c',
   'gpio.c',
@@ -46,7 +46,7 @@ libsystem_ss.add(files(
   'vm-change-state-handler.c',
   'clock-vmstate.c',
 ))
-libuser_ss.add(files(
+user_ss.add(files(
   'cpu-user.c',
   'qdev-user.c',
 ))
diff --git a/plugins/meson.build b/plugins/meson.build
index 5383c7b88bf..b20edfbabc1 100644
--- a/plugins/meson.build
+++ b/plugins/meson.build
@@ -61,8 +61,8 @@ endif
 user_ss.add(files('user.c', 'api-user.c'))
 system_ss.add(files('system.c', 'api-system.c'))
 
-libuser_ss.add(files('api.c', 'core.c'))
-libsystem_ss.add(files('api.c', 'core.c'))
+user_ss.add(files('api.c', 'core.c'))
+system_ss.add(files('api.c', 'core.c'))
 
 common_ss.add(files('loader.c'))
 
diff --git a/system/meson.build b/system/meson.build
index c2f00827669..7514bf3455d 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -7,7 +7,7 @@ system_ss.add(files(
   'vl.c',
 ), sdl, libpmem, libdaxctl)
 
-libsystem_ss.add(files(
+system_ss.add(files(
   'balloon.c',
   'bootdevice.c',
   'cpus.c',
diff --git a/tcg/meson.build b/tcg/meson.build
index bd2821e4b54..706a6eb260e 100644
--- a/tcg/meson.build
+++ b/tcg/meson.build
@@ -27,5 +27,5 @@ if host_os == 'linux'
   tcg_ss.add(files('perf.c'))
 endif
 
-libuser_ss.add_all(tcg_ss)
-libsystem_ss.add_all(tcg_ss)
+user_ss.add_all(tcg_ss)
+system_ss.add_all(tcg_ss)
-- 
2.49.0


