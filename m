Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A81C3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 11:02:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEnO5-0006rj-B1; Tue, 13 May 2025 07:01:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uEnO4-0006qs-8N
 for qemu-devel@nongnu.org; Tue, 13 May 2025 07:01:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uEnO1-0004dd-9L
 for qemu-devel@nongnu.org; Tue, 13 May 2025 07:01:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747134081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TS2yL7ZCoRqSI1GlyDP1hf6SFl052EjkRDbZaOdY3kM=;
 b=LiJQRXiBBd3oKahPsXMeg9sgfbqB2XZ2WH+N++EKP1xPtgq97WT+o9GoWLkAHqQ85k9A+h
 FRNhiEYHQ0MX9srourO2QnafB3ZGzx2A1qOwsEzqYDA+7LLq6FdsPYsjOpjMkYxPcuAIWj
 RiKv1aaqBqoaMrcxW8G+b/G+BCpH1XI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-355-x9G-84KkPWytHRhwPHMyKQ-1; Tue,
 13 May 2025 07:01:20 -0400
X-MC-Unique: x9G-84KkPWytHRhwPHMyKQ-1
X-Mimecast-MFC-AGG-ID: x9G-84KkPWytHRhwPHMyKQ_1747134076
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A636A1953976; Tue, 13 May 2025 11:01:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BDAA830001A1; Tue, 13 May 2025 11:01:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1772A21E66E3; Tue, 13 May 2025 13:01:11 +0200 (CEST)
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
Date: Tue, 13 May 2025 13:01:11 +0200
Message-ID: <87v7q4epvs.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
>
>> We use device properties for:
>>
>> * Letting users configure pluggable devices, with -device or device_add
>>
>> * Letting code configure onboard devices
>>
>>  For onboard devices that are also pluggable, everything exposed to
>>  code is also exposed externally.  This might be a mistake in places.
>
> If a device is pluggable, theoretically a user could create a machine from them declaratively, e.g. starting from a "none" machine or like plugging cards in a motherboard so their properties should be exposed as long as those properties correspond to the device pins they model or configurable options. Only properties that are implementation details should not be exposed because setting them can break the device. There are a few places where we have such properties. But you say "in places" so I think you meant the same.

Building machines declaratively has been the dream for many years.

I chose to write "might be in places", because I can't point to examples
offhand to support a stronger claim :)

External interfaces should be intentional, i.e. carefully curated to
serve actual use cases.  They should also be stable and documented.

The QOM parts of our external interfaces are largely accidental,
unstable, and undocumented.  We have some internal need, we create
something to serve it, and expose it externally simply because we lack
the means not to.

>> * Letting the machine versioning machinery adjust device configuration
>>
>>  Some properties are meant to be used just for this.  They're exposed
>>  externally regardless, which is a mistake.
>
> Question is if we want to allow users to tweak these compatibility options, like selectively enable/disable when migrating between QEMU versions or for testing. It might have some uses and maybe that's the reason why people would like these to go through deprecation instead of just dropping them. Marking some properties not exposed would get the same resistance then so may not solve the issue.

If you need to mess with properties to make migration work, that's a
bug.  That's versioning machinery's job.

External interfaces just for testing can be okay.  We should not promise
stability there.  We should still be intentional, and we should still
document.

Attempts to get rid of external interfaces always draw resistance, even
when they're accidental.


