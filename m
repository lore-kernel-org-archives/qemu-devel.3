Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D7F8C61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 11:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1j6C-0001e9-3R; Wed, 02 Sep 2026 07:25:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x1j67-0001cY-SQ
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 07:25:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x1j65-0003yO-F3
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 07:25:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788348339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RAWmXweH7pk+4A8wy/C2lo/Eq14iU/5evBrN/SFKEPc=;
 b=Bu29AUxSHOBa4YtpN4ip+dC0fgDmzeBa4nT6wTTchtNLVCPgJBV62/4Gkw6sv2M4tVdBJ8
 NooVeT5DIfrdptj19/DHmf8Cq4a+FMGhLkr2aKNvYIrcDdEFJR548wCsT2neWK+Lsn+DZa
 fWgKrZYQCTvxnTK3sNhTJG2PePRK2Bk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-3RALgp5xNoWzrRN_zh_lYA-1; Wed,
 02 Sept 2026 07:25:37 -0400
X-MC-Unique: 3RALgp5xNoWzrRN_zh_lYA-1
X-Mimecast-MFC-AGG-ID: 3RALgp5xNoWzrRN_zh_lYA_1788348336
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6A6EB1977037; Wed,  2 Sep 2026 11:25:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0EF801800577; Wed,  2 Sep 2026 11:25:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 948C121E682B; Wed, 02 Sep 2026 13:25:33 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Eric Blake <eblake@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P .
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Jason Wang
 <jasowangio@gmail.com>
Subject: Re: [PATCH V14 06/15] monitor: track IOThread users with QOM paths
In-Reply-To: <CAK3tnvLbaJ4b+gRhXC678cye-cHv+aP3FFwRvhPNjyfSHxL6MA@mail.gmail.com>
 (Zhang Chen's message of "Tue, 1 Sep 2026 22:47:41 +0800")
References: <20260831160038.221776-1-zhangckid@gmail.com>
 <20260831160038.221776-7-zhangckid@gmail.com>
 <8733vtbk16.fsf@pond.sub.org>
 <CAK3tnvLbaJ4b+gRhXC678cye-cHv+aP3FFwRvhPNjyfSHxL6MA@mail.gmail.com>
Date: Wed, 02 Sep 2026 13:25:33 +0200
Message-ID: <87qzjb3nf6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

> On Tue, Sep 1, 2026 at 1:47=E2=80=AFPM Markus Armbruster <armbru@redhat.c=
om> wrote:
>>
>> Zhang Chen <zhangckid@gmail.com> writes:
>>
>> > Monitors that require an IOThread share the internal mon_iothread.
>> > Account for each monitor explicitly in IOThread holder tracking, using
>> > the monitor's canonical QOM path to distinguish holders.
>> >
>> > Acquire the shared monitor IOThread AioContext once, using the monitor
>> > QOM path as the holder, and reuse the stored context for later
>> > operations.
>> >
>> > Release the holder from the Monitor ObjectClass::unparent callback,
>> > while the canonical QOM path is still available. This covers every
>> > object_unparent() path and avoids duplicating the cleanup in
>> > monitor_cleanup() and monitor_qmp_prepare_delete().
>> >
>> > The internal mon_iothread remains hidden from query-iothreads, as befo=
re.
>> > Management applications therefore cannot use it to determine which
>> > monitors are using the IOThread. Nevertheless, track the monitor
>> > holders so that they follow the same explicit holder and
>> > IOThread reference lifecycle as other AioContext users.
>> >
>> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
>>
>> I have a question for our QOM experts (Paolo and Daniel).
>>
>> This patch takes a reference in its UserCreatableClass method
>> complete(), and relinquishes it in its ObjectClass unparent() method.
>> Is that correct and clean?  Or should complete() pair with
>> prepare_delete()?
>
>
> Add some background information in previous reviews for here:
> https://lists.gnu.org/archive/html/qemu-devel/2026-08/msg05318.html

Aha, Stefan asked for monitor_finalize(), which doesn't exist.  You then
moved it to the unparent() method.

My question for the QOM maintainers remains: is it okay to pair
complete() with unparent(), or should it pair with prepare_delete()?

[...]


