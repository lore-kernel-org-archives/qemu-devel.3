Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 829D3CAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 15:57:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1oKj-0004SN-Qn; Thu, 25 Sep 2025 11:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v1oKh-0004PU-Ib
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 11:56:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v1oKX-0006xZ-6I
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 11:56:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758815778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qAYLdPhM4/R7SIDyDjB/upk8wCIDVYGEUwRdxuqLihQ=;
 b=WanfDUulYzO1F06x+1OLbePA2TNPp7IkPgqKRb1oCOA53B+ONaxczMBWBYv8cHGgFHu2Nm
 0B81S2cPvhFOJpTNtaneRYA0xvxRnVAgTP4TgBu3Q4Rwr/yXikXacKJFkaZAXdwQibcS7j
 Mqb5wT6o28LV4j2HvmKHhMgyyEKfgbI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-kTvOyIHSOCuPfFjsg974-A-1; Thu, 25 Sep 2025 11:56:16 -0400
X-MC-Unique: kTvOyIHSOCuPfFjsg974-A-1
X-Mimecast-MFC-AGG-ID: kTvOyIHSOCuPfFjsg974-A_1758815774
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3ef21d77d2eso712726f8f.1
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 08:56:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758815774; x=1759420574;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qAYLdPhM4/R7SIDyDjB/upk8wCIDVYGEUwRdxuqLihQ=;
 b=tzjWQUdLOSyWzgK19vGN3M2Bad+R/xw3Q4sh50POLfx9QZdS01lqKa2cCyBV5703BK
 l17Rk73kWcE4fx4u5HChgErUpWMXGTytCiSFVUa4YWIDDLkjkfX1YEkuck8oy+UUzcAk
 IOuHoCFdwzVYnK1xxXMECyXCHgfd9GBOr1XUm9QYSFEvKxuQ6ZSwCU+wXlqh/h+ghBu6
 LNL+rnKsMkMw2UsAerlp6lL9tVtxwCijsbz8AuV9NXLXql4jU0ZPlpAON5xKAQnZIrNo
 Qf/f+qQU5Hi3VdEtRt4vfqJf2bD1G5//E5O+RnODOGqCO/vvxbnoQf04VCusLTB8xxGm
 WsUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdhWe4+xyU1fon6srCBp7J9Ypw+x3ZeDCBRuQfnQd8TZITnvq6OhktcyW1+vvLAi0LM1juSkkzwtCJ@nongnu.org
X-Gm-Message-State: AOJu0YzW/FP61u5xX6TSSUBxGNJBPu8jozROjGXdumeG9hmLWBXvODFZ
 xqLaqMtjOBPOGOfVkLWEzAJb0sCkSEAcLQ5+/8uS40dDdeF8d2c5NkN+3kMlFc/3ljv9N0gZ22i
 Qec4FGNyUZ81OYKSj7YDZ4b7CkMuwfTYqAaMyG6P7f5ru17aGml/3xahw
X-Gm-Gg: ASbGnctdGxMJkQpfMfkJfFGqSRazdYQb1vJBhjzKkA+c2jIoZngUDZJ6sk9lhOIUdVT
 aziUM4h93RioxVszp3/U9nTs7LjAsDiFUo/NSpMUGrQOQRUq7ar4ttlBgkljJORQ5ZPFgCdA69j
 UK9lq28vFzh+OahdFmqnwkoITOmi/0NKzniQTxAUqIxWj/o/Noag1NUZnv4IKBjNgrxkmIeCrht
 +OZxF2jY5UzGnsS+7GkSmYVahlsDh0oT7jIx01MH6MnoRLZ4V2G/zPT3ViYTM/cQsU+hDFYuFk5
 DGC9Zywz4twFvHc8Zg9pRgroWivtfpvR0CCGzcOUakqRYmHF+PlsbO1ZReOJ3H+Koq7PwTjY9o+
 v/eM=
X-Received: by 2002:a05:6000:400b:b0:3e8:9e32:38f8 with SMTP id
 ffacd0b85a97d-40e44498167mr4356174f8f.14.1758815773860; 
 Thu, 25 Sep 2025 08:56:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESuM6yzhcH7fPikUaQnb/3PCXVFypBo/ho+YN0D4qSHBmPhw3KwzO8330CFk4EB5iAIL810g==
X-Received: by 2002:a05:6000:400b:b0:3e8:9e32:38f8 with SMTP id
 ffacd0b85a97d-40e44498167mr4356149f8f.14.1758815773491; 
 Thu, 25 Sep 2025 08:56:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2a996bf1sm83163665e9.1.2025.09.25.08.56.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 08:56:13 -0700 (PDT)
Message-ID: <af515d18-01dc-42a4-9d9c-320c1d7c9081@redhat.com>
Date: Thu, 25 Sep 2025 17:56:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] tests/functional: add a vfio-user smoke test
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
References: <20250911210905.2070474-1-john.levon@nutanix.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250911210905.2070474-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/11/25 23:09, John Levon wrote:
> From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> 
> Add a basic test of the vfio-user PCI client implementation.
> 
> Co-authored-by: John Levon <john.levon@nutanix.com>
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   MAINTAINERS                                   |   1 +
>   tests/functional/x86_64/meson.build           |   1 +
>   .../x86_64/test_vfio_user_client.py           | 201 ++++++++++++++++++
>   3 files changed, 203 insertions(+)
>   create mode 100755 tests/functional/x86_64/test_vfio_user_client.py


Applied to vfio-next.

Thanks,

C.




