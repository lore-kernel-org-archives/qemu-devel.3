Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A779FCEBF8F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 10:51:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1su8ZE-0005QK-I5; Fri, 27 Sep 2024 06:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1su8Z8-0005HW-Gs
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 06:51:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1su8Z6-0005Xt-7C
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 06:51:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727434254;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mFToqpFLrVdpaSn8ZSYksOPcDnl7+r7uJJzFlzyEnuU=;
 b=CsxRiFw/iwUDbGrhBoqqHMjbSMCuJTDBIt7eOlA3DstdDrbc1B3td3J+Wg2qRCuU1E2W2p
 3XhbJv7AQZBXbTfhHbg/lEjBzDWsDAufAoV2fqHxbH1uSr/utdzu6RNuFP3ViafIWBqZpt
 701VkUcphYFzMtTYiPHD6W8fXFpnOY8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-LfQHs5LmOMqzAGyReOByFA-1; Fri,
 27 Sep 2024 06:50:51 -0400
X-MC-Unique: LfQHs5LmOMqzAGyReOByFA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 017E919034EC; Fri, 27 Sep 2024 10:50:50 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.169])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 39B991956086; Fri, 27 Sep 2024 10:50:44 +0000 (UTC)
Date: Fri, 27 Sep 2024 11:50:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, eblake@redhat.com,
 armbru@redhat.com, ajones@ventanamicro.com
Subject: Re: [PATCH] qapi, machine-qmp-cmds.c: query-accelerator support
Message-ID: <ZvaN7-W4VLr6TGsm@redhat.com>
References: <20240919112056.620917-1-dbarboza@ventanamicro.com>
 <ZuwXjyqhxwHBEvR_@redhat.com>
 <f4c52806-1722-43fc-b4b4-ab17c930d4cd@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f4c52806-1722-43fc-b4b4-ab17c930d4cd@ventanamicro.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Markus: QAPI design Qs for you at the bottom

On Wed, Sep 25, 2024 at 10:19:33AM -0300, Daniel Henrique Barboza wrote:
> 
> 
> On 9/19/24 9:22 AM, Daniel P. Berrangé wrote:
> > On Thu, Sep 19, 2024 at 08:20:56AM -0300, Daniel Henrique Barboza wrote:
> > > Add a QMP command that shows all specific properties of the current
> > > accelerator in use.
> > 
> > Why do we need to expose /everything/ ?
> 
> I wouldn't mind pick and choose advertised properties for the accelerators
> like we do with other APIs.
> 
> This would mean that each arch should choose what to advertise or not, given that
> some accelerator properties might be relevant just for some archs. The API would
> be implemented by each arch individually.

Well with qemu-system-any we might get multiple arches reporting
info in the same binary, so we'll need to fan out to fill in the
per-arch info, after doing a common base.

Hmmm, i wonder if qemu-system-any will support mixing KVM and TCG ?
ie KVM for the host native accelerator, combined with TCG for the
foreign archs ??? Hopefully not !

