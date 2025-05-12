Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11DCCC3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 06:35:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEMko-0003Vj-To; Mon, 12 May 2025 02:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uEMki-0003SK-Du
 for qemu-devel@nongnu.org; Mon, 12 May 2025 02:35:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uEMkg-0002dw-1J
 for qemu-devel@nongnu.org; Mon, 12 May 2025 02:35:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747031700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=natpKHXNFNFKQUWTeJGwNh7Gg+YeikwA5L3IRAwW6PU=;
 b=S20pUEHG2m3xc/kjPFIYuOdaEfsOHWi9DZ6WvEkIwynfqHIQCYMt2f3+pLLLMVCfEN+k7i
 o2q7/pAGkD+B8rtLrv4yYCoSCxwLwGcL9AsXF5fS7cIkAkLLmY/FuG0UfFewzzu1tza4K5
 OAw4hKeArxjNxOqRjHxOcUh+SZhjdjU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-MX620s8OMBq5RhpUJ_HC0A-1; Mon,
 12 May 2025 02:34:55 -0400
X-MC-Unique: MX620s8OMBq5RhpUJ_HC0A-1
X-Mimecast-MFC-AGG-ID: MX620s8OMBq5RhpUJ_HC0A_1747031692
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1C3E71800264; Mon, 12 May 2025 06:34:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0AB541956058; Mon, 12 May 2025 06:34:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 769C921E66C2; Mon, 12 May 2025 08:34:46 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>,  Xiaoyao Li <xiaoyao.li@intel.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Markus
 Armbruster
 <armbru@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  "Daniel P.
 Berrange" <berrange@redhat.com>,  qemu-devel@nongnu.org,  Richard
 Henderson <richard.henderson@linaro.org>,  kvm@vger.kernel.org,  Gerd
 Hoffmann <kraxel@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,  Jiaxun Yang
 <jiaxun.yang@flygoat.com>,  Yi Liu <yi.l.liu@intel.com>,  "Michael S.
 Tsirkin" <mst@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Alistair Francis
 <alistair.francis@wdc.com>,  Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>,  Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-riscv@nongnu.org,  Weiwei Li <liwei1518@gmail.com>,  Amit Shah
 <amit@kernel.org>,  Yanan Wang <wangyanan55@huawei.com>,  Helge Deller
 <deller@gmx.de>,  Palmer Dabbelt <palmer@dabbelt.com>,  Ani Sinha
 <anisinha@redhat.com>,  Igor Mammedov <imammedo@redhat.com>,  Fabiano
 Rosas <farosas@suse.de>,  Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 qemu-arm@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>,  Jason Wang <jasowang@redhat.com>
Subject: Re: How to mark internal properties
In-Reply-To: <2f526570-7ab0-479c-967c-b3f95f9f19e3@redhat.com> (Thomas Huth's
 message of "Fri, 9 May 2025 12:04:19 +0200")
References: <20250508133550.81391-1-philmd@linaro.org>
 <20250508133550.81391-13-philmd@linaro.org>
 <23260c74-01ba-45bc-bf2f-b3e19c28ec8a@intel.com>
 <aB2vjuT07EuO6JSQ@intel.com>
 <2f526570-7ab0-479c-967c-b3f95f9f19e3@redhat.com>
Date: Mon, 12 May 2025 08:34:46 +0200
Message-ID: <87selauyk9.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Thomas Huth <thuth@redhat.com> writes:

