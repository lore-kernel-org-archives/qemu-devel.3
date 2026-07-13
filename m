Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C46C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 20:22:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjNAO-0004jI-MA; Mon, 13 Jul 2026 16:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wjNAN-0004ix-K4
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 16:22:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wjNAL-0001Tp-6s
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 16:22:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783974131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X37tg6xaiqQrNkzkLwXV64QQxDF0bDFORgAU6jUvxUk=;
 b=Qb9spWkJOwMASyVTWjgdGPA96P5GQDoySk+Czf3PXQCwQBVC93qaYhy6wxnRRenonLkLD/
 sjqn13ZcLrugrGAjFX2COqD0LbxwykyQzmAqVEudFYL7DIdkJz18oKzrIDY0eTFoa1Dq4k
 AfR4oungqnwK6+pmnHk8jGfd6FOcAeI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-3B0uaI7LNiaLElORqz42Hg-1; Mon, 13 Jul 2026 16:22:10 -0400
X-MC-Unique: 3B0uaI7LNiaLElORqz42Hg-1
X-Mimecast-MFC-AGG-ID: 3B0uaI7LNiaLElORqz42Hg_1783974129
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-493f75ebec5so21988115e9.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 13:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783974129; x=1784578929; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=X37tg6xaiqQrNkzkLwXV64QQxDF0bDFORgAU6jUvxUk=;
 b=PfTrqEdEPQqzOZiu2bAK/WzM38q0bZg96Zit1uUBotkERX8urtdKGva+wihtv005pr
 20Ut1SpGpft3ghqPlX2LpA5pW181W6/LrHoxMOxJtanDfPaZlYB66EnZugcjHHOyxrV1
 O8hyxCYhOFDdLegdG7BWOz8KOB/QvfsRQ2CA/FWwLLcca31Vo8RwCp7o/ukqLbkX11po
 +jXRM328lIztHnKY9ODp+qqH0rx7mhLakC6Tc0qR9Jh17hRk9gKQYmS6EaLkVKz3DBlC
 i/AP67bNTt1fCYeid8hmjhTcujv66nhZ/F2Zp1Qa4+BgkQFZ0a9fKt2x4rM1OL7DxiKr
 yasA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783974129; x=1784578929;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=X37tg6xaiqQrNkzkLwXV64QQxDF0bDFORgAU6jUvxUk=;
 b=Yc2uE7XH+9Nd01rA6S0YzYnEhYYloE3ujvGfzQAXjJveyqKblCwvLeoiea5o7JodAe
 4nBZqSPLts4J3xT5qyaR0RHP0E2ZXP4BYhwM1poatMiE1S7Hf6qJz3ph15fyqLhHF4pM
 jMSq/Trjpqgts+TKyLmgPzcBZRFrjY5NWt1JJtXoBnxCEIX4XM9FhRf4J6oswyKt6WPU
 PfToIhsojO3gmegnuI1qzbWFQWHLinTeYzpF4NND1XULP7dCEUY3KPyPytp+zqgS2Wtd
 QziG+tHn2qxnIeSjE7/dzaIZjKD3362U9ZxzULgv5VVaVTvBGvGsMKr9BAYOg2Mr6Cdd
 +nvA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqGM3I/jk9Xj6sgVG8Mk3S2xjbkj3qCaS7m+TXiTCukw1uKab3GYESPvCvKHRmFarovNOYy22cVn+0g@nongnu.org
X-Gm-Message-State: AOJu0Yy1a0Jm0vMRya+CtWngCwwer5f3jmjuer2AJ5vhFr6WTGsSr0NF
 X1iNhz9Bf6EbhjNgmcFMJTuA/FymMmxpFIu4xGh/yhZlfCFvLkTTWlJZ1vaU2iSPWMpKzKsieN1
 /la/jgRnPfbePpVw522JHhFR94AF5AgBdwjwJcEwwuZJeY74F+RCu84T/
