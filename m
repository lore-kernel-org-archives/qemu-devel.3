Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 705EBC87FCF
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 19:23:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uk6CS-0007KT-21; Thu, 07 Aug 2025 15:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uk6CL-0007JC-Tf
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 15:22:47 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uk6C5-0004Dd-R5
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 15:22:45 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 5A10143D38;
 Thu,  7 Aug 2025 19:22:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7EDC4CEEB;
 Thu,  7 Aug 2025 19:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1754594543;
 bh=SU0lO2oZwrJjfYsB5keclC7ksml1gF5bqMhvLqoo7iU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KxqIBjIwhVZqCQ7ybR4KY2DxLo2eXGByR5QXjZhKBmsnJfhSV6FCDf3uZLdn/s0KQ
 0zAAYCLbUeHNsfbousYLQ6JC2sVsT8eQEa7n2O6968celxxaY3kb69Tp4psauJq4rw
 yJM6axGqAW0LHwyyHBFLE9lv8wAHIPhqZF5VxDK/SljwsHwp7Tu0M2IDM3iJVzwZcW
 u7RDJF14ypQ4nUQnrrMSfZot7aBgcbMxJqJbYZ/dAI2Y1gI109XMguWI1qEilsQVpg
 Hq7qxs9SVD2ioF9/EizL85eoZsJEfSavRpBKeOW06j29XkK86+OdOGmRP9sTO2XkYr
 SqqlvwIh2LZZQ==
Date: Thu, 7 Aug 2025 19:22:21 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>, prapal@linux.microsoft.com
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Magnus Kulke <magnus.kulke@microsoft.com>,
 Cornelia Huck <cohuck@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Thomas Huth <thuth@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Cameron Esfahani <dirty@apple.com>, Wei Liu <wei.liu@kernel.org>,
 Wei Liu <liuwe@microsoft.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 26/26] qapi/accel: Allow to query mshv capabilities
Message-ID: <aJT87brzXBy89lfV@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250807143951.1154713-1-magnuskulke@linux.microsoft.com>
 <20250807143951.1154713-27-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807143951.1154713-27-magnuskulke@linux.microsoft.com>
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=wei.liu@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, Aug 07, 2025 at 04:39:51PM +0200, Magnus Kulke wrote:
> From: Praveen K Paladugu <prapal@microsoft.com>
> 
> Allow to query mshv capabilities via query-mshv QMP command.
> 
> Signed-off-by: Praveen K Paladugu <prapal@linux.microsoft.com>
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
>  hw/core/machine-qmp-cmds.c | 14 ++++++++++++++
>  qapi/accelerator.json      | 29 +++++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+)
> 
> diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
> index 6aca1a626e..024ddb8d2d 100644
> --- a/hw/core/machine-qmp-cmds.c
> +++ b/hw/core/machine-qmp-cmds.c
> @@ -28,6 +28,20 @@
>  #include "system/runstate.h"
>  #include "system/system.h"
>  #include "hw/s390x/storage-keys.h"
> +#include <sys/stat.h>
> +
> +/*
> + * QMP query for MSHV
> + */
> +MshvInfo *qmp_query_mshv(Error **errp)
> +{
> +    MshvInfo *info = g_malloc0(sizeof(*info));
> +    struct stat st;
> +
> +    info->present = accel_find("mshv");
> +    info->enabled = (stat("/dev/mshv", &st) == 0);

I don't think this is the right way to check if MSHV is _enabled_. The
device node being around doesn't necessarily mean that QEMU is using it.

You can refer to kvm_enabled() to see how it is implemented.

Some functions that are of interest:
   do_configure_accelerator
   accel_init_machine

Thanks,
Wei

