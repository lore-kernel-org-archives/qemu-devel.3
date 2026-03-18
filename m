Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 879D2FCD0DC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 08:31:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2mJa-0008Vq-EO; Wed, 18 Mar 2026 04:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w2mJE-0008UL-1a
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 04:31:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w2mJB-00005w-D8
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 04:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773822675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9lpYg480c4fPMkvNO+xVaXELygcWb2xqwE0auihC/dI=;
 b=irzE9MMuYgvaS0fACzvvD5cGPIoEyt012sXOpH0wBt/Uoe2rzQbXaYlYU0qYTb+GHqo5jj
 TzkgZXfN4VobD44W4+wLoqYX+nhQma6LyREghP/eMU1F2+jisM/9sLyrBQSsVUDoeKlcqm
 TKxQxVdzL1wLK0W10hXuF0P+tUodi7w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-K19WV5FjODqhS-DIDLdVXA-1; Wed, 18 Mar 2026 04:31:12 -0400
X-MC-Unique: K19WV5FjODqhS-DIDLdVXA-1
X-Mimecast-MFC-AGG-ID: K19WV5FjODqhS-DIDLdVXA_1773822672
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43b46b2b161so2865797f8f.0
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 01:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773822672; x=1774427472; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=9lpYg480c4fPMkvNO+xVaXELygcWb2xqwE0auihC/dI=;
 b=qLPVcd1nXR9A2ZWsp8l9OuF2LLJo8M4UaVQramlGxotG8w2dE/IrvTIT1g/z/KZv6O
 5UeNjeCdZXb5fKzY8dda3OlNJYys/U/SSlhhHdpcMJ1BCQSn+4oASR848u+dIpz6dLj0
 qq7Hx+4MYLA35zuIR7uz0szMZzx3Db9RGcIoyLKAEM4AWlNpf8t431+YafTUkYM8AQi5
 FsJ5sAwubKgZVdfQ3Tn9xidD/r1kcP6kC64FN7ycKGzu4T5cMDm7DGYpy/YSlmXPqI02
 vwmiNcxSccQJijhVQAnVnd0sAnHW1KHcKl/kkPIGKySpA6NQYRYOzMjDuMbG7IlCtvDe
 /2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773822672; x=1774427472;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9lpYg480c4fPMkvNO+xVaXELygcWb2xqwE0auihC/dI=;
 b=i6+VP6T3tVD8iYVfcMeq6Ytgrh6adIENkXRBXm0JwQJwr/ARJXGv0NEZ6S8HNrXJbq
 CVl1NHEFk3mgNJwe2Zwrv+efgez+gtb/trE4BJ6rfMI7nzcnlpbi5pbJQeW42N8a+iSA
 WnkHKhRoeUxyz8a9VLchwj3xo0KHTAP26uuClZrpbso27lV0+BIJ1Hx5kKmCFtSL+MIB
 gJOZL+QWC/MAJ8maGgUIHtmWtX7J3STAoVEQPolqpqHPrM934amS7jtOi3hXo962BW7e
 FBm+TboSZFGK6+L+o4ENY3OZp4Ans/VNCEcqyjfPLVlW6m5cdkjGzn5eZoKjXHBnMzHp
 Cn/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/iAthQrBsvmxeEdGviXYD7OzO/DwnPI2hhLt4iZXLH++cTQBFyp5FredKGvBVrtv+/Ah2jbWszr/Z@nongnu.org
X-Gm-Message-State: AOJu0YyiEWk+V5io92d5FvksUfIl7X/o7uZcKspdb3oPpRyxZscqGvjd
 F7HY1v46QT49oHt1yj+iuIrPaCgm+gBw4zLE69jWue/YUML7HVgRgBO5K8n+ppSC3ywasOpY2AG
 wcFhCXW5pnv1PHExi3Pbye3D38e8btpvyn4S5PTcHpXCc8F+wwrTLjBuJ
X-Gm-Gg: ATEYQzzpBW12u/eW6Xfvbmayi2V/ajcm3KNuLMgutdJeoQv2dgXnLBBCds+3wG2//9s
 p685ThpGXC1Ib1R1U0uS3tmaDp/RueE6bZkEPLaZNbyEVhmyqZ+fFt804gHJYCgzzeDC+JJ1GBR
 ob72UH4MFRnfZrk+ux3FiHyaEwa37fnSS6+vZDZKQstTflUyZWilxCnLVjOB1VfKyghv9js+6X/
 82Jh219ApLc1aacLcJ3objco3hmvYZc9q9il+GTn6MxjNfPjgAyL0DGMY3/Asyf0W2Lubrzyy1U
 7lGsFNSpILXo37vOMUEGV9ET3glvj69H6dwyzgtc/EhUlLVVuvWaYvbyufyCQixuYw9WLg7FIl6
 7q1reXHjN9jVaabYXh1vDiOE8U/o3fH7bPfp+CQQnfxt7Svj4BYO1bGgQhTpZ
X-Received: by 2002:a05:6000:24c8:b0:43b:4ec7:f924 with SMTP id
 ffacd0b85a97d-43b527c4e7cmr3840830f8f.34.1773822671477; 
 Wed, 18 Mar 2026 01:31:11 -0700 (PDT)
X-Received: by 2002:a05:6000:24c8:b0:43b:4ec7:f924 with SMTP id
 ffacd0b85a97d-43b527c4e7cmr3840740f8f.34.1773822670806; 
 Wed, 18 Mar 2026 01:31:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b51892244sm6084243f8f.22.2026.03.18.01.31.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2026 01:31:10 -0700 (PDT)
Message-ID: <78675050-16b3-45d2-8650-78268ea8e2f1@redhat.com>
Date: Wed, 18 Mar 2026 09:31:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/8] hw/vfio: all vfio files can now be common files
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org
References: <20260317194241.869568-1-pierrick.bouvier@linaro.org>
 <20260317194241.869568-9-pierrick.bouvier@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260317194241.869568-9-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/17/26 20:42, Pierrick Bouvier wrote:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/vfio/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
> index bab5f2b7f15..fa0ea6ecf0e 100644
> --- a/hw/vfio/meson.build
> +++ b/hw/vfio/meson.build
> @@ -20,7 +20,7 @@ vfio_ss.add(when: 'CONFIG_VFIO_AP', if_true: files('ap.c'))
>   vfio_ss.add(when: 'CONFIG_VFIO_IGD', if_true: files('igd.c'))
>   stub_ss.add(files('igd-stubs.c'))
>   
> -specific_ss.add_all(when: 'CONFIG_VFIO', if_true: vfio_ss)
> +system_ss.add_all(when: 'CONFIG_VFIO', if_true: vfio_ss)
>   
>   system_ss.add(when: 'CONFIG_VFIO', if_true: files(
>     'cpr.c',


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


