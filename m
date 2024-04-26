Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90296C25B5C
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 14:33:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0MdY-0008Gs-9N; Fri, 26 Apr 2024 10:33:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s0MdW-0008Eh-26
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 10:33:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s0MdU-000401-J9
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 10:33:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714141991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3w5xIQawdXNkAYHJwWwOmTO2KDZnlg+FuuQTraSXhBU=;
 b=METnr9KC7AdGxhEkX/9YV3Gqg/AHI+t6ADGhFrvfTwnmSk+z7zpYNNVZz5DnwvIqir+Px4
 N4P5ccXBHdDPdQ6MfEEZ2ZvRDwr7RHtpjCDUyCOreNbgZFgHKPQFJTccka2pCogdNg5erF
 8Ov7q0B0aotDwU7405IUYo4GsGtmoEI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-ncYoZnY2Mi-B5bI6J-46AA-1; Fri, 26 Apr 2024 10:33:08 -0400
X-MC-Unique: ncYoZnY2Mi-B5bI6J-46AA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8240E800CA2;
 Fri, 26 Apr 2024 14:33:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F00B400EAC;
 Fri, 26 Apr 2024 14:33:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 51D7721E6811; Fri, 26 Apr 2024 16:33:06 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  berrange@redhat.com,  armbru@redhat.com,  Peter
 Xu <peterx@redhat.com>,  Claudio Fontana <cfontana@suse.de>,  Jim Fehlig
 <jfehlig@suse.com>,  Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 4/9] migration: Add direct-io parameter
In-Reply-To: <20240426142042.14573-5-farosas@suse.de> (Fabiano Rosas's message
 of "Fri, 26 Apr 2024 11:20:37 -0300")
References: <20240426142042.14573-1-farosas@suse.de>
 <20240426142042.14573-5-farosas@suse.de>
Date: Fri, 26 Apr 2024 16:33:06 +0200
Message-ID: <87jzkkqjml.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Fabiano Rosas <farosas@suse.de> writes:

> Add the direct-io migration parameter that tells the migration code to
> use O_DIRECT when opening the migration stream file whenever possible.
>
> This is currently only used with the mapped-ram migration that has a
> clear window guaranteed to perform aligned writes.
>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

[...]

> diff --git a/qapi/migration.json b/qapi/migration.json
> index 8c65b90328..1a8a4b114c 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -914,6 +914,9 @@
>  #     See description in @ZeroPageDetection.  Default is 'multifd'.
>  #     (since 9.0)
>  #
> +# @direct-io: Open migration files with O_DIRECT when possible. This
> +#     requires that the @mapped-ram capability is enabled. (since 9.1)
> +#

Two spaces between sentences for consistency, please.

>  # Features:
>  #
>  # @deprecated: Member @block-incremental is deprecated.  Use
> @@ -948,7 +951,8 @@
>             { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] },
>             'vcpu-dirty-limit',
>             'mode',
> -           'zero-page-detection'] }
> +           'zero-page-detection',
> +           'direct-io'] }
>  
>  ##
>  # @MigrateSetParameters:

[...]


