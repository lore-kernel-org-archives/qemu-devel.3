Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A61E77199
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 13:10:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV9LF-0001W7-9j; Tue, 07 Jan 2025 08:09:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tV9L3-0001Tr-GQ; Tue, 07 Jan 2025 08:09:43 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tV9L1-0007q0-Hq; Tue, 07 Jan 2025 08:09:41 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5741C4E6000;
 Tue, 07 Jan 2025 14:09:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id U0rxOlpL8Io9; Tue,  7 Jan 2025 14:09:30 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 62FA44E6010; Tue, 07 Jan 2025 14:09:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 60242746F60;
 Tue, 07 Jan 2025 14:09:30 +0100 (CET)
Date: Tue, 7 Jan 2025 14:09:30 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org,
 =?ISO-8859-15?Q?Fr=E9d=E9ric_Barrat?= <fbarrat@linux.ibm.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, Cameron Esfahani <dirty@apple.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
 Alexander Graf <agraf@csgraf.de>, Paul Durrant <paul@xen.org>, 
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 xen-devel@lists.xenproject.org, qemu-arm@nongnu.org, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@redhat.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Reinoud Zandijk <reinoud@netbsd.org>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org, 
 Riku Voipio <riku.voipio@iki.fi>, Anthony PERARD <anthony@xenproject.org>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Sunil Muthuswamy <sunilmut@microsoft.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Marcelo Tosatti <mtosatti@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Roman Bolshakov <rbolshakov@ddn.com>, 
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Phil Dennis-Jordan <phil@philjordan.eu>, 
 David Woodhouse <dwmw2@infradead.org>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Anton Johansson <anjo@rev.ng>
Subject: Re: [RFC PATCH 6/7] accel/hvf: Use CPU_FOREACH_HVF()
In-Reply-To: <6df59c2c-e29d-4b86-8908-4cb9093bad13@linaro.org>
Message-ID: <4abe9825-ff86-5e7d-1170-3677d5494879@eik.bme.hu>
References: <20250106200258.37008-1-philmd@linaro.org>
 <20250106200258.37008-7-philmd@linaro.org>
 <bd8168fe-c774-4f75-8a94-1a67ec31e38d@ventanamicro.com>
 <6df59c2c-e29d-4b86-8908-4cb9093bad13@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1325344726-1736255370=:80373"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1325344726-1736255370=:80373
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 6 Jan 2025, Philippe Mathieu-Daudé wrote:
> On 6/1/25 21:33, Daniel Henrique Barboza wrote:
>> 
>> 
>> On 1/6/25 5:02 PM, Philippe Mathieu-Daudé wrote:
>>> Only iterate over HVF vCPUs when running HVF specific code.
>>> 
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   include/system/hvf_int.h  | 4 ++++
>>>   accel/hvf/hvf-accel-ops.c | 9 +++++----
>>>   target/arm/hvf/hvf.c      | 4 ++--
>>>   3 files changed, 11 insertions(+), 6 deletions(-)
>>> 
>>> diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
>>> index 42ae18433f0..3cf64faabd1 100644
>>> --- a/include/system/hvf_int.h
>>> +++ b/include/system/hvf_int.h
>>> @@ -11,6 +11,8 @@
>>>   #ifndef HVF_INT_H
>>>   #define HVF_INT_H
>>> +#include "system/hw_accel.h"
>>> +
>>>   #ifdef __aarch64__
>>>   #include <Hypervisor/Hypervisor.h>
>>>   typedef hv_vcpu_t hvf_vcpuid;
>>> @@ -74,4 +76,6 @@ int hvf_put_registers(CPUState *);
>>>   int hvf_get_registers(CPUState *);
>>>   void hvf_kick_vcpu_thread(CPUState *cpu);
>>> +#define CPU_FOREACH_HVF(cpu) CPU_FOREACH_HWACCEL(cpu)
>> 
>> 
>> Cosmetic comment: given that this is HVF specific code and we only support 
>> one hw
>> accelerator at a time, I'd skip this alias and use CPU_FOREACH_HWACCEL(cpu) 
>> directly.
>> It would make it easier when grepping to see where and how the macro is 
>> being used.
>
> I find it more useful to grep for a particular accelerator, or for
> all of them:
>
> $ git grep CPU_FOREACH_
> accel/hvf/hvf-accel-ops.c:507:    CPU_FOREACH_HVF(cpu) {
> accel/hvf/hvf-accel-ops.c:546:    CPU_FOREACH_HVF(cpu) {
> accel/kvm/kvm-all.c:875:        CPU_FOREACH_KVM(cpu) {
> accel/kvm/kvm-all.c:938:    CPU_FOREACH_KVM(cpu) {
> accel/tcg/cputlb.c:372:    CPU_FOREACH_TCG(cpu) {
> accel/tcg/cputlb.c:650:        CPU_FOREACH_TCG(dst_cpu) {

But then you need to define a new macro for every new accelerator. Maybe 
it's simpler to have CPU_FOREACH take the queue as a parameter so no 
separate macro is needed for each accel (and they cannot get inconsistent 
by changing only one of them in the future).

Regards,
BALATON Zoltan
--3866299591-1325344726-1736255370=:80373--

