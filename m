Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F93C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 15:00:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcQbG-0002Z8-6L; Mon, 27 Jan 2025 10:00:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tcQar-0002Pr-Hl
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 10:00:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tcQap-0008Jh-Ml
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 10:00:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737990002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UWXAeaw53oOUf+nFHf2R78ExMbour4cE0GRNazxQZfY=;
 b=K7ftURy2CVRh1mJk088RRWuSqA4ljAD1EDE/phtRF3x8t2Scdus4bnlxvU6iiVDlbdy5gs
 oTefJPehuZNkjM0ve2YY8ct8/D4oF7uZjczJNJT5YR1Tqsf2RWKqvD/wBAKq7OSvVCG11/
 Ipswd2fFG11LjlSoUrjNC3Ma69QxM2Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-298-f9AiXbLeM6K4Of6rRnjxFA-1; Mon,
 27 Jan 2025 09:59:59 -0500
X-MC-Unique: f9AiXbLeM6K4Of6rRnjxFA-1
X-Mimecast-MFC-AGG-ID: f9AiXbLeM6K4Of6rRnjxFA
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C22731800378; Mon, 27 Jan 2025 14:59:56 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.225])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E05E61800348; Mon, 27 Jan 2025 14:59:52 +0000 (UTC)
Date: Mon, 27 Jan 2025 15:59:50 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Krempa <pkrempa@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, qemu-stable@nongnu.org, vsementsov@yandex-team.ru
Subject: Re: [PATCH] block-backend: Fix argument order when calling
 'qapi_event_send_block_io_error()'
Message-ID: <Z5efZkr0H3Q-nspy@redhat.com>
References: <09728d784888b38d7a8f09ee5e9e9c542c875e1e.1737973614.git.pkrempa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09728d784888b38d7a8f09ee5e9e9c542c875e1e.1737973614.git.pkrempa@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Am 27.01.2025 um 11:29 hat Peter Krempa geschrieben:
> Commit 7452162adec25c10 introduced 'qom-path' argument to BLOCK_IO_ERROR
> event but when the event is instantiated in 'send_qmp_error_event()' the
> arguments for 'device' and 'qom_path' in
> qapi_event_send_block_io_error() were reversed :
> 
> Generated code for sending event:
> 
>   void qapi_event_send_block_io_error(const char *qom_path,
>                                       const char *device,
>                                       const char *node_name,
>                                       IoOperationType operation,
>                                       [...]
> 
> Call inside send_qmp_error_event():
> 
>      qapi_event_send_block_io_error(blk_name(blk),
>                                     blk_get_attached_dev_path(blk),
>                                     bs ? bdrv_get_node_name(bs) : NULL, optype,
>                                     [...]
> 
> This results into reporting the QOM path as the device alias and vice
> versa which in turn breaks libvirt, which expects the device alias being
> either a valid alias or empty (which would make libvirt do the lookup by
> node-name instead).
> 
> Fixes: 7452162adec25c1003d5bf0079aca52913a80e0c
> Signed-off-by: Peter Krempa <pkrempa@redhat.com>

Thanks, applied to the block branch after resolving a merge conflict
with:

    block: Fix leak in send_qmp_error_event
    https://lists.gnu.org/archive/html/qemu-block/2024-11/msg00258.html

Both patches are trivial, so I'm reasonably confident I got this one
right. :-)

Kevin


