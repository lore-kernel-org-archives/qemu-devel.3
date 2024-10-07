Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35485CFB43F
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 09:54:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxkRV-0000G5-1g; Mon, 07 Oct 2024 05:54:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sxkRS-0000Ff-6D
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 05:54:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sxkRP-0006CE-OE
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 05:54:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728294839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KlrcALPKmT8uwS8PyU/7IJmwF0Z+X09TH/klQ+x1bE8=;
 b=WfmslEo9LuL8mR0VENoLEV2Pe1WWXv2bZvLg3lHCBbU95oia5d59duuUQua/rgNYtg76wa
 8zbeoj5q3wAdZxT9siysMbcWw6IPGbVTYMDz8WVjPDaTqo3HoOtm6Jk3EfwO0YUh9JceaO
 mIDQno9bsJ1USPsB8whXTb877co1a+k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-6AUBZF-3NoaUYh4yQxMblA-1; Mon,
 07 Oct 2024 05:53:56 -0400
X-MC-Unique: 6AUBZF-3NoaUYh4yQxMblA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A3AFD195FE3C; Mon,  7 Oct 2024 09:53:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.47])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 49E0919560AA; Mon,  7 Oct 2024 09:53:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4FA4621E6A28; Mon,  7 Oct 2024 11:53:50 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 qemu-devel@nongnu.org,  peter.maydell@linaro.org,  eduardo@habkost.net,
 marcel.apfelbaum@gmail.com,  philmd@linaro.org,  wangyanan55@huawei.com,
 zhao1.liu@intel.com,  eblake@redhat.com,  ajones@ventanamicro.com
Subject: Re: [PATCH] qapi, machine-qmp-cmds.c: query-accelerator support
In-Reply-To: <ZvaN7-W4VLr6TGsm@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Fri, 27 Sep 2024 11:50:42 +0100")
References: <20240919112056.620917-1-dbarboza@ventanamicro.com>
 <ZuwXjyqhxwHBEvR_@redhat.com>
 <f4c52806-1722-43fc-b4b4-ab17c930d4cd@ventanamicro.com>
 <ZvaN7-W4VLr6TGsm@redhat.com>
