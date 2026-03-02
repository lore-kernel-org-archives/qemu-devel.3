Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFECED58E7F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:45:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwytE-0001j7-8R; Mon, 02 Mar 2026 03:44:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyt9-0001hU-SS
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:44:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyt3-0001XP-Tj
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:44:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DjHOs1Bdw3tpUt85OROmin9Qv7K0zbnwvkrQQLrQkzU=;
 b=cqltAYZUe0FmAqmKBJdmWaShu6lsW5Rn4PN4QZ3BVERBwg1UQTBoTpgdixFxy63jNBpIet
 u86NXVQMHQ8i9dl3JYrqoHqvvWLJwHYD5dPfe6UcVQB8mQv29c2aHCuFUdk1w7XiJUuzhx
 74gs+5THHrejehfgL/Df+10H4tVXEis=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-uBK7c6CjPouL4yamQMvVzA-1; Mon, 02 Mar 2026 03:44:18 -0500
X-MC-Unique: uBK7c6CjPouL4yamQMvVzA-1
X-Mimecast-MFC-AGG-ID: uBK7c6CjPouL4yamQMvVzA_1772441057
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4836c819456so28161155e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441056; x=1773045856; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DjHOs1Bdw3tpUt85OROmin9Qv7K0zbnwvkrQQLrQkzU=;
 b=Br7xh/6RgQXCLu+Vvm3kF1e8frR23JTLNKgp38TriCg4UoAg2KvQGzCzEXpQJ661f6
 eSS/nybDrxiZh4LOeF5Ei/My2q18wXQiJRoOy41c4PtG8b4ipwesKHChZ81PwdGucByI
 TXRjg7HXb7KWxcA/5QNfipiH5ezUS2UJ/po9T3xzYD1xBeh8YMG4mOhf7yfrZAM0qpv8
 +qDFwjYes2OGOglSIAGauBDLtyjLBQ+dlJ9y0e/oN+QHVPTtqt1lKvKCWfrAOkhhMR/t
 Aa0UCk+f+Rdkz6HVMONBDlAF1wH5C+blzcYyp4AGY0Ynr6AFCGWUf7UUHfWq1HsuJD95
 6ykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441056; x=1773045856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DjHOs1Bdw3tpUt85OROmin9Qv7K0zbnwvkrQQLrQkzU=;
 b=MYtKC0IhcFcHoypwCV8KF1+RQeTcDhJ2h241XHT487kGBRUnewhtHtzCkpYvcyaB6z
 3sE93LVh61C0ROV/SfhqdSPiLwcG2+Cu5GQOhuajGxqCvbGpbqzVcLJzmgswSpn2MIqQ
 0l3M8ZMOYIWPta1Wb8/jCeoLSW4jBBuKkn9E0QEjA0Vy4lUzcj9c1Aymj/AmMqejeTgf
 NBkcAzefv8AXS7J4AAgQFMyFULz6c4eQVc8PcrhQ79V325pbh1zPPa/9KbW0HOJY3rVs
 pvDpARpc5P5Z0QHaJ8VXyl5wm2p6taxAAGeaNsnpzDmY0UJTbBB2e8arTQ8hihypy3dT
 ioeQ==
X-Gm-Message-State: AOJu0YxZNBavjmrPpvOe19u904sNpYEcnGekY88jQxldBg+/Wc1qogrR
 2NiNedfqKv0XijMGAjvF6NPGx4/e9LA3H7xaa0cjBSxRGvqy5awUJexBA9EetcnkEQ/M2hN18Sc
 IsVhyx6jQwwbvr/fK4sEBZeDj8tj0OLZzeiCKjteUIg4xbimdffjltI9nroud7J8XOQqMLtYJWd
 1dpOkuIO/W3/Jhjrur8NBG/bO6bXz0x/i/veqDNvgF
X-Gm-Gg: ATEYQzwILr0lbBcEy9eZ7j1MxRRDC5wMpx0eFlYzkjPgGnqruqqHyiTXep1dpl6PlK3
 kvvNFov3rgpbkYApJRWNyb5x5iKoY0a9jxHI16OQBlBWrUj8I3NzXukhSbR6VI3lt+LFx+h/3hI
 42LnFmRcF4Oo2gT1GWj6tJLYflgdmgpg4mML4gAhhoY1GG8x3fDTZrWpO2KuQQl+lY36vA1PVq0
 L4wAUqO1zvHgUAJJjA246VmoVPnfbSZh+yQohC6YOo5Dq56JMmdspaaoFNso9nD64cxNe5Nfjnf
 g7adPb6Cz8VKEHY2LzAhnZJCksqDN69Mic6WDHYywQ6Mje0BqOBJIYkw90gaDFLq8gSPZ0BeHT+
 OqGdQeULKAsE4zr7Wli2GMMsBNld/HoUg4qQ/1YR4lsEkyidkbOR+AdXDiK8KqsLNvxj9zCtvjM
 GykLLpBG962Keo0wVA8uECMhrbrGI=
