Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18A6FF60C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 05:55:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7S3v-0003ps-1a; Tue, 31 Mar 2026 01:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w7S3t-0003pT-EO
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 01:54:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w7S3r-0000dz-Jh
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 01:54:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774936487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=rk3QYWDM+EmYXI5eH/NLPACn/AKB5G+ypw/DwjSqC1w=;
 b=dXZiz4UcETkwIcbrAikRdfULbrHB7g7FW7yGEGUpJXryJZp+GjTP93rZ88gSkUIUeQAGAB
 AeFNAGnA9D9CMbEt99XLwYlAwGm5D8euGDSsXbu9aEmHn6pmvTaVYwpl4nGUVnkJ9HHSCQ
 brdwsKeX/y4rDXUPMwABAiX1D/fsIW0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-192-e4RuFbsrP1C6F-9-qJ_6Ug-1; Tue,
 31 Mar 2026 01:54:41 -0400
X-MC-Unique: e4RuFbsrP1C6F-9-qJ_6Ug-1
X-Mimecast-MFC-AGG-ID: e4RuFbsrP1C6F-9-qJ_6Ug_1774936480
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E9F2319560A1; Tue, 31 Mar 2026 05:54:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 60A4D1800107; Tue, 31 Mar 2026 05:54:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CFC1821E6A28; Tue, 31 Mar 2026 07:54:36 +0200 (CEST)
Resent-To: stefanha@gmail.com, zhangckid@gmail.com, qemu-devel@nongnu.org,
 dave@treblig.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Tue, 31 Mar 2026 07:54:36 +0200
Resent-Message-ID: <87zf3ownkz.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>,  Kevin Wolf <kwolf@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  qemu-devel <qemu-devel@nongnu.org>,  "Dr . David
 Alan Gilbert" <dave@treblig.org>,  Eric Blake <eblake@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V5 04/13] blockdev: Update tracking iothread users with
 holder name
