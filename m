Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6450AC4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 07:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm4cV-0002Gb-4H; Tue, 21 Jul 2026 03:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wm4cT-0002FC-C9
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 03:10:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wm4cR-0000ms-Rg
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 03:10:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784617823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+cCphlS0ON4cZ1iSbe3VdBGNV3YUxu2j78zyIgDzRdw=;
 b=JvGo2+CqJNExhW6khD+k78pIw4egSBHaeoKuf3xgzYzQR6bPxLXWNTjl4VTGPnr6e6D/KR
 CMKDCGQdCIgvbfEU4qCkJjmKqJvlWGXlngrLh/w6GYQEijK4fjJC7t3/9atoAP/o5o8kQu
 3UXr2K36/4P+Bu4PN7hsnUnfIAuprhs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-8SBus08HNcmc7GQFg-8ONg-1; Tue, 21 Jul 2026 03:10:21 -0400
X-MC-Unique: 8SBus08HNcmc7GQFg-8ONg-1
X-Mimecast-MFC-AGG-ID: 8SBus08HNcmc7GQFg-8ONg_1784617821
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4955d314945so12088475e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 00:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784617820; x=1785222620; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+cCphlS0ON4cZ1iSbe3VdBGNV3YUxu2j78zyIgDzRdw=;
 b=GD+CrgE228i2wUIJVUAQvdSXP0jwhxD8KgAP4/cX5/nDBRQxMN0c9TM+bbDc7DzDGh
 QZ2JpG1unu/iY/e5/l3J4aKTK7fvumbzkf/cjnKuPVVpea3ED2qnYf8oLmgQHNE0K+ra
 Cd6eAAr2khrMnrFgs7EyojW+4p3N2stQIQbJolv+TiEwjBpDErHlXFYb1N6e6FbynRIx
 xnJRFamfo8JAwjvbIl/Tkr76UCVjTnoV/5V26RLjzfCEq3IyVitLp1aKCDFu3COcM3N4
 K8sSIfHsTk3WMjLu4F5bcYZc+bgcR++ycAlLIsTYd/woPMY82xa3+wmbBEvG1rMhV8ho
 ZsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784617820; x=1785222620;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+cCphlS0ON4cZ1iSbe3VdBGNV3YUxu2j78zyIgDzRdw=;
 b=FuarpzTeaT5Ix5RM16wXDPda/w5lueKprnxZ2MTQaoKbzYsO/r+SAq4VYeTbfOsR4R
 +XZSR6uBvt2Qj4QV1jgqHCICguyOYORbGiUlHRexbMiF4oB2Hfs0fmkEiiv6EU+bXjw9
 b2wTD0yG8bnViv7zkIKghlo2R8xtbSgmbOPx7wUR5iNIABG/Swcj+inaMM+sv2gMhXzH
 1MUG/VBSVvOcmzmDLo3bVzZHViF6WUuzOqvqkr+d8FRnoD9knoc3BHjXIJU9k2QY+mhe
 i1a51e84BkMgMZ4UzgX+7UFiQMyPbnx9xlG7swancIdvsZLT1QUqvN19PRdkQfOVMc6w
 4Xkw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrCo0Zjn9wbwXgZhTCvuJaXmxcxi4A9SsO4Z56LB4pUyV3Lw6qaUrzLVHcZlJEOriMNMI4Ek1JYcQj5@nongnu.org
X-Gm-Message-State: AOJu0YyAI6g4p19LwyYyZtnd7g7dJC10ixCNI3ZiIHwEuj4268Qc+KhG
 LbKrmcVoDJBAFRpN4jgT90gb5/Bd2+PU/2fHLuG+0UZ0vzzFCqfSx093QuQnjZhHLl4qTgeNkgf
 ZCgXhcKSnohFr3DNMeH4sIaT1g+rYlulF4ldXx7SbTaduhNHvDVliI33uaHR9NNR6
X-Gm-Gg: AfdE7ckoyvt4MhUmZOZC/OBgfko/dU0Dfu5qKC3GBbPP4QwdZUKXMil2xcVUDVtAD1g
 2OZdWva0Pzh9APbZGv18aoddTVC/YRrwIqI6WD61/dlKFu1fNOm1v4le5rsnKCuYUesnDbB5mOc
 c0p+2zX6mIxtd2ft6435GmrJZswjmgMkYBJdeFVVEzOY2wY7WnnEj4AcvilU2J3Q2SeY/V1RX4D
 vBMbhJ1aIB4UJKs+LqLAjFLt14v1JbrD/q3K027z4GLhLqvpX83mkKKkbybW3HhG0uUhISLyDWV
 GYg4Sn+umo8FLVzB689Ve7RxTmjtJfr4TtXOi7VVCenNyrytN9AaX1POw2zXqZS3DgsONrNkxvJ
 6aHWC7Iu5q1pxpyqX3lkUdp5GeW9lXs4ASRTr6vg=
X-Received: by 2002:a05:600c:190b:b0:493:c77c:108a with SMTP id
 5b1f17b1804b1-4954aa1a10amr182400985e9.36.1784617820489; 
 Tue, 21 Jul 2026 00:10:20 -0700 (PDT)
X-Received: by 2002:a05:600c:190b:b0:493:c77c:108a with SMTP id
 5b1f17b1804b1-4954aa1a10amr182400675e9.36.1784617820059; 
 Tue, 21 Jul 2026 00:10:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495653d38dbsm43404725e9.15.2026.07.21.00.10.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 00:10:19 -0700 (PDT)
Message-ID: <209c64fe-c988-41f4-a030-050753439d60@redhat.com>
Date: Tue, 21 Jul 2026 09:10:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] vfio-user: vfio_user_get_region_info: reject
 unreasonably short struct
To: Thanos Makatos <thanos.makatos@nutanix.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: John Levon <john.levon@nutanix.com>
References: <20260720091718.2642-1-thanos.makatos@nutanix.com>
 <20260720135823.21070-1-thanos.makatos@nutanix.com>
 <20260720135823.21070-4-thanos.makatos@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260720135823.21070-4-thanos.makatos@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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
> While this isn't technically a bug, it's highly unlikely that the
> server wouldn't be writing an entire struct.
> 
> Signed-off-by: Thanos Makatos <thanos.makatos@nutanix.com>
> ---
>   hw/vfio-user/device.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
> index 8350bb2c01..3d12e8b2a2 100644
> --- a/hw/vfio-user/device.c
> +++ b/hw/vfio-user/device.c
> @@ -165,6 +165,11 @@ static int vfio_user_get_region_info(VFIOUserProxy *proxy,
>       }
>       trace_vfio_user_get_region_info(msgp->index, msgp->flags, msgp->size);
>   
> +    if (msgp->argsz < sizeof(*info)) {
> +        error_printf("vfio_user_get_region_info reply argsz too small\n");
> +        return -EINVAL;
> +    }
> +
>       memcpy(info, &msgp->argsz, info->argsz);
>   
>       /*

Fixes: 667866d66620 ("vfio-user: implement VFIO_USER_DEVICE_GET_REGION_INFO")
Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.




