Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 349FAFF4934
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 03:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w734r-00012d-Pr; Sun, 29 Mar 2026 23:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1w734q-00012E-2F
 for qemu-devel@nongnu.org; Sun, 29 Mar 2026 23:14:08 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1w734o-0001XD-52
 for qemu-devel@nongnu.org; Sun, 29 Mar 2026 23:14:07 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b980b35534eso775998266b.1
 for <qemu-devel@nongnu.org>; Sun, 29 Mar 2026 20:14:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774840443; cv=none;
 d=google.com; s=arc-20240605;
 b=SUKYiVoh3lm3h/7eZzRBvCFDLhWnx8eJvkQHt98ZAjO2jsxoRJOha9iTi0BtGwS+mc
 iR+gpvdI+FoOoH1Rtn66JBjPwFvuwvq4R/FC4BrADAf93/ou6FQBSL3WPZ0Q4YJftWkU
 +Jyg/4KyOBrt9eaGyI2ZOxztzycRXfw2ioaNRmR3nD3Hwr/jjxZJawWixOjWB+k4bEJy
 Zsbvuy5BPlm022ZblOgJcyBg84db2H1yq5TEBPBLzTVzQiroIbFVskWVsejhIJSnIGFQ
 oTS+x9kHgj0gDFkFB/PZxDtXCvQwsFZ/ivEiHU2seHyEkoIbZ10mHs+xMB1OBTltEDfL
 UG/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aGj6Vf/ZoLHTqyQhf2F8vdtahNFq4G9weSXJsl0g0nM=;
 fh=zWUcYqnTJ3e9ImU/KLi68Hph9raGFECJWfZswlVAu5k=;
 b=Kxh+ric7GclCu49VSkTfDYsTdMB8TtCjt4LZVDbSRsQTOxMzwaikXmHN12dcFl2qTx
 Akl/Vlj2+ZfSj8qaeUfCXFBvVa1SRT93wAk9EZ1Z9qtUj4EOlyu14YydTM82WQad9E6v
 QzOeFg20Sj1wOWTjWM+a32ZZs9TwRQvOL6O6zTZvQaiD4MeaXHMy2Id0pELyEhROhGlZ
 cjiCjfAx9NO6Hk3KDbSsaoqRD63tMFU8wRLUioTbapk8CRF59M0oxLc8jfkxObj5MdiQ
 0j3n1Y7SePegpLmIUR1RG55vpUbi58H6SgQ3Wvn2OmJvbKBwaXdPx5sWqJbvfCOTNkKd
 Y5qw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774840443; x=1775445243; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aGj6Vf/ZoLHTqyQhf2F8vdtahNFq4G9weSXJsl0g0nM=;
 b=nhs45X+DA288aPvkF2MYAfaoA/QQqCevHBpq5oXm7Z1inw8pGc27sih6iCYbBQEJ7z
 VY7MwBP4yamYPX+HZTJpYaFcIrVO0VOg0JorBjqTJlp3yHYuw/OQTBz2gDksk0sO29I4
 dL2nYZqVRdGu14Pm5izWH8gLJFM/JCVxw5KVFAVAUJB/iupD3pJYpTKNsc5yQDQP2Rmg
 kns+aIAIVCcAyCWtahR8zEfthJ0ZGNEHDwyQQSpEGyr0O9xlX7rMMK7MysqmLamP2tO1
 FApYxJnCxobOgO7JRII9xwD0Hcq8G+0a0/BOpiEPsUnCo8WAlyf85dXDmcX7LwgrW/lh
 RKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774840443; x=1775445243;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aGj6Vf/ZoLHTqyQhf2F8vdtahNFq4G9weSXJsl0g0nM=;
 b=NW+QO1EJJ1kZlFEvR/0xqjAup95Yl2VNXmJL0+d52xsnSGWVexJhVfMRBLj210UCdd
 gqAz8MFjVqYg3r6gJ5Jz4ezl/3960k5rayd0kShyOKLh6FgtP9j9GWyn55cEXqMaJoF9
 2rKdFc1+M3jRde4Ke2oZ20xEpSgUVyXBbXWb7JgrspVbBIkvnfru8g7awkiDf62gAdhJ
 GPywLG/K2Jq5qY/C+CpQxEvED//3HtHpZItDsedLWjhZf+vlOdABNW3hONg9Z+UTtLxA
 tXGW28LXbCA+QepOpHIlpyo1sJXTAqeXbasOmgXGhzqZ5Qt5gS2CCepzwXJUY9Z4qxdd
 p0hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWws3LfQ12Kubr84c1OfkyVwiboFi2VV1oWg3kLBout2W3aGigbIqVAjSrHKSWbabmRk+igbyYpmR4g@nongnu.org
