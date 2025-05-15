Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1140C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 08:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFUEO-0007wY-3O; Thu, 15 May 2025 04:46:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uFUEE-0007v9-Mx
 for qemu-devel@nongnu.org; Thu, 15 May 2025 04:46:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uFUEA-0005gV-G1
 for qemu-devel@nongnu.org; Thu, 15 May 2025 04:46:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747298764;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NG04K+EEBGj2xR0ybRzwbJNytW/HzSe3gp8cxwUNDrY=;
 b=aZAFczWPbABLhoc6vyvcPGWEoHkKIlCP8kDwUTNPncOb3NsOcJbPzCY1Vq4shotSx1hixy
 OuuCyjj30/JCH80ecpCpt0DcC8GgYs3jP4YeRpTujbBg3GMzChvYwuurKLSDr5Xgi+hZjg
 CRiBEiKG3HLZivQX/7T3zxydIn5TzrQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-3tyquzIfMLuB1hqJilvvaQ-1; Thu,
 15 May 2025 04:46:00 -0400
X-MC-Unique: 3tyquzIfMLuB1hqJilvvaQ-1
X-Mimecast-MFC-AGG-ID: 3tyquzIfMLuB1hqJilvvaQ_1747298759
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0B2481800875; Thu, 15 May 2025 08:45:59 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.135])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E88121956094; Thu, 15 May 2025 08:45:55 +0000 (UTC)
Date: Thu, 15 May 2025 09:45:52 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 peter.maydell@linaro.org, Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 01/12] qapi: expose rtc-reset-reinjection command
 unconditionally
Message-ID: <aCWpn-ZzyygxT-2F@redhat.com>
References: <20250514234108.3746675-1-pierrick.bouvier@linaro.org>
 <20250514234108.3746675-2-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250514234108.3746675-2-pierrick.bouvier@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, May 14, 2025 at 04:40:57PM -0700, Pierrick Bouvier wrote:
> From: Daniel P. Berrangé <berrange@redhat.com>
> 
> This removes the TARGET_I386 condition from the rtc-reset-reinjection
> command. This requires providing a QMP command stub for non-i386 target.
> This in turn requires moving the command out of misc-target.json, since
> that will trigger symbol poisoning errors when built from target
> independent code.
> 
> Rather than putting the command into misc.json, it is proposed to create
> misc-$TARGET.json files to hold commands whose impl is conceptually
> only applicable to a single target. This gives an obvious docs hint to
> consumers that the command is only useful in relation a specific target,
> while misc.json is for commands applicable to 2 or more targets.
> 
> The current impl of qmp_rtc_reset_reinject() is a no-op if the i386
> RTC is disabled in Kconfig, or if the running machine type lack any
> RTC device. Thus the stub impl for non-i386 targets retains this
> no-op behaviour, instead of reporting a Error which is the more usual
> choice for commands invoked against unsupported configurations.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  qapi/misc-i386.json      | 24 ++++++++++++++++++++++++
>  qapi/misc-target.json    | 17 -----------------
>  qapi/qapi-schema.json    |  1 +
>  hw/i386/monitor.c        |  2 +-
>  stubs/monitor-i386-rtc.c | 14 ++++++++++++++
>  qapi/meson.build         |  1 +
>  stubs/meson.build        |  1 +
>  7 files changed, 42 insertions(+), 18 deletions(-)
>  create mode 100644 qapi/misc-i386.json
>  create mode 100644 stubs/monitor-i386-rtc.c

> diff --git a/stubs/monitor-i386-rtc.c b/stubs/monitor-i386-rtc.c
> new file mode 100644
> index 00000000000..e78757b24f2
> --- /dev/null
> +++ b/stubs/monitor-i386-rtc.c
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qapi/qapi-commands-misc-i386.h"
> +
> +void qmp_rtc_reset_reinjection(Error **errp)
> +{
> +    /*
> +     * Use of this command is only applicable for x86 machines with an RTC,
> +     * and on other machines will silently return without performing any
> +     * action.
> +     */
> +}

Based on Markus' feedback, I think we need to report an error here
rather than silently ignore the code.

The existing real impl of this method can also benefit from removing
the assert, but that's not in scope of this series


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


