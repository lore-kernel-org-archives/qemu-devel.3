Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A1AC3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 02:29:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZLYl-0007hw-6t; Wed, 31 Jul 2024 22:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sZLYi-0007hA-UN
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 22:28:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sZLYh-0006Ec-3U
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 22:28:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722479329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ymiMFPu/Ln/A7vr6W8lz7URLp1VgCsTuloa5OhCdEHI=;
 b=ZApva884Uy7N7GN9hstK9WxRkVeRnxRHGcgQfWfiW032iM2O+4lsNhKQ43rZdeXdtwaiGp
 Aj7RvrUSGo7pPA4ghRYkl6ET/LrPpYMC2l+78cFM0SDQUqPmzhZlgWGIVNs5UDIiosV9St
 wlavns9b+iaMujtp2bmUpvssk0tdUig=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-Hn36HVeFMpaZ-M-BNEamTA-1; Wed, 31 Jul 2024 22:28:44 -0400
X-MC-Unique: Hn36HVeFMpaZ-M-BNEamTA-1
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-4929c8fd8e8so2992165137.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 19:28:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722479323; x=1723084123;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ymiMFPu/Ln/A7vr6W8lz7URLp1VgCsTuloa5OhCdEHI=;
 b=FPXVvcBS49iz6KX8kKZOzJdedXwKwV/fS75EutqvRSUVRxq7Eo+hZ63aHmnpXOttqM
 QYZflt+Z/MbRqlVrIRjXJvu0gI6O3hO1Uh6GKUYwzYisXwmRkZOt10SfLqapEdG6sEX5
 I2mRW8C5R0lAYlFYRYwpjLR7MJ1E7Hv3zZmADYqHxJVYF6LeRVSWoanwvGTSBlnR8t/f
 Bv0E5LLU/jlLJvpR91sPjiREUASu3LHodiVwVQcfPsoOnykLrgVPmxaJnd6BlcymWmK0
 KecoVBW8rB33Hh21vk3tgckfJHLubQQHyt821ji0eIjoDU5cHQL+BGK+34UkjKxBRwf9
 sZBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmCwwZS/vwS7RjN5yBSPTMqxKfsgCedQ41EqFj/L45dD/UTm7PUb7/GwC2ovYRV473v9KbKP9D/fVZ@nongnu.org
X-Gm-Message-State: AOJu0YzS5NCuVZZK3ys2cRGXLoxAdKu3soHgITryxJEozOhM3CWoSKkt
 dDBM/A8mqPpBTHsWFFTG2OkB7z9q9Gdgju7o1Zt/QI51jdC6E1XmqZ85OvGppmhEw1MLg2gLBVZ
 RWSpBsIkr/AzRKz59vyUTpzgcCGqUISUQXNubDF06JvSmwr2uNnNvbROk+rvnRK9X8RJylH7Vmd
 KYn2n9mBj+A0+GydR+YTZTkTAEEC0=
X-Received: by 2002:a05:6102:304c:b0:48f:95aa:ae2b with SMTP id
 ada2fe7eead31-4945099d090mr1531969137.28.1722479323467; 
 Wed, 31 Jul 2024 19:28:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcBRZNxsxml0k63ZF1d4zXbJm3mqZ7TyRjS/J1evjjP5DFqb+3kEmujoodLaE1qeXqmgTLOfT+R2Q3VNSKOs0=
X-Received: by 2002:a05:6102:304c:b0:48f:95aa:ae2b with SMTP id
 ada2fe7eead31-4945099d090mr1531944137.28.1722479323042; Wed, 31 Jul 2024
 19:28:43 -0700 (PDT)
MIME-Version: 1.0
References: <ZqfKrtQSSRVnEOGt@x1n> <ZqfQ0cGf8t2trEdl@redhat.com>
 <ZqktXwxBWjuAgGxZ@x1n> <Zqk09BGxlpdxMBMx@redhat.com> <Zqk6x2nd3Twz--75@x1n>
 <20240730151746-mutt-send-email-mst@kernel.org> <ZqlHKaQXzKGcnoBM@x1n>
 <20240730172148-mutt-send-email-mst@kernel.org> <Zqnh-AJC4JPl5EkS@redhat.com>
 <20240731033803-mutt-send-email-mst@kernel.org> <Zqo00Na1MZpksY9A@x1n>