X-Gm-Gg: AfdE7cngDNcxUsNZmdwYNF4w2mzKaUqJbtg3zISJHbTsDrSKuXd2CJIi5gskR/bmWAe
 dZUOhmYEgx1ZVnVvPuvx9H6Wu/BBoC25v99U3SEnPCFUs5V4yNQ7xh7FhP/gpbbWUhG2MX/OKw/
 VIJvbAHLVeEm7OYs5EwCVVk2xz02KSpLEmt7Wcrk+U5Qx5DQZygbNnJpyu8qWOjir4UR0OTs3c+
 dvbd4wMfLjRfcRjyP71Qirq7DQjTXbsEGhJCtG4h4k/3iEHr/JqNkCJWqTjFXT5HPAgFuWn5PNZ
 6QMHVoXwfh4vcgZZaXzWz2y78srkJunLjy+i+YbzBKJEXi6DjAJKsZI0vn0M+XNwZhfkpJ7MeMe
 WPp0XiwxmFrgi/nNkXgHC+cAjW5tjh9tBhDQ=
X-Received: by 2002:a05:600c:3143:b0:493:b87c:c87d with SMTP id
 5b1f17b1804b1-493f87e9f43mr107559695e9.11.1783974128594; 
 Mon, 13 Jul 2026 13:22:08 -0700 (PDT)
X-Received: by 2002:a05:600c:3143:b0:493:b87c:c87d with SMTP id
 5b1f17b1804b1-493f87e9f43mr107559285e9.11.1783974127966; 
 Mon, 13 Jul 2026 13:22:07 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-24-117.inter.net.il. [80.230.24.117])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f2a38b19sm219251325e9.0.2026.07.13.13.22.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 13:22:07 -0700 (PDT)
Date: Mon, 13 Jul 2026 16:22:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 jasowang@redhat.com, armbru@redhat.com, peterx@redhat.com,
 farosas@suse.de, raphael.s.norwitz@gmail.com, bchaney@akamai.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com, yc-core@yandex-team.ru,
 mark.caveayland@nutanix.com, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v18 09/14] qapi: add local migration parameter
Message-ID: <20260713162057-mutt-send-email-mst@kernel.org>
References: <20260710191809.721154-1-vsementsov@yandex-team.ru>
 <20260710191809.721154-10-vsementsov@yandex-team.ru>
 <alS1DMD_pRrklFRb@redhat.com>
 <05c89310-7bec-4aac-addc-b5ef377e09a7@yandex-team.ru>
 <alTKMA87h9x951Ei@redhat.com>
 <25b5e9a6-e563-4ab0-9075-04a3a00d3b33@yandex-team.ru>
 <alUwflog7Xd34Vd4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alUwflog7Xd34Vd4@redhat.com>
