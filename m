Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 137A5C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 10:42:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we9Rb-0004HB-5O; Mon, 29 Jun 2026 06:42:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1we9RZ-0004Gj-Ug
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 06:42:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1we9RY-0003uq-Dz
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 06:42:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782729742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QM2xB1nomDlL4ukHeL7bSN6O5PKqyuJ52BNzBDdmL9I=;
 b=dk3hGLiQE/16L+5jglCqFN+2fMGxIXvcxaDgGaP4m28cHB6YWO/5d0PO4+a0SWF0iQwUoX
 MHTLIF8mP6fXdApDH36jxnosWt0g5Z0UlNqvudaoQrdKb0/K0kRbNS9mLGsblbX+FDO6kv
 hH5urwRdu9GPkR0oWEAA/9qCwx0GkBg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-144-jrwQoKvrNhK8RMGgLZpVzQ-1; Mon,
 29 Jun 2026 06:42:19 -0400
X-MC-Unique: jrwQoKvrNhK8RMGgLZpVzQ-1
X-Mimecast-MFC-AGG-ID: jrwQoKvrNhK8RMGgLZpVzQ_1782729738
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 593F218052D4; Mon, 29 Jun 2026 10:42:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D9C73653A; Mon, 29 Jun 2026 10:42:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 035EC21E6920; Mon, 29 Jun 2026 12:42:14 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  "Dr . David Alan Gilbert"
 <dave@treblig.org>,  Eric Blake <eblake@redhat.com>,  "Michael S .
 Tsirkin" <mst@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  Jason Wang
 <jasowang@redhat.com>,  Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH V9 02/17] iothread: introduce iothread_ref/unref to
 track attached devices
In-Reply-To: <CAK3tnv+YGdTPOgGSwz-KO22E_-UaaABmEKwTqrsuE7no91pXEQ@mail.gmail.com>
 (Zhang Chen's message of "Mon, 29 Jun 2026 14:58:35 +0800")
References: <20260624070851.13342-1-zhangckid@gmail.com>
 <20260624070851.13342-3-zhangckid@gmail.com>
 <87o6gx1yg4.fsf@pond.sub.org>
 <CAK3tnv+YGdTPOgGSwz-KO22E_-UaaABmEKwTqrsuE7no91pXEQ@mail.gmail.com>
Date: Mon, 29 Jun 2026 12:42:13 +0200
Message-ID: <877bnhvda2.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> On Fri, Jun 26, 2026 at 4:46=E2=80=AFPM Markus Armbruster <armbru@redhat.=
com> wrote:
>>
>> Looks like you missed my review of v8.  I'm replaying my review
>> comments.
>
> Oh, my fault, very sorry about that, focused on other patch's comments fi=
xes.

Happens :)

> Thank you for your detailed explanation.
>
> I will address your comments in next version.
> Expect the:
>   IOThreadHolder *h =3D QAPI_CLONE(IOThreadHolder, holder);
>
> Same as your estimate, this doesn't seem worthwhile.

Replacing hand-written code by QAPI_CLONE() is worth a try.

I additionally described how to avoid the copy entirely instead, but
advised against it.

> And the same issue in the [ PATCH V8 14/15] comments:
> static IOThreadHolderList *iothread_get_holders_list(IOThread *iothread)
>
>> If iothread->holders was a IOThreadHolderList instead of a GList, this
>> loop could be QAPI_CLONE(IOThreadHolderList, iothread->holders) instead.
>
> If we change the GList *holders to the IOThreadHolderList *holders,
> This means that we have to reimplement the  GList related API,
> for example the "g_list_prepend", "g_list_find_custom" and the
> "g_list_delete_link"
>
> This doesn't seem worthwhile.

The replacement for g_list_prepend() would be trivial:

    h->next =3D iothread->holders;
    iothread->holders =3D h;

iothread_unref() would turn into simple loop to find and delete the
matching list element.  iothread_get_holders_list()'s similarly simple
loop around QAPI_CLONE() would turn into a single QAPI_CLONE().
Basically the same amount of code, I think.

Your solution already exists, which is a valid argument.

Mine stays within QAPI instead of mixing GList and QAPI.  Also a valid
argument.

Use your judgement.  I'd try to avoid the mixing.


