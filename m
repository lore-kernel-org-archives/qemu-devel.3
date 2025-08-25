Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB39CA0EFA
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 08:23:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqSTb-0003in-FT; Mon, 25 Aug 2025 04:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uqSTV-0003ho-I0
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 04:22:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uqSTS-0000ec-0C
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 04:22:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756110157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zmc390DHWIPJV8VKuzSv8ykQgKiAfAguRa7yWjWyGb0=;
 b=VaOCPQzpfBPlL13sMPPzUmAfwU/8OjJZe1mjgiikZge6/5Mz27+vpzmpvVeu0/8AJx4gxW
 eLrKa2I4TPM4rRIedQigag+J5q/Ia3EQD8+HKgcM2gLwT/gMMeHBIGnnKCGdoVLt/gjiFx
 piGky6FmbYtHX4p02yGcfVp4rSyhvNA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-YK2e3N6hPJa0zucEl-TlDQ-1; Mon,
 25 Aug 2025 04:22:33 -0400
X-MC-Unique: YK2e3N6hPJa0zucEl-TlDQ-1
X-Mimecast-MFC-AGG-ID: YK2e3N6hPJa0zucEl-TlDQ_1756110152
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DEC8618002C5; Mon, 25 Aug 2025 08:22:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6948718004A3; Mon, 25 Aug 2025 08:22:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 999B121E6A27; Mon, 25 Aug 2025 10:22:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  qemu-trivial@nongnu.org
Subject: Re: [PATCH trivial] block/curl: drop old/unuspported curl version
 checks
In-Reply-To: <20250824084127.2016645-1-mjt@tls.msk.ru> (Michael Tokarev's
 message of "Sun, 24 Aug 2025 11:41:24 +0300")
References: <20250824084127.2016645-1-mjt@tls.msk.ru>
Date: Mon, 25 Aug 2025 10:22:26 +0200
Message-ID: <87ecszlsjh.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Michael Tokarev <mjt@tls.msk.ru> writes:

> We currently require libcurl >=7.29.0.  Drop older LIBCURL_VERSION_NUM
> checks from the driver.
>
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  block/curl.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
>
> diff --git a/block/curl.c b/block/curl.c
> index 00b949ea45..444f258ea3 100644
> --- a/block/curl.c
> +++ b/block/curl.c
> @@ -516,7 +516,7 @@ static int curl_init_state(BDRVCURLState *s, CURLState *state)
>                               CURLOPT_REDIR_PROTOCOLS_STR, PROTOCOLS)) {
>              goto err;
>          }
> -#elif LIBCURL_VERSION_NUM >= 0x071304
> +#else
>          if (curl_easy_setopt(state->curl, CURLOPT_PROTOCOLS, PROTOCOLS) ||
>              curl_easy_setopt(state->curl, CURLOPT_REDIR_PROTOCOLS, PROTOCOLS)) {
>              goto err;
> @@ -821,22 +821,11 @@ static int curl_open(BlockDriverState *bs, QDict *options, int flags,
>          goto out;
>      }
>  #endif
> -    /* Prior CURL 7.19.4 return value of 0 could mean that the file size is not
> -     * know or the size is zero. From 7.19.4 CURL returns -1 if size is not
> -     * known and zero if it is really zero-length file. */
> -#if LIBCURL_VERSION_NUM >= 0x071304

This is the version for new libcurl.

> -    if (cl < 0) {
> -        pstrcpy(state->errmsg, CURL_ERROR_SIZE,
> -                "Server didn't report file size.");
> -        goto out;
> -    }
> -#else

This is the version for old libcurl.

>      if (cl <= 0) {
>          pstrcpy(state->errmsg, CURL_ERROR_SIZE,
>                  "Unknown file size or zero-length file.");
>          goto out;
>      }
> -#endif

Am I confused or does your patch keep the wrong version?

>  
>      s->len = cl;


