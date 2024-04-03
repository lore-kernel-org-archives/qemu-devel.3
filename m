Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22202CD1288
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 17:52:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rs4lR-0003iJ-Ki; Wed, 03 Apr 2024 13:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rs4lP-0003hw-KW
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 13:51:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rs4lL-0000EO-Bw
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 13:51:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712166662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kNdYv6LHFMI0Ma9P6nUltSmR2ARa0gJCL1olN++mmLw=;
 b=NfsMKjg/OuCYCJc3h2eoVZYel9GmeYJHoSTr+eAttMRnL15qyuANoIpeQBat+xZiwmNoeu
 bVJK11GsAAWaaPTXaABBpC0+5lC3UClZPU9Fk0B3sE3aNqFVEDUBlicd0M4KspzNVg5xXh
 /aBTKYuuEMZVTZlIsmu6Fs/MXJsoLZA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-O3GPhXzXMquXt5sbLzqoZQ-1; Wed,
 03 Apr 2024 13:50:58 -0400
X-MC-Unique: O3GPhXzXMquXt5sbLzqoZQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5F0FD3821343;
 Wed,  3 Apr 2024 17:50:57 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8753E492BCA;
 Wed,  3 Apr 2024 17:50:51 +0000 (UTC)
Date: Wed, 3 Apr 2024 12:50:45 -0500
From: Eric Blake <eblake@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 qemu-devel@nongnu.org, Hyman Huang <yong.huang@smartx.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-block@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Mahmoud Mandour <ma.mandourr@gmail.com>, John Snow <jsnow@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, 
 Fam Zheng <fam@euphon.net>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Bin Meng <bin.meng@windriver.com>, Hanna Reitz <hreitz@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, 
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jesper Devantier <foss@defmacro.it>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Keith Busch <kbusch@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 06/19] block/stream: fix -Werror=maybe-uninitialized
 false-positives
Message-ID: <7qztxyz6yrjir6odtguvfxnzmvpqfevxd3lnhmjldlk4br6cqc@iens4se43kj5>
References: <20240328102052.3499331-1-marcandre.lureau@redhat.com>
 <20240328102052.3499331-7-marcandre.lureau@redhat.com>
 <65d791e4-6c68-4b6d-b181-bc3886745ce3@yandex-team.ru>
 <CAJ+F1CLbjZG24rMKwA20NFM=6sTE4CRAaGt4Vha+bP8i=+on-A@mail.gmail.com>
 <0d7344c2-b146-44cf-a911-21fa5e556665@yandex-team.ru>
 <mzls26xlctld3fd5fl3h5wdrbh6hb5i3xcakeslwzny5tva7ch@w6wnruxtefkl>
 <3064bc69-3d8e-4d7c-b640-a7ab703f9575@yandex-team.ru>
 <CAJ+F1CLG+7BT8wLFmmJ0t8NvMu2a2Vp1+p6gUuBTch9haYP8LQ@mail.gmail.com>
 <ba76742d-4fa1-4120-98ad-944845a37ad6@yandex-team.ru>
 <CAJ+F1CKAWpeOKe=8YM38_H6xP5cvDJ0RQXcSvm9LUMLpyo4ndw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CKAWpeOKe=8YM38_H6xP5cvDJ0RQXcSvm9LUMLpyo4ndw@mail.gmail.com>
User-Agent: NeoMutt/20240201
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Apr 03, 2024 at 01:24:11PM +0400, Marc-André Lureau wrote:
> > > Unfortunately, it doesn't work in all cases. It seems to have issues
> > > with some guards:
> > > ../block/stream.c: In function ‘stream_run’:
> > > ../block/stream.c:216:12: error: ‘ret’ may be used uninitialized
> > > [-Werror=maybe-uninitialized]
> > >    216 |         if (ret < 0) {
> > >

That one looks like:

int ret;
WITH_GRAPH_RDLOCK_GUARD() {
  ret = ...;
}
if (copy) {
  ret = ...;
}
if (ret < 0)

I suspect the compiler is seeing the uncertainty possible from the
second conditional, and letting it take priority over the certainty
that the tweaked macro provided for the first conditional.

> > >
> >
> > So, updated macro helps in some cases, but doesn't help here? Intersting, why.
> >
> > > What should we do? change the macros + cherry-pick the missing
> > > false-positives, or keep this series as is?

An uglier macro, with sufficient comments as to why it is ugly (in
order to let us have fewer false positives where we have to add
initializers) may be less churn in the code base, but I'm not
necessarily sold on the ugly macro.  Let's see if anyone else
expresses an opinion.


> > >
> > >
> >
> > I think marco + missing is better. No reason to add dead-initializations in cases where new macros helps.
> 
> Ok
> 
> > Still, would be good to understand, what's the difference, why it help on some cases and not help in another.
> 
> I don't know, it's like if the analyzer was lazy for this particular
> case, although there is nothing much different from other usages.
> 
> If I replace:
> for (... *var2 = (void *)true; var2;
> with:
> for (... *var2 = (void *)true; var2 || true;
> 
> then it doesn't warn..

but it also doesn't work.  We want the body to execute exactly once,
not infloop.


> 
> Interestingly as well, if I change:
>     for (... *var2 = (void *)true; var2; var2 = NULL)
> for:
>     for (... *var2 = GML_OBJ_(); var2; var2 = NULL)
> 
> GML_OBJ_() simply being &(GraphLockable) { }), an empty compound
> literal, then it doesn't work, in all usages.

So the compiler is not figuring out that the compound literal is
sufficient for an unconditional one time through the for loop body.

What's worse, different compiler versions will change behavior over
time.  Making the code ugly to pacify a particular compiler, when that
compiler might improve in the future, is a form of chasing windmills.

> 
> All in all, I am not sure the trick of using var2 is really reliable either.

And that's my biggest argument for not making the macro not more
complex than it already is.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


