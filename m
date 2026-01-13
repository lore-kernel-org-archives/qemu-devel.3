Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA15D29DDE
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 07:35:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfYw6-00031m-4N; Tue, 13 Jan 2026 02:35:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfYvz-000301-9F
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 02:35:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfYvw-0007OV-PC
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 02:35:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768289720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xqUJTMuzyZl4pLdelWfnHNDcOFznLyfhrEx3UpHvoF0=;
 b=OaUERy+REWlIycv8jSKlrNHtR5vAFYOKNx0PzZug8ZK+/e0OC4vId3ZAGyBEvXUBaoUrDi
 hxF85l1jufDNPgGgkWl/tJSk+v40o0C4BhcYWX3hkgpIJVmYnQMOdz4lFd4IGH5pCnvVjE
 sGWdxGTMAvSJOOd9aKI2o0nO3dr3VMM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-P91k2nGNPWGnEORmNcstqw-1; Tue, 13 Jan 2026 02:35:18 -0500
X-MC-Unique: P91k2nGNPWGnEORmNcstqw-1
X-Mimecast-MFC-AGG-ID: P91k2nGNPWGnEORmNcstqw_1768289717
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-43284edbbc8so4858469f8f.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 23:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768289717; x=1768894517; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=xqUJTMuzyZl4pLdelWfnHNDcOFznLyfhrEx3UpHvoF0=;
 b=rV2zT22zq8JfO74Zh+vJ/7fEvuGc0kgRsx3nn/QadUaBcEcZKDwgpNfDBKtNo5Lz0X
 giza7/fBjPHx4pGRGC+UDaPLkqzdmIWlGTYpSLEYDf9gEO6J2PXCIJGQNakkU9lNGnFP
 dsRd2X9TmXLvnebb5vF1gJkMJow8ph7/wvArXIexd/OVGQo2zXOTAPcP84ZXRGGrlgJn
 GlKr3gfRvmtJBgpmSh/MlskF6KZLhlrnAkVtn7DefEJMXgmRn73xP2KM+rg5pHRaDHJl
 ETs7asjr9hul3p+jjGc7BWYp1D5SwQsl7uT5Il8NFH0Jp1ESbL/QtjEB1rgC1lCjh1/a
 P5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768289717; x=1768894517;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xqUJTMuzyZl4pLdelWfnHNDcOFznLyfhrEx3UpHvoF0=;
 b=Y1b6I/vVNCQQJzniHZlUKvRzd6uQr9FC8qrfxW69yXqApTDEG7eLgV8OH1YWEt28FX
 VatH1vV1p8RnDbDdCRpxsf0JlcEsp3tcNhcfroj706+dacKWMZOMo4C16FcC79RE3774
 SgtnIe9WsgORgGIJ0LZZsPxOTfhuMVDnS9MLOMGoxYboA9QHPJutlcuKZvQZEmF/O/yO
 IccRLjSSza1LaJd2lE22aRvEnfZ2a3KvqehWfWIg37IQrqU/vbY0D3L1lazYqhlq7kM6
 J4r9PrHg6sr5B51hVdH8hDINCtWYPE4E9gkKthyri+IhI6PTEqjKFOaAWgFEBqpjvCru
 uQ/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWe8MQmkR8KV4GWNVgus8iYscOx4YYqfggsyXPvpCJ/KYLCty2EiBEKqKVcm+D4FAyNJkDF7zmZglvG@nongnu.org
X-Gm-Message-State: AOJu0Yxw8lGtSTWrGf0pZygfFNNHKfXMkMTBRWnfczsbxtdD3EAYm3Lc
 a095sqw+n4zN72x0vH8qVnBjhnk8glZrqtyM4dSLwzVWzIzEnAYI4a2hwKbM4E60lktjDjvzSZf
 D0poR0l86mzYyx++IcLnWX9WulFzVglTpU/GDXm1bnI/uu0qfrOWFMvFX
X-Gm-Gg: AY/fxX4MRY51Yr5aRmrsiqXRsxv7KFKQ5K0AKtY7JUgGdGYwBwXu78TKYzKUWtxhfj2
 63R0kc7pvDUK8U6LTfA0N4HGkX/jcEXHwpPIMVaje6lufi+pU221Nj5klXApHGhnk4+MXJwYB1o
 Hobc6XnS4J7qK0qEB48jwNekOlwLWz8H9FXRjQol3ALfFqsw+annKKiYNKAmGKVqx3iq8YOIC/U
 W4yqXdXBoA0OiQEuNfxxuGBeVbV9PViXOnm+q5MJ8a0Q7PrjxAIF3lE2dtrN/3upTYrss8/avqC
 jIcprme9JkeHBCFJnlgwrWw/cidVqA2v48bbEBPV39lk+fk6HQwp34UQzmZ6n8z0EQ8/QgFva1Z
 r2aU6koxzWlVsUYdh3VBZ02q3fwlVvoD9KsC+lr7vyS6bPCUL
X-Received: by 2002:a05:6000:26ce:b0:430:f5dc:d34a with SMTP id
 ffacd0b85a97d-432c37c8719mr22953522f8f.29.1768289717412; 
 Mon, 12 Jan 2026 23:35:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExlgNZr7E+722gH4ZCvT5ONgU4K+i+73qRxUTLWr+DfQ3WR3Z20lPSvFXhzGnXayH4Ybv8LQ==
X-Received: by 2002:a05:6000:26ce:b0:430:f5dc:d34a with SMTP id
 ffacd0b85a97d-432c37c8719mr22953490f8f.29.1768289716980; 
 Mon, 12 Jan 2026 23:35:16 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e17aasm43143885f8f.15.2026.01.12.23.35.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 23:35:16 -0800 (PST)
Message-ID: <f244815d-a6b9-4e04-970c-9f755df4eeae@redhat.com>
Date: Tue, 13 Jan 2026 08:35:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/19] intel_iommu: Enable first stage translation for
 passthrough device
To: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 qemu-devel@nongnu.org
Cc: alex@shazbot.org, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, chao.p.peng@intel.com
References: <20260106061304.314546-1-zhenzhong.duan@intel.com>
 <a080e728-6754-4897-9531-61b875720b33@redhat.com>
 <4c098753-8db6-4052-a5e5-21d076001776@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <4c098753-8db6-4052-a5e5-21d076001776@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 1/13/26 04:12, Yi Liu wrote:
> On 2026/1/9 22:34, Cédric Le Goater wrote:
>> Michael,
>>
>> Since there are a couple of VFIO series depending on this one, do you mind
>> if it goes through the VFIO queue ?
>>
>> Thanks,
>>
>> C.
>>
> 
> Hi Cédric,
> 
> I have two nits on the series.
> 1) a commit message typo to patch 09, already sent email
> 2) I noticed there are several new files added, while the copyright starts from 2025. will be nice to be 2026. :)

I amended the commits.

Thanks,

C.


