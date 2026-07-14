Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02DF9C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 08:03:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjY6n-00088o-4v; Tue, 14 Jul 2026 04:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wjY6l-00083Y-4Q
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 04:03:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wjY6i-0004LT-AR
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 04:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784016190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qEGXvmXuRO6w+1cXuRbiLY5ajiZATiFQrDJxRS4ZV6M=;
 b=cFtQ1W8Pxojm1PGaQDvSTKC6zkU2FygSz2UXHq64myqCpevRTa1qU8sJtHLd8+OYHg821a
 tFQmbNay8Cxk1FyQ9bBQ7FkRyApLuFA0SJ2MvBpw7uAp67qs2ctx+LqOegHo6qZ7LMEhbN
 I7V2Zahc3VXyCNm62GCJoyV0NCegDrs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-IvuYuKADNbG50vkL9sVx6A-1; Tue, 14 Jul 2026 04:03:09 -0400
X-MC-Unique: IvuYuKADNbG50vkL9sVx6A-1
X-Mimecast-MFC-AGG-ID: IvuYuKADNbG50vkL9sVx6A_1784016188
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490a767c7dcso31248695e9.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 01:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784016188; x=1784620988; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qEGXvmXuRO6w+1cXuRbiLY5ajiZATiFQrDJxRS4ZV6M=;
 b=WMn2EKxPqbbpcSeFPFoVo/YSbGwoxFSnVU1966SUlaxEv+4KBsuEWiMTdhnrGufWJ/
 Gkej+T1yo1Vg6+xQPpPanGKzqL+fBUXG08busCpBDvn+eZr//wMU2xKCEigDg9bj3XrT
 vwAmgViP1R9CBr7gfhhpg1oeVjs8h/rtPmHpRWbXVmsX7bJvAxpApeK01e6SgatE1dYB
 ej1kHU5KqLCkZmoCoIdAJQc8U2gXcN2XCG3yVjhzMQ4KPlaLbBwlGXPbhzsznrdrdsUz
 f9IJgOsbkcU90VcsEOyXVzkjVWs6aMfuyuZwOzwKgMznzz0xVmHtaYuzUnXiNAfQqWwU
 k2yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784016188; x=1784620988;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qEGXvmXuRO6w+1cXuRbiLY5ajiZATiFQrDJxRS4ZV6M=;
 b=o7+0LvZEbOoeMMU7HcBYBVaWezvIawq6sT2PjSFaDfXcyatqVWfKbomp6c9eO+7/Pu
 Bk3A6tPYkx0AWF0EqnMNgSAiRws+bxo5gffdpsP88eWgHr5Uk/SF8+t79HI72XMzAarl
 T4aOSwPqQBDOVwGZtofxN22mtidEpzwIAqSmM33ATL/UzjRPXsgjP7v5QsbciZGjgN4r
 /OHwFb3pN+uBsBUkpDzCOH56PbgwiLdFTLzpq5j0d3ARGgRF4i37nor1TFb0wA6gycKo
 rF3e0z4c48Txd28+jWG03N7D5ZrVn6JZHQtgKHmb9tXtAGihu6El2VmeLMS7GKUjblWq
 iw2Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqv6IIEAAc4NaE7eDRarXZYPrvq3aGggrNyhtVdN5h0W6pvBD71IbNvUOlphzmU6ZZ67Tjx1aBMQ5Ln@nongnu.org
X-Gm-Message-State: AOJu0YxozZDZ9kH1jT+YNPWYZ/G8zwkGmNYB9qNfOhz5Dx1eWFyBwSiO
 YHh6KQGTJXOK1nvpGKbxOWqj4AxSu43k7Fz5W9rH+9ny/TyYruiQJxnBk+90TAdcNNOnOVAne7/
 nv78jbDPLj3ttO92a58LjCZ3e4o1qMAug8lZrwL8GJ9Xyeb5pkHjSd32M
