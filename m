Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D84C44501
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 16:02:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk23A-0002m6-C3; Wed, 15 Jul 2026 12:01:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wk234-0002kq-P0
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 12:01:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wk231-0006Va-AX
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 12:01:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784131280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hPq28wTmWk0drLb08pyvoJKK5J9N3ChXU/wNBkg0kdo=;
 b=btkcpsbVQwMekYggVH15XHLvskbV96iir0CR0vH4b6NbrpZ+/5oJgyuAIf1KvsSPLW1UfO
 GQpkCNdSq84gTVq/+VgekQBe2Vno1r5nA9MFgFjKXJP+w3aReuohh6T81l+6uYtK9LVlyx
 iucdIcAiA0tyGoCASp7t91DMrLpYk2k=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-pw9IPdnrMWucPHjnW2jIIQ-1; Wed, 15 Jul 2026 12:01:18 -0400
X-MC-Unique: pw9IPdnrMWucPHjnW2jIIQ-1
X-Mimecast-MFC-AGG-ID: pw9IPdnrMWucPHjnW2jIIQ_1784131278
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e5fc4c7e9so247961585a.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 09:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784131278; x=1784736078; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hPq28wTmWk0drLb08pyvoJKK5J9N3ChXU/wNBkg0kdo=;
 b=EQUAMwb6FyI/16V6v8/Tg0r0QuoZLOOfa6UDqTilYgpihJW1IjOAXAN9pRB+kXyqwa
 nk0rEuIs8OD9vdYwUqpHmgMNxkJRKQFG3E+bm47iz8yPjj1dYfxwuQvYkjW5u2kVxLQZ
 14B+ouuV86hpCdmCx/LSzt87vweijsepb8OHxSuuqDZSiIl/ERFCmdHrwSrjWifAQEyo
 aiaHdQTQn26aS5B69U14PA3bTnMg+dIoIiAVMeHSQqClwMjIXWv+HbJDjU/kYffuxuFl
 w7ndYDWb1PjhIuapObmlflD/TdM5W06I32YYuDnvOYLmW4N3QRzfq8jQjlDnaOG2WO4Y
 WkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784131278; x=1784736078;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hPq28wTmWk0drLb08pyvoJKK5J9N3ChXU/wNBkg0kdo=;
 b=Te8ruWpCd5f3Xl0Cshit5nUPBnKHjE5Xj2/XDeIgb6vVL/vzQKfJ3YyzfTcYAdYUxf
 O26lxLeTut3SwfaaCVbid+uGKzfICjOifm/+6vcqw5ldXKl82hrnEaIGxDqXn+j/2nD3
 EU+eWYmiAHxPWTKU9yYHXXBK7LW0OC5Lf423F6ag66IU2CmmEKVwMz/4IqZoUB9Un4wl
 zQgRdBQX46yINmu/k1N/7DupqZYSr0yK6m+3mph8UQMajt7mkLrLPU4Y39LYrqgA6lyw
 7qtPrUapdng1DEZcDhIBAEbtGLdxeUNHJ4DNktruf5Aro3nnrwF21QAnbnmFiMnl5HzT
 gtLA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrdKOQnLvlj+AzXL6zU9Uy/IhadG7qAhaxjpWV/Oi8bl6WsDhSamwMUT1OpREdi/CbMR05WF8eiDtlZ@nongnu.org
X-Gm-Message-State: AOJu0Ywk2S+x0/cex+aQbXb5UAamx4QzBNWF9GM/srVlzi7Finwc7l85
 uHDRKiMK3DlnQETUBEos58ab0F6l1m/WqEREPZSi7FKM48/PS+6rFosMvAW6hofbIi7vxaMDdry
 /pY6dywEMkXg03SnT0dtiZizAHXo7p8RutMTLGJ+gpQHPD+hw8KYwfwcv
