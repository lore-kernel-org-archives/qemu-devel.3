Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE25C3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 15:22:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZB9D-0002tw-D2; Wed, 31 Jul 2024 11:21:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sZB9A-0002sQ-GA
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 11:21:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sZB98-0006ko-UZ
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 11:21:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722439306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EuPadYHE5F9ga3dsED3ZBkxQlSPE7Tr0QIumyhMBOtw=;
 b=RJd5WL4svS/Fx2yp2niDnkQ4vRqOtQb8SR/3CfgY38VgLKMW+0yf/x0+0nnNRVO4xa9Jsh
 y7utvjeJG6VJeOWfsI+5xgvkTDuCURo9n2FKFGG1GBZunbo9RZHQcmDXkeGYSHTrYCG9qB
 StKdnVXunXx2xyEQPHLXkm4ET4Nqhkw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-10-Xin_Be6lMqGykbnZ0aDwng-1; Wed,
 31 Jul 2024 11:21:42 -0400
X-MC-Unique: Xin_Be6lMqGykbnZ0aDwng-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D073F18EB204; Wed, 31 Jul 2024 15:21:40 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.1])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7B0601955E89; Wed, 31 Jul 2024 15:21:38 +0000 (UTC)
Date: Wed, 31 Jul 2024 17:21:36 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 "Richard W.M. Jones" <rjones@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH 7/7] block/ssh.c: Don't double-check that characters are
 hex digits
Message-ID: <ZqpWgDooox-kHyk2@redhat.com>
References: <20240731143617.3391947-1-peter.maydell@linaro.org>
 <20240731143617.3391947-8-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731143617.3391947-8-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 31.07.2024 um 16:36 hat Peter Maydell geschrieben:
> In compare_fingerprint() we effectively check whether the characters
> in the fingerprint are valid hex digits twice: first we do so with
> qemu_isxdigit(), but then the hex2decimal() function also has a code
> path where it effectively detects an invalid digit and returns -1.
> This causes Coverity to complain because it thinks that we might use
> that -1 value in an expression where it would be an integer overflow.

If it's a Coverity issue, I think you want to mention the CID, too.

> Avoid the double-check of hex digit validity by testing the return
> values from hex2decimal() rather than doing separate calls to
> qemu_isxdigit().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Could alternatively have put a g_assert_non_reached() in
> hex2decimal(), but this seemed better to me.

I don't like that hex2decimal() returns -1 when its result is unsigned,
which is why you had to write the check as > 0xf rather than < 0. So in
this sense, g_assert_non_reached() would look better to me. But we could
also just change it to return UINT_MAX instead, which should be the
same, just written in a less confusing way.

>  block/ssh.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/block/ssh.c b/block/ssh.c
> index 27d582e0e3d..510dd208aba 100644
> --- a/block/ssh.c
> +++ b/block/ssh.c
> @@ -376,13 +376,15 @@ static int compare_fingerprint(const unsigned char *fingerprint, size_t len,
>      unsigned c;
>  
>      while (len > 0) {
> +        unsigned c0, c1;
>          while (*host_key_check == ':')
>              host_key_check++;
> -        if (!qemu_isxdigit(host_key_check[0]) ||
> -            !qemu_isxdigit(host_key_check[1]))
> +        c0 = hex2decimal(host_key_check[0]);
> +        c1 = hex2decimal(host_key_check[1]);
> +        if (c0 > 0xf || c1 > 0xf) {
>              return 1;
> -        c = hex2decimal(host_key_check[0]) * 16 +
> -            hex2decimal(host_key_check[1]);
> +        }
> +        c = c0 * 16 + c1;
>          if (c - *fingerprint != 0)
>              return c - *fingerprint;
>          fingerprint++;

Reviewed-by: Kevin Wolf <kwolf@redhat.com>


