Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82066C9EC62
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 10:21:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfF35-0002iP-P8; Mon, 12 Jan 2026 05:21:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfF32-0002h6-Sw
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:21:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfF31-0008H8-4D
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:21:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768213277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wSQV1Kw2hEWJNqOG0YIXw4aabSzKvD2CWOqUeOzaLo0=;
 b=GvgH316ZXoj3nBgd0G7l4Cw0tD6GU129OYjHFL1f/05wxtUJl/JhbyLL70od0bHrqysXx9
 MZZE8fWV7McM4WyzqObSQhVrX8DriT38uHK0EIMesPT5hUo40UHFKKQDYtruSs8bMo3sVe
 XI6ojaXKmal2vIK6Id0li0buwIdSBAg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-p6vjF_NbPcCcm3c-4dbc3w-1; Mon, 12 Jan 2026 05:21:15 -0500
X-MC-Unique: p6vjF_NbPcCcm3c-4dbc3w-1
X-Mimecast-MFC-AGG-ID: p6vjF_NbPcCcm3c-4dbc3w_1768213274
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47a83800743so25185915e9.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 02:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768213274; x=1768818074; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=wSQV1Kw2hEWJNqOG0YIXw4aabSzKvD2CWOqUeOzaLo0=;
 b=rMVV3G/JBss0fCZB6HbUca9nTr3Mt/VEHCHzoIMoa+jZaNo/ljkaxmxa/pwMNwPn+7
 ZbWgWOwmKXG+bCYliARrf99AQyIi4C81EwS8kWcbv0NKvE2bfmW40HE8KemFcYQpMSeq
 cF9ilaO8Oo0Njdz3ioQtN47UWjE2kWD/Yf0OUUsLrhtqSt0SOQk8XlHfd1lBOAv5HydG
 MYQX++VnIqSomhG/uABUoRU8VzceCregVuuzK8kiCy8iUhrKOCpvjm0rzlH/luOTGtie
 LMUFD6t5IPqymdADQnHrz7CAsBGwnoQyf+1Blicv02PTp2ZcYv+rxVvqI5pqj5IWdkeH
 9+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768213274; x=1768818074;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wSQV1Kw2hEWJNqOG0YIXw4aabSzKvD2CWOqUeOzaLo0=;
 b=fGjnCQO267OYrgFdENE86nra/YKtR5k2Lc+Upgx4dQv7UwjiWvYVKJPf0HZk7Fg3Fk
 p80PRiUQimk3rBdYtghRNxM+57OdtKNV1E3ekDbZsvjKereSvGIr0yZcSC39+m8XeBDv
 VfkJqEeqFPZ8TJnMtgWoCEHcJfpowOkek2xRr6dv1pFbhoKfY52Vtp8i4iLq8Dkl//Ji
 MO5x86YbcibUt7drBSTCS3rOR/2Gu32iSgrE2vZIaSHkBXn3LTq3nGUbzwWPPR8t1WqP
 tUJPnD7H3zhqjBVPzYJPsxHzvmY0vdLxjnzdPHhfqI0eFwGqH6n9ttWTPDZ0QlLAHtPy
 z8mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX56hIhYfMfktVswLrahGMzZClMd3h/BzSDKiedRdxo/3Oo2WgyzDaizIjK1FQv2/+Ngal0NSm73zwp@nongnu.org
X-Gm-Message-State: AOJu0YySqrfHus2F0XyYF+xiMbg66J2gMdqQj/nS6j4yVyQtJfq7OO0a
 QLTKWVqAn2PfEDlXwbqXMfR02xzbVV6eMC4pZb45IUfXbB0uk22t6Z/3dNaNElvyMWQwX/a2EmY
 daptta6nibLChl82ROmLpONAU84QR0IOAT1Df8XrbZlTmfhcqjbAL+Er9
X-Gm-Gg: AY/fxX6ppURZ0dryQvhqHdCXVHo/dapQcrpMU3ng1NdFHP+pynlau70IVFm6KXT58ZQ
 zYzfzhSLSwhaZ6roSXya2Jsm3tUSM+SHP4p5LJlf7BnUy9Uzjidd2hspKrVApRP6SVniwVAZUhC
 ayi5mWCmpr0Is9D0vjqH8X55sZGuDInrl6epOAErXYRysbyvVOe01JpnDwJfIBEtlGkvHbtwaBP
 Y26aeATbVCK33Y9Qcz+0hpWeS11wZZLHFEFEC6Wul+p22RcrOHQUCRcC8A1y92jaw4WawGxa7nw
 BFpXlphIrivfbMwXQwlF82Qr9GO75Y9xI4zUz3flJPAfSaXIOWGxJ6Uz5YIUP4Ul//CDZI2x8jN
 0Ck1gdac=
X-Received: by 2002:a05:600c:3b05:b0:475:ddad:c3a9 with SMTP id
 5b1f17b1804b1-47d84877e51mr211485385e9.13.1768213274089; 
 Mon, 12 Jan 2026 02:21:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0xeQsgucUhTBKccGwBZ9VozkHlTAS1qJbh+/W8swyQ9QSsG8tOb+6X/iD8DdXt9oxBmuC1w==
X-Received: by 2002:a05:600c:3b05:b0:475:ddad:c3a9 with SMTP id
 5b1f17b1804b1-47d84877e51mr211485015e9.13.1768213273659; 
 Mon, 12 Jan 2026 02:21:13 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f69e802sm352902575e9.8.2026.01.12.02.21.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 02:21:13 -0800 (PST)
Message-ID: <e907e8c8-8ad9-457c-a047-3ec0fd0a65c5@redhat.com>
Date: Mon, 12 Jan 2026 11:21:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/29] s390x/diag: Introduce DIAG 508 for secure IPL
 operations
To: Zhuoying Cai <zycai@linux.ibm.com>, berrange@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, brueckner@linux.ibm.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20251208213247.702569-1-zycai@linux.ibm.com>
 <20251208213247.702569-11-zycai@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251208213247.702569-11-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

On 08/12/2025 22.32, Zhuoying Cai wrote:
> From: Collin Walling <walling@linux.ibm.com>
> 
> In order to support secure IPL (aka secure boot) for the s390-ccw BIOS,
> a new s390 DIAGNOSE instruction is introduced to leverage QEMU for
> handling operations such as signature verification and certificate
> retrieval.
> 
> Currently, only subcode 0 is supported with this patch, which is used to
> query a bitmap of which subcodes are supported.
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>   docs/specs/s390x-secure-ipl.rst | 18 ++++++++++++++++++
>   include/hw/s390x/ipl/diag508.h  | 15 +++++++++++++++
>   target/s390x/diag.c             | 27 +++++++++++++++++++++++++++
>   target/s390x/kvm/kvm.c          | 14 ++++++++++++++
>   target/s390x/s390x-internal.h   |  2 ++
>   target/s390x/tcg/misc_helper.c  |  7 +++++++
>   6 files changed, 83 insertions(+)
>   create mode 100644 include/hw/s390x/ipl/diag508.h

Reviewed-by: Thomas Huth <thuth@redhat.com>


