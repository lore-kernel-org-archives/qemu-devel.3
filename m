Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 671C110854D9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 09:13:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2my4-00032F-Rk; Wed, 18 Mar 2026 05:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1w2my3-00031u-CU
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 05:13:31 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1w2my1-0004TR-7I
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 05:13:31 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-667d8f30bb7so662990a12.0
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 02:13:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773825207; cv=none;
 d=google.com; s=arc-20240605;
 b=BCipB2h86jigQusIPTq+RnhhJl6Tw6O3zMLGS9ejhAVm/TYC30036cBpfYW4lwp5Tf
 d5NrBHw+ILVkF99f10RVr53k1b4QbYPElAmKwUTm/RIIUhOvVL0x7EYkUPUW9QVIR9nS
 Oz7KHIFQ7LWrAwpEf+lSj+VSMpNwi2E6ZqTMHX1LH918h2Yp0eS+7hGnZjvEGU8TgmQH
 P+GFqfxiUfJMTg7E5ll87WJhavPDkIFd0g7LQDXm+TeDhQUMzeWgxhHlXhtVVaAaHngD
 V50jSpoHkfb7F7/gAS0KIJdnn1fm6OMADoAu+1PdL0+V7pUHnkHCrCNT4lTnt8HJHt4B
 0Upw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=sDwWSNjqwGPVnzFNOms8iNcfp/jQBQm8yfITtTLfZis=;
 fh=7uQb03SakFrMBOkt6UN6cgs3l1LlfbhKYrhfFdD5gok=;
 b=W9yCCV6pTLeyvn0ta+0ZqicXj5tcCfNl1j8UYWyz141YIFp9GQJYHDw9jm3qlbDDHH
 wuqw/0zrI2exEO1jX5+NvgyIBDfH/eDz5oOnSHvcoMtbYrh19Odcd1NYcT+glBQx5t+r
 MBzEIcJV8RE++19cUP3CAsJw3dGbSzXBXA/5fAqqAeu1YW3KlEucPBPaMqVMaRiHxxbX
 bNzlVXsjWYDwr8c0R8jFFjSRKJ2nI6wMfDBsToXTLCEs0pNPR467mYRoQ3TdhdR5LB89
 3qtRNnXAGlR9AKCR24lVMxY47q5g6NYXleCIx7Xy22w3f+5nfCTNsIoksZQaB/RB/eTX
 oliw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773825207; x=1774430007; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sDwWSNjqwGPVnzFNOms8iNcfp/jQBQm8yfITtTLfZis=;
 b=gdqoTO9SQar0qVdDCIA9qmATDqWsSSKE7KOdZ42pIOP7pQPWzGFX7BJOAkwzbvGMQN
 hX++zAH0FupSswLeS7HZmTPbMWAjppa/pUt24rl+XrAxxa66j67e+d8RR/Oaqkx0w396
 GeQzFOWSTLCuQNbT4xl7wQmE39wZTNHw0+u8y3HIPzGsb2tNwClQ/9S29ayhdGJUIGDS
 6KR88m8Uy5bw8NGPESPDiaYkX/iJU0L09mXynl7XEdPLi8lgeSbTZHY2ukLnnxWCVySs
 TT735DvJ3gGQLhBlfsHv66lIr8/rOSWQaras2rvhAC44S8fCpNG02fyYv+XkT4auq+h/
 PUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773825207; x=1774430007;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sDwWSNjqwGPVnzFNOms8iNcfp/jQBQm8yfITtTLfZis=;
 b=p6kkkOkbQwwHRTI0v16zv4p3/6AwJs6Yzs5+YiynutN/fGgILhukNcSn8lqsIGEEnn
 +Uo7ao4pWOOQpbOyCSpWOevHNWebanMkIKPRUEaXS6XSLoeuB5km9wf7JXksjNzIlQ0j
 2eBx9gWYCs/FbC6sR0terSVCedc2LDhk/6D+8opXxuH3DHjTIUwIq7c1FQh7BI5nyD0w
 WkxfKY1sGhim6qZk75CQWGM1p+A+mIwqOvji66BvwCpkFH/xHlj9FUb7jAx5uFP4i9bT
 tPmu3MilA5BSiuBFuhDTmU+4LQo+zPki+S/m2k3naw78ff8pfXX0Cbw2ieddyOMegQUR
 Tkeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW32B1sxzLngNYLPqLpJpXC1lmarPQIzkTf9OTlcNxb24Cl0x0anhvJRo5vLvAUBKSR5isv0W7zxzno@nongnu.org
