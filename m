Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 280AACA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 11:41:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urEVV-00079H-3u; Wed, 27 Aug 2025 07:40:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1urEVP-00077M-0v
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 07:39:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1urEVF-0004SB-QN
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 07:39:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756294779;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=D4CuUGtTiOGNFpvN1w/zejklZa/sJvParZ0RrmWIIlc=;
 b=FOt6SrKX/4ffjxJSHPkOKBLA/eWdEQxVLKxAmfxLEv/xVyFMUxrmp1tgsGnkxJSRJMIlZv
 2uliQmLMSagk/6KTP2FICZs/Y6pODuSY7eSRoLriCYBWkSn9rH3kEV1wHPhlpDG1FQjc4o
 KfvyTxIDb8AGjYxDmm304xTBqKB33Rk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-241-yyCyV68BNzCja5PYV7N_1w-1; Wed,
 27 Aug 2025 07:39:36 -0400
X-MC-Unique: yyCyV68BNzCja5PYV7N_1w-1
X-Mimecast-MFC-AGG-ID: yyCyV68BNzCja5PYV7N_1w_1756294773
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 84B7C19560B2; Wed, 27 Aug 2025 11:39:32 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.195])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E175D1800447; Wed, 27 Aug 2025 11:39:24 +0000 (UTC)
Date: Wed, 27 Aug 2025 12:39:21 +0100
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
Subject: Re: [PATCH v3 26/26] qapi/accel: Allow to query mshv capabilities
Message-ID: <aK7uabGJaXnl1T4N@redhat.com>
References: <20250807143951.1154713-1-magnuskulke@linux.microsoft.com>
 <20250807143951.1154713-27-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250807143951.1154713-27-magnuskulke@linux.microsoft.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This does't have the right semantics

$ sudo touch /dev/mshv
$ ./scripts/qmp/qmp-shell-wrap ./build/qemu-system-x86_64 -display none -accel tcg
(QEMU) query-mshv
{"return": {"enabled": true, "present": true}}


It cannot be enabled, since I asked for 'tcg' as the accelerator

IIUC, it should be

  info->enabled = mshv_enabled();

to match what KVM does.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


