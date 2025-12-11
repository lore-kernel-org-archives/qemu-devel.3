Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 522A1D41C21
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 11:16:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTedZ-0005u0-EI; Thu, 11 Dec 2025 06:15:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1vTedX-0005tF-8V
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 06:15:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1vTedT-0002nh-Gs
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 06:15:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765451702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lxfPWo5wFs6Ox1x8af5WIxFiP/2EoIk46rgigvc2QXE=;
 b=gBbkC+qPNlHZeS4iQ9D+dW7z7DYwOB3qh3HDfzQ6dt/rN1n4e/jSMX1VxxLnBAiab84gtw
 HCvFLqX9biS+YmR7hbmSz1DYB7rVza/TRald1It6OR08P4wVUnXobwVlURZS/Uy9QIXltI
 bRTFOo97xkS4TTm4eLoFNUQ7p0O96es=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-HfdHm4JvMNKczpzyzGj35g-1; Thu, 11 Dec 2025 06:13:37 -0500
X-MC-Unique: HfdHm4JvMNKczpzyzGj35g-1
X-Mimecast-MFC-AGG-ID: HfdHm4JvMNKczpzyzGj35g_1765451616
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-42b3c965ce5so527599f8f.2
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 03:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765451616; x=1766056416; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lxfPWo5wFs6Ox1x8af5WIxFiP/2EoIk46rgigvc2QXE=;
 b=ZYhQ9DU9GOk7Y84YFBqt83UtR3gP0KDeA//rzHyfUsD4WrB0N9HJAGI7DWLW+ktLV6
 Afw5xFncOj3J+l4dLdcKb56Rk2Qm+9Uv5Q2AbPIL/x7LDXw8UyZNB9NTr+9EtmHLPjsB
 i4g11kqLtCkJ3LjfLzLUMHZHyfRWx9lGlibhjFv8r6pzuV2Bl71m9k+PhFSb3KbSx0dY
 BWSKH9d97cRs2uy8HS9RqpJYCC6agsx+htT93uyEUNoqlLyZuA6HWcNVCdt4dGgxeeDF
 Whvdm1mXoF2WMgMRM7YKBtdrq0hsx1ZGX+LWrwPaduBED9I8Roow7oOnaMHPuYUVojDd
 GenA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765451616; x=1766056416;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lxfPWo5wFs6Ox1x8af5WIxFiP/2EoIk46rgigvc2QXE=;
 b=A+5t8R5m0RjA0SxWC/sNPbKfudu3aeKSsAiIecvK/v9Tk0EADGZqLhE/ZOfErjT7Sl
 1U7nhnKXMiXmJ7OnlyLkjyHiQWvddj49ht2t6e2tLkzW/sRSjNvW0yw+q21aH70lVbwW
 cO9seukHhdchxU3cgNFOmP8ZMdVcmtZ/bExictVfaqVpLnxoX7URY2SiPWMi33UBXoOi
 YUnf7zMEzT/rOCXSbcsqI3s5KZsmVCIZhPHewhGki42nxdEqmuD/y+Yy92Hg6zsAIPyJ
 1K0PH2nLV83lPwQqLvW0AQB1ubNYAQtOaQOan6KH3beilIw2fISUSDv7SzoQD57sXo9o
 dWMQ==
X-Gm-Message-State: AOJu0Ywav9scv0iwal8FcKW2XS7+HnfkpZsMkVP65+aXZ574aBgkgGNw
 Vo43DXyDKKEMmxZ8KYanUDBE3NzZhC268douagqL5RZQLngEPU2W2kz587wDDuQ+DobkgqxOzFe
 CCWHu9H0T9fXEZrwiIdz00qflvkP4cUCyIVjT7arLgulqPPNsXPo66y3c
X-Gm-Gg: AY/fxX5RCG7G1VSjOs2/XYnO/5NDBjvbIV3kXrv9up3KoJAmxXiXQnc4kJ85YbIJJbo
 nrYgD7a5w53qxEaMZjv81y/5gX8Qi4hRstC1qGlLZNOIJYuMowdhJ/zkyq2dDCeK9XWBTDM1LyS
 EzxfLVUxHZ7ZEJEWtkdHPbQwLkDyqxWTN/WUYxgQlPeNMn7Hit5zqCH0o1jcY9BBmsI2GDoUsmt
 CqMRCGERtAtru/9omf9SQXb6xmSVlP1EmkxdhmwIkJK80l3eBg/tyTNZxQyReYPmAJMTJ4NwH/h
 2INjknNdUw/tXYKuhCuqVigjJnM2v0GAz91WznjJFI6+cOWVJpzRvvAIy1UeUGUIiBFnW5qo0gQ
 F7vO7c8D/hrO5kJM=
X-Received: by 2002:a05:6000:4285:b0:429:ccd7:9d94 with SMTP id
 ffacd0b85a97d-42fa3b07ca8mr5671661f8f.51.1765451615981; 
 Thu, 11 Dec 2025 03:13:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGNvO7L2WSyb7/dW5BHy719Bf+kqntxstBPE0NQUvMNplbs3WXf3R24zKXuywk9XKCfLdnAA==
X-Received: by 2002:a05:6000:4285:b0:429:ccd7:9d94 with SMTP id
 ffacd0b85a97d-42fa3b07ca8mr5671629f8f.51.1765451615451; 
 Thu, 11 Dec 2025 03:13:35 -0800 (PST)
