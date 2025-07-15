Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18746C83F21
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 09:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubbf1-0001Zw-H8; Tue, 15 Jul 2025 05:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ubbe6-0000lL-6Q
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:08:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ubbe4-000651-8A
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:08:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752570494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Z1FTcAaRxrcihRjNxxra+1Krnrhif/bVlHeoLRWDRp8=;
 b=g7m0TF3gPGWM6s9yFmo3dKFTvfTfRIVqNrEeBVCvlPz1bByuO3utHn6Izi7lI3Yg8O/L5U
 Zn9rNEcfC7tBfc7rrwR1EHbhwg5mRniSx3gCoUgsqrSVibYQP95TCoY9lwP7t60R34IyYv
 806GAXa0QfmpADqr4v3uS6R/7raamTQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-qevNe-hcM3OmDzuP7cVB6Q-1; Tue, 15 Jul 2025 05:08:13 -0400
X-MC-Unique: qevNe-hcM3OmDzuP7cVB6Q-1
X-Mimecast-MFC-AGG-ID: qevNe-hcM3OmDzuP7cVB6Q_1752570492
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45600d19a2aso24622905e9.1
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 02:08:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752570491; x=1753175291;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z1FTcAaRxrcihRjNxxra+1Krnrhif/bVlHeoLRWDRp8=;
 b=Ip0MOCFVIi2B5VcyWMUzG1dg7udnEmNYg1fwFoz8a3n8nRNgdcS2d1sEWmENOwHEup
 nzYo93xKsZRYc18JZuO85rWF5kNozn3HzvGoH9RkHn9rpl661MsF6g0I2YmOrEqJgEvL
 ad6fmRsMxQi228a2qpNLcc8hQH2bgonCYqq6jlaAI8x52di7NCvh/uZz4HS6IxaAIvTw
 bGagPpzl1PfIljpPUbGoZZDGPyt6D5w3jdq2HwtxgPhuGcpTS/LG5rstO8ja17Gq8IGs
 aZ9hyY39cMrIFqewRjTkx0HzJrZptv5WmUJl8LtLfeq0atnbf0wQC2QpoiOLRlkFyglq
 vWTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWX6CWDIVVH302GM0VUsaxvKCSsFWN5Pgsnh+4rmDI78PELWlQTLSVBzbymXtcV4IkXv1WrrRpjeJG6@nongnu.org
X-Gm-Message-State: AOJu0YzfbVA0WxJC2VXzUTz7iJ/GGJshUE1b5IkaQZJcYZiR+U7uxmZi
 F5OGF1THgeSfjwnqdzVvdGIwDcuYydv25HE7I2j16rhNkam3MZhhL6hZpl7CZPFqUiOvHCpWyvn
 L2swslEOeAUlRLu2WhprqRC+M5/hnSHquq+yTOGPsHNQS845RpHdN/ch3w66dlQt+
X-Gm-Gg: ASbGncsqS/+RZvN1uv+JYFGl5TglpQoYPSYpYNEiBXyvIEPFWr34fWBmu8oKPpwxUDy
 q9NxfqomVJG+7elEccs7TnFB0wmorBTel3Z1Hf+32UjuxFTcI0DE/gmFVM1fo3q1OZbwxEx8Lfy
 pSuJDm9K/J5PU89hJDdS2abozqlJfwaHUxKHfn024erWyd79xKi11Z3LMOo9dmGDGbdbEW3yKkB
 QFeAjVvKv3rP16QgBiNFIZf+IQF6MSaS7SgdnZ9nbQOOyo2gNg1ayGvhanWgpTZzC3ttuwiVjp4
 d9XpNJfTYPOXueuv5ryP4JKPrhG1lCDRaOF/4ZaDnlxGyilfowQP1+c4tWFUz7vJ2n+CexVUkzQ
 =
X-Received: by 2002:a05:600c:8b84:b0:456:28d4:ef1 with SMTP id
 5b1f17b1804b1-45628d40fdcmr12094935e9.29.1752570491117; 
 Tue, 15 Jul 2025 02:08:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6XgWP0ZYwhA0EZz5QwDDfhd0iU6QCeZYfIUuSEK2pF316w7E2SB7V90WcK6pmp79QdA0ouA==
X-Received: by 2002:a05:600c:8b84:b0:456:28d4:ef1 with SMTP id
 5b1f17b1804b1-45628d40fdcmr12094565e9.29.1752570490635; 
 Tue, 15 Jul 2025 02:08:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:266c:b13b:afd7:40fd?
 ([2a01:e0a:165:d60:266c:b13b:afd7:40fd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc2131sm14296320f8f.29.2025.07.15.02.08.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 02:08:10 -0700 (PDT)
Message-ID: <66037870-933f-4164-978e-3b92fa76b508@redhat.com>
Date: Tue, 15 Jul 2025 11:08:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] vfio/migration: Add
 x-migration-load-config-after-iter VFIO property
To: Avihai Horon <avihaih@nvidia.com>,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <cover.1750787338.git.maciej.szmigiero@oracle.com>
 <22e94f25448f9ff42b84c84df3960c4ecc94cbdc.1750787338.git.maciej.szmigiero@oracle.com>
 <6b85f85b-51e5-4e6e-9c78-788d9118ad9d@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <6b85f85b-51e5-4e6e-9c78-788d9118ad9d@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/8/25 10:34, Avihai Horon wrote:
> 
> On 24/06/2025 20:51, Maciej S. Szmigiero wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>
>> This property allows configuring whether to start the config load only
>> after all iterables were loaded.
> 
> Nit: maybe, to be more accurate, mention that it is loaded as part of the non-iterables:
> This property allows configuring whether to start the config load only after all iterables were loaded, during non-iterables loading phase.
> (We can also mention this in docs/code comment)
> 
> Anyway:
> 
> Reviewed-by: Avihai Horon <avihaih@nvidia.com>


Avihai,

Have you had a chance to test this series on ARM?

Thanks,

C.



