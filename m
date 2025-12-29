Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9555E9273E
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 16:34:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaGBy-0006v9-Gz; Mon, 29 Dec 2025 11:33:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vaGBo-0006us-Kn
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 11:33:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vaGBm-0007Ss-Pr
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 11:33:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767026022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dvK7P/kl9iHht2r/rUEdMR8jJZONhEjWbp3U4M8wv1A=;
 b=V3lw1iCGT7zsWEid7sCnHW9p4xibFoqB8zf9oGufoBYGER6I+N5gky2Bj8Mm970uRQ8iQq
 I2s3bCPY5K8gUCvc/9sQ8qhMGKc2LWJHHX0ds4e8l1yoetVDmoyZDjIptH9yZFjdFp5cvL
 bzcZDhyd7+I77J7sane4IwlDSqFim2I=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-dub5Yw9jPbyCc0CGZ5EhiQ-1; Mon, 29 Dec 2025 11:33:40 -0500
X-MC-Unique: dub5Yw9jPbyCc0CGZ5EhiQ-1
X-Mimecast-MFC-AGG-ID: dub5Yw9jPbyCc0CGZ5EhiQ_1767026020
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8888a6cb328so239182476d6.0
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 08:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767026020; x=1767630820; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dvK7P/kl9iHht2r/rUEdMR8jJZONhEjWbp3U4M8wv1A=;
 b=s+6dWXFoU5E46GBI/sPWCBkcq47aSxjiEwttQRJagImlCKpDGY9lbBS8pUF+Ggstke
 2GbQ3W0bUM3nomDVuv9yl8GI2MHnrHcBmcUusFyfqRrciZ2NzpWmkE2AZiSqWAiDNbS3
 TwI4kIcHFEfaGIyJ7wpwJCXPDZEfrTiY83NxCiKpYknsP7x2bFbnuiCLfjIK43xYkyIk
 0w3UIEW2xW1nRBRtyPC7Nv0yRPWldXUAevvnTlhKmli8bkF0s1W4iznkM5A+snaVsltU
 iuWQ0jO2SjQw0C/iv9w3TZlUQ22rOu/zjUsfWgBSmG0OsEuswXt+urInXGx65ktEXoqE
 O1pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767026020; x=1767630820;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dvK7P/kl9iHht2r/rUEdMR8jJZONhEjWbp3U4M8wv1A=;
 b=XDc94WAt3G1kuPQq5qIeyiZzkvGMzFg1k2d1tmhF6DbWTdPh6MYIZORCQzgxCzMnT2
 xvgfPjYvDa1mJDIwDMbjSTOeSH5XkqHMq4nt9ol9s4WZMjP0fyLKIsdm7tpv08fHzOcy
 WpMLjyUHNxaCfbaemjmTGoxi8jApIZNcme9SoZhlqoQQELstjmNDdZKnpd3uaBgcWz+z
 Jqh/uHOt8Mh/WQ71uIT9yzx9+y0z1oZmv07b/T7/DBha0P9gMPU1cjvPTaDClX1z69QS
 W1QBpMshsimP9CS64oasXbQq4vjG9IhsD9hQJPRc56IfX1+3urvvp3gwzIcAc4z9z8l7
 Bi0w==
X-Gm-Message-State: AOJu0Yyz+KLD1skBJOot3tlR0y7T+9QcU+d7Y5GOB7zbRHcub9+fybyO
 15xDzjtwnshCUflwt3vv14k5K1PU7BbLHVQRnLIemEsyZIpLKE/0kQMZCddvDpRWpR4fo+lGQee
 XGiObNFE3alhhESeRXmwgcrMv3ZpyvOs+CpwtF4CGXh9wQqktNjtQWQ9A
X-Gm-Gg: AY/fxX7kG7LxeWNCfx6mJAiQZWtq7fMqyH4onkWezLjvNB2qI3+TvMG2cMt3NnIH+dF
 OPg1tby05Ob5GeMbF1HF5lGSitIkACSVg2s2F3fQ1QlX4NFNoRy5DmT7a8PzIDlR1Dg5G2dKh/r
 py7piXbJHa52YX5SKj3CGSfI2KxnGXvIQYGksjCgDgcTLiIXWxHAHPfJ7LSGova8gBz+vHjE5SH
 tyTVngnofi2KwAjaLH6ZuEIPQim0NTd3g8f1Zw1uk1bmigWLxkYQfP+DCKFzQsTXLQ1iGeZ5lVP
 2E/uiWtkkRF3KAUJbvSy6rLnpxjCHkFYn9BAbnoiLW1/zQpsY/OTYnFQaRgHuRIV2o1VzGbSjbS
 92Ws=
X-Received: by 2002:a05:6214:20ce:b0:87d:e2b:cdf7 with SMTP id
 6a1803df08f44-88d8442e459mr467741146d6.66.1767026020199; 
 Mon, 29 Dec 2025 08:33:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIiHKmgwfxodgwYWUJov6xQSYDdBj4ulSSl+Y+nwqV2ucw5DaRr5I1GCGzafg0Z4pArBqitQ==
X-Received: by 2002:a05:6214:20ce:b0:87d:e2b:cdf7 with SMTP id
 6a1803df08f44-88d8442e459mr467740766d6.66.1767026019703; 
 Mon, 29 Dec 2025 08:33:39 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4f4ac62fa56sm240107511cf.17.2025.12.29.08.33.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 08:33:39 -0800 (PST)
Date: Mon, 29 Dec 2025 11:33:38 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 07/25] migration: Use migrate_mode() to query for
 cpr-transfer
Message-ID: <aVKtYlK_4eLFEds_@x1.local>
References: <20251226211930.27565-1-farosas@suse.de>
 <20251226211930.27565-8-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251226211930.27565-8-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Fri, Dec 26, 2025 at 06:19:09PM -0300, Fabiano Rosas wrote:
> cpr_set_incoming_mode() is only called on the target side, so
> migrate_mode() on the source side is the same as s->parameters.mode.
> 
> Use the function to reduce explicit access to s->parameters, we have
> options.c for that.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

Said that, we have three more users outside options.c.  Wanna do it
together?  They are:

  migration_call_notifiers, migrate_mode_is_cpr, migrate_prepare.

> ---
>  migration/migration.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index f2933f7789..4b1afcab24 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2252,7 +2252,7 @@ void qmp_migrate(const char *uri, bool has_channels,
>          return;
>      }
>  
> -    if (s->parameters.mode == MIG_MODE_CPR_TRANSFER && !cpr_channel) {
> +    if (migrate_mode() == MIG_MODE_CPR_TRANSFER && !cpr_channel) {
>          error_setg(errp, "missing 'cpr' migration channel");
>          return;
>      }
> @@ -2277,7 +2277,7 @@ void qmp_migrate(const char *uri, bool has_channels,
>       * in which case the target will not listen for the incoming migration
>       * connection, so qmp_migrate_finish will fail to connect, and then recover.
>       */
> -    if (s->parameters.mode == MIG_MODE_CPR_TRANSFER) {
> +    if (migrate_mode() == MIG_MODE_CPR_TRANSFER) {
>          migrate_hup_add(s, cpr_state_ioc(), (GSourceFunc)qmp_migrate_finish_cb,
>                          QAPI_CLONE(MigrationAddress, addr));
>  
> -- 
> 2.51.0
> 

-- 
Peter Xu