Received: from leonardi-redhat ([151.29.156.207])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fa8b8a841sm5260783f8f.30.2025.12.11.03.13.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 03:13:34 -0800 (PST)
Date: Thu, 11 Dec 2025 12:13:32 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Oliver Steffen <osteffen@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v2 1/5] igvm: reorganize headers
Message-ID: <iaysdncdycow33aagzhxugt6cl5dbdx67o4m67to6qiklolew5@fqx5aivqrxkg>
References: <20251211105419.3573449-1-kraxel@redhat.com>
 <20251211105419.3573449-2-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251211105419.3573449-2-kraxel@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Hi Gerd,

On Thu, Dec 11, 2025 at 11:54:15AM +0100, Gerd Hoffmann wrote:
>Add a new igvm-internal.h header file.  Structs and declarations which
>depend on the igvm library header go into that file.
>
>Also declare IgvmCfg in typedefs.h, so the type can be used without
>including igvm header files.
>
>Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>---
> include/qemu/typedefs.h        |  1 +
> include/system/igvm-cfg.h      | 12 +-----------
> include/system/igvm-internal.h | 26 ++++++++++++++++++++++++++
> include/system/igvm.h          |  2 +-
> backends/igvm-cfg.c            |  4 +++-
> backends/igvm.c                |  2 ++
> 6 files changed, 34 insertions(+), 13 deletions(-)
> create mode 100644 include/system/igvm-internal.h
>
>diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
>index 4a94af9665a5..416a8c9acead 100644
>--- a/include/qemu/typedefs.h
>+++ b/include/qemu/typedefs.h
>@@ -55,6 +55,7 @@ typedef struct FWCfgState FWCfgState;
> typedef struct HostMemoryBackend HostMemoryBackend;
> typedef struct I2CBus I2CBus;
> typedef struct I2SCodec I2SCodec;
>+typedef struct IgvmCfg IgvmCfg;
> typedef struct IOMMUMemoryRegion IOMMUMemoryRegion;
> typedef struct ISABus ISABus;
> typedef struct ISADevice ISADevice;
>diff --git a/include/system/igvm-cfg.h b/include/system/igvm-cfg.h
>index 944f23a814dd..6c07f3084082 100644
>--- a/include/system/igvm-cfg.h
>+++ b/include/system/igvm-cfg.h
>@@ -12,19 +12,9 @@
> #ifndef QEMU_IGVM_CFG_H
> #define QEMU_IGVM_CFG_H
>
>+#include "qemu/typedefs.h"
> #include "qom/object.h"
>
>-typedef struct IgvmCfg {
>-    ObjectClass parent_class;
>-
>-    /*
>-     * filename: Filename that specifies a file that contains the configuration
>-     *           of the guest in Independent Guest Virtual Machine (IGVM)
>-     *           format.
>-     */
>-    char *filename;
>-} IgvmCfg;
>-
> typedef struct IgvmCfgClass {
>     ObjectClass parent_class;
>
>diff --git a/include/system/igvm-internal.h b/include/system/igvm-internal.h
>new file mode 100644
>index 000000000000..475a29bbf3d7
>--- /dev/null
>+++ b/include/system/igvm-internal.h
>@@ -0,0 +1,26 @@
>+/*
>+ * QEMU IGVM private data structures
>+ *
>+ * Everything which depends on igvm library headers goes here.
>+ *
>+ * SPDX-License-Identifier: GPL-2.0-or-later
>+ */
>+
>+#ifndef QEMU_IGVM_INTERNAL_H
>+#define QEMU_IGVM_INTERNAL_H
>+
>+#include "qemu/typedefs.h"
>+#include "qom/object.h"
>+
>+struct IgvmCfg {
>+    ObjectClass parent_class;
>+
>+    /*
>+     * filename: Filename that specifies a file that contains the configuration
>+     *           of the guest in Independent Guest Virtual Machine (IGVM)
>+     *           format.
>+     */
>+    char *filename;
>+};
>+
>+#endif
>diff --git a/include/system/igvm.h b/include/system/igvm.h
>index 48ce20604259..8355e54e95fc 100644
>--- a/include/system/igvm.h
>+++ b/include/system/igvm.h
>@@ -12,8 +12,8 @@
> #ifndef BACKENDS_IGVM_H
> #define BACKENDS_IGVM_H
>
>+#include "qemu/typedefs.h"
> #include "system/confidential-guest-support.h"
>-#include "system/igvm-cfg.h"
> #include "qapi/error.h"
>
> int qigvm_process_file(IgvmCfg *igvm, ConfidentialGuestSupport *cgs,
>diff --git a/backends/igvm-cfg.c b/backends/igvm-cfg.c
>index d00acf351249..001c4dc93346 100644
>--- a/backends/igvm-cfg.c
>+++ b/backends/igvm-cfg.c
>@@ -11,8 +11,10 @@
>
> #include "qemu/osdep.h"
>
>-#include "system/igvm-cfg.h"
> #include "system/igvm.h"
>+#include "system/igvm-cfg.h"
>+#include "system/igvm-internal.h"
>+#include "system/reset.h"
> #include "qom/object_interfaces.h"
>
> static char *get_igvm(Object *obj, Error **errp)
>diff --git a/backends/igvm.c b/backends/igvm.c
>index 905bd8d98994..fbb8300b6d01 100644
>--- a/backends/igvm.c
>+++ b/backends/igvm.c
>@@ -14,6 +14,8 @@
> #include "qapi/error.h"
> #include "qemu/target-info-qapi.h"
> #include "system/igvm.h"
>+#include "system/igvm-cfg.h"
>+#include "system/igvm-internal.h"
> #include "system/memory.h"
> #include "system/address-spaces.h"
> #include "hw/core/cpu.h"
>-- 
>2.52.0
>

Should we add `igvm-internal.h` to the MAINTAINERS file?

Thanks,
Luigi


