Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A28C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 15:56:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlqKv-0001Ub-4N; Mon, 20 Jul 2026 11:55:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wlqKs-0001S1-Uh
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 11:55:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wlqKq-00053o-HW
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 11:55:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784562915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Ih3Hha2URxmFHExNDLByFWMH0nf7D68+II4Ifjia5XM=;
 b=epEPDi0tYI1vH2kxeoPGKS8b+aOMvS2GWtJjYPkizoYxxogd3lSx3th0+sTjmdU9dqMaQA
 KW4M6bTNbXM2AAZDOyoSMscsr0+R7y5kCowPer3Abe0MqsqnC5HA3/NuVHK6tw1ySAnvww
 84XKMHrOC7Yp1qfAgD72w95qpcVvDe4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-VWlNN7dROpKSrGOpSm-WmQ-1; Mon, 20 Jul 2026 11:55:13 -0400
X-MC-Unique: VWlNN7dROpKSrGOpSm-WmQ-1
X-Mimecast-MFC-AGG-ID: VWlNN7dROpKSrGOpSm-WmQ_1784562912
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49545071724so42735215e9.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 08:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784562912; x=1785167712; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Ih3Hha2URxmFHExNDLByFWMH0nf7D68+II4Ifjia5XM=;
 b=dTkElyBHInTKWpkAy/sJqFxgS3y4VsCB4aO/MEmB3m7sFqJmNHWR1O0z9wfAEuptwS
 iVnj7w0lWpk2xWiaz0nBHVjlO8BMjA3Sl1eTz9ODW0E+JU3OM9mED8ofpZ/ppOCrZRAu
 Lp/92DObHc5JU1aHSrib9bYHndVxyauKQBsguoAwF9xlrXyEjoFiL+3kH7zAciXFpW+n
 VrO3B2Q3A5Zb0nbtI0VFGwpvKhPuzA3wiArGkL/LD/HnhomHI/s3RWb69lEZHUoISVVX
 wqu9CiABVU3FHJQTxyE9BmmhFp9CvHoblXtDHfKJq7d1/6qkjng/nxTGxdFTkkges8aw
 DCVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784562912; x=1785167712;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ih3Hha2URxmFHExNDLByFWMH0nf7D68+II4Ifjia5XM=;
 b=Ff6nrKegCd7TL170jcbJ2y4MsYGAjSfDyNI/MYCRRIJXlClAl0PuO9/b3pI6+Y4+Hc
 CpRJXbW3KlSqQssVrZvkyYQpsd470eZoSyH3wW+Y0kT2nkHHNwVCGR5JmGUwLqjwJbnC
 n/G5XAF3ohLk/8apRKupT9Or9I01rSxidpws5Y2ZkSS18UWK/PLKPaZ381Q5Fa9XNtTH
 2yGQ5XpsrLl7RFsa5sb8fNfJ39J8spadxNukBTaCOaPt10SwlC4CL1WQZFLrAaH6KL6G
 LAh/Co4OonBt9Znym2C+BaiEcXbbWky0UjIP+95HkodEk9/FuFFGS16sm9Yv6cpxsgpn
 YU0A==
X-Forwarded-Encrypted: i=1;
 AHgh+RoCyn4CDTq+nU/+C3uujD6kxLIk+hiE6fr/p1iU7erF1YOTZYKfuN0NIn3NVEFmmTST7WkXryi+94Ix@nongnu.org
X-Gm-Message-State: AOJu0YwCr5CAT3m35ZPrpkHkhgd/aNVA6boT9GAHmSAMW/tN1lzlJj13
 KNJO5Nyv5r23WE4QROSWeTfhYvKmbSJGG+xOrhahq71bQ7A/C0M0CqI0ntRpJtAgHGfe336lobR
 mx/oYHQw75CONJaKnjOjKUpAaJs0+60VRUh7Foe5S//PvN4K2x6wQohO6
X-Gm-Gg: AfdE7ckOd8lw9u3Pku3wmuJ0bUaGO9MC2bqrdGJjavsdACQgPu+Dg2XqJZYsC8lShp/
 ibJJXssDAOSWPGxEPt4vqadYQdiMTT0QUnQJ1v2L7cHJI39BWgOa4W/j8vqCvdjE/bxBjz/MfUf
 n3EyxZ5TeZo9qEDoRovCHYEwbnX5EamD5j1vK7xgnj1JkOUU7AAcJ08HjxQ/rS/MC/ipEmvZuM5
 VBaSFqRJ6n7BTbyPsgxo1kW2x5ruW8cY/0k93etFWKvpk5jDscyin98gimvWBj+iwFP/JFkVcjd
 GKPFJyqqt4BswOERDk3xzc8MIZfyPHfWB4gUzYLHejrA87sp51cO4EQPS7KrqGA1rvvIjiZfiTD
 Dfrcv2VTO2LbapRm9rzGuRnF7SXUDIsynoJ9K6rc=
X-Received: by 2002:a05:600c:35cb:b0:495:50c:259c with SMTP id
 5b1f17b1804b1-4954a3cffa9mr191920805e9.7.1784562912129; 
 Mon, 20 Jul 2026 08:55:12 -0700 (PDT)
X-Received: by 2002:a05:600c:35cb:b0:495:50c:259c with SMTP id
 5b1f17b1804b1-4954a3cffa9mr191920225e9.7.1784562911610; 
 Mon, 20 Jul 2026 08:55:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954a2aa698sm267061025e9.4.2026.07.20.08.55.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 08:55:11 -0700 (PDT)
Message-ID: <a4ddb949-7a65-4665-a802-890e47089e76@redhat.com>
Date: Mon, 20 Jul 2026 17:55:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] vfio-user: validate server responses
To: Thanos Makatos <thanos.makatos@nutanix.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: John Levon <john.levon@nutanix.com>
References: <20260720091718.2642-1-thanos.makatos@nutanix.com>
 <20260720135823.21070-1-thanos.makatos@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260720135823.21070-1-thanos.makatos@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hello Thanos,

On 7/20/26 15:58, Thanos Makatos wrote:
> This patch series fixes some bugs where the vfio-user client doesn't
> properly validate information returned by the vfio-user server.
> 
> Thanos Makatos (6):
>    vfio-user: vfio_user_get_region_info: prevent buffer overflow
>    vfio-user: vfio_user_get_region_info: respect max_xfer_size
>    vfio-user: vfio_user_get_region_info: reject unreasonably short struct
>    vfio-user: vfio_user_get_region_info: prevent excessive malloc
>    vfio-user: vfio_user_device_io_get_region_info: fix capability check
>    vfio-user: vfio_user_device_io_device_feature: prevent buffer overflow
> 
>   hw/vfio-user/device.c | 40 +++++++++++++++++++++++++++++++++++++---
>   1 file changed, 37 insertions(+), 3 deletions(-)
> 
> Changes since v1:
> - added 'Resolves:' in patches 1 and 5
> - added missing SOB from patch 1
> - removed reassignment in patch 1
> - added a new patch to address the same issue as in patch 1
> 

Could you please add 'Fixes:' tags ? No need to resend, just
reply to the email you sent.

Thanks,

C.


