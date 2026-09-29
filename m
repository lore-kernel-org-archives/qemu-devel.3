Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3FD8CA5FA7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 18:23:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBcTq-0004zK-TX; Tue, 29 Sep 2026 14:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xBcTo-0004ys-LQ
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 14:23:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xBcTm-0008WA-Uo
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 14:23:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790706181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KLyZWCzpXUd6rzDusgOp+3kMOSGxnG0XGr63e8C2GR0=;
 b=K8d4KmU/3k9eG2Z3OPfOgp1vMOdF7/LrtBHMKt5cD8I09W5Vtr+k0Ow698RCi6ZFEVHYSv
 IzETa8kB51IDb45BVWmSWmYGGWMH3jrqjWr+hHcfLkYK5rqAvO6gjz6ZwBm9aeMOGObZSl
 jwyBfBxSS1lY4AzubSI9O257pH8sI+0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-M6v0JGlnMOi55OUONdDBGA-1; Tue, 29 Sep 2026 14:22:59 -0400
X-MC-Unique: M6v0JGlnMOi55OUONdDBGA-1
X-Mimecast-MFC-AGG-ID: M6v0JGlnMOi55OUONdDBGA_1790706179
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-9106fce784dso91062476d6.2
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 11:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790706179; x=1791310979; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KLyZWCzpXUd6rzDusgOp+3kMOSGxnG0XGr63e8C2GR0=;
 b=MKYRRa/TWp4EHbjk8WISiDMV6cw7pFRA/bHD7tXAvGVYpclz2YnezyYOSjlbqtDG14
 hnQqVECAjjAoNWEEtoOSQhMWtFr2k7k62jw5ZMZ7p6ORtRvLX4rB//wOYpnSuq9CvEfE
 WbCZFNM5I9vFizNW5mddA7ptJPmjyStbr5aYL7Nthm/vXdJ2CrxER050O//WIoHSEHnX
 lS5AOEvees/9JOLEZslTXLoeGoqiWzzPZG3coXfozbR0Zwd5CSoqTE712du4bKmnw6Ut
 kGehw1VugNysi6uQUN8t9df7UqSb5o6JdKJI8zvjjQ0HewfRRER4BI+gzECdkfmgUtZO
 Ct2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790706179; x=1791310979;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KLyZWCzpXUd6rzDusgOp+3kMOSGxnG0XGr63e8C2GR0=;
 b=OsnoGusPoEIaVy7Hp6vKOSSe8+F+CF/7qbPqxTzkrxgBV6rt1kxnYX2WPQmklRYdyp
 eg3WNRe07iiuLWDVIAwBCtVJ2NcFL1xS2JvVHA/814BhI+QPh/EkzadYykp75M6bz47f
 EdMylItptCcX08F4P6awOn9x591Ofc12RVeeKPPza3tu1yfAJ04+bOa+VZVd47Rr4jOB
 PSV5y9BSBVwOhr0Bm+Wocwo1wlN1eKWn5ipgp+/qa9tP8rj+nykgvTuqJqQW9gtmCudM
 ew3Azgz6yZ2R53zBtGH4OVO4vknwA81mDCZc5IVPSBTRLmxhH/MqzvAZWZWKi36L9IpJ
 rKBA==
X-Gm-Message-State: AFuF++kKfKTJeSGGy+B/h4wplzvqqKDQx5esGxjRNaCXG5Q5JvAv4ldI
 Sfa7OyoFIJDdEeklsf7WjXsF3wUV3GCtHACsARCeCQvDjAqOADcMa0u2sB8sfg5gbowPQDuH+kM
 cgBo/IU2lfuyw9y9Sq+ajQ21cF2z/u/8n1xpmmas4fyWWauEtBn4PlA/r
X-Gm-Gg: AYBFou0BvYbnHPd71yj3eTzGzK9sSgZbBnLYQtyTZHYjd6HzT6DwA2Pd/HO7inLWsms
 /7a9mDb6kKS/itJQ2YVk5iVQ+2Bg3hnY3wvG6skHdj1phXZ5eI82nDGYhbzCr9+H7KS6d88myLl
 4XyvwrSlKyHHOGqQlo5K0V55kf9N2fF0Ie+XmvDsDEumIbeZPb5Q6eWvHlhjIli5BS5Zw0twug1
 QwJpEj83Jcwgm/pS2jxQILpmQNpa8nnEiJE7wKl7BJvqUp0ugFXyV6Vpub1yRvsxIxYu+FCIVZs
 NZkmSu/fBRKumeHL9yj6OInO7wWZQPngejOsT2E/Ln2cMuiS+60r26VYENDDq+mr5icr55U=
X-Received: by 2002:a05:6214:5344:b0:917:86e7:1129 with SMTP id
 6a1803df08f44-91799845c78mr79026d6.6.1790706178889; 
 Tue, 29 Sep 2026 11:22:58 -0700 (PDT)
X-Received: by 2002:a05:6214:5344:b0:917:86e7:1129 with SMTP id
 6a1803df08f44-91799845c78mr78316d6.6.1790706178272; 
 Tue, 29 Sep 2026 11:22:58 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-917989872f9sm1256376d6.48.2026.09.29.11.22.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 11:22:57 -0700 (PDT)
Date: Tue, 29 Sep 2026 14:22:56 -0400
From: Peter Xu <peterx@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, maciej.szmigiero@oracle.com,
 philmd@oss.qualcomm.com, odaki@rsg.ci.i.u-tokyo.ac.jp,
 clg@redhat.com, den@openvz.org, mark.kanda@oracle.com,
 vsementsov@yandex-team.ru, farosas@suse.de, sgarzare@redhat.com,
 bchaney@akamai.com, dongli.zhang@oracle.com,
 David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Subject: Re: [PATCH v8 04/17] migration: forbid snapshots under Xen
Message-ID: <arwCADGhCZenoYke@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260929-up-vsock-vhost-v5-v8-0-12bcf1c0b84a@virtuozzo.com>
 <20260929-up-vsock-vhost-v5-v8-4-12bcf1c0b84a@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260929-up-vsock-vhost-v5-v8-4-12bcf1c0b84a@virtuozzo.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Sep 29, 2026 at 08:23:23PM +0300, Andrey Drobyshev wrote:
> The snapshot RAM-saving path does not support Xen's memory mappings.
> Refuse 'savevm' and 'loadvm' when running as a Xen device model, the
> same way they are refused for CPR migration modes.
> 
> Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

Acked-by: Peter Xu <peterx@redhat.com>

Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Paul Durrant <paul@xen.org>

> ---
>  migration/options.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/migration/options.c b/migration/options.c
> index 92eda90114e..0b7f393492d 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -37,6 +37,7 @@
>  #include "ram.h"
>  #include "options.h"
>  #include "system/kvm.h"
> +#include "system/xen.h"
>  
>  /* Maximum migrate downtime set to 2000 seconds */
>  #define MAX_MIGRATE_DOWNTIME_SECONDS 2000
> @@ -563,6 +564,11 @@ bool migrate_can_snapshot(Error **errp)
>      MigMode mode = migrate_mode();
>      int i;
>  
> +    if (xen_enabled()) {
> +        error_setg(errp, "Snapshots are not compatible with Xen");
> +        return false;
> +    }
> +
>      if (mode != MIG_MODE_NORMAL) {
>          error_setg(errp, "Snapshots are not compatible with migration mode %s",
>                     MigMode_str(mode));
> 
> -- 
> 2.47.1
> 

-- 
Peter Xu


