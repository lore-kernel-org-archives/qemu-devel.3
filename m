Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC9CCD609DB
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 19:32:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vValp-0000xa-19; Tue, 16 Dec 2025 14:31:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVall-0000xG-Ig
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 14:31:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vValj-0004A8-VO
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 14:31:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765913494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cofkPrxdprT3guCmCwDMtm4wLqM859nOJoDdI7hjkq4=;
 b=KZfOfmjLrzNp2GI/baOzyF70SZ1wQ8MnnoUmLCrxkjJJdnDvWBo/+MEX2GrotjTjPBk+Ow
 EhqwKSFCHmGpmAIz/zWl86KpyKGisEk2oCNxZgpJjTzOE0JuYR5yLn6KcHKTf7qFNrNzJ2
 +jCaGz+ZnTSE+wcJm5e9oXSZlwKjSPo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-MkZvBykJPJq_cCWdnsTiNQ-1; Tue, 16 Dec 2025 14:31:33 -0500
X-MC-Unique: MkZvBykJPJq_cCWdnsTiNQ-1
X-Mimecast-MFC-AGG-ID: MkZvBykJPJq_cCWdnsTiNQ_1765913492
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4f1d7ac8339so148289281cf.2
 for <qemu-devel@nongnu.org>; Tue, 16 Dec 2025 11:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765913492; x=1766518292; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cofkPrxdprT3guCmCwDMtm4wLqM859nOJoDdI7hjkq4=;
 b=VNFtnFEi5SrL0yH69pUgQdhtxnmTKdgdaWnPtEQgGpc5dKKFGr3W+SqB1PzruN7v23
 h1klVOhVqqnQKIw6efICMi482XIL7XOlVpCseYGIUzdVrT/mXq9Qa0GO5OjbL3ukkw+G
 sAvSn6N1bV3JNc2p6uFtSMq/L9hGxVtpvSU1fTl3ge+xK4bvfHTw5F4zfqt8q/TH8322
 gTqWpQOGpKY2CrrSip5TGEVJfLcrG14FusFTLa/pTl7LU0VeyWwaqjCZMkC5EluAs2MP
 I8pPupc1uufQvvUp/n8kVi/yarUNla2ZbHRH4/yau+bZLWCSpe8i+U/vxGLmKxNg8Nzk
 kj+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765913492; x=1766518292;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cofkPrxdprT3guCmCwDMtm4wLqM859nOJoDdI7hjkq4=;
 b=M1wcIfHYqe8oL7IJMUkP7FV65gGiNWEG12soQ81oTWkirLQIE4nyLr04o8hqx+ODiZ
 PWZeKyydUFoEjqGmxpuYGj8ojovFZvg7LzposqIC9zoPft2EUHvwLSWCjPmW2CK5aDBk
 fnELMEkuxsEOmPQGLfJ6bP+bQGA8evQywLN7UK/523LKS/Kgedl2aUhTX9mYvM5sKqzg
 MuMYWCPRMFWumwhs5mp1qYHZ/IJdis/e6pN1VsPmwm9Ofg4FMwtcKshCTqahJWaI7LtS
 LmsGqqH40uofoPeC0hhNYAEF6QY0ChbXl8Z/FBf5WHNw1kejYyOsBeH0jDKqxu97v2lJ
 TN/g==
X-Gm-Message-State: AOJu0YzI8/d/DRF5j96ZWwFYreIvceF9odqE+Zqzu2i6x14h4/SxvouL
 NUDibevXAM3i5E8O9F2rtpxzP7GsEwiig+lJSi/wVCH/uUQL7h7W/d+s21aD5lVxEgiyGOGnhgl
 EIs0ScZ7SAXaCgCKYz9ovwtmcYtEnGrT+Wc8V3yg6KFMMA1csgzbADPMZ
X-Gm-Gg: AY/fxX7s6bXgc9hXUV36qt9iltt1ssZ01wcHkbveE6/jWNafk7ITNQNlZwv2QftSJ8H
 OiIqsnasabevKrP33mCmIFDi+vmr1qJFteZbLDm2IPlssBwI9blLzkiub27u+jLO6yOQGGFRpT8
 za2dCc0chaZuv1HiHBM5L/xfAIaOgHo2MyYltRMFAGBGkRS8d6lILeYONXcolj6eiu0cwahbMSH
 0wwQ85FSawCH3qEZUOxQSWD+EKAjZA8XSK1Zr460PocCVBYHhYylgU3grNY8p4hWYju4Ugs8jDB
 wQGFawQra8CD1JgskOCwXsu9LuMFyISkUDJGNkszMjyFJrC6pEM0PDVew+2pnRUP7KOZO58NcrN
 bXIc=
