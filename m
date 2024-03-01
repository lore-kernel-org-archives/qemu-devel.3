Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF081C5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 07:40:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfxVh-0005R2-CS; Fri, 01 Mar 2024 02:40:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfxVb-0005QX-8V
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 02:40:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfxVZ-0001iG-N1
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 02:40:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709278840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HtKjMe+fbDWcT8yNOTXNYxPoS3fYcE6aqi8vIhzZ79c=;
 b=Y8IhqMLJEDyGd9p6G4xmKozoSFvtGx40xm5zF412fXrqVoz+rT68Ym7m0DVibzG1IFo4xA
 eS+oLRff1Nwd5+RLlGeCiLZBfoxC4opw1sUlk7M3H8QmbnUW0qi8suzghmmG0APYcnSmY0
 myMQaJYWENy1ip+1l2SO7HhYe+1YLRo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-sLohgB1VOTymwGrk8KQCuw-1; Fri, 01 Mar 2024 02:40:39 -0500
X-MC-Unique: sLohgB1VOTymwGrk8KQCuw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5DF13106CF99;
 Fri,  1 Mar 2024 07:40:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F20D61C060B1;
 Fri,  1 Mar 2024 07:40:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9BFAC21E6740; Fri,  1 Mar 2024 08:40:36 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Hao Xiang <hao.xiang@bytedance.com>
Cc: pbonzini@redhat.com,  berrange@redhat.com,  eduardo@habkost.net,
 peterx@redhat.com,  farosas@suse.de,  eblake@redhat.com,
 armbru@redhat.com,  thuth@redhat.com,  lvivier@redhat.com,
 jdenemar@redhat.com,  marcel.apfelbaum@gmail.com,  philmd@linaro.org,
 wangyanan55@huawei.com,  qemu-devel@nongnu.org
Subject: Re: [PATCH v4 6/7] migration/multifd: Add zero pages and zero bytes
 counter to migration status interface.
In-Reply-To: <20240301022829.3390548-7-hao.xiang@bytedance.com> (Hao Xiang's
 message of "Fri, 1 Mar 2024 02:28:28 +0000")
References: <20240301022829.3390548-1-hao.xiang@bytedance.com>
 <20240301022829.3390548-7-hao.xiang@bytedance.com>
Date: Fri, 01 Mar 2024 08:40:36 +0100
Message-ID: <87ttlqpfgr.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
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

Hao Xiang <hao.xiang@bytedance.com> writes:

> This change extends the MigrationStatus interface to track zero pages
> and zero bytes counter.
>
> Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>

[...]

> diff --git a/qapi/migration.json b/qapi/migration.json
> index ca9561fbf1..03b850bab7 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -63,6 +63,10 @@
>  #     between 0 and @dirty-sync-count * @multifd-channels.  (since
>  #     7.1)
>  #
> +# @zero-pages: number of zero pages (since 9.0)
> +#
> +# @zero-bytes: number of zero bytes sent (since 9.0)
> +#

Discussion of v3 has led me to believe:

1. A page is either migrated as a normal page or as a zero page.

2. The following equations hold:

    @normal-bytes = @normal * @page-size

    @zero-bytes = @zero-pages * @page-size

3. @zero-pages is the same as @duplicate, with a better name.  We intend
   to drop @duplicate eventually.

If this is correct, I'd like you to

A. Name it @zero for consistency with @normal.  Disregard my advice to
   name it @zero-pages; two consistent bad names are better than one bad
   name, one good name, and inconsistency.

B. Add @zero and @zero-bytes next to @normal and @normal-bytes.

C. Deprecate @duplicate (item 3).  Separate patch, please.

D. Consider documenting more clearly what normal and zero pages are
   (item 1), and how @FOO, @FOO-pages and @page-size are related (item
   2).  Could be done in a followup patch.

>  # Features:
>  #
>  # @deprecated: Member @skipped is always zero since 1.5.3
> @@ -81,7 +85,8 @@
>             'multifd-bytes': 'uint64', 'pages-per-second': 'uint64',
>             'precopy-bytes': 'uint64', 'downtime-bytes': 'uint64',
>             'postcopy-bytes': 'uint64',
> -           'dirty-sync-missed-zero-copy': 'uint64' } }
> +           'dirty-sync-missed-zero-copy': 'uint64',
> +           'zero-pages': 'int', 'zero-bytes': 'size' } }
>  

[...]


