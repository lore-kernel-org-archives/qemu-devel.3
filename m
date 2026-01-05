Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55223C79F8C
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 13:37:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcklx-0000UY-N0; Mon, 05 Jan 2026 08:37:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vcklv-0000U3-Ke
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 08:37:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vcklt-00068j-AL
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 08:37:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767620238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=buN8vjK1AU9q5IgTliu5eCeFgf7FvxKFDf+YQUK2gtA=;
 b=bFMifDpb0jeBKxhmua/VPQr9XQ3Y1q+z+38Ze5oaDpZXapD2JhgeqBR0tLTWFNcSnt3LWG
 RNJE7VwyZS06q/fJSuMnq+qA3RnASsccH7mMj8wI599Kmww17VjXGIz/k/kIH3eSUMF+Td
 OEKNpSONrZa47kGC9trFXeo4+At/mMo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-199-tOYGJgMhPAuXcSdPUhyjVQ-1; Mon,
 05 Jan 2026 08:37:15 -0500
X-MC-Unique: tOYGJgMhPAuXcSdPUhyjVQ-1
X-Mimecast-MFC-AGG-ID: tOYGJgMhPAuXcSdPUhyjVQ_1767620234
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD56519560A2; Mon,  5 Jan 2026 13:37:13 +0000 (UTC)
Received: from localhost (unknown [10.44.33.132])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D9BD0180035A; Mon,  5 Jan 2026 13:37:12 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eric Auger
 <eric.auger@redhat.com>
Subject: Re: [PATCH for-11.0 v2] arm: add DCZID_EL0 to idregs array
In-Reply-To: <40954ada-f7b5-4709-b5ac-a6711d503015@linaro.org>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20251127170657.3335112-1-cohuck@redhat.com>
 <40954ada-f7b5-4709-b5ac-a6711d503015@linaro.org>
User-Agent: Notmuch/0.39 (https://notmuchmail.org)
Date: Mon, 05 Jan 2026 14:37:10 +0100
Message-ID: <87wm1w9o55.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Jan 05 2026, Richard Henderson <richard.henderson@linaro.org> wrote:

> On 11/28/25 04:06, Cornelia Huck wrote:
>> This requires a bit of care, since we still have to handle the EL
>> specific part (DCZID_EL0.DZP). Callers can set/access dcz_blocksize
>> via a wrapper working on DCZID_EL.BS.
>> 
>> KVM currently does not support DCZID_EL0 via ONE_REG, assert that
>> we're not trying to do anything with it until it does.
>> 
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>> Changes v1 -> v2:
>> - use extract64/deposit64, tweak helper names
>> - assert that we're not using the reg while running under kvm, instead
>>    of providing an incorrect dummy value
>> ---
>>   target/arm/cpu-sysregs.h.inc   |  1 +
>>   target/arm/cpu.c               |  2 +-
>>   target/arm/cpu.h               | 14 ++++++++++++--
>>   target/arm/cpu64.c             |  4 ++--
>>   target/arm/helper.c            |  5 ++++-
>>   target/arm/tcg/cpu64.c         | 22 +++++++++++-----------
>>   target/arm/tcg/helper-a64.c    |  2 +-
>>   target/arm/tcg/mte_helper.c    |  4 ++--
>>   target/arm/tcg/translate-a64.c |  2 +-
>>   target/arm/tcg/translate.h     |  2 +-
>>   10 files changed, 36 insertions(+), 22 deletions(-)
>> 
>> diff --git a/target/arm/cpu-sysregs.h.inc b/target/arm/cpu-sysregs.h.inc
>> index 2bb2861c6234..7f3aa8b991aa 100644
>> --- a/target/arm/cpu-sysregs.h.inc
>> +++ b/target/arm/cpu-sysregs.h.inc
>> @@ -39,3 +39,4 @@ DEF(ID_MMFR5_EL1, 3, 0, 0, 3, 6)
>>   DEF(CLIDR_EL1, 3, 1, 0, 0, 1)
>>   DEF(ID_AA64ZFR0_EL1, 3, 0, 0, 4, 4)
>>   DEF(CTR_EL0, 3, 3, 0, 0, 1)
>> +DEF(DCZID_EL0, 3, 3, 0, 0, 7)
>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>> index 39292fb9bc1f..557af43a9709 100644
>> --- a/target/arm/cpu.c
>> +++ b/target/arm/cpu.c
>> @@ -2184,7 +2184,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>>   #endif
>>   
>>       if (tcg_enabled()) {
>> -        int dcz_blocklen = 4 << cpu->dcz_blocksize;
>> +        int dcz_blocklen = 4 << get_dczid_bs(cpu);
>>   
>>           /*
>>            * We only support DCZ blocklen that fits on one page.
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index 39f2b2e54deb..32f003705551 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -1111,8 +1111,6 @@ struct ArchCPU {
>>       bool prop_pauth_qarma5;
>>       bool prop_lpa2;
>>   
>> -    /* DCZ blocksize, in log_2(words), ie low 4 bits of DCZID_EL0 */
>> -    uint8_t dcz_blocksize;
>>       /* GM blocksize, in log_2(words), ie low 4 bits of GMID_EL0 */
>>       uint8_t gm_blocksize;
>>   
>> @@ -1178,6 +1176,18 @@ struct ARMCPUClass {
>>       ResettablePhases parent_phases;
>>   };
>>   
>> +static inline uint8_t get_dczid_bs(ARMCPU *cpu)
>> +{
>> +    return extract64(cpu->isar.idregs[DCZID_EL0_IDX], 0, 4);
>> +}
>> +
>> +static inline void set_dczid_bs(ARMCPU *cpu, uint8_t bs)
>> +{
>> +    /* keep dzp unchanged */
>> +    cpu->isar.idregs[DCZID_EL0_IDX] =
>> +        deposit64(cpu->isar.idregs[DCZID_EL0_IDX], 0, 4, bs);
>> +}
>
> Given that dzp is always computed, I don't see the point of this.  Or... is the point that 
> KVM *will* eventually support DCZID_EL0, and we won't be computing DZP along the KVM 
> trap-and-read path?

The idea was to move all of the ID registers into the idregs array
eventually, to be prepared for switching to an automatically generated
cpu-sysregs.h.inc. (Still remaining after this patch are CCSIDR* and
friends.) I'm not sure if KVM will support DCZID_EL0 anytime soon, but
if that happens, it will be easier to integrate.

>
> You could usefully split this patch, introducing the get/set helpers before changing the 
> representation.

Can do that.


