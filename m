Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EA5606A326
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 16:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=du6I4lJx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOH2p-000447-T9; Tue, 03 Nov 2026 11:07:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xOH2o-00042z-7d
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 11:07:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xOH2m-0007KC-QH
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 11:07:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793722047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3mYQc2X2c2Y6XnLjlwA1Fyb8sxEfMeu7BBcTI4ivtJI=;
 b=du6I4lJxPslru/bOCjENEvUhGGfzmElM+J5C5suxtlXRlAk9cKyw/FRB6HmuhD25mL1m7z
 gmP//5bsRhlE5MiKIsMHkyX5h0VePJkUKZmk5LyOPkNCqSl03G8VTHpatR0QK7J20zDoqv
 NGWSFriDjwkEX9wMHCffxaapvJoFPU4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-97-_wYsNc3XNESn3j_m6v_9IA-1; Tue,
 03 Nov 2026 11:07:22 -0500
X-MC-Unique: _wYsNc3XNESn3j_m6v_9IA-1
X-Mimecast-MFC-AGG-ID: _wYsNc3XNESn3j_m6v_9IA_1793722041
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 33AD01955DC3; Tue,  3 Nov 2026 16:07:19 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.52])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 62E7B180057F; Tue,  3 Nov 2026 16:07:17 +0000 (UTC)
Date: Tue, 3 Nov 2026 17:07:15 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 jean-louis@dupond.be, den@openvz.org
Subject: Re: [PATCH 0/3] qcow2: fix discard-no-unref=on data corruption
Message-ID: <auoGs-0R5rOF2gMB@redhat.com>
References: <20261027104441.830212-1-andrey.drobyshev@virtuozzo.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027104441.830212-1-andrey.drobyshev@virtuozzo.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 27.10.2026 um 11:44 hat Andrey Drobyshev geschrieben:
> 1st commit with tests is my own old commit from previously unmerged
> subcluster series [1].
> 2nd is the actual bug fix, 3rd is the regression test.
> 
> [1] https://lore.kernel.org/qemu-devel/20240913163942.423050-1-andrey.drobyshev@virtuozzo.com
> 
> Andrey Drobyshev (3):
>   iotests/290: add test case to check 'discard-no-unref' option behavior
>   qcow2: fix snapshot data corruption with discard-no-unref=on
>     #VSTOR-151885
>   iotests/290: add 'discard' and 'write -z -u' case with a snapshot
>     #VSTOR-151885
> 
>  block/qcow2-cluster.c      |  6 +++--
>  tests/qemu-iotests/290     | 50 ++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/290.out | 33 +++++++++++++++++++++++++
>  3 files changed, 87 insertions(+), 2 deletions(-)

Patches 2 and 3:
Reviewed-by: Kevin Wolf <kwolf@redhat.com>