X-Gm-Message-State: AOJu0Yw9VlpYtpG9cVnxIjlhv8THzRq/+LN3Ghi1MIccRzyIUce3IzLO
 H7rXcNET29IL7SkMw5OoTuoxj818KXLh460ccfMgl1wlVuhHcPKX4SLFZDNfrIMEUyitopLN6cF
 FGfFNRsbB9W/hURXMgbarXEgBz9vh39k=
X-Gm-Gg: ATEYQzy2riTK+kxM8/Xr+6fSYtiuzpMZb26lNhLu3JcgzEGCUegoPj6Xox3o1Eua3dm
 obuYYz3J/60LdF7tygjO1r6LY8jgGpDXBYczsNlbGpWdubbYgrF8MMKoAv+tj4gnLM8N8RWmHZt
 XvYq1fX601ieoI2rvYXwJIY6GL5J8RFtMrjPcJBBYLxhq1CrOEDDzWat1ZBiKihfYUW9ypB0lKt
 Jobni00oJ9XtXSpvFcaV51vb4oNIhtlZSyElWBfEzjw+aLvA9VuRS7wYjRV9HATMZc8w+xdV9lZ
 jjX/V55MVhtkCG5rMk9Q2WEdHh7qnl7V7wjTadQ9iAhlUz/VeYG6
X-Received: by 2002:a05:6402:1ed5:b0:667:247:b026 with SMTP id
 4fb4d7f45d1cf-667b2c033aamr1984998a12.18.1773825206505; Wed, 18 Mar 2026
 02:13:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260305142459.52559-1-zhangckid@gmail.com>
 <20260305142459.52559-5-zhangckid@gmail.com>
 <20260309081502.GC39949@fedora>
 <CAK3tnv+HfV9JCR7whLRDcXpfp6ZAdbw1AhWzT1RSdTVevtyvBg@mail.gmail.com>
 <20260312052422.GA116604@fedora> <87bjgtxv9b.fsf@pond.sub.org>
 <CAK3tnvJc2U+c=sx=RASKHCAjcTQMx9dg0iOpe5eEui9U0-Ft_g@mail.gmail.com>
 <87jyv9fyn5.fsf@pond.sub.org>
In-Reply-To: <87jyv9fyn5.fsf@pond.sub.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 18 Mar 2026 17:13:13 +0800
X-Gm-Features: AaiRm52kXACm8rf6WahfgS_y5lcZcrYU9sathbN_Is-SLfVzKRgRuZZjFw7g7-A
Message-ID: <CAJSP0QWnRRRATvgRtWss_hw4ygqB_bHgBuWQd3mqUcbb1q48KA@mail.gmail.com>
Subject: Re: [PATCH V5 04/13] blockdev: Update tracking iothread users with
 holder name
To: Markus Armbruster <armbru@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, 
 "Dr . David Alan Gilbert" <dave@treblig.org>, Eric Blake <eblake@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Hanna Czenczek <hreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x530.google.com
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

