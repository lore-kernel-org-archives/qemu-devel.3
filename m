Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF5AC3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 08:33:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ4lB-0002lp-JP; Wed, 31 Jul 2024 04:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sZ4lA-0002l8-Go
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 04:32:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sZ4l7-0001YM-CG
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 04:32:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722414750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=btIcE9RgOI2DuErRk2jZPSA4sTMB/8y0hynpBu3aXm0=;
 b=WCcTAi5AhPSB99Y1WQu7LnQj0p39LJG5+RCzEQvwvCEGy60oYJaak4AH6MDIEHv+vAS4sr
 nkGTKIqXLxI4J7Z0vvH96H4xViYF9nI3uDC4bmBX0L5TCjSNuPIxvGpnIBMZw3jGFYpgsC
 vrNkjLtOBofB10xtCVQUuk5MwkbyCdk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-kUETRoRqOEy6Cc91dJnudA-1; Wed,
 31 Jul 2024 04:32:25 -0400
X-MC-Unique: kUETRoRqOEy6Cc91dJnudA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5BBB21955F56; Wed, 31 Jul 2024 08:32:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 338D719560AE; Wed, 31 Jul 2024 08:32:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F23D221E6690; Wed, 31 Jul 2024 10:32:19 +0200 (CEST)
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
In-Reply-To: <20240714-rombar-v2-0-af1504ef55de@daynix.com> (Akihiko Odaki's
 message of "Sun, 14 Jul 2024 16:48:30 +0900")
References: <20240714-rombar-v2-0-af1504ef55de@daynix.com>
Date: Wed, 31 Jul 2024 10:32:19 +0200
Message-ID: <87a5hyj71o.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

> rom_bar is tristate but was defined as uint32_t so convert it into
> OnOffAuto to clarify that. For compatibility, a uint32 value set via
> QOM will be converted into OnOffAuto.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

I agree making property "rombar" an integer was a design mistake.  I
further agree that vfio_pci_size_rom() peeking into dev->opts to
distinguish "user didn't set a value" from "user set the default value")
is an unadvisable hack.

However, ...

> ---
> Changes in v2:
> - Documented in docs/about/deprecated.rst (Daniel P. Berrang=C3=A9)
> - Link to v1: https://lore.kernel.org/r/20240706-rombar-v1-0-802daef2aec1=
@daynix.com
>
> ---
> Akihiko Odaki (4):
>       qapi: Add visit_type_str_preserving()
>       qapi: Do not consume a value when visit_type_enum() fails
>       hw/pci: Convert rom_bar into OnOffAuto
>       hw/qdev: Remove opts member
>
>  docs/about/deprecated.rst         |  7 +++++
>  docs/igd-assign.txt               |  2 +-
>  include/hw/pci/pci_device.h       |  2 +-
>  include/hw/qdev-core.h            |  4 ---
>  include/qapi/visitor-impl.h       |  3 ++-
>  include/qapi/visitor.h            | 25 +++++++++++++----
>  hw/core/qdev.c                    |  1 -
>  hw/pci/pci.c                      | 57 +++++++++++++++++++++++++++++++++=
++++--
>  hw/vfio/pci-quirks.c              |  2 +-
>  hw/vfio/pci.c                     | 11 ++++----
>  hw/xen/xen_pt_load_rom.c          |  4 +--
>  qapi/opts-visitor.c               | 12 ++++-----
>  qapi/qapi-clone-visitor.c         |  2 +-
>  qapi/qapi-dealloc-visitor.c       |  4 +--
>  qapi/qapi-forward-visitor.c       |  4 ++-
>  qapi/qapi-visit-core.c            | 21 ++++++++++++---
>  qapi/qobject-input-visitor.c      | 23 ++++++++--------
>  qapi/qobject-output-visitor.c     |  2 +-
>  qapi/string-input-visitor.c       |  2 +-
>  qapi/string-output-visitor.c      |  2 +-
>  system/qdev-monitor.c             | 12 +++++----
>  tests/qtest/virtio-net-failover.c | 32 +++++++++++-----------
>  22 files changed, 161 insertions(+), 73 deletions(-)
> ---
> base-commit: f2cb4026fccfe073f84a4b440e41d3ed0c3134f6
> change-id: 20240704-rombar-1a4ba2890d6c
>
> Best regards,

... this is an awful lot of QAPI visitor infrastructure.  Infrastructure
that will likely only ever be used for this one property.

Moreover, the property setter rom_bar_set() is a hack: it first tries to
parse the value as enum, and if that fails, as uint32_t.  QAPI already
provides a way to express "either this type or that type": alternate.
Like this:

    { 'alternate': 'OnOffAutoUint32',
      'data': { 'sym': 'OnOffAuto',
                'uint': 'uint32' } }

Unfortunately, such alternates don't work on the command line due to
keyval visitor restrictions.  These cannot be lifted entirely, but we
might be able to lift them sufficiently to make this alternate work.

Whether it would be worth your trouble and mine just to clean up
"rombar" seems highly dubious, though.


