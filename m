Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F8BCCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 12:42:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBubD-0006oe-DW; Thu, 23 Oct 2025 08:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vBuap-0006XS-7e
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:39:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vBual-0000wy-F4
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:38:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761223131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nrICuWHY7mjRal5EkNAEKD1FmbbP2dlIg0AQuUlvJ5c=;
 b=bvDgWjtYht9hjFEwS5J9MmGvDyTx3vnkj0eIGSAnsAa3lUFat6RzmoHwwVos8WU3ZkSXyp
 n69YGtQzsxkeQ/M7RjKo3JkTbVia5pvBGppoIeq89p4VhHKnINFySgwsr2DPmdjkG/fr9M
 pMnsTvm4fpQRvO7ZbrgP2NbI6txBrbA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-CEZoH32BORa8bMZtizNrlQ-1; Thu,
 23 Oct 2025 08:38:47 -0400
X-MC-Unique: CEZoH32BORa8bMZtizNrlQ-1
X-Mimecast-MFC-AGG-ID: CEZoH32BORa8bMZtizNrlQ_1761223127
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 02D4B195609F; Thu, 23 Oct 2025 12:38:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.19])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0BECC1800353; Thu, 23 Oct 2025 12:38:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 451CF21E6A27; Thu, 23 Oct 2025 14:38:43 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peter
 Maydell <peter.maydell@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 00/32] Encode object type security status in code
In-Reply-To: <20250926140144.1998694-1-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Fri, 26 Sep 2025 15:01:11
 +0100")
References: <20250926140144.1998694-1-berrange@redhat.com>
Date: Thu, 23 Oct 2025 14:38:43 +0200
Message-ID: <87o6px6be4.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> Our docs/system/security.rst file loosely classifies code into that
> applicable for 'virtualization' vs 'non-virtualization' use cases.
> Only code relevant to the former group is eligible for security
> bug handling. Peter's recent proposal pointed out that we are
> increasingly hitting the limits of such a crude classification
>
> Michael suggested that with the increased complexity, docs are not
> going to be an effective way to convey the information, and we
> need to re-consider embedding this info in code.  This also allows
> users to validate a configuration's security status when starting
> a guest, or modifying a running guest.
>
> This series is an attempt to start the embedding process.
>
> Probably I should split in multiple series. One introducing the
> overall framework, and then multiple series doing type annotations,
> as the latter really need to be CC'd to maintainers, but the CC
> list would be way too huge on this combined series. At least this
> combined series shows what the real world implictions of this code
> approach will be though.

I appreciate seeing the entire work.  We can split later if it helps
with review.

> It starts with QOM, adding a "bool secure" property to the
> TypeInfo struct, which get turned into a flag on the Type
> struct. This enables querying any ObjectClass to ask whether or
> not it is declared secure.
>
> By only using a single boolean flag, at runtime we are unable
> to distinguish between "marked insecure" and "no decision,
> implicitly insecure". As such, all our existing code is
> initially considered insecure, except for that which gets
> explicit annotation.
>
> The "-compat" argument gains a new parameter
>
>   * insecure-types=3Daccept|reject|warn
>
>     The default 'accept' preserves historical behaviour of
>     anything being permissible. The other two options both
>     identify use of types that are not explicitly marked
>     as secure.
>
> The code annotations are useful immediately, but to make the
> new -compat switch useful, we need to annotate as much as is
> possible. This series makes a strong attempt to do that across
> a large subset of the codebase. My guidance was to mark enough
> as being 'secure', that a downstream RHEL build of QEMU would
> have explicit anntation of most of its devices, with most being
> secure given they target virtualization use cases.
>
> This annotation is 90% complete for the x86 target, but more
> work is needed to finish it and then address the arch specific
> devices for arm, ppc, s390.
>
> Example: TCG is explicitly insecure, KVM is explicitly secure:

[...]

>  281 files changed, 632 insertions(+), 38 deletions(-)

PATCH 01..13, i.e. just the infrastructure:

 docs/system/security.rst     | 43 ++++++++++++++++++++++++++++++++++++++++=
+++
 qapi/compat.json             | 24 +++++++++++++++++++++++-
 qapi/machine.json            |  8 +++++++-
 qapi/qom.json                | 10 ++++++++--
 include/hw/boards.h          | 12 +++++++++++-
 include/hw/i386/pc.h         | 13 ++++++++++++-
 include/qapi/compat-policy.h |  5 +++++
 include/qom/object.h         | 13 +++++++++++++
 hw/core/machine-qmp-cmds.c   |  1 +
 qapi/qapi-util.c             | 30 ++++++++++++++++++++++++++++++
 qom/object.c                 | 30 +++++++++++++++++++++++-------
 qom/qom-qmp-cmds.c           | 30 ++++++++++++++++++++++++------
 system/qdev-monitor.c        | 12 ++++++++++++
 system/vl.c                  | 35 ++++++++++++++++++++++++++++++-----
 14 files changed, 242 insertions(+), 24 deletions(-)

Quite tractable.

The remainder is purely declarative:

    $ git-diff -U0 3f6db27c42..review | egrep '^[-+][^-+]'| sed 's/  */ /g'=
 | sort -u
    + .abstract =3D true,
    + .class_init =3D i2c_ddc_class_init,
    + .instance_init =3D aw_emac_init,
    + .instance_init =3D xhci_sysbus_instance_init,
    + .secure =3D false,
    + .secure =3D true,
    + .secure =3D true, \
    + isapc_machine_options);
    + type_info.secure =3D false,
    + type_info.secure =3D false;
    + type_info.secure =3D true,
    + xenfv_machine_3_1_options);
    + xenfv_machine_4_2_options);
    +DEFINE_INSECURE_MACHINE("none", machine_none_machine_init)
    +DEFINE_INSECURE_PC_MACHINE(isapc, "isapc", pc_init_isa,
    +DEFINE_SECURE_MACHINE("xenpv", xenpv_machine_init)
    +DEFINE_SECURE_PC_MACHINE(xenfv, "xenfv-3.1", pc_xen_hvm_init,
    +DEFINE_SECURE_PC_MACHINE(xenfv_4_2, "xenfv-4.2", pc_xen_hvm_init,
    - .abstract =3D true
    - .class_init =3D i2c_ddc_class_init
    - .instance_init =3D aw_emac_init,
    - .instance_init =3D xhci_sysbus_instance_init
    - isapc_machine_options);
    - xenfv_machine_3_1_options);
    - xenfv_machine_4_2_options);
    -DEFINE_MACHINE("none", machine_none_machine_init)
    -DEFINE_MACHINE("xenpv", xenpv_machine_init)
    -DEFINE_PC_MACHINE(isapc, "isapc", pc_init_isa,
    -DEFINE_PC_MACHINE(xenfv, "xenfv-3.1", pc_xen_hvm_init,
    -DEFINE_PC_MACHINE(xenfv_4_2, "xenfv-4.2", pc_xen_hvm_init,

I like it.


