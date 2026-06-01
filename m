Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9496CD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 14:14:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU3OS-0001o4-SJ; Mon, 01 Jun 2026 10:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wU3OK-0001dI-8V
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 10:13:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wU3OI-0000Yx-J0
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 10:13:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780323198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q4mAxw6LJGsSxtvy10XVCImBCVKwU22fquA7pM4XS8U=;
 b=iQoSfjAe92k5DGBQgxKDGz99m1YtNqK2fVNXsWptQr5lm/6o6tHZAkYMMrgLW6ZXXeeuaK
 N8eycJRxpdhBa0xn8GIsYOVRGrXz0jT6/oqE6n4E+Vao47FzLXX+OXKMWKYA7SW9REfuk4
 Vp1AGMRQljIIuxe+xwPxk7fjEXxam9c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659--_4Ie5k5OAW47wPuWEQotw-1; Mon,
 01 Jun 2026 10:13:14 -0400
X-MC-Unique: -_4Ie5k5OAW47wPuWEQotw-1
X-Mimecast-MFC-AGG-ID: -_4Ie5k5OAW47wPuWEQotw_1780323193
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E565D192E275; Mon,  1 Jun 2026 14:09:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D67AA19560A3; Mon,  1 Jun 2026 14:09:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 059B021E6A01; Mon, 01 Jun 2026 16:09:33 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Mateusz Nowicki <mateusz.nowicki@posteo.net>
Cc: qemu-devel@nongnu.org,  "Dr . David Alan Gilbert" <dave@treblig.org>,
 Keith Busch <kbusch@kernel.org>,  Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>,  Zhao Liu <zhao1.liu@intel.com>,  Eric Blake
 <eblake@redhat.com>,  qemu-block@nongnu.org
Subject: Re: [PATCH v3 1/2] hw/nvme: add 'info nvme' HMP command
In-Reply-To: <20260522102821.16766-2-mateusz.nowicki@posteo.net> (Mateusz
 Nowicki's message of "Fri, 22 May 2026 10:29:18 +0000")
References: <20260522102821.16766-1-mateusz.nowicki@posteo.net>
 <20260522102821.16766-2-mateusz.nowicki@posteo.net>
Date: Mon, 01 Jun 2026 16:09:32 +0200
Message-ID: <87v7c2wdwj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Mateusz Nowicki <mateusz.nowicki@posteo.net> writes:

> Add an 'info nvme' HMP command for inspecting emulated NVMe
> controllers from the QEMU monitor.
>
> For each NVMe controller in the QOM tree the command prints:
>
>   - PCI BDF, vendor/device ID and BAR0 base address;
>   - Identify Controller fields visible to the host driver: SN, MN, FR
>     and CNTLID;
>   - the CC, CSTS and AQA registers (raw 32-bit values);
>   - the number of admin and active I/O submission/completion queues.
>
> Useful when debugging the Linux NVMe driver against the QEMU emulation
> without attaching gdb to the QEMU process.
>
> Example:
>
>   (qemu) info nvme
>   /machine/peripheral-anon/device[0]
>     PCI:    BDF 00:04.0  VID=8086 DID=5845  BAR0=0x00000000feb50000
>     ID:     SN=NVME0001  MN=QEMU NVMe Ctrl  FR=...  CNTLID=0x0000
>     CC:     0x00460001
>     CSTS:   0x00000001
>     AQA:    0x001f001f
>     Queues: 1 admin + 4 IO SQ / 4 IO CQ
>
> Signed-off-by: Mateusz Nowicki <mateusz.nowicki@posteo.net>
> Acked-by: Dr. David Alan Gilbert <dave@treblig.org>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hmp-commands-info.hx | 13 ++++++++
>  hw/nvme/meson.build  |  2 +-
>  hw/nvme/monitor.c    | 76 ++++++++++++++++++++++++++++++++++++++++++++
>  qapi/machine.json    | 17 ++++++++++
>  4 files changed, 107 insertions(+), 1 deletion(-)
>  create mode 100644 hw/nvme/monitor.c
>
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index 82134eb6c2..b984691c3c 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -340,6 +340,19 @@ SRST
>      Show guest USB devices.
>  ERST
>  
> +    {
> +        .name       = "nvme",
> +        .args_type  = "",
> +        .params     = "",
> +        .help       = "show emulated NVMe controllers",
> +        .cmd_info_hrt = qmp_x_query_nvme,
> +    },
> +
> +SRST
> +  ``info nvme``
> +    Show emulated NVMe controllers.
> +ERST
> +
>      {
>          .name       = "usbhost",
>          .args_type  = "",
> diff --git a/hw/nvme/meson.build b/hw/nvme/meson.build
> index 7d5caa53c2..33dee048b0 100644
> --- a/hw/nvme/meson.build
> +++ b/hw/nvme/meson.build
> @@ -1 +1 @@
> -system_ss.add(when: 'CONFIG_NVME_PCI', if_true: files('ctrl.c', 'dif.c', 'ns.c', 'subsys.c', 'nguid.c'))
> \ No newline at end of file
> +system_ss.add(when: 'CONFIG_NVME_PCI', if_true: files('ctrl.c', 'dif.c', 'ns.c', 'subsys.c', 'nguid.c', 'monitor.c'))

Keep this list alphabetically sorted, please.

I can tidy this up myself in my tree.

[...]


