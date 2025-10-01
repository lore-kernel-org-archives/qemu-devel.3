Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F698CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 09:44:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3tNF-0002Yt-Ap; Wed, 01 Oct 2025 05:43:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v3tNA-0002YA-JU
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 05:43:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v3tMx-0002Hb-CM
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 05:43:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759311801;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=uePlgq2yzw7XHZ5fijPn3ktH6jF0INhzyLGeD0niPoU=;
 b=GX6H8VKyx1ImmXw7iA2An4rGh/QQwoG/R23w83hEAG2wDjqpGIV8G2IFc0OiHeUhkAFCH5
 nlJjdrtsL9bKHGyQAMXQcT1OcXM5I7SW1YhnA3jEKgOuldKDmnabGpWVUQUPHCq+3CDb6s
 i23lpUFTBWg6cJs/vYJDgk+f93AGL50=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-140-GIrGU6ULNjqsG2TwVSzz5g-1; Wed,
 01 Oct 2025 05:43:18 -0400
X-MC-Unique: GIrGU6ULNjqsG2TwVSzz5g-1
X-Mimecast-MFC-AGG-ID: GIrGU6ULNjqsG2TwVSzz5g_1759311796
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 93FB81944EB6; Wed,  1 Oct 2025 09:43:15 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.187])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 034E430002D0; Wed,  1 Oct 2025 09:43:06 +0000 (UTC)
Date: Wed, 1 Oct 2025 10:43:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wei Liu <liuwe@microsoft.com>, Cornelia Huck <cohuck@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Eric Blake <eblake@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v4 24/27] qapi/accel: Allow to query mshv capabilities
Message-ID: <aNz3p2QyQaFg6r0P@redhat.com>
References: <20250916164847.77883-1-magnuskulke@linux.microsoft.com>
 <20250916164847.77883-25-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250916164847.77883-25-magnuskulke@linux.microsoft.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Sep 16, 2025 at 06:48:44PM +0200, Magnus Kulke wrote:
> From: Praveen K Paladugu <prapal@microsoft.com>
> 
> Allow to query mshv capabilities via query-mshv QMP and info mshv HMP commands.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
>  hmp-commands-info.hx       | 13 +++++++++++++
>  hw/core/machine-hmp-cmds.c | 15 +++++++++++++++
>  hw/core/machine-qmp-cmds.c | 14 ++++++++++++++
>  include/monitor/hmp.h      |  1 +
>  include/system/hw_accel.h  |  1 +
>  qapi/accelerator.json      | 29 +++++++++++++++++++++++++++++
>  6 files changed, 73 insertions(+)

> diff --git a/qapi/accelerator.json b/qapi/accelerator.json
> index fb28c8d920..c2bfbc507f 100644
> --- a/qapi/accelerator.json
> +++ b/qapi/accelerator.json
> @@ -54,3 +54,32 @@
>  { 'command': 'x-accel-stats',
>    'returns': 'HumanReadableText',
>    'features': [ 'unstable' ] }
> +
> +##
> +# @MshvInfo:
> +#
> +# Information about support for MSHV acceleration
> +#
> +# @enabled: true if MSHV acceleration is active
> +#
> +# @present: true if MSHV acceleration is built into this executable
> +#
> +# Since: 10.0.92

FYI, any time the last "miro" component is 50, it indicates
a development stream, and 90 onwards indicates a release candidate.

QAPI schema 'Since" tags shouldn't ever used those numbers, instead
when proposing patches, use the forthcoming GA release version which
will be a .0 in the micro component.

QEMU does three releases a year, and bumps the major version component
at the start of each year, and minor component for each release. The
micro component is always 0 for the first release, and then stable
branches bump micro.

We've just had 10.1.0, so the next release will be 10.2.0 and then
after that next year we'll be going to 11.0.0, 

IOW for your patches, this should now be using 10.2.0 as that's the
next release available for merging

> +##
> +{ 'struct': 'MshvInfo', 'data': {'enabled': 'bool', 'present': 'bool'} }
> +
> +##
> +# @query-mshv:
> +#
> +# Return information about MSHV acceleration
> +#
> +# Returns: @MshvInfo
> +#
> +# Since: 10.0.92
> +#
> +# .. qmp-example::
> +#
> +#     -> { "execute": "query-mshv" }
> +#     <- { "return": { "enabled": true, "present": true } }
> +##
> +{ 'command': 'query-mshv', 'returns': 'MshvInfo' }
> -- 
> 2.34.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