X-Gm-Message-State: AOJu0YwPOoPz87ttKXAU1DmgeKQDqCIcow/fJ6PGIizdsXo2AusyGbc6
 ElHttoRManIed0jWI9uEVw7XfBNP5zO8q3WoRUAzz8vPErH1dAFEqviCSAgH4p7yBabiAFk35/e
 h7oCWbdS4yfNVyKeF2cEKYyd77785zUs=
X-Gm-Gg: ATEYQzwHgXSO764LxmATyPJ1MevNneOyibPiXO4Zowb0z1tb5c1SJ3SvTJxmiCsugo9
 QnZ07eGbJBws4SN3sioHVgRYq1xDs3N+9rmDX+OszJQ5951DDhMkDtDxXchOoH5/iJ0HgoIUvLv
 bAIzzA8kmNaYv3fBctVuo3Qt95U/IvvUXZw82ci0bmcA+DLnKj+z0Etrwo0SFTJdYbUQe/C/aJL
 J9AxobxUwjweQS2XUPlhYyl8GYeqdFoMUS1RBZu5RXTM+gYZsFMiuFbU6jefjCJ8cGoSQDM2yRA
 uA/IMyZCOITK0ciimjI=
X-Received: by 2002:a17:907:9808:b0:b94:82e:55e7 with SMTP id
 a640c23a62f3a-b9b522ae87bmr583545666b.25.1774840442734; Sun, 29 Mar 2026
 20:14:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260305142459.52559-1-zhangckid@gmail.com>
 <20260305142459.52559-5-zhangckid@gmail.com>
 <20260309081502.GC39949@fedora>
 <CAK3tnv+HfV9JCR7whLRDcXpfp6ZAdbw1AhWzT1RSdTVevtyvBg@mail.gmail.com>
 <20260312052422.GA116604@fedora> <87bjgtxv9b.fsf@pond.sub.org>
 <CAK3tnvJc2U+c=sx=RASKHCAjcTQMx9dg0iOpe5eEui9U0-Ft_g@mail.gmail.com>
 <87jyv9fyn5.fsf@pond.sub.org>
 <CAJSP0QWnRRRATvgRtWss_hw4ygqB_bHgBuWQd3mqUcbb1q48KA@mail.gmail.com>
In-Reply-To: <CAJSP0QWnRRRATvgRtWss_hw4ygqB_bHgBuWQd3mqUcbb1q48KA@mail.gmail.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Mon, 30 Mar 2026 11:13:26 +0800
X-Gm-Features: AQROBzCiMEzfPD2LtrV0JUqSEs6tB68aYRlLhLMXCFehmgt_UXACJKT0T9gCjgQ
Message-ID: <CAK3tnv+9pdVG_FzEYbux3JDHv8T1ywbwLBvA6j4xJ=ATdNtxAQ@mail.gmail.com>
Subject: Re: [PATCH V5 04/13] blockdev: Update tracking iothread users with
 holder name
To: Stefan Hajnoczi <stefanha@gmail.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Czenczek <hreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, 
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Mar 18, 2026 at 5:13=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.com=
> wrote:
>
> On Wed, Mar 18, 2026 at 2:20=E2=80=AFPM Markus Armbruster <armbru@redhat.=
com> wrote:
> >
> > Zhang Chen <zhangckid@gmail.com> writes:
> >
> > > On Thu, Mar 12, 2026 at 5:16=E2=80=AFPM Markus Armbruster <armbru@red=
hat.com> wrote:
> > >>
> > >> Context...  we're talking about this command:
> > >>
> > >>     ##
> > >>     # @x-blockdev-set-iothread:
> > >>     #
> > >>     # Move @node and its children into the @iothread.  If @iothread =
is
> > >>     # null then move @node and its children into the main loop.
> > >>     #
> > >>     # The node must not be attached to a BlockBackend.
> > >>     #
> > >>     # @node-name: the name of the block driver node
> > >>     #
> > >>     # @iothread: the name of the IOThread object or null for the mai=
n loop
> > >>     #
> > >>     # @force: true if the node and its children should be moved when=
 a
