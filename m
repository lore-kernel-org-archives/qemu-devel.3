Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95985606A325
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 14:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QTGmxi/9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMQlh-0006Nq-2J; Thu, 29 Oct 2026 10:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xMQkw-0006Ae-Ds
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 10:05:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xMQks-0004Tu-R7
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 10:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793282721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pK6fuRCqdB50ZFhhS/b+kGUOervOMAkzJNGtFn1mCM0=;
 b=QTGmxi/9SiG9EPAlZIw3paz1UT5o+0NDxs4lixbM6fXVNITOQTK6ggITyLjJ7WTHBFT6Ly
 TOmqzA12IFiwd4vFk4xKEaGVT/UwZ7TTxxpoeXkxCqBsigsV+xk9FAZwWPdEbyHilOLj8I
 6JKGd2ks97RD7HPirKAHv5fcCBQXOOo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-uKeRIm-tPbOW4bsd3GYo0g-1; Thu,
 29 Oct 2026 10:05:17 -0400
X-MC-Unique: uKeRIm-tPbOW4bsd3GYo0g-1
X-Mimecast-MFC-AGG-ID: uKeRIm-tPbOW4bsd3GYo0g_1793282716
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F8A4195423C; Thu, 29 Oct 2026 14:05:16 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4EC7D18001CA; Thu, 29 Oct 2026 14:05:15 +0000 (UTC)
Date: Thu, 29 Oct 2026 10:05:14 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, mst@redhat.com,
 devel@lists.libvirt.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 0/5] virtio-blk: Deprecate silent truncation of serial
Message-ID: <20261029140514.GJ1506267@shajnocz.csb>
References: <20261028232400.222535-1-kwolf@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028232400.222535-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Oct 29, 2026 at 12:23:55AM +0100, Kevin Wolf wrote:
> QEMU has allowed the user to specify serials of arbitrary length for
> virtio-blk devices, even though the virtio-blk protocol can only
> communicate 20 characters of the serial to the guest. This means that a
> longer serial number on the command line is silently truncated to 20
> characters from the guest perspective.
> 
> As a first step to fix this, deprecate the silent truncation and turn it
> into a warning; we can later make this a hard error. While touching
> GET_ID, let's make it more spec compliant and clean up the internal
> state.
> 
> Another part is planned that will actually enable users to use longer
> serials and additional device identifiers. This will need spec changes
> and would take more time than we have until the QEMU 11.2 freeze anyway,
> so I'll address this later. For now, the important thing is to get the
> deprecation period started.
> 
> Kevin Wolf (5):
>   virtio-blk: Implement full NUL padding for GET_ID
>   virtio-blk-test: Add a basic GET_ID test case
>   virtio-blk: Deprecate silent truncation of serial
>   virtio-blk: Represent truncated serial in qdev property
>   virtio-blk-test: Test truncated serial
> 
>  docs/about/deprecated.rst     | 13 +++++
>  hw/block/virtio-blk.c         | 24 +++++++--
>  tests/qtest/virtio-blk-test.c | 92 +++++++++++++++++++++++++++++++++++
>  3 files changed, 125 insertions(+), 4 deletions(-)

Aside from the comments I've sent:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>


