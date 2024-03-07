Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45EE8C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 08:41:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri9IP-0001q1-5W; Thu, 07 Mar 2024 03:40:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ri9IL-0001pn-Qk
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 03:40:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ri9II-0007vl-Ux
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 03:40:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709800801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t5MK8Z1+Clb6vMX42xo0HuA8KOusTR69BaPtEu+d+j4=;
 b=VZhn22Rv7uuEjYvbueYQy4gYCqpmWV6nNNQT5TWEjGBKBkwwq69v0P4aa0Jxgxgk6hm+YN
 REgv0U7YkcymMDLg37QBCWaazzaTRL7Ln7tnkex1wX09U4mJMa4/kz6CyGBiBvaIOWCrZH
 3MClmEfLGU2lwwjgpDSLL4m4IwY8oHo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-w_2fWGYkPNabyI0OfB_iCQ-1; Thu, 07 Mar 2024 03:39:57 -0500
X-MC-Unique: w_2fWGYkPNabyI0OfB_iCQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 664E3185A784;
 Thu,  7 Mar 2024 08:39:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BC0492166AE8;
 Thu,  7 Mar 2024 08:39:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C11EB21E6A24; Thu,  7 Mar 2024 09:39:54 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  David Hildenbrand
 <david@redhat.com>,  Igor Mammedov <imammedo@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Yanan Wang
 <wangyanan55@huawei.com>,  "Michael S. Tsirkin" <mst@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Ani Sinha
 <anisinha@redhat.com>,  Peter Xu <peterx@redhat.com>,  Cornelia Huck
 <cohuck@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eric
 Blake <eblake@redhat.com>,  Marcelo Tosatti <mtosatti@redhat.com>,
 kvm@vger.kernel.org,  qemu-devel@nongnu.org,  Michael Roth
 <michael.roth@amd.com>,  Claudio Fontana <cfontana@suse.de>,  Gerd
 Hoffmann <kraxel@redhat.com>,  Isaku Yamahata <isaku.yamahata@gmail.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>
Subject: Re: [PATCH v5 30/65] i386/tdx: Support user configurable
 mrconfigid/mrowner/mrownerconfig
In-Reply-To: <4602df24-029e-4a40-bdec-1b0a6aa30a3c@intel.com> (Xiaoyao Li's
 message of "Thu, 29 Feb 2024 22:14:27 +0800")
References: <20240229063726.610065-1-xiaoyao.li@intel.com>
 <20240229063726.610065-31-xiaoyao.li@intel.com>
 <87edcv1x9j.fsf@pond.sub.org>
 <f9774e89-399c-42ad-8fa8-dd4050ee46da@intel.com>
 <871q8vxuzx.fsf@pond.sub.org>
 <4602df24-029e-4a40-bdec-1b0a6aa30a3c@intel.com>
Date: Thu, 07 Mar 2024 09:39:54 +0100
Message-ID: <87v85yv3j9.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Xiaoyao Li <xiaoyao.li@intel.com> writes:

> On 2/29/2024 9:25 PM, Markus Armbruster wrote:
>> Xiaoyao Li <xiaoyao.li@intel.com> writes:
>>=20
>>> On 2/29/2024 4:37 PM, Markus Armbruster wrote:
>>>> Xiaoyao Li <xiaoyao.li@intel.com> writes:
>>>>
>>>>> From: Isaku Yamahata <isaku.yamahata@intel.com>
>>>>>
>>>>> Three sha384 hash values, mrconfigid, mrowner and mrownerconfig, of a=
 TD
>>>>> can be provided for TDX attestation. Detailed meaning of them can be
>>>>> found: https://lore.kernel.org/qemu-devel/31d6dbc1-f453-4cef-ab08-481=
3f4e0ff92@intel.com/
>>>>>
>>>>> Allow user to specify those values via property mrconfigid, mrowner a=
nd
>>>>> mrownerconfig. They are all in base64 format.
>>>>>
>>>>> example
>>>>> -object tdx-guest, \
>>>>>     mrconfigid=3DASNFZ4mrze8BI0VniavN7wEjRWeJq83vASNFZ4mrze8BI0VniavN=
7wEjRWeJq83v,\
>>>>>     mrowner=3DASNFZ4mrze8BI0VniavN7wEjRWeJq83vASNFZ4mrze8BI0VniavN7wE=
jRWeJq83v,\
>>>>>     mrownerconfig=3DASNFZ4mrze8BI0VniavN7wEjRWeJq83vASNFZ4mrze8BI0Vni=
avN7wEjRWeJq83v
>>>>>
>>>>> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
>>>>> Co-developed-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>>>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> [...]
>>=20
>>>>> diff --git a/qapi/qom.json b/qapi/qom.json
>>>>> index 89ed89b9b46e..cac875349a3a 100644
>>>>> --- a/qapi/qom.json
>>>>> +++ b/qapi/qom.json
>>>>> @@ -905,10 +905,25 @@
>>>>>   #     pages.  Some guest OS (e.g., Linux TD guest) may require this=
 to
