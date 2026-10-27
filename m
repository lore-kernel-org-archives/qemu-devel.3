Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78827606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 20:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dOhPm3Vl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLnWu-0003US-4e; Tue, 27 Oct 2026 16:12:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xLnWe-0003RX-Rg
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 16:12:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xLnWc-00070Y-G9
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 16:12:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793131920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D5rFIuvuQHgfs/29uj/2Up6Ig5WJWsJUy3EtQVM7CiY=;
 b=dOhPm3VlAYb6vuh9Zz61LSBeiidneA+v5KCnc89h1np3+lNlWvERXInNSYpebBfrn5XKrH
 BDg2fZ916wuKg+l76FQbwo+hBSerT74tZYL7DkWHWPUKTqsBnDTy6Sb7umbRndY5N35CGN
 xoo854J4zA7iAZqJA5WWSyvrBUX2S4Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-KuQnhUK0MO20NuUty8XYEw-1; Tue,
 27 Oct 2026 16:11:57 -0400
X-MC-Unique: KuQnhUK0MO20NuUty8XYEw-1
X-Mimecast-MFC-AGG-ID: KuQnhUK0MO20NuUty8XYEw_1793131916
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D61219560A3; Tue, 27 Oct 2026 20:11:56 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A284718005B6; Tue, 27 Oct 2026 20:11:55 +0000 (UTC)
Date: Tue, 27 Oct 2026 16:11:54 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Subject: Re: [PATCH V18 00/13] iothread: Support tracking and querying
 IOThread holder
Message-ID: <20261027201154.GE933537@shajnocz.csb>
References: <20260929084416.1600199-1-zhangckid@gmail.com>
 <20261022201643.GG20810@shajnocz.csb>
 <CAK3tnvJRKw8XSG9aWusCouo=Z=wBs8w+4DT4a774eej9tkNQBw@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK3tnvJRKw8XSG9aWusCouo=Z=wBs8w+4DT4a774eej9tkNQBw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 23, 2026 at 05:42:48PM +0800, Zhang Chen wrote:
> On Fri, Oct 23, 2026 at 4:16 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
> >
> > Please update docs/devel/multiple-iothreads.rst. It still refers to
> > iothread_get_aio_context() instead of the new API.
> >
> 
> Hi Stefan,
> 
> Thanks for pointing this out. Would it be okay to include the documentation
> update as a separate patch in the next revision like this?
> 
> diff --git a/docs/devel/multiple-iothreads.rst
> b/docs/devel/multiple-iothreads.rst
> index a6eb046267..c184222d71 100644
> --- a/docs/devel/multiple-iothreads.rst
> +++ b/docs/devel/multiple-iothreads.rst
> @@ -88,11 +88,20 @@ argument, which is used to check for and prevent
> re-entrancy problems. For
>  BHs associated with devices, the reentrancy-guard is contained in the
>  corresponding ``DeviceState`` and named ``mem_reentrancy_guard``.
> 
> -The ``AioContext`` can be obtained from the ``IOThread`` using
> -``iothread_get_aio_context()`` or for the main loop using
> -``qemu_get_aio_context()``. Code that takes an ``AioContext`` argument
> -works both in ``IOThread``\ s or the main loop, depending on which
> ``AioContext``
> -instance the caller passes in.
> +The ``AioContext`` can be obtained from an ``IOThread`` using
> +``iothread_ref_and_get_aio_context(iothread, holder)``, or from the main loop
> +using ``qemu_get_aio_context()``. Code accepting an ``AioContext`` works with
> +either event loop.
> +
> +The holder-aware get registers a holder and takes an IOThread reference.

I suggest ``iothread_ref_and_get_aio_context()`` instead of "The
holder-aware get" so it's clear which API you are referring to.

> +After the caller has finished using the context, release the reference with
> +``iothread_unref_and_put_aio_context()``, passing the same IOThread and an
> +equivalent holder. Both calls require the BQL. No matching IOThread put is
> +needed for the main loop's context.
> +
> +``iothread_unsafe_get_aio_context()`` neither registers a holder nor takes a
> +reference. It is for legacy callers that ensure the IOThread's lifetime
> +themselves; new code must use the holder-aware API.

Yes, this looks good. Thanks!

> 
>  How to synchronize with an ``IOThread``
>  ---------------------------------------
> 
> 
> When you have a chance, I'd also appreciate your review of the remaining
> patches that don't yet have Reviewed-by tags.

I will take a look!

Stefan


