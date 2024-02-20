Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3443C5475B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 18:49:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcVAg-0005Jr-J3; Tue, 20 Feb 2024 13:48:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rcVAa-0005J2-Lj
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 13:48:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rcVAZ-0008AT-3H
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 13:48:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708454922;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=sSjjcClsE1bOcyjciKXndTO0nkJut309msnbhdYBq1c=;
 b=UXoZWu35QAzK+k3wzsBFQ9hImV8To45k+7OA5UgCEQWc8IbDMpmde8sjOK65XW0WX79p7z
 eT6bdAnbsNvlgaVEwY/LfvclzT2oDIgQKWsch6ZJ5ycNaExVSHMS4mGc1Roxq71QVernsq
 06vUvaQBP+qrW8OCDuVqQDP75lcA3s4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-f9y3T99CMhSIwBfacEamiw-1; Tue,
 20 Feb 2024 13:48:38 -0500
X-MC-Unique: f9y3T99CMhSIwBfacEamiw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 598642820B75;
 Tue, 20 Feb 2024 18:48:38 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C53C840C94A8;
 Tue, 20 Feb 2024 18:48:37 +0000 (UTC)
Date: Tue, 20 Feb 2024 18:48:35 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: Re: [PATCH 23/23] qemu-img: inline list of supported commands,
 remove qemu-img-cmds.h include
Message-ID: <ZdT0A3b9-JrMd6aI@redhat.com>
References: <cover.1707513011.git.mjt@tls.msk.ru>
 <a7e67594e748d1b91f755dd971f222afa09f5443.1707513012.git.mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a7e67594e748d1b91f755dd971f222afa09f5443.1707513012.git.mjt@tls.msk.ru>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Sat, Feb 10, 2024 at 12:22:44AM +0300, Michael Tokarev wrote:
> also add short description to each command and use it in --help
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  qemu-img.c | 42 +++++++++++++++++++++++++++++++++++-------
>  1 file changed, 35 insertions(+), 7 deletions(-)
> 
> diff --git a/qemu-img.c b/qemu-img.c
> index d9c5c6078b..e57076738e 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -61,6 +61,7 @@
>  typedef struct img_cmd_t {
>      const char *name;
>      int (*handler)(const struct img_cmd_t *ccmd, int argc, char **argv);
> +    const char *description;
>  } img_cmd_t;
>  
>  enum {
> @@ -130,11 +131,12 @@ static G_NORETURN
>  void cmd_help(const img_cmd_t *ccmd,
>                const char *syntax, const char *arguments)
>  {
> -    printf("qemu-img %s %s"
> +    printf("qemu-img %s: %s.  Usage:\n"
> +           "qemu-img %s %s"

This ends up looking a bit muddled together. I don't think we
need repeat 'qemu-img <cmd>' twice, and could add a little
more whitespace

eg instead of:

$ ./build/qemu-img check --help
qemu-img check: Check basic image integrity.  Usage:
qemu-img check [-f FMT | --image-opts] [-T CACHE_MODE] [-r] [-u]
        [--output human|json] [--object OBJDEF] FILENAME
Arguments:
...snip...

have it look like

$ ./build/qemu-img check --help
Check basic image integrity.

Usage:

  qemu-img check [-f FMT | --image-opts] [-T CACHE_MODE] [-r] [-u]
        [--output human|json] [--object OBJDEF] FILENAME

Arguments:
...snip...


>             "Arguments:\n"
>             " -h|--help - print this help and exit\n"
>             "%s",
> -           ccmd->name, syntax, arguments);
> +           ccmd->name, ccmd->description, ccmd->name, syntax, arguments);
>      exit(EXIT_SUCCESS);
>  }
>  
> @@ -5746,10 +5748,36 @@ out:
>  }
>  
>  static const img_cmd_t img_cmds[] = {
> -#define DEF(option, callback, arg_string)        \
> -    { option, callback },
> -#include "qemu-img-cmds.h"
> -#undef DEF
> +    { "amend", img_amend,
> +      "Update format-specific options of the image" },
> +    { "bench", img_bench,
> +      "Run simple image benchmark" },
> +    { "bitmap", img_bitmap,
> +      "Perform modifications of the persistent bitmap in the image" },
> +    { "check", img_check,
> +      "Check basic image integrity" },
> +    { "commit", img_commit,
> +      "Commit image to its backing file" },
> +    { "compare", img_compare,
> +      "Check if two images have the same contents" },
> +    { "convert", img_convert,
> +      "Copy one image to another with optional format conversion" },
> +    { "create", img_create,
> +      "Create and format new image file" },
> +    { "dd", img_dd,
> +      "Copy input to output with optional format conversion" },
> +    { "info", img_info,
> +      "Display information about image" },
> +    { "map", img_map,
> +      "Dump image metadata" },
> +    { "measure", img_measure,
> +      "Calculate file size requred for a new image" },
> +    { "rebase", img_rebase,
> +      "Change backing file of the image" },
> +    { "resize", img_resize,
> +      "Resize the image to the new size" },
> +    { "snapshot", img_snapshot,
> +      "List or manipulate snapshots within image" },
>      { NULL, NULL, },
>  };
>  
> @@ -5813,7 +5841,7 @@ QEMU_IMG_VERSION
>  "   [[enable=]<pattern>][,events=<file>][,file=<file>]\n"
>  "Recognized commands (run qemu-img command --help for command-specific help):\n");
>              for (cmd = img_cmds; cmd->name != NULL; cmd++) {
> -                printf("  %s\n", cmd->name);
> +                printf("  %s - %s\n", cmd->name, cmd->description);
>              }
>              c = printf("Supported image formats:");
>              bdrv_iterate_format(format_print, &c, false);
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


