Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE3A1061B15
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 17:44:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7GeZ-0005Rn-1z; Mon, 30 Mar 2026 13:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1w7GeO-0005QP-KH
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 13:43:49 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1w7GeK-00077n-TS
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 13:43:44 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-66b957dd76dso2817226a12.3
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 10:43:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774892619; cv=none;
 d=google.com; s=arc-20240605;
 b=jNg7XPdfY1t5iCNZoApy4JOqD+rv8RDhl1GipWIfuHcJUodtvWmF5yRtLOMcxSo3hy
 3dr3ZjJXx7ksrmCEErBuwZVHz7dhFLu/3c7jX5E4AK8wrKMBEWB87RFzrqSMGm+6fI+o
 xb6AAjBRpjAPrDMhUh+NYEboPeRqiCLZ8pCFntLZzF99pGEM2VwUw7oWI8kUqAnibibp
 pDpVUWKivHc34JZ7xS4U6M8reNLiADdfWSS7qYekFlB09GQ+iXUydpMpaUH3gNGTRXJb
 h6lGxWhSCSdyy7PdvBB2prCLhzd29/42+a7xkfGO2U7gSercpFRTg8nRDUr0VKFgRf84
 u/1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OZKf0dZHMTjnXvbaQrW4s0zsZSyHJULyyqF6Phz1evE=;
 fh=nSLIvFiDxQH/YyE/FpKxoLtlJvNZh4oTTKZsWPA1+1A=;
 b=OCoSlWy+1+KpiiwTAEf289Xr3TietN2gCfBGwcaZn1pJJYe6fGdfZ9jkskdsAtA2Lb
 /fEVCSVUCkdmTtLAk47Sb2JX8WeCqrQd0oVDdtXmpdRUDGjUEslawIGkfNEEJGBfeDTK
 dGaducXVya/25TdGU0ueT6WhEG1Xd212Vkow6loGmZ+NX1RlN2NGzbetY/DqJyZMtfNv
 waI6lFC/aSzXps0MDdarjRe6TYrEN69rwwJwTb3WKVNz+m9R68+mZQRbJSsgQ4rvEAFv
 Mx5LY3JkF58vccBoIjusJQ4rC9sKAZrtlI0k/ax0ObNE4GiAklfgYgkVrRuUJn2XSc3Q
 k2EQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774892619; x=1775497419; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OZKf0dZHMTjnXvbaQrW4s0zsZSyHJULyyqF6Phz1evE=;
 b=fQVB06jvEMTC7l8g83BMKaraNtPwLd+AKtHSgJilnzyElbEECS/irCQGFcZF/rV6yK
 U5ZQh+VYufpUWooLuyaPIWEwohCXFxHR9Ys4sYLHmdMH/8ROteeGVScu3EzJ0QM3bsJn
 nLmsVgwDXyKl/Om6xTa3fazUcloQRhxK1rXGv2oOUPAnoRu3udgW7cRHhRqHLds1XP5X
 X7FIxpW97s2OIa/zcKI0UgOPKU7qoxf09xATtZJGxGDHBv00N45LkuRUUb2Sby0aZRPB
 A6G/QJOlFREv381fE7QbsaTfcHNH6B7Az8KAV8VDw8hfr1nYIAkxNbfDRa0MaaDY78XQ
 NtPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774892619; x=1775497419;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OZKf0dZHMTjnXvbaQrW4s0zsZSyHJULyyqF6Phz1evE=;
 b=LdaCMi16c2kaAehQMr0d7ogzSrQqeHPn+j0TM+1M5gve0sgK4BbTJycpCaS3z/cwkU
 EkZhV7nCg8OPhPkQsQTwPlQ1jLNV7jxuRCVtEu6Q+pFoHR+M9N/NmjjZXo6VLZGbiMMN
 QZEBHpNAfYYaSum3tGzAzStFUJUhCxWmjI9gfFGNe7zh8+DWVQI/Etj/gv150y7G+6eq
 ohaejylEEDcdhdBbR/or0VcVGk3qg5BtNocDrYaryABj2EfDH1kKzb2Nz1x+i/A5ZpYd
 4E7dyVe09QdgxVdhsa+WXxNjcdCfV0PLzhKps6ko2ghYjjojM7YXwfexCAQYnG3GBlCD
 GdXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVesrROxXh0rZSckJRdjcJ3kQNVNpZSMjBPnXzunSB8d3lguGIVoYp8Yd1Rqgp5YuOBbdyxTIHryhzi@nongnu.org
