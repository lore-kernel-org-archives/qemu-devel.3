Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D6BEC531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 17:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnJMo-0001ky-GM; Fri, 24 Jul 2026 13:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wnJMm-0001kU-Ag
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 13:07:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wnJMk-00010P-GG
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 13:07:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784912836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tRwjbs01iHq1/foUq4mTnBgeNdu7URzLyxQZpcgQL4w=;
 b=ceNZl+HhB6JjufpcueGvj2r8aISCR0MhGsX/ll/j2EcrZYgZIogENmi/EOXaWXD85lpOVw
 K/UfisbFJJk16bw5aVetK3n86ecDaAf/8Dy2K9PmuUNjrNVnxOmVN/Ny7pKFtxL8IazHLX
 +mt98lgXN9Zxq+kGQOm2dAQGWRcsuTg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-6bqmfzRyPAixf_OgUg65aw-1; Fri,
 24 Jul 2026 13:07:14 -0400
X-MC-Unique: 6bqmfzRyPAixf_OgUg65aw-1
X-Mimecast-MFC-AGG-ID: 6bqmfzRyPAixf_OgUg65aw_1784912832
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D609A180A8F4; Fri, 24 Jul 2026 17:07:11 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.93])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BAA3915AD; Fri, 24 Jul 2026 17:07:09 +0000 (UTC)
Date: Fri, 24 Jul 2026 19:07:07 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH v2 0/3] iotests: fix three spurious local failures
Message-ID: <amObu_2az8zKoLKs@redhat.com>
References: <20260715103451.1930909-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715103451.1930909-1-den@openvz.org>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 15.07.2026 um 12:34 hat Denis V. Lunev geschrieben:
> Three independent fixes found while chasing a clean './check -qcow2'
> run on a Python 3.14 host. Unrelated to each other, sent as one
> series since they came out of the same session.
> 
> v2:
> - patch 1: drop the now-unused 'Pool' import (Kevin)
> - patch 2: rename _notrun_on_no_fuse to _notrun_on_fuse_error (Kevin)
> - patch 3: replace the dropped assertion with a check that bitmap0's
>   content on the destination has not reached its final value right
>   after RESUME, throttling migration bandwidth

Thanks, applied to the block branch.

Kevin


