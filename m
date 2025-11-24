Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCDF3CFA466
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 14:11:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNXHf-0007uf-Gi; Mon, 24 Nov 2025 09:11:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vNXHd-0007uM-R6
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 09:11:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vNXHb-0006Kk-Bq
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 09:11:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763993469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iY4/5tZdYFjUMKNic8QcrO+CTpNELjYUJ6RGmSKFGHs=;
 b=TpqmZM9NPQJDtYR9EOE0eEPMPxUK9i+Gz9+kP6N0ouy7o5TUUOE1djYDFdWvx601GV2RKO
 0lZwLmlhHGxyeKwg0aQbT+p+fiT3kYf5JTXOnBfh3NngH2GjOfCCV56ZzIYw5ERseEqHro
 vDY/xtxjjQQCy/GrsIpiGyTUYs/NO0Y=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-kpXr0k4LNwixeE9Atmy0mQ-1; Mon, 24 Nov 2025 09:11:08 -0500
X-MC-Unique: kpXr0k4LNwixeE9Atmy0mQ-1
X-Mimecast-MFC-AGG-ID: kpXr0k4LNwixeE9Atmy0mQ_1763993467
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4ed6ceab125so126084411cf.1
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 06:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763993467; x=1764598267; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iY4/5tZdYFjUMKNic8QcrO+CTpNELjYUJ6RGmSKFGHs=;
 b=hlSuAjG4rrSdcXtW1f6K8VIs+kvF8CRW81fcCWTqTBLw/KpQTIHiMKdDuQHCwYJ1HZ
 No0oXSFXk1TGWmLHq5m/5CMXxL6/bBPWFtJRMOj3pSdd+9lMFijqmcUpxoqSQBl4Z5uK
 cqj3wh23tJf8P7e6by3LwwVmgh7xW7kj2sC2obRP5ehRvpQATDiRn8ktg2nOOOTgZr9N
 1h4zGGlBUrth0PSHMGz5tfiSgA1nVxxV6QxLD96UxLEPw9jZTbTBhsLyiQzEFopJ/RWN
 sZ5avgbTIta1CKaYh4o49rdesK/M4rTg/yF1gjHsXLhk3KlvMzzEo0TiJfBmLWNUT7r+
 dfHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763993467; x=1764598267;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iY4/5tZdYFjUMKNic8QcrO+CTpNELjYUJ6RGmSKFGHs=;
 b=dxSY8uiPRYxSseU+BjMbcoj/fOZPKplH+NkXUZV9nnqKQAkumR1ZtOo/0uAkz+hsGE
 C7zdPJOy0pB4RU+VrRbyLm2PpSRGwTOyzhbp8ZJlQQk1NKZIx4tF9N7oDA17Wmk9YtgY
 MkMVxQDmvbFyVRq5fhENZ4racWBKVl+3O8/v0OZMv5X2qi5oWNCXk1ZNMrZ9HhoeuLYn
 ZS2qBZl2MEULAt4tYmaVRRp1IGYW7Od+bWkzntkTXtRYN2SEYKj/EH/8kUsVe5B0MSif
 SExsKS/bwjPZ+Ovpv2sSQlkhsqtSvIHn+2RFE/LN2LsGuWTYWbsuq9e+a2O+/oY0Or98
 +Iaw==
X-Gm-Message-State: AOJu0Yzzyo9grerr0JsdynvauOmWqDubCRvwa7KC8BFaFDgE+gd/+hpE
 PHhnHOFVA8zNmmY876OBfg9xyt5PuCp2PIyLHnY8uMiESwWMCkHfOPx7cYt5c0PuSqrgaANJrWy
 bWEWFX/r7uvcwhjdDSVDN4J3+g8I57XpBLmP4bIkGfxdo7qEng/dJhp5g
X-Gm-Gg: ASbGncsGCn+bw/Rh2kmxYpSNg7AO58wj3ocOTJIWtUCafNXjlQP9u7UZeJRFRz/Vcha
 rfJnRPXCtYZA4s9MjnW0yIwBohs4mQWS0cQaslPFFMkHdQyxffBSdBvQ8IaR/oraacXuYNVHHz/
 lmhfBy4qKMX/E8JvRQPUThNJwdVSlXfVMu2435wk5E1fzzXTTyDoz3bA3eEiEvadvgpmkTFTkhn
 Gt9cmp0Nr71Uu7l/mhQS6QPcM3j8xF2XFeVzvTNc3U20k3HYS+k00Q5NkQkCOkUs2gULGABQNan
 N4tiIdYMuaPz0nettYyULCTfqrvKWmyDJSsuv4DKXa2S6h0s3lQTMlVhlw/KPeqrzaXzJjimHQZ
 6bXXyskVUahmzuiQBGixS7b4o7y0zFt5LULTb/j2L7Um5+l8awGBHY8kAAYXrXg==
X-Received: by 2002:ac8:7d16:0:b0:4ee:2984:7d93 with SMTP id
 d75a77b69052e-4ee58801ad4mr134195851cf.17.1763993467253; 
 Mon, 24 Nov 2025 06:11:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRFeDxnD3bX8C6hENFI+bf1jIq0da/umjioo4zqUoFSdBqPDF+hLYLFcnBpPmvAm0CpovIUw==
X-Received: by 2002:ac8:7d16:0:b0:4ee:2984:7d93 with SMTP id
 d75a77b69052e-4ee58801ad4mr134195171cf.17.1763993466792; 
 Mon, 24 Nov 2025 06:11:06 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-139-91.business.telecomitalia.it.
 [87.12.139.91]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ee48e909b6sm89757771cf.32.2025.11.24.06.11.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 06:11:06 -0800 (PST)
