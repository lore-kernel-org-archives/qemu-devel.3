Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A543C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 09:38:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rraaV-0002Kw-Hx; Tue, 02 Apr 2024 05:37:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rraaC-0002Cm-4s
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 05:37:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rraa1-0001RL-BZ
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 05:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712050640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wF5lK1aJPl/KNxtJvjVqnprrlMlNrhSTZPVBoQn9ZQQ=;
 b=Q9JKmmR8WrkRb43GYP/vtG+zPQrfdnGEvb6ctbTMX2DmVO1Pa6R3XFF/kg75PyxqN1gPJB
 grn+brhs4w3bImRnaSG2jM3KFUsME2lwjQT39N3YYmt9qGSvIV4XaWabcAvbPrUyf+GYWs
 Q736CWDm1hs2XnEFpyzf9pY4BC02J1U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-ZNIApIi2P7W73p1i2a3tlA-1; Tue, 02 Apr 2024 05:37:14 -0400
X-MC-Unique: ZNIApIi2P7W73p1i2a3tlA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E51E08828C3;
 Tue,  2 Apr 2024 09:37:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 46CFE1121313;
 Tue,  2 Apr 2024 09:37:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 28B8221E6757; Tue,  2 Apr 2024 11:37:08 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-riscv@nongnu.org,  Anton Johansson
 <anjo@rev.ng>,  qemu-s390x@nongnu.org,  qemu-ppc@nongnu.org,  Daniel
 =?utf-8?Q?P=2EBerrang=C3=A9?= <berrange@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,  Claudio Fontana
 <cfontana@suse.de>,  Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Zhao Liu <zhao1.liu@intel.com>,
 qemu-arm@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Michael Roth
 <michael.roth@amd.com>
Subject: Re: [RFC PATCH-for-9.1 14/21] system: Introduce QMP
 generic_query_cpu_definitions()
In-Reply-To: <96bcb673-18dd-49bc-8bcb-281c7409b410@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 29 Mar 2024 14:03:48
 +0100")
References: <20240315130910.15750-1-philmd@linaro.org>
 <20240315130910.15750-15-philmd@linaro.org>
 <87v859m89y.fsf@pond.sub.org>
 <96bcb673-18dd-49bc-8bcb-281c7409b410@linaro.org>
