Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D8CFF9EDCA
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 13:06:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFXH8-0007cT-Q4; Wed, 22 Apr 2026 09:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wFXH4-0007c5-LP
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 09:05:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wFXH2-0002QM-Ak
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 09:05:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776863145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 resent-to:resent-from:resent-message-id:in-reply-to:in-reply-to:
 references:references; bh=yEF8doncWix4ktRWxiXro4NFPpyPdr0jhT71VMZJda4=;
 b=PlkUO1PCwRROAVpRroHsy8ZCe/rc14RrI8gLE11OrSD/C+H7w4k/QVeU8V/0o/zFYjt2bp
 fSXMjenPc5y7WpoJHuzbYp1wrbixxh7rRkFl39RP7O8hPsXySkIEG3jSqIO+7IjU9tJqaG
 rkG+1XyU9t+oQhHnh4CccPbR+24916Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-w50cfSS2MMm4Iw04sHgbtg-1; Wed,
 22 Apr 2026 09:05:43 -0400
X-MC-Unique: w50cfSS2MMm4Iw04sHgbtg-1
X-Mimecast-MFC-AGG-ID: w50cfSS2MMm4Iw04sHgbtg_1776863143
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CCA1719560B4; Wed, 22 Apr 2026 13:05:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.30])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E8721800351; Wed, 22 Apr 2026 13:05:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C9C3821E6A28; Wed, 22 Apr 2026 15:05:39 +0200 (CEST)
Resent-To: marcandre.lureau@gmail.com, qemu-devel@nongnu.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Wed, 22 Apr 2026 15:05:39 +0200
Resent-Message-ID: <87bjfbxhzw.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: About query-qmp-schema
In-Reply-To: <CAJ+F1CLQjQ5_FrCyxiQoxGFiU7m_pdqsKY+4P2GsRS1yKCdu+Q@mail.gmail.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 22 Apr 2026
 00:19:23 +0400")
References: <CAJ+F1C+ukA5ZBDLaeTmjwKXdiOdG6Ob11+nUG0Ct_SpAaUx+Mw@mail.gmail.com>
 <CAJ+F1CLQjQ5_FrCyxiQoxGFiU7m_pdqsKY+4P2GsRS1yKCdu+Q@mail.gmail.com>
Date: Wed, 22 Apr 2026 13:35:31 +0200
Message-ID: <87ldefz0qk.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Tue, Apr 21, 2026 at 12:11=E2=80=AFPM Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@gmail.com> wrote:
>>
>> Hi
>>
>> The query-qmp-schema returns a stripped-down version, removing types
>> unused by commands and events. It also renames types with integers.
>>
>> That makes it impractical for a client to know which values are
>> acceptable for a generic qom-set commands:

Wanting to know which values are acceptable for qom-set is fair.  The
means we provide for that (QOM introspection) are flawed.

>>                                            qom-list returns the real
>> "unmasked" type name,

If you're lucky.  More on that below.

>>                       and it may be a type that is not even used by
>> qmp commands/events.

Yes, because query-qmp-schema returns the *QMP* schema.

>>                      A quick test shows the current schema is about
>> ~243kb of json. With all types, it grows to ~273kb. Unmask it grows to
>> ~308kb.
>>
>> Could we send the full version? Eventually, we could have a "flavour":
>> "full" argument.
>>
>> Another option is to compress the schema. A "full-gz" in baes64 would be=
 51kb.
>
> After some experiments and some thoughts, here is what I propose:
> - Replace QLit representation with a compressed JSON - the JSON is
> built-evaluated at compile time to handle the #if conditions and
> produce the per-target schema

I wouldn't mind QLit to go.  I don't want to lose the ability to inspect
the generated introspection value, though.

We used to generate JSON returned by query-qmp-schema as a string.  Easy
to read for me.

Commit 7d0f982bfb (qapi: generate a literal qobject for introspection)
replaced it with QLit.  Harder to read, but still workable, especially
with 8c643361eeb (qapi: Add comments to aid debugging generated
introspection).

Compressed JSON would be unreadable.  Generate a comment with the
uncompressed JSON?

> - At runtime, query-qmp-schema decompresses it and parses the JSON to
> keep compatibility with existing commands, applying filtering and
> typename substitution
> - Add a query-qmp-schema-data, which returns the unmodified compressed
> JSON schema blob (~35kb in base64)

If we expose QAPI schema type names externally, they become ABI.  The
design decision not to has enabled schema refactorings time and again.
Changing that feels like a bad idea.

Instead of making QAPI introspection worse to match QOM introspection,
let's make QOM introspection better to match QAPI introspection: use the
same masked type names.