X-Gm-Message-State: AOJu0Yz73QFZe/Y4/CrShrtN7i5jlj8y3al9tWfEOl4DZbxqxaSvYsCm
 xPUYvmUWGnM3lg1uzDT/+Oqp29zWHZNoFdYdGKMb3Qy94oJ3xsUasPD0yr8QtSH7hsK/AXXm581
 bIG20y60gLa3fqPmlHKGVG9aA05+2CD4=
X-Gm-Gg: ATEYQzwaMnp/5ZyGYAfE+U7eF6HTHNWZ9B56gCzQvYBIBCLZGcSRTAdBquuETzvoFIW
 kwHdzNAKggo6xz8T6Vl6aSr6/J2jw9w/u8ZLyxcXUrsY97ydEpP/R/QBJB6W2n/ydJQxXgw1bFT
 f36m8unZUOTiGj2EwQoet6teoft02Vd+dGP/v2nQsM3bt2VQx8ermJf5vdme7SzLaS9VKH+r/bS
 +BVd8788niiBRreioYBeho3vSypgR40/7UIoZ7MvJ+78KX1GJ2gKKd4xkdgYKH2u0zIWoZBf5Xq
 DvG5kKLs
X-Received: by 2002:a17:906:209c:b0:b98:8692:bc3e with SMTP id
 a640c23a62f3a-b9b5031adabmr688338466b.9.1774892618536; Mon, 30 Mar 2026
 10:43:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260305142459.52559-5-zhangckid@gmail.com>
 <20260309081502.GC39949@fedora>
 <CAK3tnv+HfV9JCR7whLRDcXpfp6ZAdbw1AhWzT1RSdTVevtyvBg@mail.gmail.com>
 <20260312052422.GA116604@fedora> <87bjgtxv9b.fsf@pond.sub.org>
 <CAK3tnvJc2U+c=sx=RASKHCAjcTQMx9dg0iOpe5eEui9U0-Ft_g@mail.gmail.com>
 <87jyv9fyn5.fsf@pond.sub.org>
 <CAJSP0QWnRRRATvgRtWss_hw4ygqB_bHgBuWQd3mqUcbb1q48KA@mail.gmail.com>
 <CAK3tnv+9pdVG_FzEYbux3JDHv8T1ywbwLBvA6j4xJ=ATdNtxAQ@mail.gmail.com>
 <875x6dzo50.fsf@pond.sub.org> <20260330133155.GA154632@fedora>
In-Reply-To: <20260330133155.GA154632@fedora>
From: Zhang Chen <zhangckid@gmail.com>
Date: Tue, 31 Mar 2026 01:43:00 +0800
X-Gm-Features: AQROBzDWsNZqI2E920GfhQxVVIYVrdwx8OJN7dr8g36AzmlosFWZwO-rQf0Ellg
Message-ID: <CAK3tnvJJKUgmJQ0oV4kOX7Lppo4=90EHUUzyGiTOMZjX44fevQ@mail.gmail.com>
Subject: Re: [PATCH V5 04/13] blockdev: Update tracking iothread users with
 holder name
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 Hanna Czenczek <hreitz@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, 
 "Dr . David Alan Gilbert" <dave@treblig.org>, Eric Blake <eblake@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x52c.google.com
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

