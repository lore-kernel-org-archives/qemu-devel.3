Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52903C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 14:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8KGr-0006tk-M2; Fri, 25 Apr 2025 10:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1u8KGo-0006t8-W9
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 10:43:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1u8KGi-0006M0-7h
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 10:43:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745592184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f12rdVTm4LTEtIPQBcA5gNprqcbubUfKXV49fLf41XU=;
 b=YI/8kpIWAyjFMSrEjVtel85Bci/Ci77xrCoHc5elQ9NGkB9CZq4OQNeG7zsH1l3LVojPG6
 J/YFmS8EWFqAa5aWDjDYzHd1OfquyNcUlD6Nn57O7ctgYWZv1AVf+KI1Jc4qAyS2ErVFO1
 BL+hOYaPwvFc55XEuxh40UMnSWYAkMo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269-tF1TF1n-PW6xtHFW9rAZLQ-1; Fri,
 25 Apr 2025 10:43:00 -0400
X-MC-Unique: tF1TF1n-PW6xtHFW9rAZLQ-1
X-Mimecast-MFC-AGG-ID: tF1TF1n-PW6xtHFW9rAZLQ_1745592179
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 211C51800368; Fri, 25 Apr 2025 14:42:59 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.183])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E7E97180047F; Fri, 25 Apr 2025 14:42:55 +0000 (UTC)
Date: Fri, 25 Apr 2025 16:42:53 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v4 0/2] block: discard alignment fixes
Message-ID: <aAufbVJQvQMoH89X@redhat.com>
References: <20250417150528.76470-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417150528.76470-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.314,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 17.04.2025 um 17:05 hat Stefan Hajnoczi geschrieben:
> v4:
> - Mention -EINVAL in bdrv_co_pdiscard() comment [Kevin]
> v3:
> - Refine error handling when pdiscard_alignment is not a multiple of request_alignment [Hanna]
> v2:
> - Fix inverted logic in alignment check [Qing Wang]
> 
> Two discard alignment issues were identified in
> https://issues.redhat.com/browse/RHEL-86032:
> 1. pdiscard_alignment is not populated for host_device in file-posix.c.
> 2. Misaligned head/tail discard requests are not skipped when file-posix.c
>    returns -EINVAL. This causes an undesired pause when guests are configured
>    with werror=stop.

Thanks, applied to the block branch.

Kevin


