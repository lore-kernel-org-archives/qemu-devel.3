Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E84C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 14:18:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzzuk-00076N-0E; Thu, 25 Apr 2024 10:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rzzua-00074O-GL
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 10:17:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rzzuX-0001Tv-Dy
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 10:17:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714054633;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ats0eIAYHKFvf8DypLJSegocl/XeTCzUE3xREugdd4w=;
 b=Fy1PcQN6n3rQMao4HdSOKitGu5rSAsYXttW56Zt6VMPyYmuxMw9Jla4Yjv9MpFayYy6UiW
 fBL18LXEkZoV6s+mBmk8AvyRF3aAGHVoWimt7dcuKUo65w1dmfSoJGcCW/csKgQJt8VWp2
 z4h+Idmov6P4hkt03/NS30LczYilnu0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-f7oEStASP8yregafkbUpSg-1; Thu, 25 Apr 2024 10:17:09 -0400
X-MC-Unique: f7oEStASP8yregafkbUpSg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6F82697AF46;
 Thu, 25 Apr 2024 14:17:09 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8AE921121313;
 Thu, 25 Apr 2024 14:17:07 +0000 (UTC)
Date: Thu, 25 Apr 2024 15:17:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Hao Xiang <hao.xiang@linux.dev>
Cc: marcandre.lureau@redhat.com, peterx@redhat.com, farosas@suse.de,
 armbru@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 08/14] migration/multifd: Add new migration option for
 multifd DSA offloading.
Message-ID: <Zipl4WkTFgMr92NP@redhat.com>
References: <20240425022117.4035031-1-hao.xiang@linux.dev>
 <20240425022117.4035031-9-hao.xiang@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240425022117.4035031-9-hao.xiang@linux.dev>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Apr 25, 2024 at 02:21:11AM +0000, Hao Xiang wrote:
> Intel DSA offloading is an optional feature that turns on if
> proper hardware and software stack is available. To turn on
> DSA offloading in multifd live migration:
> 
> multifd-dsa-accel="[dsa_dev_path1] [dsa_dev_path2] ... [dsa_dev_pathX]"
> 
> This feature is turned off by default.
> 
> Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
> ---
>  migration/migration-hmp-cmds.c |  8 ++++++++
>  migration/options.c            | 30 ++++++++++++++++++++++++++++++
>  migration/options.h            |  1 +
>  qapi/migration.json            | 26 +++++++++++++++++++++++---
>  4 files changed, 62 insertions(+), 3 deletions(-)

> diff --git a/qapi/migration.json b/qapi/migration.json
> index 8c65b90328..934fa8839e 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -914,6 +914,12 @@
>  #     See description in @ZeroPageDetection.  Default is 'multifd'.
>  #     (since 9.0)
>  #
> +# @multifd-dsa-accel: If enabled, use DSA accelerator offloading for
> +#     certain memory operations. Enable DSA accelerator offloading by
> +#     setting this string to a list of DSA device path separated by space
> +#     characters. Setting this string to an empty string means disabling
> +#     DSA accelerator offloading. Defaults to an empty string. (since 9.2)

Passing a list of paths as a single space separate string is a
design anti-pattern. This needs to use a list type at the QAPI
level.

Also I don't think we need add 'multifd' on the name - all
new features are for multifd.

Overall it should be called 'dsa-accel-path' I thjink

> @@ -1122,6 +1128,12 @@
>  #     See description in @ZeroPageDetection.  Default is 'multifd'.
>  #     (since 9.0)
>  #
> +# @multifd-dsa-accel: If enabled, use DSA accelerator offloading for
> +#     certain memory operations. Enable DSA accelerator offloading by
> +#     setting this string to a list of DSA device path separated by space
> +#     characters. Setting this string to an empty string means disabling
> +#     DSA accelerator offloading. Defaults to an empty string. (since 9.2)
> +#
>  # Features:
>  #
>  # @deprecated: Member @block-incremental is deprecated.  Use
> @@ -1176,7 +1188,8 @@
>                                              'features': [ 'unstable' ] },
>              '*vcpu-dirty-limit': 'uint64',
>              '*mode': 'MigMode',
> -            '*zero-page-detection': 'ZeroPageDetection'} }
> +            '*zero-page-detection': 'ZeroPageDetection',
> +            '*multifd-dsa-accel': 'StrOrNull'} }

This needs to be

  ['str']   not 'StrOrNull'

>  
>  ##
>  # @migrate-set-parameters:
> @@ -1354,6 +1367,12 @@
>  #     See description in @ZeroPageDetection.  Default is 'multifd'.
>  #     (since 9.0)
>  #
> +# @multifd-dsa-accel: If enabled, use DSA accelerator offloading for
> +#     certain memory operations. Enable DSA accelerator offloading by
> +#     setting this string to a list of DSA device path separated by space
> +#     characters. Setting this string to an empty string means disabling
> +#     DSA accelerator offloading. Defaults to an empty string. (since 9.2)
> +#
>  # Features:
>  #
>  # @deprecated: Member @block-incremental is deprecated.  Use
> @@ -1405,7 +1424,8 @@
>                                              'features': [ 'unstable' ] },
>              '*vcpu-dirty-limit': 'uint64',
>              '*mode': 'MigMode',
> -            '*zero-page-detection': 'ZeroPageDetection'} }
> +            '*zero-page-detection': 'ZeroPageDetection',
> +            '*multifd-dsa-accel': 'str'} }

Liekewise needs to be

   ['str']


Having mgmt apps pass in the path every time though, feels like
overkill. Surely there's a standard path that QEMU should use
by default, and should only require flag to turn on its usage.

IOW, why not extend the ZeroPageDetection enum, to have a further
entry for 'dsa' to request ue of dsa accel. Passing paths could
be optional.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


