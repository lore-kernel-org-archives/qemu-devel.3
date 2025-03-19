Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA953C35FFF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 08:44:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tup1s-0008W5-6H; Wed, 19 Mar 2025 04:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tup1h-0008SZ-VD
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 04:43:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tup1f-0006IZ-Oo
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 04:43:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742373825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4qKAlikB86xmxRKgtUtOjpW6xh4BbgQY6JTBm0o2bKQ=;
 b=izFWllZZCrirfynugEsBNjXhfQZ8ayGMEkTF6mROEPBij0SIQaZrftzrJ+TpD7aBBQsDMc
 tVTcPYZzh9HGbLupnCUzU3DCjoVevpnGoRHgWIUJSb1oklTiBOA7u8tf5S+EsRah7vCGCq
 ounG49bP9BIXO025E5c613mvhj/HR1A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-343-lUBH3dprM8yvfDahwplxGg-1; Wed,
 19 Mar 2025 04:43:41 -0400
X-MC-Unique: lUBH3dprM8yvfDahwplxGg-1
X-Mimecast-MFC-AGG-ID: lUBH3dprM8yvfDahwplxGg_1742373820
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 11017180035C; Wed, 19 Mar 2025 08:43:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C09EE3001D0E; Wed, 19 Mar 2025 08:43:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C65BF21E66C4; Wed, 19 Mar 2025 09:43:34 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: bibo mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>,  Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 2/4] hw/loongarch/virt: Remove unnecessary NULL pointer
In-Reply-To: <6b6b0792-04af-220d-8375-cef4b09b3ea9@loongson.cn> (bibo mao's
 message of "Wed, 19 Mar 2025 16:14:50 +0800")
References: <20250319020847.1511759-1-maobibo@loongson.cn>
 <20250319020847.1511759-3-maobibo@loongson.cn>
 <87v7s5345y.fsf@pond.sub.org>
 <6b6b0792-04af-220d-8375-cef4b09b3ea9@loongson.cn>
Date: Wed, 19 Mar 2025 09:43:34 +0100
Message-ID: <87bjtx1kcp.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2025/3/19 =E4=B8=8B=E5=8D=882:50, Markus Armbruster wrote:
>> Bibo Mao <maobibo@loongson.cn> writes:
>>=20
>>> There is NULL pointer checking function error_propagate() already,
>>> it is not necessary to add checking for function parameter. Here remove
>>> NULL pointer checking with function parameter.
>>=20
>> I believe the title "Remove unnecessary NULL pointer" and this paragraph
>> are remnants of your initial version, which transformed
>>=20
>>      if (err) {
>>          error_propagate(errp, err);
>>      }
>>=20
>> to just
>>=20
>>      error_propagate(errp, err);
>>=20
>> However, the patch doesn't do that anymore.
>>=20
>> I think you should drop the paragraph, and replace the title.
>
> yes, the title is misleading. Originally the problem is found with=20
> script scripts/coccinelle/remove_local_err.cocci, so here is the title.
>
> How about "Remove local error object" or something else. Could you=20
> please provide some suggestions since English is your mother language?

My first language is German, but I've practiced writing English commit
messages for a while :)

Here's what I've used for similar patches before, adapted to this one:

    hw/loongarch/virt: Eliminate error_propagate()
=20=20=20=20
    When all we do with an Error we receive into a local variable is
    propagating to somewhere else, we can just as well receive it there
    right away.


>> I apologize for not noticing this earlier.
>
> It is not necessary for the apologize. I appreciate your review=20
> comments. With effective communication, the quality of code is better.

Thank you!

>>> Since function will return directly when there is error report, this
>>> patch removes combination about error_setg() and error_propagate(),
>>> error_setg() with dest error object is used directly such as:
>>>
>>>    error_setg(err);                 -------->      error_setg(errp);
>>>    error_propagate(errp, err);                     return;
>>>    return;
>>=20
>> Yes, much of the patch does this or equivalent transformations.
>> However, there's more; see [*] below.
>>=20
>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>> ---
>>>   hw/loongarch/virt.c | 33 ++++++++++++---------------------
>>>   1 file changed, 12 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
>>> index a5840ff968..a9fab39dd8 100644
>>> --- a/hw/loongarch/virt.c
>>> +++ b/hw/loongarch/virt.c

[...]

>>> @@ -1003,6 +993,7 @@ static void virt_cpu_plug(HotplugHandler *hotplug_=
dev,
>>>          hotplug_handler_plug(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &er=
r);
>>>          if (err) {
>>>              error_propagate(errp, err);
>>> +            return;
>>>          }
>>>      }
>>=20
>>       cpu_slot =3D virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id);
>>       cpu_slot->cpu =3D NULL;
>>       return;
>>   }
>>=20
>> [*] This is something else.  Before the patch, we clear cpu_slot->cpu
>> evem when the last hotplug_handler() fails.  Afterwards, we don't.
>> Looks like a bug fix to me.  Either mention the fix in the commit
>> message, or split it off into a separate patch.  I'd do the latter.
>>=20
> yes, will split it into two patches. The latter is bugfix, when cpu=20
> fails to unplug and it should return immediately, so that system can=20
> continue to run , and cpu_slot->cpu should not be cleared.

Thanks again!


