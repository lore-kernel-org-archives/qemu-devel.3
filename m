Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5856C71136
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 16:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRYfR-0003Am-Gv; Tue, 17 Jun 2025 11:56:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uRYVI-0005Ef-Co
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 11:45:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uRYVD-0006p8-UN
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 11:45:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750175133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pimc7ToHXzj5NjsL3cnFa44sV45BUXzhB1gmiO8PNfc=;
 b=ZzhkYJtKoAecutdOyLuKOYUiWwdqHbd6sSoxfvBYddaKy9IoLOwPaq5mlyibyEkbeNKnDO
 VuF/U73m0ktSkcktg75u7k1BU4qIV9W4QidMj2tg2HeteUAt4Awe6VNbOHTiJhCKSnAumR
 +/cwrCaibWUDK8BSgEhNBy9fI2+XVws=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-KFe1QetPPQC4DZGrfoLaKw-1; Tue,
 17 Jun 2025 11:45:27 -0400
X-MC-Unique: KFe1QetPPQC4DZGrfoLaKw-1
X-Mimecast-MFC-AGG-ID: KFe1QetPPQC4DZGrfoLaKw_1750175119
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 37CE81800284; Tue, 17 Jun 2025 15:45:19 +0000 (UTC)
Received: from localhost (pixel-6a.str.redhat.com [10.33.192.205])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 257B130001B1; Tue, 17 Jun 2025 15:45:17 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 oliver.upton@linux.dev, sebott@redhat.com,
 shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com,
 agraf@csgraf.de
Cc: shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org,
 pbonzini@redhat.com
Subject: Re: [PATCH v8 12/14] arm/cpu: Add sysreg generation scripts
In-Reply-To: <20250617153931.1330449-13-cohuck@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20250617153931.1330449-1-cohuck@redhat.com>
 <20250617153931.1330449-13-cohuck@redhat.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Tue, 17 Jun 2025 17:45:15 +0200
Message-ID: <87h60e1ies.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.89,
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

On Tue, Jun 17 2025, Cornelia Huck <cohuck@redhat.com> wrote:

> diff --git a/scripts/arm-gen-cpu-sysregs-header.awk b/scripts/arm-gen-cpu-sysregs-header.awk
> new file mode 100755
> index 000000000000..f92bbbafa727
> --- /dev/null
> +++ b/scripts/arm-gen-cpu-sysregs-header.awk
> @@ -0,0 +1,37 @@
> +#!/bin/awk -f
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# arm-gen-cpu-sysregs-header.awk: arm64 sysreg header include generator
> +#
> +# Usage: awk -f arm-gen-cpu-sysregs-header.awk $LINUX_PATH/arch/arm64/tools/sysreg
> +
> +BEGIN {
> +    print "/* SPDX-License-Identifier: GPL-2.0-or-later */"

FWIW, checkpatch.pl chokes on this:

^* matches null string many times in regex; marked by <-- HERE in m/^* <-- HERE /"$/ at scripts/checkpatch.pl line 1389.
ERROR: Saw unacceptable licenses '*/"', valid choices for QEMU are:
GPL-2.0-or-later
GPL-2.0-only
LGPL-2.1-only
LGPL-2.1-or-later
BSD-2-Clause
BSD-3-Clause
MIT
total: 1 errors, 0 warnings, 76 lines checked


> +    print "/* GENERATED FILE, DO NOT EDIT */"
> +    print "/* use arm-gen-cpu-sysregs-header.awk to regenerate */"
> +} END {
> +    print ""
> +}
> +


