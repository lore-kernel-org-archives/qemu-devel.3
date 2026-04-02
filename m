Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A0FCC6B3E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 15:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Jbj-0003lV-60; Thu, 02 Apr 2026 11:05:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1w8Jbc-0003jV-AN
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 11:05:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1w8JbZ-0006Yk-En
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 11:05:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775142305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/Len+JygoBgd2zttBSDPHhxPuBRC+VOEGpBc5RJaBJ4=;
 b=Ny0jhMM8wxUI1zdGJu1G4cndUTFUZRUpe0hg/sh0jZgwHHCTAYqR/JiQW5yvIxWrl/kpeW
 ogMeRqI/PRPaskCa98aixDvUXeokbzbgF071d/kU8KwvcS2Gc2QDi9z1ZbBtCpAZszEqwp
 Hid5cvO59INi3kINJScGoFbl2viZpFA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-327-ylGpo3A3OFe477wyJqUv5Q-1; Thu,
 02 Apr 2026 11:05:00 -0400
X-MC-Unique: ylGpo3A3OFe477wyJqUv5Q-1
X-Mimecast-MFC-AGG-ID: ylGpo3A3OFe477wyJqUv5Q_1775142298
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 92BBC1955F04; Thu,  2 Apr 2026 15:04:57 +0000 (UTC)
Received: from localhost (unknown [10.44.49.158])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 565191800361; Thu,  2 Apr 2026 15:04:55 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: eric.auger@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Sebastian Ott
 <sebott@redhat.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>
Subject: Re: [PATCH v2 2/3] arm: handle CCSIDR_EL1 as a demuxed register
In-Reply-To: <93e01647-de7e-4c8e-adb0-7c0bda3f656e@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260204133229.297061-1-cohuck@redhat.com>
 <20260204133229.297061-3-cohuck@redhat.com>
 <93e01647-de7e-4c8e-adb0-7c0bda3f656e@redhat.com>
User-Agent: Notmuch/0.39 (https://notmuchmail.org)
Date: Thu, 02 Apr 2026 17:04:53 +0200
Message-ID: <87341de73e.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.542,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Apr 01 2026, Eric Auger <eric.auger@redhat.com> wrote:

> Hi Connie,
>
> On 2/4/26 2:32 PM, Cornelia Huck wrote:
>> Move handling of CCSIDR_EL1 over to the new *_IDREG_DEMUX
>> infrastructure.
>>
>> Tested-by: Alireza Sanaee <alireza.sanaee@huawei.com>
>> Reviewed-by: Sebastian Ott <sebott@redhat.com>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>>  hw/intc/armv7m_nvic.c        |  2 +-
>>  target/arm/cpu-sysregs.h     |  1 +
>>  target/arm/cpu-sysregs.h.inc |  1 +
>>  target/arm/cpu.h             |  6 ----
>>  target/arm/cpu64.c           | 12 ++++----
>>  target/arm/helper.c          |  2 +-
>>  target/arm/tcg/cpu32.c       | 32 +++++++++----------
>>  target/arm/tcg/cpu64.c       | 60 ++++++++++++++++++------------------
>>  8 files changed, 56 insertions(+), 60 deletions(-)
>> diff --git a/target/arm/cpu-sysregs.h.inc b/target/arm/cpu-sysregs.h.inc
>> index 3d1ed40f0439..ed466ffb7318 100644
>> --- a/target/arm/cpu-sysregs.h.inc
>> +++ b/target/arm/cpu-sysregs.h.inc
>> @@ -37,6 +37,7 @@ DEF(MVFR2_EL1, 3, 0, 0, 3, 2)
>>  DEF(ID_PFR2_EL1, 3, 0, 0, 3, 4)
>>  DEF(ID_DFR1_EL1, 3, 0, 0, 3, 5)
>>  DEF(ID_MMFR5_EL1, 3, 0, 0, 3, 6)
>> +DEF(CCSIDR_EL1, 3, 1, 0, 0, 0)
> Currently, in [PATCH 0/3] Generate target/arm/cpu-sysregs.h.inc from
> AARCHMRS Registers.json
> and especially [PATCH 1/3] scripts: introduce
> scripts/update-aarch64-sysreg-code.py
> (https://lore.kernel.org/all/20251208163751.611186-4-eric.auger@redhat.com/)
>
>
> CCSIDR_EL1 is not automatically generated. 
>
> as target/arm/cpu-sysregs.h.inc should be eventually automatically generated, shouldn't we put this definition somewhere else or do we expect to also automatically generate this demux idreg?

The generation script was explicitly skipping CCSIDR_EL1; when I played
with that script, I just removed it from the list of skipped registers.

I'm not sure if we have information to automatically generate any
demuxed registers, let me see if I can find something.

>
>>  DEF(CLIDR_EL1, 3, 1, 0, 0, 1)
>>  DEF(ID_AA64ZFR0_EL1, 3, 0, 0, 4, 4)
>>  DEF(CTR_EL0, 3, 3, 0, 0, 1)

(...)

>> @@ -792,11 +792,11 @@ static void aarch64_neoverse_v1_initfn(Object *obj)
>>       * L3: No L3 (this matches the CLIDR_EL1 value).
>>       */
>>      /* 64KB L1 dcache */
>> -    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_CCIDX, 4, 64, 64 * KiB, 0);
>> +    SET_IDREG_DEMUX(isar, CCSIDR, 0, make_ccsidr(CCSIDR_FORMAT_CCIDX, 4, 64, 64 * KiB, 0));
>>      /* 64KB L1 icache */
>> -    cpu->ccsidr[1] = cpu->ccsidr[0];
>> +    COPY_IDREG_DEMUX(isar, CCSIDR, 0, 1);
> nit: maybe we don't need a COPY but do get + set, if it is just used in
> this file. Or if we keep copy maybe use the memcpy convention?

Alternatively, we could just set the individual registers to the same
value instead of copying them. I wanted to keep the change obvious here,
but we can also defer adding a copy/memcopy macro until we really need
it.


