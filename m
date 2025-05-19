Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C92F7C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 14:51:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH1oO-0007nm-Ha; Mon, 19 May 2025 10:49:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uH1oM-0007nI-JH
 for qemu-devel@nongnu.org; Mon, 19 May 2025 10:49:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uH1oL-0000ge-0v
 for qemu-devel@nongnu.org; Mon, 19 May 2025 10:49:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747666186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tRyjY+JWvC1SFU2iPZWdTV9D8qwkGz6FhpIexNifnV4=;
 b=bosL8n18+agrzHEfOOR8rQzkPcUjxQ04sgleqsgseCRbCWYbLMk6ry/hYDq0e+iWyGLMid
 CeQvVkMVGGwvteD7DWk44Bt2yGySOtzjypLDeQZj6tYZq3WMxtoEu1qGnOII6axJHv5gvy
 kYpI3HpFfHDseqkZt0OnnpKJnARgQO0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-382-O8UDVZr3PySseP2kZxhRsw-1; Mon,
 19 May 2025 10:49:43 -0400
X-MC-Unique: O8UDVZr3PySseP2kZxhRsw-1
X-Mimecast-MFC-AGG-ID: O8UDVZr3PySseP2kZxhRsw_1747666181
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7EE48180045B; Mon, 19 May 2025 14:49:40 +0000 (UTC)
Received: from localhost (dhcp-192-216.str.redhat.com [10.33.192.216])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B7A41956095; Mon, 19 May 2025 14:49:37 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 eric.auger.pro@gmail.com,
 eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 oliver.upton@linux.dev, sebott@redhat.com,
 shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com
Cc: agraf@csgraf.de, shahuang@redhat.com, mark.rutland@arm.com,
 pbonzini@redhat.com
Subject: Re: [PATCH v3 02/10] arm/cpu: Add sysreg properties generation
In-Reply-To: <0fb4cd74-bcbf-4063-bc3b-0e8359d04117@linaro.org>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <20250414163849.321857-1-cohuck@redhat.com>
 <20250414163849.321857-3-cohuck@redhat.com>
 <0fb4cd74-bcbf-4063-bc3b-0e8359d04117@linaro.org>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Mon, 19 May 2025 16:49:34 +0200
Message-ID: <87msb8bqpt.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Tue, Apr 15 2025, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> On 14/4/25 18:38, Cornelia Huck wrote:
>> From: Eric Auger <eric.auger@redhat.com>
>>=20
>> Introduce a script that automates the generation of system register
>> properties definitions from a given linux source tree
>> arch/arm64/tools/sysreg.
>>=20
>> Invocation of
>> ./update-aarch64-sysreg-code.sh $PATH_TO_LINUX_SOURCE_TREE
>> in scripts directory additionally generates
>> target/arm/cpu-sysreg-properties.c containing definitions for
>> feature ID registers.
>>=20
>> update-aarch64-sysreg-code.sh additionally calls
>> gen-cpu-sysreg-properties.awk which is inherited from kernel
>> arch/arm64/tools/gen-sysreg.awk. All credits to Mark Rutland
>> the original author of this script.
>>=20
>> [CH: split off from original patch adding both sysreg definitions
>>   and properties]
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>>   scripts/gen-cpu-sysreg-properties.awk | 325 ++++++++++++++++++++++++++
>>   scripts/update-aarch64-sysreg-code.sh |   5 +-
>>   2 files changed, 329 insertions(+), 1 deletion(-)
>>   create mode 100755 scripts/gen-cpu-sysreg-properties.awk
>>=20
>> diff --git a/scripts/gen-cpu-sysreg-properties.awk b/scripts/gen-cpu-sys=
reg-properties.awk
>> new file mode 100755
>> index 000000000000..76c37938b168
>> --- /dev/null
>> +++ b/scripts/gen-cpu-sysreg-properties.awk
>> @@ -0,0 +1,325 @@
>> +#!/bin/awk -f
>> +# SPDX-License-Identifier: GPL-2.0
>> +# gen-cpu-sysreg-properties.awk: arm64 sysreg header generator
>> +#
>> +# Usage: awk -f gen-cpu-sysreg-properties.awk $LINUX_PATH/arch/arm64/to=
ols/sysreg
>
>
>> +BEGIN {
>
>          print "/* AUTOMATICALLY GENERATED, DO NOT MODIFY */\n"

Makes sense.

>
> Should we keep copyright?

GPL-2.0-or-later, I guess?

>
>> +	print "#include \"cpu-custom.h\""
>> +	print ""
>> +	print "ARM64SysReg arm64_id_regs[NUM_ID_IDX];"
>> +	print ""
>> +	print "void initialize_cpu_sysreg_properties(void)"
>> +	print "{"
>> +        print "    memset(arm64_id_regs, 0, sizeof(ARM64SysReg) * NUM_I=
D_IDX);"
>> +        print ""
>> +
>> +	__current_block_depth =3D 0
>> +	__current_block[__current_block_depth] =3D "Root"
>> +}


