Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE5BAD41C20
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 11:33:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTeuk-0002CE-PR; Thu, 11 Dec 2025 06:32:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1vTeui-000296-F6
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 06:32:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1vTeug-0005vl-U5
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 06:32:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765452770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+qIzzMtKhvUi+N/IpkHz+D2b0E//K21mnD2V+1kwQmE=;
 b=H/PTslcAbojPMC4dJEx7DR7O+rHtha2SsGgQdX/+G1nrTFme0kAcFilDYrDPjuI65TlvuY
 ashi81uHrN0w6qxwdNRso3+wweW3BKodhvTGZejw867kuwXYmsqydJYpnmIEJ8DXlvkTa5
 Ny16jTsi1VWyKIThOLJnZw2ppMxBxZs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-887M4pBTMO20A4Oa5w7x5g-1; Thu, 11 Dec 2025 06:32:48 -0500
X-MC-Unique: 887M4pBTMO20A4Oa5w7x5g-1
X-Mimecast-MFC-AGG-ID: 887M4pBTMO20A4Oa5w7x5g_1765452767
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4775f51ce36so5675295e9.1
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 03:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765452767; x=1766057567; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+qIzzMtKhvUi+N/IpkHz+D2b0E//K21mnD2V+1kwQmE=;
 b=awJSjSgvM/M1TTNscqFcM2PyKcBCqE/IfA8VH8TjlxBTEjaokegcaBrVKbpNsAuQf3
 XEoBVQa0WxZewi9HteJQwYIkBUJwfGZiBKFge4UYAzmUEt0Nb2jvRUqR4hzIy1OGfdJ7
 AY6EWPpEPImPdQ+sW1fyuKDP0EPxrHBL0BfmY83AftwFdYBpMkCA7hZPAOfk+uA2Bq9Y
 5CdAJCphnh9lHGLGAcwszZEturQ8/8ix5yBsUUGirUqnFY1kXJ0msfIA+q3anXnMWYE+
 RigOpPVOj50kbAu1pnIAPPCx7z7jVoD41ZvlYn1/sl1S1wGu3Cj3MFaHxHFQPEM3Cn0D
 ncwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765452767; x=1766057567;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+qIzzMtKhvUi+N/IpkHz+D2b0E//K21mnD2V+1kwQmE=;
 b=H8QWLN7tqrKsNViEwYSGpGAfkrk0cMnTVCxR/brmIBlAio1G9+pu7cvcwEwzG6zlWF
 tF2TCHAob33zgCyocU4JaEeYDZsnuvwp2U65xF72yZXBc4V6KeNVBYu3+oqDo9J+1poT
 vFmgRHWPnSbpZ3PLhTAHAUMov6kb53dG9FdSbqwxPR7wSeyPTyw9ktduZiHW6eG2apBL
 X3rIY9QJJuU33S759uTypuzusatAoPdXYeoMLYqILYq0sL/kgW44WD04wrwVLS17MeJx
 34sOx3AtFV6ix7cv4nSuC9ji4Pe2R+ChcTS/7XV53+B8G15QOavKe9FHRKKGaadabRJW
 vaeA==
X-Gm-Message-State: AOJu0YyNsaCTVvrG292WHbkkN0KmG5uDm7yKpJN2W3EPK522g012sFkb
 29Bt3fhGqoSyQo2CvGr68mCyyqj1sh489NlQ97LW871wmVvsu58ojpVfk0E1S1z/uqP3eRMBO7n
 rM9lnuCsF/g18WQcO/QBLlR53vsbVVn6Uj54rJ+9EZQb9S2kwKJn3Wx6S
