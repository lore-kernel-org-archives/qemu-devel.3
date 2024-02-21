Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3126C5478A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:39:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoaC-0006ZD-MN; Wed, 21 Feb 2024 10:32:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rcoSD-0003Ss-KJ
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:24:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rciAE-00057v-EU
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 03:41:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708504872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kQC3iDEwTU0zOMJx2FKCKhfHkf/F88iH7Ne+kunsMtE=;
 b=gYRXgcX1838su7vEB4yg34v9CeAKHJrJwX0PYgU7ZBNTQSpyIDs0sY7qUm2JXpyI/awBxm
 OkrhYxnj58kudyPfO0HUCKoHP9pXBHLY1I7loFkNR1lX10r2opMeLYD018NI1DXVz6/w+O
 4LCeGOXc13ZVQjuM3R4o8PsiW14PVP0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-513-V6DZBQODM3KJGgo7izz8WQ-1; Wed,
 21 Feb 2024 03:41:10 -0500
X-MC-Unique: V6DZBQODM3KJGgo7izz8WQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0853D1C0BB5B;
 Wed, 21 Feb 2024 08:41:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D9C012166B36;
 Wed, 21 Feb 2024 08:41:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9C5C821E66D5; Wed, 21 Feb 2024 09:41:08 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  berrange@redhat.com,  Peter Xu
 <peterx@redhat.com>,  Claudio Fontana <cfontana@suse.de>,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH v4 11/34] migration/ram: Introduce 'fixed-ram' migration
 capability
In-Reply-To: <20240220224138.24759-12-farosas@suse.de> (Fabiano Rosas's
 message of "Tue, 20 Feb 2024 19:41:15 -0300")
References: <20240220224138.24759-1-farosas@suse.de>
 <20240220224138.24759-12-farosas@suse.de>
Date: Wed, 21 Feb 2024 09:41:08 +0100
Message-ID: <87o7caxl97.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> Add a new migration capability 'fixed-ram'.
>
> The core of the feature is to ensure that each RAM page has a specific
> offset in the resulting migration stream. The reasons why we'd want
> such behavior are:
>
>  - The resulting file will have a bounded size, since pages which are
>    dirtied multiple times will always go to a fixed location in the
>    file, rather than constantly being added to a sequential
>    stream. This eliminates cases where a VM with, say, 1G of RAM can
>    result in a migration file that's 10s of GBs, provided that the
>    workload constantly redirties memory.
>
>  - It paves the way to implement O_DIRECT-enabled save/restore of the
>    migration stream as the pages are ensured to be written at aligned
>    offsets.
>
>  - It allows the usage of multifd so we can write RAM pages to the
>    migration file in parallel.
>
> For now, enabling the capability has no effect. The next couple of
> patches implement the core functionality.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

[...]

> diff --git a/qapi/migration.json b/qapi/migration.json
> index 5a565d9b8d..3fce5fe53e 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -531,6 +531,10 @@
>  #     and can result in more stable read performance.  Requires KVM
>  #     with accelerator property "dirty-ring-size" set.  (Since 8.1)
>  #
> +# @fixed-ram: Migrate using fixed offsets in the migration file for
> +#     each RAM page.  Requires a migration URI that supports seeking,
> +#     such as a file.  (since 9.0)
> +#
>  # Features:
>  #
>  # @deprecated: Member @block is deprecated.  Use blockdev-mirror with
> @@ -555,7 +559,7 @@
>             { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
>             'validate-uuid', 'background-snapshot',
>             'zero-copy-send', 'postcopy-preempt', 'switchover-ack',
> -           'dirty-limit'] }
> +           'dirty-limit', 'fixed-ram'] }
>  
>  ##
>  # @MigrationCapabilityStatus:

Can we find a better name than @fixed-ram?  @fixed-ram-offsets?
@use-seek?

Apart from that, QAPI schema
Acked-by: Markus Armbruster <armbru@redhat.com>


