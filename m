Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF1BFC79F8C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 05:46:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4B82-00077v-Qo; Wed, 09 Sep 2026 01:45:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x4B7z-00077A-GF
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 01:45:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x4B7x-0008Du-In
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 01:45:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788932744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=CnETwSEWzByRDrmJZmZTyAdrkNKGi9pl8hfhdZ4YH0M=;
 b=YBIcVGXVszrisvr7tL8F9WDMeSv0jI9XdGHMxlFSYglrWVTP12z6ucruq8nWbo8yQALsT+
 mWyCVMQ4UB6V3D+YzlrWVl/5G4Qpo+XM/zFa8Ne/ZR0ICCDuWmUUOJnFCpvu2JkfjH9nUi
 sKc1IXVsMLSjHm7VFHFx5s+nQFatt1g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-hQnS02mWOMuTNMelKXnSoQ-1; Wed, 09 Sep 2026 01:45:42 -0400
X-MC-Unique: hQnS02mWOMuTNMelKXnSoQ-1
X-Mimecast-MFC-AGG-ID: hQnS02mWOMuTNMelKXnSoQ_1788932741
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-482e05af072so4271428f8f.3
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 22:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788932741; x=1789537541; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CnETwSEWzByRDrmJZmZTyAdrkNKGi9pl8hfhdZ4YH0M=;
 b=PxFalPWnC1t6QwzwTumM+KHY+BJDsNpaA+w3Id93QQytq4L9SayrdeujCHEvd65We9
 UK2jYv92Tp452/2CjMIrCcUe7ONpCFraJwD956riyueI6fB8O73sSBG33lpM/ONFSfhW
 R/sFJd3G6ZFGdW0Yy/QjO3LEZ/tYCvXOKiywfe0RVb68Ovax5KDOiJaX4qSKNNS7hymb
 f0VQXrKjMNZVajixJkYuhAMoVfOLCmU2qYmB0Xl5/Dw9r4y6k0w0othuGiOWWLF/KGlV
 /MeVo/Zx0u4aeXYMnxMWtGcwDRNhFcjwBNsAfs7bwxFE82ISPpqEmd01KzbyVOlIfuxm
 ftXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788932741; x=1789537541;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=CnETwSEWzByRDrmJZmZTyAdrkNKGi9pl8hfhdZ4YH0M=;
 b=PdnQh5X7+k+uyAY/V6w7MZ7+DVzDtv/vyI+EQ5FC8gUPWN0Y3707bNFlt+HCtz3M4D
 Nw3XPvFToJPKc01nfSwVx3482lqFz3iXT0bmBiJUQPr3S+kcUtNIDlWvsXBlQiydDJVB
 gIZC1BTmARi1WgpIgerv/yKrL/dRdvgK+7xKBECZao2O3XscLoQ+XqXLt/oGTN8sXePE
 hBjL1tIBoG1C1n+F/RgTDmu7sTDL2UZv8y6tKQWVpu05YoIYfFZPNaJi0zCyT18rS+0m
 2Ph93hLeJStflKy45t0iib5mWapqtgoe7AcEfotFBVqR5R2TOOC9Q5vP1s4Mx/0sggcN
 mVyw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy7yojyUw1iVhW/qEr1SvqdgWkVLCPkGXa1ZjkK5iWjsg16+yFV6AjAThOB2Y2KjUvrEnkD0nW/oKzP@nongnu.org
X-Gm-Message-State: AFuF++me7/n4vHxO7CwyCGkCO7RkxodH9ygPb6FtLd9XO5QlHDp5Wg36
 N/hq2WC7NDp6YMSMZIfOytF6Azue9gNMoy8V4enEDPm9lQzUm4UeIKKxfh7Cj3LEOWUirmLpguL
 QOEe57N8Xo6I3J+ZslY9HlsRy4eEPRAwM9Xha0o92bNZqZ2y+LiYhCO66
X-Gm-Gg: AYBFou2ff8qVsyznrHPylf6sNUvNX3iBsPphuUmJOpli4YA8sl3CIXx0yuj2PfEUI/h
 m88LgpTFech2ExjKPKSHojic9Z9r8n5eg5sUCEw6S+matVIAqH9l9a9I9TY5RnJB5yYN/bZ+jg5
 +aeItmiv02tlv1C4N9gInQuKUKvp696QcM+UAQ87cnFkW93GQiwSIyHrC9z/RFSDXPv03gnNj5+
 x5FCx/kbjqUy5sUCuiO+Xrb8rFJ+qNo/uBTUBsfJ4KPXJuGKjQXtOiT+hBoizfH5utrfv7Y04eR
 HRoFaBPPItf8TTWsy2ti664JnQFCe/rJzxWi10GbY5Ii4vEwMRte5fuxc8E+B+0zAn34gdpt14j
 IDqGmp5ByXq91yA6wSJhcfiiwhhj/7lQ07Qcej+9HXA==
X-Received: by 2002:a5d:6f13:0:b0:485:ac96:7265 with SMTP id
 ffacd0b85a97d-485ac96737bmr1903868f8f.10.1788932741189; 
 Tue, 08 Sep 2026 22:45:41 -0700 (PDT)
X-Received: by 2002:a5d:6f13:0:b0:485:ac96:7265 with SMTP id
 ffacd0b85a97d-485ac96737bmr1903820f8f.10.1788932740798; 
 Tue, 08 Sep 2026 22:45:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:1292:d530:578a:3c67:6721:1232?
 ([2a01:e0a:1292:d530:578a:3c67:6721:1232])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4859207c28fsm36167376f8f.5.2026.09.08.22.45.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2026 22:45:40 -0700 (PDT)
Message-ID: <0bab1434-c36b-49e4-b902-b446b8be9617@redhat.com>
Date: Wed, 9 Sep 2026 07:45:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] qapi: convert simple enum intros for vfio.json
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-block@nongnu.org,
 Eric Blake <eblake@redhat.com>, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Jonathan Cameron <jic23@kernel.org>, Lukas Straub <lukasstraub2@web.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Hanna Reitz <hreitz@redhat.com>,
 linux-cxl@vger.kernel.org, Kevin Wolf <kwolf@redhat.com>
References: <20260909041640.69080-1-jsnow@redhat.com>
 <20260909041640.69080-2-jsnow@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260909041640.69080-2-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 9/9/26 06:16, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   qapi/vfio.json | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/qapi/vfio.json b/qapi/vfio.json
> index 3d61fc38ecd..47fff8b979d 100644
> --- a/qapi/vfio.json
> +++ b/qapi/vfio.json
> @@ -10,14 +10,13 @@
>   
>   ##
>   # @QapiVfioMigrationState:
> -#
> -# An enumeration of the VFIO device migration states.  In addition to
> -# the regular states, there are prepare states (with 'prepare' suffix)
> -# which indicate that the device is just about to transition to the
> -# corresponding state.  Note that seeing a prepare state for state X
> -# doesn't guarantee that the next state will be X, as the state
> -# transition can fail and the device may transition to a different
> -# state instead.
> +#     An enumeration of the VFIO device migration states.  In addition
> +#     to the regular states, there are prepare states (with 'prepare'
> +#     suffix) which indicate that the device is just about to
> +#     transition to the corresponding state.  Note that seeing a
> +#     prepare state for state X doesn't guarantee that the next state
> +#     will be X, as the state transition can fail and the device may
> +#     transition to a different state instead.
>   #
>   # @stop: The device is stopped.
>   #

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


