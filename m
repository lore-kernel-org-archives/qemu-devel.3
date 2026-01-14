Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 301B6D31A1E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 07:38:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfvSf-0002pA-D5; Wed, 14 Jan 2026 02:38:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vfvSd-0002oy-WE
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 02:38:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vfvSc-0005fN-L4
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 02:38:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768376313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RfbpJJw547pl6ZLP4TcDNthGLpNw4tF+zAFJ8/k1Mbw=;
 b=B0yurfQ3+5TPkfctOXIZGigXWyCpCO9SK80KWjUk+yP/pkEb/P368Nz/MZDxr9X5zHQlY7
 GeMu6tSrJLSJI3B4ueUu3T2vq3mRO/MJ7kmyb89vZnkaJ7xKeKw/lvyr1mex2p7GEPJazy
 6fwoIaoCLuUZdPR7lIgE1BN7LgOqLIE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-gOk_EOktPJ6GpCIwcCwpzg-1; Wed,
 14 Jan 2026 02:38:31 -0500
X-MC-Unique: gOk_EOktPJ6GpCIwcCwpzg-1
X-Mimecast-MFC-AGG-ID: gOk_EOktPJ6GpCIwcCwpzg_1768376310
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8E4E41800447; Wed, 14 Jan 2026 07:38:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F19C130001A2; Wed, 14 Jan 2026 07:38:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 825B521E66C9; Wed, 14 Jan 2026 08:38:26 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>,  qemu-devel@nongnu.org,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,  Reinoud Zandijk
 <reinoud@netbsd.org>,  Ryo ONODERA <ryoon@netbsd.org>
Subject: Re: [PULL 13/31] accel/nvmm: Replace @dirty field by generic
 CPUState::vcpu_dirty field
In-Reply-To: <dd7fbe03-1458-4c44-b8db-a9d5e9ae33f1@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 13 Jan 2026 21:30:32
 +0100")
References: <20250704101433.8813-1-philmd@linaro.org>
 <20250704101433.8813-14-philmd@linaro.org>
 <44ccfba7-21a3-4c24-aa6a-4b2bdb989792@redhat.com>
 <dd7fbe03-1458-4c44-b8db-a9d5e9ae33f1@linaro.org>
Date: Wed, 14 Jan 2026 08:38:26 +0100
Message-ID: <87v7h44pal.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 13/1/26 20:32, Thomas Huth wrote:
>> On 04/07/2025 12.14, Philippe Mathieu-Daud=C3=A9 wrote:
>>> No need for accel-specific @dirty field when we have
>>> a generic one in CPUState.
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
>>> Message-Id: <20250703173248.44995-20-philmd@linaro.org>
>>> ---
>>> =C2=A0 target/i386/nvmm/nvmm-all.c | 21 ++++++++++-----------
>>> =C2=A0 1 file changed, 10 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
>>> index f1c6120ccf1..aea61a6fd2a 100644
>>> --- a/target/i386/nvmm/nvmm-all.c
>>> +++ b/target/i386/nvmm/nvmm-all.c
>> ...
>>> @@ -982,7 +981,7 @@ nvmm_init_vcpu(CPUState *cpu)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> -=C2=A0=C2=A0=C2=A0 qcpu->dirty =3D true;
>>> +=C2=A0=C2=A0=C2=A0 qcpu->vcpu_dirty =3D true;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu->accel =3D qcpu;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> FYI, this does not seem to compile:
>> ../src/target/i386/nvmm/nvmm-all.c: In function 'nvmm_init_vcpu':
>> ../src/target/i386/nvmm/nvmm-all.c:988:9: error: 'AccelCPUState' has no =
member named 'vcpu_dirty'
>>  =C2=A0 988 |=C2=A0=C2=A0=C2=A0=C2=A0 qcpu->vcpu_dirty =3D true;
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ^~
>
> s/qcpu/cpu/
>
>> Is anybody checking the netbsd builds at all?
>
> 3 reviewers and 6 months later.

I have good news!  Because this does not compile since 10.1, and we're
already in the 11.0 cycle, we can rip it out immediately without doing
the deprecation dance.

> Should we add a policy for bitrotting untested code?

What policy do you have in mind?

>> (I'm currently trying to update test/vm/netbsd to version 10.1, that's h=
ow I noticed it)
>>  =C2=A0Thomas
>>=20