In-Reply-To: <CAK3tnv+9pdVG_FzEYbux3JDHv8T1ywbwLBvA6j4xJ=ATdNtxAQ@mail.gmail.com>
 (Zhang Chen's message of "Mon, 30 Mar 2026 11:13:26 +0800")
References: <20260305142459.52559-1-zhangckid@gmail.com>
 <20260305142459.52559-5-zhangckid@gmail.com>
 <20260309081502.GC39949@fedora>
 <CAK3tnv+HfV9JCR7whLRDcXpfp6ZAdbw1AhWzT1RSdTVevtyvBg@mail.gmail.com>
 <20260312052422.GA116604@fedora> <87bjgtxv9b.fsf@pond.sub.org>
 <CAK3tnvJc2U+c=sx=RASKHCAjcTQMx9dg0iOpe5eEui9U0-Ft_g@mail.gmail.com>
 <87jyv9fyn5.fsf@pond.sub.org>
 <CAJSP0QWnRRRATvgRtWss_hw4ygqB_bHgBuWQd3mqUcbb1q48KA@mail.gmail.com>
 <CAK3tnv+9pdVG_FzEYbux3JDHv8T1ywbwLBvA6j4xJ=ATdNtxAQ@mail.gmail.com>
Date: Mon, 30 Mar 2026 11:02:03 +0200
Message-ID: <875x6dzo50.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Zhang Chen <zhangckid@gmail.com> writes:

> On Wed, Mar 18, 2026 at 5:13=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.c=
om> wrote:
>>
>> On Wed, Mar 18, 2026 at 2:20=E2=80=AFPM Markus Armbruster <armbru@redhat=
.com> wrote:
>> >
>> > Zhang Chen <zhangckid@gmail.com> writes:
>> >
>> > > On Thu, Mar 12, 2026 at 5:16=E2=80=AFPM Markus Armbruster <armbru@re=
dhat.com> wrote:
>> > >>
>> > >> Context...  we're talking about this command:
>> > >>
>> > >>     ##
>> > >>     # @x-blockdev-set-iothread:
>> > >>     #
>> > >>     # Move @node and its children into the @iothread.  If @iothread=
 is
>> > >>     # null then move @node and its children into the main loop.
>> > >>     #
>> > >>     # The node must not be attached to a BlockBackend.
>> > >>     #
>> > >>     # @node-name: the name of the block driver node
>> > >>     #
>> > >>     # @iothread: the name of the IOThread object or null for the ma=
in loop
>> > >>     #
>> > >>     # @force: true if the node and its children should be moved whe=
n a
>> > >>     #     BlockBackend is already attached
>> > >>     #
>> > >>     # Features:
>> > >>     #
>> > >>     # @unstable: This command is experimental and intended for test=
 cases
>> > >>     #     that need control over IOThreads only.
>> > >>     #
>> > >>     # Since: 2.12
>> > >>     #
>> > >>     # .. qmp-example::
>> > >>     #    :title: Move a node into an IOThread
>> > >>     #
>> > >>     #     -> { "execute": "x-blockdev-set-iothread",
>> > >>     #          "arguments": { "node-name": "disk1",
>> > >>     #                         "iothread": "iothread0" } }
>> > >>     #     <- { "return": {} }
>> > >>     #
>> > >>     # .. qmp-example::
>> > >>     #    :title: Move a node into the main loop
>> > >>     #
>> > >>     #     -> { "execute": "x-blockdev-set-iothread",
>> > >>     #          "arguments": { "node-name": "disk1",
>> > >>     #                         "iothread": null } }
>> > >>     #     <- { "return": {} }
>> > >>     ##
>> > >>     { 'command': 'x-blockdev-set-iothread',
>> > >>       'data' : { 'node-name': 'str',
>> > >>                  'iothread': 'StrOrNull',
>> > >>                  '*force': 'bool' },
>> > >>       'features': [ 'unstable' ],
>> > >>       'allow-preconfig': true }
>> > >>
>> > >>
>> > >> Stefan Hajnoczi <stefanha@redhat.com> writes:
>> > >>
>> > >> > On Tue, Mar 10, 2026 at 06:02:54PM +0800, Zhang Chen wrote:
>> > >> >> On Mon, Mar 9, 2026 at 4:15=E2=80=AFPM Stefan Hajnoczi <stefanha=
@redhat.com> wrote:
>> > >> >> >
>> > >> >> > On Thu, Mar 05, 2026 at 10:24:50PM +0800, Zhang Chen wrote:
>> > >> >> > > Update the usage of "iothread_get_aio_context()".
>> > >> >> > >
>> > >> >> > > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
>> > >> >> > > ---
>> > >> >> > >  blockdev.c | 9 ++++++++-
>> > >> >> > >  1 file changed, 8 insertions(+), 1 deletion(-)
>> > >> >> > >
>> > >> >> > > diff --git a/blockdev.c b/blockdev.c
>> > >> >> > > index 6e86c6262f..01ccf64b3f 100644
>> > >> >> > > --- a/blockdev.c
>> > >> >> > > +++ b/blockdev.c
>> > >> >> > > @@ -3683,7 +3683,14 @@ void qmp_x_blockdev_set_iothread(cons=
t char *node_name, StrOrNull *iothread,
>> > >> >> > >              goto out;
>> > >> >> > >          }
>> > >> >> > >
>> > >> >> > > -        new_context =3D iothread_get_aio_context(obj);
>> > >> >> > > +        char *path =3D object_get_canonical_path(OBJECT(bs)=
);
>> > >> >> >
>> > >> >> > CCing Kevin and Markus in case they have an opinion on this.
>> > >> >> >
>> > >> >> > BlockDriverState is not a QOM Object so using OBJECT(bs) is un=
defined
>> > >> >> > behavior and may crash.
>> > >>
>> > >> Yes.
>> > >>
>> > >> >> > node_name is unique across block driver graph nodes and could =
be used.
>> > >> >> > Unfortunately it's not connected to the QOM Object hierarchy.
>> > >>
>> > >> Correct.
>> > >>
>> > >> >> >                                                               =
Maybe it's
>> > >> >> > best to build a holder name that is an invalid QOM path so the=
re can be
>> > >> >> > no collisions between QOM paths and block driver graph nodes.
>> > >>
>> > >> I guess you're talking about the values that go into IOThreadInfo m=
ember
>> > >> holders.  From PATCH 13:
>> > >>
>> > >>     # @holders: The parameter is an array of QOM paths indicating h=
ow many
>> > >>     #     active devices are currently associated with this iothread
>> > >>     #     (e.g. virtio-blk).  In hotplug scenarios, users can
>> > >>     #     pre-allocate multiple iothread objects to serve as a pers=
istent
>> > >>     #     thread pool.  When a device is hot-unplugged, the corresp=
onding
>> > >>     #     IOThread is released but remains available, allowing subs=
equent
>> > >>     #     hot-plugged devices to attach to and reuse the existing t=
hread.
>> > >>     #     Returns empty if no devices are attached.  (since 11.0)
>> > >>     #
>> > >>
>> > >> I further guess you need it to refer to both QOM objects and block
>> > >> nodes, and you worry about ambiguity.
>> > >>
>> > >> Ambiguity indeed exists: a block node name can be a valid QOM path.
>> > >>
>> > >> We could restrict QOM paths to absolute paths.  These start with '/=
'.
>> > >> If I remember correctly, node names cannot contain '/'.
>> > >>
>> > >> Note that canonical paths (returned object_get_canonical_path()) are
>> > >> absolute.
>> > >>
>> > >> We ran into a similar design issue in review of Vladimir's "[PATCH =
v10
>> > >> 4/8] qapi: add blockdev-replace command" not too long ago:
>> > >>
>> > >>     Subject: Re: [PATCH v10 4/8] qapi: add blockdev-replace command
>> > >>     Date: Wed, 04 Feb 2026 13:26:35 +0100
>> > >>     Message-ID: <87wm0sy9s4.fsf@pond.sub.org>
>> > >>
>> > >> There, the new command needs to refer to QOM object, block node, or
>> > >> block export.
>> > >>
>> > >> >> >   g_autofree char *holder =3D g_strdup_printf("BlockDriverStat=
e %s", node_name);
>> > >> >> >
>> > >> >> > (A cleaner long-term solution would be making BlockDriverState=
s QOM
>> > >> >> > Objects so they have a proper path.)
>> > >>
>> > >> Yes, but that's a beefy project, isn't it?
>> > >>
>> > >> >> If no other comments, it's OK for me. This issue like I mentione=
d in
>> > >> >> patch 7 and 9.
>> > >> >
>> > >> > A thought about the QAPI interface:
>> > >> >
>> > >> > QAPI expresses as much information in the schema as possible, so =
I think
>> > >> > the right approach would be a {'union': 'IOThreadHolder',
>> > >> > 'discriminator': 'type', ...} that supports at least "qom" and
>> > >> > "block-node". That way there are proper types to encode QOM Objec=
t paths
>> > >> > vs block node-names. Let's avoid having a single string value tha=
t takes
>> > >> > on different meaning depending on the type of holder.
>> > >>
>> > >> This shifts the complexity from semantics to syntax.
>> > >>
>> > >> Semantics: the member can have multiple meanings, and you have to
>> > >> examine its value to decide which one applies.  The member's
>> > >> documentation should specify how to decide.  Say something like "if=
 the
>> > >> value starts with '/', it's an absolute QOM path, else it's a block=
 node
>> > >> name".
>> > >>
>> > >> Syntax: meaning is syntactically obvious.  For instance, union of Q=
OM
>> > >> path and block node name.
>> > >>
>> > >> Complex semantics tend to require more complex documentation.
>> > >>
>> > >> Which choice is better depends on the specific case.  I generally l=
ean
>> > >> towards syntax.
>> > >>
>> > >
>> > > I agree Markus's suggestion.
>> > > Compare with standard QOM path:
>> > > /machine/peripheral/blk0/virtio-backend
>> > >
>> > > I will try to implement block nodes path like this:
>> > > /machine/blockdriverstate/node-name
>> >
>> > I gather you'd like to try creating QOM objects for block nodes.
>> >
>> > First, this should not go into /machine.  We already have /chardevs and
>> > /audiodevs, which suggests something like /blockdevs or /block-nodes.
>>
>> It may be a lot of work. An alternative I suggested was a holder enum
>> instead of a string so that QOM paths and block node names can be
>> separated with no chance of collisions. That approach is more
>> straightforward to implement and the main drawback I see is that the
>> enum would become superfluous if block nodes become QOM objects in the
>> future. That's not terrible.
>>
>> Stefan
>
> Ping....
>
> Hi Markus and Stefan,
> As Markus's comments, I prefer the /blockdevs or /block-nodes is more sim=
ple,
> And use a holder enum instead of a string will make it more difficult
> for users to understand.
> Please let us make a decision.

I'm not sure what exactly you need from me.

I assume you need advice on how to represent a reference to a "holder"
in the QAPI schema, where the holder can either be a QOM object or a
block node.

If everthing was a QOM object, we could simply use a QOM path,
i.e. 'str'.

Sadly, block nodes are not QOM objects.  Unless you want to solve the
(non-trivial) problem of making them QOM objects first, you need
something else.

My recommendation for something else would be a union:

    { 'union': 'IoThreadHolder',
      'base': { 'type': 'IoThreadHolderKind' },
      'discriminator': 'type',
      'data': {
          'block-node': ...,
          'qom-object': ... } }

Stefan, do you agree?

Hope this helps!

> Hi Kevin and Hanna,
> Considering the possibility of blockdevs being qom in the future,  we
> need your idea here, any comments for the series?
>
> Thanks
> Chen


