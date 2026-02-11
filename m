Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D23ECD6E0
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 19:08:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqFYT-00033z-LZ; Wed, 11 Feb 2026 14:07:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vqFYQ-00033c-Qs
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 14:07:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vqFYO-0001Bz-HA
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 14:07:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770836829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+nW2gV/AiYW+4xS/a1j48d1hVTxVcelBhRPcdCK5Tow=;
 b=h13InFbSRl/G6CzXBr5r5raCa8KuOvGMcfdJMeUkKslb/zZcArEE3vvl0nd4D/SYvZ/D87
 /kiLXrvszZkNqEUynKKePLS2ghFs0J6GeTIPx1RLr2IXbjo3NYqTbKVZtYIobYzE3fge8u
 dhO+TGZr2EFc7qNjngJZMneuK6mpfGA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-1jEgAiJ_PtqIe3hD6Ft0gw-1; Wed, 11 Feb 2026 14:07:07 -0500
X-MC-Unique: 1jEgAiJ_PtqIe3hD6Ft0gw-1
X-Mimecast-MFC-AGG-ID: 1jEgAiJ_PtqIe3hD6Ft0gw_1770836827
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-894709fbae5so240741056d6.2
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 11:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770836827; x=1771441627; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+nW2gV/AiYW+4xS/a1j48d1hVTxVcelBhRPcdCK5Tow=;
 b=cYgaY43ACwbhiUKyh+wbMGxzhBKkli5xWOWasePbvmYlzSArzKFBz2RyFItssXanyq
 LedBOt7bI5i9xkNWkCdVotvyneoxBxnPeXIwY6PRT29dlN5AnhQ4kdk/76kMylMWf2Bz
 +2tNHFPA5Nfs2JU5waTni4wegmTTWvG8X2pnERxZ/g7CR529YqfwxrVHMpan68R+HHbi
 h0Ic7tQQmYd3IfDwLtFD3oi8SlXBESnyaKKqKx35AalYnnOEpw0BQIn41ZPkJXeFB/nA
 OTNu66sF9R7RW1XlIuamNoDSO+ppIkG4W8bEIRKsCOw27XVtOTTKJlk+r8/gZeG7QCYS
 826A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770836827; x=1771441627;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+nW2gV/AiYW+4xS/a1j48d1hVTxVcelBhRPcdCK5Tow=;
 b=R6SMldJwTaM+e4NNek4pFMkH9k5Em8H7GdWjTGfuwSpc5PjJ8QNBKWASqsE2ulEa9k
 8gZVxPzM+7JPLOGS+wMz4MGkkl8ZE0Fty9rAEjPEdR/IU/7ibXI4v85JdU2T2G53FceM
 TZxJ4gTAFB0ArjVE/y+EDkUEE7a0DJHYap/4wIOCCCtXuxcRSpXqzadhgEUibS+P5xo3
 H4NhZ50FZ3SeUxve1sCWTfpMM/Yr2KhHKE7GKMBib4UHMiO0vyex5KklSxqx90HAudu6
 tDAQbKU/7g9tJAb8dDJLzoiONLJesDNEAkqo7ZSLjnqod3raeRQm3vAKXeritw8U1eBn
 zo0w==
X-Gm-Message-State: AOJu0YzaN/QdtgFts81nLfWz5bsTh6GZT2XFV+dCiEMToreve+8cPl71
 /4X9QfeTh0+acL13MJCkzkvu+yY9qfapRSiSd6vmE6M+HLUrHKzuVaRex+y5Va5mn6IBQP6HfLN
 hdo13V+Qy9oV2WIlJIJHSUVNyXZrtCT+WsJZiEVhF38LDI4PPie34lKH8
X-Gm-Gg: AZuq6aLDq7mRdtG5CQaVXBR0aFZTV7L1hsFdvWRmFetCMzq6zEYh9lNZkqeu7xhYMRt
 RUw65MVnICRuNQl8saj/490Xuif9MAY5fJ06bAwqrH9xkUKQDYQFRnrezbUPKFeCiGfjEl+4VfZ
 hu3NpF8CXkBEOMbRc9h8WWGsLpLttJ9g53/fDUO3gujnghgjI0Tz1GyWORmPIq645zGJhsm0WkD
 vOj6LCUsS/FgIKQDUF8U3gxvb1llxrriOFkaz/EnGw8k7gE+9IUakUO+VDCQPBoxCTpyyxiA3kk
 l/V7YUhtQ+YEJGznPad3KuyGOrMTMVzG75faMr+LMm+JZCFjhC7cVzJRi+yT7YuMyBACiqbp9ED
 KnsCtuKwobLxHfg==
X-Received: by 2002:ad4:5c86:0:b0:894:4689:7283 with SMTP id
 6a1803df08f44-89727a92569mr7902246d6.45.1770836826577; 
 Wed, 11 Feb 2026 11:07:06 -0800 (PST)
X-Received: by 2002:ad4:5c86:0:b0:894:4689:7283 with SMTP id
 6a1803df08f44-89727a92569mr7901506d6.45.1770836825941; 
 Wed, 11 Feb 2026 11:07:05 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8971cc7ff1csm20858826d6.3.2026.02.11.11.07.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 11:07:05 -0800 (PST)
Date: Wed, 11 Feb 2026 14:06:54 -0500
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Mark Kanda <mark.kanda@oracle.com>, Ben Chaney <bchaney@akamai.com>
Subject: Re: [PATCH] migration/cpr: Include vfio-cpr.h instead of vfio-device.h
Message-ID: <aYzTTrgqWTlY76m_@x1.local>
References: <20260211171532.1556719-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260211171532.1556719-1-clg@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Wed, Feb 11, 2026 at 06:15:32PM +0100, Cédric Le Goater wrote:
> The file migration/cpr.c uses vmstate_cpr_vfio_devices which is
> declared in hw/vfio/vfio-cpr.h, not in hw/vfio/vfio-device.h.
> 
> Replace the include with the correct header file to avoid pulling in
> unnecessary VFIO device declarations.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>  migration/cpr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/migration/cpr.c b/migration/cpr.c
> index adee2a919a364244867ef190fdf29bd1fe7e20e2..a0b37007f55d6dac32bd6220ffe65d32c4e6b52e 100644
> --- a/migration/cpr.c
> +++ b/migration/cpr.c
> @@ -9,7 +9,7 @@
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
> -#include "hw/vfio/vfio-device.h"
> +#include "hw/vfio/vfio-cpr.h"
>  #include "migration/cpr.h"
>  #include "migration/misc.h"
>  #include "migration/options.h"
> -- 
> 2.53.0
> 

This should be better as a standalone change, thanks.

Reviewed-by: Peter Xu <peterx@redhat.com>

Some thoughts beyond this patch alone.

When looking at this, it's a layer violation.  Logically migration/cpr.c
shouldn't include a vfio header, otherwise it means when new devices added
to support cpr then migration needs to include headers to every single of
these devices..

Logically it should be the other way round where migration/cpr.c should
provide a helper allowing devices to opt-in for cpr-states to register
instead.

Now it's also awkward that vmstate_cpr_state always have a subsection
called vmstate_cpr_vfio_devices.. it means we will migrate this subsection
even if there's no vfio device..  that's also another point that I think it
should be done the other way round..

I do not know whether we must persist CPR ABI now.. if we need, we can't
change this anymore without a machine type compat entry (as we will expect
vmstate_cpr_vfio_devices to come from an older binary that does a cpr
migration).  But that'll be sad..

Thanks,

-- 
Peter Xu


