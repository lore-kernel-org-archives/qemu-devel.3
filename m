Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D235C3ABCC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 14:55:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFDV8-0000jh-Vt; Wed, 14 May 2025 10:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uFDV6-0000iq-PI
 for qemu-devel@nongnu.org; Wed, 14 May 2025 10:54:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uFDV5-0002MS-62
 for qemu-devel@nongnu.org; Wed, 14 May 2025 10:54:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747234464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KF6lDVwcE50AHlY5Ciik4TP5xsofh1kR+7PtPFs+N2U=;
 b=T8jLcYangM8Xmxi3z8Dx1JNCmSaGwmCEeshHV+vku0OcEnQqNYRzARmj/zvqbisR3owCgm
 DRGnEP3yNnIachGOFKhfdMcaJBHDTBrOLmhSxkzi50dSq3sLCAOMzDxLATLU35htiJLb7P
 8JbXxmLqQNYwInlZTf/vaS9JXKZgMBo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-35-TdhHYpF5MzyBlTdPUz-4JQ-1; Wed,
 14 May 2025 10:54:23 -0400
X-MC-Unique: TdhHYpF5MzyBlTdPUz-4JQ-1
X-Mimecast-MFC-AGG-ID: TdhHYpF5MzyBlTdPUz-4JQ_1747234461
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0A45A1956050; Wed, 14 May 2025 14:54:20 +0000 (UTC)
Received: from localhost (dhcp-192-216.str.redhat.com [10.33.192.216])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C74DC30001A1; Wed, 14 May 2025 14:54:17 +0000 (UTC)
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
Subject: Re: [PATCH v6 12/14] arm/cpu: Add sysreg generation scripts
In-Reply-To: <aCNwKBDtJES0GX3q@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <20250506085234.855779-1-cohuck@redhat.com>
 <20250506085234.855779-13-cohuck@redhat.com> <aCNwKBDtJES0GX3q@redhat.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Wed, 14 May 2025 16:54:15 +0200
Message-ID: <87ecwrckfc.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

On Tue, May 13 2025, Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Tue, May 06, 2025 at 10:52:32AM +0200, Cornelia Huck wrote:
>> From: Eric Auger <eric.auger@redhat.com>
>>=20
>> Introduce scripts that automate the generation of system register
>> definitions from a given linux source tree arch/arm64/tools/sysreg.
>>=20
>> Invocation of
>> ./update-aarch64-sysreg-code.sh $PATH_TO_LINUX_SOURCE_TREE
>> in scripts directory generates target/arm/cpu-sysregs.h.inc
>> containing defines for all system registers.
>>=20
>> [CH: update to handle current kernel sysregs structure, and to emit
>>      the re-worked register structures; cpu properties will be added
>>      later]
>> Reviewed-by: Sebastian Ott <sebott@redhat.com>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>>  scripts/gen-cpu-sysregs-header.awk    | 35 +++++++++++++++++++++++++++
>>  scripts/update-aarch64-sysreg-code.sh | 25 +++++++++++++++++++
>>  2 files changed, 60 insertions(+)
>>  create mode 100755 scripts/gen-cpu-sysregs-header.awk
>>  create mode 100755 scripts/update-aarch64-sysreg-code.sh
>>=20
>> diff --git a/scripts/gen-cpu-sysregs-header.awk b/scripts/gen-cpu-sysreg=
s-header.awk
>> new file mode 100755
>> index 000000000000..b6b207e3c0fd
>> --- /dev/null
>> +++ b/scripts/gen-cpu-sysregs-header.awk
>> @@ -0,0 +1,35 @@
>> +#!/bin/awk -f
>> +# SPDX-License-Identifier: GPL-2.0
>
> Invalid license name here - hopefully checkpatch.pl is warning
> about this.

It might not check .awk scripts?

>
> Same issue as in the other sysreg script in the host CPU model
> series.
>
>
>> diff --git a/scripts/update-aarch64-sysreg-code.sh b/scripts/update-aarc=
h64-sysreg-code.sh
>> new file mode 100755
>> index 000000000000..721f41a9a516
>> --- /dev/null
>> +++ b/scripts/update-aarch64-sysreg-code.sh
>> @@ -0,0 +1,25 @@
>> +#!/bin/sh -e
>> +#
>> +# Update target/arm/cpu-sysregs.h
>> +# from a linux source tree (arch/arm64/tools/sysreg)
>> +#
>> +# Copyright Red Hat, Inc. 2024
>> +#
>> +# Authors:
>> +#          Eric Auger <eric.auger@redhat.com>
>
> Although its fairly short, this still deserves SPDX-License-Identifier
> to be set.

@Eric: do you agree on "GPL-2.0-or-later"?