>>>>>   #     be set, otherwise they refuse to boot.
>>>>>   #
>>>>> +# @mrconfigid: ID for non-owner-defined configuration of the guest T=
D,
>>>>> +#     e.g., run-time or OS configuration (base64 encoded SHA384 dige=
st).
>>>>> +#     (A default value 0 of SHA384 is used when absent).
>>>>
>>>> Suggest to drop the parenthesis in the last sentence.
>>>>
>>>> @mrconfigid is a string, so the default value can't be 0.  Actually,
>>>> it's not just any string, but a base64 encoded SHA384 digest, which
>>>> means it must be exactly 96 hex digits.  So it can't be "0", either.  =
It
>>>> could be
>>>> "000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000".
>>>
>>> I thought value 0 of SHA384 just means it.
>>>
>>> That's my fault and my poor english.
>>
>> "Fault" is too harsh :)  It's not as precise as I want our interface
>> documentation to be.  We work together to get there.
>>=20
>>>> More on this below.
>>>>
>>>>> +#
>>>>> +# @mrowner: ID for the guest TD=E2=80=99s owner (base64 encoded SHA3=
84 digest).
>>>>> +#     (A default value 0 of SHA384 is used when absent).
>>>>> +#
>>>>> +# @mrownerconfig: ID for owner-defined configuration of the guest TD,
>>>>> +#     e.g., specific to the workload rather than the run-time or OS
>>>>> +#     (base64 encoded SHA384 digest). (A default value 0 of SHA384 is
>>>>> +#     used when absent).
>>>>> +#
>>>>>   # Since: 9.0
>>>>>   ##
>>>>>   { 'struct': 'TdxGuestProperties',
>>>>> -  'data': { '*sept-ve-disable': 'bool' } }
>>>>> +  'data': { '*sept-ve-disable': 'bool',
>>>>> +            '*mrconfigid': 'str',
>>>>> +            '*mrowner': 'str',
>>>>> +            '*mrownerconfig': 'str' } }
>>>>>   ##
>>>>>   # @ThreadContextProperties:
>>>>> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
>>>>> index d0ad4f57b5d0..4ce2f1d082ce 100644
>>>>> --- a/target/i386/kvm/tdx.c
>>>>> +++ b/target/i386/kvm/tdx.c
>>>>> @@ -13,6 +13,7 @@
>>>>>   #include "qemu/osdep.h"
>>>>>   #include "qemu/error-report.h"
>>>>> +#include "qemu/base64.h"
>>>>>   #include "qapi/error.h"
>>>>>   #include "qom/object_interfaces.h"
>>>>>   #include "standard-headers/asm-x86/kvm_para.h"
>>>>> @@ -516,6 +517,7 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **er=
rp)
>>>>>       X86CPU *x86cpu =3D X86_CPU(cpu);
>>>>>       CPUX86State *env =3D &x86cpu->env;
>>>>>       g_autofree struct kvm_tdx_init_vm *init_vm =3D NULL;
>>>>> +    size_t data_len;
>>>>>       int r =3D 0;
>>>>>       object_property_set_bool(OBJECT(cpu), "pmu", false, &error_abor=
t);
>>>>> @@ -528,6 +530,38 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **e=
rrp)
>>>>>       init_vm =3D g_malloc0(sizeof(struct kvm_tdx_init_vm) +
>>>>>                           sizeof(struct kvm_cpuid_entry2) * KVM_MAX_C=
PUID_ENTRIES);
>>>>> +#define SHA384_DIGEST_SIZE  48
>>>>> +
>>>>> +    if (tdx_guest->mrconfigid) {
>>>>> +        g_autofree uint8_t *data =3D qbase64_decode(tdx_guest->mrcon=
figid,
>>>>> +                              strlen(tdx_guest->mrconfigid), &data_l=
en, errp);
>>>>> +        if (!data || data_len !=3D SHA384_DIGEST_SIZE) {
>>>>> +            error_setg(errp, "TDX: failed to decode mrconfigid");
>>>>> +            return -1;
>>>>> +        }
>>>>> +        memcpy(init_vm->mrconfigid, data, data_len);
>>>>> +    }
>>>>
>>>> When @mrconfigid is absent, the property remains null, and this
>>>> conditional is not executed.  init_vm->mrconfigid[], an array of 6
>>>> __u64, remains all zero.  How does the kernel treat that?
>>>
>>> A all-zero SHA384 value is still a valid value, isn't it?
>>>
>>> KVM treats it with no difference.
>>
>> Can you point me to the spot in the kernel where mrconfigid is used?
>
> https://github.com/intel/tdx/blob/66a10e258636fa8ec9f5ce687607bf2196a9234=
1/arch/x86/kvm/vmx/tdx.c#L2322
>
> KVM just copy what QEMU provides into its own data structure @td_params. =
The format @of td_params is defined by TDX spec, and @td_params needs to be=
 passed to TDX module when initialize the context of TD via SEAMCALL(TDH.MN=
G.INIT): https://github.com/intel/tdx/blob/66a10e258636fa8ec9f5ce687607bf21=
96a92341/arch/x86/kvm/vmx/tdx.c#L2450
>
>
> In fact, all the three SHA384 fields, will be hashed together with some o=
ther fields (in td_params and other content of TD) to compromise the initia=
l measurement of TD.
>
> TDX module doesn't care the value of td_params->mrconfigid.

My problem is that I don't understand when and why users would omit the
optional @mrFOO.

I naively expected absent @mrFOO to mean something like "no attestation
of FOO".

But I see that they default to
"00000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000".

If this zero value is special and means "no attestation", then we
accidentally get no attestation when whatever is being hashed happens to
hash to this zero value.  Unlikely, but possible.

If it's not special, then when and why is the ability to omit it useful?


