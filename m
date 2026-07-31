Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 126C3C55167
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 07:24:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wphau-0002An-Vf; Fri, 31 Jul 2026 03:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wphar-0002AS-Tx
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 03:23:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wphaq-0007Xs-Fm
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 03:23:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785482622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DFy5V3bT60WjqeV+MUGnBKA+v/q9X4Vi4mMPKW1zccA=;
 b=BfxN5Bv7/Rd8fJJqkG/bOJUOmTMGCklkAeQb2ix9h8XzV7Nn7LzrYDIYEfhLS1IkjWMYq7
 7XY8vuVFCAihTEa+K59qtppCt7L1/TUKBocYLk5uZRgGSVng2SEmLSZAgZLFuQhvVWkD5J
 wPYRwvhNk4KevgNcCjGFzqa3JASt7J4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-44--REUL4s6PiaU1fVkaik3TA-1; Fri,
 31 Jul 2026 03:23:39 -0400
X-MC-Unique: -REUL4s6PiaU1fVkaik3TA-1
X-Mimecast-MFC-AGG-ID: -REUL4s6PiaU1fVkaik3TA_1785482618
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD6FA180036E; Fri, 31 Jul 2026 07:23:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 66089180044F; Fri, 31 Jul 2026 07:23:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D6AF421E6920; Fri, 31 Jul 2026 09:23:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  "Dr . David Alan Gilbert"
 <dave@treblig.org>,  Eric Blake <eblake@redhat.com>,  "Michael S .
 Tsirkin" <mst@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  Jason Wang
 <jasowang@redhat.com>,  Fam Zheng <fam@euphon.net>,  Daniel P .
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [RESEND PATCH V10 06/15] monitor: Update tracking iothread
 users with holder
In-Reply-To: <CAK3tnv+UMEsZTR12iY74sD42m5nNhYEtyF58QxVoG-JAeUZHcw@mail.gmail.com>
 (Zhang Chen's message of "Fri, 31 Jul 2026 10:42:29 +0800")
References: <20260716172108.87700-1-zhangckid@gmail.com>
 <20260716172108.87700-7-zhangckid@gmail.com>
 <87a4rkplof.fsf@pond.sub.org>
 <CAK3tnv+UMEsZTR12iY74sD42m5nNhYEtyF58QxVoG-JAeUZHcw@mail.gmail.com>
Date: Fri, 31 Jul 2026 09:23:34 +0200
Message-ID: <87cxw3aah5.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> On Tue, Jul 21, 2026 at 8:33=E2=80=AFPM Markus Armbruster <armbru@redhat.=
com> wrote:
>>
>> Zhang Chen <zhangckid@gmail.com> writes:
>>
>> > Based on monitor QOM path tracking iothread users with holder.
>> > Introduce the AioContext in the Monitor struct to avoid repeated calls=
 to
>> > iothread_get_aio_context() and ensure symmetrical ref/unref during
>> > monitor lifecycle.
>> >
>> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
>>
>> Why are repeated calls bad?
>>
>> How would symmetry be lost?
>>
>
> OK, will add detailed comments like this in the next version:
>
> Avoid repeated calls: Under the holder tracking model, fetching the
> AioContext increments the IOThread refcount and registers holder metadata.
> Dynamically querying it in helper functions (e.g., suspend, BH scheduling)
> leads to redundant refcount churn.

Right here, we still have

    AioContext *iothread_get_aio_context(IOThread *iothread)
    {
        return iothread->ctx;
    }

and complicating code to avoid additional calls feels dubious.

PATCH 14 changes it to

    AioContext *iothread_get_aio_context(IOThread *iothread,
                                         const IOThreadHolder *holder)
    {
        /* Add IOThreadHolder to the list */
        iothread_ref(iothread, holder);

        return iothread->ctx;
     }

Are you making this change in preparation of PATCH 14?

> Ensure lifecycle symmetry: Storing AioContext in mon->ctx establishes a
> strict 1-to-1 lifecycle pairing: a single iothread_ref_and_get_aio_contex=
t()
> in monitor_complete() matched by a single iothread_put_aio_context()
> in monitor_cleanup().
>
> Thanks
> Chen


