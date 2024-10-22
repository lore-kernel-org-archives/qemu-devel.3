Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E0DD2C54C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 13:03:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3EXg-000620-C3; Tue, 22 Oct 2024 09:03:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t3EXa-00061i-Nn
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 09:03:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t3EXZ-0004iT-5g
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 09:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729602192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W1yZ+GCSEVLmGRocGXwtmWC0dKqLSXvl6B9DFzo7jP8=;
 b=TNjH+97NkUvywcF5OfVC016wKp/pymlOD6FbSsOCjQYwp96EybqZu5zw9NP2Ts4pw9y2lA
 M0+UYPknnyqA74tvbn8LpDBqsT+msX4Wk74Ql62aulvr6O4NtX5Ljbh6F3i15Y8WraOAn8
 dOmGLz5S3bk0LrGIq7jCitG0V5beQk8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-250-oW5zWu2YPfSejsUV4yV-6A-1; Tue,
 22 Oct 2024 09:03:09 -0400
X-MC-Unique: oW5zWu2YPfSejsUV4yV-6A-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3308C1955D59; Tue, 22 Oct 2024 13:03:08 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.70])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 003221955EA3; Tue, 22 Oct 2024 13:03:04 +0000 (UTC)
Date: Tue, 22 Oct 2024 15:03:01 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 eblake@redhat.com, devel@lists.libvirt.org, hreitz@redhat.com,
 jsnow@redhat.com, pkrempa@redhat.com
Subject: Re: [PATCH v3 5/7] qapi: add job-change
Message-ID: <ZxeihWyS3Cz13-pT@redhat.com>
References: <20241002140616.561652-1-vsementsov@yandex-team.ru>
 <20241002140616.561652-6-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002140616.561652-6-vsementsov@yandex-team.ru>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Am 02.10.2024 um 16:06 hat Vladimir Sementsov-Ogievskiy geschrieben:
> Add a new-style command job-change, doing same thing as
> block-job-change. The aim is finally deprecate block-job-* APIs and
> move to job-* APIs.
> 
> We add a new command to qapi/block-core.json, not to
> qapi/job.json to avoid resolving json file including loops for now.
> This all would be a lot simple to refactor when we finally drop
> deprecated block-job-* APIs.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  job-qmp.c            | 14 ++++++++++++++
>  qapi/block-core.json | 10 ++++++++++
>  2 files changed, 24 insertions(+)

> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index f370593037..e314734b53 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3105,6 +3105,16 @@
>  { 'command': 'block-job-change',
>    'data': 'JobChangeOptions', 'boxed': true }
>  
> +##
> +# @job-change:
> +#
> +# Change the block job's options.

s/block job/job/

> +#
> +# Since: 9.2
> +##
> +{ 'command': 'job-change',
> +  'data': 'JobChangeOptions', 'boxed': true }

Kevin


