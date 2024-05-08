Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D26C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 10:07:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4eCO-0003GO-JD; Wed, 08 May 2024 06:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s4eCL-0003FT-J1
 for qemu-devel@nongnu.org; Wed, 08 May 2024 06:06:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s4eCJ-0001v6-72
 for qemu-devel@nongnu.org; Wed, 08 May 2024 06:06:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715162810;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gdV7aO/vBaZrtRyxgzjWMxfg2weXLmcHwx6yfA2YnlA=;
 b=VTQl0RYc0uwA1SBqnetZmzJNAi//SJhOKCQLfdy4CAgvKyfK2tD2D31sLJDVyFX7yrdVZ/
 Ue7KBmozr+YJgCR/ZOrTz2QS6tTO9lLzAkZilDC+aokcEut4F19uGMT/gNaZ4RsSQhhl2/
 v/68oy7XzSQm2xayW7fURILoL61DMM4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-cpw-36GsNp-7uauo7qRaXw-1; Wed, 08 May 2024 06:06:45 -0400
X-MC-Unique: cpw-36GsNp-7uauo7qRaXw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B4718021A4;
 Wed,  8 May 2024 10:06:44 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A82C40C6EB7;
 Wed,  8 May 2024 10:06:39 +0000 (UTC)
Date: Wed, 8 May 2024 11:06:37 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Jinpu Wang <jinpu.wang@ionos.com>
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Galaxy <mgalaxy@akamai.com>, Yu Zhang <yu.zhang@ionos.com>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 Elmar Gerdes <elmar.gerdes@ionos.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Prasanna Kumar Kalever <prasanna.kalever@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Prasanna Kumar Kalever <prasanna4324@gmail.com>,
 "integration@gluster.org" <integration@gluster.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "devel@lists.libvirt.org" <devel@lists.libvirt.org>,
 Hanna Reitz <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 Song Gao <gaosong@loongson.cn>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, arei.gonglei@huawei.com,
 pannengyuan@huawei.com
Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
Message-ID: <ZjtOreamN8xF9FDE@redhat.com>
References: <Zi-1OvxA5MIHjklU@x1n> <877cgfe2yw.fsf@pond.sub.org>
 <ZjClMb-6MddpvHqQ@redhat.com> <ZjJgQcPQ29HJsTpY@x1n>
 <ZjJm6rcqS5EhoKgK@redhat.com>
 <CAMGffEnj54q1GAtB84dWGVR0hLPzfR1W8Fa2TeP22y2zTBRNeQ@mail.gmail.com>
 <ZjT1sPh5OaByQmAB@x1n>
 <CAMGffEk8wiKNQmoUYxcaTHGtiEm2dwoCF_W7T0vMcD-i30tUkA@mail.gmail.com>
 <Zjj3GXsaUyCjjUnC@x1n>
 <CAMGffE=Hcep90DaoJDmKY6ESMtr1fZHehv-UrcHJHA8b2KvjBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMGffE=Hcep90DaoJDmKY6ESMtr1fZHehv-UrcHJHA8b2KvjBw@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, May 07, 2024 at 06:52:50AM +0200, Jinpu Wang wrote:
> Hi Peter, hi Daniel,
> On Mon, May 6, 2024 at 5:29 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Mon, May 06, 2024 at 12:08:43PM +0200, Jinpu Wang wrote:
> > > Hi Peter, hi Daniel,
> >
> > Hi, Jinpu,
> >
> > Thanks for sharing this test results.  Sounds like a great news.
> >
> > What's your plan next?  Would it then be worthwhile / possible moving QEMU
> > into that direction?  Would that greatly simplify rdma code as Dan
> > mentioned?
> I'm rather not familiar with QEMU migration yet,  from the test
> result, I think it's a possible direction,
> just we need to at least based on a rather recent release like
> rdma-core v33 with proper 'fork' support.
> 
> Maybe Dan or you could give more detail about what you have in mind
> for using rsocket as a replacement for the future.
> We will also look into the implementation details in the meantime.

The migration/socket.c file is the entrypoint for traditional TCP
based migration code. It uses the QIOChannelSocket class which is
written against the traditional sockets APIs, and uses the QAPI
SocketAddress data type to configure it..

My thought was that potentially SocketAddress could be extended to
offer RDMA addressing eg


{ 'union': 'SocketAddress',
  'base': { 'type': 'SocketAddressType' },
  'discriminator': 'type',
  'data': { 'inet': 'InetSocketAddress',
            'unix': 'UnixSocketAddress',
            'vsock': 'VsockSocketAddress',
            'fd': 'FdSocketAddress',
	    'rdma': 'InetSocketAddress' } }

And then QIOChannelSocket could be also extended to call the
alternative 'rsockets' APIs where needed. That would mean that
existing sockets migration code would almost "just work" with
RDMA. Theoreticaly any other part of QEMU using QIOChannelSocket
would also then magically support RDMA too, with very little (if
any) extra work.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


