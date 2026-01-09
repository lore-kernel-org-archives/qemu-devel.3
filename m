Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70DE7D1681C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 11:52:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veB24-00006V-EV; Fri, 09 Jan 2026 06:51:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1veB22-00006J-ON
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 06:51:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1veB21-0006Bm-3h
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 06:51:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767959512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T6cuie97GRK/pCM49JcOHtI+LepKKNQc10AP/xyMvEo=;
 b=ECYHAUErSMPsrnTCM9AE7y7L+psf5LrG1vnFO6LWIO9uLRd74131koc9SGtef4Q+XRmA7D
 ZWk9eEV2bbeLXTE3u68GcsYezhLz5/LVvWzrY51nXhnu1/erIzdhrR68g+z935ss8VEJvx
 K0EHDdeA9OYKq9c4P0Vv7ZknX9eBUQg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-QxEyM-WaM56MC-EzNc3rKw-1; Fri, 09 Jan 2026 06:51:51 -0500
X-MC-Unique: QxEyM-WaM56MC-EzNc3rKw-1
X-Mimecast-MFC-AGG-ID: QxEyM-WaM56MC-EzNc3rKw_1767959510
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b844098867cso567418366b.3
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 03:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767959510; x=1768564310; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=T6cuie97GRK/pCM49JcOHtI+LepKKNQc10AP/xyMvEo=;
 b=MHsoX1jEpRL8Ng6vCZ8LDPYhSAuGvl8eibOl9+KJMendOOSdPP0P1DqlBw895HeU26
 OaLRV7S2yM3yEy6KL9XHpNVzk3cbzKDlHYgUqFU+fU7t1JIBWxTgUsAJcm5+QgjtFM/c
 ZFepAaisG1SXFx2QhAP58QJSrxsQRBGkK+vpJclynEe7MKucAgW2uonYk/PekrfDq4Fs
 eJtEv4rKEDxvrnjGxZYElh/LL631JD+QYosjXiGouf6ObNXqVbPD162J7IWipinzN92B
 L9yDff0F9X6mq2OrKTaoW3bsAulgyh0kne5B+rowLbjhSvcqwpSty2f7drGnemICVlHk
 kKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767959510; x=1768564310;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T6cuie97GRK/pCM49JcOHtI+LepKKNQc10AP/xyMvEo=;
 b=ZhgHZjLS5bwCPvCOAVfr5qhTAx01Z7ywnS2jS81Y6wXh/AZEPnkdclDycfsasmr14m
 7tzA9S+whQfvlZ8ZFdC/hBuji2swYoOmd7IzcltCeHzJiJ6e2jCBa4QjWB+8kZPvpFQd
 FJSHVS3bodYFXNKnI8NF8RdmJUIkYS6smX4sDzJ0Jb6hpg8mcIee89IoOlSrPepUy5Rs
 vVe9Yy3xVKjQjSVZmVb+l/IuruB4hI7c9yHwtAXik4GWuICulTWnJaFQGFIanXfIq1zu
 hf5sB6jg6xVos29ORyL0qi0Im9nrbolufKSMcCJ2dJzKEdqKU1jtnztNiJ1+oblsCORZ
 3NRg==
X-Gm-Message-State: AOJu0YxiTueFt+oLK6u1uNadrupwVHQT+yaDv6yz6anPq665n4pmT/jP
 qSPkYcx5Mm8h17K4K40KZI9XGiQ8AyEvPrGYdsEiNgmbs5J62xE166Gx/ff99fy6MY1awwIpZbm
 Bsoae3zVYGvI/EoLmSPyFIgE8xx2zXzeZW82zSq0918v9XYCvYdvt5zCv
X-Gm-Gg: AY/fxX72RiTw5xF4V30304O7PgDAQpcDkTdwDaXSegbftJY/Rl2i3YxSOJSPfK/xNz+
 1FKeINOoN3+UUkx564Au8mAKG+ZX3NFX28Hw+KYUC+IK7Hc7Gp75GcSOI/gecW7mjA0ZsVu3/mq
 SBdxVBxI7pEYE0jq0iCMcofCqlovBZrsp7xlYssxpnAI7ge/BKulD2IhIcRmuZIjkh3aTu7JUlS
 KFnGEXspGIoIMDRuDXSI92R8Uf4PUWRXbpFL41uBEABCaSa+Z3R8JZ/r0xZBItErs+vB63TKI5L
 xducLRWJbQnZeOJ6qZhHvcaJbVVbhfn1uTACzA5xZx5Fp7iP60XKtxpNNvVd3Ce7eoDyuS09sME
 SEx2ztH0bY6G3pf8Z
X-Received: by 2002:a17:907:a4a:b0:b79:c879:fe71 with SMTP id
 a640c23a62f3a-b84451e156bmr831548866b.19.1767959510120; 
 Fri, 09 Jan 2026 03:51:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEm6p/TD8lBTYAmoRKuzR5IRbh+I8HNyN7OHVU6cq7d4DHab/kBifLO4FejvQ2n2Vms0DrPMQ==
X-Received: by 2002:a17:907:a4a:b0:b79:c879:fe71 with SMTP id
 a640c23a62f3a-b84451e156bmr831546366b.19.1767959509510; 
 Fri, 09 Jan 2026 03:51:49 -0800 (PST)
