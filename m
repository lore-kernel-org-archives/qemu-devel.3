Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C1DAC61DB6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 08:17:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wymLD-0000Js-8b; Tue, 25 Aug 2026 04:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wymLB-0000Jd-LQ
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 04:17:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wymLA-0002F9-1b
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 04:17:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787645820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YLxEHNEb8QwCgk/DLTCRXq7gC4OckZkBoij29RBa9bU=;
 b=W1aaSqByCZlJYgJnB4sJGDT0KrdgYJvrkTIKjYzWTZixpMJGPEqJ7Oj2nde+mp0oH2HFSU
 iJC9uc4kmtASM+ZZJmtJYDjw9Me162oQMnLj3B60lO+Ph0PDrQNGKAnVa+GDgKViExUQUA
 rr89zFN6oBrB/lAcAUveaioHYj6BeXY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-35-tnoNNsTDO_mMbS3u1eLl6w-1; Tue,
 25 Aug 2026 04:16:57 -0400
X-MC-Unique: tnoNNsTDO_mMbS3u1eLl6w-1
X-Mimecast-MFC-AGG-ID: tnoNNsTDO_mMbS3u1eLl6w_1787645816
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 64C65186A6E1; Tue, 25 Aug 2026 08:16:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.12])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD652195604A; Tue, 25 Aug 2026 08:16:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5293921E6920; Tue, 25 Aug 2026 10:16:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Eric Blake <eblake@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  'Daniel P .
 =?utf-8?Q?Berrang=C3=A9'?= <berrange@redhat.com>,  Jason Wang
 <jasowangio@gmail.com>
Subject: Re: [PATCH V13 02/15] iothread: introduce holder tracking
In-Reply-To: <20260822213343.661939-3-zhangckid@gmail.com> (Zhang Chen's
 message of "Sun, 23 Aug 2026 05:33:25 +0800")
References: <20260822213343.661939-1-zhangckid@gmail.com>
 <20260822213343.661939-3-zhangckid@gmail.com>
Date: Tue, 25 Aug 2026 10:16:53 +0200
Message-ID: <874igipqbu.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Zhang Chen <zhangckid@gmail.com> writes:

> IOThreads do not record the QOM objects and block exports that use
> them, making runtime introspection and hotplug debugging difficult.
>
> Add:
>
> - holders: a list describing what is holding an iothread
> - iothread_ref(): add a holder to the list
> - iothread_unref(): remove a holder from the list
>
> A holder can identify either a QOM object or a block export. A later
> patch will expose this information through query-iothreads.
>
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

I'm suspending my R-by, see below why.

[...]

> diff --git a/iothread.c b/iothread.c
> index 3558535b40..66dfde626e 100644
> --- a/iothread.c
> +++ b/iothread.c
> @@ -21,10 +21,71 @@
>  #include "system/iothread.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-commands-misc.h"
> +#include "qapi/clone-visitor.h"
> +#include "qapi/qapi-visit-misc.h"
>  #include "qemu/error-report.h"
>  #include "qemu/rcu.h"
>  #include "qemu/main-loop.h"
>  
> +/* Add a deep copy of @holder to @iothread's list of holders. */
> +void iothread_ref(IOThread *iothread, const IOThreadHolder *holder)
> +{
> +    assert(holder);
> +
> +    QAPI_LIST_PREPEND(iothread->holders, QAPI_CLONE(IOThreadHolder, holder));
> +}
> +
> +static int iothread_holder_compare(const IOThreadHolder *holder_a,
> +                                   const IOThreadHolder *holder_b)
> +{
> +    const char *name_a, *name_b;
> +
> +    if (holder_a->type != holder_b->type) {
> +        return holder_a->type - holder_b->type;

Why did you swap the operands in v13?  Not mentioned in the cover
letter's change log.  I requested the other order in review of v8[*] and
v9, and you complied in v10.  Unless you have a compelling reason, swap
them right back, please.

In general, rocking the boat like this when you're at v13 is
inadvisable.  It risks delaying the series even more and annoying
reviewers.

> +    }
> +
> +    switch (holder_a->type) {
> +    case IO_THREAD_HOLDER_KIND_QOM_OBJECT:
> +        name_a = holder_a->u.qom_object.qom_path;
> +        name_b = holder_b->u.qom_object.qom_path;
> +        break;
> +    case IO_THREAD_HOLDER_KIND_BLOCK_EXPORT:
> +        name_a = holder_a->u.block_export.export_id;
> +        name_b = holder_b->u.block_export.export_id;
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    return strcmp(name_a, name_b);
> +}

[...]

[*] Here's my review of v8:

    Date: Tue, 02 Jun 2026 13:29:19 +0200
    Message-ID: <87tsrl2nao.fsf@pond.sub.org>
    https://lore.kernel.org/qemu-devel/87tsrl2nao.fsf@pond.sub.org


