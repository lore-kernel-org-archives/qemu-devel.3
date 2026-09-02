Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E3DDC61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 10:46:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1iU5-0002cK-Og; Wed, 02 Sep 2026 06:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x1iTy-0002bx-Tx
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 06:46:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x1iTx-00080i-8d
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 06:46:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788345975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZEm0ywbGY0izqvpgHoikcnVa8k0pkN7JJEhGu9ToqNA=;
 b=Y+vE/lTUBSA+DGz0NaMntCVc6NXhqHbw1KVjtjHF33Jh3SWvg4DK7OQP3NLxlwlkhbQrvO
 g34y90X7++75M+HtxveQvWHQRrA0hNJUh9SnavbBIlq79tu4JGVkRUtArEuwy85yz1OgN7
 DbJmetdwRSZ5msK5SzVf2CN9vnEza68=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-63-LJtYVbTWOVOHINAFm5Gzew-1; Wed,
 02 Sept 2026 06:46:14 -0400
X-MC-Unique: LJtYVbTWOVOHINAFm5Gzew-1
X-Mimecast-MFC-AGG-ID: LJtYVbTWOVOHINAFm5Gzew_1788345973
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 68DB5192E250; Wed,  2 Sep 2026 10:46:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0E76B7DD; Wed,  2 Sep 2026 10:46:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9DA1521E682E; Wed, 02 Sep 2026 12:46:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Eric Blake <eblake@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P .
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Jason Wang
 <jasowangio@gmail.com>
Subject: Re: [PATCH V14 04/15] iothread: introduce
 iothread_unsafe_get_aio_context()
In-Reply-To: <CAK3tnvKE14GhTcmQ5UPgQSCAvJhR8e=_F=ehukd4Mv9wXFuzrQ@mail.gmail.com>
 (Zhang Chen's message of "Tue, 1 Sep 2026 22:39:42 +0800")
References: <20260831160038.221776-1-zhangckid@gmail.com>
 <20260831160038.221776-5-zhangckid@gmail.com>
 <87bjahbksk.fsf@pond.sub.org>
 <CAK3tnvKE14GhTcmQ5UPgQSCAvJhR8e=_F=ehukd4Mv9wXFuzrQ@mail.gmail.com>
Date: Wed, 02 Sep 2026 12:46:10 +0200
Message-ID: <87a4q03p8t.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Zhang Chen <zhangckid@gmail.com> writes:

> On Tue, Sep 1, 2026 at 1:30=E2=80=AFPM Markus Armbruster <armbru@redhat.c=
om> wrote:
>>
>> Zhang Chen <zhangckid@gmail.com> writes:
>>
>> > Add an explicitly unsafe accessor for legacy callers that cannot
>> > provide a matching holder lifecycle, and convert blockdev.c to use it.
>>
>> Why is blockdev.c unable to "provide a matching holder lifecycle"?
>
> x-blockdev-set-iothread only retains the AioContext in the block graph.
> It does not retain the corresponding IOThread, and the eventual context
> detach or block-node destruction happens outside this command. Therefore
> there is no point in this call site where a matching put can be issued.
> Supporting that properly would require adding IOThread ownership to the
> block graph context lifecycle (and likely a block-node holder kind).
>
> The unsafe accessor only makes the command's existing lifetime assumption
> explicit; it does not make that lifetime safe. I will reword the commit
> message accordingly in the new version of the patch 14.

Yes, please.

Would a comment next to the call could be useful?  I can't tell, but you
might.

>> > Keep iothread_get_aio_context() temporarily so that later caller
>> > conversions remain independently buildable. It will be removed after
>> > all production callers have migrated.
>>
>> Which callers aren't "production callers"?
>
> I meant the standalone IOThread implementation to the patch 14.

Suggest to drop "production".  Possibly moot, since you squash this
patch into PATCH 14.

>
> Thanks
> Chen
>
>>
>> > New code should use iothread_ref_and_get_aio_context().
>> >
>> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
>>