In-Reply-To: <Zqo00Na1MZpksY9A@x1n>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 1 Aug 2024 10:28:25 +0800
Message-ID: <CACGkMEuM+nONim_gNsjgxu9R+0=vcKGx7SQaTGMOoczL6666fw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
To: Peter Xu <peterx@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>,
 eduardo@habkost.net, 
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com, 
 dmitry.fleytman@gmail.com, akihiko.odaki@daynix.com, 
 sriram.yagnaraman@est.tech, sw@weilnetz.de, qemu-devel@nongnu.org, 
 yan@daynix.com, Fabiano Rosas <farosas@suse.de>, devel@lists.libvirt.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
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

On Wed, Jul 31, 2024 at 8:58=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Jul 31, 2024 at 03:41:00AM -0400, Michael S. Tsirkin wrote:
> > On Wed, Jul 31, 2024 at 08:04:24AM +0100, Daniel P. Berrang=C3=A9 wrote=
:
> > > On Tue, Jul 30, 2024 at 05:32:48PM -0400, Michael S. Tsirkin wrote:
> > > > On Tue, Jul 30, 2024 at 04:03:53PM -0400, Peter Xu wrote:
> > > > > On Tue, Jul 30, 2024 at 03:22:50PM -0400, Michael S. Tsirkin wrot=
e:
> > > > > > This is not what we did historically. Why should we start now?
> > > > >
> > > > > It's a matter of whether we still want migration to randomly fail=
, like
> > > > > what this patch does.
> > > > >
> > > > > Or any better suggestions?  I'm definitely open to that.
> > > > >
> > > > > Thanks,
> > > > >
> > > > > --
> > > > > Peter Xu
> > > >
> > > > Randomly is an overstatement. You need to switch between kernels
> > > > where this feature differs. We did it with a ton of features
> > > > in the past, donnu why we single out USO now.
> > >
> > > This has been a problem with a ton of features in the past. We've
> > > ignored the problem, but that doesn't make it the right solution
> > >
> > > With regards,
> > > Daniel
> >
> > Pushing it to domain xml does not really help,
> > migration will still fail unexpectedly (after wasting
> > a ton of resources copying memory, and getting
> > a downtime bump, I might add).
>
> Could you elaborate why it would fail if with what I proposed?
>
> Note that if this is a generic comment about "any migration can fail if w=
e
> found a device mismatch", we have plan to fix that to some degree. It's
> just that we don't have enough people working on these topics yet. See:
>
> https://wiki.qemu.org/ToDo/LiveMigration#Migration_handshake
>
> It includes:
>
>  "Check device tree on both sides, etc., to make sure the migration is
>   applicable. E.g., we should fail early and clearly on any device
>   mismatch."
>
> However I don't think it'll cover all checks, e.g. I _think_ even if we
> verify VMSDs then post_load() hooks can still fail, and there can be some
> corner cases to think.  And of course, this may not even apply to virtio
> since virtio manages migration itself, without providing a top-level vmsd=
.
>
> >
> > The right solution is to have a tool that can query
> > backends, and that given the results from all of the cluster,
> > generate a set of parameters that will ensure migration works.

This seems to be very hard for vhost-users.

> > Kind of like qemu-img, but for migration.
>
> This is adding extra work, IMHO.
>
> If we stick with "qemu cmdline as guest ABI" concept, I think we're all
> fine, as that work is done by QEMU booting up first on both sides,
> including dest.

Probably, letting Qemu to probe is much easier than rewriting the
probe in the upper layer.

>  Basically Libvirt already plays this role of the new tool
> without any new code to be added at all: what captured on the boot failur=
e
> log will be the output of that tool if we write it.
>
> Thanks,

Thanks

>
> --
> Peter Xu
>


