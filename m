Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC32C54F54
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 07:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wphu6-0006xP-Sb; Fri, 31 Jul 2026 03:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wphtz-0006wS-Jt
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 03:43:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wphtw-0002Xe-LG
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 03:43:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785483807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ny/XuU+oq4Ui7c9bZfxjiMt6MKpjLiuIYuScXvyDwa0=;
 b=RDy+y0feXIZvJ7cHC+dJIJtN1vBVuCQYQXuOAAmlQ1iRHYF/Lg//Q/3MlSZICHatw6ek2w
 SmsvI3cjman4BuGFSs20rSsDnzvAGzn4iNquffjyKD04VHBt2XmarvEJr2G8GN6G/DBrzo
 oHgB9oGull5xxK313hcJtkRg3MNLizE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-278-bJHephDiMryeb5BipKDHQw-1; Fri,
 31 Jul 2026 03:43:25 -0400
X-MC-Unique: bJHephDiMryeb5BipKDHQw-1
X-Mimecast-MFC-AGG-ID: bJHephDiMryeb5BipKDHQw_1785483804
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1DAAD1956088; Fri, 31 Jul 2026 07:43:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 21D8D19560AB; Fri, 31 Jul 2026 07:43:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 63DB421E6920; Fri, 31 Jul 2026 09:43:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  "Dr . David Alan Gilbert"
 <dave@treblig.org>,  Eric Blake <eblake@redhat.com>,  "Michael S .
 Tsirkin" <mst@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  Jason Wang
 <jasowang@redhat.com>,  Fam Zheng <fam@euphon.net>,  Daniel P .
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [RESEND PATCH V10 14/15] iothread: simplify API by merging
 iothread_get_aio_context variants
In-Reply-To: <20260716172108.87700-15-zhangckid@gmail.com> (Zhang Chen's
 message of "Fri, 17 Jul 2026 01:20:55 +0800")
References: <20260716172108.87700-1-zhangckid@gmail.com>
 <20260716172108.87700-15-zhangckid@gmail.com>
Date: Fri, 31 Jul 2026 09:43:20 +0200
Message-ID: <877bmba9k7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Zhang Chen <zhangckid@gmail.com> writes:

> Simplify the interface by merging iothread_ref_and_get_aio_context()
> into iothread_get_aio_context(). The updated function now requires a
> 'holder' parameter, ensuring that every retrieval of an AioContext for
> long-term use is automatically registered in the IOThread's holder list.
>
> Update all callers across block, virtio, scsi, net, and monitor
> subsystems to match the new signature. This cleanup reduces code
> redundancy and improves the reliability of IOThread introspection.
>
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>

[...]

> diff --git a/include/system/iothread.h b/include/system/iothread.h
> index 3cce5eeb09..3a6010b9f0 100644
> --- a/include/system/iothread.h
> +++ b/include/system/iothread.h
> @@ -73,22 +73,22 @@ DECLARE_INSTANCE_CHECKER(IOThread, IOTHREAD,
>  
>  char *iothread_get_id(IOThread *iothread);
>  IOThread *iothread_by_id(const char *id);
> -/*
> - * The iothread_get_aio_context() and iothread_put_aio_context() are not
> - * thread-safe and must be called under the Big QEMU Lock (BQL).
> - */
> -AioContext *iothread_get_aio_context(IOThread *iothread);
> +
>  /*
>   * Normally the IOThread's AioContext is fetched using
> - * iothread_ref_and_get_aio_context(), but there are legacy callers
> + * iothread_get_aio_context(), but there are legacy callers
>   * without a clear ref/unref lifecycle. They cannot unref (e.g. because
>   * they do not have an IOThread pointer), so provide an unsafe way to
>   * fetch the AioContext without holding a reference count. This unsafe
>   * API serves legacy callers - do not use it in new code.
>   */
>  AioContext *iothread_unsafe_get_aio_context(IOThread *iothread);
> -AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
> -                                             const IOThreadHolder *holder);
> +/*
> + * The iothread_get_aio_context() and iothread_put_aio_context() are not
> + * thread-safe and must be called under the Big QEMU Lock (BQL).
> + */
> +AioContext *iothread_get_aio_context(IOThread *iothread,
> +                                     const IOThreadHolder *holder);
>  void iothread_put_aio_context(IOThread *iothread, const IOThreadHolder *holder);
>  GMainContext *iothread_get_g_main_context(IOThread *iothread);
>  
> diff --git a/iothread.c b/iothread.c
> index 157bb4d302..9d278efc45 100644
> --- a/iothread.c
> +++ b/iothread.c
> @@ -429,13 +429,8 @@ char *iothread_get_id(IOThread *iothread)
>      return g_strdup(object_get_canonical_path_component(OBJECT(iothread)));
>  }
>  
> -AioContext *iothread_get_aio_context(IOThread *iothread)
> -{
> -    return iothread->ctx;
> -}
> -
> -AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
> -                                             const IOThreadHolder *holder)
> +AioContext *iothread_get_aio_context(IOThread *iothread,
> +                                     const IOThreadHolder *holder)
>  {
>      /* Add IOThreadHolder to the list */
>      iothread_ref(iothread, holder);

Together with PATCH 04, this renames iothread_get_aio_context() to
iothread_unsafe_get_aio_context(), and
iothread_ref_and_get_aio_context() to iothread_get_aio_context().

iothread_get_aio_context() takes a reference now.  That's a very
significant change.

In my opinion, every function that takes or releases a reference needs a
function comment unless the function name makes it completely obvious.
I know we have plenty of functions lacking such comments, but that
doesn't make me wrong :)

There are similarly named functions that, as far as I can tell, return a
thing's AioContext without taking a reference:

    bdrv_get_aio_context()
    blk_get_aio_context()
    block_job_get_aio_context()
    iohandler_get_aio_context()
    qemu_coroutine_get_aio_context()
    qemu_get_aio_context()

I fear this is going to be confusing.

But I'm not the maintainer.  Who is the maintainer?  MAINTAINERS doesn't
cover iothread.c, even though it is a core piece of infrastructure.

[...]