X-Received: by 2002:a05:600c:b90:b0:483:abeb:7a5c with SMTP id
 5b1f17b1804b1-483c9bdb600mr202112065e9.12.1772441056244; 
 Mon, 02 Mar 2026 00:44:16 -0800 (PST)
X-Received: by 2002:a05:600c:b90:b0:483:abeb:7a5c with SMTP id
 5b1f17b1804b1-483c9bdb600mr202111765e9.12.1772441055752; 
 Mon, 02 Mar 2026 00:44:15 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd750701sm413730355e9.11.2026.03.02.00.44.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:44:13 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 013/102] whpx: i386: remove remaining winhvemulation support
 code
Date: Mon,  2 Mar 2026 09:42:08 +0100
Message-ID: <20260302084338.473368-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

After moving away to target/i386/emulate, this is no longer necessary.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260223233950.96076-13-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                    |  3 +--
 include/system/whpx-common.h   |  3 ---
 include/system/whpx-internal.h | 16 ----------------
 accel/whpx/whpx-common.c       | 22 ----------------------
 4 files changed, 1 insertion(+), 43 deletions(-)

diff --git a/meson.build b/meson.build
index 3cd1d8dbc66..2bae618d848 100644
--- a/meson.build
+++ b/meson.build
@@ -865,8 +865,7 @@ if get_option('whpx').allowed() and host_os == 'windows'
     endif
    # Leave CONFIG_WHPX disabled
   else
-    if cc.has_header('winhvplatform.h', required: get_option('whpx')) and \
-      cc.has_header('winhvemulation.h', required: get_option('whpx'))
+    if cc.has_header('winhvplatform.h', required: get_option('whpx'))
       accelerators += 'CONFIG_WHPX'
     endif
   endif
