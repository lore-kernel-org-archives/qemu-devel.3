Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F767C3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 15:05:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZAsK-00028G-Pl; Wed, 31 Jul 2024 11:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sZAs8-00026x-T8
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 11:04:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sZAs6-0001iC-21
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 11:04:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722438248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0lGFSp7vR25PzFheDpm51dMgk00nON8OqLwYaAmQzeo=;
 b=gpNLN0lMXRQosXj9TOKpq2QciLmAA78JJbLIA+aDP0YLSrxNMnvFAxVPGI/OSUByHBC3a2
 4sCFRgrJaQLHuEgpf6uJEb/vDjjnchVHXn4+EdPfsp0td/UqbKiP0HgJwMN617IAlfHKba
 IIm2Z7PTT3xi7sj5PFgRqOPgLL9ghDg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-62-8KHeljCaODiRqRC98nNK5Q-1; Wed,
 31 Jul 2024 11:04:07 -0400
X-MC-Unique: 8KHeljCaODiRqRC98nNK5Q-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9137518B65C0; Wed, 31 Jul 2024 15:04:05 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.1])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 170F31955E89; Wed, 31 Jul 2024 15:04:02 +0000 (UTC)
Date: Wed, 31 Jul 2024 17:04:00 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 "Richard W.M. Jones" <rjones@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH 2/7] block/gluster: Use g_autofree for string in
 qemu_gluster_parse_json()
Message-ID: <ZqpSYBIIiDW03-lz@redhat.com>
References: <20240731143617.3391947-1-peter.maydell@linaro.org>
 <20240731143617.3391947-3-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731143617.3391947-3-peter.maydell@linaro.org>
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
> In the loop in qemu_gluster_parse_json() we do:
> 
>     char *str = NULL;
>     for(...) {
>         str = g_strdup_printf(...);
>         ...
>         if (various errors) {
>             goto out;
>         }
>         ...
>         g_free(str);
>         str = NULL;
>     }
>     return 0;
> out:
>     various cleanups;
>     g_free(str);
>     ...
>     return -errno;
> 
> Coverity correctly complains that the assignment "str = NULL" at the
> end of the loop is unnecessary, because we will either go back to the
> top of the loop and overwrite it, or else we will exit the loop and
> then exit the function without ever reading str again. The assignment
> is there as defensive coding to ensure that str is only non-NULL if
> it's a live allocation, so this is intentional.
> 
> We can make Coverity happier and simplify the code here by using
> g_autofree, since we never need 'str' outside the loop.
> 
> Resolves: Coverity CID 1527385
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  block/gluster.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/block/gluster.c b/block/gluster.c
> index f8b415f3812..61ded95e660 100644
> --- a/block/gluster.c
> +++ b/block/gluster.c
> @@ -514,7 +514,6 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
>      SocketAddressList **tail;
>      QDict *backing_options = NULL;
>      Error *local_err = NULL;
> -    char *str = NULL;
>      const char *ptr;
>      int i, type, num_servers;
>  
> @@ -547,7 +546,7 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
>      tail = &gconf->server;
>  
>      for (i = 0; i < num_servers; i++) {
> -        str = g_strdup_printf(GLUSTER_OPT_SERVER_PATTERN"%d.", i);
> +        g_autofree char *str = g_strdup_printf(GLUSTER_OPT_SERVER_PATTERN"%d.", i);

This line is too long now.

With this fixed:
Reviewed-by: Kevin Wolf <kwolf@redhat.com>


