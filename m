Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E80C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 11:54:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2V0H-0000Wp-30; Thu, 02 May 2024 07:53:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s2V0B-0000Tk-4n
 for qemu-devel@nongnu.org; Thu, 02 May 2024 07:53:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s2V08-0005Mr-Rp
 for qemu-devel@nongnu.org; Thu, 02 May 2024 07:53:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714650803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VFYzTiIYnjTlO2S60NhTNUnRRSemmcyNKdgoXg6Nsqs=;
 b=V9dUQ8iLmIYD6P3b4yXt14Rk78++/82HKuYJj0KYYc/2yQ16coDVsbpVY7nB9vLLVbYm5Q
 ejKw8rtpgWylJ/au+TKZyaC2QIbv5OzntxQdGFNqM6gsGo8sOLxS9IwClHDGq32ojceBTu
 3LcuaXJiodVT9xTeihDKm3kU5DhAIcE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-lmNEliEyNBiyfxem281fZg-1; Thu, 02 May 2024 07:53:19 -0400
X-MC-Unique: lmNEliEyNBiyfxem281fZg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 40EC918065AD;
 Thu,  2 May 2024 11:53:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E6432033A43;
 Thu,  2 May 2024 11:53:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C3BC521E6811; Thu,  2 May 2024 13:53:17 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>,  devel@lists.libvirt.org,  Markus
 Armbruster <armbru@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Thomas Huth
 <thuth@redhat.com>,  Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,  "Dr. David Alan Gilbert"
 <dave@treblig.org>,  Eric Blake <eblake@redhat.com>,  Kevin Wolf
 <kwolf@redhat.com>,  Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v3 3/6] migration: Remove 'blk/-b' option from migrate
 commands
In-Reply-To: <20240430142737.29066-4-farosas@suse.de> (Fabiano Rosas's message
 of "Tue, 30 Apr 2024 11:27:34 -0300")
References: <20240430142737.29066-1-farosas@suse.de>
 <20240430142737.29066-4-farosas@suse.de>
Date: Thu, 02 May 2024 13:53:17 +0200
Message-ID: <87y18s77ma.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.476,
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

Fabiano Rosas <farosas@suse.de> writes:

> The block migration is considered obsolete and has been deprecated in
> 8.2. Remove the migrate command option that enables it. This only
> affects the QMP and HMP commands, the feature can still be accessed by
> setting the migration 'block' capability. The whole feature will be
> removed in a future patch.
>
> Deprecation commit 8846b5bfca ("migration: migrate 'blk' command
> option is deprecated.").
>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

[...]

> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 7978302949..ebca2cdced 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -909,21 +909,17 @@ ERST
>  
>      {
>          .name       = "migrate",
> -        .args_type  = "detach:-d,blk:-b,resume:-r,uri:s",
> -        .params     = "[-d] [-b] [-r] uri",
> +        .args_type  = "detach:-d,resume:-r,uri:s",
> +        .params     = "[-d] [-r] uri",
>          .help       = "migrate to URI (using -d to not wait for completion)"
> -		      "\n\t\t\t -b for migration without shared storage with"
> -		      " full copy of disk\n\t\t\t -r to resume a paused migration",
> +		      "\n\t\t\t -r to resume a paused migration",
>          .cmd        = hmp_migrate,
>      },
>  
>  
>  SRST
> -``migrate [-d] [-b]`` *uri*
> +``migrate [-d]`` *uri*
>    Migrate to *uri* (using -d to not wait for completion).
> -
> -  ``-b``
> -    for migration with full copy of disk
>  ERST

Not this patch's fault, but here goes anyway: -r is undocumented here.

>  
>      {

[...]


