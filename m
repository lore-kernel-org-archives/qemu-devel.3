Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC2B8C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:06:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wojNz-0002k0-K7; Tue, 28 Jul 2026 11:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wojNb-0002eu-Dy
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:06:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wojNZ-0005Cj-Lk
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:06:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785251160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CEa1UaYTqKsR3ZI22DUHmtrNqVkGp0so/PMo85//CCE=;
 b=VQBz4kiBWUGDIaB/euAF2550GkFbbohVBnYuhxFMyEP6nt+hS0YLzokSzWkh5aTFU//F/5
 PRi4NKoCA0nyfx1X9IJ8IUC+5yGEH/MNDtS/5XndDXoD0IILZ5Xj1888J6YiY0JQvB+yVK
 svuoUzNWyeh/7lIoA0q0clpa5EvqBsM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611--seB-44hMEO3u0IR57CPug-1; Tue,
 28 Jul 2026 11:05:57 -0400
X-MC-Unique: -seB-44hMEO3u0IR57CPug-1
X-Mimecast-MFC-AGG-ID: -seB-44hMEO3u0IR57CPug_1785251156
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D8F4180057E; Tue, 28 Jul 2026 15:05:54 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.201])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9DDDD18004AD; Tue, 28 Jul 2026 15:05:52 +0000 (UTC)
Date: Tue, 28 Jul 2026 17:05:50 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Farman <farman@linux.ibm.com>
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH v1 0/3] io_tests fuse fixes
Message-ID: <amjFTkbGZX-1d42k@redhat.com>
References: <20260725125651.3896151-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260725125651.3896151-1-farman@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 25.07.2026 um 14:56 hat Eric Farman geschrieben:
> Hi,
> 
> The following are three small fixes against some of the qemu iotests
> to avoid some errors that should prevent the tests from running in
> the first place. We noticed these on an s390 host, but I don't
> believe that to be relevant. My hunch is the messages are slightly
> different based on distro, because the tests (correctly) skip for
> me running Fedora on s390 or x86_64 while they fail under Ubuntu 26.04.

This series conflicts with a patch from Denis Lunev I already queued:

[PATCH v2 2/3] iotests: skip FUSE tests when FUSE is not usable
https://patchew.org/QEMU/20260715103451.1930909-1-den@openvz.org/20260715103451.1930909-3-den@openvz.org/

Can you please check if this already solves some of your problems and
rebase the rest of your series on top of it?

Kevin


