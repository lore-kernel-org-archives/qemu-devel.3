Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16760D5AE6F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 07:38:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8x55-0005IF-CM; Thu, 07 Nov 2024 02:37:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1t8x53-0005Hs-JQ
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 02:37:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1t8x51-00053Z-Qd
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 02:37:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730965042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=orQx0P5TQQjk91+GJi9h721lKcAJTd5bqWn0IxJNUP0=;
 b=ah5lEZllk2BOgsAHdefItkyPyuL8P/99wcLS/M/QbaqXWOKLanz5WVqe9sZz/dU5qbGdy4
 jpZT1DXNZRQ2uS/y+jQUj0MbovrUhjse1thaM2hXEq/6VnBBzwedfU/bmLwZlp9WHVgOmN
 V6NTjpTlOpTu0mzFd+GWDGdLxhxC/1k=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-456-fO-pWrxWN_-XPFlQoPYgdw-1; Thu,
 07 Nov 2024 02:37:17 -0500
X-MC-Unique: fO-pWrxWN_-XPFlQoPYgdw-1
X-Mimecast-MFC-AGG-ID: fO-pWrxWN_-XPFlQoPYgdw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1AB4F1955F34; Thu,  7 Nov 2024 07:37:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.150])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 563381955F3C; Thu,  7 Nov 2024 07:37:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 36FAF21E6A28; Thu,  7 Nov 2024 08:37:13 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org,  qemu-devel@nongnu.org,  eblake@redhat.com,
 devel@lists.libvirt.org,  hreitz@redhat.com,  kwolf@redhat.com,
 jsnow@redhat.com,  pkrempa@redhat.com
Subject: Re: [PATCH v3 6/7] qapi/block-core: deprecate block-job-change
In-Reply-To: <20241002140616.561652-7-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Wed, 2 Oct 2024 17:06:15 +0300")
References: <20241002140616.561652-1-vsementsov@yandex-team.ru>
 <20241002140616.561652-7-vsementsov@yandex-team.ru>
Date: Thu, 07 Nov 2024 08:37:13 +0100
Message-ID: <87cyj7mr4m.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

> That's a first step to move on newer job-* APIs.
>
> The difference between block-job-change and job-change is in
> find_block_job_locked() vs find_job_locked() functions. What's
> different?
>
> 1. find_block_job_locked() finds only block jobs, whereas
>    find_job_locked() finds any kind of job.  job-change is a
>    compatible extension of block-job-change.
>
> 2. find_block_job_locked() reports DeviceNotActive on failure, when
>    find_job_locked() reports GenericError.  Since the kind of error
>    reported isn't documented for either command, and clients
>    shouldn't rely on undocumented error details, job-change is a
>    compatible replacement for block-job-change.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Acked-by: Markus Armbruster <armbru@redhat.com>


