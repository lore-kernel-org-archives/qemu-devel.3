Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7392C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 07:17:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1hi0-0003Wm-9a; Tue, 30 Apr 2024 03:15:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s1hhw-0003OX-FF
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 03:15:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s1hho-00006a-0m
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 03:15:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714461310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qm05XfiJ11YJUtgyns7rc73BV158o98FK8vvoeqqE8I=;
 b=SGu1ihVJOOswFyk8DJ5ahSVg8yMkAYuTxYpEES/YHQ7FYSAKRow9yUwBhfP5saMJMzpRvx
 2KvBJI/oh5fbw79cZ9zvgeOT9CHA8jtDepNkZEhpw9xG5lxtpK1fvjF0dDlIkAo2g62GKy
 nm2CXMCnZiT+CRp9AV++knu1W2r+sKk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-3laLqJ45OFGSNKwdfkmP4w-1; Tue, 30 Apr 2024 03:15:06 -0400
X-MC-Unique: 3laLqJ45OFGSNKwdfkmP4w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 34F3080017B;
 Tue, 30 Apr 2024 07:15:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C26FC15771;
 Tue, 30 Apr 2024 07:15:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 45F5A21E66C8; Tue, 30 Apr 2024 09:15:03 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Michael Galaxy <mgalaxy@akamai.com>,  Yu Zhang <yu.zhang@ionos.com>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,  Jinpu Wang
 <jinpu.wang@ionos.com>,  Elmar Gerdes <elmar.gerdes@ionos.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,  Yuval Shaia
 <yuval.shaia.ml@gmail.com>,  Kevin Wolf <kwolf@redhat.com>,  Prasanna
 Kumar Kalever <prasanna.kalever@redhat.com>,  Cornelia Huck
 <cohuck@redhat.com>,  Michael Roth <michael.roth@amd.com>,  Prasanna Kumar
 Kalever <prasanna4324@gmail.com>,  "integration@gluster.org"
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
In-Reply-To: <Zi-1OvxA5MIHjklU@x1n> (Peter Xu's message of "Mon, 29 Apr 2024
 10:56:58 -0400")
References: <Zgx3brrz8m0V7HS4@x1n>
 <CAMGffE=i+hVCNaX_31h1D1VW7JGJBqoa9T0qEJe2CDcb9BPiAA@mail.gmail.com>
 <ZhQYu3ZnsIGv2qUZ@x1n>
 <CAMGffEm2TWJxOPcNQTQ1Sjytf5395dBzTCMYiKRqfxDzJwSN6A@mail.gmail.com>
 <ZhWa0YeAb9ySVKD1@x1n>
 <082a21b0-d4d1-9f6c-24b5-bee56263008e@fujitsu.com>
 <ZhaY2_cO6CrQFCt3@x1n> <Zhfxoaz9yNTx8Btd@x1n>
 <CAHEcVy7POArt+CmY8dyNTzLJp3XxXgjh3k8=C=9K+_cw1CSJFA@mail.gmail.com>
 <46f5e323-632d-7bda-f2c5-3cfa7b1c6b68@akamai.com>
 <Zi-1OvxA5MIHjklU@x1n>
Date: Tue, 30 Apr 2024 09:15:03 +0200
Message-ID: <877cgfe2yw.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
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

> On Mon, Apr 29, 2024 at 08:08:10AM -0500, Michael Galaxy wrote:
>> Hi All (and Peter),
>
> Hi, Michael,
>
>> 
>> My name is Michael Galaxy (formerly Hines). Yes, I changed my last name
>> (highly irregular for a male) and yes, that's my real last name:
>> https://www.linkedin.com/in/mrgalaxy/)
>> 
>> I'm the original author of the RDMA implementation. I've been discussing
>> with Yu Zhang for a little bit about potentially handing over maintainership
>> of the codebase to his team.
>> 
>> I simply have zero access to RoCE or Infiniband hardware at all,
>> unfortunately. so I've never been able to run tests or use what I wrote at
>> work, and as all of you know, if you don't have a way to test something,
>> then you can't maintain it.
>> 
>> Yu Zhang put a (very kind) proposal forward to me to ask the community if
>> they feel comfortable training his team to maintain the codebase (and run
>> tests) while they learn about it.
>
> The "while learning" part is fine at least to me.  IMHO the "ownership" to
> the code, or say, taking over the responsibility, may or may not need 100%
> mastering the code base first.  There should still be some fundamental
> confidence to work on the code though as a starting point, then it's about
> serious use case to back this up, and careful testings while getting more
> familiar with it.

How much experience we expect of maintainers depends on the subsystem
and other circumstances.  The hard requirement isn't experience, it's
trust.  See the recent attack on xz.

I do not mean to express any doubts whatsoever on Yu Zhang's integrity!
I'm merely reminding y'all what's at stake.

[...]


