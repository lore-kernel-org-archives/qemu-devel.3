Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9591E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 10:58:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV7Hq-0003lc-Tk; Tue, 07 Jan 2025 05:58:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tV7Hp-0003lT-D1
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 05:58:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tV7Hn-000758-8W
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 05:58:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736247488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JW1MXiAJRgyA+aiEnIV6hEQ10AOKG3ov2cHF2WaP5So=;
 b=ZkQzawIG0O5T2g4VTiM9CrXVuTo+etStpwh2Ar/xCx1RPNPSkocmDHmnLcRJo6M5hUcWvw
 Bvit5112XG4Gmtjmu9MmtQswqw496RlaGDuqGmpY7tk97db1VTKLiVBlTZsq1GJb36WMk/
 jf9FsSoczTDccdygnb2+xzFXiH9QxEM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-183-BMB70ZUmPN-kMJbLzVOnOw-1; Tue,
 07 Jan 2025 05:58:03 -0500
X-MC-Unique: BMB70ZUmPN-kMJbLzVOnOw-1
X-Mimecast-MFC-AGG-ID: BMB70ZUmPN-kMJbLzVOnOw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 60E731955F65; Tue,  7 Jan 2025 10:58:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.194.101])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 33A8A1956053; Tue,  7 Jan 2025 10:57:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CA1D321E6924; Tue, 07 Jan 2025 11:57:56 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Yichen Wang <yichen.wang@bytedance.com>
Cc: Peter Xu <peterx@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  "Dr.
 David Alan Gilbert" <dave@treblig.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Eric Blake <eblake@redhat.com>,  "Michael S.
 Tsirkin" <mst@redhat.com>,  Cornelia Huck <cohuck@redhat.com>,  Laurent
 Vivier <lvivier@redhat.com>,  qemu-devel@nongnu.org,  "Hao Xiang"
 <hao.xiang@linux.dev>,  "Liu, Yuan1" <yuan1.liu@intel.com>,  "Shivam
 Kumar" <shivam.kumar1@nutanix.com>,  "Ho-Ren (Jack) Chuang"
 <horenchuang@bytedance.com>
Subject: Re: [PATCH v9 08/12] migration/multifd: Add new migration option
 for multifd DSA offloading.
In-Reply-To: <20241225005919.26853-9-yichen.wang@bytedance.com> (Yichen Wang's
 message of "Tue, 24 Dec 2024 16:59:15 -0800")
References: <20241225005919.26853-1-yichen.wang@bytedance.com>
 <20241225005919.26853-9-yichen.wang@bytedance.com>
Date: Tue, 07 Jan 2025 11:57:56 +0100
Message-ID: <874j2ac2mj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Yichen Wang <yichen.wang@bytedance.com> writes:

> From: Hao Xiang <hao.xiang@linux.dev>
>
> Intel DSA offloading is an optional feature that turns on if
> proper hardware and software stack is available. To turn on
> DSA offloading in multifd live migration by setting:
>
> zero-page-detection=dsa-accel
> accel-path="dsa:<dsa_dev_path1> dsa:[dsa_dev_path2] ..."
>
> This feature is turned off by default.
>
> Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
> Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
> Acked-by: Dr. David Alan Gilbert <dave@treblig.org>

[...]

> diff --git a/qapi/migration.json b/qapi/migration.json
> index a605dc26db..76a3920e2e 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -629,10 +629,14 @@
>  #     multifd migration is enabled, else in the main migration thread
>  #     as for @legacy.
>  #
> +# @dsa-accel: Perform zero page checking with the DSA accelerator
> +#     offloading in multifd sender thread if multifd migration is
> +#     enabled, else in the main migration thread as for @legacy.
> +#
>  # Since: 9.0
>  ##
>  { 'enum': 'ZeroPageDetection',
> -  'data': [ 'none', 'legacy', 'multifd' ] }
> +  'data': [ 'none', 'legacy', 'multifd', 'dsa-accel' ] }
>  
>  ##
>  # @BitmapMigrationBitmapAliasTransform:
> @@ -840,6 +844,12 @@
>  #     See description in @ZeroPageDetection.  Default is 'multifd'.
>  #     (since 9.0)
>  #
> +# @accel-path: If enabled, specify the accelerator paths that to be

"If enabled" makes no sense, I'm afraid.

> +#     used in QEMU. For example, enable DSA accelerator for zero page

Please separate sentences with two spaces for consistency.

> +#     detection offloading by setting the @zero-page-detection to
> +#     dsa-accel, and defines the accel-path to "dsa:<dsa_device path>".

Looks like the members of the lists are strings in a little language you
invented, but are not defining here.

What is the abstract structure of the configuration data are you trying
to pass here?

> +#     This parameter is default to an empty list.  (Since 10.0)

Either "This parameter defaults to an empty list" or "(default empty
list)".

> +#
>  # @direct-io: Open migration files with O_DIRECT when possible.  This
>  #     only has effect if the @mapped-ram capability is enabled.
>  #     (Since 9.1)
> @@ -858,7 +868,7 @@
>             'cpu-throttle-initial', 'cpu-throttle-increment',
>             'cpu-throttle-tailslow',
>             'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
> -           'avail-switchover-bandwidth', 'downtime-limit',
> +           'avail-switchover-bandwidth', 'downtime-limit', 'accel-path',
>             { 'name': 'x-checkpoint-delay', 'features': [ 'unstable' ] },
>             'multifd-channels',
>             'xbzrle-cache-size', 'max-postcopy-bandwidth',

[...]


