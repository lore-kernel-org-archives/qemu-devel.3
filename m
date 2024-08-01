Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2FDEC3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 11:01:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZTXZ-0005Xw-R7; Thu, 01 Aug 2024 07:00:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sZTXX-0005WT-RA
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 07:00:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sZTXV-000367-Am
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 07:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722510007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zqmco2BoOAbprzEGhESuG53s62PGf38ko48l4pyKGqo=;
 b=BErehbBk689X6jKZ1n/MQF6Y994SCcb7FtrE9FEpoqDBRG987OuNMhegWPjosj4QuZeW4R
 rEBFN/Vj/pIBHLE0+ctPzpqmRdTczuHPgbGlWlI+E5HNA/dWd8CmdR/09rq35BfceWXBM4
 k/ECzSHOEyyoJQgZrlbVarwHx4TrYZE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-xbYWKAviPrm5BM12jDnyzQ-1; Thu,
 01 Aug 2024 07:00:03 -0400
X-MC-Unique: xbYWKAviPrm5BM12jDnyzQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2503F1955D5F; Thu,  1 Aug 2024 11:00:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AE6781955E76; Thu,  1 Aug 2024 10:59:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8E24921E6692; Thu,  1 Aug 2024 12:59:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  "Michael
 S. Tsirkin"
 <mst@redhat.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,  Alex
 Williamson <alex.williamson@redhat.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,  Jason Wang
 <jasowang@redhat.com>,  Keith Busch <kbusch@kernel.org>,  Klaus Jensen
 <its@irrelevant.dk>,  qemu-devel@nongnu.org,  qemu-block@nongnu.org
Subject: Re: [PATCH v2 0/4] hw/pci: Convert rom_bar into OnOffAuto
In-Reply-To: <8ee4464e-f9b3-48bc-9fa3-0b5f0d2a5faf@daynix.com> (Akihiko
 Odaki's message of "Thu, 1 Aug 2024 16:01:44 +0900")
References: <20240714-rombar-v2-0-af1504ef55de@daynix.com>
 <87a5hyj71o.fsf@pond.sub.org>
 <8ee4464e-f9b3-48bc-9fa3-0b5f0d2a5faf@daynix.com>
Date: Thu, 01 Aug 2024 12:59:57 +0200
Message-ID: <87h6c4fqz6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> On 2024/07/31 17:32, Markus Armbruster wrote:
>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>=20
>>> rom_bar is tristate but was defined as uint32_t so convert it into
>>> OnOffAuto to clarify that. For compatibility, a uint32 value set via
>>> QOM will be converted into OnOffAuto.
>>>
>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>=20
>> I agree making property "rombar" an integer was a design mistake.  I
>> further agree that vfio_pci_size_rom() peeking into dev->opts to
>> distinguish "user didn't set a value" from "user set the default value")
>> is an unadvisable hack.
>>=20
>> However, ...
>>=20
>>> ---
>>> Changes in v2:
>>> - Documented in docs/about/deprecated.rst (Daniel P. Berrang=C3=A9)
>>> - Link to v1: https://lore.kernel.org/r/20240706-rombar-v1-0-802daef2ae=
c1@daynix.com
>>>
>>> ---
>>> Akihiko Odaki (4):
>>>        qapi: Add visit_type_str_preserving()
>>>        qapi: Do not consume a value when visit_type_enum() fails
>>>        hw/pci: Convert rom_bar into OnOffAuto
>>>        hw/qdev: Remove opts member
>>>
>>>   docs/about/deprecated.rst         |  7 +++++
>>>   docs/igd-assign.txt               |  2 +-
>>>   include/hw/pci/pci_device.h       |  2 +-
>>>   include/hw/qdev-core.h            |  4 ---
>>>   include/qapi/visitor-impl.h       |  3 ++-
>>>   include/qapi/visitor.h            | 25 +++++++++++++----
>>>   hw/core/qdev.c                    |  1 -
>>>   hw/pci/pci.c                      | 57 ++++++++++++++++++++++++++++++=
+++++++--
>>>   hw/vfio/pci-quirks.c              |  2 +-
>>>   hw/vfio/pci.c                     | 11 ++++----
>>>   hw/xen/xen_pt_load_rom.c          |  4 +--
>>>   qapi/opts-visitor.c               | 12 ++++-----
>>>   qapi/qapi-clone-visitor.c         |  2 +-
>>>   qapi/qapi-dealloc-visitor.c       |  4 +--
>>>   qapi/qapi-forward-visitor.c       |  4 ++-
>>>   qapi/qapi-visit-core.c            | 21 ++++++++++++---
>>>   qapi/qobject-input-visitor.c      | 23 ++++++++--------
>>>   qapi/qobject-output-visitor.c     |  2 +-
>>>   qapi/string-input-visitor.c       |  2 +-
>>>   qapi/string-output-visitor.c      |  2 +-
>>>   system/qdev-monitor.c             | 12 +++++----
>>>   tests/qtest/virtio-net-failover.c | 32 +++++++++++-----------
>>>   22 files changed, 161 insertions(+), 73 deletions(-)
>>> ---
>>> base-commit: f2cb4026fccfe073f84a4b440e41d3ed0c3134f6
>>> change-id: 20240704-rombar-1a4ba2890d6c
>>>
>>> Best regards,
>>=20
>> ... this is an awful lot of QAPI visitor infrastructure.  Infrastructure
>> that will likely only ever be used for this one property.
>>=20
>> Moreover, the property setter rom_bar_set() is a hack: it first tries to
>> parse the value as enum, and if that fails, as uint32_t.  QAPI already
>> provides a way to express "either this type or that type": alternate.
>> Like this:
>>=20
>>      { 'alternate': 'OnOffAutoUint32',
>>        'data': { 'sym': 'OnOffAuto',
>>                  'uint': 'uint32' } }
>>=20
>> Unfortunately, such alternates don't work on the command line due to
>> keyval visitor restrictions.  These cannot be lifted entirely, but we
>> might be able to lift them sufficiently to make this alternate work.
>
> The keyval visitor cannot implement alternates because the command line=20
> input does not have type information. For example, you cannot=20
> distinguish string "0" and integer 0.

