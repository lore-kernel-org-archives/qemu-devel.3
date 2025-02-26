Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A91E3C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 15:50:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnJfb-0008PH-0e; Wed, 26 Feb 2025 10:49:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tnJfQ-0008JY-64
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 10:49:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tnJfL-0003fB-Op
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 10:49:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740584981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oWNJAKnTiLX2OXluFd192ijHM44TrET6Ofe+E0qRMR8=;
 b=PqX4uYy5lDXbtD+uBENc8f4BFv2HjaLte+fXehG2SiXm5argjcDK0i3MPhd8AWNrZOcdul
 gQIy4PHyFcturHuKslwV2cI6S8mA9GiRbqkuFdYe9ZJNCVwntntqZF8RFj6JZcUc7BtAoO
 Jupk95pPTfVBBUsHC8CqkQdGzrLvBJU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-EuEu3bbDO6iN7yrkVuU9sg-1; Wed, 26 Feb 2025 10:49:39 -0500
X-MC-Unique: EuEu3bbDO6iN7yrkVuU9sg-1
X-Mimecast-MFC-AGG-ID: EuEu3bbDO6iN7yrkVuU9sg_1740584979
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38f4e47d0b2so3151121f8f.2
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 07:49:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740584978; x=1741189778;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oWNJAKnTiLX2OXluFd192ijHM44TrET6Ofe+E0qRMR8=;
 b=DqocSdSPfoLjjx9ZpdF+M6zh/Vvfcr+leHA3rp/1EK76clFJhsty/k+65QgHKZpZ80
 bew6rfnB8ALMeSLyNlQRvvzydfgLxOUGErpKZuXPcETEe9Y+hXzciJXCXId0VOFxzdR8
 JcdWxfqOpDat+7qpPZPypyj0NBIdvHfecIKyiDD0TZTSBEG2h66DV/Goc1TFSdUKCkiL
 vk82FjTcYqJhzRdWDSrMl77+wnLvAky/rofPQ31tyAF2u8m+omCot9cA65/cz1wClVDW
 mAlSZboH/wHUbB43Rt9DNeYmtoNXbmCCIzabb7TQF36qjEvgQo5lTaH/wSKMEFPt60KI
 5j3Q==
X-Gm-Message-State: AOJu0YxXD2niuHBsij7FZYk2V/ycpT/mlaUMVGO9lV+ptpp+1hdTO5QS
 ocBHUjdYQ9HsLzV1cDSEQ0PxajUvDSFEeCuPBYvijsVYrqVhWf0UVy+uo0ZUcf5n7ulUuhBjb0q
 sH8UZ1vnG5afU7vgaK+jrhmJOkapuSKMzT+XwW3LDsxX8LIOga4dM
X-Gm-Gg: ASbGncvIUSAJbYO9GjsrNoHR3XgKSjmRifNxOtPIJk93Cl0KkXV7KMxgxgBVRq7t4KP
 KY6tH/37F/Vu70QQsa7XksyY37Rfxyqi6nrKxK4QPJ+mCrucKQ/i+CbESBeFSrwZMXMjjmqDmpS
 tid6vp2DEUCN5/k9a+GNHWcz+hFnhVITMsWOa30+RQvnVheiDkrPi4fbqkgCB5ZXswi5eREs52t
 Qzl2LKFEOgCIdwH120xbdMT9uHEz41kxwBMtAhvWyTSc0t9CCrPWr6AgcsSrH7aTW7ml867aWDC
 KfWwPOM0KpjxZeXaQTg3q7Ld99DzBX03n2SClXweIO12mjxjctpEzWQ66ss=
X-Received: by 2002:a5d:6c6f:0:b0:38f:4984:d968 with SMTP id
 ffacd0b85a97d-390d4f3635emr3531129f8f.10.1740584978629; 
 Wed, 26 Feb 2025 07:49:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGx9hvXebBugQgujjJZF4muoSIWi2hiFbIsB5A6UXUBKiIxvxiXVpmeZKOFTPnBwmU6ZDbNSw==
X-Received: by 2002:a5d:6c6f:0:b0:38f:4984:d968 with SMTP id
 ffacd0b85a97d-390d4f3635emr3531114f8f.10.1740584978318; 
 Wed, 26 Feb 2025 07:49:38 -0800 (PST)
Received: from ?IPV6:2a01:cb19:9004:d500:a732:5611:7f59:8bb3?
 ([2a01:cb19:9004:d500:a732:5611:7f59:8bb3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba57145esm25715075e9.30.2025.02.26.07.49.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 07:49:37 -0800 (PST)
Message-ID: <bc8f4c3c-9beb-4660-a0fa-0aef7fde8c07@redhat.com>
Date: Wed, 26 Feb 2025 16:49:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] vfio: Restrict to 64-bit host platforms
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>
References: <20250226084721.232703-1-clg@redhat.com>
 <Z78ew0NSNMNmcM0W@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <Z78ew0NSNMNmcM0W@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hello

On 2/26/25 15:01, Daniel P. Berrangé wrote:
> On Wed, Feb 26, 2025 at 09:47:19AM +0100, Cédric Le Goater wrote:
>> Hello,
>>
>> This series avoids compiling VFIO on 32-bit host platforms where it is
>> not needed.
> 
> If it was previously enabled on 32-bit and was possible to successfully
> build & use, then it needs to go through the deprecation process - we
> can't just rip out features with no prior warning.

well, x86 32-bit was the host platform I was not sure about and Alex
confirmed it worked. We would need deprecation for it I agree.
  
> In any case this recently merged:
> 
>    commit 6d701c9bac1d3571e9ad511e01b27df7237f0b13
>    Author: Richard Henderson <richard.henderson@linaro.org>
>    Date:   Mon Jan 27 16:22:24 2025 -0800
> 
>      meson: Deprecate 32-bit host support
>      
>      We deprecated i686 system mode support for qemu 8.0.  However, to
>      make real cleanups to TCG we need to deprecate all 32-bit hosts.

oh. I missed that. Great, at last !

> so 32-bit host support in general is nearing end of life. Given that,
> I don't think we need to further limit 32-bit host for individual
> features, just let it die all at once.

yes. Let's do that.

Now, I have to look more closely at those patches modifying VFIO for
32-bit support.

Thanks,

C.


