Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B22E2C44501
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 08:19:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjYME-000260-2j; Tue, 14 Jul 2026 04:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wjYMA-00025l-2S
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 04:19:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wjYM0-0007YS-3P
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 04:19:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784017138;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ngaVO5UgeulUm/HAC8eIVltc3194YOxQ24ZCC7LfK84=;
 b=FkV+GToMXPTQyuwHX6hbCTbLUrk3II9saPY5lC6BqnSUc/iEvrN1iy/scrpRs9JObETjZ0
 FqTfeLNp9wLdnvGyS/z4qE97L+xITH1y6iT3glU5ELlXjVMGAoxe8fKPS+mNkV5XHrFYbD
 iRuGFnjQDR7WttvT4XKlFuHlvGjRH5o=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-417-UL6FeHSlNreg14oWXjNw-g-1; Tue,
 14 Jul 2026 04:18:57 -0400
X-MC-Unique: UL6FeHSlNreg14oWXjNw-g-1
X-Mimecast-MFC-AGG-ID: UL6FeHSlNreg14oWXjNw-g_1784017135
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C29A19560BD; Tue, 14 Jul 2026 08:18:55 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.163])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 44A32180049F; Tue, 14 Jul 2026 08:18:49 +0000 (UTC)
Date: Tue, 14 Jul 2026 09:18:46 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 jasowang@redhat.com, armbru@redhat.com, peterx@redhat.com,
 farosas@suse.de, raphael.s.norwitz@gmail.com, bchaney@akamai.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com, yc-core@yandex-team.ru,
 mark.caveayland@nutanix.com, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v18 09/14] qapi: add local migration parameter
Message-ID: <alXw5uA9RjQgv-kR@redhat.com>
References: <20260710191809.721154-1-vsementsov@yandex-team.ru>
 <20260710191809.721154-10-vsementsov@yandex-team.ru>
 <alS1DMD_pRrklFRb@redhat.com>
 <05c89310-7bec-4aac-addc-b5ef377e09a7@yandex-team.ru>
 <alTKMA87h9x951Ei@redhat.com>
 <25b5e9a6-e563-4ab0-9075-04a3a00d3b33@yandex-team.ru>
 <alUwflog7Xd34Vd4@redhat.com>
 <20260713162057-mutt-send-email-mst@kernel.org>
 <alXiLqaMV6v73O2E@redhat.com>
 <20260714035918-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260714035918-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=berrange@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jul 14, 2026 at 04:02:29AM -0400, Michael S. Tsirkin wrote:
