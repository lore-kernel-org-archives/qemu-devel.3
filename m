Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2766D68BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 09:19:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWA9X-0002WL-Lh; Thu, 18 Dec 2025 04:18:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vWA9U-0002W9-Jm
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 04:18:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vWA9T-0005HC-2m
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 04:18:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766049505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=epJtLsu8TCXnSc0Kkcj7sH43/QN/yQBlXmzJonCvwA4=;
 b=dwie7w+pfO7MvW2XJp5ZMCsx59GB74/2uxS61RT1knpgXDuzBZbaAqRy0VxK8gEwFpQpzZ
 iKKMn6oBQmi+nZgXLjr7qULgCP2bTbcIH9JFbKdUsoHLwBR4T5ffENVBKT4P7+1wWvbwav
 68zgmTOabLNknN95NdH6nyXeqiNUSkk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-9_fldCfPMS-FG4gi2YHPSg-1; Thu,
 18 Dec 2025 04:18:21 -0500
X-MC-Unique: 9_fldCfPMS-FG4gi2YHPSg-1
X-Mimecast-MFC-AGG-ID: 9_fldCfPMS-FG4gi2YHPSg_1766049500
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D1DA18002F9; Thu, 18 Dec 2025 09:18:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D8D8180049F; Thu, 18 Dec 2025 09:18:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 264DF21E6A27; Thu, 18 Dec 2025 10:18:17 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: jonathan.cameron@huawei.com,  ira.weiny@intel.com,  alucerop@amd.com,
 a.manzanares@samsung.com,  dongjoo.seo1@samsung.com,  mst@redhat.com,
 marcel.apfelbaum@gmail.com,  linux-cxl@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 3/5] hw/cxl: Allow BI by default in Window restrictions
In-Reply-To: <20251103195209.1319917-4-dave@stgolabs.net> (Davidlohr Bueso's
 message of "Mon, 3 Nov 2025 11:52:07 -0800")
References: <20251103195209.1319917-1-dave@stgolabs.net>
 <20251103195209.1319917-4-dave@stgolabs.net>
Date: Thu, 18 Dec 2025 10:18:17 +0100
Message-ID: <87wm2ki1wm.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Davidlohr Bueso <dave@stgolabs.net> writes:

> Update the CFMW restrictions to also permit Back-Invalidate
> flows by default, which is aligned with the no-restrictions
> policy.
>
> While at it, document the 'restrictions=' option.

I'd split the patch.  Up to you.

> Tested-by: Dongjoo Seo <dongjoo.seo1@samsung.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  hw/cxl/cxl-host.c | 2 +-
>  qapi/machine.json | 3 ++-
>  qemu-options.hx   | 4 +++-
>  3 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> index e420b25176a6..ed0c76a31980 100644
> --- a/hw/cxl/cxl-host.c
> +++ b/hw/cxl/cxl-host.c
> @@ -64,7 +64,7 @@ static void cxl_fixed_memory_window_config(CXLFixedMemoryWindowOptions *object,
>      if (object->has_restrictions) {
>          fw->restrictions = object->restrictions;
>      } else {
> -        fw->restrictions = 0xf; /* No restrictions */
> +        fw->restrictions = 0x2f; /* No restrictions */
>      }
>  
>      fw->targets = g_malloc0_n(fw->num_targets, sizeof(*fw->targets));
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 225690d2986a..85e31432b038 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -555,7 +555,8 @@
>  #     BIT(2) - Volatile
>  #     BIT(3) - Persistent
>  #     BIT(4) - Fixed Device Config
> -#     Default is 0xF
> +#     BIT(5) - BI
> +#     Default is 0x2F
>  #
>  # @targets: Target root bridge IDs from -device ...,id=<ID> for each
>  #     root bridge.

This changes the default of @restrictions.  No problem since
@restrictions has not been in any release.  If it was, we'd have to
consider backward compatibility.

[...]


