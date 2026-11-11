Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC21606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 12:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aWem43lq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR7sx-0006Aj-23; Wed, 11 Nov 2026 07:57:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xR7sk-000694-FF
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 07:56:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xR7si-0005zG-2u
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 07:56:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794401811;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bgZhdF1UUSYs3uzK8Tg/4WEtbIaKey6WShFICaMRkzg=;
 b=aWem43lqwEeJrVD5qa//oaUfWOYcyR+fODR/SSLeYWxmB55G/f0h0u/65EWHlF2sW8PO3u
 Cdy3C8Zg0bKN+qnMKn3QCCrrch/oWDYZ5Y2qMI2raQ7v7Da5cxKqa/u+S0TW5cfwp8lYEx
 0ALShHGqmAn/FJiOmTirjmhfdn7+ncI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15-wpbx1KIvPbawQiNGLHmD0w-1; Wed,
 11 Nov 2026 07:56:48 -0500
X-MC-Unique: wpbx1KIvPbawQiNGLHmD0w-1
X-Mimecast-MFC-AGG-ID: wpbx1KIvPbawQiNGLHmD0w_1794401807
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 05C3A1800372; Wed, 11 Nov 2026 12:56:47 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BECFA1800347; Wed, 11 Nov 2026 12:56:45 +0000 (UTC)
Date: Wed, 11 Nov 2026 12:56:43 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, david@kernel.org, imammedo@redhat.com,
 peter.maydell@linaro.org
Subject: Re: [PATCH 7/7] backends/hostmem-memfd: Add huge TLB properties
 unconditionally
Message-ID: <avRmC6aBecul9e6B@redhat.com>
References: <20261111122342.634370-1-armbru@redhat.com>
 <20261111122342.634370-8-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261111122342.634370-8-armbru@redhat.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11, 2026 at 01:23:42PM +0100, Markus Armbruster wrote:
> We add class properties "hugetlb" and "hugetlbsize" only when a test
> of memfd_create() succeeds.  Such conditional registration is unusual
> and can be problematic:
> 
> 1. Management applications use introspection interfaces to find out
> what a certain QEMU can do.  Conditional property addition makes QOM
> introspection results depend on the condition, which generally makes
> them valid only for the process that produced them.  Undesirable.
> 
> 2. For user-creatable objects like "memory-backend-memfd", it also
> makes QAPI introspection unreliable: query-qmp-schema claims the
> properties exist (object-add takes arguments @hugetlb and @hugetlbsize
> when argument @qom-type is "memory-backend-memfd") even when it
> doesn't.
> 
> Conditional registration actually serves no purpose here, because we
> still have to memfd_create() for real when we create the object, and
> need and do handle errors then.
> 
> Moreover, we actually KVM ioctl KVM_CREATE_GUEST_MEMFD instead of
> memfd_create() there when @guest-memfd is on.  If the memfd_create()
> check can fail when the ioctl could still succeed, the condition is
> counter-productive.
> 
> Add the properties unconditionally.
> 
> To test, I hacked the qemu_memfd() call to fail.  The error for
> -object memory-backend-memfd,id=mem0,size=1m,hugetlb=off,hugetlbsize=512,seal=on
> changes from
> 
>     qemu-system-x86_64: Property 'memory-backend-memfd.hugetlbsize' not found
> 
> to
> 
>     qemu-system-x86_64: can't create 'memory-backend-memfd': failed to create memfd with sealing and without huge pages: Invalid argument
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  backends/hostmem-memfd.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


