Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96046CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 06:30:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9HVH-0007VL-Bg; Thu, 16 Oct 2025 02:30:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v9HVD-0007Uv-Dx
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 02:30:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v9HV4-0003pB-Eg
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 02:30:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760596209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0EbepmDVRJ/bHrs8WIO007Vi+N8MRrEJJTRHH7oii/M=;
 b=UKwHyhZFl3ZPSzo7TQzLqZSJlG4W/xvRMplKZeRvopPT1nT/DXoht2yEp5M6OuXHhjKUcW
 9wJvxGXab89yadTaAPRuXf/Pon7z4H/eHr4ch+QMq2KKqExlFbeNhRIPEc9CxvXFcda/ic
 OTie2yx++GJwpfCJD8ROx9Zx8ndXGOc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-x8s2rXK0OV6P0b1EXMBhNg-1; Thu, 16 Oct 2025 02:30:06 -0400
X-MC-Unique: x8s2rXK0OV6P0b1EXMBhNg-1
X-Mimecast-MFC-AGG-ID: x8s2rXK0OV6P0b1EXMBhNg_1760596205
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-40cfb98eddbso718877f8f.0
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 23:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760596205; x=1761201005;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0EbepmDVRJ/bHrs8WIO007Vi+N8MRrEJJTRHH7oii/M=;
 b=uEHF/fNYvKxv9j59Z1pUVxyEBprv64wgHj/ySzDgrXTQrGvHE1d+c1Bf6HEqjqd2yS
 vtI6K3BeC8UgSKydyw1DIwRlpff278ZxH4jCw0CbM6jaWMeickkN2h7P2NeywIVLVac1
 HhFraRv/s6TZGJ15CBsDdt3QneWWA9V1M1+/Z+POw0yZ3fhCscxihBVUPJKCMNG36B8c
 kqgGB4+Tcr1yqxs5dDGBvnVHMOhT2AS5FXYx9mwhNIcmJhrhEsFlUdyA9MbfTViOoNyZ
 g1FwPSKvdTnMo3fLh0OJUhe18/eXxU6OaaMLZr/VwDuzv2FNbuLko09g/M/6OY4HqMOJ
 4FCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOWwFx5VL0hld2aEtQBUl+gkMguEIbhF5HxuoAJ+ZmvGV0E53GZBE/mqDWwjvzdIAUpDj9IFECo24y@nongnu.org
X-Gm-Message-State: AOJu0YxfjeAHEWfepgFFaBp/+AjwvelFt4fwy2EW/bbrFG8KJ83NTZDr
 ssW3JsHaxsCFck54X8JjAplFjCnBfbktHtvKJrgfXqUQq/CFoyH/3ndh06hHH2W4WPqkvKJtHct
 DGUo+Yf6pQXAf+CCxpnnwXzsb4qL/THf24ZuqZXEqV+meYgZ3btysD3f3
X-Gm-Gg: ASbGnctmQ1JkOVAOunsEZmWjnK5YbOGvzwDvcs25GEEA0rq51BiwABYRr0bE0KWdXj8
 TB8LNECQjcWCp7tunDD1B8OCReslcVlQcLHIV22rWJZ665j4h492V7JWoZKTupjKs9+8XGqtnVA
 00RAB8iFE7PyptEYoxKzlSGxuAUK4vUtaO44/Tg5haMXuHoWxyOE0GPQ42HA3eBeGsmgy7JIdjX
 Giu2mUxUsDWb/OrOooNXmOB1AEucpL8oo+IpFYqHLJPCjQr4+Fa2JgISIFqfPCHmsFE82ak/5CL
 DBtDKGoVDt0Kayzj4eu5xogRyNKMPCFztjFbEq6f2P38SHMB6TGVnHj5uAXmg5aS0nVTUBUmkVq
 CDyqi8k9MVk8MrVYPC+N9Gy2U/2PRC1URU4xTwCMR
X-Received: by 2002:a05:6000:2404:b0:425:6fb5:2ad4 with SMTP id
 ffacd0b85a97d-426fb7bbe2dmr1709170f8f.15.1760596205412; 
 Wed, 15 Oct 2025 23:30:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYEbC9CV80/u8CiQsYP95bDPDJSNdmIjVAbCF37BiIHRK5QjHPKyvbGh3glRy4ZxTPMk4JDA==
X-Received: by 2002:a05:6000:2404:b0:425:6fb5:2ad4 with SMTP id
 ffacd0b85a97d-426fb7bbe2dmr1709151f8f.15.1760596204956; 
 Wed, 15 Oct 2025 23:30:04 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-112-136.pools.arcor-ip.net.
 [47.64.112.136]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426fb279857sm4002149f8f.20.2025.10.15.23.30.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 23:30:04 -0700 (PDT)
Message-ID: <bf243ec1-c4be-4a24-a766-efc0fc41a7f9@redhat.com>
Date: Thu, 16 Oct 2025 08:30:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] buildsys: Remove support for 32-bit PPC hosts
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, alex.bennee@linaro.org
References: <20251015213843.14277-1-richard.henderson@linaro.org>
 <20251015213843.14277-8-richard.henderson@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251015213843.14277-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 15/10/2025 23.38, Richard Henderson wrote:
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Stop detecting 32-bit PPC host as supported.
> See previous commit for rationale.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> [rth: Retain _ARCH_PPC64 check in udiv_qrnnd]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Message-ID: <20251014173900.87497-4-philmd@linaro.org>
> ---
>   include/qemu/timer.h | 13 +------------
>   disas/disas-host.c   |  4 +---
>   util/cacheflush.c    |  4 ++--
>   configure            | 19 +++++--------------
>   4 files changed, 9 insertions(+), 31 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