> On Tue, Jul 14, 2026 at 08:55:28AM +0100, Daniel P. Berrangé wrote:
> > On Mon, Jul 13, 2026 at 04:22:03PM -0400, Michael S. Tsirkin wrote:
> > > On Mon, Jul 13, 2026 at 07:37:50PM +0100, Daniel P. Berrangé wrote:
> > > > On Mon, Jul 13, 2026 at 08:55:37PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > > > On 13.07.26 14:21, Daniel P. Berrangé wrote:
> > > > > > On Mon, Jul 13, 2026 at 01:55:48PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > > > > > On 13.07.26 12:51, Daniel P. Berrangé wrote:
> > > > > > > > On Fri, Jul 10, 2026 at 10:17:58PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > > > > > > > We are going to implement local-migration feature: some devices will be
> > > > > > > > > able to transfer open file descriptors through migration stream (which
> > > > > > > > > must UNIX domain socket for that purpose).  This allows to transfer the
> > > > > > > > > whole backend state without reconnecting and restarting the backend
> > > > > > > > > service. For example, virtio-net will migrate its attached TAP netdev,
> > > > > > > > > together with its connected file descriptors.
> > > > > > > > > 
> > > > > > > > > In this commit we introduce a migration parameter, which enables
> > > > > > > > > the feature for devices that support it (none at the moment).
> > > > > > > > > 
> > > > > > > > > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> > > > > > > > > Acked-by: Markus Armbruster <armbru@redhat.com>
> > > > > > > > > Acked-by: Peter Xu <peterx@redhat.com>
> > > > > > > > > Reviewed-by: Ben Chaney <bchaney@akamai.com>
> > > > > > > > > ---
> > > > > > > > >    include/migration/misc.h |  2 ++
> > > > > > > > >    migration/options.c      | 18 +++++++++++++++++-
> > > > > > > > >    qapi/migration.json      | 12 ++++++++++--
> > > > > > > > >    3 files changed, 29 insertions(+), 3 deletions(-)
> > > > > > > > 
> > > > > > > > 
> > > > > > > > > diff --git a/qapi/migration.json b/qapi/migration.json
> > > > > > > > > index 66bd900465a..03bdf19f3a6 100644
> > > > > > > > > --- a/qapi/migration.json
> > > > > > > > > +++ b/qapi/migration.json
> > > > > > > > > @@ -830,7 +830,8 @@
> > > > > > > > >               'zero-page-detection',
> > > > > > > > >               'direct-io',
> > > > > > > > >               { 'name': 'x-rdma-chunk-size', 'features': [ 'unstable' ] },
> > > > > > > > > -           'cpr-exec-command'] }
> > > > > > > > > +           'cpr-exec-command',
> > > > > > > > > +           'local'] }
> > > > > > > > >    ##
> > > > > > > > >    # @migrate-set-parameters:
> > > > > > > > > @@ -1012,6 +1013,12 @@
> > > > > > > > >    #     Must be set to the same value on both source and destination
> > > > > > > > >    #     before migration starts.  (Since 11.1)
> > > > > > > > >    #
> > > > > > > > > +# @local: Enable local migration for devices that support it.  Backend
> > > > > > > > > +#     state and its file descriptors can then be passed to the
> > > > > > > > > +#     destination in the migration channel.  The migration channel
> > > > > > > > > +#     must be a Unix domain socket.  Usually needs to be enabled per
> > > > > > > > > +#     device.  (Since 11.2)
> > > > > > > > 
> > > > > > > > What happens when this is enabled and there are devices which
> > > > > > > > don't support it ?
> > > > > > > 
> > > > > > > These devices are migrated as usual, ignoring "local" option.
> > > > > > > 
> > > > > > > > 
> > > > > > > > What happens when this is enabled and a device on the src
> > > > > > > > does not support it but a device on the (newer) QEMU dest
> > > > > > > > does support it ?  How does the mgmt app know which devices
> > > > > > > > support it ?
> > > > > > > 
> > > > > > > The only supporting device (TAP-backend) declares support by
> > > > > > > "local-migration-supported", so mgmt app should care to set
> > > > > > > same value for it on host and target (like for other options
> > > > > > > actually). Or simply relay on default, which is true starting
> > > > > > > from 11.2 Machine Type.
> > > > > > > 
> > > > > > > > 
> > > > > > > > Can we document the semantics in these cases.
> > > > > > > 
> > > > > > > That's: "Usually needs to be enabled per device."
> > > > > > 
> > > > > > ....except that we have it enabled by default for TAP backends
> > > > > > in new machine types.... except that it will then break if the
> > > > > > app/user has enabled any of the "forbidden" options.
> > > > > > 
> > > > > > The way this doc is written makes it sound like "local" is an
> > > > > > optimization you can turn on in any scenario, and it will do
> > > > > > the right thing if the device supports it. That is very much
> > > > > > not the case - enabling this flag will definitely break many
> > > > > > configs out of the box, with new machine types due to the TAP
> > > > > > device defaults & incompatible options.
> > > > > 
> > > > > Ok, now we decided to NOT make default support for TAP in newer
> > > > > machine types.
> > > > > 
> > > > > So, enabling "local" is safe in existing scenarios, only explicit
> > > > > enabling TAP.local-migration-supported will change the behavior.
> > > > > 
> > > > > Keep "local" documentation as is?
> > > > > 
> > > > > I see the only way to make it more informative: directly describe
> > > > > connection with TAP.local-migration-supported, without general
> > > > > phrases about "devices that support" and "usual". We'll have to
> > > > > update it when more devices added (my next step is vhost-user-blk),
> > > > > but at least, it would be absolutely correct at the moment.
> > > > 
> > > > How about....
> > > > 
> > > >  # @local: Permit the use of optimizations for local migration.
> > > >  #     This must only be set when both the source and destination
> > > >  #     QEMU processes are on the same OS and directly connected
> > > >  #     with a UNIX domain socket as the migration channel to enable
> > > >  #     use of file descriptor passing. Individual device backends
> > > >  #     may need additional configuration flags set  to enable local
> > > >  #     migration optimizations. This will be documented against the
> > > >  #     device backends where it applies. (Since 11.2)
> > > > 
> > > 
> > > BTW surely qemu can just detect this? getsockname maybe?
> > 
> > QEMU might be given a UNIX socket that connects to a MITM proxy
> > that then uses TCP to reach the dest QEMU.
> 
> We could try to exchange FDs and see it it works I guess.

See my earlier email response about QEMU live migration protocol being
awful. This is an example where we need to have a properly designed
protocol with a bidirectional feature negotation upfront, instead of
the current piles of hacks. 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


