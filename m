Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22985CCD183
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 19:14:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6D8e-00070Z-11; Tue, 07 Oct 2025 15:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v6D8d-00070R-7i
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 15:14:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v6D8Z-0007UX-SC
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 15:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759864453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FzYADlvQo4MFxOTkXgK5dyGT7LkDSaJ8DJh8LjwOnYU=;
 b=gD0AjoMFkoJ6QYQhkUhUqN7dTbJyanNmcIXpPYT1TpTkQ2+4o5CGddLqbgHpAX4ecxgWJX
 9+HWKEol9wqkd5kDajctGP43wrfKsRuEjUgu/zGEXTxHs4uvN5608i7fNHZKPOaCk++Kxw
 FFLSH0+Umu2erCXG4FOcaZjptE+ktW4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-2pDm2u-OMEa7xjUY-jN99A-1; Tue, 07 Oct 2025 15:14:12 -0400
X-MC-Unique: 2pDm2u-OMEa7xjUY-jN99A-1
X-Mimecast-MFC-AGG-ID: 2pDm2u-OMEa7xjUY-jN99A_1759864451
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-879e66b788bso169586696d6.2
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 12:14:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759864451; x=1760469251;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FzYADlvQo4MFxOTkXgK5dyGT7LkDSaJ8DJh8LjwOnYU=;
 b=Ja+syh6zlRfH/AVGXDDsLVkhXLBkWWTocrq8EQ4U9IrezadvV/UoVdUcro0p8+3QBM
 Y2B8o6nZlYy8Sg3HorM0D8VBgDDZVK+MGjnlRyRGOpGIrGK8lpquQm7TC+LYexCoZNCb
 +hvSLc+wyRBRPSA6QF3V1AYrHvQU5B1rdPUi9EyL7P4lu8d/nXt0XpAbNXNp4E4QkjBa
 +MltWqjk7vapq/LJB0ppZAPqMfigx1Axb9VWHSvBkc7QYpVdUPxAJHsLBSXUjYx28TsW
 QX2yaqZnqwTmxzYq+mhTiGby5tfuNNiEOrcTmJPD03hRAGBpSr5dO0CkWnwqLUTGWjvK
 09DQ==
X-Gm-Message-State: AOJu0Yx1OPt+AUPipNBKV7I0I+FKCLaJqngVWzCypk3C4LQYg/bnRzar
 r3CjDCtoK2NSfzuHzLTKqT90D6dKN6iYOy0jCOnCeC+dIFwGfUNeVM5Ve9YGR3pJ9LUFs+5iEh1
 Mhk/k3QTziNLKERcnCHChnh28joATu3lkqhNtsDXT0JplaTncFQXMlYOJ
X-Gm-Gg: ASbGncuPog/R9AGFel6Z8eijQYc5sKKi9Mnssmlt2rPiyJ2MRVQCX7TPfPjvk38EPom
 7/i/L/OqmAO4mDAYSmICBf2KfG2cNsZD3r9cNtrdCBPd/QftZ3GimNAusRZP317i0mL37FzA/c4
 avnsGVpMdnf7Lavu7c3/FhjcATCP+OeWWRy8dhI+cXO7z8bOe1Vc7FupzBnG/2fjNHpI6CuEsjs
 ulruR0FtYgVytG01x0ub0paGcb/vzSvw4JzQ818sha29ZPaJtpsrjPwfWOI34llKDdO88s//UGW
 jDYkUNSu99Du/TR7Zyrhtjg8IyURTYd22CxQWQ==
X-Received: by 2002:a05:6214:b6d:b0:7f7:708e:4797 with SMTP id
 6a1803df08f44-87b2100104bmr9123866d6.12.1759864450740; 
 Tue, 07 Oct 2025 12:14:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFC9936ouavcOv/TKxm94DmGyZ7fsb/3cGZDeT5XsDUlBuUTtEnsJRBZuOCBWzblAFdmS9dvQ==
X-Received: by 2002:a05:6214:b6d:b0:7f7:708e:4797 with SMTP id
 6a1803df08f44-87b2100104bmr9123416d6.12.1759864450196; 
 Tue, 07 Oct 2025 12:14:10 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bae60126sm146656656d6.6.2025.10.07.12.14.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 12:14:09 -0700 (PDT)
