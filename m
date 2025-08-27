Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 263EFCA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 11:16:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urE7t-0007r8-44; Wed, 27 Aug 2025 07:15:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1urE7q-0007pZ-Aq
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 07:15:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1urE7n-0000ct-1J
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 07:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756293328;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=1mfY/7T5HUvtG72DJGw+wBZAara5T0QJGIo+Q7MH4Yc=;
 b=Byc2R7yzTUD95bFg0XMMxvyl+mzcLkFm1CWGSILV23PqKtQZOeeIup8lLo1Oex3ZyjTVjx
 /V9XVVbPhvtLqy8kRYzXZ9k4hXaZebhul+T3/Rkw7gU/YgZeZ8wMvgCeoPYGvspVl9Mgue
 tmsJ2ONgc0+ZOQVfo0f7bXwJDKbywn0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-320-7z-qeHTVOKWt-8Q5rQ4k0A-1; Wed,
 27 Aug 2025 07:15:27 -0400
X-MC-Unique: 7z-qeHTVOKWt-8Q5rQ4k0A-1
X-Mimecast-MFC-AGG-ID: 7z-qeHTVOKWt-8Q5rQ4k0A_1756293324
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B0CF1800340; Wed, 27 Aug 2025 11:15:24 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.195])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C3BB30001A5; Wed, 27 Aug 2025 11:15:16 +0000 (UTC)
Date: Wed, 27 Aug 2025 12:15:12 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Magnus Kulke <magnus.kulke@microsoft.com>,
 Cornelia Huck <cohuck@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Thomas Huth <thuth@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Cameron Esfahani <dirty@apple.com>, Wei Liu <wei.liu@kernel.org>,
 Wei Liu <liuwe@microsoft.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 09/26] accel/mshv: Initialize VM partition
Message-ID: <aK7owFKKQh8y0_m2@redhat.com>
References: <20250807143951.1154713-1-magnuskulke@linux.microsoft.com>
 <20250807143951.1154713-10-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250807143951.1154713-10-magnuskulke@linux.microsoft.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Aug 07, 2025 at 04:39:34PM +0200, Magnus Kulke wrote:
> Create the MSHV virtual machine by opening a partition and issuing
> the necessary ioctl to initialize it. This sets up the basic VM
> structure and initial configuration used by MSHV to manage guest state.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
>  accel/mshv/irq.c             | 397 +++++++++++++++++++++++++++++++++++
>  accel/mshv/mem.c             | 129 +++++++++++-
>  accel/mshv/meson.build       |   1 +
>  accel/mshv/mshv-all.c        | 325 ++++++++++++++++++++++++++++
>  accel/mshv/trace-events      |  23 ++
>  accel/mshv/trace.h           |  14 ++
>  hw/intc/apic.c               |   8 +
>  include/system/mshv.h        |  38 +++-
>  meson.build                  |   1 +
>  target/i386/mshv/meson.build |   1 +
>  target/i386/mshv/mshv-cpu.c  |  71 +++++++
>  11 files changed, 1001 insertions(+), 7 deletions(-)
>  create mode 100644 accel/mshv/irq.c
>  create mode 100644 accel/mshv/trace-events
>  create mode 100644 accel/mshv/trace.h
>  create mode 100644 target/i386/mshv/mshv-cpu.c
> 
> diff --git a/accel/mshv/irq.c b/accel/mshv/irq.c

> diff --git a/accel/mshv/trace-events b/accel/mshv/trace-events
> new file mode 100644
> index 0000000000..5ea5e74722
> --- /dev/null
> +++ b/accel/mshv/trace-events
> @@ -0,0 +1,23 @@
> +# See docs/devel/tracing.rst for syntax documentation.

This will need the SPDX-License-Identifier tag too these
days.

> diff --git a/accel/mshv/trace.h b/accel/mshv/trace.h
> new file mode 100644
> index 0000000000..0dca48f917
> --- /dev/null
> +++ b/accel/mshv/trace.h
> @@ -0,0 +1,14 @@
> +/*
> + * QEMU MSHV support
> + *
> + * Copyright Microsoft, Corp. 2025
> + *
> + * Authors:
> + *  Ziqiao Zhou       <ziqiaozhou@microsoft.com>
> + *  Magnus Kulke      <magnuskulke@microsoft.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + */
> +
> +#include "trace/trace-accel_mshv.h"


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


