Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36378C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 08:25:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wod7Q-0001dV-5F; Tue, 28 Jul 2026 04:24:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wod7D-0001XE-Ja
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 04:24:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wod7C-000898-7F
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 04:24:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785227081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HKTyObDCnJxQQJ8+7uYSOW7+2EmhUKJ/gSnUEDFpzSo=;
 b=SYck9BGRber+N5RXaOKi6C3n2LOp4u3q4kj9nU6u//27x8Opq7QdBIoJqtt342ClbAGBiU
 JiBs7LDdjGXwXwh0jBZ0m4v+nWVgKNRQXtMYaAU+zFcDECm0C+p5L9a82jSGMX/qWrjJ4n
 P8/r4jnB4HgxJSbv/f1VpdRVLCMjhlE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-69b0cr8lND2Z1w1IWKdMog-1; Tue,
 28 Jul 2026 04:24:37 -0400
X-MC-Unique: 69b0cr8lND2Z1w1IWKdMog-1
X-Mimecast-MFC-AGG-ID: 69b0cr8lND2Z1w1IWKdMog_1785227077
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 82ECA1956063; Tue, 28 Jul 2026 08:24:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7B50F1956044; Tue, 28 Jul 2026 08:24:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 128A021E6920; Tue, 28 Jul 2026 10:24:33 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Michael Roth
 <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: Re: [PATCH v2 50/53] qdev: simplify DEFINE_PROP_ARRAY and remove
 generic array PropertyInfo
In-Reply-To: <87wlufword.fsf@pond.sub.org> (Markus Armbruster's message of
 "Tue, 28 Jul 2026 09:35:02 +0200")
References: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
 <20260616-qom-qapi-v2-50-cc9396b9c18c@redhat.com>
 <87wlufword.fsf@pond.sub.org>
Date: Tue, 28 Jul 2026 10:24:33 +0200
Message-ID: <87jyqfwmgu.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Markus Armbruster <armbru@redhat.com> writes:

> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
>> Change DEFINE_PROP_ARRAY, the macro now uses _arrayprop##_list to
>> resolve the typed list PropertyInfo (introduced in the previous patch)
>> instead of the generic qdev_prop_array.
>>
>> This means the element type and size information is carried by the
>> PropertyInfo itself rather than duplicated at each callsite. Since
>> the typed list PropertyInfos encode element_info and element_size,
>> the .arrayinfo and .arrayfieldsize fields are no longer set by the
>> macro (they will be removed from the Property struct in the next patch).
>>
>> Remove qdev_prop_array, which is now unused.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> [...]
>
>> diff --git a/hw/intc/arm_gicv5_common.c b/hw/intc/arm_gicv5_common.c
>> index b155486af65..61c8ae49302 100644
>> --- a/hw/intc/arm_gicv5_common.c
>> +++ b/hw/intc/arm_gicv5_common.c
>> @@ -191,9 +191,9 @@ static void gicv5_common_realize(DeviceState *dev, E=
rror **errp)
>>=20=20
>>  static const Property arm_gicv5_common_properties[] =3D {
>>      DEFINE_PROP_LINK_ARRAY("cpus", GICv5Common, num_cpus,
>> -                           cpus, TYPE_ARM_CPU, ARMCPU *),
>> +                           cpus, TYPE_ARM_CPU),
>>      DEFINE_PROP_ARRAY("cpu-iaffids", GICv5Common, num_cpu_iaffids,
>> -                      cpu_iaffids, qdev_prop_uint32, uint32_t),
>> +                      cpu_iaffids, qdev_prop_uint32),
>>      DEFINE_PROP_UINT32("irsid", GICv5Common, irsid, 0),
>>      DEFINE_PROP_UINT32("spi-range", GICv5Common, spi_range, 0),
>>      DEFINE_PROP_UINT32("spi-base", GICv5Common, spi_base, 0),
>
> Doesn't compile for me.  I applied the series at merge commit
> 8333dba732.  If it compiles for you, could you push it to where I can
> pull?

I just found base-commit: 2f28d34ea0aead9830478cd1d3d0dd9d9191d82e in
your cover letter, and I'm going to try it.

[...]


