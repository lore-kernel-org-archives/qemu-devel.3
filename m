Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B474CCD4F24
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 11:52:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN87u-0004xj-KW; Wed, 13 May 2026 07:51:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wN87t-0004xR-8f
 for qemu-devel@nongnu.org; Wed, 13 May 2026 07:51:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wN87r-0006Qb-5W
 for qemu-devel@nongnu.org; Wed, 13 May 2026 07:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778673101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ERw7ay+PnhwAUmUt6/ho5cu028Ir/y2whNm8lMrbmVY=;
 b=al+CsDJToGHwcwt9uFb5KiLubVcQli7mZsvvXXedsH0m1XGqH0ItuiH/CX/mp9wg2qMgXk
 0t9GmuLt7k3pYckAAz9Dm83rH4dXJJQmcmJirjiMfCpU2jUEFunXmyO3DS/TvyIkkrBg+/
 0ScFY2UQ3HBbXHqSRBhH9Fu9F0muwiQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-490-HS1z8_CTP-OYC3c6l5EG6g-1; Wed,
 13 May 2026 07:51:37 -0400
X-MC-Unique: HS1z8_CTP-OYC3c6l5EG6g-1
X-Mimecast-MFC-AGG-ID: HS1z8_CTP-OYC3c6l5EG6g_1778673096
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7AB3D195608D; Wed, 13 May 2026 11:51:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5AEB630001BE; Wed, 13 May 2026 11:51:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A4B1E21E6A01; Wed, 13 May 2026 13:51:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: Mateusz Nowicki <mateusz.nowicki@posteo.net>,  qemu-devel@nongnu.org,
 qemu-block@nongnu.org,  Keith Busch <kbusch@kernel.org>,  Klaus Jensen
 <its@irrelevant.dk>,  Jesper Devantier <foss@defmacro.it>,  Eric Blake
 <eblake@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 1/2] hw/nvme: add 'info nvme' HMP command
In-Reply-To: <agJuVpu7EwtRNcMU@gallifrey> (David Alan Gilbert's message of
 "Tue, 12 May 2026 00:03:34 +0000")
References: <cover.1778409416.git.mateusz.nowicki@posteo.net>
 <f419a9cf97e79b5148c10cd0a3c138dccb5d36a0.1778409416.git.mateusz.nowicki@posteo.net>
 <agJuVpu7EwtRNcMU@gallifrey>
Date: Wed, 13 May 2026 13:51:31 +0200
Message-ID: <87o6ijr0ho.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

"Dr. David Alan Gilbert" <dave@treblig.org> writes:

> * Mateusz Nowicki (mateusz.nowicki@posteo.net) wrote:
>> Add an 'info nvme' HMP command for inspecting emulated NVMe
>> controllers from the QEMU monitor.
>> 
>> For each NVMe controller in the QOM tree the command prints:
>> 
>>   - PCI BDF, vendor/device ID and BAR0 base address;
>>   - Identify Controller fields visible to the host driver: SN, MN, FR
>>     and CNTLID;
>>   - the CC, CSTS and AQA registers (raw 32-bit values);
>>   - the number of admin and active I/O submission/completion queues.
>> 
>> Useful when debugging the Linux NVMe driver against the QEMU emulation
>> without attaching gdb to the QEMU process.
>> 
>> Example:
>> 
>>   (qemu) info nvme
>>   /machine/peripheral-anon/device[0]
>>     PCI:    BDF 00:04.0  VID=8086 DID=5845  BAR0=0x00000000feb50000
>>     ID:     SN=NVME0001  MN=QEMU NVMe Ctrl  FR=...  CNTLID=0x0000
>>     CC:     0x00460001
>>     CSTS:   0x00000001
>>     AQA:    0x001f001f
>>     Queues: 1 admin + 4 IO SQ / 4 IO CQ
>
> I won't claim to know what those NVMe magic numbers mean, but I'll
> trust you they're useful.
>
>> Signed-off-by: Mateusz Nowicki <mateusz.nowicki@posteo.net>
>> ---
>>  hmp-commands-info.hx | 13 ++++++++
>>  hw/nvme/meson.build  |  2 +-
>>  hw/nvme/monitor.c    | 76 ++++++++++++++++++++++++++++++++++++++++++++
>>  qapi/machine.json    | 17 ++++++++++
>
> So that lot looks OK from an HMP point of view, I wonder if
> qapi/machine.json is the right place for it.  Markus?

qapi/machine.json has become a bit of a dumping ground, I'm afraid.

Precedence for putting queries for the machine's device frontends of
certain kinds there: x-query-irq, x-query-interrupt-controllers, and
x-query-usb.

All the other NVMe QAPI stuff is in qapi/block-core.json, but that's the
block backend, not frontend.  Not a good home for x-query-nvme.

Let's take the patch as is.

One nitpick below.

> Acked-by: Dr. David Alan Gilbert <dave@treblig.org>
>
>>  4 files changed, 107 insertions(+), 1 deletion(-)
>>  create mode 100644 hw/nvme/monitor.c
>> 
>> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
>> index 82134eb6c2..b984691c3c 100644
>> --- a/hmp-commands-info.hx
>> +++ b/hmp-commands-info.hx
>> @@ -340,6 +340,19 @@ SRST
>>      Show guest USB devices.
>>  ERST
>>  
>> +    {
>> +        .name       = "nvme",
>> +        .args_type  = "",
>> +        .params     = "",
>> +        .help       = "show emulated NVMe controllers",
>> +        .cmd_info_hrt = qmp_x_query_nvme,
>> +    },
>> +
>> +SRST
>> +  ``info nvme``
>> +    Show emulated NVMe controllers.
>> +ERST
>> +
>>      {
>>          .name       = "usbhost",
>>          .args_type  = "",
>> diff --git a/hw/nvme/meson.build b/hw/nvme/meson.build
>> index 7d5caa53c2..3017f058f9 100644
>> --- a/hw/nvme/meson.build
>> +++ b/hw/nvme/meson.build
>> @@ -1 +1 @@
>> -system_ss.add(when: 'CONFIG_NVME_PCI', if_true: files('ctrl.c', 'dif.c', 'ns.c', 'subsys.c', 'nguid.c'))
>> \ No newline at end of file
>> +system_ss.add(when: 'CONFIG_NVME_PCI', if_true: files('ctrl.c', 'dif.c', 'ns.c', 'subsys.c', 'nguid.c', 'monitor.c'))
>> \ No newline at end of file

Please use the opportunity to add the newline.

[...]

QAPI schema
Acked-by: Markus Armbruster <armbru@redhat.com>


