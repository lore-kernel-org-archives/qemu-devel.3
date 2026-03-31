Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F037109B468
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 13:22:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Z2w-00041D-Ht; Tue, 31 Mar 2026 09:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w7Z2u-0003z2-SR
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 09:22:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w7Z2s-000582-IU
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 09:22:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774963332;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nt8j4iyH58d07zpTysGpv5CGwonr20qNERs9/4v61Ms=;
 b=WDEAjPpJKD1Ctu7ni3e5EHiXGcHmyAyHvbHCkZIIHgXl3wj2jkznCEg2Fn+l9I5zJc2OFB
 XkLtn+tL5cbsH4lhB1zO4vkfnciPwnvjS1/2R+OsspCz+tluCpu2LOtOjOvthfXnQQyju/
 CLMDLpFrxRDAM9pN+zdzCM56bbccD1Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-190-LebkDRATNWy8eN-8QpcP3A-1; Tue,
 31 Mar 2026 09:22:11 -0400
X-MC-Unique: LebkDRATNWy8eN-8QpcP3A-1
X-Mimecast-MFC-AGG-ID: LebkDRATNWy8eN-8QpcP3A_1774963330
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0E1AC1955EA1; Tue, 31 Mar 2026 13:22:10 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.79])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 54C4D30001A2; Tue, 31 Mar 2026 13:22:08 +0000 (UTC)
Date: Tue, 31 Mar 2026 14:22:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Tejus GK <tejus.gk@nutanix.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v3 1/1] io: invert the return semantics of
 qio_channel_flush
Message-ID: <acvKfOK5tq99FwHI@redhat.com>
References: <20260320083950.262119-1-tejus.gk@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260320083950.262119-1-tejus.gk@nutanix.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Mar 20, 2026 at 08:39:41AM +0000, Tejus GK wrote:
> With the kernel's zerocopy notification mechanism, the caller can
> determine whether
>  * All syscalls successfully used zero copy
>  * At least one syscall failed to use zero copy
> 
> But, as of now QEMU's IO channel flush function semantics are like
>  * 1 => all syscalls failed to use zero copy
>  * 0 => at least one syscall successfully used zero copy
> 
> This is not aligned with what the kernel reports, and ends up reporting
> false negatives for cases like when there's just a single successful
> zerocopy amongst a collection of deferred zero-copies during a flush.
> 
> Fix this by inverting the return semantics of the IO flush function.
> 
> Suggested-by: Peter Xu <peterx@redhat.com>
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Tejus GK <tejus.gk@nutanix.com>
> ---
>  include/io/channel-socket.h |  6 +-----
>  include/io/channel.h        |  4 ++--
>  io/channel-socket.c         | 16 ++++++++--------
>  3 files changed, 11 insertions(+), 15 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


