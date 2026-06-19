Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF50CD98F8
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 08:13:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waULW-0000Bp-OI; Fri, 19 Jun 2026 04:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1waULT-0000Bb-Uj
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 04:13:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1waULR-0005Qa-Gl
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 04:12:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781856775;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=wdJSNClyAXmJ9Ql1r7cDQ9lvOhNCTs/j/80y9M2GP3I=;
 b=eWWcCJicyT4ZDiHblAdkYv4KiRMurMMzqgdgwCVH1B731vUhKUNgG2HZL5l2qIL1ONy4se
 e7oTXw6oPKkvZJiZRIW4SbMY7LTalbiyuX6boEmkCaY9aj9aInKjj2f5xN1ZnStbwus0oe
 /5ifCCa1qei0BWUOubjZwj0cwT3dJyY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-317-V6VWaTCGPJSlz2adC3FjWg-1; Fri,
 19 Jun 2026 04:12:53 -0400
X-MC-Unique: V6VWaTCGPJSlz2adC3FjWg-1
X-Mimecast-MFC-AGG-ID: V6VWaTCGPJSlz2adC3FjWg_1781856772
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 386E919560BD; Fri, 19 Jun 2026 08:12:52 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.122])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 92FA6180035F; Fri, 19 Jun 2026 08:12:50 +0000 (UTC)
Date: Fri, 19 Jun 2026 09:12:47 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Christian S. Lima" <christianslima@proton.me>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] audio: converts malloc to g_new and free to g_free
Message-ID: <ajT5_xu7JtzGINWD@redhat.com>
References: <20260619080934.237834-1-christianslima@proton.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260619080934.237834-1-christianslima@proton.me>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jun 19, 2026 at 08:09:42AM +0000, Christian S. Lima wrote:
> Following the qemu coding style change malloc to g_new, the advantage
> are that g_new can catch multiplication overflowing size_t and allow
> catch more type errors because it returns the type itself.
> 
> Signed-off-by: Christian S. Lima <christianslima@proton.me>
> ---
>  hw/audio/fmopl.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/audio/fmopl.c b/hw/audio/fmopl.c
> index a63ad0f04d..19c4b388f3 100644
> --- a/hw/audio/fmopl.c
> +++ b/hw/audio/fmopl.c
> @@ -607,24 +607,24 @@ static int OPLOpenTable( void )
>  	double pom;
>  
>  	/* allocate dynamic tables */
> -	if( (TL_TABLE = malloc(TL_MAX*2*sizeof(int32_t))) == NULL)
> +	if( (TL_TABLE = g_new(int32_t, TL_MAX * 2)) == NULL)

g_new cannot fail, so all checks for NULL must be removed too.

Unless this is a performance critical path, we'll also prefer
g_new0 over g_new, so that all memory is guaranteed zero-initialized

>  		return 0;
> -	if( (SIN_TABLE = malloc(SIN_ENT*4 *sizeof(int32_t *))) == NULL)
> +	if( (SIN_TABLE = g_new(int32_t *, SIN_ENT * 4)) == NULL)
>  	{
> -		free(TL_TABLE);
> +		g_free(TL_TABLE);
>  		return 0;
>  	}
> -	if( (AMS_TABLE = malloc(AMS_ENT*2 *sizeof(int32_t))) == NULL)
> +	if( (AMS_TABLE = g_new(int32_t, AMS_ENT * 2)) == NULL)
>  	{
> -		free(TL_TABLE);
> -		free(SIN_TABLE);
> +		g_free(TL_TABLE);
> +		g_free(SIN_TABLE);
>  		return 0;
>  	}
> -	if( (VIB_TABLE = malloc(VIB_ENT*2 *sizeof(int32_t))) == NULL)
> +	if( (VIB_TABLE = g_new(int32_t, VIB_ENT * 2)) == NULL)
>  	{
> -		free(TL_TABLE);
> -		free(SIN_TABLE);
> -		free(AMS_TABLE);
> +		g_free(TL_TABLE);
> +		g_free(SIN_TABLE);
> +		g_free(AMS_TABLE);
>  		return 0;
>  	}
>      ENV_CURVE = g_new(int32_t, 2 * EG_ENT + 1);
> -- 
> 2.53.0
> 
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


