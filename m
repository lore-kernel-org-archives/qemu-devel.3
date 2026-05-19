Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0983CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 20:11:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPQn0-0003Jp-02; Tue, 19 May 2026 16:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPQme-0003EV-Fy
 for qemu-devel@nongnu.org; Tue, 19 May 2026 16:11:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPQmW-0001hG-0K
 for qemu-devel@nongnu.org; Tue, 19 May 2026 16:11:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779221468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G4qBTmLgAqfuOV1d6pxEGBsdbgdOeGbz4gZ6EkzU5Bc=;
 b=E9woXRPDdXK+odampbBl+wmAdjDwpkbmSbmbFbhOc+0ZqXwsBAUMmaryUrETQr6vEXtXMu
 79OUpmUM9LK+GmBt27SmKzQ6a20RtpNyNHytyCKT2I41HlqTUrVGKu/fTLYoOYq3W6cdkn
 T2dM0oeltyocyeHED+sFUSHr2YGE2H0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-AxTICGXtNcWTFKRpbLWs6g-1; Tue, 19 May 2026 16:11:07 -0400
X-MC-Unique: AxTICGXtNcWTFKRpbLWs6g-1
X-Mimecast-MFC-AGG-ID: AxTICGXtNcWTFKRpbLWs6g_1779221467
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50d812c898cso113935141cf.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 13:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779221467; x=1779826267; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=G4qBTmLgAqfuOV1d6pxEGBsdbgdOeGbz4gZ6EkzU5Bc=;
 b=j1sZuqg136e6+84ygPXmXcFb5qM8c1zgiVH96w+t+gSWW1GLJbA2qrRh3Axga8RVlf
 1W2oMS71Y4ai+skagi+yop2up4zXNQQHPWWO/MSgspbDUANNHqCTFqTbctCLXC0rtbu5
 XN+cdUNClRuDuThVcoym04zrVWtJAyOivJhw7NCG26A1lyAOjRACA4BdjonCe/2g/OnM
 1RMW1hgpDMgbXl1E1RLJt6+8pj8/JsIWMznY6+H+QPdQpgFli/0aZEabU6N+CA8ysIWI
 LHVEwIzEZu2i1RRalkAw0RWnkkMwmPfdxhedtE5dFLSNHNqCLGlg+xab524ZL8xgfbKo
 Cqmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779221467; x=1779826267;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G4qBTmLgAqfuOV1d6pxEGBsdbgdOeGbz4gZ6EkzU5Bc=;
 b=crKfEnYzuxD/L8s1j6saGql9e73e9K/eSU/d7coKbpstq0+/CwE2yxiAS+zE3WcaJ1
 6+J6vuj2eSK9Jww8auA5L+eBDqZbv7LxkzAL8vtzQvJQFxB2a1G3Mjg8R5rrhT6HQbhZ
 3WwV/SdStMbgeXV554dtBfR+PoMU150bWImSqVd+hE/6l09x5+c1VgjuQCAYUYE0rlPk
 cRMOgjXqeCcgqP+Rwz0z4OZ05pKBFx9K5canFvXFVk9gQug2g0/70hSlGmfT14uxuCSu
 Y7ZVqwAdmh2Bo31jWXWXWt05J7gntg0sKarBdzHYuKMv7Xlze3nV5x6+alNqjkohP5eX
 HdeA==
X-Gm-Message-State: AOJu0Yx17qrnYA2F4wOmbAHPxcB3BvD6D1FjRDTadk+u+/WwFiCTyQC6
 lJ3uhPZGYtMcCDCkqyyDtjAIdkOIFecBbT0nxcPo547yynPVcIoqkeL2MH/jUlxmjkTsIOS/YRJ
 xXNYIz+P3pGYDR9kj2LnnFr6aCk4ZFx9XfBuLhFU9Gy9sM1n5feXa2Gn/
X-Gm-Gg: Acq92OFFxA4lr3ZXiY65pxDV3NDkiNBtQpLivL4/5ZyijbmprnWNLMQ2TmHGcBYWRo4
 lY54b4mwWkvBrmEeWrQLoN1Y9rlEisg7yhOr6LX9Xm1V3FgsXYp0KHo5imNWoG5W6ZIha6ExpqB
 6SEZ0CDVwu5xRmtM2Z7CMK1XrVXhET5ImGQw4Lxf+WbEuzjC/spG7/qdObIspd6sqEkWNvBjNHU
 lYpnEZgWd6KAFYet+y8TF89THVxYPKDslZjQnd9/5TyDbzJo3eT2xHKu+YQ64fCjwJ9AEweu3bL
 wH1mtlvBPBveMQrr+feabbG9br1vBJN2iZBw0zpRtx5uXCZDxDJfQZD/6EH1KngpnO3G6g2dnTz
 qMiSe/fITK6DW/rZPup7/SS4fXlgzCs0t1oLYyfcMyzo0ghw=
X-Received: by 2002:a05:622a:4cc4:b0:50e:defb:9dca with SMTP id
 d75a77b69052e-5165a22c5d1mr297501841cf.45.1779221465721; 
 Tue, 19 May 2026 13:11:05 -0700 (PDT)
X-Received: by 2002:a05:622a:4cc4:b0:50e:defb:9dca with SMTP id
 d75a77b69052e-5165a22c5d1mr297501351cf.45.1779221465177; 
 Tue, 19 May 2026 13:11:05 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ca36190422sm100564196d6.26.2026.05.19.13.11.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 13:11:04 -0700 (PDT)
Date: Tue, 19 May 2026 16:11:03 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH 14/14] migration: Enable new switchover-ack
Message-ID: <agzD1-wZ4MeKwgPT@x1.local>
References: <20260505081423.28326-1-avihaih@nvidia.com>
 <20260505081423.28326-15-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260505081423.28326-15-avihaih@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, May 05, 2026 at 11:14:23AM +0300, Avihai Horon wrote:
> Now that VFIO has implemented new switchover-ack, enable it.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> ---
>  migration/options.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/migration/options.c b/migration/options.c
> index 44327c588f..91571f9d30 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -108,9 +108,8 @@ const Property migration_properties[] = {
>                       preempt_pre_7_2, false),
>      DEFINE_PROP_BOOL("multifd-clean-tls-termination", MigrationState,
>                       multifd_clean_tls_termination, true),
> -    /* Use legacy until VFIO implements new switchover-ack */

Removing this line is fine because it's a very temporary thing.  But maybe
it would be good we have some rich documentation on both the legacy and new
behavior of switchover-ack.  Normally it would be qapi/migration.json, but
in this case the user shouldn't need to choose, so I think when keeping
qapi doc simple we need to have somewhere internal that document all these.

Thanks,

>      DEFINE_PROP_BOOL("switchover-ack-legacy", MigrationState,
> -                     switchover_ack_legacy, true),
> +                     switchover_ack_legacy, false),
>  
>      /* Migration parameters */
>      DEFINE_PROP_UINT8("x-throttle-trigger-threshold", MigrationState,
> -- 
> 2.40.1
> 

-- 
Peter Xu


