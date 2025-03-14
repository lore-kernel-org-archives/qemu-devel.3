Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94340C282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 09:39:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt1VU-0007g4-5y; Fri, 14 Mar 2025 05:39:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tt1VS-0007eu-NJ
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 05:39:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tt1VL-000639-8L
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 05:39:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741945137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xVxleWGDhBLG0PueD6xI76IURlcNAeogH0mCQm+b290=;
 b=JbFuRQSE0tB2DOmxF2GlWGobdNO5H4dHnajZfMv5oqHenukVBWLV18HWHrBrhB8tPzlvSe
 cOW3OGAYcCxA0AmqVRYc29b/PUcu2YvztfnecGOYFPzEGw19TQo+3sVY7TP6aYZqCU11F5
 PjLA8w3n/URWkNwU1gBWxxGS71ufoiQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350-HSP-PMgaPvmzUPMEp-gteg-1; Fri,
 14 Mar 2025 05:38:49 -0400
X-MC-Unique: HSP-PMgaPvmzUPMEp-gteg-1
X-Mimecast-MFC-AGG-ID: HSP-PMgaPvmzUPMEp-gteg_1741945128
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A66C3180AB1C; Fri, 14 Mar 2025 09:38:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0DAC91955F2D; Fri, 14 Mar 2025 09:38:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5030321E675F; Fri, 14 Mar 2025 10:38:42 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: bibo mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>,  Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 2/3] hw/loongarch/virt: Remove unnecessary NULL
 pointer checking
In-Reply-To: <63fc3b2b-140c-a4e4-c3ec-536cc31d9f11@loongson.cn> (bibo mao's
 message of "Fri, 14 Mar 2025 17:25:45 +0800")
References: <20250314084201.4182054-1-maobibo@loongson.cn>
 <20250314084201.4182054-3-maobibo@loongson.cn>
 <87plikrn81.fsf@pond.sub.org>
 <63fc3b2b-140c-a4e4-c3ec-536cc31d9f11@loongson.cn>
Date: Fri, 14 Mar 2025 10:38:42 +0100
Message-ID: <87ldt8q7dp.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

bibo mao <maobibo@loongson.cn> writes:

On 2025/3/14 =E4=B8=8B=E5=8D=885:11, Markus Armbruster wrote:
>> Bibo Mao <maobibo@loongson.cn> writes:
>>=20
>>> There is NULL pointer checking function error_propagate() already,
>>> it is not necessary to add checking for function parameter. Here remove
>>> NULL pointer checking with function parameter.
>>>
>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>

[...]

>>> @@ -1001,9 +999,8 @@ static void virt_cpu_plug(HotplugHandler *hotplug_=
dev,
>>         cpu_slot =3D virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id);
>>         cpu_slot->cpu =3D CPU(dev);
>>         if (lvms->ipi) {
>>             hotplug_handler_plug(HOTPLUG_HANDLER(lvms->ipi), dev, &err);
>>             if (err) {
>>                 error_propagate(errp, err);
>>                 return;
>>             }
>>         }
>>=20
>>         if (lvms->extioi) {
>>             hotplug_handler_plug(HOTPLUG_HANDLER(lvms->extioi), dev, &er=
r);
>>             if (err) {
>>                 error_propagate(errp, err);
>>                 return;
>>             }
>>         }
>>>=20=20=20
>>>       if (lvms->acpi_ged) {
>>>           hotplug_handler_plug(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &e=
rr);
>>> -        if (err) {
>>> -            error_propagate(errp, err);
>>> -        }
>>> +        error_propagate(errp, err);
>>> +        return;
>>>       }
>>>=20=20=20
>>>       return;
>>=20
>> Better make this work exactly like the other checks above, and drop the
>> final return, which serves no purpose:
>>=20
>>             if (err) {
>>                 error_propagate(errp, err);
>>                 return;
>>             }
>>         }
> Here is report from commandline, it say err NULL check is not necessary
> spatch --sp-file scripts/coccinelle/error_propagate_null.cocci --dir=20
> hw/loongarch/
>
> @@ -1001,9 +997,7 @@ static void virt_cpu_plug(HotplugHandler
>
>       if (lvms->acpi_ged) {
>           hotplug_handler_plug(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &err=
);
> -        if (err) {
> -            error_propagate(errp, err);
> -        }
> +        error_propagate(errp, err);
>       }

This change is correct.  The change I suggests is also correct.  I
prefer mine because it's less easy to screw up.  If you add another
check at the end, my version keeps working, while yours needs an update,
which is easy to miss.


