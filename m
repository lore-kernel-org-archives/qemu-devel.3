Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2000BC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 18:06:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMtVl-0002kV-3L; Thu, 27 Jun 2024 14:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sMtVC-0002Qf-4D
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 14:05:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sMtV9-0001yd-Uc
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 14:05:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719511542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Auy3qRGwnkQims27jqaR1iEwV6VnNJ3Z3w3uUc2NdqE=;
 b=Niqtq2FvAYkhVXyitc6qeOLk/VYGw2XpYavU0WDotoE9Rsuxq+1jmOIX3vs5EkXLngyxtR
 xfcswU7KsGoeouGXxMA/Z3v9bLrKZqF0t+gLT55uMRGVCVsGpKRZ9jJIZzB3pne3DW50I4
 bt+XMq2MD/583fp8dgKduDMs5dNlBuA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-vrNZY0IhMh2GtJh_p8YVeQ-1; Thu,
 27 Jun 2024 14:05:34 -0400
X-MC-Unique: vrNZY0IhMh2GtJh_p8YVeQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4CEDB1956089; Thu, 27 Jun 2024 18:05:32 +0000 (UTC)
Received: from redhat.com (unknown [10.39.192.213])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E3A6D300022B; Thu, 27 Jun 2024 18:05:29 +0000 (UTC)
Date: Thu, 27 Jun 2024 20:05:22 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 qemu-trivial@nongnu.org
Subject: Re: [PATCH] block/curl: explicitly assert that strchr returns
 non-NULL value
Message-ID: <Zn2p4v8jmkGB1on-@redhat.com>
References: <20240627153059.589070-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627153059.589070-1-vsementsov@yandex-team.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.212,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 27.06.2024 um 17:30 hat Vladimir Sementsov-Ogievskiy geschrieben:
> strchr may return NULL if colon is not found. It seems clearer to
> assert explicitly that we don't expect it here, than dereference 1 in
> the next line.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  block/curl.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/block/curl.c b/block/curl.c
> index 419f7c89ef..ccfffd6c12 100644
> --- a/block/curl.c
> +++ b/block/curl.c
> @@ -219,7 +219,9 @@ static size_t curl_header_cb(void *ptr, size_t size, size_t nmemb, void *opaque)
>          && g_ascii_strncasecmp(header, accept_ranges,
>                                 strlen(accept_ranges)) == 0) {
>  
> -        char *p = strchr(header, ':') + 1;
> +        char *p = strchr(header, ':');
> +        assert(p != NULL);
> +        p += 1;

I'm not sure if this is actually much clearer because it doesn't say why
we don't expect NULL here. If you don't look at the context, it almost
looks like an assert() where proper error handling is needed. If you do,
then the original line is clear enough.

My first thought was that maybe what we want is a comment, but we
actually already know where the colon is. So how about this instead:

    char *p = header + strlen(accept_ranges);

Kevin

>          /* Skip whitespace between the header name and value. */
>          while (p < end && *p && g_ascii_isspace(*p)) {
> -- 
> 2.34.1
> 


