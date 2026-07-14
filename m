Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF95C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 08:03:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjY6G-0007si-Nc; Tue, 14 Jul 2026 04:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wjY6F-0007sN-5Y
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 04:02:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wjY6C-0004Fs-7O
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 04:02:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784016157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SWVFMPsOp0q/GB1rZbN3lvYM1v6exgL1r3bquD/XSJg=;
 b=PWtQunCmWYLWabvCddmRJNdRY5hkHGE4Qj12QdsiW43GwcYn+3Kp1asMYGe6FxIC12iFaj
 5FO6ky0h4ZxlTXN9XD9iQyz0qf7fSP9XuQtSG9+pxWBoN34GuB7Fn3tjs7sSfqhfWQCmwP
 7p6YZgOxQrxTW66hUyMAV6hTD3B6DA4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-gyRMiSqUMbiAmLC_POb1Tw-1; Tue, 14 Jul 2026 04:02:35 -0400
X-MC-Unique: gyRMiSqUMbiAmLC_POb1Tw-1
X-Mimecast-MFC-AGG-ID: gyRMiSqUMbiAmLC_POb1Tw_1784016154
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-47eaa4006a1so367532f8f.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 01:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784016154; x=1784620954; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SWVFMPsOp0q/GB1rZbN3lvYM1v6exgL1r3bquD/XSJg=;
 b=lp8kQYQjXoWcpCFPjoSUbZAy2E1HPkKjhoHUekjitnwcOzAEqY7kpxYfuZ7n5c0Gs3
 L8FSb6cbpcfH4G0XvrZMV846j4CGYJItIb9eyKaGX5Vm/48YaEQ7MmmxA7+F0tV9BTet
 fJZbsLLWopOISBRfKx/P3KNGjBBb0sCDlxxjfOqAOCUut1tgPnJKIkeRFWbTUy2diqR+
 qVpp+du8EWVOT12Y8RG80sNWZlmq6ZGWenxnK9lIQtthNXkCKopLvcWmWfkFo23vVf8m
 VSwitix4rrO5bQsJVecx4yVbmUjPS280JadntpFDHkU9iA2qig9zWv7CzRp44bDoI4Zj
 zsPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784016154; x=1784620954;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SWVFMPsOp0q/GB1rZbN3lvYM1v6exgL1r3bquD/XSJg=;
 b=Rzm7sraESXIMJW0/0vJ0N4ebjKYquSaPiCxjn1emg6/jedKZbkuGgGf0dAXEtylLSK
 0CXlDIkSorXW4CArP/X1LuV5mro0lfYahk4ppzdMYXZKyva2TId0X0c4KCHiYhSgwXZl
 GPqmZrplCb7XJwWR7zSn298Cqdn00pPZHIWNYeznhdp6/vEs8kgZ1gN9P70IOo5LfMm6
 raiJKip386nPlfz/5PZCjMIi4cpewXE1FwlfCN1V5fXw54Q+7Hh8UQTLar/i+HU7KaEB
 uZ9w9Sf8Nv1zYtGH41p091tNAeIsBlXt5h2HdQuLG6GNdro6Oyi9VJW9SwXQFRgibYgi
 3Iuw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoKhMdDvQ/u22mhaR02Cxv2Ut/Xdj7h/VqyX51u9qNKa8pBf99AC956O1qjDafnqZc8HUI2+DYy1n2S@nongnu.org
X-Gm-Message-State: AOJu0Yxkv2ECfly/0aUwmYZfAXFNAvGdgVcveA0f0XmN0/2XSKXH5ZxP
 z9JX9YOsHALrtpUKRpqJOgJSTVbIQ9verfn5NbwMRquTbBSAM6Ozaggeg0fP7t8uxCaORx7pLJ5
 ZEuW+sjuHLRcdgty39DrDzGxKcV3u7Mjki7WleamhTPw0ReEZi7A71ahG
X-Gm-Gg: AfdE7cnLDzwjR6F5EaCU3/v//3PDBWKsk0WdEE81Kkw9mWW7FgG8LvAqUVK5MoR6zhj
 g6Rx1HCQ8s3hwK0KWPI74UwX6tPVfAk9CuQbXsAvLgjhWOCXauGw9/KTlyeyClLTGP5FiRbsfIk
 xj6vK3XMkDJhnU+PWgOjm5RPA2/J4CwS7BDX/90FCaaOyOTBHyX8Yw/q1jXvzu6gNph4m3T8pe4
 8qXEgCMLG8y3hvHPN765yC4YSI4sQ5IzrBwbbpq2Auk4C70zdgfm4PL1bjGXdsl8s0fLobhMgrT
 g8G6FypfLvgq7tLwYwyTOSz28d1zVQha6YxJgCYIOXMGw62UMzC3rrWOC2ntk25fUz1Ir61+XST
 nWsZRstfIF5+AVZ0TmEV5GSn3LzJq7GfkkZ4=