> - additionally, I'd like a way for the client to query the
> documentation. Having a similar query-qmp-schema-doc would result in
> shipping ~135kb of gz content, which could be shared by all binaries
> (since the doc doesn't have configuration).

John Snow mentioned a desire to access QMP documentation via QMP.  I
figure it could use a bit more structure than dumping the generated HTML
or the ReST-with-extensions source.  We should talk, but let's put this
aside while we discuss QOM introspection.

> Please comment, thanks

First, the type names returned by qom-list and qom-list-properties are
problematic.  Here's the documentation:

    # @type: the type of the property.  This will typically come in one of
    #     four forms:
    #
    #     1) A primitive type such as 'u8', 'u16', 'bool', 'str', or
    #        'double'.  These types are mapped to the appropriate JSON
    #        type.
    #
    #     2) A child type in the form 'child<subtype>' where subtype is a
    #        qdev device type name.  Child properties create the
    #        composition tree.
    #
    #     3) A link type in the form 'link<subtype>' where subtype is a
    #        qdev device type name.  Link properties form the device model
    #        graph.

Pretty much every sentence is misleading or wrong:

* Type names "come in four forms", but we document just three.  The
  missing fourth form is a type that's neither "primitive", "child", nor
  "link".

* The primitive types are "defined" by listing a few examples, and
  waving hands towards JSON.  Srsly?!?

* A "child type" can refer to any object type, not just device types.

* Same for "link type".

So what are the *actual* types?  Find attached a rough Python script to
find most of the type names used for QOM properties in
qemu-system-x86_64.

"Most of" because it can't find properties created after object
initialization, and it needs to skip a few objects that crash on
introspection (will report separately).  Good enough for this memo.

Of type type names the script finds, the following are returned by
query-qmp-schema (checked with grep -E '=3D (name1|name2|...)'
qapi/qapi-introspect.c):

    BlockdevOnError
    DisplayGLMode
    GrabToggleKeys
    GuestPanicInformation
    GuestPanicInformationHyperV
    GuestPanicInformationS390
    GuestPanicInformationSev
    GuestPanicInformationTdx
    GuestPanicInformationType
    HostMemPolicy
    MigMode
    MultiFDCompression
    NetFilterDirection
    OnOffAuto
    QAuthZListPolicy
    QAuthZListRule
    QCryptoSecretFormat
    QCryptoTLSCredsEndpoint
    SgxEPCDeviceInfo
    SgxEPCDeviceInfoWrapper
    SocketAddress
    SocketAddressLegacy
    SocketAddressType
    StrOrNull
    ThrottleLimits
    ZeroPageDetection
    bool
    int
    str

The following aren't, but they exist in the schema (checked with grep
-Eh '# @(name1|name2|...)' qapi/*json):

    BiosAtaTranslation
    BootConfiguration
    CXLFixedMemoryWindowOptions
    FloppyDriveType
    GranuleMode
    IOThreadVirtQueueMapping
    LostTickPolicy
    MemorySizeConfiguration
    OffAutoPCIBAR
    PCIELinkSpeed
    PCIELinkWidth
    SMPConfiguration
    SgxEPC
    SgxEPCDeviceInfo
    SgxEPCDeviceInfoWrapper
    SgxEPCProperties
    SmpCachePropertiesWrapper
    VirtIOGPUOutput
    X86CPUFeatureWordInfo

The following are built-in QAPI types we intentionally do not expose in
query-qmp-schema:

    int32
    size
    uint16
    uint32
    uint64
    uint8

The following aren't QAPI types all:

    CXLFixedMemoryWindow
    NotifyVMexitOption
    PCSouthBridgeOption
    QemuUUID
    SpdmTransportType
    busnr
    guest statistics
    int32_t
    list
    on|off|split
    string
    uint32_t
    uint64_t

Some of them are C types, some of them aren't even that.

Nothing ensures the type names returned by qom-list and
qom-list-properties correspond to anything.  It's all convention and
developer diligence (or lack thereof).  This makes these type names
*unreliable*.

Nothing requires QOM properties to be of a QAPI type.  Developers are
free to use QAPI visitors as they see fit.

Your proposal does not address these issues.

Alan Perlis's epigram applies: "Beware of the Turing tar-pit in which
everything is possible but nothing of interest is easy."

We should make defining a QOM property of QAPI type easy.  Properties
defined that way should get the correct type name automatically.

Fixing all properties in one go feels impractical.  Therefore, type
names remain unreliable.  I propose to add another, reliable member next
to it: the masked QAPI name.  Present only for properties defined the
QAPI way.


Example run of my script:

$ PYTHONPATH=3Dpython python/qemu/utils/qom-type-names.py
216 child<>
982 link<>
103003 other
property types: ['BiosAtaTranslation', 'BlockdevOnError', 'BootConfiguratio=
n', 'CXLFixedMemoryWindow', 'DisplayGLMode', 'FloppyDriveType', 'GrabToggle=
Keys', 'GranuleMode', 'GuestPanicInformation', 'HostMemPolicy', 'IOThreadVi=
rtQueueMapping', 'LostTickPolicy', 'MemorySizeConfiguration', 'MigMode', 'M=
ultiFDCompression', 'NetFilterDirection', 'NotifyVMexitOption', 'OffAutoPCI=
BAR', 'OnOffAuto', 'PCIELinkSpeed', 'PCIELinkWidth', 'PCSouthBridgeOption',=
 'QAuthZListPolicy', 'QAuthZListRule', 'QCryptoSecretFormat', 'QCryptoTLSCr=
edsEndpoint', 'QemuUUID', 'SMPConfiguration', 'SgxEPC', 'SmpCacheProperties=
Wrapper', 'SocketAddress', 'SpdmTransportType', 'StrOrNull', 'ThrottleLimit=
s', 'VirtIOGPUOutput', 'X86CPUFeatureWordInfo', 'ZeroPageDetection', 'bool'=
, 'busnr', 'guest statistics', 'int', 'int32', 'int32_t', 'list', 'on|off|s=
plit', 'size', 'str', 'string', 'uint16', 'uint32', 'uint32_t', 'uint64', '=
uint64_t', 'uint8']
good refs: ['PCI', 'base-xhci', 'bus', 'can-bus', 'cfi.pflash01', 'confiden=
tial-guest-support', 'cryptodev-backend', 'cxl-upstream', 'device', 'esp', =
'gpex-root', 'hotplug-handler', 'i2c-bus', 'i2c-ddc', 'i8042', 'iommufd', '=
iothread', 'ipmi-bmc', 'irq', 'mc146818rtc', 'mch', 'memory-backend', 'memo=
ry-region', 'nitro-vsock-bus', 'nvme-subsys', 'piix3-ide', 'piix4-ide', 'pi=
t-common', 'ps2-kbd', 'ps2-mouse', 'rng-backend', 'sdhci-bus', 'serial', 't=
hread-context', 'vhost-scsi', 'vhost-user-blk', 'vhost-user-fs-device', 'vh=
ost-user-gpio-device', 'vhost-user-gpu', 'vhost-user-i2c-device', 'vhost-us=
er-input', 'vhost-user-rng', 'vhost-user-scsi', 'vhost-user-snd', 'vhost-us=
er-spi-device', 'vhost-user-test-device', 'vhost-user-vsock-device', 'vhost=
-vdpa-device', 'vhost-vsock-device', 'virtio-9p-device', 'virtio-balloon-de=
vice', 'virtio-blk-device', 'virtio-crypto-device', 'virtio-gpu-device', 'v=
irtio-gpu-gl-device', 'virtio-input-host-device', 'virtio-iommu-device', 'v=
irtio-keyboard-device', 'virtio-mem', 'virtio-mouse-device', 'virtio-multit=
ouch-device', 'virtio-net-device', 'virtio-pmem', 'virtio-rng-device', 'vir=
tio-scsi-device', 'virtio-serial-device', 'virtio-sound-device', 'virtio-ta=
blet-device']
dangling refs: ['memory-backend-epc']


--=-=-=
Content-Type: text/x-python
Content-Disposition: attached; filename=qom-type-names.py

#!/usr/bin/env python3

import sys

from qemu.machine import QEMUMachine

def main():
    obj_types = set()
    refs = set()
    prop_types = set()
    nchild = nlink = nother = 0
    broken_obj_types = {
        'colo-compare',
        'cryptodev-backend-lkcf',
        'memory-region-portio-list',
        'qemu-fixed-text-console',
        'qemu-graphic-console',
        'qio-net-listener',
        'x-remote-object',
    }
    vm = QEMUMachine(binary='bld-x86/qemu-system-x86_64')
    vm.launch()

    resp = vm.qmp('qom-list-types', {'abstract': True})
    otinfos = resp['return']
    concrete_obj_types = set([info['name']
                              for info in otinfos if not info.get('abstract')])
    obj_types = set([info['name']
                     for info in otinfos])

    for ot in concrete_obj_types - broken_obj_types:
        resp = vm.qmp('qom-list-properties', {'typename': ot})
        opinfos = resp['return']
        for info in opinfos:
            pt = info['type']
            if pt.startswith('child<'):
                nchild += 1
                refs.add(pt[6:-1])
            elif pt.startswith('link<'):
                nlink += 1
                refs.add(pt[5:-1])
            else:
                if pt.endswith('List'):
                    pt = pt[:-4]
                nother += 1
                prop_types.add(pt)
                ref = None

    print(f'{nchild} child<>')
    print(f'{nlink} link<>')
    print(f'{nother} other')
    print(f'property types: {sorted(prop_types)}')
    print(f'good refs: {sorted(refs & obj_types)}')
    print(f'dangling refs: {sorted(refs - obj_types)}')

    vm.shutdown()

if __name__ == '__main__':
    sys.exit(main())

--=-=-=--