Received: from sgarzare-redhat ([193.207.180.225])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507bf6d683sm10170433a12.34.2026.01.09.03.51.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jan 2026 03:51:48 -0800 (PST)
Date: Fri, 9 Jan 2026 12:51:42 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Oliver Steffen <osteffen@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Luigi Leonardi <leonardi@redhat.com>
Subject: Re: [PATCH v2 3/5] igvm: move file load to complete callback
Message-ID: <aWDrKDOzwN4qjsVF@sgarzare-redhat>
References: <20251211105419.3573449-1-kraxel@redhat.com>
 <20251211105419.3573449-4-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251211105419.3573449-4-kraxel@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Dec 11, 2025 at 11:54:17AM +0100, Gerd Hoffmann wrote:
>Add UserCreatableClass->complete callback function for igvm-cfg object.
>
>Move file loading and parsing of the igvm file from the process function
>to the new complete() callback function.  Keep the igvm file loaded
>after processing, release it in finalize() instead, so we parse it only
>once.
>
>Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>---
> include/system/igvm-internal.h |  5 +++++
> backends/igvm-cfg.c            | 18 ++++++++++++++++++
> backends/igvm.c                |  9 ++++-----
> 3 files changed, 27 insertions(+), 5 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/include/system/igvm-internal.h b/include/system/igvm-internal.h
>index e0452080b127..d378d682b0fb 100644
>--- a/include/system/igvm-internal.h
>+++ b/include/system/igvm-internal.h
>@@ -12,6 +12,8 @@
> #include "qemu/typedefs.h"
> #include "qom/object.h"
>
>+#include <igvm/igvm.h>
>+
> struct IgvmCfg {
>     ObjectClass parent_class;
>
>@@ -21,7 +23,10 @@ struct IgvmCfg {
>      *           format.
>      */
>     char *filename;
>+    IgvmHandle file;
>     ResettableState reset_state;
> };
>
>+IgvmHandle qigvm_file_init(char *filename, Error **errp);
>+
> #endif
>diff --git a/backends/igvm-cfg.c b/backends/igvm-cfg.c
>index e0df3eaa8efd..4014062e0f22 100644
>--- a/backends/igvm-cfg.c
>+++ b/backends/igvm-cfg.c
>@@ -53,6 +53,13 @@ static void igvm_reset_exit(Object *obj, ResetType type)
>     trace_igvm_reset_exit(type);
> }
>
>+static void igvm_complete(UserCreatable *uc, Error **errp)
>+{
>+    IgvmCfg *igvm = IGVM_CFG(uc);
>+
>+    igvm->file = qigvm_file_init(igvm->filename, errp);
>+}
>+
> OBJECT_DEFINE_TYPE_WITH_INTERFACES(IgvmCfg, igvm_cfg, IGVM_CFG, OBJECT,
>                                    { TYPE_USER_CREATABLE },
>                                    { TYPE_RESETTABLE_INTERFACE },
>@@ -62,6 +69,7 @@ static void igvm_cfg_class_init(ObjectClass *oc, const void *data)
> {
>     IgvmCfgClass *igvmc = IGVM_CFG_CLASS(oc);
>     ResettableClass *rc = RESETTABLE_CLASS(oc);
>+    UserCreatableClass *uc = USER_CREATABLE_CLASS(oc);
>
>     object_class_property_add_str(oc, "file", get_igvm, set_igvm);
>     object_class_property_set_description(oc, "file",
>@@ -73,14 +81,24 @@ static void igvm_cfg_class_init(ObjectClass *oc, const void *data)
>     rc->phases.enter = igvm_reset_enter;
>     rc->phases.hold = igvm_reset_hold;
>     rc->phases.exit = igvm_reset_exit;
>+
>+    uc->complete = igvm_complete;
> }
>
> static void igvm_cfg_init(Object *obj)
> {
>+    IgvmCfg *igvm = IGVM_CFG(obj);
>+
>+    igvm->file = -1;
>     qemu_register_resettable(obj);
> }
>
> static void igvm_cfg_finalize(Object *obj)
> {
>+    IgvmCfg *igvm = IGVM_CFG(obj);
>+
>     qemu_unregister_resettable(obj);
>+    if (igvm->file >= 0) {
>+        igvm_free(igvm->file);
>+    }
> }
>diff --git a/backends/igvm.c b/backends/igvm.c
>index fbb8300b6d01..a01e01a12a60 100644
>--- a/backends/igvm.c
>+++ b/backends/igvm.c
>@@ -869,7 +869,7 @@ static int qigvm_handle_policy(QIgvm *ctx, Error **errp)
>     return 0;
> }
>
>-static IgvmHandle qigvm_file_init(char *filename, Error **errp)
>+IgvmHandle qigvm_file_init(char *filename, Error **errp)
> {
>     IgvmHandle igvm;
>     g_autofree uint8_t *buf = NULL;
>@@ -898,10 +898,11 @@ int qigvm_process_file(IgvmCfg *cfg, ConfidentialGuestSupport *cgs,
>     QIgvm ctx;
>
>     memset(&ctx, 0, sizeof(ctx));
>-    ctx.file = qigvm_file_init(cfg->filename, errp);
>-    if (ctx.file < 0) {
>+    if (cfg->file < 0) {
>+        error_setg(errp, "No IGVM file loaded.");
>         return -1;
>     }
>+    ctx.file = cfg->file;
>
>     /*
>      * The ConfidentialGuestSupport object is optional and allows a confidential
>@@ -992,7 +993,5 @@ cleanup_parameters:
>     g_free(ctx.id_auth);
>
> cleanup:
>-    igvm_free(ctx.file);
>-
>     return retval;
> }
>-- 
>2.52.0
>