Correct.

For alternate types, an input visitor picks the branch based on the
QType.

With JSON, we have scalar types null, number, string, and bool.

With keyval, we only have string.  Alternates with more than one scalar
branch don't work.

They could be made to work to some degree, though.  Observe:

* Any value can be a string.

* "frob" can be nothing else.

* "on" and "off" can also be bool.

* "123" and "1e3" can also be number or enum.

Instead of picking the branch based on the QType, we could pick based on
QType and value, where the value part is delegated to a visitor method.

This is also new infrastructure.  But it's more generally useful
infrastructure.

>> Whether it would be worth your trouble and mine just to clean up
>> "rombar" seems highly dubious, though.
>
> rom_bar_set() and and underlying visit_type_str_preserving() are ugly,=20
> but we can remove them once the deprecation period ends. On the other=20
> hand, if we don't make this change, dev->opts will keep floating around,=
=20
> and we will even have another use of it for "[PATCH v5 1/8] hw/pci: Do=20
> not add ROM BAR for SR-IOV VF"[1]. Eventually, having this refactoring=20
> early will result in less mess in the future.
>
> [1]: lore.kernel.org/r/20240715-sriov-v5-1-3f5539093ffc@daynix.com

Here's another idea.

Property "rombar" is backed by PCIDevice member uint32_t rom_bar, and
defaults to 1.

The code uses member rom_bar as if it was a boolean: it tests
zero/non-zero.

vfio_pci_size_rom() additionally uses qdict_haskey(dev->opts, "rombar")
to see whether "rombar" was set by the user.

Taken together, "rom_bar" has three abstract states: zero,
non-zero-default, non-zero-user.  The concrete representation uses
dev->opts in addition to member rom_bar.  This is unusual.

You propose to represent as OnOffAuto instead, with On for
non-zero-user, Off for zero, Auto for non-zero-default.  Fine, except
for the compatibility headaches.

OnOffAuto is not the only option for encoding these three states.  We
could also do positive, 0, negative.  Like this:

* Change "rombar" from unsigned to signed.

* Change its default to -1.

* Now 0 means off, positive means on, and negative means auto.

The change to signed breaks rombar=3DN for 2^31<=3DN<2^32.  Do we care?
Only if we have reason to fear something passes such values.  I doubt
it.  I'd expect only rombar=3D0 and rombar=3D1.

If we do care, we could create a special kind of property that maps any
positive value to 1.

With the change, we no longer reject rombar=3DN for -2^31<=3DN<0.  That's
not a compatiblity break.

Thoughts?