X-Received: by 2002:a05:622a:1455:b0:4f1:cbdc:28 with SMTP id
 d75a77b69052e-4f1d05aed11mr206500451cf.52.1765913492254; 
 Tue, 16 Dec 2025 11:31:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBYnmuwupzXP0kFl/ASRThV60ieoRXgbZt0WBtEZ3widT/cY5gZJe6Rwb4xRXT7g1vHhP3OA==
X-Received: by 2002:a05:622a:1455:b0:4f1:cbdc:28 with SMTP id
 d75a77b69052e-4f1d05aed11mr206500011cf.52.1765913491777; 
 Tue, 16 Dec 2025 11:31:31 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4f345c2e5f7sm19841981cf.20.2025.12.16.11.31.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Dec 2025 11:31:31 -0800 (PST)
Date: Tue, 16 Dec 2025 14:31:30 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com
Subject: Re: [PATCH v3 14/51] migration: Use QAPI_CLONE_MEMBERS in
 migrate_params_test_apply
Message-ID: <aUGzkpyNcLE2bixw@x1.local>
References: <20251215220041.12657-1-farosas@suse.de>
 <20251215220041.12657-15-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251215220041.12657-15-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Mon, Dec 15, 2025 at 07:00:00PM -0300, Fabiano Rosas wrote:
> Use QAPI_CLONE_MEMBERS instead of making an assignment. The QAPI
> method makes the handling of the TLS strings more intuitive because it
> clones them as well.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/options.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/migration/options.c b/migration/options.c
> index 6b60003a32..2901b37228 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -1262,9 +1262,9 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
>  static void migrate_params_test_apply(MigrationParameters *params,
>                                        MigrationParameters *dest)
>  {
> -    *dest = migrate_get_current()->parameters;
> +    MigrationState *s = migrate_get_current();
>  
> -    /* TODO use QAPI_CLONE() instead of duplicating it inline */
> +    QAPI_CLONE_MEMBERS(MigrationParameters, dest, &s->parameters);
>  
>      if (params->has_throttle_trigger_threshold) {
>          dest->throttle_trigger_threshold = params->throttle_trigger_threshold;
> @@ -1283,24 +1283,18 @@ static void migrate_params_test_apply(MigrationParameters *params,
>      }
>  
>      if (params->tls_creds) {
> +        qapi_free_StrOrNull(dest->tls_creds);
>          dest->tls_creds = QAPI_CLONE(StrOrNull, params->tls_creds);
> -    } else {
> -        /* clear the reference, it's owned by s->parameters */
> -        dest->tls_creds = NULL;
>      }
>  
>      if (params->tls_hostname) {
> +        qapi_free_StrOrNull(dest->tls_hostname);
>          dest->tls_hostname = QAPI_CLONE(StrOrNull, params->tls_hostname);
> -    } else {
> -        /* clear the reference, it's owned by s->parameters */
> -        dest->tls_hostname = NULL;
>      }
>  
>      if (params->tls_authz) {
> +        qapi_free_StrOrNull(dest->tls_authz);
>          dest->tls_authz = QAPI_CLONE(StrOrNull, params->tls_authz);
> -    } else {
> -        /* clear the reference, it's owned by s->parameters */
> -        dest->tls_authz = NULL;
>      }
>  
>      if (params->has_max_bandwidth) {
> @@ -1357,7 +1351,6 @@ static void migrate_params_test_apply(MigrationParameters *params,
>      }
>  
>      if (params->has_block_bitmap_mapping) {
> -        dest->has_block_bitmap_mapping = true;
>          dest->block_bitmap_mapping = params->block_bitmap_mapping;

Now "dest" came from a QAPI_CLONE, does it also need explicit free and
QAPI_CLONE() from params->block_bitmap_mapping?

I think this part looks fine when the whole set is applied, so it's only a
question of intermediate stage of this patch.

>      }
>  
> @@ -1532,6 +1525,14 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
>  
>      migrate_params_test_apply(params, &tmp);
>  
> +    /*
> +     * Mark block_bitmap_mapping as present now while we have the
> +     * params structure with the user input around.
> +     */
> +    if (params->has_block_bitmap_mapping) {
> +        migrate_get_current()->has_block_bitmap_mapping = true;
> +    }

Should this be put into the if block below?  Aka, when we decide to apply
the parameters?

> +
>      if (migrate_params_check(&tmp, errp)) {
>          migrate_params_apply(params);
>          migrate_post_update_params(params, errp);
> -- 
> 2.51.0
> 

-- 
Peter Xu