X-Gm-Gg: AfdE7cnlg6Tl0QTrRj6NId7D8xNhCMsU0cn5pToBkoIk1vpiqP3T52nITAin7kNtLAQ
 WQoNj+62s0i2qL0tiwYMcxoe477l8lwE3SVLrsnTvK+atSRt5+ZfsUz9Hf8thHIA7Noh3kHMazj
 oamEctG+yZcacCBYiK6axhWOADbR+LqVxKzRFIwlVe1FEkP5uQE8BsJtq6zcepuPcQFxSlw+0jJ
 wlUATC89ZZb/qFxyjvwhzIy5dvShCC13MYigUN9qaEo94rePGQG3LmDRdaXpD8hmwvr5SC7EqP3
 kEJDuryF3wP7Q2cFT51uV5pb8zO8A8JMsmxJSfZwMJPzQarmCO0B2khqSnxjnoUKs7VE9EZtnuw
 6bgWpUB8KXuE4ERmhs/W5ZM8ZsjoLPn8XoPfCUuYAa6A4z4MqkhuQ9w8ZCW5YgmoW7ZNDzg==
X-Received: by 2002:a05:6214:3b86:b0:8f0:275e:8b3a with SMTP id
 6a1803df08f44-904017824b2mr198428596d6.48.1784131277887; 
 Wed, 15 Jul 2026 09:01:17 -0700 (PDT)
X-Received: by 2002:a05:6214:3b86:b0:8f0:275e:8b3a with SMTP id
 6a1803df08f44-904017824b2mr198413316d6.48.1784131264511; 
 Wed, 15 Jul 2026 09:01:04 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ffd87cad3csm196768556d6.48.2026.07.15.09.00.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 09:01:00 -0700 (PDT)
Date: Wed, 15 Jul 2026 12:00:55 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 jasowang@redhat.com, armbru@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com, yc-core@yandex-team.ru,
 mark.caveayland@nutanix.com
Subject: Re: [PATCH v19 00/15] virtio-net: live-TAP local migration
Message-ID: <aleut_YyeS_YeYus@x1.local>
References: <20260714154246.1242856-1-vsementsov@yandex-team.ru>
 <fa53bef0-4fbd-445a-9395-379bbfcb3773@tls.msk.ru>
 <20260715114802-mutt-send-email-mst@kernel.org>
 <ales0BaHaS0ZgA2d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ales0BaHaS0ZgA2d@redhat.com>
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=peterx@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, Jul 15, 2026 at 04:52:48PM +0100, Daniel P. Berrangé wrote:
> On Wed, Jul 15, 2026 at 11:48:40AM -0400, Michael S. Tsirkin wrote:
> > On Wed, Jul 15, 2026 at 06:01:39PM +0300, Michael Tokarev wrote:
> > > On 14.07.2026 18:42, Vladimir Sementsov-Ogievskiy wrote:
> > > > Hi all!
> > > > 
> > > > Here is a migration for TAP net backend, including its properties and
> > > > open fds.
> > > > 
> > > > With this new feature, management software doesn't need to initialize
> > > > new TAP and do a switch to it. Nothing should be done around
> > > > virtio-net in local migration: it just migrates and continues to use
> > > > same TAP device. So we avoid extra logic in management software, extra
> > > > allocations in kernel (for new TAP), and corresponding extra delay in
> > > > migration downtime.
> > > 
> > > This is quite a big patch set, - is this really worth the effort to do
> > > all this just for *local* migration?  What's the possible use case for
> > > this in real, - am I right this is just about upgrading the host qemu?
> > > And with that in mind, isn't it sufficient to use what we already have
> > > (namely, create new tap, start new qemu instance, and migrate the usual
> > > way), and tolerate some very minor downtime while the networking code
> > > learns the new network topology (isn't it happening almost instantly
> > > anyway, and if not, the management can help by sending gratitious ARP)?
> > > 
> > > I wonder what's the use for this at yandex?
> > > 
> > > Thanks,
> > > 
> > > /mjt
> > 
> > Well just theoretically, imagine a big VM, reserving twice the amount
> > of memory just to migrate is not nice at all.
> 
> Don't we already have the ability to skip memory transfer by setting
> the "x-ignore-shared" capability, assuming the VM RAM has a shared
> memory backing.

Right, IIUC all similar single-host migrations like this series or CPR (or
anything else...) should always need to enable x-ignore-shared in the first
place.  That's almost always the starting point of optimizing local
migrations.. no matter how the memory will be shared (by the same pool of
page cache, or persisted over kexec, etc.).

Thanks,

-- 
Peter Xu


