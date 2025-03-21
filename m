Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3FFCC35FF3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 08:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvXR2-0007R8-Oa; Fri, 21 Mar 2025 04:08:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tvXQv-0007QV-0V
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 04:08:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tvXQs-0005TQ-K5
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 04:08:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742544525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8FbVsDnu14sl5aKhI98/P8CCHJxCY7XkPanjNglX0mY=;
 b=DQTLkWXtywRF8BhkXgOSuwtLYZRiFQ/EQz4wLDMiEbbjxiKzHD+rKAKQeOcMfxaY3bUFdH
 3DXxQ8acX/RKhGKdjKKFCvjYhRMtVDMIq2Ap2bN99iKDF1VF6FB89/1iGOjUP76NRufWZV
 tCZkDRIBxBqBRXAhi1kmNUR3l5Dw0v4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-258-CNW5SLlUONGpNq0r59lC3g-1; Fri,
 21 Mar 2025 04:08:41 -0400
X-MC-Unique: CNW5SLlUONGpNq0r59lC3g-1
X-Mimecast-MFC-AGG-ID: CNW5SLlUONGpNq0r59lC3g_1742544520
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A1ED318001F3; Fri, 21 Mar 2025 08:08:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DA3911955BFE; Fri, 21 Mar 2025 08:08:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 24BB621E675E; Fri, 21 Mar 2025 09:08:33 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: bibo mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>,  Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Igor
 Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v6 3/6] hw/loongarch/virt: Fix error handling in cpu unplug
In-Reply-To: <ff30bac6-9004-0ba2-505a-3406e66623da@loongson.cn> (bibo mao's
 message of "Fri, 21 Mar 2025 15:35:37 +0800")
References: <20250321031259.2419842-1-maobibo@loongson.cn>
 <20250321031259.2419842-4-maobibo@loongson.cn>
 <87ecyq98y1.fsf@pond.sub.org>
 <87d1b58e-1b8b-f582-753b-574c4ba44a6b@loongson.cn>
 <87ldsy7sry.fsf@pond.sub.org>
 <ff30bac6-9004-0ba2-505a-3406e66623da@loongson.cn>
Date: Fri, 21 Mar 2025 09:08:33 +0100
Message-ID: <87h63m6c1q.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

