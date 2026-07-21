Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6CD4C44529
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 07:10:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm4cb-0002JV-7b; Tue, 21 Jul 2026 03:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wm4cZ-0002IM-I0
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 03:10:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wm4cY-0000nB-6i
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 03:10:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784617829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZbNYNInTaqsqwPoblRT0PfUz1jX1p2D5R74bgTKpJlA=;
 b=Bt84UO2be4IEmukKJzPJqaciYuK9s0CzPKDQcYH63kM51yQZ/yScz4hUoOs3QROa8YbqoW
 j7DatmoAP5bOVRzU6cLAkk6JpXj9X8LYDiI+2sxhOYSEvZrWya5jEQxx87qGaN+DjzUnaz
 NyQSHLG6QyYBbAmMaFOfiRDN2A0qddw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-bq4pxMsaMXe8cRleb9P7Vw-1; Tue, 21 Jul 2026 03:10:28 -0400
X-MC-Unique: bq4pxMsaMXe8cRleb9P7Vw-1
X-Mimecast-MFC-AGG-ID: bq4pxMsaMXe8cRleb9P7Vw_1784617827
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-476d52b13d7so6788329f8f.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 00:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784617827; x=1785222627; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZbNYNInTaqsqwPoblRT0PfUz1jX1p2D5R74bgTKpJlA=;
 b=b5zU1wdVSbgvF8F9D8i1U4eru3emf8hN6TiI5ahIWoAfC7isCWY7sJBFhH8q3pkHDT
 zay1VRUrUYu3+3HujbrFYscY5VMyz84PfL7TI1HfaGC3ml87a0YdaJpA8bcpX2OIcG5v
 t8qUOiENthe9tnPKvKnBxu1LlU+S+/M1XhNl3xTrxyX6Nri74C35ccCsJHVIUHC5j5eO
 /ZjKkAjPDxdag1CjF/ZO+aJ0XdcUftM2welysCb7b1QNHX8yw56sYv436mTsuzjES/8W
 4ZxPLZQ1fy+0bSkdtpJsNX0ybARXRxejezxKgGJ7b+8NayZE+7DB+RRYR/OcLZWFLzt/
 8fLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784617827; x=1785222627;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZbNYNInTaqsqwPoblRT0PfUz1jX1p2D5R74bgTKpJlA=;
 b=rSzshRZ2TW6arCC4SIQahW+JzVeUS7i3DVxkmALzQzW6xC44CeIgxqdvLjG46eQZry
 SwQrY36HSlDyHlgDbUHlDkXNPvH3baW7hhHhR2iVVQ10hJJG7cntgo0H8tUZriskMRzo
 2KysQf4MeR26XaMOyG3FcZqekCPF/+LQBjiA3HwcDCQgOWyIe4/cjOdS1L5cMzkWQzh6
 V0dRHTU8HCbL3OHBna4wVFoWTP46kKv9Jt8thkQugiwjfbezBajireXzJja5QHEasvBk
 lguz0Pw3/BPQZJ9Er9Ia//FgKQi+ecZZcsP0i+dXwICX+F3ecyZuLp5EYDIoZ3Q/2F51
 9ABg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqhclnqtUWy0An6XmulImC+PrZJ/41jFB802vKmnM4ucDQ3x2rG1gRwFE4y9p2w4d6VRIv2ugKQrR3T@nongnu.org
X-Gm-Message-State: AOJu0YwB11RvQ8DFgrGyBrT3fnBdu/jqNkIjFpGYUl0zqNPysArNm01g
 96kcEowpZdOZWi/oC79DJVltoKYsLVq83iEF6o+YiUgQ6UKd017GUfjt3sehqOlDgl95RcRT09V
 v6Ac679dTFaYDyYK5GmTTNc1TxWL5jJCrBnkHbTungvuVu4jLV6LpHMG1qiXAqN10
X-Gm-Gg: AfdE7clmpvrjFBgRvnDeXE2dpl+CeLP9MfZu8o5w2MLEqLKF8yzIoDYuhvsu2eL6T/l
 jSp/pvtc8c5ziuD+qBBdSr3FbG4mOPgt0IdyBwZA25y4WrHsm2mdS91piKtRnaGCHXS8nE6apy6
 LWegzv3h6lg3d8xVrQE7muDARr+SErMHBrfukZrDgLlyaneCUl58rkhBLJMwyYL94W8FReSpk8A
 3R71MMS8H414Ruuiyj14s/PmjzF2PL0wa3QH6cnDbp2xwESU4YjNPNLKpotGlhFIiJYlKXZtzJ1
 ZLnlxIKTEY1bliPUZtoHML7Ref0yUVdwXPzD+pxZ5Nxy3TVCSB+bRfcAkPN9RavsVMJsM0exAK4
 ce5a2DNS/WzcM0uZvM4QD455oQ6LjaweyjPqwspc=
X-Received: by 2002:a05:600c:6a0b:b0:493:c453:6002 with SMTP id
 5b1f17b1804b1-4954a516453mr109849865e9.35.1784617826921; 
 Tue, 21 Jul 2026 00:10:26 -0700 (PDT)
X-Received: by 2002:a05:600c:6a0b:b0:493:c453:6002 with SMTP id
 5b1f17b1804b1-4954a516453mr109849695e9.35.1784617826458; 
 Tue, 21 Jul 2026 00:10:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495653d38dbsm43404725e9.15.2026.07.21.00.10.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 00:10:25 -0700 (PDT)
Message-ID: <217b88a4-d25d-42c6-9b97-1089c0483e94@redhat.com>
Date: Tue, 21 Jul 2026 09:10:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] vfio-user: vfio_user_get_region_info: prevent
 excessive malloc
To: Thanos Makatos <thanos.makatos@nutanix.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: John Levon <john.levon@nutanix.com>
References: <20260720091718.2642-1-thanos.makatos@nutanix.com>
 <20260720135823.21070-1-thanos.makatos@nutanix.com>
 <20260720135823.21070-5-thanos.makatos@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260720135823.21070-5-thanos.makatos@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On 7/20/26 15:58, Thanos Makatos wrote:
> If the vfio-user server responds with a value larger than max_xfer_size
> vfio_device_get_region_info() blindly uses it in the next loop in
> g_realloc. An value larger than max_xfer_size is anyway rejected by the
> check at the beginning of vfio_user_get_region_info(), however that only
> happens _after_ the g_realloc, and if that value is excessively large it
> can cause g_realloc to fail, so check it here.
> 
> Signed-off-by: Thanos Makatos <thanos.makatos@nutanix.com>
> ---
>   hw/vfio-user/device.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
> index 3d12e8b2a2..008e5cf687 100644
> --- a/hw/vfio-user/device.c
> +++ b/hw/vfio-user/device.c
> @@ -170,6 +170,16 @@ static int vfio_user_get_region_info(VFIOUserProxy *proxy,
>           return -EINVAL;
>       }
>   
> +    /*
> +     * The server can respond with a larger argsz in the reply to request a
> +     * larger buffer on the next iteration via vfio_device_get_region_info().
> +     * Reject values that would trigger an oversized realloc.
> +     */
> +    if (msgp->argsz > proxy->max_xfer_size) {
> +        error_printf("vfio_user_get_region_info reply argsz too large\n");
> +        return -E2BIG;
> +    }
> +
>       memcpy(info, &msgp->argsz, info->argsz);
>   
>       /*

Fixes: 667866d66620 ("vfio-user: implement VFIO_USER_DEVICE_GET_REGION_INFO")
Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.




