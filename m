Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F1B9CDB471
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 11:52:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcM9q-0004Is-S9; Wed, 24 Jun 2026 07:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wcM9o-0004FL-S3
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:52:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wcM9n-0001za-GR
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782301958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4h4Xdi44Ng4EJRiUfDjYU6MeDGPjtcioVAHRbWOPb2o=;
 b=UOzNIdYQMlJ3Lq6sgsxKfSKbfNtVfhAt8bndcWzcv74GShD7Qz0xbD1mHF5inJ4euSVrtM
 RDxQ1fGrb0GZFGwqM8C+ZloOLERu3Su7H0qj9E06kFKPK8I9S+ANZdaHUsSAPx8sDW4ZpR
 KUkudxYsQf0+9eqh9ZrXouqlCZatmf4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-W_3Yv0ekM72GxaL_3kUuIw-1; Wed, 24 Jun 2026 07:52:37 -0400
X-MC-Unique: W_3Yv0ekM72GxaL_3kUuIw-1
X-Mimecast-MFC-AGG-ID: W_3Yv0ekM72GxaL_3kUuIw_1782301956
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-46ab0ea1f72so764590f8f.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 04:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782301956; x=1782906756; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=4h4Xdi44Ng4EJRiUfDjYU6MeDGPjtcioVAHRbWOPb2o=;
 b=UPU3jMNrtWpgzRXCzreJ0QzNSXoT3bwFv8N5p7FIAR9xxFTyz3jlvJm82EordrDOE0
 az1d1D1eneFDQS5W/rsvzCwieHY1LVMsOjlaj+z632Lj8iA7nEMcNQgqor+zQE/JO9v/
 gImSmV7pqCfBZRH8Qwpcvv2INnpbItr/B9SbjrrCRqd1YP2JD3VEwIkAFSScUMPeHkf4
 ZY0Txv7weiwOdgIfZc+iv6pWr0hWG4gu0TIhhOiZvJRrWbW1NLF++WpBIvx6O1lomIHv
 0G8HQSEXl7VAvOW3MrLFfTAeRFtI16oLm9O+2ZKyHFCO2go0GkZ2zcwqj9jbqBGXY3yl
 zcDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782301956; x=1782906756;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4h4Xdi44Ng4EJRiUfDjYU6MeDGPjtcioVAHRbWOPb2o=;
 b=RCvgvWlIFEqVXNLMXjok5dtETRSuB+urgU1itZElKPjggmq95pIiBZAz5vO/L4dBc8
 9zZCfk8t/fXdnBYr1UfxVi07EUjouLVxyg1iOLMr+KGwY4u6iT+5lqrdezkI/BIHDwhg
 ehPfBvS2SAZpr+LGFtpS1kFIEPsmgyJ30eISEkCAr77qmB4xHwVfsehrvU+Y1CE0DKpV
 pg6FWZlvuxY1a8QsUqT7u7DzMkE6ORUeGwsle05glLuy3UEW3xNFkqTGVVVR4Oob3AVr
 OGm307g8Y6z+Z7mKM94G932rn5H/WbBJec3p3soK7/sH121SDP5B6K/AMPpuyn4vZKoL
 rQEA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8bwI9dWvhUHHMApF/gGrIvhY0oiih4w3it+Ap+K1xIDDFa21mc/uU6ln9WNYZeQWZQtMC/UKyORllE@nongnu.org
X-Gm-Message-State: AOJu0Yx/xE8Vi+/S0OvYyoZ7SSedjA28sUI7d1CbD6UfTuvBWgHbCwiL
 Vt5EYXKwxt1zJLlM0ByVzSEYB+zVTTs53BS6RnZ1zWVO6wANL1c9AQUISRZjpMl6T2v+y4786M7
 R5FGiLxJ9fssvhnrfLBAyBpbB7swdf5G/H+3yTroa42HLipzXOHTgsPi7
X-Gm-Gg: AfdE7cnUC+NRbI48Hvg+YNbmnn35GJUMv9EAK44LP/fU+KwqqgxN4ACPJY9T27vyEdz
 xPWKVHkcazFc1vE+5gik0IOc9HQb7rWBaxZdUvGJGtVlKtHKgDJnsZitfGKSxzLn6qqtsPFAZsv
 kS228OvYW/26lNXx1GOG5MT8OgBoZpTsfAdU+cEWuPVPaGfy1tsfUD0Q4ifQxAuOJSPfReqQfMJ
 +TiTDu3dw+uIYy3HmkrVY8CdAJtc800zMgOMGxpzxAwvtJcXcAxINVjfbCTLoOCprP+UOqYB/Z6
 F/KNNtKueEV8CZnHvfwQEa4ZJhismmQ5D79wkzMFJEeaB6Dpw+HOuY2fRDCTuqzdjAEjVWag5oO
 GGHksvGBndNjCf2v4o+BTxE1lHu2PjSq7EEMpIqZIp9uLCOBpKw4karc=
X-Received: by 2002:a05:600c:630f:b0:492:5145:f054 with SMTP id
 5b1f17b1804b1-492608785a1mr44617905e9.26.1782301955833; 
 Wed, 24 Jun 2026 04:52:35 -0700 (PDT)
X-Received: by 2002:a05:600c:630f:b0:492:5145:f054 with SMTP id
 5b1f17b1804b1-492608785a1mr44617225e9.26.1782301955317; 
 Wed, 24 Jun 2026 04:52:35 -0700 (PDT)
Received: from ?IPV6:2a01:cb19:8426:ae00:2b21:b1ac:81f4:97b6?
 ([2a01:cb19:8426:ae00:2b21:b1ac:81f4:97b6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923ff8a9e3sm482795255e9.14.2026.06.24.04.52.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2026 04:52:34 -0700 (PDT)
Message-ID: <8bc75e1c-8f4a-472d-9265-c9cda0681a09@redhat.com>
Date: Wed, 24 Jun 2026 13:52:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] MAINTAINERS: Add self as maintainer for PowerNV
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 devel@lists.libvirt.org, Misbah Anjum N <misanjum@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, kvm@vger.kernel.org,
 Gautam Menghani <gautam@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>
References: <20260623141933.577981-1-adityag@linux.ibm.com>
 <20260623141933.577981-9-adityag@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260623141933.577981-9-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

Hello Nick,

Are you still active on the qemu-ppc subsystem ?

Thanks,

C.


On 6/23/26 16:19, Aditya Gupta wrote:
> Add myself as maintainer for PowerNV machine, and remove the
> reviewer entry
> 
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>   MAINTAINERS | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 93df53d87f63..67f65bff3913 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1646,7 +1646,8 @@ F: tests/functional/ppc64/test_tuxrun.py
>   
>   PowerNV (Non-Virtualized)
>   M: Nicholas Piggin <npiggin@gmail.com>
> -R: Aditya Gupta <adityag@linux.ibm.com>
> +M: Aditya Gupta <adityag@linux.ibm.com>
> +G: @adi-g15-ibm
>   R: Glenn Miles <milesg@linux.ibm.com>
>   R: Harsh Prateek Bora <harshpb@linux.ibm.com>
>   L: qemu-ppc@nongnu.org


