Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 179CACCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 07:32:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIirR-0004Fx-JL; Tue, 11 Nov 2025 02:32:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vIirF-0004BK-3x
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 02:32:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vIirB-0003z8-Tj
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 02:32:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762846319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WCtLIRD+fmLqFUhzuTcaK1xWurPTLl1+LnYZhUzIoTo=;
 b=ETyq0A+XYixcHYd0OO5BGqZXVAc2u7VOJ1Zx0GseLs4RIk+M4FyKsSYEBRDZNad5wR858l
 8VlsQWCvIw6GiU5PPL4jJFzipUS74lFypdFEsCdFIHj3iLePijcdMcCyQxykyQ7L/sOCAV
 ab+Pl4VLcdDJlR+1/xrYkvYc1piTKTw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-Wi3ktwNKODig974MNFRVcA-1; Tue,
 11 Nov 2025 02:31:55 -0500
X-MC-Unique: Wi3ktwNKODig974MNFRVcA-1
X-Mimecast-MFC-AGG-ID: Wi3ktwNKODig974MNFRVcA_1762846314
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 731301800452; Tue, 11 Nov 2025 07:31:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 441011956056; Tue, 11 Nov 2025 07:31:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 995D521E6A27; Tue, 11 Nov 2025 08:31:49 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-arm@nongnu.org,  qemu-devel@nongnu.org,
 jonathan.cameron@huawei.com,  mchehab+huawei@kernel.org,
 gengdongjiu1@gmail.com,  mst@redhat.com,  imammedo@redhat.com,
 anisinha@redhat.com,  peter.maydell@linaro.org,  pbonzini@redhat.com,
 shan.gavin@gmail.com
Subject: Re: [PATCH v3 6/8] acpi/ghes: Use error_abort in
 acpi_ghes_memory_errors()
In-Reply-To: <b673bf36-cf1b-4103-bce8-0465a1385403@redhat.com> (Gavin Shan's
 message of "Tue, 11 Nov 2025 16:02:24 +1000")
References: <20251105114453.2164073-1-gshan@redhat.com>
 <20251105114453.2164073-7-gshan@redhat.com>
 <87o6p9gmy4.fsf@pond.sub.org>
 <b673bf36-cf1b-4103-bce8-0465a1385403@redhat.com>
Date: Tue, 11 Nov 2025 08:31:49 +0100
Message-ID: <87jyzxf2je.fsf@pond.sub.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Gavin Shan <gshan@redhat.com> writes:

> Hi Markus,
>
> On 11/11/25 3:25 PM, Markus Armbruster wrote:
>> Gavin Shan <gshan@redhat.com> writes:
>>=20
>>> Use error_abort in acpi_ghes_memory_errors() so that the caller needn't
>>> explicitly call abort() on errors. With this change, its return value
>>> isn't needed any more.
>>>
>>> Suggested-by: Igor Mammedov <imammedo@redhat.com>
>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>> ---
>>>   hw/acpi/ghes-stub.c    |  6 +++---
>>>   hw/acpi/ghes.c         | 15 ++++-----------
>>>   include/hw/acpi/ghes.h |  5 +++--
>>>   target/arm/kvm.c       | 10 +++-------
>>>   4 files changed, 13 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/hw/acpi/ghes-stub.c b/hw/acpi/ghes-stub.c
>>> index 4faf573aeb..4ef914ffc5 100644
>>> --- a/hw/acpi/ghes-stub.c
>>> +++ b/hw/acpi/ghes-stub.c
>>> @@ -11,10 +11,10 @@
>>>  #include "qemu/osdep.h"
>>>  #include "hw/acpi/ghes.h"
>>>=20=20
>>> -int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
>>> -                            uint64_t *addresses, uint32_t num_of_addre=
sses)
>>> +void acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
>>> +                             uint64_t *addresses, uint32_t num_of_addr=
esses,
>>> +                             Error **errp)
>>>  {
>>> -    return -1;
>>>  }
>>=20
>> Before the patch, this function always fails: it returns -1.
>>=20
>> Afterwards, it always succeeds: it doesn't set @errp.
>>=20
>> Which one is correct?
>>=20
>
> Both are correct. This variant is only used on !CONFIG_ACPI_APEI. In this=
 case,
> there is no chance to call this variant in the only caller kvm_arch_on_si=
gbus_vcpu().
> acpi_ghes_get_state() returns NULL on !CONFIG_ACPI_APEI there.

If this is not supposed to be called, have it abort() to make it
obvious.

>>>=20=20
>>>  AcpiGhesState *acpi_ghes_get_state(void)
>>> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
>>> index 055e5d719a..aa469c03f2 100644
>>> --- a/hw/acpi/ghes.c
>>> +++ b/hw/acpi/ghes.c
>>> @@ -543,8 +543,9 @@ void ghes_record_cper_errors(AcpiGhesState *ags, co=
nst void *cper, size_t len,
>>>      notifier_list_notify(&acpi_generic_error_notifiers, &source_id);
>>>  }
>>>=20=20
>>> -int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
>>> -                            uint64_t *addresses, uint32_t num_of_addre=
sses)
>>> +void acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
>>> +                             uint64_t *addresses, uint32_t num_of_addr=
esses,
>>> +                             Error **errp)
>>=20
>> qapi/error.h:
>>=20
>>   * - Whenever practical, also return a value that indicates success /
>>   *   failure.  This can make the error checking more concise, and can
>>   *   avoid useless error object creation and destruction.  Note that
>>   *   we still have many functions returning void.  We recommend
>>   *   =E2=80=A2 bool-valued functions return true on success / false on =
failure,
>>   *   =E2=80=A2 pointer-valued functions return non-null / null pointer,=
 and
