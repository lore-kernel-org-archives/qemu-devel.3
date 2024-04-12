Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8319BC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 14:41:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvI4u-0000ut-GJ; Fri, 12 Apr 2024 10:40:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rvI4r-0000uW-Ua
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 10:40:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rvI4m-0005V9-Dz
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 10:40:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712932823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bJZVgZQhaPQhIWZ3IYuQuBSAtI8yGUVsl5twbMRd8YE=;
 b=NiHIj5JHFsFMhjNcYsLxhk5TNTVp1C8ZalSrjd/4aGX8jYWOx32nzVD3dz3m1zcUpbPmXC
 APbul7cU29IDpB9s7FVlF4g8WtEXkTKPtGOCWWJ65O86veuqTHwps6k/jn388uJ0n/xO09
 Xsfg2kjhQrzjVA1Yr3o84pxM3/B4vqg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-G_3FxyJOPXmywUQE_Fz_cw-1; Fri,
 12 Apr 2024 10:40:19 -0400
X-MC-Unique: G_3FxyJOPXmywUQE_Fz_cw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 70B913C00086;
 Fri, 12 Apr 2024 14:40:18 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.15])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BDD111121312;
 Fri, 12 Apr 2024 14:40:16 +0000 (UTC)
Date: Fri, 12 Apr 2024 09:40:11 -0500
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 Peter Lieven <pl@kamp.de>, "Richard W.M. Jones" <rjones@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Konstantin Kostiuk <kkostiuk@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH v2 09/13] block/gluster: Use URI parsing code from glib
Message-ID: <zrdtuxegb3kyrp6qobgpygmoydiigpc6tv5e4jk7w7fi7cwvr3@pivj5d3df5uj>
References: <20240412132415.282354-1-thuth@redhat.com>
 <20240412132415.282354-10-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412132415.282354-10-thuth@redhat.com>
User-Agent: NeoMutt/20240201
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.103,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Fri, Apr 12, 2024 at 03:24:11PM +0200, Thomas Huth wrote:
> Since version 2.66, glib has useful URI parsing functions, too.
> Use those instead of the QEMU-internal ones to be finally able
> to get rid of the latter.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  block/gluster.c | 71 ++++++++++++++++++++++++-------------------------
>  1 file changed, 35 insertions(+), 36 deletions(-)
> 
> diff --git a/block/gluster.c b/block/gluster.c
> index cc74af06dc..1c9505f8bb 100644
> --- a/block/gluster.c
> +++ b/block/gluster.c
> @@ -17,7 +17,6 @@
>  #include "qapi/error.h"
>  #include "qapi/qmp/qdict.h"
>  #include "qapi/qmp/qerror.h"
> -#include "qemu/uri.h"
>  #include "qemu/error-report.h"
>  #include "qemu/module.h"
>  #include "qemu/option.h"
> @@ -289,9 +288,9 @@ static void glfs_clear_preopened(glfs_t *fs)
>      }
>  }
>  
> -static int parse_volume_options(BlockdevOptionsGluster *gconf, char *path)
> +static int parse_volume_options(BlockdevOptionsGluster *gconf, const char *path)

Is it worth mentioning in the commit message that this includes a
const-correctness tweak?

> @@ -364,57 +363,57 @@ static int qemu_gluster_parse_uri(BlockdevOptionsGluster *gconf,
>      QAPI_LIST_PREPEND(gconf->server, gsconf);
>  
>      /* transport */
> -    if (!uri->scheme || !strcmp(uri->scheme, "gluster")) {
> +    uri_scheme = g_uri_get_scheme(uri);
> +    if (!uri_scheme || !strcmp(uri_scheme, "gluster")) {

Pre-existing, but per RFC 3986, we should probably be using strcasecmp
for scheme comparisons (I'm not sure if g_uri_parse guarantees a
lower-case return, even when the user passed in upper case).  That can
be a separate patch.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


