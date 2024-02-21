Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE826C48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:46:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoaH-0007Ii-WC; Wed, 21 Feb 2024 10:32:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rcoSD-0003RC-4n
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:24:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rcijE-0001Ro-BS
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 04:17:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708507043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hKemNzyEDxMR9dRSjFinPfyeeGDMuqmVo7SqJ7xLIK0=;
 b=fmdgtgXgseihgFDYh51jOLAzl7S4b1pcNWF8J+4/5ltIBCmg+xstIPbhN09JPiYc6/cT5P
 UAfsrLCVjG97tuvBWEMrvUdT3wkB9ZNYFYX78IoZM0hjXJ92yQH4eIQzt9RKnWNNZInKTc
 F3Dc5KT4pCi/VBTbMN2PM8xnUv2Rly4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-tStC8PaQO3uvM17QAyOpXw-1; Wed, 21 Feb 2024 04:17:18 -0500
X-MC-Unique: tStC8PaQO3uvM17QAyOpXw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9EB148630C6;
 Wed, 21 Feb 2024 09:17:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C54D2022AAA;
 Wed, 21 Feb 2024 09:17:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 64CE121E6740; Wed, 21 Feb 2024 10:17:14 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  berrange@redhat.com,  Peter Xu
 <peterx@redhat.com>,  Claudio Fontana <cfontana@suse.de>,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH v4 27/34] migration: Add direct-io parameter
In-Reply-To: <20240220224138.24759-28-farosas@suse.de> (Fabiano Rosas's
 message of "Tue, 20 Feb 2024 19:41:31 -0300")
References: <20240220224138.24759-1-farosas@suse.de>
 <20240220224138.24759-28-farosas@suse.de>
Date: Wed, 21 Feb 2024 10:17:14 +0100
Message-ID: <87h6i2xjl1.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Fabiano Rosas <farosas@suse.de> writes:

> Add the direct-io migration parameter that tells the migration code to
> use O_DIRECT when opening the migration stream file whenever possible.
>
> This is currently only used with the fixed-ram migration that has a
> clear window guaranteed to perform aligned writes.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

[...]

> diff --git a/qapi/migration.json b/qapi/migration.json
> index 3fce5fe53e..41241a2178 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -878,6 +878,9 @@
>  # @mode: Migration mode. See description in @MigMode. Default is 'normal'.
>  #        (Since 8.2)
>  #
> +# @direct-io: Open migration files with O_DIRECT when possible. This
> +#     requires that the 'fixed-ram' capability is enabled. (since 9.0)

'fixed-ram' is a cross-reference to MigrationCapability member
fixed-ram.

For local members, @name is better than 'name', because @name carries
meaning, while 'name' could be anything.

Currently, @name is merely shorthand for ``name``, which is an reST
"inline literal", commonly used for short code snippets.  Rendered in
fixed-width font, unlike 'name'.

Making @name generating a link to the description would be a nice
improvement.

For non-local members, we can't make @name a link without also
specifying the thing it's a member of.

Let's stick to @name for member names, even non-local ones, so we get
the same font for all of them.

> +#
>  # Features:
>  #
>  # @deprecated: Member @block-incremental is deprecated.  Use
> @@ -911,7 +914,8 @@
>             'block-bitmap-mapping',
>             { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] },
>             'vcpu-dirty-limit',
> -           'mode'] }
> +           'mode',
> +           'direct-io'] }
>  
>  ##
>  # @MigrateSetParameters:
> @@ -1070,6 +1074,9 @@
>  # @mode: Migration mode. See description in @MigMode. Default is 'normal'.
>  #        (Since 8.2)
>  #
> +# @direct-io: Open migration files with O_DIRECT when possible. This
> +#     requires that the 'fixed-ram' capability is enabled. (since 9.0)
> +#
>  # Features:
>  #
>  # @deprecated: Member @block-incremental is deprecated.  Use
> @@ -1123,7 +1130,8 @@
>              '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
>                                              'features': [ 'unstable' ] },
>              '*vcpu-dirty-limit': 'uint64',
> -            '*mode': 'MigMode'} }
> +            '*mode': 'MigMode',
> +            '*direct-io': 'bool' } }
>  
>  ##
>  # @migrate-set-parameters:
> @@ -1298,6 +1306,9 @@
>  # @mode: Migration mode. See description in @MigMode. Default is 'normal'.
>  #        (Since 8.2)
>  #
> +# @direct-io: Open migration files with O_DIRECT when possible. This
> +#     requires that the 'fixed-ram' capability is enabled. (since 9.0)
> +#
>  # Features:
>  #
>  # @deprecated: Member @block-incremental is deprecated.  Use
> @@ -1348,7 +1359,8 @@
>              '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
>                                              'features': [ 'unstable' ] },
>              '*vcpu-dirty-limit': 'uint64',
> -            '*mode': 'MigMode'} }
> +            '*mode': 'MigMode',
> +            '*direct-io': 'bool' } }
>  
>  ##
>  # @query-migrate-parameters:

Other than that, QAPI schema
Acked-by: Markus Armbruster <armbru@redhat.com>


