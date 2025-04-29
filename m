Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7361FC3ABA9
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 09:39:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9hQd-0001Om-A7; Tue, 29 Apr 2025 05:39:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1u9hQY-0001La-Qi
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 05:38:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1u9hQW-0007ZE-8r
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 05:38:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745919535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KR1LcDvsP9uT0uOKvz6dwPjLfvp1L742V1Hmhtu47no=;
 b=Wn9bFKBhTcGkCxX52F7NI+o5Zvd+w/21kd0rhDqDTg3/4Pu2UBxw6Fci0mwb5/4HXvdKnt
 tw7FyyfuDeMVNR9c94q+OtVfZR/fNpu0sfZi89HA/FdzNBoNQ93Q+HaiQKGs+q1vsPoyE2
 6rn1NR7Zzn+PqryQ0oPCCLxizmM2vFU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691--vYir4OeNMaBV74Bv58JHw-1; Tue,
 29 Apr 2025 05:38:53 -0400
X-MC-Unique: -vYir4OeNMaBV74Bv58JHw-1
X-Mimecast-MFC-AGG-ID: -vYir4OeNMaBV74Bv58JHw_1745919531
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EE9D41800368; Tue, 29 Apr 2025 09:38:50 +0000 (UTC)
Received: from localhost (dhcp-192-216.str.redhat.com [10.33.192.216])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B73371800D97; Tue, 29 Apr 2025 09:38:49 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: eric.auger@redhat.com, eric.auger.pro@gmail.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 oliver.upton@linux.dev, sebott@redhat.com,
 shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com,
 agraf@csgraf.de
Cc: shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org,
 pbonzini@redhat.com
Subject: Re: [PATCH for-10.1 v5 04/13] arm/cpu: Store aa64pfr0/1 into the
 idregs array
In-Reply-To: <07b785e0-431d-40ba-ab04-56336fdac483@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <20250409144304.912325-1-cohuck@redhat.com>
 <20250409144304.912325-5-cohuck@redhat.com>
 <07b785e0-431d-40ba-ab04-56336fdac483@redhat.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Tue, 29 Apr 2025 11:38:47 +0200
Message-ID: <87ldrjqpco.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Apr 28 2025, Eric Auger <eric.auger@redhat.com> wrote:

> On 4/9/25 4:42 PM, Cornelia Huck wrote:
>> From: Eric Auger <eric.auger@redhat.com>
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Reviewed-by: Sebastian Ott <sebott@redhat.com>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>>  target/arm/cpu-features.h | 40 ++++++++++++++++-----------------
>>  target/arm/cpu.c          | 29 ++++++++----------------
>>  target/arm/cpu.h          |  2 --
>>  target/arm/cpu64.c        | 14 ++++--------
>>  target/arm/helper.c       |  6 ++---
>>  target/arm/hvf/hvf.c      |  9 ++++----
>>  target/arm/kvm.c          | 24 +++++++++-----------
>>  target/arm/tcg/cpu64.c    | 47 ++++++++++++++++++---------------------
>>  8 files changed, 73 insertions(+), 98 deletions(-)

>> @@ -380,10 +378,8 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>>           * than skipping the reads and leaving 0, as we must avoid
>>           * considering the values in every case.
>>           */
>> -        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_pfr0,
>> -                              ARM64_SYS_REG(3, 0, 0, 1, 0));
>> -        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_pfr1,
>> -                              ARM64_SYS_REG(3, 0, 0, 1, 1));
>> +        err |= get_host_cpu_reg(fd, ahcf, ID_AA64PFR0_EL1_IDX);
> Hum I think we have a conversion mistake here:
>
> +DEF(ID_PFR0_EL1, 3, 0, 0, 1, 0)
> +DEF(ID_PFR1_EL1, 3, 0, 0, 1, 1)

Indeed, wrong regs. Will fix.


