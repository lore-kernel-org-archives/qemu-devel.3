Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA0BCD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 11:59:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMllF-0001Jc-Am; Tue, 12 May 2026 07:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wMllC-0001In-0K
 for qemu-devel@nongnu.org; Tue, 12 May 2026 07:58:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wMllA-0005PA-BF
 for qemu-devel@nongnu.org; Tue, 12 May 2026 07:58:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778587122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nrrWx4FGULrR2I1Ew3PrWpUUZMkz76/dJB4OwPA7KLA=;
 b=FUM0Ya5PzC8BJIw8N2+hFdTGdvaakTyCo+7CODi+x+T27yKuYzEhoS+q8vnBLtpQHdy6Ca
 QkzgyKAZWtx4Qr5tRvtVAw3VP7GqzhAiC0KWgOhmMbuBheUcJGnGA78Qi9dHS+JqI1JQP3
 TUMU2PWza3PYaZLhzV2aiVZcy7dPmSY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-499-pVJr_ApKMheAR_IuEtU5OQ-1; Tue,
 12 May 2026 07:58:38 -0400
X-MC-Unique: pVJr_ApKMheAR_IuEtU5OQ-1
X-Mimecast-MFC-AGG-ID: pVJr_ApKMheAR_IuEtU5OQ_1778587116
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1EC6318005BF; Tue, 12 May 2026 11:58:36 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.152])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 034DC30001BE; Tue, 12 May 2026 11:58:32 +0000 (UTC)
Date: Tue, 12 May 2026 13:58:30 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: hreitz@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Subject: Re: [PATCH 0/7] ide: Fix deadlock between TRIM and drain
Message-ID: <agMV5rhQxIfEmumH@redhat.com>
References: <20260421161132.99878-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421161132.99878-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 21.04.2026 um 18:11 hat Kevin Wolf geschrieben:
> Patches 2 and 4 are the core of the fix, see their commit message for
> details.
> 
> Kevin Wolf (7):
>   blkdebug: Add 'delay-ns' option
>   block: Add blk_co_start/end_request() and BDRV_REQ_NO_QUEUE
>   block: Add flags parameter to blk_*_pdiscard()
>   ide: Minimal fix for deadlock between TRIM and drain
>   ide: Clean up ide_trim_co_entry() to be idiomatic coroutine code
>   ide-test: Factor out wait_dma_completion()
>   ide-test: Test reset during TRIM

Applied to the block branch.

Kevin


