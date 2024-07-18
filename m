Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1091C3DA61
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 18:55:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUWGw-0002Tq-DX; Thu, 18 Jul 2024 14:54:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sUWGt-0002Qm-1F
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 14:54:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sUWGq-0008Hr-Nf
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 14:54:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721328868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iHiJVlDiVGakY83VFOrL3zt9E2yBK6he9sXBbfuvNLw=;
 b=KIymWBKcJyuaBg9jUEpnV3lrNW+dCYMNPjsTxWt5zEfY2Oj5/iZHSae3QRCQW+MapCjPo3
 ubXNpkd5LUVNyP+uxnAWEwPVt+U184peoQl6D2hJJhLboYDABVJdZ8cHzBHu4xOMy0STkL
 hHudw8Rgvfoc9S3Nnghh+c+ByvrQ5o4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-Ez3vlr26NcaQcmKktAgb_g-1; Thu,
 18 Jul 2024 14:54:23 -0400
X-MC-Unique: Ez3vlr26NcaQcmKktAgb_g-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 72CC91955F41; Thu, 18 Jul 2024 18:54:21 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.0])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F2B21955F40; Thu, 18 Jul 2024 18:54:15 +0000 (UTC)
Date: Thu, 18 Jul 2024 20:54:13 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 qemu-trivial@nongnu.org
Subject: Re: [PATCH] block/curl: rewrite http header parsing function
Message-ID: <Zplk1RLrHl0VIrBO@redhat.com>
References: <20240629142542.1086076-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240629142542.1086076-1-mjt@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am 29.06.2024 um 16:25 hat Michael Tokarev geschrieben:
> Existing code was long, unclear and twisty.
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  block/curl.c | 44 ++++++++++++++++++--------------------------
>  1 file changed, 18 insertions(+), 26 deletions(-)
> 
> diff --git a/block/curl.c b/block/curl.c
> index 419f7c89ef..9802d0319d 100644
> --- a/block/curl.c
> +++ b/block/curl.c
> @@ -210,37 +210,29 @@ static size_t curl_header_cb(void *ptr, size_t size, size_t nmemb, void *opaque)
>  {
>      BDRVCURLState *s = opaque;
>      size_t realsize = size * nmemb;
> -    const char *header = (char *)ptr;
> -    const char *end = header + realsize;
> -    const char *accept_ranges = "accept-ranges:";
> -    const char *bytes = "bytes";
> +    const char *p = ptr;
> +    const char *end = p + realsize;
> +    const char *t = "accept-ranges : bytes "; /* A lowercase template */

I don't think spaces between the field name and the colon are allowed
in the spec (and in the old code), only before and after the value.

> -    if (realsize >= strlen(accept_ranges)
> -        && g_ascii_strncasecmp(header, accept_ranges,
> -                               strlen(accept_ranges)) == 0) {
> -
> -        char *p = strchr(header, ':') + 1;
> -
> -        /* Skip whitespace between the header name and value. */
> -        while (p < end && *p && g_ascii_isspace(*p)) {
> -            p++;
> -        }
> -
> -        if (end - p >= strlen(bytes)
> -            && strncmp(p, bytes, strlen(bytes)) == 0) {
> -
> -            /* Check that there is nothing but whitespace after the value. */
> -            p += strlen(bytes);
> -            while (p < end && *p && g_ascii_isspace(*p)) {
> -                p++;
> -            }
> -
> -            if (p == end || !*p) {
> -                s->accept_range = true;
> +    /* check if header matches the "t" template */
> +    for (;;) {
> +        if (*t == ' ') { /* space in t matches any amount of isspace in p */
> +            if (p < end && g_ascii_isspace(*p)) {
> +                ++p;
> +            } else {
> +                ++t;
>              }
> +        } else if (*t && p < end && *t == g_ascii_tolower(*p)) {
> +            ++p, ++t;
> +        } else {
> +            break;
>          }
>      }
>  
> +    if (!*t && p == end) { /* if we managed to reach ends of both strings */
> +        s->accept_range = true;
> +    }

Maybe make the generic comparison with a template a separate function
(maybe even in cutils.c?) so that curl_header_cb() essentially only has
something like this any more:

if (!qemu_memcasecmp_space(ptr, end, "accept-ranges: bytes ")) {
    s->accept_range = true;
}

(A better name for the function would be preferable, of course. Maybe
also a bool return value, but if it has a name related to memcmp() or
strcmp(), then 0 must mean it matches.)

Then this would really highlight the curl specific logic rather than the
string parser in curl_header_cb().

Kevin


