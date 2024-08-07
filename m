Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BACEBC3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 08:17:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbbqN-0003bu-Th; Wed, 07 Aug 2024 04:16:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sbbqK-0003X5-9k
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 04:16:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sbbqH-0006mR-Dm
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 04:16:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723018579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uIWD3gKCs/+S0jBcNjaionm02eBM5EhFim02t5GD0PM=;
 b=JQ0aEA7orQiM8iBImE8y7UpDmKUeluObK++uxqRlnKWSMFvL7+3sqEo3BXhh8KgcW3fWBw
 OgQDK2heSqBo1Uto0swALcEWGei/6i4JS3tZWg4au+Bo43yaGLH+f/MU7g42aZrCt57K9v
 4hYVvK2OY2l+a+Lp0VMzET1hP1CJcg8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-358-6ldfQ0avNTGjW2gvaFJ62A-1; Wed,
 07 Aug 2024 04:16:15 -0400
X-MC-Unique: 6ldfQ0avNTGjW2gvaFJ62A-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F12B619560A3; Wed,  7 Aug 2024 08:16:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.245])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C8EE19560A3; Wed,  7 Aug 2024 08:16:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 42C4921E668F; Wed,  7 Aug 2024 10:16:09 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Eric Blake <eblake@redhat.com>,
 qemu-arm@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,  Thomas
 Huth <thuth@redhat.com>
Subject: Re: [RFC PATCH-for-9.1? 1/2] target/arm: Move
 qmp_query_gic_capabilities() to hw/intc/
In-Reply-To: <df628091-6d6a-4fdc-b048-3dd91a8060a1@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 7 Aug 2024 09:28:32
 +0200")
References: <20240806141940.22095-1-philmd@linaro.org>
 <20240806141940.22095-2-philmd@linaro.org>
 <877ccs29xh.fsf@pond.sub.org>
 <df628091-6d6a-4fdc-b048-3dd91a8060a1@linaro.org>
Date: Wed, 07 Aug 2024 10:16:09 +0200
Message-ID: <87sevgychi.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 7/8/24 07:12, Markus Armbruster wrote:
>> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
>>=20
>>> qmp_query_gic_capabilities() is not specific to the ARM
>>> architecture but to the GIC device which is modelled in
>>> hw/intc/, so move the code there for clarity. No logical
>>> change intended.
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>>> ---
>>>   hw/intc/arm_gic_qmp.c     | 59 +++++++++++++++++++++++++++++++++++++++
>>>   target/arm/arm-qmp-cmds.c | 52 +---------------------------------
>>>   hw/intc/meson.build       |  1 +
>>>   3 files changed, 61 insertions(+), 51 deletions(-)
>>>   create mode 100644 hw/intc/arm_gic_qmp.c
>> [...]
>>=20
>>> diff --git a/hw/intc/meson.build b/hw/intc/meson.build
>>> index afd1aa51ee..45d3503d49 100644
>>> --- a/hw/intc/meson.build
>>> +++ b/hw/intc/meson.build
>>> @@ -39,6 +39,7 @@ if config_all_devices.has_key('CONFIG_APIC') or \
>>>   endif
>>>     specific_ss.add(when: 'CONFIG_APIC', if_true: files('apic.c', 'apic=
_common.c'))
>>> +specific_ss.add(when: 'CONFIG_ARM', if_true: files('arm_gic_qmp.c'))
>>>   specific_ss.add(when: 'CONFIG_ARM_GIC', if_true: files('arm_gicv3_cpu=
if_common.c'))
>>>   specific_ss.add(when: 'CONFIG_ARM_GICV3_TCG', if_true: files('arm_gic=
v3_cpuif.c'))
>>>   specific_ss.add(when: 'CONFIG_ARM_GIC_KVM', if_true: files('arm_gic_k=
vm.c'))
>> You move qmp_query_gic_capabilities() from target/arm/arm-qmp-cmds.c (in
>> arm_system_ss) to hw/intc/arm_gic_qmp.c (in specific_ss when
>> CONFIG_ARM).
>>
>> Both _ss are target-dependent.  In my testing, both get only compiled
>> for target arm and aarch64.  Obvious for arm-qmp-cmds.c in
>> arm_system_ss.  Less so for arm_gic_qmp.c in specific_ss; I guess the
>> CONFIG_ARM does the trick there.  Correct?
>
> Correct, Kconfig CONFIG_ARM_GIC depends on Kconfig CONFIG_ARM,
> itself defined for configure TARGET_ARM (see target/arm/Kconfig).
> (Also CONFIG_AARCH64 selects CONFIG_ARM).
>
> I can clarify that in the patch description if necessary.

Wouldn't hurt.  If figure this patch is meant to be just code motion,
but it's not obvious from the patch that the code being moved gets
compiled into the exact same binaries before and after the move, unless
you know how CONFIG_ARM works.


