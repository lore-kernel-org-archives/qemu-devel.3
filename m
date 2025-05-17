Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73809C2D0CD
	for <qemu-devel@archiver.kernel.org>; Sat, 17 May 2025 08:22:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGCnd-0006LL-Gt; Sat, 17 May 2025 04:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uGCna-0006L6-6D
 for qemu-devel@nongnu.org; Sat, 17 May 2025 04:21:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uGCnY-0001TX-0f
 for qemu-devel@nongnu.org; Sat, 17 May 2025 04:21:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747470093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=beN+xvW+rKh3pfg5CAKr8R2buGhfG41fhwrbVJKl+3w=;
 b=DvXhATBhB44bPwsIgaiCF0nxsePUPmsPgHZ38e214ZmluwTrRBcRIoSLxVLd9GCA3U5X2j
 1D8ey/9g5EQqVwO+6AbKQbfWxPkmHfJn1LGqox0Xh8KCaGJKVEE8OZx95ctZhNTh42wQov
 F9b1RYHhy0XIMm/Z/zLiefH9ii8qC+Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-235-aW5K1FP-M0a8I3qigHaIXw-1; Sat,
 17 May 2025 04:21:31 -0400
X-MC-Unique: aW5K1FP-M0a8I3qigHaIXw-1
X-Mimecast-MFC-AGG-ID: aW5K1FP-M0a8I3qigHaIXw_1747470090
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C6A48195608C; Sat, 17 May 2025 08:21:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1463730075D5; Sat, 17 May 2025 08:21:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5EB3C21E6768; Sat, 17 May 2025 10:21:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Michael Roth
 <michael.roth@amd.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  berrange@redhat.com,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 01/12] qapi: expose rtc-reset-reinjection command
 unconditionally
In-Reply-To: <20250515172732.3992504-2-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Thu, 15 May 2025 10:27:21 -0700")
References: <20250515172732.3992504-1-pierrick.bouvier@linaro.org>
 <20250515172732.3992504-2-pierrick.bouvier@linaro.org>
Date: Sat, 17 May 2025 10:21:26 +0200
Message-ID: <87plg7myux.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
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
> RTC device.
>
> The stub impl for non-i386 targets retains this no-op behaviour.
> However, it is now reporting an Error mentioning this command is not
> available for current target.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

[...]

> diff --git a/stubs/monitor-i386-rtc.c b/stubs/monitor-i386-rtc.c
> new file mode 100644
> index 00000000000..d810f33efec
> --- /dev/null
> +++ b/stubs/monitor-i386-rtc.c
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qapi/qapi-commands-misc-i386.h"
> +
> +void qmp_rtc_reset_reinjection(Error **errp)
> +{
> +    error_setg(errp,
> +               "rtc-reset-injection is only available for x86 machines w=
ith RTC");
> +}

We get this stub exactly when the command did not exist before the
patch.  Thus, the command fails before and after, only error code and
message change, which is fine.

However, the error message feels brittle: it becomes misleading when we
implement the command for other targets.  Let's dumb it down to
something like "RTC interrupt reinjection backlog reset is not available
for this machine".

[...]