>>   *   =E2=80=A2 integer-valued functions return non-negative / negative.
>>=20
>
> Question: If it's deterministic that caller passes @error_abort or @error=
_fatal
> to acpi_ghes_memory_errors(), QEMU crashes with a core dump or exit befor=
e its
> caller to check the return value. In this case, it's still preferred for
> acpi_ghes_memory_errors() returns a value to indicate the success or fail=
ure?

Yes, to separate concerns: acpi_ghes_memory_errors() remains oblivious
of how it is called.

>>>  {
>>>      /* Memory Error Section Type */
>>>      const uint8_t guid[] =3D
>>> @@ -555,7 +556,6 @@ int acpi_ghes_memory_errors(AcpiGhesState *ags, uin=
t16_t source_id,
>>>       * Table 17-13 Generic Error Data Entry
>>>       */
>>>      QemuUUID fru_id =3D {};
>>> -    Error *errp =3D NULL;
>>>      int data_length;
>>>      GArray *block;
>>>      uint32_t block_status, i;
>>> @@ -592,16 +592,9 @@ int acpi_ghes_memory_errors(AcpiGhesState *ags, ui=
nt16_t source_id,
>>>      }
>>>=20=20
>>>      /* Report the error */
>>> -    ghes_record_cper_errors(ags, block->data, block->len, source_id, &=
errp);
>>> +    ghes_record_cper_errors(ags, block->data, block->len, source_id, e=
rrp);
>>>=20=20
>>>      g_array_free(block, true);
>>> -
>>> -    if (errp) {
>>> -        error_report_err(errp);
>>> -        return -1;
>>> -    }
>>> -
>>> -    return 0;
>>>  }
>>=20
>> The error reporting moves into the caller.
>>=20
>
> Similar question as above. If it's deterministic for the caller passes @e=
rror_abort
> or @error_fatal to acpi_ghes_memory_errors() and then to ghes_record_cper=
_errors(),
> QEMU crashes with a core dump or exit before error_report_err(errp) can b=
e executed.
> In this case, it's still preferred to have error_report_err(&error_abort)=
 or
> error_report_err(&error_fatal) in its caller?

Yes.

>>>=20=20
>>>  AcpiGhesState *acpi_ghes_get_state(void)
>>> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
>>> index f73908985d..35c7bbbb01 100644
>>> --- a/include/hw/acpi/ghes.h
>>> +++ b/include/hw/acpi/ghes.h
>>> @@ -98,8 +98,9 @@ void acpi_build_hest(AcpiGhesState *ags, GArray *tabl=
e_data,
>>>                       const char *oem_id, const char *oem_table_id);
>>>  void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
>>>                            GArray *hardware_errors);
>>> -int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
>>> -                            uint64_t *addresses, uint32_t num_of_addre=
sses);
>>> +void acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
>>> +                             uint64_t *addresses, uint32_t num_of_addr=
esses,
>>> +                             Error **errp);
>>>  void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, siz=
e_t len,
>>>                               uint16_t source_id, Error **errp);
>>>=20=20
>>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>>> index 459ca4a9b0..a889315606 100644
>>> --- a/target/arm/kvm.c
>>> +++ b/target/arm/kvm.c
>>> @@ -2458,13 +2458,9 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int co=
de, void *addr)
>>>              addresses[0] =3D paddr;
>>>              if (code =3D=3D BUS_MCEERR_AR) {
>>>                  kvm_cpu_synchronize_state(c);
>>> -                if (!acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SYN=
C,
>>> -                                             addresses, 1)) {
>>> -                    kvm_inject_arm_sea(c);
>>> -                } else {
>>> -                    error_report("failed to record the error");
>>> -                    abort();
>>> -                }
>>> +                acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SYNC,
>>> +                                        addresses, 1, &error_abort);
>>> +                kvm_inject_arm_sea(c);
>>=20
>> Before the patch, we get two error reports, like this:
>>=20
>>      qemu-system-FOO: OSPM does not acknowledge previous error, so can n=
ot record CPER for current error anymore
>>      qemu-system-FOO: failed to record the error
>>      Aborted (core dumped)
>>=20
>> Such error cascades should be avoided.
>>=20
>> Afterwards, we get one:
>>=20
>>      Unexpected error at SOURCE-FILE:LINE-NUMBER:
>>      qemu-system-FOO: OSPM does not acknowledge previous error, so can n=
ot record CPER for current error anymore
>>      Aborted (core dumped)
>>=20
>> Are all errors reported by acpi_ghes_memory_errors() programming errors,
>> i.e. when an error is reported, there's a bug for us to fix?
>>=20
>> If not, abort() is wrong before the patch, and &error_abort is wrong
>> afterwards.
>>=20
>> You can use &error_fatal for fatal errors that are not programming
>> errors.
>
> No, there is no programming errors and the core dump is actually no sense.

Confirms my suspicion :)

> It makes more sense for the caller to pass @error_fatal down to acpi_ghes=
_memory_errors().

Makes sense.

>>>              }
>>>              return;
>>>          }
>>=20
>
> Thanks,
> Gavin


