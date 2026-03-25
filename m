Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52792FEA80C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 05:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5H9R-0007Jp-56; Wed, 25 Mar 2026 01:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w5H9Q-0007Je-8Y
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 01:51:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w5H9O-00060X-Oq
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 01:51:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774417888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gHXmyUOYfW7IzxEt89LrgkcB4shs3Kpb2dNeeBcHAR8=;
 b=Mzh4DAM3elFpS3RNyhVryC7NUKbfoJNTHlx8mGOUGQ8eJVILF2jM1UKQaei1tW4fWKgIgR
 uStOYi9THTBZURopfKIWSG/PhRAs5LNPPCzAUQOc2VRM00HHEeBH2PiyceKu3xMfYopOrI
 +LTogeYns0ZssFRO6J9/Nzj2HKaeeOY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-230-WZ3URSVUMt27atAZvmjMKA-1; Wed,
 25 Mar 2026 01:51:27 -0400
X-MC-Unique: WZ3URSVUMt27atAZvmjMKA-1
X-Mimecast-MFC-AGG-ID: WZ3URSVUMt27atAZvmjMKA_1774417885
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 71843195609D; Wed, 25 Mar 2026 05:51:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A33F31955D71; Wed, 25 Mar 2026 05:51:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 492AB21E6937; Wed, 25 Mar 2026 06:51:22 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,  Philippe =?utf-8?Q?Mathieu-?=
 =?utf-8?Q?Daud=C3=A9?=
 <philmd@linaro.org>,  qemu-devel@nongnu.org,  Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Mark
 Cave-Ayland <mark.cave-ayland@ilande.co.uk>,  Artyom Tarasenko
 <atar4qemu@gmail.com>,  "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>,  Zhao Liu
 <zhao1.liu@intel.com>
Subject: Re: [PATCH-for-11.1 v6 3/6] monitor: Have MonitorDef::get_value()
 always return int64_t type
In-Reply-To: <c0f35257-98ae-4cb8-a73e-2e36bac91a55@linaro.org> (Pierrick
 Bouvier's message of "Tue, 24 Mar 2026 11:34:38 -0700")
References: <20260320091019.59902-1-philmd@linaro.org>
 <20260320091019.59902-4-philmd@linaro.org>
 <87pl4ts7vx.fsf@pond.sub.org>
 <CAFEAcA_y5amOwF-HCM8L3xc1_bSbXxno+HjrLBiOaN25fCt4eA@mail.gmail.com>
 <87tsu5qofj.fsf@pond.sub.org>
 <c0f35257-98ae-4cb8-a73e-2e36bac91a55@linaro.org>
Date: Wed, 25 Mar 2026 06:51:22 +0100
Message-ID: <871ph8picl.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> On 3/24/26 7:42 AM, Markus Armbruster wrote:
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>=20
>>> On Tue, 24 Mar 2026 at 12:57, Markus Armbruster <armbru@redhat.com> wro=
te:
>>>>
>>>> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
>>>>
>>>>> Simplify MonitorDef::get_value() handler by having it always
>>>>> return a int64_t type. Truncate to 32-bit in the single caller.
>>>>>
>>>>> Note, this handler is only implemented once for the x86 targets.
>>>
>>>>> @@ -78,7 +80,8 @@ int get_monitor_def(Monitor *mon, int64_t *pval, co=
nst char *name)
>>>>>       for(; md->name !=3D NULL; md++) {
>>>>>           if (hmp_compare_cmd(name, md->name)) {
>>>>>               if (md->get_value) {
>>>>> -                *pval =3D md->get_value(mon, md, md->offset);
>>>>> +                int64_t val =3D md->get_value(mon, md, md->offset);
>>>>> +                *pval =3D target_long_bits() =3D=3D 32 ? (int32_t)va=
l : val;
>>>>
>>>> This assumes target_long_bits() returns either 32 or 64, doesn't it?
>>>>
>>>> Is this true today?
>>>
>>> It's certainly true today, and we insist on that: exec/target_long.h
>>> handles TARGET_LONG_SIZE being 4 or 8 and will #error on anything else.
>>=20
>> Good.
>>=20
>>> What other values do you expect it could have ?
>>=20
>> There might be a need for 128 in the future.  Not an easy change to
>> make.
>>
>
> The day this will happen, there will be more places to fix than the=20
> current patch, as it's assumed everywhere else that target_long_bits or=20
> TARGET_LONG_BITS is 32 or 64 only. So I would not worry too much about=20
> it at the moment.

Yes, not an easy change to make.

I guess my comment came out of a feeling of unease about

    target_long_bits() =3D=3D 32 ? [32 bit code] : [64 bit code]

I feel there's a bit of friction between abstract requirements and the
concrete software interface.  In the abstract, we need to ask a yes/no
question here.  The concrete interface provides a function that returns
32/64, which works, but isn't obvious from the type.  I guess it's
obvious enough for anybody working in this area of the code.

If truncating to the target's actual width is common, consider providing
function for that.

Feel free to ignore me :)

[...]