X-Received: by 2002:a05:6000:29d8:b0:47f:40f3:88bc with SMTP id
 ffacd0b85a97d-47f40f38950mr4921017f8f.19.1784016154069; 
 Tue, 14 Jul 2026 01:02:34 -0700 (PDT)
X-Received: by 2002:a05:6000:29d8:b0:47f:40f3:88bc with SMTP id
 ffacd0b85a97d-47f40f38950mr4920959f8f.19.1784016153360; 
 Tue, 14 Jul 2026 01:02:33 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-24-117.inter.net.il. [80.230.24.117])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464a974csm7533090f8f.18.2026.07.14.01.02.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 01:02:32 -0700 (PDT)
Date: Tue, 14 Jul 2026 04:02:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 jasowang@redhat.com, armbru@redhat.com, peterx@redhat.com,
 farosas@suse.de, raphael.s.norwitz@gmail.com, bchaney@akamai.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com, yc-core@yandex-team.ru,
 mark.caveayland@nutanix.com, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v18 09/14] qapi: add local migration parameter
Message-ID: <20260714035918-mutt-send-email-mst@kernel.org>
References: <20260710191809.721154-1-vsementsov@yandex-team.ru>
 <20260710191809.721154-10-vsementsov@yandex-team.ru>
 <alS1DMD_pRrklFRb@redhat.com>
 <05c89310-7bec-4aac-addc-b5ef377e09a7@yandex-team.ru>
 <alTKMA87h9x951Ei@redhat.com>
 <25b5e9a6-e563-4ab0-9075-04a3a00d3b33@yandex-team.ru>
 <alUwflog7Xd34Vd4@redhat.com>
 <20260713162057-mutt-send-email-mst@kernel.org>
 <alXiLqaMV6v73O2E@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alXiLqaMV6v73O2E@redhat.com>
Received-SPF: permerror client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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

On Tue, Jul 14, 2026 at 08:55:28AM +0100, Daniel P. Berrangé wrote:
> On Mon, Jul 13, 2026 at 04:22:03PM -0400, Michael S. Tsirkin wrote:
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
> > > > > > > >    include/migration/misc.h |  2 ++
> > > > > > > >    migration/options.c      | 18 +++++++++++++++++-
> > > > > > > >    qapi/migration.json      | 12 ++++++++++--
> > > > > > > >    3 files changed, 29 insertions(+), 3 deletions(-)
> > > > > > > 
> > > > > > > 
> > > > > > > > diff --git a/qapi/migration.json b/qapi/migration.json
> > > > > > > > index 66bd900465a..03bdf19f3a6 100644
> > > > > > > > --- a/qapi/migration.json
> > > > > > > > +++ b/qapi/migration.json
> > > > > > > > @@ -830,7 +830,8 @@
> > > > > > > >               'zero-page-detection',
> > > > > > > >               'direct-io',
> > > > > > > >               { 'name': 'x-rdma-chunk-size', 'features': [ 'unstable' ] },
> > > > > > > > -           'cpr-exec-command'] }
> > > > > > > > +           'cpr-exec-command',
> > > > > > > > +           'local'] }
> > > > > > > >    ##
> > > > > > > >    # @migrate-set-parameters:
> > > > > > > > @@ -1012,6 +1013,12 @@
> > > > > > > >    #     Must be set to the same value on both source and destination
> > > > > > > >    #     before migration starts.  (Since 11.1)
> > > > > > > >    #
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
> > >  # @local: Permit the use of optimizations for local migration.
> > >  #     This must only be set when both the source and destination
> > >  #     QEMU processes are on the same OS and directly connected
> > >  #     with a UNIX domain socket as the migration channel to enable
> > >  #     use of file descriptor passing. Individual device backends
> > >  #     may need additional configuration flags set  to enable local
> > >  #     migration optimizations. This will be documented against the
> > >  #     device backends where it applies. (Since 11.2)
> > > 
> > 
> > BTW surely qemu can just detect this? getsockname maybe?
> 
> QEMU might be given a UNIX socket that connects to a MITM proxy
> that then uses TCP to reach the dest QEMU.

We could try to exchange FDs and see it it works I guess.

But anyway, my point is QEMU should validate it,
even if that's not enough of a signal to fully trust.

> With regards,
> Daniel
> -- 
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


