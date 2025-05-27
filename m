Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D604C54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 10:07:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJrDO-0006aI-Lk; Tue, 27 May 2025 06:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uJrDF-0006ZT-UR
 for qemu-devel@nongnu.org; Tue, 27 May 2025 06:07:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uJrDD-0006Hs-SZ
 for qemu-devel@nongnu.org; Tue, 27 May 2025 06:07:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748340429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HknLfGhWrCtmGXx/VCFJmPd/NUIKIcmMxx6r3LCgYjI=;
 b=b6kVTcTso6aMvbSLLtobCUh3ODl0mtn272OgTgK3VCZLVCEe0bufo5QE6PDisFpW0x1qbW
 rNk/JeY5F7idDC7iFWhIJMapW4p/9ytyJNVp4YeaLn8imCNcyC2AXYKwlIBUdwBU47GemF
 wRPInDaPlt4lw79jAR57BRQM8eIk1as=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-449-4AEKlbMTN5ObR0CfXOENTQ-1; Tue,
 27 May 2025 06:07:05 -0400
X-MC-Unique: 4AEKlbMTN5ObR0CfXOENTQ-1
X-Mimecast-MFC-AGG-ID: 4AEKlbMTN5ObR0CfXOENTQ_1748340424
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D94B180036F; Tue, 27 May 2025 10:07:02 +0000 (UTC)
Received: from localhost (unknown [10.2.16.9])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B217630001A1; Tue, 27 May 2025 10:06:59 +0000 (UTC)
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
Subject: RE: [PATCH v3 00/10] kvm/arm: Introduce a customizable aarch64 KVM
 host model
In-Reply-To: <87bjrfbkyz.fsf@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <20250414163849.321857-1-cohuck@redhat.com>
 <de7db6bc22ad4f0a8ac1fac718c810a1@huawei.com> <87bjrfbkyz.fsf@redhat.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Tue, 27 May 2025 12:06:57 +0200
Message-ID: <878qmibc5a.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, May 26 2025, Cornelia Huck <cohuck@redhat.com> wrote:

> On Fri, May 23 2025, Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com> wrote:
>
>> Hi,
>>
>>> -----Original Message-----
>>> From: Cornelia Huck <cohuck@redhat.com>
>>> Sent: Monday, April 14, 2025 5:39 PM
>>> To: eric.auger.pro@gmail.com; eric.auger@redhat.com; qemu-
>>> devel@nongnu.org; qemu-arm@nongnu.org; kvmarm@lists.linux.dev;
>>> peter.maydell@linaro.org; richard.henderson@linaro.org;
>>> alex.bennee@linaro.org; maz@kernel.org; oliver.upton@linux.dev;
>>> sebott@redhat.com; Shameerali Kolothum Thodi
>>> <shameerali.kolothum.thodi@huawei.com>; armbru@redhat.com;
>>> berrange@redhat.com; abologna@redhat.com; jdenemar@redhat.com
>>> Cc: agraf@csgraf.de; shahuang@redhat.com; mark.rutland@arm.com;
>>> philmd@linaro.org; pbonzini@redhat.com; Cornelia Huck
>>> <cohuck@redhat.com>
>>> Subject: [PATCH v3 00/10] kvm/arm: Introduce a customizable aarch64 KVM
>>> host model
>>
>> [..]
>>
>> )
>>> 
>>> Code also available at
>>> https://gitlab.com/cohuck/qemu/-/tree/arm-cpu-model-
>>> rfcv3?ref_type=heads
>>
>> I had a spin with the above branch, but Qemu boot fails,
>>
>> ERROR:../target/arm/cpu64.c:57:get_sysreg_idx: code should not be reached
>> Bail out! ERROR:../target/arm/cpu64.c:57:get_sysreg_idx: code should not be reached
>>
>> From a quick debug, it looks like the below path results in an invalid ID idx.
>>
>> kvm_arm_expose_idreg_properties()
>>  kvm_idx_to_idregs_idx(0)
>>   get_sysreg_idx(0xc000)  --> id_register seems to start at 0xc008
>>
>> Haven't debugged further.
>>
>> I am running against a 6.15-rc1 kernel after updating the Qemu branch by,
>> ./update-aarch64-sysreg-code.sh  path_to_6.15-rc1
>>
>> Not sure I am  missing anything. Please check and let me know.
>
> Thanks for trying this out; I'll try to re-create this here.
> (I think I've messed up those conversion functions often enough...)

The conversion functions are not at fault here, but we're missing
registers. If we have MIDR and friends writable, they show up in the
masks returned by the kernel, but they are not present in the kernel's
sysreg file where we generate our definitions from, and
kvm_idx_to_idregs_idx() asserts instead of returning an error, which is
kind of suboptimal...

So I see two possible ways to fix this:
- add MIDR and friends to the kernel's sysreg file
- add MIDR and friends in QEMU's cpu-sysregs.h.inc file, and only append
  generated definitions there

First option means one more round trip, second options has more
potential for messing things up if we keep stuff local to QEMU.


