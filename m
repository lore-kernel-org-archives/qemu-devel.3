Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58F71C61CE8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 15:30:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPjsT-0001nl-8k; Thu, 12 Jun 2025 11:30:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uPjsO-0001jJ-G2
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 11:30:01 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uPjsJ-0008KV-5Z
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 11:30:00 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-710bbd7a9e2so8478097b3.0
 for <qemu-devel@nongnu.org>; Thu, 12 Jun 2025 08:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749742193; x=1750346993; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=geYJAPYMrYCt/FNmyMs6RoHZ9I62sqBam9PO+m4TAek=;
 b=dz7XqQQzIDi0UFhyrVkrhX1D7N6sm618cOLgjYJ2xftEvwgj3UgQ7We876/rYcUYhp
 hvVgBaPmvT+ziw12pM5O8pbDhoeX4SxzK8PRVVmFMGGAuHXI/J2sgtEiiyfn6L84mK94
 n6AWvd1WXWW4sVKIys7JOO7UX+nH3vaNVNMdrOv+qiZoKdrmxZTmcYzFkjyaTyzkW3TQ
 eU+u+rtoToeJrsaMeXH7OCUv8ps8EzTxMqiYCfOU+T1Egbr5iMu4cKPAHmX/XI17tBjz
 JD/EpUo7oDB4DrL64x1QTL+s+dH2iDN2wm7NuOTXrLKbKycXGk+MPJ6DewisxqrE/llR
 /GZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749742193; x=1750346993;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=geYJAPYMrYCt/FNmyMs6RoHZ9I62sqBam9PO+m4TAek=;
 b=rmjCavkEdr0cPwsudJk0iHwc1sX0QCMoXRSHMt/zPm719Y7enA+beV9aZoDus1mhm+
 95oUE89/yiQNIQS96+tdIRb7K84ty+C/GRZKZ0U3pZ63g3VfpPMy12Frs6IC2XKmcMrZ
 N7lXEwMu6C8ui4jB6m2p29E+ham5j0zavinQfabxtuIM923Ruw/7hTf92QVDozbPosIG
 LBiBk28t2rTectUw4XNk0mTJoCqaEyiWxBh15+NvR4a+ayio+DTsU6Ad260ct+Fg+B8g
 RxTKLpptgXIoFOKxVtVO+ZUqjXSNAs4O66wh3Usm0DmEH+PjUgrTphdtVwGeKaZAm69a
 Isww==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQslA2uvIOOcNBucSLiOmuO8pji3Q2zjykGxvpZgfvTfknwL7nd8amBDTgk51KmeP8dB/OowyNHTjK@nongnu.org
X-Gm-Message-State: AOJu0YxFk6Yu5B5HNg8GRKwBdjVQq/a2Uy+46FT7D+PH18g/HnuSR6rQ
 wznACz1eAtG8Vnp5nI0Q78vrdjFP18lwhremjhZeq19hytk/3ZsbjxJpSO7cS9NgKYLf8ZFcRQQ
 Qro9f/vDjHSymnTL6zatnZK/TD9RCvwSzvtcGSWQkYg==
X-Gm-Gg: ASbGncuQmuB/MJntHGVYoePBCpzdK2QhYGrZ7yEA2/+2qBYIgJV/XdIb2GpOLM4qOYq
 L5dxPXQeoFL+RXudLPCEGAfc4FrPwdBYaQJWNPeZLZnv7wW/bqWXWRTaBGS8cSgj39bBc0QRTwM
 33GwnwrhqkQz0VseR5QdwEb8JeSlgv8T1mhWCMiG3NilZp
X-Google-Smtp-Source: AGHT+IENjmqyi7346POaDkGZR6RfoGXIVitfUyfSfUlXG98lTBAK4TulNP1eC5vKMUT/0qOqM92Y6Hx33E5GW3olJ4A=
X-Received: by 2002:a05:690c:7483:b0:70e:73ae:766c with SMTP id
 00721157ae682-71161effb98mr5173077b3.22.1749742193383; Thu, 12 Jun 2025
 08:29:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250515153907.151174-1-cohuck@redhat.com>
 <20250515153907.151174-13-cohuck@redhat.com>
