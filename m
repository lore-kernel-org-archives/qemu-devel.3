Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE050FF885A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 07:27:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHcpu-0002cP-PL; Tue, 28 Apr 2026 03:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wHcpm-0002bb-0f
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 03:26:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wHcpj-0007q9-QE
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 03:26:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777361173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a36fSYE6M+YWTm0rluUa4iLfQ5epyR22EqRcHUwmVYs=;
 b=PZ6ylDLVIQVifBuTjBdoRRbYewWQffUGHH6JBLpIzZ3i71VLeVf7TCioz46/4k7kJAtD3/
 dsOE9ZqbyPiJzeY0O0aCoKeAoaZOHwXYcHYcbHAnBmBNCMrqmgpgDx1qU4rtXIE7fDrhON
 G59LyQmJTWbaWsGjDcQtps3EhoFmyWE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-H_nj5ry_P8-EB2CU49XHsQ-1; Tue,
 28 Apr 2026 03:26:09 -0400
X-MC-Unique: H_nj5ry_P8-EB2CU49XHsQ-1
X-Mimecast-MFC-AGG-ID: H_nj5ry_P8-EB2CU49XHsQ_1777361168
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 52C08195608F; Tue, 28 Apr 2026 07:26:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.9])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AD3F41800357; Tue, 28 Apr 2026 07:26:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5058021E6A28; Tue, 28 Apr 2026 09:26:05 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel
 <qemu-devel@nongnu.org>,  "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>,  "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH V6 06/14] monitor: Update tracking iothread users with
 holder name
In-Reply-To: <CAK3tnvLHHXoEVngnyUbeTeVdj3w997wSc6heOPJG6-aWmzNazg@mail.gmail.com>
 (Zhang Chen's message of "Mon, 27 Apr 2026 22:55:48 +0800")
References: <20260410150457.85190-1-zhangckid@gmail.com>
 <20260410150457.85190-7-zhangckid@gmail.com>
 <87ldedongv.fsf@pond.sub.org>
 <CAK3tnvLHHXoEVngnyUbeTeVdj3w997wSc6heOPJG6-aWmzNazg@mail.gmail.com>
Date: Tue, 28 Apr 2026 09:26:05 +0200
Message-ID: <877bpr5ywi.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

> On Thu, Apr 23, 2026 at 8:44=E2=80=AFPM Markus Armbruster <armbru@redhat.=
com> wrote:
>> Oh.
>>
>> PATCH 02 defines QAPI type IoThreadHolder as a union with two branches
>> for the two kinds of holders: one for block node holder, and one for QOM
>> object holder.  Both branches use a string to identify the holder.
>>
>> The C code in PATCH 02 uses just a string to identify the holder.  This
>> silently assumes that the strings for block nodes are distinct from the
>> strings for QOM objects.  True as long as we only use absolute QOM
>> paths: these start with '/', and block nodes can't.
>>
>> This patch shows me there's actually a third kind: monitor.  You use the
>> QOM object branch for it.  That's confusing; a monitor is not a QOM
>> object.  Moreover, you make yet another silent assumption: absolute QOM
>> paths do not start with "/monitor/".
>>
>> This is too much for me.
>>
>> Please use a separate IoThreadHolderKind value and IoThreadHolder branch
>> for each kind of holder.  The kinds I've seen so far are block-node, QOM
>> object, monitor.
>>
>> If Daniel Berrang=C3=A9's "[PATCH RFC 00/17] monitor: turn QMP and HMP i=
nto
>> QOM objects" gets merged, kind monitor can go away.
>>
>> Use of just a string to identify the holder requires strings for
>> different kinds to be distinct.  The argument why they are must be
>> written down, simple, and likely to remain true.
>>
>> But I'd prefer to use IoThreadHolder instead of string.  No assumptions
>> necessary then.
>>
>> If this IoThreadHolder arguments make the calls ugly or overly verbose,
>> consider thin wrappers for each kind, i.e.
>>
>>     new_ctx =3D iothread_get_aio_context_block(iothread, bs);
>>
>> instead of
>>
>>     holder_name =3D bdrv_get_node_name(bs);
>>     new_ctx =3D iothread_get_aio_context(iothread, holder_name);
>>
>> and so forth.
>>
>> Questions?
>
> Thank you for the detailed explanation.
> You are right, in this patch I silent assumption: absolute QOM paths
> do not start with "/monitor/".
> Because the Daniel Berrang=C3=A9's RFC patch and the monitor implementati=
on
> is very special,
> it creates the iothread for itself. The iothread lifecycle is same
> with the monitor.
> It is not a general case like QOM and block node.
> Maybe no need for this case add a third kind here?

I don't know.  Or maybe I don't understand the question.


