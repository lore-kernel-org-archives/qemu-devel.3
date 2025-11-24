Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A6C8CFA466
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 14:12:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNXIb-0000Sm-Rf; Mon, 24 Nov 2025 09:12:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vNXIF-00005W-En
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 09:11:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vNXIB-0006PU-Fv
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 09:11:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763993506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JEqBC79Wz0Fc9sPxvQgKKjDZ9Tufny1JMqjjVTiD1Vc=;
 b=He+YfF+MLLLPOsO9OKj10KocK5Brdd2yk9EeO30CNjH3kLKh/YeOF71Mf3PtpfdhmuVyWe
 1LdlOH1/qMfInhS0Dt4CRPNned6mhisady5rWvCGa9cACLhup0JbqIebRbOCxOqtOPs53v
 enEU0clIs1OnL65hfoA6I46il6yMqGA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-yeB0SEwcMwClGOAac2g0XQ-1; Mon, 24 Nov 2025 09:11:44 -0500
X-MC-Unique: yeB0SEwcMwClGOAac2g0XQ-1
X-Mimecast-MFC-AGG-ID: yeB0SEwcMwClGOAac2g0XQ_1763993504
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-880441e0f93so144245136d6.1
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 06:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763993504; x=1764598304; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JEqBC79Wz0Fc9sPxvQgKKjDZ9Tufny1JMqjjVTiD1Vc=;
 b=a+gELqYVjv5S1IzgUjsZH8QKXsGk7H1VHp22GloNoquMzX568leAnrXZv1qzL8ZZwT
 gjQWWZmfESyNygtryYKJy5xNXbbmlqZn2dTOHOtLK1hwFX6QV11YvOL2/NnmbHnToxZR
 UvSfHhBdDAew/zNdqPMG+GXPxDyE6H51OqTKalZVgANYkX9pO7EkmvSKIhkAqeWOFyWE
 3l9jcJciTpuBue+sTSeM1A24kqxVoahMus+BxArM4cYA/3c6hTK+SB9wVQrU9iRUn7EI
 XcWW8njuavchccXe+MFL+uvU9b3PyjlmlblWBBuW3TgQ5k6KRiihC4mXSRNwQVtpHR9T
 ypUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763993504; x=1764598304;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JEqBC79Wz0Fc9sPxvQgKKjDZ9Tufny1JMqjjVTiD1Vc=;
 b=VKnFZ8FsDJJhshvS7siFaMHrhDAucJ5pm9aLB9QFlweN8ynXrbP+ynasmzRipaRNUM
 iN2qbdYTc2dUUODsmLDHhuqdGKFVEaiOw6eYFgqk7GIPkWYpicmqTVWGslzd4dCArASo
 zXoQi2jxs4/7OpjBUeXR9mfNY2CUYizUPf/cLeu634SRm5HBoazpni/saGYaUpnNntvB
 7aSY2V+kG1fp+Q5olXesic+fb9YuXnhnD/sFrlC01gKQyMf+mRsHiby/O/Y3bjtVdMDX
 rjlX8gfK2Qq7MzzJl5bHvtnpKMGFw/G3rB1FqhB0UJR6Ey0JGBbGI/WX+Ez7JvpiMsLo
 I/lg==
X-Gm-Message-State: AOJu0Yz/D1YcE0m7ioTIQdnui/VUkTjUlyFN1at0a3+20oEDa/OPEcsP
 8csW48QuAuZzAFWT4KCJggHnRpt1pY7H4tpCzEnM4ZgW9ChC+Sp+Fs9Bg6wW52dCw8sWZjHyXfE
 OAPSjyzjZb5/rED3rgzuQL+hD8iDjkYiA7u6ZEhnMIq+pis7Dr+nYN3Zj
X-Gm-Gg: ASbGncsYRPnpfXxIh+asDxmKR/zfhhsU0MNMfnxKdDcZepJe8/RhHX2nqtqXFxwiJRa
 vfhnDhgUdmaZ3JG5IeUl3qtlSJZiycN3DzAPEweIbbghL36EDSH1rnn4Ln4fmHILnUGzwLXFJ2k
 EYBL5J+fXisZq9g3j52wQB8ezcSkFsL4wWIx+48788NNJveLmhGqbAFSJDABOzvnF0FuM2ctfcy
 a3HRycOk4sRqxb1iew3TAtENxa6VygvsAhEcvIh+6FPPsHoj59w4Xgr6V1QPuvAippt9vmwja9s
 URaOrOt5SRaU9QgngfHeh1ty0QUIRkFDC0RJ5LNkBYXhEolxLaF9aYmZL8TrJRVYbCR58IST16j
 lE7vOgpqJiS/20RlAvEN1VLIoQVGvMTN+h1xTVgGEPDC45EIXhSFja/9aavuWPg==
X-Received: by 2002:a05:6214:4a87:b0:882:6b8e:3143 with SMTP id
 6a1803df08f44-8847c4c4ccemr170314936d6.18.1763993504056; 
 Mon, 24 Nov 2025 06:11:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtqHfPt/tF6fVEesGJBwuPFs7THX9Wdxnw3/zeJeQaPfV3+ywy+zDOKRxlGzNdgIrjn0MKjA==
X-Received: by 2002:a05:6214:4a87:b0:882:6b8e:3143 with SMTP id
 6a1803df08f44-8847c4c4ccemr170314356d6.18.1763993503641; 
 Mon, 24 Nov 2025 06:11:43 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-139-91.business.telecomitalia.it.
 [87.12.139.91]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8846e573909sm102233176d6.39.2025.11.24.06.11.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 06:11:43 -0800 (PST)
Date: Mon, 24 Nov 2025 15:11:37 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>, 
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Luigi Leonardi <leonardi@redhat.com>, Oliver Steffen <osteffen@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 3/4] igvm: add trace point for igvm file loading and
 processing
Message-ID: <6nrtckcyxijhohelhkuo6tpgnpis3dsxbzoph6fphym6zfmubd@o3gofvfi4474>
References: <20251118122133.1695767-1-kraxel@redhat.com>
 <20251118122133.1695767-4-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251118122133.1695767-4-kraxel@redhat.com>
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

On Tue, Nov 18, 2025 at 01:21:31PM +0100, Gerd Hoffmann wrote:
>Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>---
> backends/igvm.c       | 5 +++++
> backends/trace-events | 2 ++
> 2 files changed, 7 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/backends/igvm.c b/backends/igvm.c
>index 05d197fdfe85..a350c890cc95 100644
>--- a/backends/igvm.c
>+++ b/backends/igvm.c
>@@ -18,6 +18,8 @@
> #include "system/address-spaces.h"
> #include "hw/core/cpu.h"
>
>+#include "trace.h"
>+
> #include <igvm/igvm.h>
> #include <igvm/igvm_defs.h>
>
>@@ -884,6 +886,8 @@ IgvmHandle qigvm_file_init(char *filename, Error **errp)
>         error_setg(errp, "Unable to parse IGVM file %s: %d", filename, igvm);
>         return -1;
>     }
>+
>+    trace_igvm_file_loaded(filename, igvm);
>     return igvm;
> }
>
>@@ -901,6 +905,7 @@ int qigvm_process_file(IgvmCfg *cfg, ConfidentialGuestSupport *cgs,
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
>-- 
>2.51.1
>


