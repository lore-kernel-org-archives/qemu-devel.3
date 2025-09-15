Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 547F0CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 15:47:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyBP6-00008v-WF; Mon, 15 Sep 2025 11:46:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uyBP3-00008B-OX
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 11:46:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uyBOt-0006sC-Mm
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 11:46:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757951142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+fxGt5AeT0IJNVP/fiweqHqFrzaB95yd4leksNI92jg=;
 b=A1B75L5HYm/wXiJq/qyNTxf9qAiIvkgsk0CIQaOwIrFBMwCCC2EJ528U+wFtYYY90LoTvF
 vzNXL84HteKsvmYnmnUkvu2MXPR5g1dDn1mBSPOcKF9pcoX0RYwaPM9ndfGuthwyG5K7jz
 cgA6elV6zFXsb+XXAefpud/+xfNmUyw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-gRHsJ5wiMZSv_RQpaqs5zQ-1; Mon, 15 Sep 2025 11:45:41 -0400
X-MC-Unique: gRHsJ5wiMZSv_RQpaqs5zQ-1
X-Mimecast-MFC-AGG-ID: gRHsJ5wiMZSv_RQpaqs5zQ_1757951140
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4b60dd9634dso107017141cf.2
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 08:45:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757951140; x=1758555940;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+fxGt5AeT0IJNVP/fiweqHqFrzaB95yd4leksNI92jg=;
 b=DI/zxsvg20gtj2b+/u2oWGq+vg/fXPu1IEVRdMcu0fpNr3Qd+DOhf2jmJXQCR/3LZO
 2eWE7GvTU9WJD2cUQXqkBybiw47QlmVZ6UDpWdrFqsXX6WYqbmMORBPx3Gb4UwOkk6C+
 9SnCvI72DxMPSllLjuL6MRE64HVjK4nDqiATryG+PdhUAfB5dL6CAr3Vp2pLrHjJgJ9I
 e9rIf5KtseSo4evPDaTtVBUHqNfmjAJzGB7g3Qw4aHdDHFoTuwUjRg+XLZdd2dwelsZJ
 4YrB3bBaLOVSGktPYQeneDqd9L5Y0m9cLl0H3yL9OhtO6pvCMmewUq1jAW4eOBMs/fxb
 RRGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6aKTmNXOJBZ6Bxo3yvN0Wfc0kRLUSeCcEmfguAAAsh1gD75U8c4HgiqNLi+xhKzA6VTziqYecHk33@nongnu.org
X-Gm-Message-State: AOJu0Yzsb9L0cwHEFz5FMOOSz2anAcM56/03DNyWaJQde4HRrFJ/3ETf
 lIa8dzHn4c6c0go2+Uj9ia+c+u6PD31qr5heiGM3wDCQxQHU5IRw2LbC4vEFWB0VC+4gDWr5JpX
 EWwcpXdO2VxdHGOZsEDDH55QlB4wom2YAixHvhBdx+KOStl67lH5FrED+
X-Gm-Gg: ASbGncuwIpaCI//096vNBrUCSkqGUEFy6wJ5L20suNWlGLl2mT1QFt6lRkwSAfQP/d4
 7tyQG9jwNQ5LNij/FXhPenm4XSGTIGv/zZD5yy6/8acM266viZ1tJGXEcCMWvHgwsmft8NRdslU
 jzSu05uHJkLw7nejy1cWjSiKPty5PkqcEEyhjS7kGeN8pgFFBzTuoChUfLzVCXGJYR/14L0Bhbb
 FUXWcoliRW7ds5oC+9MwkNrgypN02IBcqnBMBSmt+7lwR0rk1E9HyrXv20Qjufg/ZHippe+6qkm
 cVOXIWdSZTIJU3RNzoqnyDNqAeAzpXO7
X-Received: by 2002:a05:622a:4c0b:b0:4b7:a92d:3d99 with SMTP id
 d75a77b69052e-4b7a92d421cmr28851371cf.1.1757951140234; 
 Mon, 15 Sep 2025 08:45:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGl1h1U3aZGsXc7C3qs3PDdIunDw0pvR6fi/pXoVm4LBkeiy+I+Wnod+Mo6bvZFmkh4GQv4CQ==
X-Received: by 2002:a05:622a:4c0b:b0:4b7:a92d:3d99 with SMTP id
 d75a77b69052e-4b7a92d421cmr28850951cf.1.1757951139653; 
 Mon, 15 Sep 2025 08:45:39 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b639deecf4sm71185231cf.49.2025.09.15.08.45.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 08:45:39 -0700 (PDT)
Date: Mon, 15 Sep 2025 11:45:27 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: berrange@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 leiyang@redhat.com, marcandre.lureau@redhat.com,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH v3 04/13] util/error: add &error_reporter
Message-ID: <aMg0l0xgq3hdiDnh@x1.local>
References: <20250915132211.135095-1-vsementsov@yandex-team.ru>
 <20250915132211.135095-5-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250915132211.135095-5-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Mon, Sep 15, 2025 at 04:22:01PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Add a pair to &error_warn helper, to reduce the pattern like
> 
>     Error *local_err = NULL;
> 
>     ...
> 
>     if (!foo(..., &local_err)) {
>         error_report_err(local_err);
>         return false;
>     }
> 
> to simply
> 
>     if (!foo(..., &error_reporter)) {
>         return false;
>     }
> 
> Of course, for new interfaces, it's better to always support and handle
> errp argument. But when have to rework the old ones, it's not always
> feasible to convert everything to support/handle errp.
> 
> The new helper is used in following commits.

Could we add some explanation of why we need this if we already have
error_warn?

I don't see much difference except error_warn will prepend it with
"warning: ", but that doesn't sound like a real problem..

> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  include/qapi/error.h | 6 ++++++
>  util/error.c         | 3 +++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/include/qapi/error.h b/include/qapi/error.h
> index 41e3816380..cea95f5c36 100644
> --- a/include/qapi/error.h
> +++ b/include/qapi/error.h
> @@ -539,6 +539,12 @@ G_DEFINE_AUTO_CLEANUP_CLEAR_FUNC(ErrorPropagator, error_propagator_cleanup);
>   */
>  extern Error *error_warn;
>  
> +/*
> + * Special error destination to report on error.
> + * See error_setg() and error_propagate() for details.
> + */
> +extern Error *error_reporter;
> +
>  /*
>   * Special error destination to abort on error.
>   * See error_setg() and error_propagate() for details.
> diff --git a/util/error.c b/util/error.c
> index daea2142f3..5160435c86 100644
> --- a/util/error.c
> +++ b/util/error.c
> @@ -20,6 +20,7 @@
>  Error *error_abort;
>  Error *error_fatal;
>  Error *error_warn;
> +Error *error_reporter;
>  
>  static void error_handle(Error **errp, Error *err)
>  {
> @@ -43,6 +44,8 @@ static void error_handle(Error **errp, Error *err)
>      }
>      if (errp == &error_warn) {
>          warn_report_err(err);
> +    } else if (errp == &error_reporter) {
> +        error_report_err(err);
>      } else if (errp && !*errp) {
>          *errp = err;
>      } else {
> -- 
> 2.48.1
> 

-- 
Peter Xu