> > > This can be used as a complement of other APIs like query-machines and
> > > query-cpu-model-expansion, allowing management to get a more complete
> > > picture of the running QEMU process.
> > 
> > query-machines doesn't return every single QOM property, just
> > a hand selected set of information pieces.
> > 
> > The query-cpu-model-expansion does return everything, but I
> > consider that command to be bad design, as it doesn't distinguish
> > between hardware CPU features, and QEMU QOM properties
> > 
> > > 
> > > This is the output with a x86_64 TCG guest:
> > > 
> > > $ ./build/qemu-system-x86_64 -S  -display none -accel tcg -qmp tcp:localhost:1234,server,wait=off
> > > 
> > > $ ./scripts/qmp/qmp-shell localhost:1234
> > > Welcome to the QMP low-level shell!
> > > Connected to QEMU 9.1.50
> > > 
> > > (QEMU) query-accelerator
> > > {"return": {"name": "tcg", "props": {"one-insn-per-tb": false, "thread": "multi", "tb-size": 0, "split-wx": false, "type": "tcg-accel"}}}
> > > 
> > > And for a x86_64 KVM guest:
> > > 
> > > $ ./build/qemu-system-x86_64 -S  -display none -accel kvm -qmp tcp:localhost:1234,server,wait=off
> > > 
> > > $ ./scripts/qmp/qmp-shell localhost:1234
> > > Welcome to the QMP low-level shell!
> > > Connected to QEMU 9.1.50
> > > 
> > > (QEMU) query-accelerator
> > > {"return": {"name": "KVM", "props": {"mem-container-smram[0]": "", "xen-gnttab-max-frames": 64, "device": "", "xen-version": 0, "mem-smram[0]": "", "notify-window": 0, "dirty-ring-size": 0, "kvm-shadow-mem": -1, "type": "kvm-accel", "notify-vmexit": "run", "xen-evtchn-max-pirq": 256}}}
> > > 
> > > Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> > > ---
> > >   hw/core/machine-qmp-cmds.c | 34 ++++++++++++++++++++++++++++++++++
> > >   qapi/machine.json          | 27 +++++++++++++++++++++++++++
> > >   2 files changed, 61 insertions(+)
> > > 
> > > diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
> > > index 130217da8f..eac803bf36 100644
> > > --- a/hw/core/machine-qmp-cmds.c
> > > +++ b/hw/core/machine-qmp-cmds.c
> > 
> > > +AccelInfo *qmp_query_accelerator(Error **errp)
> > > +{
> > > +    AccelState *accel = current_accel();
> > > +    AccelClass *acc = ACCEL_GET_CLASS(accel);
> > > +    AccelInfo *info = g_new0(AccelInfo, 1);
> > > +    QDict *qdict_out = qdict_new();
> > > +    ObjectPropertyIterator iter;
> > > +    ObjectProperty *prop;
> > > +
> > > +    info->name = g_strdup(acc->name);
> > > +
> > > +    object_property_iter_init(&iter, OBJECT(accel));
> > > +    while ((prop = object_property_iter_next(&iter))) {
> > > +        QObject *value;
> > > +
> > > +        if (!prop->get) {
> > > +            continue;
> > > +        }
> > > +
> > > +        value = object_property_get_qobject(OBJECT(accel), prop->name,
> > > +                                                  &error_abort);
> > > +        qdict_put_obj(qdict_out, prop->name, value);
> > > +    }
> > 
> > I'm not at all convinced trhat we should be exposing every single
> > QOM property on the accelerator class as public QMP data
> > 
> > > +
> > > +    if (!qdict_size(qdict_out)) {
> > > +        qobject_unref(qdict_out);
> > > +    } else {
> > > +        info->props = QOBJECT(qdict_out);
> > > +    }
> > > +
> > > +    return info;
> > > +}
> > > diff --git a/qapi/machine.json b/qapi/machine.json
> > > index a6b8795b09..d0d527d1eb 100644
> > > --- a/qapi/machine.json
> > > +++ b/qapi/machine.json
> > > @@ -1898,3 +1898,30 @@
> > >   { 'command': 'x-query-interrupt-controllers',
> > >     'returns': 'HumanReadableText',
> > >     'features': [ 'unstable' ]}
> > > +
> > > +##
> > > +# @AccelInfo:
> > > +#
> > > +# Information about the current accelerator.
> > > +#
> > > +# @name: the name of the current accelerator being used
> > > +#
> > > +# @props: a dictionary of the accelerator properties
> > > +#
> > > +# Since: 9.2
> > > +##
> > > +{ 'struct': 'AccelInfo',
> > > +  'data': { 'name': 'str',
> > > +            '*props': 'any' } }
> > 
> > This is way too open ended. IMHO ideally we would never add more
> > instances of the 'any' type, as it has many downsides
> > 
> >   - zero documentation about what is available
> >   - no version info about when each prop was introduced
> >   - no ability to tag fields as deprecated
> > 
> > For this new API, IMHO 'name' should be an enumeration of the
> > accelerator types, and thenm 'props' should be a discrinated
> > union of accelerator specific structs
> 
> We have accelerator properties that differs from arch to arch, e.g. x86 has properties like
> notify-vmexit, declared in kvm_arch_accel_class_init() from target/i386/kvm/kvm.c, that no
> other arch has access to. RISC-V has its own share of these properties too.
> 
> Is it possible to declare specific structs based on arch for the API? In a quick glance
> it seems like we're doing something like that with query-cpus-fast, where s390x has
> additional properties that are exposed.

To allow for qemu-system-any, which will eventually have multiple arches in
one, I guess we'll need multiple levels of nesting. Perhaps  something like
this:

  { 'enum': 'AccelType',
    'data': ['tcg', 'kvm', ....] }

  { 'union': 'AccelInfo',
    'type': 'AccelType',
    'data': {
        'tcg': 'AccelInfoTCG',
	'kvm': 'AccelInfoKVM',
    } }

  { 'struct': 'AccelInfoTCGX86',
    'data': {
        'notify-vmexit': ...
    } }

  { 'struct': 'AccelInfoTCGArch',
    'data': {
       'x86': 'AccelInfoTCGX86',
       'riscv': 'AccelInfoTCGRiscV',
       ...etc...
    }

  { 'struct': 'AccelInfoTCG',
    'data': {
         ...non-arch specific fields...,
	 'arch': 'AccelInfoTCGArch',
    } }

 ...equiv AccelInfoKVM* structs....

Markus:  any other/better ideas ?

> > > +
> > > +##
> > > +# @query-accelerator:
> > > +#
> > > +# Shows information about the accelerator in use.
> > > +#
> > > +# Returns: a CpuModelExpansionInfo describing the expanded CPU model
> > > +#
> > > +# Since: 9.2
> > > +##
> > > +{ 'command': 'query-accelerator',
> > > +  'returns': 'AccelInfo' }
> > > -- 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


