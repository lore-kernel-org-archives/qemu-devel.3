Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5520A10A1E68
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 11:27:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5isD-0005Wk-N6; Thu, 26 Mar 2026 07:27:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w5isC-0005WI-4m
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 07:27:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w5isA-0003B7-3c
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 07:27:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774524452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ohN2fiB4s0vef49xAcpsOH5E8zzlSnaOj89GorM+m0A=;
 b=C5MVWIIlwxGu9QNwt6Uyv9cmcgIhbisEoCPttb21jp9iEHUcBydh4X/nqjePp+T6lGu9bm
 goBMnQ4AO4q/IrYTs7wy0K/2P2QwN3XO3S8p3xmCvGhIYolJ3Hd21Diky/+a/TNHuQgv7O
 X/m+JEp/dn0ovXuRnKobDSYI6JhlkNE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-gGOy8PwAMTaKLWShAQysgQ-1; Thu,
 26 Mar 2026 07:27:29 -0400
X-MC-Unique: gGOy8PwAMTaKLWShAQysgQ-1
X-Mimecast-MFC-AGG-ID: gGOy8PwAMTaKLWShAQysgQ_1774524444
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 995381955DBB; Thu, 26 Mar 2026 11:27:22 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5195C1955D84; Thu, 26 Mar 2026 11:27:20 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [RFC v2 5/7] test/qtest: Add test for tpm crb chunking
From: marcandre.lureau@redhat.com
To: Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, marcandre.lureau@redhat.com, 
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>
In-Reply-To: <20260319135316.37412-6-armenon@redhat.com>
References: <20260319135316.37412-1-armenon@redhat.com>
 <20260319135316.37412-6-armenon@redhat.com>
Date: Thu, 26 Mar 2026 15:27:02 +0400
Message-Id: <177452442287.34609.2774813943061790610.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2248;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=H4EEjYNG84zMCVxAT3S68tqPtgv/tAS6+2QIwvCJeKE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpxRgJMVvIOT84PLzAPYb1DC5bW3XBVXEUuUx4B
 jLY7SdiZtOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCacUYCQAKCRDa6OEJdZac
 5T4VD/9qegjJ1uBToyJO8orkoWNr1ElKBYqA863yx62OnssIJiUJPLdv4fDy5g5z+sQLLMXiZqX
 modfo23aMhxM7aqyIjQPGfWRpF4ES+/ZeOMtYW+jytmIvHUbCIeUV89GHNgdlREdZtpF7sFBZm4
 GJ91051Ng9MhBhn1ljTRhCW5c+PL4atvIQ/gmAJXbBcBWuVOhG/JVvnHN7dVH3kHQEx8G6C2kI4
 hMExHS07fi5gfPnpth6Pb68DOfah+jOuYiKQzh1sWcEoWRWaCjcXeCcnM6uNvDZSfcL2ibBb0EC
 KD40NsLx/D1Dy/EBNCxwHfLlzArwE8a/moXqK3tGbsj/3WyjJvaNHf4YYgRcsiLL1wL/E/cy/MJ
 GAvLo9Pz9hLZBiPTWurI7samV+T+5Kthtk1DRsRHVdsL05bVvvkSRzxlyxe6Bl4WgjHjTWacaJB
 lF7YKMOMkn1HpigicGiUXQY8Gf6DU8zVzQ7TdXVNWojr7Qqq8kihyZntJxzlMWtzUejYbpq2IWZ
 MzB6vc/0m/jg6W+Ab/87DOyBlWg13DDlsDcgKFO3+zT5A0+HC6l9juUQKelNinogHhpcobCoMJd
 SjijvVIEfAGGG5rUPBzDTMk3kE6uVhVZ6q35KsAvUj7w+eb77oSTG4kxwWtao5yLlKXD8vF55Jw
 1oe7hZh8nfmQWrw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
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

On Thu, 19 Mar 2026 19:23:14 +0530, Arun Menon <armenon@redhat.com> wrote:

Hi

>
> diff --git a/tests/qtest/tpm-util.c b/tests/qtest/tpm-util.c
> index 2cb2dd47961..dfc1fd70b7f 100644
> --- a/tests/qtest/tpm-util.c
> +++ b/tests/qtest/tpm-util.c
> @@ -14,16 +14,42 @@
>  
>  #include "qemu/osdep.h"
>  #include <glib/gstdio.h>
> +#include "system/memory.h"

Use qemu/bswap.h instead

>  
>  #include "hw/acpi/tpm.h"
>  #include "libqtest.h"
>  #include "tpm-util.h"
>  #include "qobject/qdict.h"
>  
> +#define CRB_ADDR_START (TPM_CRB_ADDR_BASE + A_CRB_CTRL_START)
> +#define CRB_CTRL_STS (TPM_CRB_ADDR_BASE + A_CRB_CTRL_STS)
> +#define CRB_CTRL_CMD_SIZE (TPM_CRB_ADDR_BASE + A_CRB_CTRL_CMD_SIZE)

Shadows tpm.h macro. Use CRB_ADDR_CTRL_STS ?

> +
> +#define BIT_START_INVOKE  (1 << 0)

Similar (although in tpm_crb.c unit)

> [ ... skip 11 lines ... ]
> +            break;
> +        }
> +        if (g_get_monotonic_time() >= end_time) {
> +            break;
> +        }
> +    }

Consider adding a g_assert() here

> @@ -31,24 +57,74 @@ void tpm_util_crb_transfer(QTestState *s,
> [ ... skip 30 lines ... ]
> +
> +    qtest_writeb(s, TPM_CRB_ADDR_BASE + A_CRB_LOC_CTRL, 1);
> +
> +    for (size_t i = 0 ; i < req_size; i += chunk_size) {
> +        bool last_chunk = false;
> +        size_t current_chunk_size = chunk_size ;

Trailing whitespace before the semicolon.

> +
> +        if (i + chunk_size > req_size) {
> +            last_chunk = true;
> +            current_chunk_size = req_size - i;
>          }
> -        if (g_get_monotonic_time() >= end_time) {
> -            break;
> +
> +        qtest_memwrite(s, caddr, req + i, current_chunk_size);
> +
> +        if (last_chunk) {
> +            qtest_writel(s, CRB_ADDR_START , BIT_START_INVOKE);

Trailing whitespace before the comma.

Style: should be tpm_sts per QEMU naming conventions.
Style: declarations should be at the top of the function.
Same: declaration mixed with statements.

Style: should be tpm_sts per QEMU naming conventions.
Style: declarations should be at the top of the function.
Same: declaration mixed with statements.

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


