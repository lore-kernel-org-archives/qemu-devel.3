Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 507BACD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 09:01:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru7Lx-0005hK-0r; Tue, 09 Apr 2024 05:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ru7Ll-0005UT-Jb
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 05:01:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ru7Lk-0000UM-0R
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 05:01:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712653261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7GiYpAWx0LAbg8GHeDh3MC8dTSAlB3H/U0GWaE+Dji8=;
 b=LfgB5WFYp12Cy2hCtrNq+ndG04vVTjWbCP0SYUENLhR+II+wg0zxFzNYbITf1EzzRLBfzz
 lRI6Ovk16CIYp2R0lKNRQPj+lqjesws7bjMHn4VMalwDGcfaB554QGO29AZjhg041DQkY3
 K+EiPtebKeZwhOiwtWoGA4NNMUhfMGg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-25-Uk-daZioPx28-iJzTloAmg-1; Tue,
 09 Apr 2024 05:00:59 -0400
X-MC-Unique: Uk-daZioPx28-iJzTloAmg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 49BBD29AA39A;
 Tue,  9 Apr 2024 09:00:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E551517ABB;
 Tue,  9 Apr 2024 09:00:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 086EF21E65D7; Tue,  9 Apr 2024 11:00:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Jinpu Wang <jinpu.wang@ionos.com>,  Yu Zhang <yu.zhang@ionos.com>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,  Elmar Gerdes
 <elmar.gerdes@ionos.com>,  "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>,  Yuval Shaia <yuval.shaia.ml@gmail.com>,  Kevin
 Wolf <kwolf@redhat.com>,  Prasanna Kumar Kalever
 <prasanna.kalever@redhat.com>,  Cornelia Huck <cohuck@redhat.com>,
 Michael Roth <michael.roth@amd.com>,  Prasanna Kumar Kalever
 <prasanna4324@gmail.com>,  "integration@gluster.org"
 <integration@gluster.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,  Daniel P. =?utf-8?Q?Be?=
 =?utf-8?Q?rrang=C3=A9?= <berrange@redhat.com>,  "devel@lists.libvirt.org"
 <devel@lists.libvirt.org>,  Hanna Reitz <hreitz@redhat.com>,  "Michael S.
 Tsirkin" <mst@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Song Gao <gaosong@loongson.cn>,  =?utf-8?Q?Marc-And?=
 =?utf-8?Q?r=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,  Beraldo Leal
 <bleal@redhat.com>,  arei.gonglei@huawei.com,  pannengyuan@huawei.com
Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
In-Reply-To: <ZhQYu3ZnsIGv2qUZ@x1n> (Peter Xu's message of "Mon, 8 Apr 2024
 12:18:03 -0400")
References: <20240328130255.52257-1-philmd@linaro.org>
 <20240328130255.52257-3-philmd@linaro.org> <87frwatp7n.fsf@suse.de>
 <ZgWGMmUTq0jqSUvr@x1n>
 <7a510fbe-1c27-4f67-93b8-0d9cf01c1c74@fujitsu.com>
 <ef160e75-d4a4-4be0-81f3-77d8b0e76178@linaro.org>
 <9d082daf-acf0-27c5-1758-5a3f2af7ee0f@fujitsu.com>
 <CAHEcVy50AtvDyCjwPa9Hu+x1wiUF6xf5McGOTHL+wdt3WN3pgA@mail.gmail.com>
 <Zgx3brrz8m0V7HS4@x1n>
 <CAMGffE=i+hVCNaX_31h1D1VW7JGJBqoa9T0qEJe2CDcb9BPiAA@mail.gmail.com>
 <ZhQYu3ZnsIGv2qUZ@x1n>
Date: Tue, 09 Apr 2024 11:00:52 +0200
Message-ID: <87bk6ioqpn.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Peter Xu <peterx@redhat.com> writes:

> On Mon, Apr 08, 2024 at 04:07:20PM +0200, Jinpu Wang wrote:
>> Hi Peter,
>
> Jinpu,
>
> Thanks for joining the discussion.
>
>>=20
>> On Tue, Apr 2, 2024 at 11:24=E2=80=AFPM Peter Xu <peterx@redhat.com> wro=
te:
>> >
>> > On Mon, Apr 01, 2024 at 11:26:25PM +0200, Yu Zhang wrote:
>> > > Hello Peter und Zhjian,
>> > >
>> > > Thank you so much for letting me know about this. I'm also a bit sur=
prised at
>> > > the plan for deprecating the RDMA migration subsystem.
>> >
>> > It's not too late, since it looks like we do have users not yet notifi=
ed
>> > from this, we'll redo the deprecation procedure even if it'll be the f=
inal
>> > plan, and it'll be 2 releases after this.

[...]

>> > Per our best knowledge, RDMA users are rare, and please let anyone kno=
w if
>> > you are aware of such users.  IIUC the major reason why RDMA stopped b=
eing
>> > the trend is because the network is not like ten years ago; I don't th=
ink I
>> > have good knowledge in RDMA at all nor network, but my understanding is
>> > it's pretty easy to fetch modern NIC to outperform RDMAs, then it may =
make
>> > little sense to maintain multiple protocols, considering RDMA migration
>> > code is so special so that it has the most custom code comparing to ot=
her
>> > protocols.
>> +cc some guys from Huawei.
>>=20
>> I'm surprised RDMA users are rare,  I guess maybe many are just
>> working with different code base.
>
> Yes, please cc whoever might be interested (or surprised.. :) to know thi=
s,
> and let's be open to all possibilities.
>
> I don't think it makes sense if there're a lot of users of a feature then
> we deprecate that without a good reason.  However there's always the
> resource limitation issue we're facing, so it could still have the
> possibility that this gets deprecated if nobody is working on our upstream
> branch. Say, if people use private branches anyway to support rdma without
> collaborating upstream, keeping such feature upstream then may not make
> much sense either, unless there's some way to collaborate.  We'll see.
>
> It seems there can still be people joining this discussion.  I'll hold off
> a bit on merging this patch to provide enough window for anyone to chim i=
n.

Users are not enough.  Only maintainers are.

At some point, people cared enough about RDMA in QEMU to contribute the
code.  That's why have the code.

To keep the code, we need people who care enough about RDMA in QEMU to
maintain it.  Without such people, the case for keeping it remains
dangerously weak, and no amount of talk or even benchmarks can change
that.


