Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E04DAC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 08:01:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1iQm-0000Ra-48; Tue, 30 Apr 2024 04:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s1iQK-0000P3-LV
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 04:01:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s1iQB-0008EQ-3N
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 04:01:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714464061;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=GyljvoPy3VUuf8o8Zxr7nQ+Vj3P283SgTwWtJQlU9lo=;
 b=ZptiM0Ww1dH91ZQq5iooBkJjx9ch5BIOyp80fkVAP8N9rJydyYHyhgBsFDTmjzMSJfw6QV
 VJ5RCESJAgymAOaDBFMhTYcH9HOi/rYv7K8NVxtPOZzrYu3fs5GF35dSLVM8fhG+ZCuva4
 84llpFoBlbGHncoR40oc5kAFO73SXuA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-urskT95KOIC9NydgCfcGIQ-1; Tue, 30 Apr 2024 04:00:57 -0400
X-MC-Unique: urskT95KOIC9NydgCfcGIQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 82CE0830D37;
 Tue, 30 Apr 2024 08:00:56 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F6BF40C6CC0;
 Tue, 30 Apr 2024 08:00:51 +0000 (UTC)
Date: Tue, 30 Apr 2024 09:00:49 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Michael Galaxy <mgalaxy@akamai.com>,
 Yu Zhang <yu.zhang@ionos.com>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 Jinpu Wang <jinpu.wang@ionos.com>, Elmar Gerdes <elmar.gerdes@ionos.com>,
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
Message-ID: <ZjClMb-6MddpvHqQ@redhat.com>
References: <ZhQYu3ZnsIGv2qUZ@x1n>
 <CAMGffEm2TWJxOPcNQTQ1Sjytf5395dBzTCMYiKRqfxDzJwSN6A@mail.gmail.com>
 <ZhWa0YeAb9ySVKD1@x1n>
 <082a21b0-d4d1-9f6c-24b5-bee56263008e@fujitsu.com>
 <ZhaY2_cO6CrQFCt3@x1n> <Zhfxoaz9yNTx8Btd@x1n>
 <CAHEcVy7POArt+CmY8dyNTzLJp3XxXgjh3k8=C=9K+_cw1CSJFA@mail.gmail.com>
 <46f5e323-632d-7bda-f2c5-3cfa7b1c6b68@akamai.com>
 <Zi-1OvxA5MIHjklU@x1n> <877cgfe2yw.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <877cgfe2yw.fsf@pond.sub.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Apr 30, 2024 at 09:15:03AM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Mon, Apr 29, 2024 at 08:08:10AM -0500, Michael Galaxy wrote:
> >> Hi All (and Peter),
> >
> > Hi, Michael,
> >
> >> 
> >> My name is Michael Galaxy (formerly Hines). Yes, I changed my last name
> >> (highly irregular for a male) and yes, that's my real last name:
> >> https://www.linkedin.com/in/mrgalaxy/)
> >> 
> >> I'm the original author of the RDMA implementation. I've been discussing
> >> with Yu Zhang for a little bit about potentially handing over maintainership
> >> of the codebase to his team.
> >> 
> >> I simply have zero access to RoCE or Infiniband hardware at all,
> >> unfortunately. so I've never been able to run tests or use what I wrote at
> >> work, and as all of you know, if you don't have a way to test something,
> >> then you can't maintain it.
> >> 
> >> Yu Zhang put a (very kind) proposal forward to me to ask the community if
> >> they feel comfortable training his team to maintain the codebase (and run
> >> tests) while they learn about it.
> >
> > The "while learning" part is fine at least to me.  IMHO the "ownership" to
> > the code, or say, taking over the responsibility, may or may not need 100%
> > mastering the code base first.  There should still be some fundamental
> > confidence to work on the code though as a starting point, then it's about
> > serious use case to back this up, and careful testings while getting more
> > familiar with it.
> 
> How much experience we expect of maintainers depends on the subsystem
> and other circumstances.  The hard requirement isn't experience, it's
> trust.  See the recent attack on xz.
> 
> I do not mean to express any doubts whatsoever on Yu Zhang's integrity!
> I'm merely reminding y'all what's at stake.

I think we shouldn't overly obsess[1] about 'xz', because the overwhealmingly
common scenario is that volunteer maintainers are honest people. QEMU is
in a massively better peer review situation. With xz there was basically no
oversight of the new maintainer. With QEMU, we have oversight from 1000's
of people on the list, a huge pool of general maintainers, the specific
migration maintainers, and the release manager merging code.

With a lack of historical experiance with QEMU maintainership, I'd suggest
that new RDMA volunteers would start by adding themselves to the "MAINTAINERS"
file with only the 'Reviewer' classification. The main migration maintainers
would still handle pull requests, but wait for a R-b from one of the RMDA
volunteers. After some period of time the RDMA folks could graduate to full
maintainer status if the migration maintainers needed to reduce their load.
I suspect that might prove unneccesary though, given RDMA isn't an area of
code with a high turnover of patches.

With regards,
Daniel

[1] If we do want to obsess about something bad though, we should
    look at our handling of binary blobs in the repo and tarballs.
    ie the firmware binaries that all get built in an arbitrary
    environment of their respective maintainer. If we need firmware
    blobs in tree, we should strive to come up with a reprodicble
    build environment that gives us byte-for-byte identical results,
    so the blobs can be verified. This is rather a tangent from this
    thread though :)
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