Date: Tue, 02 Apr 2024 11:37:07 +0200
Message-ID: <87bk6s3y2k.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> Hi Markus,
>
> On 26/3/24 14:28, Markus Armbruster wrote:
>> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
>>=20
>>> Each target use a common template for qmp_query_cpu_definitions().
>>>
>>> Extract it as generic_query_cpu_definitions(), keeping the
>>> target-specific implementations as the following SysemuCPUOps
>>> handlers:
>>>   - cpu_list_compare()
>>>   - add_definition()
>>>   - add_alias_definitions()
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>>> ---
>>>   MAINTAINERS                           |  2 +
>>>   include/hw/core/sysemu-cpu-ops.h      | 14 ++++++
>>>   include/qapi/commands-target-compat.h | 14 ++++++
>>>   system/cpu-qmp-cmds.c                 | 71 +++++++++++++++++++++++++++
>>>   system/meson.build                    |  1 +
>>>   5 files changed, 102 insertions(+)
>>>   create mode 100644 include/qapi/commands-target-compat.h
>>>   create mode 100644 system/cpu-qmp-cmds.c
>
>
>>> diff --git a/system/cpu-qmp-cmds.c b/system/cpu-qmp-cmds.c
>>> new file mode 100644
>>> index 0000000000..daeb131159
>>> --- /dev/null
>>> +++ b/system/cpu-qmp-cmds.c
>>> @@ -0,0 +1,71 @@
>>> +/*
>>> + * QAPI helpers for target specific QMP commands
>>> + *
>>> + * SPDX-FileCopyrightText: 2024 Linaro Ltd.
>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>> + */
>>> +
>>> +#include "qemu/osdep.h"
>>> +#include "qom/object.h"
>>> +#include "qapi/commands-target-compat.h"
>>> +#include "sysemu/arch_init.h"
>>> +#include "hw/core/cpu.h"
>>> +#include "hw/core/sysemu-cpu-ops.h"
>>> +
>>> +static void cpu_common_add_definition(gpointer data, gpointer user_dat=
a)
>>> +{
>>> +    ObjectClass *oc =3D data;
>>> +    CpuDefinitionInfoList **cpu_list =3D user_data;
>>> +    CpuDefinitionInfo *info;
>>> +    const char *typename;
>>> +
>>> +    typename =3D object_class_get_name(oc);
>>> +    info =3D g_malloc0(sizeof(*info));
>>> +    info->name =3D cpu_model_from_type(typename);
>>> +    info->q_typename =3D g_strdup(typename);
>>> +
>>> +    QAPI_LIST_PREPEND(*cpu_list, info);
>>> +}
>>> +
>>> +static void arch_add_cpu_definitions(CpuDefinitionInfoList **cpu_list,
>>> +                                     const char *cpu_typename)
>>> +{
>>> +    ObjectClass *oc;
>>> +    GSList *list;
>>> +    const struct SysemuCPUOps *ops;
>>> +
>>> +    oc =3D object_class_by_name(cpu_typename);
>>> +    if (!oc) {
>>> +        return;
>>> +    }
>>> +    ops =3D CPU_CLASS(oc)->sysemu_ops;
>>> +
>>> +    list =3D object_class_get_list(cpu_typename, false);
>>> +    if (ops->cpu_list_compare) {
>>> +        list =3D g_slist_sort(list, ops->cpu_list_compare);
>>> +    }
>>> +    g_slist_foreach(list, ops->add_definition ? : cpu_common_add_defin=
ition,
>>> +                    cpu_list);
>>> +    g_slist_free(list);
>>> +
>>> +    if (ops->add_alias_definitions) {
>>> +        ops->add_alias_definitions(cpu_list);
>>> +    }
>>> +}
>>> +
>>> +CpuDefinitionInfoList *generic_query_cpu_definitions(Error **errp)
>>> +{
>>> +    CpuDefinitionInfoList *cpu_list =3D NULL;
>>> +
>>> +    for (unsigned i =3D 0; i <=3D QEMU_ARCH_BIT_LAST; i++) {
>>> +        const char *cpu_typename;
>>> +
>>> +        cpu_typename =3D cpu_typename_by_arch_bit(i);
>>> +        if (!cpu_typename) {
>>> +            continue;
>>> +        }
>>> +        arch_add_cpu_definitions(&cpu_list, cpu_typename);
>>> +    }
>>> +
>>> +    return cpu_list;
>>> +}
>>
>> The target-specific qmp_query_cpu_definitions() this is going to replace
>> each execute the equivalent of *one* loop iteration: the one
>> corresponding to their own arch bit.
>>
>> For the replacement to be faithful, as cpu_typename_by_arch_bit() must
>> return non-null exactly once.
>>
>> This is the case for the qemu-system-TARGET.  The solution feels
>> overengineered there.
>>
>> I figure cpu_typename_by_arch_bit() will return non-null multiple times
>> in a future single binary supporting heterogeneous machines.
>>
>> Such a single binary then can't serve as drop-in replacement for the
>> qemu-system-TARGET, because query-cpu-definitions returns more.
>>
>> To get a drop-in replacement, we'll need additional logic to restrict
>> the query for the homogeneous use case.
>
> Can we ask the management layer to provide the current homogeneous
> target via argument? Otherwise we can add a new query-cpu-definitions-v2
> command requiring an explicit target argument, allowing 'all', and
> deprecate the current query-cpu-definitions.

Is "new binary can serve as drop-in replacement for the
qemu-system-TARGET" a goal?

I'm asking because a new binary is also an opportunity to improve
things, and backward compatibility conflicts with that.

Where would we want to go if backward compatibility was not a concern?
I guess we'd want a single binary capable of running any machine,
homogeneous or not.

Your query-cpu-definitions would be fine for that binary, as long as its
users can filter out the CPUs they're interested in.

I prefer client-side filtering whenever practical, since it keeps the
interface simple.  We do have to provide clients the information they
need to filter.  How would a client filter the result of your
query-cpu-definitions for target?

Since backward compatibility is a concern, and we don't want to provide
per target binaries forever, we need to think about how to provide
suitable replacements based on the single binary.  I'm not sure drop-in
replacement is feasible, given the complexity of the external
interfaces.

>> I think this needs to be discussed in the commit message.
>>
>> Possibly easier: don't loop over the bits, relying on
>> cpu_typename_by_arch_bit() to select the right one.  Instead get the
>> right bit from somewhere.
>>
>> We can switch to a loop when we need it for the heterogeneous case.
>
> Alex suggested to consider heterogeneous emulation the new default,
> and the current homogeneous use as a particular case. I'd rather not
> plan on a "heterogeneous switch day" and get things integrated in
> the way, otherwise we'll never get there...

I guess it's okay to overengineer certain things so they're ready for
the heterogenous case when it comes.  We may want to explain this in
comments, so people don't simplify the overengineered code :)


