Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 696DBCAC5B1
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 10:15:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v102i-0007xq-KO; Tue, 23 Sep 2025 06:14:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v102f-0007wl-U6
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:14:38 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v102a-0002LN-RV
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:14:37 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1621:0:640:12d9:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id D80E38851F;
 Tue, 23 Sep 2025 13:14:25 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b38::1:12] (unknown
 [2a02:6bf:8080:b38::1:12])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id NEUjuB0Gl8c0-9cRBDPUp; Tue, 23 Sep 2025 13:14:25 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1758622465;
 bh=xbqZ33OMicFc58SmT8yXDDQdxSYpnD87LVbZjSdvPtI=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=yXZb2IGsjUDGuNOB5XJ07Yh+zpOYcc52vvM9n6vfwiITz+m32XFoYxC+uu5rXZ0+G
 kTyf0OEzoK5V4tu8s5HmI++AXmL7bocQeMWDp7/DK5F0Is+gwJ3S0gKhrA4W4QpBI9
 twP2ohgsKBq+Lufy3A/lvv/chGONn/5JrRfWgWJk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <1a10e0d3-17fc-4ec9-aa4c-cdfed13988e6@yandex-team.ru>
Date: Tue, 23 Sep 2025 13:14:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/13] hw/remote/vfio-user: Clean up error reporting
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: odaki@rsg.ci.i.u-tokyo.ac.jp, marcandre.lureau@redhat.com,
 berrange@redhat.com, richard.henderson@linaro.org,
 Jagannathan Raman <jag.raman@oracle.com>
References: <20250923091000.3180122-1-armbru@redhat.com>
 <20250923091000.3180122-6-armbru@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20250923091000.3180122-6-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 23.09.25 12:09, Markus Armbruster wrote:
> VFU_OBJECT_ERROR() reports the error with error_setg(&error_abort,
> ...) when auto-shutdown is enabled, else with error_report().
> 
> Issues:
> 
> 1. The error is serious enough to warrant aborting the process when
> auto-shutdown is enabled, yet harmless enough to permit carrying on
> when it's disabled.  This makes no sense to me.
> 
> 2. Like assert(), &error_abort is strictly for programming errors.  Is
> this one?

Brief look at the code make me think that, no it isn't.

>  Or should we exit(1) instead?
> 
> 3. qapi/error.h advises "don't error_setg(&error_abort, ...), use
> assert()."
> 
> This patch addresses just 3.
> 
> Cc: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   hw/remote/vfio-user-obj.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
> index ea6165ebdc..eb96982a3a 100644
> --- a/hw/remote/vfio-user-obj.c
> +++ b/hw/remote/vfio-user-obj.c
> @@ -75,12 +75,9 @@ OBJECT_DECLARE_TYPE(VfuObject, VfuObjectClass, VFU_OBJECT)
>    */
>   #define VFU_OBJECT_ERROR(o, fmt, ...)                                     \
>       {                                                                     \
> -        if (vfu_object_auto_shutdown()) {                                 \
> -            error_setg(&error_abort, (fmt), ## __VA_ARGS__);              \
> -        } else {                                                          \
> -            error_report((fmt), ## __VA_ARGS__);                          \
> -        }                                                                 \
> -    }                                                                     \
> +        error_report((fmt), ## __VA_ARGS__);                              \
> +        assert(!vfu_object_auto_shutdown());                              \

Probably, it's only my feeling, but for me, assert() is really strictly bound
to programming errors, more than abort(). Using abort() for errors which are
not programming, but we can't handle them looks less confusing, i.e.

if (vfu_object_auto_shutdown()) {
     abort();
}

Not really matter. Anyway:

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

> +    }
>   
>   struct VfuObjectClass {
>       ObjectClass parent_class;


-- 
Best regards,
Vladimir

