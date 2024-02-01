Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28392C48286
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 05:23:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVPXJ-0005J2-Bq; Thu, 01 Feb 2024 00:22:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVPXE-0005IH-Sd
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 00:22:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVPXD-0005Cb-CD
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 00:22:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706764965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P2UEcZQaDKZgueRUgtBOQY3mFpZfp/wN79FiS6ZU8EA=;
 b=KpnZRyUaBsGYFdmElkLzyB75lZWSGnc55BYYDvIjccb8nNU9I9oE9CzGg09OHutGC2kU5R
 vJVrr08ZnZprPIE1w1sQXGit70vIejnfmRRA/cPhbUX5I/DHIfRCWQfLuzWLJr17BRdiur
 WfzGhGkmjwE+hZwZSaTauc8nxlk4L6M=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-UjywsCBpOYGbjhSVBeMuGg-1; Thu, 01 Feb 2024 00:22:44 -0500
X-MC-Unique: UjywsCBpOYGbjhSVBeMuGg-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3be75cab163so125295b6e.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 21:22:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706764963; x=1707369763;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P2UEcZQaDKZgueRUgtBOQY3mFpZfp/wN79FiS6ZU8EA=;
 b=rUwEMr1JIQT6gC0vIeRHLjEwb8a1dF1xos8Oi9b1Wzya5ycjkFbzfGLJP/uNU/MfIU
 FaFWgyg9svUDxW5SXqdvCb/vTG378/jhgpTF5VHWvWnRCbGGvGZA5Ysw+Gck1DLYcvIE
 BWbmuj8tw7CeQ+KO0SEBfyl+ymUN59iJHFDSxib8CCVfA1F/tFo+KvF53yOS0zTkdXlH
 tY+Y+3cLQozin0LHUKsEXVtlxfq+urg533GaPqGpnaDbj4ERvFIZpdaw+ZOf3OVKHeIF
 NiXrsQRvBZJOWRyjmHQ3V9iKxYZtGUcvKYDjD2mKhoGs76seu9StiOAKygSSJxnLJOwO
 xH5g==
X-Gm-Message-State: AOJu0YwE3jUkP6oy4eJuGZYgX8jmwY5wKpW8xapRkESErpK42dL2g9jO
 a7EKb1BszplyKXZuRJ9lnHcr6tfR1P1bStikCeXLZ/H+BllvsF142Awr/rJYmlDKobEl18IlzP2
 ABf4/RESlSAd5efjfrPJI1kkWDN9PO5kfbMzDrFTBItiLwmbB+KO6
X-Received: by 2002:a05:6870:b4ac:b0:218:57b9:ad8f with SMTP id
 y44-20020a056870b4ac00b0021857b9ad8fmr1440954oap.5.1706764963566; 
 Wed, 31 Jan 2024 21:22:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9iw0FcTh6pr45WpPLC40fQh0fiOCFj064KTONi+o5J30npIpRigOpc1CpNgk/afE0bNw7bQ==
X-Received: by 2002:a05:6870:b4ac:b0:218:57b9:ad8f with SMTP id
 y44-20020a056870b4ac00b0021857b9ad8fmr1440949oap.5.1706764963339; 
 Wed, 31 Jan 2024 21:22:43 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWgtwgbZWNWyQbiAQ33s1qlkSuk3cOa8opcOzLAMrydgWSjNtTeLctQs8NCksvFufWvKp5lc+yasDEPFJHNSEfTLssbWKKuVbwg/l0M9sXB7nwlMXRCzPV+lUpSZycrMdT3TiMqe+O8plOOJdaRuqTUvUV6Erzt5mV7GUgeMFlQR1zxq2s4Us4ODAP/CzfbSEDxpMxO5KzyYaYpJpRkLWJbDjybsEWZ/WreywUq
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 p19-20020a631e53000000b005d3bae243bbsm11565057pgm.4.2024.01.31.21.22.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 21:22:42 -0800 (PST)
Date: Thu, 1 Feb 2024 13:22:33 +0800
From: Peter Xu <peterx@redhat.com>
To: Hao Xiang <hao.xiang@bytedance.com>
Cc: farosas@suse.de, peter.maydell@linaro.org, marcandre.lureau@redhat.com,
 bryan.zhang@bytedance.com, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v3 03/20] multifd: Zero pages transmission
Message-ID: <ZbsqmZj-eHlSkXVY@x1n>
References: <20240104004452.324068-1-hao.xiang@bytedance.com>
 <20240104004452.324068-4-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240104004452.324068-4-hao.xiang@bytedance.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Jan 04, 2024 at 12:44:35AM +0000, Hao Xiang wrote:
> From: Juan Quintela <quintela@redhat.com>
> 
> This implements the zero page dection and handling.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/multifd.c | 41 +++++++++++++++++++++++++++++++++++++++--
>  migration/multifd.h |  5 +++++
>  2 files changed, 44 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 5a1f50c7e8..756673029d 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -11,6 +11,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/cutils.h"
>  #include "qemu/rcu.h"
>  #include "exec/target_page.h"
>  #include "sysemu/sysemu.h"
> @@ -279,6 +280,12 @@ static void multifd_send_fill_packet(MultiFDSendParams *p)
>  
>          packet->offset[i] = cpu_to_be64(temp);
>      }
> +    for (i = 0; i < p->zero_num; i++) {
> +        /* there are architectures where ram_addr_t is 32 bit */
> +        uint64_t temp = p->zero[i];
> +
> +        packet->offset[p->normal_num + i] = cpu_to_be64(temp);
> +    }
>  }

I think changes like this needs to be moved into the previous patch.  I got
quite confused when reading previous one and only understood what happens
until now.  Fabiano, if you're going to pick these ones out and post
separately, please also consider.  Perhaps squashing them together?

-- 
Peter Xu