> On 09/05/2025 09.32, Zhao Liu wrote:
>> On Fri, May 09, 2025 at 02:49:27PM +0800, Xiaoyao Li wrote:
>>> Date: Fri, 9 May 2025 14:49:27 +0800
>>> From: Xiaoyao Li <xiaoyao.li@intel.com>
>>> Subject: Re: [PATCH v4 12/27] target/i386/cpu: Remove
>>>   CPUX86State::enable_cpuid_0xb field
>>>
>>> On 5/8/2025 9:35 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> The CPUX86State::enable_cpuid_0xb boolean was only disabled
>>>> for the pc-q35-2.6 and pc-i440fx-2.6 machines, which got
>>>> removed. Being now always %true, we can remove it and simplify
>>>> cpu_x86_cpuid().
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>>>> ---
>>>> target/i386/cpu.h | 3 ---
>>>> target/i386/cpu.c | 6 ------
>>>> 2 files changed, 9 deletions(-)
>>>>
>>>> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
>>>> index 0db70a70439..06817a31cf9 100644
>>>> --- a/target/i386/cpu.h
>>>> +++ b/target/i386/cpu.h
>>>> @@ -2241,9 +2241,6 @@ struct ArchCPU {
>>>>       */
>>>>      bool legacy_multi_node;
>>>> -    /* Compatibility bits for old machine types: */
>>>> -    bool enable_cpuid_0xb;
>>>> -
>>>>      /* Enable auto level-increase for all CPUID leaves */
>>>>      bool full_cpuid_auto_level;
>>>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>>>> index 49179f35812..6fe37f71b1e 100644
>>>> --- a/target/i386/cpu.c
>>>> +++ b/target/i386/cpu.c
>>>> @@ -6982,11 +6982,6 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t i=
ndex, uint32_t count,
>>>>          break;
>>>>      case 0xB:
>>>>            /* Extended Topology Enumeration Leaf */
>>>> -        if (!cpu->enable_cpuid_0xb) {
>>>> -            *eax =3D *ebx =3D *ecx =3D *edx =3D 0;
>>>> -            break;
>>>> -        }
>>>> -
>>>>          *ecx =3D count & 0xff;
>>>>          *edx =3D cpu->apic_id;
>>>> @@ -8828,7 +8823,6 @@ static const Property x86_cpu_properties[] =3D {
>>>>      DEFINE_PROP_UINT64("ucode-rev", X86CPU, ucode_rev, 0),
>>>>      DEFINE_PROP_BOOL("full-cpuid-auto-level", X86CPU, full_cpuid_auto=
_level, true),
>>>>      DEFINE_PROP_STRING("hv-vendor-id", X86CPU, hyperv_vendor),
>>>> -    DEFINE_PROP_BOOL("cpuid-0xb", X86CPU, enable_cpuid_0xb, true),
>>>
>>> It's deprecating the "cpuid-0xb" property.
>>>
>>> I think we need go with the standard process to deprecate it.
>>=20
>> Thanks! I got your point.
>>=20
>> Though this property is introduced for compatibility, as its comment
>> said "Compatibility bits for old machine types", it is also useful for
>> somer users.
>
> Thanks for your clarifications, Zhao! But I think this shows again the=20
> problem that we have hit a couple of times in the past already: Propertie=
s=20
> are currently used for both, config knobs for the users and internal=20
> switches for configuration of the machine. We lack a proper way to say "t=
his=20
> property is usable for the user" and "this property is meant for internal=
=20
> configuration only".

Correct.

Exposing properties meant for internal use at the external interface
inevitably leads to (uncertainty about) external use.

> I wonder whether we could maybe come up with a naming scheme to better=20
> distinguish the two sets, e.g. by using a prefix similar to the "x-" pref=
ix=20
> for experimental properties? We could e.g. say that all properties starti=
ng=20
> with a "q-" are meant for QEMU-internal configuration only or something=20
> similar (and maybe even hide those from the default help output when runn=
ing=20
> "-device xyz,help" ?)? Anybody any opinions or better ideas on this?

This papers over our inability / unwillingness to isolate the external
interface from internal detail.

The proper solution is to make the internal properties inaccessible at
the external interface.  This requires declaring properties' intent.
Which strikes me as a very good idea.

A naming convention is a simple, stupid way to do that.  There are
drawbacks, as experience with the "x-" prefix has shown:

* Flipping a flag bit involves changing the name.  Tolerable when all
  uses are internal, compatibility break when not.  Not a problem when
  the bit governs external access, of course.

* Name capture: consider InputBarrier properties x-origin, y-origin.
  Oops.

* If we have multiple flag bits, their prefixes can accumulate.  This
  gets ugly and confusing real quick.  Not an issue when at most one of
  the flags can be set, as is the case for "unstable" and "internal
  use".

* QAPI reserves "q_" for the generator's use.  Since "q-" would get
  mapped to "q_" in C, we risk name clashes.

For what it's worth, QAPI abandoned the "x-" naming convention (commit
a3c45b3e629 (qapi: New special feature flag "unstable"), commit message
appended for your convenience).  Developers are free to use "x-" to help
guide human users, but the feature flag is the sole source of thruth.



[...]



commit a3c45b3e62962f99338716b1347cfb0d427cea44
Author: Markus Armbruster <armbru@redhat.com>
Date:   Thu Oct 28 12:25:12 2021 +0200

    qapi: New special feature flag "unstable"
=20=20=20=20
    By convention, names starting with "x-" are experimental.  The parts
    of external interfaces so named may be withdrawn or changed
    incompatibly in future releases.
=20=20=20=20
    The naming convention makes unstable interfaces easy to recognize.
    Promoting something from experimental to stable involves a name
    change.  Client code needs to be updated.  Occasionally bothersome.
=20=20=20=20
    Worse, the convention is not universally observed:
=20=20=20=20
    * QOM type "input-barrier" has properties "x-origin", "y-origin".
      Looks accidental, but it's ABI since 4.2.
=20=20=20=20
    * QOM types "memory-backend-file", "memory-backend-memfd",
      "memory-backend-ram", and "memory-backend-epc" have a property
      "x-use-canonical-path-for-ramblock-id" that is documented to be
      stable despite its name.
=20=20=20=20
    We could document these exceptions, but documentation helps only
    humans.  We want to recognize "unstable" in code, like "deprecated".
=20=20=20=20
    So support recognizing it the same way: introduce new special feature
    flag "unstable".  It will be treated specially by the QAPI generator,
    like the existing feature flag "deprecated", and unlike regular
    feature flags.
=20=20=20=20
    This commit updates documentation and prepares tests.  The next commit
    updates the QAPI schema.  The remaining patches update the QAPI
    generator and wire up -compat policy checking.
=20=20=20=20
    Management applications can then use query-qmp-schema and -compat to
    manage or guard against use of unstable interfaces the same way as for
    deprecated interfaces.
=20=20=20=20
    docs/devel/qapi-code-gen.txt no longer mandates the naming convention.
    Using it anyway might help writers of programs that aren't
    full-fledged management applications.  Not using it can save us
    bothersome renames.  We'll see how that shakes out.
=20=20=20=20
    Signed-off-by: Markus Armbruster <armbru@redhat.com>
    Reviewed-by: Juan Quintela <quintela@redhat.com>
    Reviewed-by: John Snow <jsnow@redhat.com>
    Message-Id: <20211028102520.747396-2-armbru@redhat.com>


