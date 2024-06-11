Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498A2C25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 05:38:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGuBn-0005G0-FQ; Tue, 11 Jun 2024 01:36:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sGuBl-0005FV-Pk
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 01:36:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sGuBj-0004RG-Tl
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 01:36:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718084213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8muqscW0gLMLIVQoE9rAh0RZxnA/AZSMLbOh7Y/hXp4=;
 b=ZHYd62ALCjIE1V4mzViwVppbRwHIuIYpkhVCdFXVx1VrG5GW2SKkNP4ayksCZTrcTjlqQv
 KkFsdmGlQhkArtxeOPlBBsdAT+/n9OdADYfZYZMFzoJd9EkYARKrpgJG7NAD40lOMYxocI
 cvw7wr6Y28ks6C7oXhHR8gLioYRyn/8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-84-Y8WSQOqfONK5sgTygVu8bg-1; Tue,
 11 Jun 2024 01:36:51 -0400
X-MC-Unique: Y8WSQOqfONK5sgTygVu8bg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0BF8319560B8; Tue, 11 Jun 2024 05:36:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8E2C91955E85; Tue, 11 Jun 2024 05:36:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 772C321E6757; Tue, 11 Jun 2024 07:36:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  "Dr. David Alan Gilbert" <dave@treblig.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,  Daniel P .
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  qemu-ppc@nongnu.org
Subject: Re: [PATCH 1/2] hw/misc/mos6522: Expose x-query-mos6522-devices QMP
 command
In-Reply-To: <20240610150758.2827-2-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 10 Jun 2024 17:07:57
 +0200")
References: <20240610150758.2827-1-philmd@linaro.org>
 <20240610150758.2827-2-philmd@linaro.org>
Date: Tue, 11 Jun 2024 07:36:45 +0200
Message-ID: <87sexkujki.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> This is a counterpart to the HMP "info via" command. It is being
> added with an "x-" prefix because this QMP command is intended as an
> adhoc debugging tool and will thus not be modelled in QAPI as fully
> structured data, nor will it have long term guaranteed stability.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  MAINTAINERS             |  2 +-
>  qapi/machine.json       | 17 +++++++++++++++++
>  hw/misc/mos6522-stubs.c | 18 ++++++++++++++++++
>  hw/misc/mos6522.c       |  5 +++--
>  hw/misc/meson.build     |  3 ++-
>  5 files changed, 41 insertions(+), 4 deletions(-)
>  create mode 100644 hw/misc/mos6522-stubs.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 951556224a..e86638c68c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1453,7 +1453,7 @@ F: hw/ppc/mac_newworld.c
>  F: hw/pci-host/uninorth.c
>  F: hw/pci-bridge/dec.[hc]
>  F: hw/misc/macio/
> -F: hw/misc/mos6522.c
> +F: hw/misc/mos6522*.c
>  F: hw/nvram/mac_nvram.c
>  F: hw/ppc/fw_cfg.c
>  F: hw/input/adb*
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 1283d14493..a82b8dd39d 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json

I figure you pick machine.json because it already serves as grabbag of
vaguely device-specific queries like x-query-usb.  misc-target.json is
another grabbag.

> @@ -1865,6 +1865,23 @@
>    'data': { 'filename': 'str' },
>    'if': 'CONFIG_FDT' }
>=20=20
> +##
> +# @x-query-mos6522-devices:
> +#
> +# Query information on MOS6522 VIA devices
> +#
> +# Features:
> +#
> +# @unstable: This command is meant for debugging.
> +#
> +# Returns: MOS6522 VIA devices information
> +#
> +# Since: 9.1
> +##
> +{ 'command': 'x-query-mos6522-devices',
> +  'returns': 'HumanReadableText',
> +  'features': [ 'unstable' ]}
> +
>  ##
>  # @x-query-interrupt-controllers:
>  #

HMP "info via" is compile-time conditional on CONFIG_MOS6522.

Its new QMP counterpart x-query-mos6522-devices is unconditional.
Can you explain why?

Possibly related:

commit 409e9f7131e55e74eb09e65535779e311df5ebf5
Author: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date:   Sat Mar 5 15:09:53 2022 +0000

    mos6522: add "info via" HMP command for debugging
=20=20=20=20
    This displays detailed information about the device registers and timer=
s to aid
    debugging problems with timers and interrupts.
=20=20=20=20
--> Currently the QAPI generators for HumanReadableText don't work correctl=
y if
--> used in qapi/target-misc.json when a non-specified target is built, so =
for
--> now manually add a hmp_info_via() wrapper until direct support for per-=
device
--> HMP/QMP commands is implemented.
=20=20=20=20
    Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
    Reviewed-by: Laurent Vivier <laurent@vivier.eu>
    Message-Id: <20220305150957.5053-9-mark.cave-ayland@ilande.co.uk>
    Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

[...]


