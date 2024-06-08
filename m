Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF65C27C55
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:36:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFrYD-0002y1-Rw; Sat, 08 Jun 2024 04:35:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrYB-0002rY-NO
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:35:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrY9-0000H7-TU
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:35:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717835745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9ZFB/yuExqMQepg77oZOQlaKUtKGOsnEHOoUh/toyKM=;
 b=MsHa4ZuvrkbrTYQ4w43A3PxW5hp5Obu2upw7izzS4KEFy5yJ1sR5abTO8PxVP18wpK3KeS
 h+x4rbMkbZzU6bfgqTIyHz2YxnVnc9GAcpuzEhAEciqlxVS0RM0eqLEh1R/eQCrHfzPt3L
 bipk13jVRTpwa5Led+jCDgdFugSUg1U=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639--OGSG0z1MPaTo3h2VhQAkQ-1; Sat, 08 Jun 2024 04:35:39 -0400
X-MC-Unique: -OGSG0z1MPaTo3h2VhQAkQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a6ef6ac6e0aso46492966b.0
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:35:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717835738; x=1718440538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9ZFB/yuExqMQepg77oZOQlaKUtKGOsnEHOoUh/toyKM=;
 b=L9ivVMvlxF5zr5eaWiDaX9X1z0+lPwDVMZOj8pafAjG9DG+ZeIG5MJuWpydizE7smd
 0Pge/s8pxwQjicbo8D3CRkkhwafwBG43n9jM6bFvRNPoejxD+EzX6fa6jmVqmY5QOmEA
 YkBLC8OJqEHMZjdTVAFUGI/HAAWevvU8uNXFJdc6m8QzgDykslOMUHW12ewsul2nl+cU
 n3Paa81fuhQ7bOKywjhAVdxUPan8MpkkRWOIo5r1CHzaBk85DQz8kdd63ogaY5aZ/FTq
 COZpjqFxYEC9M9z49FSiHS91agEeLSPvvkC95SQVMZabVivoXv93eu+ghyyswoP5hRmg
 oCvQ==
X-Gm-Message-State: AOJu0YyWZne3nrdDZTyp3PHHhyBoVKfs155zFJeu52pO4pekFSI/w0G9
 jRi1bngdIofklzMbtgKMtjta5CwF1eHPnc7go4GQSs9rXGHBXxnPs0xmlsuw+HDOww5PHGnWh6X
 YO5A4CWaH/LTDJFWnjyH1rc8mg79KOWLbj8aY/gmJyeyeoZqG2eZ9/0/4yjiXydasMy5jT7ZoZ/
 pwd3XoGu6H/Mc82FvNLWF8va0Oil9l77CqZ7US
X-Received: by 2002:a17:906:4a4a:b0:a6f:74:d389 with SMTP id
 a640c23a62f3a-a6f0074d52fmr61708166b.14.1717835738213; 
 Sat, 08 Jun 2024 01:35:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGg6qRSsxR1uoDlv1tO2P304Tmc/IiJ+ffWkip6goNciW0hd12+KYJmu7cUxw78M6WBuA9zmA==
X-Received: by 2002:a17:906:4a4a:b0:a6f:74:d389 with SMTP id
 a640c23a62f3a-a6f0074d52fmr61706566b.14.1717835737677; 
 Sat, 08 Jun 2024 01:35:37 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c8072a64asm355314766b.220.2024.06.08.01.35.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:35:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PULL 31/42] hvf: Makes assert_hvf_ok report failed expression
Date: Sat,  8 Jun 2024 10:34:04 +0200
Message-ID: <20240608083415.2769160-32-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240608083415.2769160-1-pbonzini@redhat.com>
References: <20240608083415.2769160-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Phil Dennis-Jordan <phil@philjordan.eu>

When a macOS Hypervisor.framework call fails which is checked by
assert_hvf_ok(), Qemu exits printing the error value, but not the
location
in the code, as regular assert() macro expansions would.