Received-SPF: permerror client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Jul 13, 2026 at 07:37:50PM +0100, Daniel P. Berrangé wrote:
> On Mon, Jul 13, 2026 at 08:55:37PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > On 13.07.26 14:21, Daniel P. Berrangé wrote:
> > > On Mon, Jul 13, 2026 at 01:55:48PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > > On 13.07.26 12:51, Daniel P. Berrangé wrote:
> > > > > On Fri, Jul 10, 2026 at 10:17:58PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > > > > We are going to implement local-migration feature: some devices will be
> > > > > > able to transfer open file descriptors through migration stream (which
> > > > > > must UNIX domain socket for that purpose).  This allows to transfer the
> > > > > > whole backend state without reconnecting and restarting the backend
> > > > > > service. For example, virtio-net will migrate its attached TAP netdev,
> > > > > > together with its connected file descriptors.
> > > > > > 
> > > > > > In this commit we introduce a migration parameter, which enables
> > > > > > the feature for devices that support it (none at the moment).
> > > > > > 
> > > > > > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> > > > > > Acked-by: Markus Armbruster <armbru@redhat.com>
> > > > > > Acked-by: Peter Xu <peterx@redhat.com>
> > > > > > Reviewed-by: Ben Chaney <bchaney@akamai.com>
> > > > > > ---
> > > > > >    include/migration/misc.h |  2 ++
> > > > > >    migration/options.c      | 18 +++++++++++++++++-
> > > > > >    qapi/migration.json      | 12 ++++++++++--
> > > > > >    3 files changed, 29 insertions(+), 3 deletions(-)
> > > > > 
> > > > > 
> > > > > > diff --git a/qapi/migration.json b/qapi/migration.json
> > > > > > index 66bd900465a..03bdf19f3a6 100644
> > > > > > --- a/qapi/migration.json
> > > > > > +++ b/qapi/migration.json
> > > > > > @@ -830,7 +830,8 @@
> > > > > >               'zero-page-detection',
> > > > > >               'direct-io',
> > > > > >               { 'name': 'x-rdma-chunk-size', 'features': [ 'unstable' ] },
> > > > > > -           'cpr-exec-command'] }
> > > > > > +           'cpr-exec-command',
> > > > > > +           'local'] }
> > > > > >    ##
> > > > > >    # @migrate-set-parameters:
> > > > > > @@ -1012,6 +1013,12 @@
> > > > > >    #     Must be set to the same value on both source and destination
> > > > > >    #     before migration starts.  (Since 11.1)
> > > > > >    #
> > > > > > +# @local: Enable local migration for devices that support it.  Backend
> > > > > > +#     state and its file descriptors can then be passed to the
> > > > > > +#     destination in the migration channel.  The migration channel
> > > > > > +#     must be a Unix domain socket.  Usually needs to be enabled per
> > > > > > +#     device.  (Since 11.2)
> > > > > 
> > > > > What happens when this is enabled and there are devices which
> > > > > don't support it ?
> > > > 
> > > > These devices are migrated as usual, ignoring "local" option.
> > > > 
> > > > > 
> > > > > What happens when this is enabled and a device on the src
> > > > > does not support it but a device on the (newer) QEMU dest
> > > > > does support it ?  How does the mgmt app know which devices
> > > > > support it ?
> > > > 
> > > > The only supporting device (TAP-backend) declares support by
> > > > "local-migration-supported", so mgmt app should care to set
> > > > same value for it on host and target (like for other options
> > > > actually). Or simply relay on default, which is true starting
> > > > from 11.2 Machine Type.
> > > > 
> > > > > 
> > > > > Can we document the semantics in these cases.
> > > > 
> > > > That's: "Usually needs to be enabled per device."
> > > 
> > > ....except that we have it enabled by default for TAP backends
> > > in new machine types.... except that it will then break if the
> > > app/user has enabled any of the "forbidden" options.
> > > 
> > > The way this doc is written makes it sound like "local" is an
> > > optimization you can turn on in any scenario, and it will do
> > > the right thing if the device supports it. That is very much
> > > not the case - enabling this flag will definitely break many
> > > configs out of the box, with new machine types due to the TAP
> > > device defaults & incompatible options.
> > 
> > Ok, now we decided to NOT make default support for TAP in newer
> > machine types.
> > 
> > So, enabling "local" is safe in existing scenarios, only explicit
> > enabling TAP.local-migration-supported will change the behavior.
> > 
> > Keep "local" documentation as is?
> > 
> > I see the only way to make it more informative: directly describe
> > connection with TAP.local-migration-supported, without general
> > phrases about "devices that support" and "usual". We'll have to
> > update it when more devices added (my next step is vhost-user-blk),
> > but at least, it would be absolutely correct at the moment.
> 
> How about....
> 
>  # @local: Permit the use of optimizations for local migration.
>  #     This must only be set when both the source and destination
>  #     QEMU processes are on the same OS and directly connected
>  #     with a UNIX domain socket as the migration channel to enable
>  #     use of file descriptor passing. Individual device backends
>  #     may need additional configuration flags set  to enable local
>  #     migration optimizations. This will be documented against the
>  #     device backends where it applies. (Since 11.2)
> 

BTW surely qemu can just detect this? getsockname maybe?


> With regards,
> Daniel
> -- 
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


