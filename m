Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E0CFC3065A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 06:54:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOAvg-0000N9-Ar; Mon, 01 Jul 2024 02:54:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sOAve-0000MT-O3; Mon, 01 Jul 2024 02:54:22 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sOAvd-0001fh-1z; Mon, 01 Jul 2024 02:54:22 -0400
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:3b1b:0:640:f68b:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id ABDD060B55;
 Mon,  1 Jul 2024 09:54:17 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:6415::1:19] (unknown
 [2a02:6b8:b081:6415::1:19])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id FsOGPR0IcqM0-G7R9bcsO; Mon, 01 Jul 2024 09:54:16 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1719816857;
 bh=3ItH6NtqsnZThhjLg/s7zTzcyCMmS+1aTcvFRMvQ3rY=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=1z6qYxKyRkWYchIkVQVkw4zxLjxDLz1E9SMzXM8qaMwcOhZHEfnDBx+jV8ZM+zPFg
 KoyDEM9VaKmiQQkpG3dekaAsNmyQxI8/zmhC04dDpf6eslpA2PzKE10W90fKccWrGE
 54NLrsGQo+K/Mb1Yvg8Rpsu/Ob5FB1RYCxJt8g0k=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <ead01cd7-80d7-4cfd-9b20-8417681fb3b8@yandex-team.ru>
Date: Mon, 1 Jul 2024 09:54:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block/curl: rewrite http header parsing function
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 qemu-trivial@nongnu.org
References: <20240629142542.1086076-1-mjt@tls.msk.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20240629142542.1086076-1-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 29.06.24 17:25, Michael Tokarev wrote:
> Existing code was long, unclear and twisty.
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

> ---
>   block/curl.c | 44 ++++++++++++++++++--------------------------
>   1 file changed, 18 insertions(+), 26 deletions(-)
> 
> diff --git a/block/curl.c b/block/curl.c
> index 419f7c89ef..9802d0319d 100644
> --- a/block/curl.c
> +++ b/block/curl.c
> @@ -210,37 +210,29 @@ static size_t curl_header_cb(void *ptr, size_t size, size_t nmemb, void *opaque)
>   {
>       BDRVCURLState *s = opaque;
>       size_t realsize = size * nmemb;
> -    const char *header = (char *)ptr;
> -    const char *end = header + realsize;
> -    const char *accept_ranges = "accept-ranges:";
> -    const char *bytes = "bytes";
> +    const char *p = ptr;
> +    const char *end = p + realsize;
> +    const char *t = "accept-ranges : bytes "; /* A lowercase template */

Note: you make parser less strict: you allow "bytes" to be uppercase (was allowed only for accept-ranges", and you allow whitespaces before colon.

>   
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
>               }
> +        } else if (*t && p < end && *t == g_ascii_tolower(*p)) {
> +            ++p, ++t;
> +        } else {
> +            break;
>           }
>       }
>   
> +    if (!*t && p == end) { /* if we managed to reach ends of both strings */
> +        s->accept_range = true;
> +    }
> +
>       return realsize;
>   }
>   

-- 
Best regards,
Vladimir