> > >>     #     BlockBackend is already attached
> > >>     #
> > >>     # Features:
> > >>     #
> > >>     # @unstable: This command is experimental and intended for test =
cases
> > >>     #     that need control over IOThreads only.
> > >>     #
> > >>     # Since: 2.12
> > >>     #
> > >>     # .. qmp-example::
> > >>     #    :title: Move a node into an IOThread
> > >>     #
> > >>     #     -> { "execute": "x-blockdev-set-iothread",
> > >>     #          "arguments": { "node-name": "disk1",
> > >>     #                         "iothread": "iothread0" } }
> > >>     #     <- { "return": {} }
> > >>     #
> > >>     # .. qmp-example::
> > >>     #    :title: Move a node into the main loop
> > >>     #
> > >>     #     -> { "execute": "x-blockdev-set-iothread",
> > >>     #          "arguments": { "node-name": "disk1",
> > >>     #                         "iothread": null } }
> > >>     #     <- { "return": {} }
> > >>     ##
> > >>     { 'command': 'x-blockdev-set-iothread',
> > >>       'data' : { 'node-name': 'str',
> > >>                  'iothread': 'StrOrNull',
> > >>                  '*force': 'bool' },
> > >>       'features': [ 'unstable' ],
> > >>       'allow-preconfig': true }
> > >>
> > >>
> > >> Stefan Hajnoczi <stefanha@redhat.com> writes:
> > >>
> > >> > On Tue, Mar 10, 2026 at 06:02:54PM +0800, Zhang Chen wrote:
> > >> >> On Mon, Mar 9, 2026 at 4:15=E2=80=AFPM Stefan Hajnoczi <stefanha@=
redhat.com> wrote:
> > >> >> >
> > >> >> > On Thu, Mar 05, 2026 at 10:24:50PM +0800, Zhang Chen wrote:
> > >> >> > > Update the usage of "iothread_get_aio_context()".
> > >> >> > >
> > >> >> > > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > >> >> > > ---
> > >> >> > >  blockdev.c | 9 ++++++++-
> > >> >> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > >> >> > >
> > >> >> > > diff --git a/blockdev.c b/blockdev.c
> > >> >> > > index 6e86c6262f..01ccf64b3f 100644
> > >> >> > > --- a/blockdev.c
> > >> >> > > +++ b/blockdev.c
> > >> >> > > @@ -3683,7 +3683,14 @@ void qmp_x_blockdev_set_iothread(const=
 char *node_name, StrOrNull *iothread,
> > >> >> > >              goto out;
> > >> >> > >          }
> > >> >> > >
> > >> >> > > -        new_context =3D iothread_get_aio_context(obj);
> > >> >> > > +        char *path =3D object_get_canonical_path(OBJECT(bs))=
;
> > >> >> >
> > >> >> > CCing Kevin and Markus in case they have an opinion on this.
> > >> >> >
> > >> >> > BlockDriverState is not a QOM Object so using OBJECT(bs) is und=
efined
> > >> >> > behavior and may crash.
> > >>
> > >> Yes.
> > >>
> > >> >> > node_name is unique across block driver graph nodes and could b=
e used.
> > >> >> > Unfortunately it's not connected to the QOM Object hierarchy.
> > >>
> > >> Correct.
> > >>
> > >> >> >                                                               M=
aybe it's
> > >> >> > best to build a holder name that is an invalid QOM path so ther=
e can be
> > >> >> > no collisions between QOM paths and block driver graph nodes.
> > >>
> > >> I guess you're talking about the values that go into IOThreadInfo me=
mber
> > >> holders.  From PATCH 13:
> > >>
> > >>     # @holders: The parameter is an array of QOM paths indicating ho=
w many
> > >>     #     active devices are currently associated with this iothread
> > >>     #     (e.g. virtio-blk).  In hotplug scenarios, users can
> > >>     #     pre-allocate multiple iothread objects to serve as a persi=
stent
> > >>     #     thread pool.  When a device is hot-unplugged, the correspo=
nding
> > >>     #     IOThread is released but remains available, allowing subse=
quent
> > >>     #     hot-plugged devices to attach to and reuse the existing th=
read.
> > >>     #     Returns empty if no devices are attached.  (since 11.0)
> > >>     #
> > >>
> > >> I further guess you need it to refer to both QOM objects and block
> > >> nodes, and you worry about ambiguity.
> > >>
> > >> Ambiguity indeed exists: a block node name can be a valid QOM path.
> > >>
> > >> We could restrict QOM paths to absolute paths.  These start with '/'=
.
> > >> If I remember correctly, node names cannot contain '/'.
> > >>
> > >> Note that canonical paths (returned object_get_canonical_path()) are
> > >> absolute.
> > >>
> > >> We ran into a similar design issue in review of Vladimir's "[PATCH v=
10
> > >> 4/8] qapi: add blockdev-replace command" not too long ago:
> > >>
> > >>     Subject: Re: [PATCH v10 4/8] qapi: add blockdev-replace command
> > >>     Date: Wed, 04 Feb 2026 13:26:35 +0100
> > >>     Message-ID: <87wm0sy9s4.fsf@pond.sub.org>
> > >>
> > >> There, the new command needs to refer to QOM object, block node, or
> > >> block export.
> > >>
> > >> >> >   g_autofree char *holder =3D g_strdup_printf("BlockDriverState=
 %s", node_name);
> > >> >> >
> > >> >> > (A cleaner long-term solution would be making BlockDriverStates=
 QOM
> > >> >> > Objects so they have a proper path.)
> > >>
> > >> Yes, but that's a beefy project, isn't it?
> > >>
> > >> >> If no other comments, it's OK for me. This issue like I mentioned=
 in
> > >> >> patch 7 and 9.
> > >> >
> > >> > A thought about the QAPI interface:
> > >> >
> > >> > QAPI expresses as much information in the schema as possible, so I=
 think
> > >> > the right approach would be a {'union': 'IOThreadHolder',
> > >> > 'discriminator': 'type', ...} that supports at least "qom" and
> > >> > "block-node". That way there are proper types to encode QOM Object=
 paths
> > >> > vs block node-names. Let's avoid having a single string value that=
 takes
> > >> > on different meaning depending on the type of holder.
> > >>
> > >> This shifts the complexity from semantics to syntax.
> > >>
> > >> Semantics: the member can have multiple meanings, and you have to
> > >> examine its value to decide which one applies.  The member's
> > >> documentation should specify how to decide.  Say something like "if =
the
> > >> value starts with '/', it's an absolute QOM path, else it's a block =
node
> > >> name".
> > >>
> > >> Syntax: meaning is syntactically obvious.  For instance, union of QO=
M
> > >> path and block node name.
> > >>
> > >> Complex semantics tend to require more complex documentation.
> > >>
> > >> Which choice is better depends on the specific case.  I generally le=
an
> > >> towards syntax.
> > >>
> > >
> > > I agree Markus's suggestion.
> > > Compare with standard QOM path:
> > > /machine/peripheral/blk0/virtio-backend
> > >
> > > I will try to implement block nodes path like this:
> > > /machine/blockdriverstate/node-name
> >
> > I gather you'd like to try creating QOM objects for block nodes.
> >
> > First, this should not go into /machine.  We already have /chardevs and
> > /audiodevs, which suggests something like /blockdevs or /block-nodes.
>
> It may be a lot of work. An alternative I suggested was a holder enum
> instead of a string so that QOM paths and block node names can be
> separated with no chance of collisions. That approach is more
> straightforward to implement and the main drawback I see is that the
> enum would become superfluous if block nodes become QOM objects in the
> future. That's not terrible.
>
> Stefan

Ping....

Hi Markus and Stefan,
As Markus's comments, I prefer the /blockdevs or /block-nodes is more simpl=
e,
And use a holder enum instead of a string will make it more difficult
for users to understand.
Please let us make a decision.

Hi Kevin and Hanna,
Considering the possibility of blockdevs being qom in the future,  we
need your idea here, any comments for the series?

Thanks
Chen

