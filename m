Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FEF9CD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 19:10:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPmIy-0002gU-NY; Wed, 20 May 2026 15:10:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPmIx-0002g4-7d
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:10:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPmIv-00066O-0z
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:10:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779304203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gNMEOkBvDZzya4Iu4MTr/RjUqoIcIAHteT1dXC+w29Q=;
 b=hw8PvmmJbwr7wf4DzNPgjcq1mu5f4DCywmmfrhBqGxyzFr5XOuI+XRK6mxBjy6/ehOfr41
 MxNvrc2ml2dP5/bp2zAi8GS64lSgDXvG6PWjLZCzvv7SzutCia2pEwJCehGDqSfAP0PoHf
 orjhxhGu6LJeBO8UmZ7VkdTT9o02LF0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-SFoiDeUgNaWSgxy6XGAj7Q-1; Wed, 20 May 2026 15:10:01 -0400
X-MC-Unique: SFoiDeUgNaWSgxy6XGAj7Q-1
X-Mimecast-MFC-AGG-ID: SFoiDeUgNaWSgxy6XGAj7Q_1779304201
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8b5f089a5c3so158723836d6.3
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 12:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779304201; x=1779909001; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gNMEOkBvDZzya4Iu4MTr/RjUqoIcIAHteT1dXC+w29Q=;
 b=WEtXS+COME/rPBGicN3xzDm4zvNd60tCP2lW8uAWMTHPfTnNa0oXbVlM3Dktdtv5FW
 12vc+9xGNsLZiPEyKrDk8PkDdPgRSJfCodt69DYxrmRfC+G5YZ4fokn6BalzPVJ1KJOt
 bvpTL6WQb8qegh7jFUVSVy4gR6e/jIIONK2yFOhRwWRY2aB/se7eWVNqrdrWxmRZ5Tkd
 EtmMMR2o078PRfjUR7JqfH0sIwtFrA7iOzpVjGFksu1QgCl41IXVs8OFb1aJ+FZB1U+z
 +8n+SYP9hVWmNqLn73Pco5z/jRCBuHKhVU9IBY4g081E/5rwQQ6uYxLxn+j2pTsBB02Z
 GEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779304201; x=1779909001;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gNMEOkBvDZzya4Iu4MTr/RjUqoIcIAHteT1dXC+w29Q=;
 b=SPVTfWNu0DIuF1f/OFV7Z2+WdhVonVktNrCB/3gv7kgVPdCKaSyi5S4UTzIMXJ+y1n
 yvEPmDDgSm2oNmZonSf1w4YzaNzywZ+I1bs4YiKvVBcV+68/sMfNEWVB3QKUGql+x4EQ
 H8BUODUqVWWy89d7Wlm47jHzQ9wgaGDkxdCpUwA8qVsmt8Jc4MYizY/KThrQFYDeNfnN
 0KhLaeJT879RRlWVkV/gj79905EG2nPIFTDqEI8GAPdpdlZOZvbRqqY3QzVScjnbcE8S
 e/WW//SuUOREW07VteWvGwa/MWq2X5qwI1UsEZtJDR25WSxxdMVJw5gH5wFgYzKmYMo1
 5ewQ==
X-Gm-Message-State: AOJu0YypHW7w4eXUQVUbKJulF/9eoGm78DiTpdOpc97fGdvr0IMaujXH
 BO5gosx9GpCaHPhm6rGYgnuRXAHU85UqwPqNijWFILbCoDeEOJ3b0/z5sfGHaBAfDdj3NBnI9eA
 wuFDgk4Z+KfJT/Qd2/fRMD4clAPXREB01QJWlbspZ3Lo7M/+q8inNwcZ2
X-Gm-Gg: Acq92OFY2ZtbH2zy6YsJm3OT+tpC0jEZUzI/fDeTZeNxyqY89jX4GsVmTW5zBWrOHfT
 gVHJAsl3ShRhn8acA5TWQeiyl2RYh/BHlRvzOD+bNTbN/3SvAGG4z9LuWDABK3QnP8YlYPFnv+R
 p/wBJ8X2I0syiRzzf4vF5f2MFHP2FUo7PX4stNTKDsPxAL4bdWPJAlFUbpqrrgSNEhOsivNzYtp
 Mnp35zM3ctuDqJvQmqrsRD+TuP4QV1rsmcEfebCeJM0MINhiA1UJtg4ygklw/rj2WcYwcGgyM4O
 tZw77jSrCTPXNQRUDp8gvUvpt4332Gx84x1UObSF9xA13RaKiRM1RlfrolLiMDmhFCbGGeWp0YH
 s98KubW/TDAoha4cytO6qoPGXmr73Ow4puWISlGGbKEHqhkc=
X-Received: by 2002:a05:6214:4c8f:b0:8ac:a9f1:6cf4 with SMTP id
 6a1803df08f44-8ca0f6ac24amr352505966d6.37.1779304200731; 
 Wed, 20 May 2026 12:10:00 -0700 (PDT)
X-Received: by 2002:a05:6214:4c8f:b0:8ac:a9f1:6cf4 with SMTP id
 6a1803df08f44-8ca0f6ac24amr352505296d6.37.1779304200132; 
 Wed, 20 May 2026 12:10:00 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ca361bcb15sm137267376d6.47.2026.05.20.12.09.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 12:09:59 -0700 (PDT)
Date: Wed, 20 May 2026 15:09:57 -0400
From: Peter Xu <peterx@redhat.com>
To: infra.ai.cloud@bitdeer.com
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Hyman Huang <yong.huang@bitdeer.com>
Subject: Re: [PATCH] MAINTAINERS: Update email of Yong Huang
Message-ID: <ag4HBdzJXGdKgy50@x1.local>
References: <b3bd81c3d9f425bb750a76d7bad7ad0284e55123.1779178180.git.infra.ai.cloud@bitdeer.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b3bd81c3d9f425bb750a76d7bad7ad0284e55123.1779178180.git.infra.ai.cloud@bitdeer.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi, Yong,

On Tue, May 19, 2026 at 04:18:12PM +0800, infra.ai.cloud@bitdeer.com wrote:
> From: Hyman Huang <yong.huang@bitdeer.com>

Just to mention you still have this different address ^^^.

Do you want to stick with infra.ai.cloud@bitdeer.com?  What is the best
address to reach you?

Thanks,

> 
> I left SmartX two weeks ago. Update my email to stay reachable.
> 
> Signed-off-by: Hyman Huang <infra.ai.cloud@bitdeer.com>
> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b75f3222f2..1308ee5a0b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3784,7 +3784,7 @@ F: migration/rdma*
>  F: scripts/rdma-migration-helper.sh
>  
>  Migration dirty limit and dirty page rate
> -M: Hyman Huang <yong.huang@smartx.com>
> +M: Hyman Huang <infra.ai.cloud@biitdeer.com>
>  S: Maintained
>  F: system/dirtylimit.c
>  F: include/system/dirtylimit.h
> @@ -3794,7 +3794,7 @@ F: include/system/dirtyrate.h
>  F: docs/devel/migration/dirty-limit.rst
>  
>  Detached LUKS header
> -M: Hyman Huang <yong.huang@smartx.com>
> +M: Hyman Huang <infra.ai.cloud@biitdeer.com>
>  S: Maintained
>  F: tests/qemu-iotests/tests/luks-detached-header
>  F: docs/devel/luks-detached-header.rst
> -- 
> 2.43.0
> 

-- 
Peter Xu