In-Reply-To: <20250515153907.151174-13-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Jun 2025 16:29:41 +0100
X-Gm-Features: AX0GCFu9aivLSnaUx6RMU2aaTzhZKVbQDpI7U6eisLoQVjKLj6ZZzS6PLa-nZE4
Message-ID: <CAFEAcA-xDxoRLWZCMrAEeSb3NvyyOPzYgFQbbEzGALujOOG-3g@mail.gmail.com>
Subject: Re: [PATCH v7 12/14] arm/cpu: Add sysreg generation scripts
To: Cornelia Huck <cohuck@redhat.com>
Cc: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, richard.henderson@linaro.org, 
 alex.bennee@linaro.org, maz@kernel.org, oliver.upton@linux.dev, 
 sebott@redhat.com, shameerali.kolothum.thodi@huawei.com, armbru@redhat.com, 
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com, 
 agraf@csgraf.de, shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org, 
 pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 15 May 2025 at 16:40, Cornelia Huck <cohuck@redhat.com> wrote:
>
> From: Eric Auger <eric.auger@redhat.com>
>
> Introduce scripts that automate the generation of system register
> definitions from a given linux source tree arch/arm64/tools/sysreg.
>
> Invocation of
> ./update-aarch64-sysreg-code.sh $PATH_TO_LINUX_SOURCE_TREE
> in scripts directory generates target/arm/cpu-sysregs.h.inc
> containing defines for all system registers.
>
> [CH: update to handle current kernel sysregs structure, and to emit
>      the re-worked register structures; cpu properties will be added
>      later]
> Reviewed-by: Sebastian Ott <sebott@redhat.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---

> diff --git a/scripts/gen-cpu-sysregs-header.awk b/scripts/gen-cpu-sysregs-header.awk
> new file mode 100755
> index 000000000000..452e51035d52
> --- /dev/null
> +++ b/scripts/gen-cpu-sysregs-header.awk

This should probably have 'arm' in the filename somewhere, unless
it's really architecture-agnostic, which I don't think it is.

> @@ -0,0 +1,35 @@
> +#!/bin/awk -f

Does this really need to be in awk? Our standard scripting
language is python. This isn't run at build time so there's
no "extra dependency" issue, but we currently use awk only
minimally and almost always for trivial stuff.

> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# gen-cpu-sysregs-header.awk: arm64 sysreg header include generator
> +#
> +# Usage: awk -f gen-cpu-sysregs-header.awk $LINUX_PATH/arch/arm64/tools/sysreg
> +
> +BEGIN {
> +    print ""
> +} END {
> +    print ""
> +}
> +
> +# skip blank lines and comment lines
> +/^$/ { next }
> +/^[\t ]*#/ { next }
> +
> +/^Sysreg\t/ || /^Sysreg /{
> +
> +       reg = $2
> +       op0 = $3
> +       op1 = $4
> +       crn = $5
> +       crm = $6
> +       op2 = $7
> +
> +       if (op0 == 3 && (op1>=0 && op1<=3) && crn==0 && (crm>=0 && crm<=7) && (op2>=0 && op2<=7)) {
> +           print "DEF("reg", "op0", "op1", "crn", "crm", "op2")"
> +       }
> +       next
> +}
> +
> +{
> +       /* skip all other lines */
> +       next
> +}

Generated source files should have a comment at the top
noting that they're autogenerated and how to regenerate
them, please.

> diff --git a/scripts/update-aarch64-sysreg-code.sh b/scripts/update-aarch64-sysreg-code.sh
> new file mode 100755
> index 000000000000..e34538887dd8
> --- /dev/null
> +++ b/scripts/update-aarch64-sysreg-code.sh
> @@ -0,0 +1,26 @@
> +#!/bin/sh -e
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Update target/arm/cpu-sysregs.h
> +# from a linux source tree (arch/arm64/tools/sysreg)
> +#
> +# Copyright Red Hat, Inc. 2024
> +#
> +# Authors:
> +#          Eric Auger <eric.auger@redhat.com>
> +#
> +
> +linux="$1"
> +output="$PWD"

We seem to set this but then not use it.

> +
> +if [ -z "$linux" ] || ! [ -d "$linux" ]; then
> +    cat << EOF
> +usage: update-aarch64-sysreg-code.sh LINUX_PATH
> +
> +LINUX_PATH      Linux kernel directory to obtain the headers from
> +EOF
> +    exit 1
> +fi
> +
> +awk -f gen-cpu-sysregs-header.awk \
> +    $linux/arch/arm64/tools/sysreg > ../target/arm/cpu-sysregs.h.inc

This looks like it is assuming that the user runs the script
from within the scripts/ directory ?

Following the same command line conventions as our existing
scripts/update-linux-headers.sh is probably the least
surprising thing.

thanks
-- PMM

