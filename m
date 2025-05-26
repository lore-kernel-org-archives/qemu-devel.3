Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB88C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 12:38:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJX5Y-0007X8-69; Mon, 26 May 2025 08:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uJX5W-0007W6-Fp
 for qemu-devel@nongnu.org; Mon, 26 May 2025 08:37:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uJX5R-0002Kk-Hn
 for qemu-devel@nongnu.org; Mon, 26 May 2025 08:37:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748263065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bdtrnT9RkpG11o+5p+F4BXtRoB0VKLAec4NLA2DCwqM=;
 b=Uxb2GutR/2YFk3r/sGg6PAnMZefFL/UtPNo8RXP2YalmiMuxPmizE+t+G4mYSB5oN24APK
 t+3IRcHwiS+GSuDeAPbcUWii27qm0uVnKUZciLZe2oxRBaRtMemZS6eYpAskVfaaXuDgdu
 Qa9GFWrFF/4uaupDlVQRYghv1hXzOgY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-317-vjeMu_RjNlC9nfbj3I-ifw-1; Mon,
 26 May 2025 08:37:39 -0400
X-MC-Unique: vjeMu_RjNlC9nfbj3I-ifw-1
X-Mimecast-MFC-AGG-ID: vjeMu_RjNlC9nfbj3I-ifw_1748263058
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D69AE1956089; Mon, 26 May 2025 12:37:36 +0000 (UTC)
Received: from localhost (dhcp-192-216.str.redhat.com [10.33.192.216])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E902195608D; Mon, 26 May 2025 12:37:33 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>, "maz@kernel.org"
 <maz@kernel.org>, "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "sebott@redhat.com" <sebott@redhat.com>, "armbru@redhat.com"
 <armbru@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "abologna@redhat.com" <abologna@redhat.com>, "jdenemar@redhat.com"
 <jdenemar@redhat.com>
Cc: "agraf@csgraf.de" <agraf@csgraf.de>, "shahuang@redhat.com"
 <shahuang@redhat.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>
Subject: RE: [PATCH v3 06/10] arm/kvm: Allow reading all the writable ID
 registers
In-Reply-To: <ee2e2631faf640f3807c08c6acd95732@huawei.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <20250414163849.321857-1-cohuck@redhat.com>
 <20250414163849.321857-7-cohuck@redhat.com>
 <ee2e2631faf640f3807c08c6acd95732@huawei.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Mon, 26 May 2025 14:37:31 +0200
Message-ID: <87ecwbbl9w.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, May 23 2025, Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com> wrote:

>> -----Original Message-----
>> From: Cornelia Huck <cohuck@redhat.com>
>> Sent: Monday, April 14, 2025 5:39 PM
>> To: eric.auger.pro@gmail.com; eric.auger@redhat.com; qemu-
>> devel@nongnu.org; qemu-arm@nongnu.org; kvmarm@lists.linux.dev;
>> peter.maydell@linaro.org; richard.henderson@linaro.org;
>> alex.bennee@linaro.org; maz@kernel.org; oliver.upton@linux.dev;
>> sebott@redhat.com; Shameerali Kolothum Thodi
>> <shameerali.kolothum.thodi@huawei.com>; armbru@redhat.com;
>> berrange@redhat.com; abologna@redhat.com; jdenemar@redhat.com
>> Cc: agraf@csgraf.de; shahuang@redhat.com; mark.rutland@arm.com;
>> philmd@linaro.org; pbonzini@redhat.com; Cornelia Huck
>> <cohuck@redhat.com>
>> Subject: [PATCH v3 06/10] arm/kvm: Allow reading all the writable ID
>> registers
>> 
>> From: Eric Auger <eric.auger@redhat.com>
>> 
>> At the moment kvm_arm_get_host_cpu_features() reads a subset of the
>> ID regs. As we want to introduce properties for all writable ID reg
>> fields, we want more genericity and read more default host register
>> values.
>> 
>> Introduce a new get_host_cpu_idregs() helper and add a new exhaustive
>> boolean parameter to kvm_arm_get_host_cpu_features() and
>> kvm_arm_set_cpu_features_from_host() to select the right behavior.
>> The host cpu model will keep the legacy behavior unless the writable
>> id register interface is available.
>> 
>> A writable_map IdRegMap is introduced in the CPU object. A subsequent
>> patch will populate it.
>> 
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>>  target/arm/cpu-sysregs.h |  2 ++
>>  target/arm/cpu.h         |  3 ++
>>  target/arm/cpu64.c       |  2 +-
>>  target/arm/kvm.c         | 78 ++++++++++++++++++++++++++++++++++++++--
>>  target/arm/kvm_arm.h     |  9 +++--
>>  target/arm/trace-events  |  1 +
>>  6 files changed, 89 insertions(+), 6 deletions(-)

(...)

>> +/*
>> + * get_host_cpu_idregs: Read all the writable ID reg host values
>> + *
>> + * Need to be called once the writable mask has been populated
>> + * Note we may want to read all the known id regs but some of them are
>> not
>> + * writable and return an error, hence the choice of reading only those
>> which
>> + * are writable. Those are also readable!
>> + */
>> +static int get_host_cpu_idregs(ARMCPU *cpu, int fd, ARMHostCPUFeatures
>> *ahcf)
>> +{
>> +    int err = 0;
>> +    int i;
>> +
>> +    for (i = 0; i < NUM_ID_IDX; i++) {
>> +        ARM64SysReg *sysregdesc = &arm64_id_regs[i];
>> +        ARMSysRegs sysreg = sysregdesc->sysreg;
>> +        uint64_t writable_mask = cpu->writable_map-
>> >regs[idregs_idx_to_kvm_idx(i)];
>> +        uint64_t *reg;
>> +        int ret;
>> +
>> +        if (!writable_mask) {
>> +            continue;
>> +        }
>> +
>> +        reg = &ahcf->isar.idregs[i];
>> +        ret = read_sys_reg64(fd, reg, idregs_sysreg_to_kvm_reg(sysreg));
>
> I think we can use get_host_cpu_reg() here.

We'd need to rejiggle the tracing a bit, though.

Looking at this, maybe we have too many cross-indexing variants, I'll
check and see if we can simplify that a bit.

>
>> +        trace_get_host_cpu_idregs(sysregdesc->name, *reg);
>> +        if (ret) {
>> +            error_report("%s error reading value of host %s register (%m)",
>> +                         __func__, sysregdesc->name);
>> +
>> +            err = ret;
>> +        }
>> +    }
>> +    return err;
>> +}
>> +
>> +static bool
>> +kvm_arm_get_host_cpu_features(ARMCPU *cpu, ARMHostCPUFeatures
>> *ahcf,
>> +                              bool exhaustive)
>>  {
>>      /* Identify the feature bits corresponding to the host CPU, and
>>       * fill out the ARMHostCPUClass fields accordingly. To do this
>> @@ -398,6 +465,11 @@ static bool
>> kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>>          err |= get_host_cpu_reg(fd, ahcf, ID_DFR1_EL1_IDX);
>>          err |= get_host_cpu_reg(fd, ahcf, ID_MMFR5_EL1_IDX);
>> 
>> +        /* Make sure writable ID reg values are read */
>> +        if (exhaustive) {
>> +            err |= get_host_cpu_idregs(cpu, fd, ahcf);
>> +        }
>
>
> Also if we do this a bit above can we avoid reading the ID registers twice
> if "exhaustive=true" ?

It's probably not performance critical as we just do this once, but
let's try that anyway.