Date: Mon, 07 Oct 2024 11:53:50 +0200
Message-ID: <874j5onsr5.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> Markus: QAPI design Qs for you at the bottom
>
> On Wed, Sep 25, 2024 at 10:19:33AM -0300, Daniel Henrique Barboza wrote:
>>=20
>>=20
>> On 9/19/24 9:22 AM, Daniel P. Berrang=C3=A9 wrote:
>> > On Thu, Sep 19, 2024 at 08:20:56AM -0300, Daniel Henrique Barboza wrot=
e:
>> > > Add a QMP command that shows all specific properties of the current
>> > > accelerator in use.
>> >=20
>> > Why do we need to expose /everything/ ?
>>=20
>> I wouldn't mind pick and choose advertised properties for the accelerato=
rs
>> like we do with other APIs.
>>=20
>> This would mean that each arch should choose what to advertise or not, g=
iven that
>> some accelerator properties might be relevant just for some archs. The A=
PI would
>> be implemented by each arch individually.
>
> Well with qemu-system-any we might get multiple arches reporting
> info in the same binary, so we'll need to fan out to fill in the
> per-arch info, after doing a common base.
>
> Hmmm, i wonder if qemu-system-any will support mixing KVM and TCG ?
> ie KVM for the host native accelerator, combined with TCG for the
> foreign archs ??? Hopefully not !
>
>> > > This can be used as a complement of other APIs like query-machines a=
nd
>> > > query-cpu-model-expansion, allowing management to get a more complete
>> > > picture of the running QEMU process.
>> >=20
>> > query-machines doesn't return every single QOM property, just
>> > a hand selected set of information pieces.
>> >=20
>> > The query-cpu-model-expansion does return everything, but I
>> > consider that command to be bad design, as it doesn't distinguish
>> > between hardware CPU features, and QEMU QOM properties
>> >=20
>> > >=20
>> > > This is the output with a x86_64 TCG guest:
>> > >=20
>> > > $ ./build/qemu-system-x86_64 -S  -display none -accel tcg -qmp tcp:l=
ocalhost:1234,server,wait=3Doff
>> > >=20
>> > > $ ./scripts/qmp/qmp-shell localhost:1234
>> > > Welcome to the QMP low-level shell!
>> > > Connected to QEMU 9.1.50
>> > >=20
>> > > (QEMU) query-accelerator
>> > > {"return": {"name": "tcg", "props": {"one-insn-per-tb": false, "thre=
ad": "multi", "tb-size": 0, "split-wx": false, "type": "tcg-accel"}}}
>> > >=20
>> > > And for a x86_64 KVM guest:
>> > >=20
>> > > $ ./build/qemu-system-x86_64 -S  -display none -accel kvm -qmp tcp:l=
ocalhost:1234,server,wait=3Doff
>> > >=20
>> > > $ ./scripts/qmp/qmp-shell localhost:1234
>> > > Welcome to the QMP low-level shell!
>> > > Connected to QEMU 9.1.50
>> > >=20
>> > > (QEMU) query-accelerator
>> > > {"return": {"name": "KVM", "props": {"mem-container-smram[0]": "", "=
xen-gnttab-max-frames": 64, "device": "", "xen-version": 0, "mem-smram[0]":=
 "", "notify-window": 0, "dirty-ring-size": 0, "kvm-shadow-mem": -1, "type"=
: "kvm-accel", "notify-vmexit": "run", "xen-evtchn-max-pirq": 256}}}
>> > >=20
>> > > Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> > > ---
>> > >   hw/core/machine-qmp-cmds.c | 34 ++++++++++++++++++++++++++++++++++
>> > >   qapi/machine.json          | 27 +++++++++++++++++++++++++++
>> > >   2 files changed, 61 insertions(+)
>> > >=20
>> > > diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
>> > > index 130217da8f..eac803bf36 100644
>> > > --- a/hw/core/machine-qmp-cmds.c
>> > > +++ b/hw/core/machine-qmp-cmds.c
>> >=20
>> > > +AccelInfo *qmp_query_accelerator(Error **errp)
>> > > +{
>> > > +    AccelState *accel =3D current_accel();
>> > > +    AccelClass *acc =3D ACCEL_GET_CLASS(accel);
>> > > +    AccelInfo *info =3D g_new0(AccelInfo, 1);
>> > > +    QDict *qdict_out =3D qdict_new();
>> > > +    ObjectPropertyIterator iter;
>> > > +    ObjectProperty *prop;
>> > > +
>> > > +    info->name =3D g_strdup(acc->name);
>> > > +
>> > > +    object_property_iter_init(&iter, OBJECT(accel));
>> > > +    while ((prop =3D object_property_iter_next(&iter))) {
>> > > +        QObject *value;
>> > > +
>> > > +        if (!prop->get) {
>> > > +            continue;
>> > > +        }
>> > > +
>> > > +        value =3D object_property_get_qobject(OBJECT(accel), prop->=
name,
>> > > +                                                  &error_abort);
>> > > +        qdict_put_obj(qdict_out, prop->name, value);
>> > > +    }
>> >=20
>> > I'm not at all convinced trhat we should be exposing every single
>> > QOM property on the accelerator class as public QMP data
>> >=20
>> > > +
>> > > +    if (!qdict_size(qdict_out)) {
>> > > +        qobject_unref(qdict_out);
>> > > +    } else {
>> > > +        info->props =3D QOBJECT(qdict_out);
>> > > +    }
>> > > +
>> > > +    return info;
>> > > +}
>> > > diff --git a/qapi/machine.json b/qapi/machine.json
>> > > index a6b8795b09..d0d527d1eb 100644
>> > > --- a/qapi/machine.json
>> > > +++ b/qapi/machine.json
>> > > @@ -1898,3 +1898,30 @@
>> > >   { 'command': 'x-query-interrupt-controllers',
>> > >     'returns': 'HumanReadableText',
>> > >     'features': [ 'unstable' ]}
>> > > +
>> > > +##
>> > > +# @AccelInfo:
>> > > +#
>> > > +# Information about the current accelerator.
>> > > +#
>> > > +# @name: the name of the current accelerator being used
>> > > +#
>> > > +# @props: a dictionary of the accelerator properties
>> > > +#
>> > > +# Since: 9.2
>> > > +##
>> > > +{ 'struct': 'AccelInfo',
>> > > +  'data': { 'name': 'str',
>> > > +            '*props': 'any' } }
>> >=20
>> > This is way too open ended. IMHO ideally we would never add more
>> > instances of the 'any' type, as it has many downsides
>> >=20
>> >   - zero documentation about what is available
>> >   - no version info about when each prop was introduced
>> >   - no ability to tag fields as deprecated

Yes, 'any' is best avoided in stable interfaces.

>> > For this new API, IMHO 'name' should be an enumeration of the
>> > accelerator types, and thenm 'props' should be a discrinated
>> > union of accelerator specific structs
>>=20
>> We have accelerator properties that differs from arch to arch, e.g. x86 =
has properties like
>> notify-vmexit, declared in kvm_arch_accel_class_init() from target/i386/=
kvm/kvm.c, that no
>> other arch has access to. RISC-V has its own share of these properties t=
oo.
>>=20
>> Is it possible to declare specific structs based on arch for the API? In=
 a quick glance
>> it seems like we're doing something like that with query-cpus-fast, wher=
e s390x has
>> additional properties that are exposed.

Yes.  Schema pattern:

    { 'union: ...,
      'base': {
          'target': 'SysEmuTarget',
          ... target-independent data ... }
      'data': {
          T: { ... data for target T ... }
          ... } }

On the wire:

    {"target": T,
     ... target-independent data ...
     ... data for target T}

This is for returning info on a single target.

Typically, a qemu-system-T will only ever return branch T.  The other
branches are dead code.  Tolerable.

With qemu-system-any, which provides multiple (eventually all, we hope)
targets, the union still has data for just one target.  To get data for
multiple targets, we'd have to return several objects.

Fine for query-cpus-fast: it returns a CpuInfoFast per CPU, and each of
them uses the branch T appropriate for the CPU.

> To allow for qemu-system-any, which will eventually have multiple arches =
in
> one,

Actually, qemu-system-any can work almost exactly like the existing
qemu-system-T, until we mix in heterogeneous machines.

Without heterogeneous machines, qemu-system-any's target T gets fixed at
some point.  From that point on, no difference to qemu-system-T.

The "almost" is for running commands before that point.

This applies to all commands that take the target as implicit input.  I
believe several exist.

How accelerators will work for heterogeneous machines is not clear to
me.  Until it is, I can't really advise on how to design accelerator
information for them.

>      I guess we'll need multiple levels of nesting. Perhaps  something li=
ke
> this:
>
>   { 'enum': 'AccelType',
>     'data': ['tcg', 'kvm', ....] }
>
>   { 'union': 'AccelInfo',
>     'type': 'AccelType',
>     'data': {
>         'tcg': 'AccelInfoTCG',
> 	'kvm': 'AccelInfoKVM',
>     } }
>
>   { 'struct': 'AccelInfoTCGX86',
>     'data': {
>         'notify-vmexit': ...
>     } }
>
>   { 'struct': 'AccelInfoTCGArch',
>     'data': {
>        'x86': 'AccelInfoTCGX86',
>        'riscv': 'AccelInfoTCGRiscV',
>        ...etc...
>     }
>
>   { 'struct': 'AccelInfoTCG',
>     'data': {
>          ...non-arch specific fields...,
> 	 'arch': 'AccelInfoTCGArch',
>     } }

Here, you want to return data for all targets, not just one.  Instead of
a sum type (union branches), you use a product type (struct members).
Feels fair.

>  ...equiv AccelInfoKVM* structs....

The only target that can actually work is the one matching the host
hardware.  Perhaps we want to return just that.

> Markus:  any other/better ideas ?

I guess there are other ways to skin this cat.  But I think there are
questions to ask before we delve deeper:

1. query-accelerator use cases?  What accelerator information exactly do
we need to provide for them?

2. How fancy do we want to get for homogeneous qemu-system-any before
the target gets fixed?

3. How will accelerators work for heterogeneous qemu-system-any?

[...]