On Wed, Mar 18, 2026 at 2:20=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Zhang Chen <zhangckid@gmail.com> writes:
>
> > On Thu, Mar 12, 2026 at 5:16=E2=80=AFPM Markus Armbruster <armbru@redha=
t.com> wrote:
> >>
> >> Context...  we're talking about this command:
> >>
> >>     ##
> >>     # @x-blockdev-set-iothread:
> >>     #
> >>     # Move @node and its children into the @iothread.  If @iothread is
> >>     # null then move @node and its children into the main loop.
> >>     #
> >>     # The node must not be attached to a BlockBackend.
> >>     #
> >>     # @node-name: the name of the block driver node
> >>     #
> >>     # @iothread: the name of the IOThread object or null for the main =
loop
> >>     #
> >>     # @force: true if the node and its children should be moved when a
> >>     #     BlockBackend is already attached
> >>     #
> >>     # Features:
> >>     #
> >>     # @unstable: This command is experimental and intended for test ca=
ses
> >>     #     that need control over IOThreads only.
> >>     #
> >>     # Since: 2.12
> >>     #
> >>     # .. qmp-example::
> >>     #    :title: Move a node into an IOThread
> >>     #
> >>     #     -> { "execute": "x-blockdev-set-iothread",
> >>     #          "arguments": { "node-name": "disk1",
> >>     #                         "iothread": "iothread0" } }
> >>     #     <- { "return": {} }
> >>     #
> >>     # .. qmp-example::
> >>     #    :title: Move a node into the main loop
> >>     #
> >>     #     -> { "execute": "x-blockdev-set-iothread",
> >>     #          "arguments": { "node-name": "disk1",
> >>     #                         "iothread": null } }
> >>     #     <- { "return": {} }
> >>     ##
> >>     { 'command': 'x-blockdev-set-iothread',
> >>       'data' : { 'node-name': 'str',
> >>                  'iothread': 'StrOrNull',
> >>                  '*force': 'bool' },
> >>       'features': [ 'unstable' ],
> >>       'allow-preconfig': true }
> >>
> >>
> >> Stefan Hajnoczi <stefanha@redhat.com> writes:
> >>
> >> > On Tue, Mar 10, 2026 at 06:02:54PM +0800, Zhang Chen wrote:
> >> >> On Mon, Mar 9, 2026 at 4:15=E2=80=AFPM Stefan Hajnoczi <stefanha@re=
dhat.com> wrote:
> >> >> >
> >> >> > On Thu, Mar 05, 2026 at 10:24:50PM +0800, Zhang Chen wrote:
> >> >> > > Update the usage of "iothread_get_aio_context()".
> >> >> > >
> >> >> > > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> >> >> > > ---
> >> >> > >  blockdev.c | 9 ++++++++-
> >> >> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> >> >> > >
> >> >> > > diff --git a/blockdev.c b/blockdev.c
> >> >> > > index 6e86c6262f..01ccf64b3f 100644
> >> >> > > --- a/blockdev.c
> >> >> > > +++ b/blockdev.c
> >> >> > > @@ -3683,7 +3683,14 @@ void qmp_x_blockdev_set_iothread(const c=
har *node_name, StrOrNull *iothread,
> >> >> > >              goto out;
> >> >> > >          }
> >> >> > >
> >> >> > > -        new_context =3D iothread_get_aio_context(obj);
> >> >> > > +        char *path =3D object_get_canonical_path(OBJECT(bs));
> >> >> >
> >> >> > CCing Kevin and Markus in case they have an opinion on this.
> >> >> >
> >> >> > BlockDriverState is not a QOM Object so using OBJECT(bs) is undef=
ined
> >> >> > behavior and may crash.
> >>
> >> Yes.
> >>
> >> >> > node_name is unique across block driver graph nodes and could be =
used.
> >> >> > Unfortunately it's not connected to the QOM Object hierarchy.
> >>
> >> Correct.
> >>
> >> >> >                                                               May=
be it's
> >> >> > best to build a holder name that is an invalid QOM path so there =
can be
> >> >> > no collisions between QOM paths and block driver graph nodes.
> >>
> >> I guess you're talking about the values that go into IOThreadInfo memb=
er
> >> holders.  From PATCH 13:
> >>
> >>     # @holders: The parameter is an array of QOM paths indicating how =
many
> >>     #     active devices are currently associated with this iothread
> >>     #     (e.g. virtio-blk).  In hotplug scenarios, users can
> >>     #     pre-allocate multiple iothread objects to serve as a persist=
ent
> >>     #     thread pool.  When a device is hot-unplugged, the correspond=
ing
> >>     #     IOThread is released but remains available, allowing subsequ=
ent
> >>     #     hot-plugged devices to attach to and reuse the existing thre=
ad.
> >>     #     Returns empty if no devices are attached.  (since 11.0)
> >>     #
> >>
> >> I further guess you need it to refer to both QOM objects and block
> >> nodes, and you worry about ambiguity.
> >>
> >> Ambiguity indeed exists: a block node name can be a valid QOM path.
> >>
> >> We could restrict QOM paths to absolute paths.  These start with '/'.
> >> If I remember correctly, node names cannot contain '/'.
> >>
> >> Note that canonical paths (returned object_get_canonical_path()) are
> >> absolute.
> >>
> >> We ran into a similar design issue in review of Vladimir's "[PATCH v10
> >> 4/8] qapi: add blockdev-replace command" not too long ago:
> >>
> >>     Subject: Re: [PATCH v10 4/8] qapi: add blockdev-replace command
> >>     Date: Wed, 04 Feb 2026 13:26:35 +0100
> >>     Message-ID: <87wm0sy9s4.fsf@pond.sub.org>
> >>
> >> There, the new command needs to refer to QOM object, block node, or
> >> block export.
> >>
> >> >> >   g_autofree char *holder =3D g_strdup_printf("BlockDriverState %=
s", node_name);
> >> >> >
> >> >> > (A cleaner long-term solution would be making BlockDriverStates Q=
OM
> >> >> > Objects so they have a proper path.)
> >>
> >> Yes, but that's a beefy project, isn't it?
> >>
> >> >> If no other comments, it's OK for me. This issue like I mentioned i=
n
> >> >> patch 7 and 9.
> >> >
> >> > A thought about the QAPI interface:
> >> >
> >> > QAPI expresses as much information in the schema as possible, so I t=
hink
> >> > the right approach would be a {'union': 'IOThreadHolder',
> >> > 'discriminator': 'type', ...} that supports at least "qom" and
> >> > "block-node". That way there are proper types to encode QOM Object p=
aths
> >> > vs block node-names. Let's avoid having a single string value that t=
akes
> >> > on different meaning depending on the type of holder.
> >>
> >> This shifts the complexity from semantics to syntax.
> >>
> >> Semantics: the member can have multiple meanings, and you have to
> >> examine its value to decide which one applies.  The member's
> >> documentation should specify how to decide.  Say something like "if th=
e
> >> value starts with '/', it's an absolute QOM path, else it's a block no=
de
> >> name".
> >>
> >> Syntax: meaning is syntactically obvious.  For instance, union of QOM
> >> path and block node name.
> >>
> >> Complex semantics tend to require more complex documentation.
> >>
> >> Which choice is better depends on the specific case.  I generally lean
> >> towards syntax.
> >>
> >
> > I agree Markus's suggestion.
> > Compare with standard QOM path:
> > /machine/peripheral/blk0/virtio-backend
> >
> > I will try to implement block nodes path like this:
> > /machine/blockdriverstate/node-name
>
> I gather you'd like to try creating QOM objects for block nodes.
>
> First, this should not go into /machine.  We already have /chardevs and
> /audiodevs, which suggests something like /blockdevs or /block-nodes.

It may be a lot of work. An alternative I suggested was a holder enum
instead of a string so that QOM paths and block node names can be
separated with no chance of collisions. That approach is more
straightforward to implement and the main drawback I see is that the
enum would become superfluous if block nodes become QOM objects in the
future. That's not terrible.

Stefan