X-Gm-Gg: AY/fxX42C0K7llP9NCR5F7dKr+5o36Rz6vKZ8Zecc/g+c/ueTpFJQiYh0pDWQhvHjLM
 1t+tbOf2X6jO+qDlf0Ni25gAxQVcRV8XXaTEeO8Iwznp/+rF27Ph6dqS7RdhR1vPY2Wqt49SkVq
 WSHze+D8mA7e1aE3iX8TRtHv558e4cUdUXyvwqNGXKOULPf2QXtx8Tux3yL5gCMfRX5Ki7XwKkP
 eRiwJAV6hVcDh5knEbHjT4qdRewLhG21KUngRrqMZJVcBIzTmC5gkbX1cTknj+hp7hbNdKRDz/F
 LaaLu9Nt+vdgIeFZdWj80Jk+DKFhdqt0aotFyoZB5DQYcyiNy2kT5FquDMmpJKSTqdD8sSyVIzL
 5dkF61vcnSrB+pdE=
X-Received: by 2002:a05:600c:a0a:b0:479:1a0a:ebbe with SMTP id
 5b1f17b1804b1-47a8375ab54mr58982505e9.14.1765452767451; 
 Thu, 11 Dec 2025 03:32:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWxswVvBo6Yc+elGKuvHQk1GdYR7vZX2DqpQjW/Y1IfhiIluOqLNtrWKYFYGGX3rHtSej5RA==
X-Received: by 2002:a05:600c:a0a:b0:479:1a0a:ebbe with SMTP id
 5b1f17b1804b1-47a8375ab54mr58982065e9.14.1765452766969; 
 Thu, 11 Dec 2025 03:32:46 -0800 (PST)
Received: from leonardi-redhat ([151.29.156.207])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a89ef4904sm11798525e9.3.2025.12.11.03.32.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 03:32:46 -0800 (PST)
Date: Thu, 11 Dec 2025 12:32:43 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Oliver Steffen <osteffen@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v2 4/5] igvm: add trace points for igvm file loading and
 processing
Message-ID: <rwetrddx3pexiegspxphdvlccjr376mq62bgeywpygqfugxcu6@i5juydrpgomg>
References: <20251211105419.3573449-1-kraxel@redhat.com>
 <20251211105419.3573449-5-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251211105419.3573449-5-kraxel@redhat.com>
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

On Thu, Dec 11, 2025 at 11:54:18AM +0100, Gerd Hoffmann wrote:
>Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>Reviewed-by: Ani Sinha <anisinha@redhat.com>
>Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>---
> backends/igvm.c       | 5 +++++
> backends/trace-events | 2 ++
> 2 files changed, 7 insertions(+)
>
>diff --git a/backends/igvm.c b/backends/igvm.c
>index a01e01a12a60..4cf7b572347c 100644
>--- a/backends/igvm.c
>+++ b/backends/igvm.c
>@@ -20,6 +20,8 @@
> #include "system/address-spaces.h"
> #include "hw/core/cpu.h"
>
>+#include "trace.h"
>+
> #include <igvm/igvm.h>
> #include <igvm/igvm_defs.h>
>
>@@ -886,6 +888,8 @@ IgvmHandle qigvm_file_init(char *filename, Error **errp)
>         error_setg(errp, "Unable to parse IGVM file %s: %d", filename, igvm);
>         return -1;
>     }
>+
>+    trace_igvm_file_loaded(filename, igvm);
>     return igvm;
> }
>
>@@ -903,6 +907,7 @@ int qigvm_process_file(IgvmCfg *cfg, ConfidentialGuestSupport *cgs,
>         return -1;
>     }
>     ctx.file = cfg->file;
>+    trace_igvm_process_file(cfg->file, onlyVpContext);
>
>     /*
>      * The ConfidentialGuestSupport object is optional and allows a confidential
>diff --git a/backends/trace-events b/backends/trace-events
>index 45ac46dc2454..7a00e9bf6c16 100644
>--- a/backends/trace-events
>+++ b/backends/trace-events
>@@ -26,3 +26,5 @@ iommufd_backend_invalidate_cache(int iommufd, uint32_t id, uint32_t data_type, u
> igvm_reset_enter(int type) "type=%u"
> igvm_reset_hold(int type) "type=%u"
> igvm_reset_exit(int type) "type=%u"
>+igvm_file_loaded(const char *fn, int32_t handle) "fn=%s, handle=0x%x"
>+igvm_process_file(int32_t handle, bool context_only) "handle=0x%x context-only=%d"
>-- 2.52.0
>

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>


