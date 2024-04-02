Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD65DC6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 15:36:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrgAa-0002uq-01; Tue, 02 Apr 2024 11:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rrgAW-0002uT-37
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 11:35:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rrgAQ-0007sU-5J
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 11:35:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712072114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rXnqVeTdWqZMHcXg/qGPTlyVQ5F7MNfTUwS7cD73PK0=;
 b=bmOQaeRoEbLVpTHNA+S0MfEIBgCdhOsmxEVCR4ohyMHUVkDRVydMXsnHfF4eKKr+5z8Hbc
 CthcMgzjmpW18APjVc8itfoNARpviwNQKEsFPdNUM9yhPaoT2ayK/Vjn/xWTozeZLjAgg5
 5upiOwkSNvYRoAxi1F1mh0uvm9HlhZ0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-YqSE0SRDOoOZjBsbWEr1QQ-1; Tue, 02 Apr 2024 11:35:10 -0400
X-MC-Unique: YqSE0SRDOoOZjBsbWEr1QQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A38985A58E;
 Tue,  2 Apr 2024 15:35:09 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6FBDE40C1409;
 Tue,  2 Apr 2024 15:35:04 +0000 (UTC)
Date: Tue, 2 Apr 2024 10:34:43 -0500
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>, 
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
Message-ID: <mzls26xlctld3fd5fl3h5wdrbh6hb5i3xcakeslwzny5tva7ch@w6wnruxtefkl>
References: <20240328102052.3499331-1-marcandre.lureau@redhat.com>
 <20240328102052.3499331-7-marcandre.lureau@redhat.com>
 <65d791e4-6c68-4b6d-b181-bc3886745ce3@yandex-team.ru>
 <CAJ+F1CLbjZG24rMKwA20NFM=6sTE4CRAaGt4Vha+bP8i=+on-A@mail.gmail.com>
 <0d7344c2-b146-44cf-a911-21fa5e556665@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d7344c2-b146-44cf-a911-21fa5e556665@yandex-team.ru>
User-Agent: NeoMutt/20240201
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Apr 02, 2024 at 12:58:43PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > Again, same false-positives, because of WITH_GRAPH_RDLOCK_GUARD()..
> > > 
> > > Didn't you try to change WITH_ macros somehow, so that compiler believe in our good intentions?
> > > 
> > 
> > 
> > #define WITH_QEMU_LOCK_GUARD_(x, var) \
> >      for (g_autoptr(QemuLockable) var = \
> >                  qemu_lockable_auto_lock(QEMU_MAKE_LOCKABLE_NONNULL((x))); \
> >           var; \
> >           qemu_lockable_auto_unlock(var), var = NULL)
> > 
> > I can't think of a clever way to rewrite this. The compiler probably
> > thinks the loop may not run, due to the "var" condition. But how to
> > convince it otherwise? it's hard to introduce another variable too..
> 
> 
> hmm. maybe like this?
> 
> #define WITH_QEMU_LOCK_GUARD_(x, var) \
>     for (g_autoptr(QemuLockable) var = \
>                 qemu_lockable_auto_lock(QEMU_MAKE_LOCKABLE_NONNULL((x))), \
>          var2 = (void *)(true); \
>          var2; \
>          qemu_lockable_auto_unlock(var), var2 = NULL)
> 
> 
> probably, it would be simpler for compiler to understand the logic this way. Could you check?

Wouldn't that attach __attribute__((cleanup(xxx))) to var2, at which
point we could cause the compiler to call xxx((void*)(true)) if the
user does an early return inside the lock guard, with disastrous
consequences?  Or is the __attribute__ applied only to the first out
of two declarations in a list?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


