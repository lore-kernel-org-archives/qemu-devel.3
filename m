Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91CCEC3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 11:12:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbeZI-0004o2-FP; Wed, 07 Aug 2024 07:11:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sbeZE-0004mE-IE
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 07:10:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sbeZB-0007Jm-Cy
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 07:10:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723029051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SPNkvLybHKCCctkHGz/5d2bjeFU7tpCA/m/iwKrNhxs=;
 b=JFk8Z9MSqbIAi5VyYhcgu+H2A9a9IxDLLndskWN9L60lX6vNEEF8kL+MIdu0ARR/pddifv
 X4JD+P73ZOUGyc6lIiidu/mCW5Wf6xwQX3NGbiIs3zsx0tQAgwGoSpWNcE1v8T5C2rRjWn
 e6jZRQKL+VdUYAvjhXJk9bdQPYKuRCM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-kIVqe62JNdunQpFdMerBtw-1; Wed,
 07 Aug 2024 07:10:46 -0400
X-MC-Unique: kIVqe62JNdunQpFdMerBtw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 956F41956096; Wed,  7 Aug 2024 11:10:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.245])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2615119560A3; Wed,  7 Aug 2024 11:10:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2C36121E66E5; Wed,  7 Aug 2024 13:10:43 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Eric Blake <eblake@redhat.com>,
 qemu-arm@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,  Thomas
 Huth <thuth@redhat.com>
Subject: Re: [RFC PATCH-for-9.1? 2/2] hw/intc/arm_gic: Only provide
 query-gic-capabilities when GIC built-in
In-Reply-To: <a8eb43d8-3714-447b-ab1b-c96ff05cf14a@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 7 Aug 2024 11:03:51
 +0200")
References: <20240806141940.22095-1-philmd@linaro.org>
 <20240806141940.22095-3-philmd@linaro.org>
 <87o764yce3.fsf@pond.sub.org>
 <a8eb43d8-3714-447b-ab1b-c96ff05cf14a@linaro.org>
Date: Wed, 07 Aug 2024 13:10:43 +0200
Message-ID: <87h6bwwpu4.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 7/8/24 10:18, Markus Armbruster wrote:
>> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
>>=20
>>> When configuring QEMU with --without-default-devices and
>>> not including machines using a GIC, the GIC model is not
>>> built in but the 'query-gic-capabilities' command still
>>> returns false hopes about GIC:
>>>
>>>    {"execute": "query-gic-capabilities"}
>>>    {"return": [{"emulated": true, "version": 3, "kernel": false}, {"emu=
lated": true, "version": 2, "kernel": false}]}
>>>
>>> Restrict the command to when the GIC is available. If it
>>> isn't we'll get:
>>>
>>>    { "execute": "query-gic-capabilities" }
>>>    {"error": {"class": "CommandNotFound", "desc": "The command query-gi=
c-capabilities has not been found"}}
>>>
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2484
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>>> ---
>>>   qapi/misc-target.json | 4 ++--
>>>   hw/intc/arm_gic_qmp.c | 2 ++
>>>   hw/intc/meson.build   | 2 +-
>>>   3 files changed, 5 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/qapi/misc-target.json b/qapi/misc-target.json
>>> index 8d70bd24d8..b857e44c2e 100644
>>> --- a/qapi/misc-target.json
>>> +++ b/qapi/misc-target.json
>>> @@ -316,7 +316,7 @@
>>>     'data': { 'version': 'int',
>>>               'emulated': 'bool',
>>>               'kernel': 'bool' },
>>> -  'if': 'TARGET_ARM' }
>>> +  'if': 'CONFIG_ARM_GIC' }
>>>=20=20=20
>>>   ##
>>>   # @query-gic-capabilities:
>>> @@ -335,7 +335,7 @@
>>>   #                     { "version": 3, "emulated": false, "kernel": tr=
ue } ] }
>>>   ##
>>>   { 'command': 'query-gic-capabilities', 'returns': ['GICCapability'],
>>> -  'if': 'TARGET_ARM' }
>>> +  'if': 'CONFIG_ARM_GIC' }
>>>=20=20=20
>>>   ##
>>>   # @SGXEPCSection:
>>> diff --git a/hw/intc/arm_gic_qmp.c b/hw/intc/arm_gic_qmp.c
>>> index 71056a0c10..1fc79c775b 100644
>>> --- a/hw/intc/arm_gic_qmp.c
>>> +++ b/hw/intc/arm_gic_qmp.c
>>> @@ -6,6 +6,8 @@
>>>=20=20=20
>>>   #include "qemu/osdep.h"
>>>   #include "qapi/util.h"
>>> +
>>> +#include CONFIG_DEVICES
>>=20
>> Uh, why do we need this now?
>
> Now qapi-commands-misc-target.h is generated guarded with
> '#ifdef CONFIG_ARM_GIC', and CONFIG_ARM_GIC is defined per
> target in CONFIG_DEVICES.
>
> I'll update the patch description, but does this makes
> sense to you? QAPI headers don't include headers defining
> guards, we have to include them manually where we use QAPI
> headers.

Hmm.  Then the generated headers aren't self-contained anymore.

Having to manually include a configuration header like CONFIG_DEVICES
wherever you use configuration symbols strikes me as unadvisable when
uses include checking for definedness, such as #ifdef: silent miscompile
when you forget to include.

This is why Autoconf wants you to include config.h first in any .c: it
makes #ifdef & friends safe.

qemu/osdep.h does include some configuration headers:

    #include "config-host.h"
    #ifdef COMPILING_PER_TARGET
    #include CONFIG_TARGET
    #else
    #include "exec/poison.h"
    #endif

Why not CONFIG_DEVICES?

[...]