This change turns assert_hvf_ok() into a macro similar to other
assertions, which expands to a call to the corresponding _impl()
function together with information about the expression that failed
the assertion and its location in the code.

Additionally, stringifying the numeric hv_return_t code is factored
into a helper function that can be reused for diagnostics and debugging
outside of assertions.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
Message-ID: <20240605112556.43193-8-phil@philjordan.eu>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/sysemu/hvf_int.h |  5 +++-
 accel/hvf/hvf-all.c      | 51 +++++++++++++++++-----------------------
 2 files changed, 26 insertions(+), 30 deletions(-)

diff --git a/include/sysemu/hvf_int.h b/include/sysemu/hvf_int.h
index 30e739a2b52..5b28d17ba1f 100644
--- a/include/sysemu/hvf_int.h
+++ b/include/sysemu/hvf_int.h
@@ -60,7 +60,10 @@ struct AccelCPUState {
     bool dirty;
 };
 
-void assert_hvf_ok(hv_return_t ret);
+void assert_hvf_ok_impl(hv_return_t ret, const char *file, unsigned int line,
+                        const char *exp);
+#define assert_hvf_ok(EX) assert_hvf_ok_impl((EX), __FILE__, __LINE__, #EX)
+const char *hvf_return_string(hv_return_t ret);
 int hvf_arch_init(void);
 int hvf_arch_init_vcpu(CPUState *cpu);
 void hvf_arch_vcpu_destroy(CPUState *cpu);
diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index db05b81be58..c008dc2f1ea 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -13,40 +13,33 @@
 #include "sysemu/hvf.h"
 #include "sysemu/hvf_int.h"
 
-void assert_hvf_ok(hv_return_t ret)
+const char *hvf_return_string(hv_return_t ret)
+{
+    switch (ret) {
+    case HV_SUCCESS:      return "HV_SUCCESS";
+    case HV_ERROR:        return "HV_ERROR";
+    case HV_BUSY:         return "HV_BUSY";
+    case HV_BAD_ARGUMENT: return "HV_BAD_ARGUMENT";
+    case HV_NO_RESOURCES: return "HV_NO_RESOURCES";
+    case HV_NO_DEVICE:    return "HV_NO_DEVICE";
+    case HV_UNSUPPORTED:  return "HV_UNSUPPORTED";
+#if defined(MAC_OS_VERSION_11_0) && \
+    MAC_OS_X_VERSION_MIN_REQUIRED >= MAC_OS_VERSION_11_0
+    case HV_DENIED:       return "HV_DENIED";
+#endif
+    default:              return "[unknown hv_return value]";
+    }
+}
+
+void assert_hvf_ok_impl(hv_return_t ret, const char *file, unsigned int line,
+                        const char *exp)
 {
     if (ret == HV_SUCCESS) {
         return;
     }
 
-    switch (ret) {
-    case HV_ERROR:
-        error_report("Error: HV_ERROR");
-        break;
-    case HV_BUSY:
-        error_report("Error: HV_BUSY");
-        break;
-    case HV_BAD_ARGUMENT:
-        error_report("Error: HV_BAD_ARGUMENT");
-        break;
-    case HV_NO_RESOURCES:
-        error_report("Error: HV_NO_RESOURCES");
-        break;
-    case HV_NO_DEVICE:
-        error_report("Error: HV_NO_DEVICE");
-        break;
-    case HV_UNSUPPORTED:
-        error_report("Error: HV_UNSUPPORTED");
-        break;
-#if defined(MAC_OS_VERSION_11_0) && \
-    MAC_OS_X_VERSION_MIN_REQUIRED >= MAC_OS_VERSION_11_0
-    case HV_DENIED:
-        error_report("Error: HV_DENIED");
-        break;
-#endif
-    default:
-        error_report("Unknown Error");
-    }
+    error_report("Error: %s = %s (0x%x, at %s:%u)",
+        exp, hvf_return_string(ret), ret, file, line);
 
     abort();
 }
-- 
2.45.1


