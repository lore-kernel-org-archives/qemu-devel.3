Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A47C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 13:05:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rok0b-00030L-6H; Mon, 25 Mar 2024 09:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rok0Y-0002zg-C5
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 09:04:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rok0W-0002Eb-UC
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 09:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711371895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WzhNu2SlzepPL/r4VUFLCuRwT3iYe0Fjk5/bXXDEJY0=;
 b=YVJ2GsGLoktxPl1LQS1F4Ds9YFrPbmIVlOnfWAlnQG+6q1YCZ4CWe9qT2dR1nxus8DxUyc
 YJIcQjlsIGsVXn83VIAqfLSKQNiw1FVkkfGAV7uFl43CxNjwVZU6wVCE2a8QBWhDyqrZZk
 qFS06DuLb1d4osZQHWQ+0ddVUA1qGIc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-pJA3k_qYMK2ZiiDz797eIQ-1; Mon, 25 Mar 2024 09:04:53 -0400
X-MC-Unique: pJA3k_qYMK2ZiiDz797eIQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E4950800267;
 Mon, 25 Mar 2024 13:04:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ABE5F40C6DB5;
 Mon, 25 Mar 2024 13:04:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C0A7021E669D; Mon, 25 Mar 2024 14:04:31 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org,  qemu-devel@nongnu.org,  eblake@redhat.com,
 hreitz@redhat.com,  kwolf@redhat.com
Subject: Re: [PATCH] qapi/block-core: improve Qcow2OverlapCheckFlags
 documentation
In-Reply-To: <20240325120054.2693236-1-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Mon, 25 Mar 2024 15:00:54 +0300")
References: <20240325120054.2693236-1-vsementsov@yandex-team.ru>
Date: Mon, 25 Mar 2024 14:04:31 +0100
Message-ID: <87le66laxs.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> Most of fields have no description at all. Let's fix that. Still, no
> reason to place here more detailed descriptions of what these
> structures are, as we have public Qcow2 format specification.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  qapi/block-core.json | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 1874f880a8..b9fb994a66 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3403,14 +3403,31 @@
>  # @Qcow2OverlapCheckFlags:
>  #
>  # Structure of flags for each metadata structure.  Setting a field to
> -# 'true' makes qemu guard that structure against unintended
> -# overwriting.  The default value is chosen according to the template
> -# given.
> +# 'true' makes qemu guard that Qcow2 format structure against

Mind if I use the occasion to correct the spelling of QEMU?

> +# unintended overwriting.  See Qcow2 format specification for detailed
> +# information on these structures.  The default value is chosen
> +# according to the template given.
>  #
>  # @template: Specifies a template mode which can be adjusted using the
>  #     other flags, defaults to 'cached'
>  #
> -# @bitmap-directory: since 3.0
> +# @main-header: Qcow2 format header
> +#
> +# @active-l1: Qcow2 active L1 table
> +#
> +# @active-l2: Qcow2 active L2 table
> +#
> +# @refcount-table: Qcow2 refcount table
> +#
> +# @refcount-block: Qcow2 refcount blocks
> +#
> +# @snapshot-table: Qcow2 snapshot table
> +#
> +# @inactive-l1: Qcow2 inactive L1 tables
> +#
> +# @inactive-l2: Qcow2 inactive L2 tables
> +#
> +# @bitmap-directory: Qcow2 bitmap directory (since 3.0)
>  #
>  # Since: 2.9
>  ##

Acked-by: Markus Armbruster <armbru@redhat.com>