diff --git a/include/system/whpx-common.h b/include/system/whpx-common.h
index a4e16e13099..04289afd973 100644
--- a/include/system/whpx-common.h
+++ b/include/system/whpx-common.h
@@ -3,9 +3,6 @@
 #define SYSTEM_WHPX_COMMON_H
 
 struct AccelCPUState {
-#ifdef HOST_X86_64
-    WHV_EMULATOR_HANDLE emulator;
-#endif
     bool window_registered;
     bool interruptable;
     bool ready_for_pic_interrupt;
diff --git a/include/system/whpx-internal.h b/include/system/whpx-internal.h
index ad6ade223ee..7a1c9871f18 100644
--- a/include/system/whpx-internal.h
+++ b/include/system/whpx-internal.h
@@ -4,9 +4,6 @@
 
 #include <windows.h>
 #include <winhvplatform.h>
-#ifdef HOST_X86_64
-#include <winhvemulation.h>
-#endif
 #include "hw/i386/apic.h"
 #include "exec/vaddr.h"
 
@@ -89,12 +86,6 @@ void whpx_apic_get(APICCommonState *s);
   X(HRESULT, WHvResetPartition, \
         (WHV_PARTITION_HANDLE Partition)) \
 
-#define LIST_WINHVEMULATION_FUNCTIONS(X) \
-  X(HRESULT, WHvEmulatorCreateEmulator, (const WHV_EMULATOR_CALLBACKS* Callbacks, WHV_EMULATOR_HANDLE* Emulator)) \
-  X(HRESULT, WHvEmulatorDestroyEmulator, (WHV_EMULATOR_HANDLE Emulator)) \
-  X(HRESULT, WHvEmulatorTryIoEmulation, (WHV_EMULATOR_HANDLE Emulator, VOID* Context, const WHV_VP_EXIT_CONTEXT* VpContext, const WHV_X64_IO_PORT_ACCESS_CONTEXT* IoInstructionContext, WHV_EMULATOR_STATUS* EmulatorReturnStatus)) \
-  X(HRESULT, WHvEmulatorTryMmioEmulation, (WHV_EMULATOR_HANDLE Emulator, VOID* Context, const WHV_VP_EXIT_CONTEXT* VpContext, const WHV_MEMORY_ACCESS_CONTEXT* MmioInstructionContext, WHV_EMULATOR_STATUS* EmulatorReturnStatus)) \
-
 #define WHP_DEFINE_TYPE(return_type, function_name, signature) \
     typedef return_type (WINAPI *function_name ## _t) signature;
 
@@ -103,16 +94,10 @@ void whpx_apic_get(APICCommonState *s);
 
 /* Define function typedef */
 LIST_WINHVPLATFORM_FUNCTIONS(WHP_DEFINE_TYPE)
-#ifdef HOST_X86_64
-LIST_WINHVEMULATION_FUNCTIONS(WHP_DEFINE_TYPE)
-#endif
 LIST_WINHVPLATFORM_FUNCTIONS_SUPPLEMENTAL(WHP_DEFINE_TYPE)
 
 struct WHPDispatch {
     LIST_WINHVPLATFORM_FUNCTIONS(WHP_DECLARE_MEMBER)
-#ifdef HOST_X86_64
-    LIST_WINHVEMULATION_FUNCTIONS(WHP_DECLARE_MEMBER)
-#endif
     LIST_WINHVPLATFORM_FUNCTIONS_SUPPLEMENTAL(WHP_DECLARE_MEMBER)
 };
 
@@ -122,7 +107,6 @@ bool init_whp_dispatch(void);
 
 typedef enum WHPFunctionList {
     WINHV_PLATFORM_FNS_DEFAULT,
-    WINHV_EMULATION_FNS_DEFAULT,
     WINHV_PLATFORM_FNS_SUPPLEMENTAL
 } WHPFunctionList;
 
diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index 21e9f1a1781..88eef557998 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -39,9 +39,6 @@ bool whpx_allowed;
 bool whpx_irqchip_in_kernel;
 static bool whp_dispatch_initialized;
 static HMODULE hWinHvPlatform;
-#ifdef HOST_X86_64
-static HMODULE hWinHvEmulation;
-#endif
 
 struct whpx_state whpx_global;
 struct WHPDispatch whp_dispatch;
@@ -393,7 +390,6 @@ static bool load_whp_dispatch_fns(HMODULE *handle,
     HMODULE hLib = *handle;
 
     #define WINHV_PLATFORM_DLL "WinHvPlatform.dll"
-    #define WINHV_EMULATION_DLL "WinHvEmulation.dll"
     #define WHP_LOAD_FIELD_OPTIONAL(return_type, function_name, signature) \
         whp_dispatch.function_name = \
             (function_name ## _t)GetProcAddress(hLib, #function_name); \
@@ -420,14 +416,6 @@ static bool load_whp_dispatch_fns(HMODULE *handle,
         WHP_LOAD_LIB(WINHV_PLATFORM_DLL, hLib)
         LIST_WINHVPLATFORM_FUNCTIONS(WHP_LOAD_FIELD)
         break;
-    case WINHV_EMULATION_FNS_DEFAULT:
-#ifdef HOST_X86_64
-        WHP_LOAD_LIB(WINHV_EMULATION_DLL, hLib)
-        LIST_WINHVEMULATION_FUNCTIONS(WHP_LOAD_FIELD)
-#else
-        g_assert_not_reached();
-#endif
-        break;
     case WINHV_PLATFORM_FNS_SUPPLEMENTAL:
         WHP_LOAD_LIB(WINHV_PLATFORM_DLL, hLib)
         LIST_WINHVPLATFORM_FUNCTIONS_SUPPLEMENTAL(WHP_LOAD_FIELD_OPTIONAL)
@@ -543,11 +531,6 @@ bool init_whp_dispatch(void)
     if (!load_whp_dispatch_fns(&hWinHvPlatform, WINHV_PLATFORM_FNS_DEFAULT)) {
         goto error;
     }
-#ifdef HOST_X86_64
-    if (!load_whp_dispatch_fns(&hWinHvEmulation, WINHV_EMULATION_FNS_DEFAULT)) {
-        goto error;
-    }
-#endif
     assert(load_whp_dispatch_fns(&hWinHvPlatform,
         WINHV_PLATFORM_FNS_SUPPLEMENTAL));
     whp_dispatch_initialized = true;
@@ -557,11 +540,6 @@ error:
     if (hWinHvPlatform) {
         FreeLibrary(hWinHvPlatform);
     }
-#ifdef HOST_X86_64
-    if (hWinHvEmulation) {
-        FreeLibrary(hWinHvEmulation);
-    }
-#endif
     return false;
 }
 
-- 
2.53.0


