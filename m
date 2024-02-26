Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6048CC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 14:54:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1recMO-0003mX-Hn; Mon, 26 Feb 2024 09:53:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1recMJ-0003hT-PA
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 09:53:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1recMD-0001en-2I
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 09:53:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708959207;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=8SDWFoU2Q36deSAdQFeFyO2kkpylsUiG4THHi518kkc=;
 b=MnXQm1Z+c+dGelemxG6Ch5XX9nse2TgzvqFrr+VdmpyagdsRAKZL1fomYJJqd47Gs/ZOne
 Th1DGPCrK+avkYkqc8mlEdyuLnHqv3fd+Z2pSw6X3eKOGo8sbwattQeTTfrdgD/nupVDKF
 NAlnd56eY9KLxafN8tZmmqz1mOjsFDc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-uZqxf7OJOpSAgzhDs2yQKw-1; Mon,
 26 Feb 2024 09:52:54 -0500
X-MC-Unique: uZqxf7OJOpSAgzhDs2yQKw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 410A638135E9;
 Mon, 26 Feb 2024 14:52:52 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AD9901C060B1;
 Mon, 26 Feb 2024 14:52:51 +0000 (UTC)
Date: Mon, 26 Feb 2024 14:52:49 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: Re: [PATCH 19/28] qemu-img: resize: do not always eat last argument
Message-ID: <Zdylwbu94EKzB73y@redhat.com>
References: <cover.1708544927.git.mjt@tls.msk.ru>
 <20240221211622.2335170-19-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240221211622.2335170-19-mjt@tls.msk.ru>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Feb 22, 2024 at 12:16:00AM +0300, Michael Tokarev wrote:
> 'qemu-img resize --help' does not work, since it wants more
> arguments.  Also it -size is only recognized as a very last
> argument, but it is common for tools to handle other options
> after positional arguments too.
> 
> Tell getopt_long() to return non-options together with options,
> and process filename and size in the loop, and check if there's
> an argument right after filename which looks like -N (number),
> and treat it as size (decrement).  This way we can handle --help,
> and we can also have options after filename and size, and `--'
> will be handled fine too.
> 
> The only case which is not handled right is when there's an option
> between filename and size, and size is given as decrement, - in
> this case -size will be treated as option, not as size.
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  qemu-img.c | 41 +++++++++++++++++++++++++++--------------
>  1 file changed, 27 insertions(+), 14 deletions(-)
> 
> diff --git a/qemu-img.c b/qemu-img.c
> index 2a4bff2872..c8b0b68d67 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -4296,7 +4296,7 @@ static int img_resize(const img_cmd_t *ccmd, int argc, char **argv)
>  {
>      Error *err = NULL;
>      int c, ret, relative;
> -    const char *filename, *fmt, *size;
> +    const char *filename = NULL, *fmt = NULL, *size = NULL;
>      int64_t n, total_size, current_size;
>      bool quiet = false;
>      BlockBackend *blk = NULL;
> @@ -4319,17 +4319,7 @@ static int img_resize(const img_cmd_t *ccmd, int argc, char **argv)
>      bool image_opts = false;
>      bool shrink = false;
>  
> -    /* Remove size from argv manually so that negative numbers are not treated
> -     * as options by getopt. */
> -    if (argc < 3) {
> -        error_exit(argv[0], "Not enough arguments");
> -        return 1;
> -    }
> -
> -    size = argv[--argc];
> -
>      /* Parse getopt arguments */
> -    fmt = NULL;
>      for(;;) {
>          static const struct option long_options[] = {
>              {"help", no_argument, 0, 'h'},
> @@ -4339,7 +4329,7 @@ static int img_resize(const img_cmd_t *ccmd, int argc, char **argv)
>              {"shrink", no_argument, 0, OPTION_SHRINK},
>              {0, 0, 0, 0}
>          };
> -        c = getopt_long(argc, argv, ":f:hq",
> +        c = getopt_long(argc, argv, "-:f:hq",

In other patches you removed the initial ':' from gopt_long arg strings.

>                          long_options, NULL);
>          if (c == -1) {
>              break;
> @@ -4377,12 +4367,35 @@ static int img_resize(const img_cmd_t *ccmd, int argc, char **argv)
>          case OPTION_SHRINK:
>              shrink = true;
>              break;
> +        case 1: /* a non-optional argument */
> +            if (!filename) {
> +                filename = optarg;
> +                /* see if we have -size (number) next to filename */
> +                if (optind < argc) {
> +                    size = argv[optind];
> +                    if (size[0] == '-' && size[1] >= '0' && size[1] <= '9') {
> +                        ++optind;
> +                    } else {
> +                        size = NULL;
> +                    }
> +                }
> +            } else if (!size) {
> +                size = optarg;
> +            } else {
> +                error_exit(argv[0], "Extra argument(s) in command line");
> +            }
> +            break;

Can you say what scenario exercises this code 'case 1' ?  I couldn't
get it to run in any scenarios i tried, and ineed removing this,
and removing the 'getopt_long' change, I could still run  'qemu-img resize --help'
OK, and also run 'qemu-img resize foo -43' too.

>          }
>      }
> -    if (optind != argc - 1) {
> +    if (!filename && optind < argc) {
> +        filename = argv[optind++];
> +    }
> +    if (!size && optind < argc) {
> +        size = argv[optind++];
> +    }
> +    if (!filename || !size || optind < argc) {
>          error_exit(argv[0], "Expecting image file name and size");
>      }
> -    filename = argv[optind++];
>  
>      /* Choose grow, shrink, or absolute resize mode */
>      switch (size[0]) {
> -- 
> 2.39.2
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