On Mon, Mar 30, 2026 at 9:32=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Mon, Mar 30, 2026 at 11:02:03AM +0200, Markus Armbruster wrote:
> > Zhang Chen <zhangckid@gmail.com> writes:
> >
> > > On Wed, Mar 18, 2026 at 5:13=E2=80=AFPM Stefan Hajnoczi <stefanha@gma=
il.com> wrote:
> > >>
> > >> On Wed, Mar 18, 2026 at 2:20=E2=80=AFPM Markus Armbruster <armbru@re=
dhat.com> wrote:
> > >> >
> > >> > Zhang Chen <zhangckid@gmail.com> writes:
> > >> >
> > >> > > On Thu, Mar 12, 2026 at 5:16=E2=80=AFPM Markus Armbruster <armbr=
u@redhat.com> wrote:
> > >> > >>
> > >> > >> Context...  we're talking about this command:
> > >> > >>
> > >> > >>     ##
> > >> > >>     # @x-blockdev-set-iothread:
> > >> > >>     #
> > >> > >>     # Move @node and its children into the @iothread.  If @ioth=
read is
> > >> > >>     # null then move @node and its children into the main loop.
> > >> > >>     #
> > >> > >>     # The node must not be attached to a BlockBackend.
> > >> > >>     #
> > >> > >>     # @node-name: the name of the block driver node
> > >> > >>     #
> > >> > >>     # @iothread: the name of the IOThread object or null for th=
e main loop
> > >> > >>     #
> > >> > >>     # @force: true if the node and its children should be moved=
 when a
> > >> > >>     #     BlockBackend is already attached
> > >> > >>     #
> > >> > >>     # Features:
> > >> > >>     #
> > >> > >>     # @unstable: This command is experimental and intended for =
test cases
> > >> > >>     #     that need control over IOThreads only.
> > >> > >>     #
> > >> > >>     # Since: 2.12
> > >> > >>     #
> > >> > >>     # .. qmp-example::
> > >> > >>     #    :title: Move a node into an IOThread
> > >> > >>     #
> > >> > >>     #     -> { "execute": "x-blockdev-set-iothread",
> > >> > >>     #          "arguments": { "node-name": "disk1",
> > >> > >>     #                         "iothread": "iothread0" } }
> > >> > >>     #     <- { "return": {} }
> > >> > >>     #
> > >> > >>     # .. qmp-example::
> > >> > >>     #    :title: Move a node into the main loop
> > >> > >>     #
> > >> > >>     #     -> { "execute": "x-blockdev-set-iothread",
> > >> > >>     #          "arguments": { "node-name": "disk1",
> > >> > >>     #                         "iothread": null } }
> > >> > >>     #     <- { "return": {} }
> > >> > >>     ##
> > >> > >>     { 'command': 'x-blockdev-set-iothread',
> > >> > >>       'data' : { 'node-name': 'str',
> > >> > >>                  'iothread': 'StrOrNull',
> > >> > >>                  '*force': 'bool' },
> > >> > >>       'features': [ 'unstable' ],
> > >> > >>       'allow-preconfig': true }
> > >> > >>
> > >> > >>
> > >> > >> Stefan Hajnoczi <stefanha@redhat.com> writes:
> > >> > >>
> > >> > >> > On Tue, Mar 10, 2026 at 06:02:54PM +0800, Zhang Chen wrote:
> > >> > >> >> On Mon, Mar 9, 2026 at 4:15=E2=80=AFPM Stefan Hajnoczi <stef=
anha@redhat.com> wrote:
> > >> > >> >> >
> > >> > >> >> > On Thu, Mar 05, 2026 at 10:24:50PM +0800, Zhang Chen wrote=
:
> > >> > >> >> > > Update the usage of "iothread_get_aio_context()".
> > >> > >> >> > >
> > >> > >> >> > > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > >> > >> >> > > ---
> > >> > >> >> > >  blockdev.c | 9 ++++++++-
> > >> > >> >> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > >> > >> >> > >
> > >> > >> >> > > diff --git a/blockdev.c b/blockdev.c
> > >> > >> >> > > index 6e86c6262f..01ccf64b3f 100644
> > >> > >> >> > > --- a/blockdev.c
> > >> > >> >> > > +++ b/blockdev.c
> > >> > >> >> > > @@ -3683,7 +3683,14 @@ void qmp_x_blockdev_set_iothread(=
const char *node_name, StrOrNull *iothread,
> > >> > >> >> > >              goto out;
> > >> > >> >> > >          }
> > >> > >> >> > >
> > >> > >> >> > > -        new_context =3D iothread_get_aio_context(obj);
> > >> > >> >> > > +        char *path =3D object_get_canonical_path(OBJECT=
(bs));
> > >> > >> >> >
> > >> > >> >> > CCing Kevin and Markus in case they have an opinion on thi=
s.
> > >> > >> >> >
> > >> > >> >> > BlockDriverState is not a QOM Object so using OBJECT(bs) i=
s undefined
> > >> > >> >> > behavior and may crash.
> > >> > >>
> > >> > >> Yes.
> > >> > >>
> > >> > >> >> > node_name is unique across block driver graph nodes and co=
uld be used.
> > >> > >> >> > Unfortunately it's not connected to the QOM Object hierarc=
hy.
> > >> > >>
> > >> > >> Correct.
> > >> > >>
> > >> > >> >> >                                                           =
    Maybe it's
