Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3AE6C3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 14:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFDWh-00035e-4z; Wed, 14 May 2025 10:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uFDWe-00031y-Cw
 for qemu-devel@nongnu.org; Wed, 14 May 2025 10:56:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uFDWb-0002qM-AI
 for qemu-devel@nongnu.org; Wed, 14 May 2025 10:56:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747234557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gubBPWsy/XGhmDxkfMCBUD6QZxWOn0NBq1+dq/fTvQI=;
 b=Ug8XiFw+s/vSp2P2Ll/1darrqGFaTHnW/x1XVNRlsIn2vecRcrECQFhNgltT2N4WHKcQBT
 R+td6mz5bGH0ttu/vu0MirctqBh+jopxb+AGVo/kP0s9lSFR+NQPFiJxfKbCbcvWk69zQS
 pd+aSM/fm4ZPq9l7/mwSdN5/RqC1Lc0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-Mj8NsofDMnClnEKQIjtqPw-1; Wed,
 14 May 2025 10:55:54 -0400
X-MC-Unique: Mj8NsofDMnClnEKQIjtqPw-1
X-Mimecast-MFC-AGG-ID: Mj8NsofDMnClnEKQIjtqPw_1747234552
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 590011956050; Wed, 14 May 2025 14:55:51 +0000 (UTC)
Received: from localhost (dhcp-192-216.str.redhat.com [10.33.192.216])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9396018004A7; Wed, 14 May 2025 14:55:48 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 oliver.upton@linux.dev, sebott@redhat.com,
 shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 abologna@redhat.com, jdenemar@redhat.com, agraf@csgraf.de,
 shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org,
 pbonzini@redhat.com
Subject: Re: [PATCH v6 02/14] arm/cpu: Store aa64isar0/aa64zfr0 into the
 idregs arrays
In-Reply-To: <aCNvHgB0dzJIQ8Yt@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <20250506085234.855779-1-cohuck@redhat.com>
 <20250506085234.855779-3-cohuck@redhat.com> <aCNvHgB0dzJIQ8Yt@redhat.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Wed, 14 May 2025 16:55:46 +0200
Message-ID: <87bjrvckct.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, May 13 2025, Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Tue, May 06, 2025 at 10:52:22AM +0200, Cornelia Huck wrote:
>> From: Eric Auger <eric.auger@redhat.com>
>>=20
>> Also add kvm accessors for storing host features into idregs.
>>=20
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Reviewed-by: Sebastian Ott <sebott@redhat.com>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>>  target/arm/cpu-features.h | 57 ++++++++++++++++++++-------------------
>>  target/arm/cpu.c          | 10 +++----
>>  target/arm/cpu.h          |  2 --
>>  target/arm/cpu64.c        |  8 +++---
>>  target/arm/helper.c       |  6 +++--
>>  target/arm/hvf/hvf.c      |  3 ++-
>>  target/arm/kvm.c          | 30 ++++++++++++++++++---
>>  target/arm/tcg/cpu64.c    | 44 ++++++++++++++++++------------
>>  8 files changed, 97 insertions(+), 63 deletions(-)
>>=20
>
>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>> index 5e951675c606..dc4b6edaa1d6 100644
>> --- a/target/arm/cpu.c
>> +++ b/target/arm/cpu.c
>> @@ -2225,12 +2226,9 @@ static void arm_cpu_realizefn(DeviceState *dev, E=
rror **errp)
>>      }
>>=20=20
>>      if (!cpu->has_neon && !cpu->has_vfp) {
>> -        uint64_t t;
>
> Premature removal because ....
>
>>          uint32_t u;
>>=20=20
>> -        t =3D cpu->isar.id_aa64isar0;
>> -        t =3D FIELD_DP64(t, ID_AA64ISAR0, FHM, 0);
>> -        cpu->isar.id_aa64isar0 =3D t;
>> +        FIELD_DP64_IDREG(isar, ID_AA64ISAR0, FHM, 0);
>>=20=20
>>          t =3D cpu->isar.id_aa64isar1;
>
> ...it is still used here and so breaks the build.
>
> Your next patch removes this line, so just need
> to shift the variable removal to the next patch
>
>>          t =3D FIELD_DP64(t, ID_AA64ISAR1, FRINTTS, 0);

To a v7 it goes, hopefully the last one...