X-Gm-Gg: AfdE7cnUD9k9kS6vKZ6YOOYD+F4JctZHGXHfgS3X+HxamVLs/LTvd3Brpq5FTLI44lW
 G6gYA7xwQBbHRKY89xXN5jmEJ57tyz4wMR0gDXAskxL5DoazPG4GFlw9MlPjrl4oEJNfiMgOH0c
 UwkBbHauvhOiCVaBgNGrguvzUtRuiDQ3gGjXABQMLjEFWoxFXl6wV7lWkG3X1kiUQ963zTg7bm0
 YCs++5Dl5fQpahyQHjO/31vFu+Iyd3jNgGXJgDgpdxKoUysEkw+XrTXJKDo6fesJ4qjnh9O3TXn
 vuczojMW3MqazG7vn3jcnCD7BuzuP/o3HzcBfGxibzD2MNCQWXD4uHp3qmwZxvx0vy7075LG279
 r23c46Awqc0W82CWiTv4QCUoCUyjO2XtWt/0=
X-Received: by 2002:a05:600c:4693:b0:493:a6b7:cae5 with SMTP id
 5b1f17b1804b1-493f883173fmr122350915e9.28.1784016187910; 
 Tue, 14 Jul 2026 01:03:07 -0700 (PDT)
X-Received: by 2002:a05:600c:4693:b0:493:a6b7:cae5 with SMTP id
 5b1f17b1804b1-493f883173fmr122350105e9.28.1784016187227; 
 Tue, 14 Jul 2026 01:03:07 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-24-117.inter.net.il. [80.230.24.117])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4950a2e98b0sm107671795e9.8.2026.07.14.01.03.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 01:03:06 -0700 (PDT)
Date: Tue, 14 Jul 2026 04:03:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 jasowang@redhat.com, armbru@redhat.com, peterx@redhat.com,
 farosas@suse.de, raphael.s.norwitz@gmail.com, bchaney@akamai.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com, yc-core@yandex-team.ru,
 mark.caveayland@nutanix.com, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v18 09/14] qapi: add local migration parameter
Message-ID: <20260714040236-mutt-send-email-mst@kernel.org>
References: <20260710191809.721154-1-vsementsov@yandex-team.ru>
 <20260710191809.721154-10-vsementsov@yandex-team.ru>
 <alS1DMD_pRrklFRb@redhat.com>
 <05c89310-7bec-4aac-addc-b5ef377e09a7@yandex-team.ru>
 <alTKMA87h9x951Ei@redhat.com>
 <25b5e9a6-e563-4ab0-9075-04a3a00d3b33@yandex-team.ru>
 <alUwflog7Xd34Vd4@redhat.com>
 <20260713162057-mutt-send-email-mst@kernel.org>
 <37a769c6-b70d-4452-bdbc-d37a7ebcc732@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <37a769c6-b70d-4452-bdbc-d37a7ebcc732@yandex-team.ru>
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