Date: Mon, 24 Nov 2025 15:11:01 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>, 
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Luigi Leonardi <leonardi@redhat.com>, Oliver Steffen <osteffen@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/4] igvm: move file load to complete callback
Message-ID: <6hzri3ak72sucvn2ipaec5inj6yxbm3hakzjbqgs75sp6ez42w@vkntoapt74o4>
References: <20251118122133.1695767-1-kraxel@redhat.com>
 <20251118122133.1695767-3-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251118122133.1695767-3-kraxel@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.075,
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

On Tue, Nov 18, 2025 at 01:21:30PM +0100, Gerd Hoffmann wrote:
>Add UserCreatableClass->complete callback function for igvm-cfg object.
>
>Move file loading and parsing of the igvm file from the process function
>to the to the new complete callback function.  Keep the igvm file loaded
         ^
there is an extra "to the"

>instead of releasing it after processing, so we parse it only once.
>
>Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>---
> include/system/igvm-cfg.h |  3 +++
> include/system/igvm.h     |  1 +
> backends/igvm-cfg.c       | 10 ++++++++++
> backends/igvm.c           |  9 ++++-----
> 4 files changed, 18 insertions(+), 5 deletions(-)
>
>diff --git a/include/system/igvm-cfg.h b/include/system/igvm-cfg.h
>index 312f77c092b0..7dc48677fd99 100644
>--- a/include/system/igvm-cfg.h
>+++ b/include/system/igvm-cfg.h
>@@ -15,6 +15,8 @@
> #include "qom/object.h"
> #include "hw/resettable.h"
>
>+#include <igvm/igvm.h>
>+
> typedef struct IgvmCfg {
>     ObjectClass parent_class;
>
>@@ -24,6 +26,7 @@ typedef struct IgvmCfg {
>      *           format.
>      */
>     char *filename;
>+    IgvmHandle file;
>     ResettableState reset_state;
> } IgvmCfg;
>
>diff --git a/include/system/igvm.h b/include/system/igvm.h
>index 48ce20604259..ec2538daa0e1 100644
>--- a/include/system/igvm.h
>+++ b/include/system/igvm.h
>@@ -16,6 +16,7 @@
> #include "system/igvm-cfg.h"
> #include "qapi/error.h"
>
>+IgvmHandle qigvm_file_init(char *filename, Error **errp);
> int qigvm_process_file(IgvmCfg *igvm, ConfidentialGuestSupport *cgs,
>                       bool onlyVpContext, Error **errp);
>
>diff --git a/backends/igvm-cfg.c b/backends/igvm-cfg.c
>index 4e3ef88ffc27..08501a67e58e 100644
>--- a/backends/igvm-cfg.c
>+++ b/backends/igvm-cfg.c
>@@ -52,6 +52,13 @@ static void igvm_reset_exit(Object *obj, ResetType type)
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
>@@ -61,6 +68,7 @@ static void igvm_cfg_class_init(ObjectClass *oc, const void *data)
> {
>     IgvmCfgClass *igvmc = IGVM_CFG_CLASS(oc);
>     ResettableClass *rc = RESETTABLE_CLASS(oc);
>+    UserCreatableClass *uc = USER_CREATABLE_CLASS(oc);
>
>     object_class_property_add_str(oc, "file", get_igvm, set_igvm);
>     object_class_property_set_description(oc, "file",
>@@ -72,6 +80,8 @@ static void igvm_cfg_class_init(ObjectClass *oc, const void *data)
>     rc->phases.enter = igvm_reset_enter;
>     rc->phases.hold = igvm_reset_hold;
>     rc->phases.exit = igvm_reset_exit;
>+
>+    uc->complete = igvm_complete;
> }
>
> static void igvm_cfg_init(Object *obj)
>diff --git a/backends/igvm.c b/backends/igvm.c
>index 905bd8d98994..05d197fdfe85 100644
>--- a/backends/igvm.c
>+++ b/backends/igvm.c
>@@ -867,7 +867,7 @@ static int qigvm_handle_policy(QIgvm *ctx, Error **errp)
>     return 0;
> }
>
>-static IgvmHandle qigvm_file_init(char *filename, Error **errp)
>+IgvmHandle qigvm_file_init(char *filename, Error **errp)
> {
>     IgvmHandle igvm;
>     g_autofree uint8_t *buf = NULL;
>@@ -896,10 +896,11 @@ int qigvm_process_file(IgvmCfg *cfg, ConfidentialGuestSupport *cgs,
>     QIgvm ctx;
>
>     memset(&ctx, 0, sizeof(ctx));
>-    ctx.file = qigvm_file_init(cfg->filename, errp);
>-    if (ctx.file < 0) {
>+    if (!cfg->file) {
>+        error_setg(errp, "No IGVM file loaded.");
>         return -1;
>     }
>+    ctx.file = cfg->file;
>
>     /*
>      * The ConfidentialGuestSupport object is optional and allows a confidential
>@@ -990,7 +991,5 @@ cleanup_parameters:
>     g_free(ctx.id_auth);
>
> cleanup:

nit: "cleanup" label is now unnecessary; perhaps we could remove it and 
return -1 directly where it is used (not a strong opinion; I'm perfectly 
fine with keeping this patch small).

>-    igvm_free(ctx.file);

Should we now move this call the the finalize or to some destructor?

Thanks,
Stefano

>-
>     return retval;
> }
>-- 2.51.1
>


