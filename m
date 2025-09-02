Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F68CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 07:29:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utLR2-00082y-Vn; Tue, 02 Sep 2025 03:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1utLQt-00082B-Jd
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 03:28:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1utLQn-0006zU-Ls
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 03:27:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756798069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dpF1u5nXWmAgn3o3LsdADLDlOOmkx83IL0RxVjOmH3Q=;
 b=A5USgaTpYiBYWRTw6qtbkIqPUjv46ihWDNKbaTOddbD8+wdPcVs8ER671hAW1u37V5JViJ
 +5RmtW9CTqlUpRNWRg6JrRb6uSC4IdnuWG1D+aQkhEOphVI+88UIt98R2AXTK9/HtNfnlY
 yMrdNMHIjnTKCDCz/MwUHtxbor526Bg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-c1TYhwWVMOqWHDwMKIIJ6A-1; Tue,
 02 Sep 2025 03:27:45 -0400
X-MC-Unique: c1TYhwWVMOqWHDwMKIIJ6A-1
X-Mimecast-MFC-AGG-ID: c1TYhwWVMOqWHDwMKIIJ6A_1756798064
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E0C67195608E; Tue,  2 Sep 2025 07:27:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 43DEA1954B04; Tue,  2 Sep 2025 07:27:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 873C521E6A27; Tue, 02 Sep 2025 09:27:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Steven Lee <steven_lee@aspeedtech.com>,  Troy
 Lee <leetroy@gmail.com>,  Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,  "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>,  "open list:All patches CC here"
 <qemu-devel@nongnu.org>,  troy_lee@aspeedtech.com
Subject: Re: [SPAM] [PATCH v1 02/21] hw/arm/ast27x0: Move SSP coprocessor
 initialization from machine to SoC leve
In-Reply-To: <555f7a62-7332-41a2-a316-e0888fbc819d@kaod.org>
 (=?utf-8?Q?=22C=C3=A9dric?= Le
 Goater"'s message of "Tue, 2 Sep 2025 08:20:40 +0200")
References: <20250717034054.1903991-1-jamin_lin@aspeedtech.com>
 <20250717034054.1903991-3-jamin_lin@aspeedtech.com>
 <555f7a62-7332-41a2-a316-e0888fbc819d@kaod.org>
Date: Tue, 02 Sep 2025 09:27:38 +0200
Message-ID: <87ms7dpb4l.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

C=C3=A9dric Le Goater <clg@kaod.org> writes:

> On 7/17/25 05:40, Jamin Lin wrote:
>> In the previous design, the SSP coprocessor (aspeed27x0ssp-soc) was init=
ialized
>> and realized at the machine level (e.g., AST2700FC). However, to make su=
re the
>> coprocessors can work together properly=E2=80=94such as using the same S=
RAM, sharing
>> the SCU, and having consistent memory remapping=E2=80=94we need to chang=
e how these
>> devices are set up.
>>
>> This commit moves the SSP coprocessor initialization and realization int=
o the
>> AST2700 SoC (aspeed_soc_ast2700_init() and aspeed_soc_ast2700_realize()).
>> By doing so, the SSP becomes a proper child of the SoC device, rather th=
an
>> the machine.
>>
>> This is a preparation step for future commits that will support shared S=
CU,
>> SRAM, and memory remap logic=E2=80=94specifically enabling PSP DRAM rema=
p for SSP SDRAM
>> access.
>>
>> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>

[...]

>> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
>> index 6aa3841b69..ffbc32fef2 100644
>> --- a/hw/arm/aspeed_ast27x0.c
>> +++ b/hw/arm/aspeed_ast27x0.c

[...]

>> @@ -610,9 +619,35 @@ static bool aspeed_soc_ast2700_gic_realize(DeviceSt=
ate *dev, Error **errp)
>>       return true;
>>   }
>>   +static bool aspeed_soc_ast2700_ssp_realize(DeviceState *dev, Error **=
errp)
>
> I would pass 'Aspeed27x0SoCState *' instead.
>
>> +{
>> +    Aspeed27x0SoCState *a =3D ASPEED27X0_SOC(dev);
>> +    AspeedSoCState *s =3D ASPEED_SOC(dev);
>> +    Clock *sysclk;
>> +
>> +    sysclk =3D clock_new(OBJECT(s), "SSP_SYSCLK");
>> +    clock_set_hz(sysclk, 200000000ULL);
>> +    qdev_connect_clock_in(DEVICE(&a->ssp), "sysclk", sysclk);
>> +
>> +    memory_region_init(&a->ssp.memory, OBJECT(&a->ssp), "ssp-memory",
>> +                       UINT64_MAX);
>> +    if (!object_property_set_link(OBJECT(&a->ssp), "memory",
>> +                                  OBJECT(&a->ssp.memory), &error_abort)=
) {
>
> please use errp instead.
>
>> +        return false;
>> +    }

object_property_set_link() can return false only when it fails, and it
sets an error when it fails.  Since you pass &error_abort, it cannot
fail (it aborts instead).  Therefore the return value is always true,
and the return statement is dead code.

If object_property_set_link() is not expected to fail, i.e. failure
would be a programming error, use

        object_property_set_link(..., &error_abort);

If failure is not a programming error, passing &error_abort is wrong,
and you need to pass errp instead.

>> +
>> +    if (!qdev_realize(DEVICE(&a->ssp), NULL, &error_abort)) {
>
> same here.

Same argument.

[...]


