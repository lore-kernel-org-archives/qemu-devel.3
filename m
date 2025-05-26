Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCE0C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 08:58:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJTfM-0007z2-Pf; Mon, 26 May 2025 04:58:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uJTfL-0007xQ-4D
 for qemu-devel@nongnu.org; Mon, 26 May 2025 04:58:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uJTfI-0008Hn-KE
 for qemu-devel@nongnu.org; Mon, 26 May 2025 04:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748249914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jzzd0Z2q7oavj1TygOVzuj6Z/b/VFUvuYV5UB2zwGk4=;
 b=EiGVR6rKHiO457lP/sOcfh1lpkyyEY9rLkoRdvgDGIJ4iFRrf+tRqUdIsSblqv9AUN85KW
 HTk1jp7wiU75biLFx8GQUo/v2tQQ+Lrs9jePm2CPCf5kUz6MrVBD05uVMOBE4Gv5wfPg0x
 sTka4IqH4mBWQ5/PO7AznQ2/4VeGh+o=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-78-gabRBkCUN3ihfu9bwQcvGg-1; Mon,
 26 May 2025 04:58:28 -0400
X-MC-Unique: gabRBkCUN3ihfu9bwQcvGg-1
X-Mimecast-MFC-AGG-ID: gabRBkCUN3ihfu9bwQcvGg_1748249905
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 19EB81956095; Mon, 26 May 2025 08:58:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.2])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4244F1956095; Mon, 26 May 2025 08:58:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CA91B21E66C3; Mon, 26 May 2025 10:58:19 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,  Daniel P. =?utf-8?Q?B?=
 =?utf-8?Q?errang=C3=A9?=
 <berrange@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,  Thomas
 Huth <thuth@redhat.com>,  Zhao Liu <zhao1.liu@intel.com>,  Xiaoyao Li
 <xiaoyao.li@intel.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,  qemu-devel@nongnu.org,  Richard
 Henderson <richard.henderson@linaro.org>,  kvm@vger.kernel.org,  Gerd
 Hoffmann <kraxel@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,  Yi Liu <yi.l.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,  Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>,  Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-riscv@nongnu.org,  Weiwei Li <liwei1518@gmail.com>,  Amit Shah
 <amit@kernel.org>,  Yanan Wang <wangyanan55@huawei.com>,  Helge Deller
 <deller@gmx.de>,  Palmer Dabbelt <palmer@dabbelt.com>,  Ani Sinha
 <anisinha@redhat.com>,  Igor Mammedov <imammedo@redhat.com>,  Fabiano
 Rosas <farosas@suse.de>,  Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 qemu-arm@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>,  Jason Wang <jasowang@redhat.com>
Subject: Re: How to mark internal properties
In-Reply-To: <60cd3ba8-2ab1-74ac-54ea-5e3b309788a1@eik.bme.hu> (BALATON
 Zoltan's message of "Tue, 13 May 2025 11:26:31 +0200 (CEST)")
References: <20250508133550.81391-1-philmd@linaro.org>
 <20250508133550.81391-13-philmd@linaro.org>
 <23260c74-01ba-45bc-bf2f-b3e19c28ec8a@intel.com>
 <aB2vjuT07EuO6JSQ@intel.com>
 <2f526570-7ab0-479c-967c-b3f95f9f19e3@redhat.com>
 <CAFEAcA-kuHvxjuV_cMh-Px3C-k2Gd51jFqhwndO52vm++M_jAA@mail.gmail.com>
 <aCG6MuDLrQpoTqpg@redhat.com> <87jz6mqeu5.fsf@pond.sub.org>
 <eedd1fa2-5856-41b8-8e6b-38bd5c98ce8f@nutanix.com>
 <87ecwshqj4.fsf@pond.sub.org>
 <60cd3ba8-2ab1-74ac-54ea-5e3b309788a1@eik.bme.hu>
Date: Mon, 26 May 2025 10:58:19 +0200
Message-ID: <874ix792ac.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

BALATON Zoltan <balaton@eik.bme.hu> writes:

> On Tue, 13 May 2025, Markus Armbruster wrote:
>> Mark Cave-Ayland <mark.caveayland@nutanix.com> writes:
>>> On a related note this also brings us back to the discussion as to the relationship between qdev and QOM: at one point I was under the impression that qdev properties were simply QOM properties that were exposed externally, i.e on the commmand line for use with -device.
>>>
>>> Can you provide an update on what the current thinking is in this area, in particular re: scoping of qdev vs QOM properties?
>>
>> qdev is a leaky layer above QOM.
>>
>> qdev properties are also QOM properties.
>>
>> All device properties are exposed externally.
>
> That was clear but the question was if QOM properties (that are not qdev properties) exist and if so are they also exposed? If not exposed it may be used for internal properties (where simpler solutions aren't convenient) but maybe qdev also adds easier definition of properties that's why they used instead of QOM properties?

I'm afraid we haven't answered your question clearly, yet.  The answer
is yes, QOM properties that are not qdev properties do exist.  The first
one that comes along: ich9_pm_add_properties() adds a bunch to device
ICH9-LPC.  They are exposted externally.  To see them, try

    $ qemu-system-x86_64 -device ICH9-LPC,help

[...]