> On 2025/3/21 =E4=B8=8B=E5=8D=883:21, Markus Armbruster wrote:
>> bibo mao <maobibo@loongson.cn> writes:
>>=20
>>> +Igor
>>>
>>>
>>> On 2025/3/21 =E4=B8=8B=E5=8D=882:47, Markus Armbruster wrote:
>>>> Bibo Mao <maobibo@loongson.cn> writes:
>>>>
>>>>> In function virt_cpu_unplug(), it will send cpu unplug message to
>>>>> interrupt controller extioi and ipi irqchip. If there is problem in
>>>>> this function, system should continue to run and keep state the same
>>>>> before cpu is removed.
>>>>>
>>>>> If error happends in cpu unplug stage, send cpu plug message to extioi
>>>>> and ipi irqchip to restore to previous stage, and then return immedia=
tely.
>>>>>
>>>>> Fixes: 2cd6857f6f5b (hw/loongarch/virt: Implement cpu unplug interfac=
e)
>>>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>>>> ---
>>>>>    hw/loongarch/virt.c | 6 ++++++
>>>>>    1 file changed, 6 insertions(+)
>>>>>
>>>>> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
>>>>> index 8563967c8b..503362a69e 100644
>>>>> --- a/hw/loongarch/virt.c
>>>>> +++ b/hw/loongarch/virt.c
>>>>> @@ -958,6 +958,8 @@ static void virt_cpu_unplug(HotplugHandler *hotpl=
ug_dev,
>>>>>        hotplug_handler_unplug(HOTPLUG_HANDLER(lvms->extioi), dev, &er=
r);
>>>>>        if (err) {
>>>>>            error_propagate(errp, err);
>>>>> +        hotplug_handler_plug(HOTPLUG_HANDLER(lvms->ipi), dev,
>>>>> +                             &error_abort);
>>>>>            return;
>>>>>        }
>>>>>=20=20=20=20
>>>>> @@ -965,6 +967,10 @@ static void virt_cpu_unplug(HotplugHandler *hotp=
lug_dev,
>>>>>        hotplug_handler_unplug(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &=
err);
>>>>>        if (err) {
>>>>>            error_propagate(errp, err);
>>>>> +        hotplug_handler_plug(HOTPLUG_HANDLER(lvms->ipi), dev,
>>>>> +                             &error_abort);
>>>>> +        hotplug_handler_plug(HOTPLUG_HANDLER(lvms->extioi), dev,
>>>>> +                             &error_abort);
>>>>>            return;
>>>>>        }
>>>>
>>>> virt_cpu_unplug() calls hotplug_handler_unplug() three times to notify
>>>> ipi, extioi, and acpi_get.  If any notification fails, virt_cpu_unplug=
()
>>>> calls hotplug_handler_plug() to "un-notify" the preceeding ones, if an=
y.
>>>> This must not fail.
>>>>
>>>> virt_cpu_plug() does it the other way round (see previous patch).
>>>>
>>>> So, hotplug_handler_plug() must not fail in virt_cpu_unplug(), yet we
>>>> check for it to fail in virt_cpu_plug().
>>>>
>>>> Can it really fail in virt_cpu_plug()?
>>>>
>>>> If yes, why can't it fail in virt_cpu_unplug()?
>>> you can check function acpi_cpu_plug_cb()/loongarch_ipi_cpu_plug(), that
>>> is cpuplug callback for acpi_ged and ipi. it will not fail.
>>>
>>> If *virt_cpu_pre_plug()* pass, it will succeed.
>>>
>>> Regards
>>> Bibo Mao
>>>
>>>>
>>>> Same questions for hotplug_handler_unplug().
>>=20
>> Let me restate my argument.
>>=20
>> We call hotplug_handler_plug() on the happy path, and on error recovery
>> paths.  Four cases:
>>=20
>> 1. Can fail on the happy path
>>=20
>>     Error recovery is required.
>>=20
>> 1.1 Can fail on the error recovery path
>>=20
>>      Error recovery is required, but broken.
>>=20
>> 1.2 Can't fail on the error recovery path
>>=20
>>      Error recovery is required and works, but why it works is not
>>      obvious.  Deserves a comment explaining why hotplug_handler_plug()
>>      can't fail here even though it can fail on the happy path next door.
>>=20
>> 2. Can't fail on the happy path
>>=20
>>     Error recovery is unreachable.
>>=20
>> 2.1 Can fail on the error recovery path
>>=20
>>      Error recovery is unreachable and broken.  Possibly a time bomb, and
>>      possibly misleading readers.
>>=20
>> 2.2 Can't fail on the error recovery path
>>=20
>>      Error recovery is unreachable and would work, but why it would work
>>      is again a not obvious.
>>=20
>> Which of the four cases is it?
> By my understanding, it is "2. Can't fail on the happy path",  and Error=
=20
> recovery is unreachable.

Got it.

> I have said that it is impossible and recovery is only for future use.
>
> do you mean recovery should be removed? And directly &error_abort is=20
> used in virt_cpu_plug() such as:
> static void virt_cpu_plug(HotplugHandler *hotplug_dev,
>                            DeviceState *dev, Error **errp)
> {
>    if (lvms->ipi) {
>      hotplug_handler_plug(HOTPLUG_HANDLER(lvms->ipi), dev, &error_abort);

Yes, I prefer this.  Here's why.

Error recovery that is unreachable now but might become reachable at
some future time is untestable now.  Mind, this does not necessarily
make it a bad idea by itself.  But there's more.

Anything that makes this error recovery reachable either breaks it or
makes correctness locally unobvious.  Why?  To make it reachable, plug /
unplug must be able to fail on the happy path.  But then they either can
fail on the error recovery path as well (which breaks error recovery),
or they can't fail there for reasons that are not locally obvious.

This sets a trap for readers.  An attentive reader will see the problem
(like I did), but to see why the code is not broken right now will take
digging (like we did together).  And after such digging, we're left with
a queasy feeling about robustness of the code (like we are now).

Passing &error_abort on the happy path avoids all this.  Instead it
clearly tells the reader that this is not expected to fail.

If failure becomes possible at some future time, this should crash in
testing.  If we neglect to test the new failure (and we really
shouldn't), we crash on error in production right away instead of
risking botched error recovery messing up the program's state.
Both are bad outcomes, but which one's less bad I find impossible to
predict.