> > >> > >> >> > best to build a holder name that is an invalid QOM path so=
 there can be
> > >> > >> >> > no collisions between QOM paths and block driver graph nod=
es.
> > >> > >>
> > >> > >> I guess you're talking about the values that go into IOThreadIn=
fo member
> > >> > >> holders.  From PATCH 13:
> > >> > >>
> > >> > >>     # @holders: The parameter is an array of QOM paths indicati=
ng how many
> > >> > >>     #     active devices are currently associated with this iot=
hread
> > >> > >>     #     (e.g. virtio-blk).  In hotplug scenarios, users can
> > >> > >>     #     pre-allocate multiple iothread objects to serve as a =
persistent
> > >> > >>     #     thread pool.  When a device is hot-unplugged, the cor=
responding
> > >> > >>     #     IOThread is released but remains available, allowing =
subsequent
> > >> > >>     #     hot-plugged devices to attach to and reuse the existi=
ng thread.
> > >> > >>     #     Returns empty if no devices are attached.  (since 11.=
0)
> > >> > >>     #
> > >> > >>
> > >> > >> I further guess you need it to refer to both QOM objects and bl=
ock
> > >> > >> nodes, and you worry about ambiguity.
> > >> > >>
> > >> > >> Ambiguity indeed exists: a block node name can be a valid QOM p=
ath.
> > >> > >>
> > >> > >> We could restrict QOM paths to absolute paths.  These start wit=
h '/'.
> > >> > >> If I remember correctly, node names cannot contain '/'.
> > >> > >>
> > >> > >> Note that canonical paths (returned object_get_canonical_path()=
) are
> > >> > >> absolute.
> > >> > >>
> > >> > >> We ran into a similar design issue in review of Vladimir's "[PA=
TCH v10
> > >> > >> 4/8] qapi: add blockdev-replace command" not too long ago:
> > >> > >>
> > >> > >>     Subject: Re: [PATCH v10 4/8] qapi: add blockdev-replace com=
mand
> > >> > >>     Date: Wed, 04 Feb 2026 13:26:35 +0100
> > >> > >>     Message-ID: <87wm0sy9s4.fsf@pond.sub.org>
> > >> > >>
> > >> > >> There, the new command needs to refer to QOM object, block node=
, or
> > >> > >> block export.
> > >> > >>
> > >> > >> >> >   g_autofree char *holder =3D g_strdup_printf("BlockDriver=
State %s", node_name);
> > >> > >> >> >
> > >> > >> >> > (A cleaner long-term solution would be making BlockDriverS=
tates QOM
> > >> > >> >> > Objects so they have a proper path.)
> > >> > >>
> > >> > >> Yes, but that's a beefy project, isn't it?
> > >> > >>
> > >> > >> >> If no other comments, it's OK for me. This issue like I ment=
ioned in
> > >> > >> >> patch 7 and 9.
> > >> > >> >
> > >> > >> > A thought about the QAPI interface:
> > >> > >> >
> > >> > >> > QAPI expresses as much information in the schema as possible,=
 so I think
> > >> > >> > the right approach would be a {'union': 'IOThreadHolder',
> > >> > >> > 'discriminator': 'type', ...} that supports at least "qom" an=
d
> > >> > >> > "block-node". That way there are proper types to encode QOM O=
bject paths
> > >> > >> > vs block node-names. Let's avoid having a single string value=
 that takes
> > >> > >> > on different meaning depending on the type of holder.
> > >> > >>
> > >> > >> This shifts the complexity from semantics to syntax.
> > >> > >>
> > >> > >> Semantics: the member can have multiple meanings, and you have =
to
> > >> > >> examine its value to decide which one applies.  The member's
> > >> > >> documentation should specify how to decide.  Say something like=
 "if the
> > >> > >> value starts with '/', it's an absolute QOM path, else it's a b=
lock node
> > >> > >> name".
> > >> > >>
> > >> > >> Syntax: meaning is syntactically obvious.  For instance, union =
of QOM
> > >> > >> path and block node name.
> > >> > >>
> > >> > >> Complex semantics tend to require more complex documentation.
> > >> > >>
> > >> > >> Which choice is better depends on the specific case.  I general=
ly lean
> > >> > >> towards syntax.
> > >> > >>
> > >> > >
> > >> > > I agree Markus's suggestion.
> > >> > > Compare with standard QOM path:
> > >> > > /machine/peripheral/blk0/virtio-backend
> > >> > >
> > >> > > I will try to implement block nodes path like this:
> > >> > > /machine/blockdriverstate/node-name
> > >> >
> > >> > I gather you'd like to try creating QOM objects for block nodes.
> > >> >
> > >> > First, this should not go into /machine.  We already have /chardev=
s and
> > >> > /audiodevs, which suggests something like /blockdevs or /block-nod=
es.
> > >>
> > >> It may be a lot of work. An alternative I suggested was a holder enu=
m
> > >> instead of a string so that QOM paths and block node names can be
> > >> separated with no chance of collisions. That approach is more
> > >> straightforward to implement and the main drawback I see is that the
> > >> enum would become superfluous if block nodes become QOM objects in t=
he
> > >> future. That's not terrible.
> > >>
> > >> Stefan
> > >
> > > Ping....
> > >
> > > Hi Markus and Stefan,
> > > As Markus's comments, I prefer the /blockdevs or /block-nodes is more=
 simple,
> > > And use a holder enum instead of a string will make it more difficult
> > > for users to understand.
> > > Please let us make a decision.
> >
> > I'm not sure what exactly you need from me.
> >
> > I assume you need advice on how to represent a reference to a "holder"
> > in the QAPI schema, where the holder can either be a QOM object or a
> > block node.
> >
> > If everthing was a QOM object, we could simply use a QOM path,
> > i.e. 'str'.
> >
> > Sadly, block nodes are not QOM objects.  Unless you want to solve the
> > (non-trivial) problem of making them QOM objects first, you need
> > something else.
> >
> > My recommendation for something else would be a union:
> >
> >     { 'union': 'IoThreadHolder',
> >       'base': { 'type': 'IoThreadHolderKind' },
> >       'discriminator': 'type',
> >       'data': {
> >           'block-node': ...,
> >           'qom-object': ... } }
> >
> > Stefan, do you agree?
>
> Yes.
>

Thank you for the comments, it's clear for next version.
By the way, It's strange that I didn't receive Markus's previous email.
Anything I missed?

Thanks
Chen

> Stefan
>
> >
> > Hope this helps!
> >
> > > Hi Kevin and Hanna,
> > > Considering the possibility of blockdevs being qom in the future,  we
> > > need your idea here, any comments for the series?
> > >
> > > Thanks
> > > Chen
> >

