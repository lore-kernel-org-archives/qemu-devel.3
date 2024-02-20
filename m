Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B91B8C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 17:59:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcUNV-0000EY-UB; Tue, 20 Feb 2024 12:58:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rcUNV-0000EI-7Q
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 12:58:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rcUNT-0007h2-Gj
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 12:58:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708451878;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=+AEO5jNywDtEIc3OcE9+vpjIAwaou6Br8nkxSal1ls4=;
 b=LTJwJs8hnz92LbyIziHshSBfRbWqa24YbeiTubY6eKvnSwEuHag/3kiobXDQwnrmvChXir
 7XmKeyp6qehCcqFJPS9pSmCDjfW13/z7AIBFIdmIaUivQntojdAsql4Pkg9dbK0fLm6X8A
 Bx6N8lnFbMGSxGFOw9zHkH5pEezzxk4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-Y0e1oTiVM3eXVswNNOR_Hg-1; Tue, 20 Feb 2024 12:57:55 -0500
X-MC-Unique: Y0e1oTiVM3eXVswNNOR_Hg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 566CA185A780;
 Tue, 20 Feb 2024 17:57:55 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B84E010800;
 Tue, 20 Feb 2024 17:57:54 +0000 (UTC)
Date: Tue, 20 Feb 2024 17:57:52 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: Re: [PATCH 15/23] qemu-img: resize: do not always eat last argument
Message-ID: <ZdToIERLC8RaHhhg@redhat.com>
References: <cover.1707513011.git.mjt@tls.msk.ru>
 <7e0e7cb2470d572e8c0a48ba85c993be3bdb1c07.1707513011.git.mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7e0e7cb2470d572e8c0a48ba85c993be3bdb1c07.1707513011.git.mjt@tls.msk.ru>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Feb 10, 2024 at 12:22:36AM +0300, Michael Tokarev wrote:
> 'qemu-img resize --help' does not work, since it wants more arguments.
> Only eat last option at the beginning if it starts like -N.., and allow
> getopt() to do its work, and eat it up at the end if not already eaten.
> This will not allow to mix options and size anyway, but it is better
> than now.
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  qemu-img.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/qemu-img.c b/qemu-img.c
> index 69d41e0a92..929a25a021 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -4271,13 +4271,13 @@ static int img_resize(const img_cmd_t *ccmd, int argc, char **argv)
>  
>      /* Remove size from argv manually so that negative numbers are not treated
>       * as options by getopt. */
> -    if (argc < 3) {
> -        error_exit(ccmd, "Not enough arguments");
> -        return 1;
> +    if (argc > 1 && argv[argc - 1][0] == '-'
> +        && argv[argc-1][1] >= '0' && argv[argc-1][1] <= '9') {
> +        size = argv[--argc];
> +    } else {
> +        size = NULL;
>      }

We already have a variable 'int relative' that is set to '-1'
or '+1' depending on whether we have a -ve or +ve size.

I think it is clearer to follow if we just set 'relative' much
earlier before parsing by moving this chunk of code to before
the getopt:

    switch (size[0]) {
    case '+':
        relative = 1;
        size++;
        break;
    case '-':
        relative = -1;
        size++;
        break;
    default:
        relative = 0;
        break;
    }

once we've done that we can simply replace the '-' with '+'
to stop getopt getting upset.

>  
> -    size = argv[--argc];
> -
>      /* Parse getopt arguments */
>      fmt = NULL;
>      for(;;) {
> @@ -4329,10 +4329,13 @@ static int img_resize(const img_cmd_t *ccmd, int argc, char **argv)
>              break;
>          }
>      }
> -    if (optind != argc - 1) {
> +    if (optind + 1 + (size == NULL) != argc) {
>          error_exit(ccmd, "Expecting image file name and size");
>      }
>      filename = argv[optind++];
> +    if (!size) {
> +        size = argv[optind++];
> +    }
>  
>      /* Choose grow, shrink, or absolute resize mode */
>      switch (size[0]) {

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