On Tue, Jul 14, 2026 at 09:50:34AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 13.07.26 23:22, Michael S. Tsirkin wrote:
> > On Mon, Jul 13, 2026 at 07:37:50PM +0100, Daniel P. Berrangé wrote:
> > > On Mon, Jul 13, 2026 at 08:55:37PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > > On 13.07.26 14:21, Daniel P. Berrangé wrote:
> > > > > On Mon, Jul 13, 2026 at 01:55:48PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > > > > On 13.07.26 12:51, Daniel P. Berrangé wrote:
> > > > > > > On Fri, Jul 10, 2026 at 10:17:58PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > > > > > > We are going to implement local-migration feature: some devices will be
> > > > > > > > able to transfer open file descriptors through migration stream (which
> > > > > > > > must UNIX domain socket for that purpose).  This allows to transfer the
> > > > > > > > whole backend state without reconnecting and restarting the backend
> > > > > > > > service. For example, virtio-net will migrate its attached TAP netdev,
> > > > > > > > together with its connected file descriptors.
> > > > > > > > 
> > > > > > > > In this commit we introduce a migration parameter, which enables
> > > > > > > > the feature for devices that support it (none at the moment).
> > > > > > > > 
> > > > > > > > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> > > > > > > > Acked-by: Markus Armbruster <armbru@redhat.com>
> > > > > > > > Acked-by: Peter Xu <peterx@redhat.com>
> > > > > > > > Reviewed-by: Ben Chaney <bchaney@akamai.com>
> > > > > > > > ---
> > > > > > > >     include/migration/misc.h |  2 ++
> > > > > > > >     migration/options.c      | 18 +++++++++++++++++-
> > > > > > > >     qapi/migration.json      | 12 ++++++++++--
> > > > > > > >     3 files changed, 29 insertions(+), 3 deletions(-)
> > > > > > > 
> > > > > > > 
> > > > > > > > diff --git a/qapi/migration.json b/qapi/migration.json
> > > > > > > > index 66bd900465a..03bdf19f3a6 100644
> > > > > > > > --- a/qapi/migration.json
> > > > > > > > +++ b/qapi/migration.json
> > > > > > > > @@ -830,7 +830,8 @@
> > > > > > > >                'zero-page-detection',
> > > > > > > >                'direct-io',
> > > > > > > >                { 'name': 'x-rdma-chunk-size', 'features': [ 'unstable' ] },
> > > > > > > > -           'cpr-exec-command'] }
> > > > > > > > +           'cpr-exec-command',
> > > > > > > > +           'local'] }
> > > > > > > >     ##
> > > > > > > >     # @migrate-set-parameters:
> > > > > > > > @@ -1012,6 +1013,12 @@
> > > > > > > >     #     Must be set to the same value on both source and destination
> > > > > > > >     #     before migration starts.  (Since 11.1)
> > > > > > > >     #
> > > > > > > > +# @local: Enable local migration for devices that support it.  Backend
> > > > > > > > +#     state and its file descriptors can then be passed to the
> > > > > > > > +#     destination in the migration channel.  The migration channel
> > > > > > > > +#     must be a Unix domain socket.  Usually needs to be enabled per
> > > > > > > > +#     device.  (Since 11.2)
> > > > > > > 
> > > > > > > What happens when this is enabled and there are devices which
> > > > > > > don't support it ?
> > > > > > 
> > > > > > These devices are migrated as usual, ignoring "local" option.
> > > > > > 
> > > > > > > 
> > > > > > > What happens when this is enabled and a device on the src
> > > > > > > does not support it but a device on the (newer) QEMU dest
> > > > > > > does support it ?  How does the mgmt app know which devices
> > > > > > > support it ?
> > > > > > 
> > > > > > The only supporting device (TAP-backend) declares support by
> > > > > > "local-migration-supported", so mgmt app should care to set
> > > > > > same value for it on host and target (like for other options
> > > > > > actually). Or simply relay on default, which is true starting
> > > > > > from 11.2 Machine Type.
> > > > > > 
> > > > > > > 
> > > > > > > Can we document the semantics in these cases.
> > > > > > 
> > > > > > That's: "Usually needs to be enabled per device."
> > > > > 
> > > > > ....except that we have it enabled by default for TAP backends
> > > > > in new machine types.... except that it will then break if the
> > > > > app/user has enabled any of the "forbidden" options.
> > > > > 
> > > > > The way this doc is written makes it sound like "local" is an
> > > > > optimization you can turn on in any scenario, and it will do
> > > > > the right thing if the device supports it. That is very much
> > > > > not the case - enabling this flag will definitely break many
> > > > > configs out of the box, with new machine types due to the TAP
> > > > > device defaults & incompatible options.
> > > > 
> > > > Ok, now we decided to NOT make default support for TAP in newer
> > > > machine types.
> > > > 
> > > > So, enabling "local" is safe in existing scenarios, only explicit
> > > > enabling TAP.local-migration-supported will change the behavior.
> > > > 
> > > > Keep "local" documentation as is?
> > > > 
> > > > I see the only way to make it more informative: directly describe
> > > > connection with TAP.local-migration-supported, without general
> > > > phrases about "devices that support" and "usual". We'll have to
> > > > update it when more devices added (my next step is vhost-user-blk),
> > > > but at least, it would be absolutely correct at the moment.
> > > 
> > > How about....
> > > 
> > >   # @local: Permit the use of optimizations for local migration.
> > >   #     This must only be set when both the source and destination
> > >   #     QEMU processes are on the same OS and directly connected
> > >   #     with a UNIX domain socket as the migration channel to enable
> > >   #     use of file descriptor passing. Individual device backends
> > >   #     may need additional configuration flags set  to enable local
> > >   #     migration optimizations. This will be documented against the
> > >   #     device backends where it applies. (Since 11.2)
> > > 
> > 
> > BTW surely qemu can just detect this? getsockname maybe?
> > 
> 
> Yes, but this doesn't guarantee that it's a direct connection by UNIX
> socket to target, and it really can pass FDs. UNIX socket may be only
> a first part of transfer channel to the remote target.

Sure, but that's not a reason not to check so we can fail early.


> -- 
> Best regards,
> Vladimir