Date: Tue, 7 Oct 2025 15:14:07 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Marco Cavenati <Marco.Cavenati@eurecom.fr>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [RESEND] migration/savevm: Add a compatibility check for
 capabilities
Message-ID: <aOVmfzJFa1C7aaF1@x1.local>
References: <20251007184213.5990-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251007184213.5990-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

queued.

+Dan

On Tue, Oct 07, 2025 at 03:42:13PM -0300, Fabiano Rosas wrote:
> It has always been possible to enable arbitrary migration capabilities
> and attempt to take a snapshot of the VM with the savevm/loadvm
> commands as well as their QMP counterparts
> snapshot-save/snapshot-load.
> 
> Most migration capabilities are not meant to be used with snapshots
> and there's a risk of crashing QEMU or producing incorrect
> behavior. Ideally, every migration capability would either be
> implemented for savevm or explicitly rejected.
> 
> Add a compatibility check routine and reject the snapshot command if
> an incompatible capability is enabled. For now only act on the the two
> that actually cause a crash: multifd and mapped-ram.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2881
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/options.c | 27 +++++++++++++++++++++++++++
>  migration/options.h |  1 +
>  migration/savevm.c  |  8 ++++++++
>  3 files changed, 36 insertions(+)
> 
> diff --git a/migration/options.c b/migration/options.c
> index 5183112775..d9227809d7 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -445,11 +445,38 @@ INITIALIZE_MIGRATE_CAPS_SET(check_caps_background_snapshot,
>      MIGRATION_CAPABILITY_VALIDATE_UUID,
>      MIGRATION_CAPABILITY_ZERO_COPY_SEND);
>  
> +/* Snapshot compatibility check list */
> +static const
> +INITIALIZE_MIGRATE_CAPS_SET(check_caps_savevm,
> +                            MIGRATION_CAPABILITY_MULTIFD,
> +                            MIGRATION_CAPABILITY_MAPPED_RAM,
> +);
> +
>  static bool migrate_incoming_started(void)
>  {
>      return !!migration_incoming_get_current()->transport_data;
>  }
>  
> +bool migrate_can_snapshot(Error **errp)
> +{
> +    MigrationState *s = migrate_get_current();
> +    int i;
> +
> +    for (i = 0; i < check_caps_savevm.size; i++) {
> +        int incomp_cap = check_caps_savevm.caps[i];
> +
> +        if (s->capabilities[incomp_cap]) {
> +            error_setg(errp,
> +                       "Snapshots are not compatible with %s",
> +                       MigrationCapability_str(incomp_cap));
> +            return false;
> +        }
> +    }
> +
> +    return true;
> +}
> +
> +
>  bool migrate_rdma_caps_check(bool *caps, Error **errp)
>  {
>      if (caps[MIGRATION_CAPABILITY_XBZRLE]) {
> diff --git a/migration/options.h b/migration/options.h
> index 82d839709e..a7b3262d1e 100644
> --- a/migration/options.h
> +++ b/migration/options.h
> @@ -59,6 +59,7 @@ bool migrate_tls(void);
>  
>  bool migrate_rdma_caps_check(bool *caps, Error **errp);
>  bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp);
> +bool migrate_can_snapshot(Error **errp);
>  
>  /* parameters */
>  
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 7b35ec4dd0..aafa40d779 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -3322,6 +3322,10 @@ bool save_snapshot(const char *name, bool overwrite, const char *vmstate,
>  
>      GLOBAL_STATE_CODE();
>  
> +    if (!migrate_can_snapshot(errp)) {
> +        return false;
> +    }
> +
>      if (migration_is_blocked(errp)) {
>          return false;
>      }
> @@ -3507,6 +3511,10 @@ bool load_snapshot(const char *name, const char *vmstate,
>      int ret;
>      MigrationIncomingState *mis = migration_incoming_get_current();
>  
> +    if (!migrate_can_snapshot(errp)) {
> +        return false;
> +    }
> +
>      if (!bdrv_all_can_snapshot(has_devices, devices, errp)) {
>          return false;
>      }
> -- 
> 2.35.3
> 

-- 
Peter Xu


