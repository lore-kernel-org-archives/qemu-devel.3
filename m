Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C35C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 15:27:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9mra-0006TK-08; Tue, 29 Apr 2025 11:27:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u9mrX-0006RH-OE
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 11:27:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u9mrU-00054V-Tw
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 11:27:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745940422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=m2YesfuqY8LGVI05y0pc2eGoP9q9PgR/6TUIPZbm+f4=;
 b=fjSECIHIM50iAxKvoFF6TmQhc7OJzZ+YwIIIOqFKyzp2Ko80tKWyJo2Qy3TZsxN3WzoEQE
 64TcaiTScfZRwlclKy0zZQxSXmbExeGUgtYF5Ks6i1ZesGwGEKofZFgImhiTztanpA3e3p
 OvLoYULu+Gth5Wl5U6wkMLJEGn2Lf2Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-JJmcjGhMNaSqfs6ulDvF2A-1; Tue, 29 Apr 2025 11:27:00 -0400
X-MC-Unique: JJmcjGhMNaSqfs6ulDvF2A-1
X-Mimecast-MFC-AGG-ID: JJmcjGhMNaSqfs6ulDvF2A_1745940419
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-440a4e2bad7so17418985e9.0
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 08:27:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745940419; x=1746545219;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m2YesfuqY8LGVI05y0pc2eGoP9q9PgR/6TUIPZbm+f4=;
 b=ujBSMAw0SLnHl5gUSqvQDNBYpW8Uh39SOlOAHMz5tQjLzJQb+Omq+QmFcr3MgBTp/x
 ENQqx4HQgRNAaVGtbvsUkj+7I/Adp4BLxfaIF6Xa9RKEekpZHeX+2jA6btxYsgvBq/bS
 E67v2VaXlxuCl/6J7nRpzMmK/R9Mk7o/OdVkonCfp+lNOhebj0XHAXl4pNxdobBMJYYb
 1gKgylsvJ1BSvWR5T7LNKEGvFXDi4oCr1no4z2afSbSLaQDBIKwjdjn7CYVLQkd5sZbh
 LKyBh2lgulSJ1g/ay9Bj3ei4JUoAXkQJutGZmH/FCoXlNNLVPtto4XwgTdlWkgtOOYLc
 WbBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzlLB/YpFU5EACwDLHYgub0UHlbtKsSIKz7VivHz9Atrs4sTPoFYVsrzUNQgMQs6By6UH4PVDm6TZP@nongnu.org
X-Gm-Message-State: AOJu0YzFrp215HSAdh8AommUU9hOKDZWE9vDL33fAePZsHSdOLPY3sXY
 kn0UB26u52cLhufqkjZq2nneiFHRfh6nFtG9wwOWhaUi7gcs//+IIxEQY4ZahYyveMPyJs1aKQT
 3IRar5kWCjf0R8y1kIaNolNYxk5a6zOLe0KADjXqgrmBvcCSwpXiCAIw5PLYH2+I=
X-Gm-Gg: ASbGncvCrVj7bxsxT5bgXU4jggY+nPxDuZfQIBBu4lFLoQtkIjp44gbVCmT2kvgx8kb
 DJRsUX2Fyny2Xx0Of4GT8rtmUOpKxp82pOT4Blgo8bqNDw3DQ6xdwdNfrOleiFGyw+B8tOS40Jg
 6d3ixKBAMhK2SIq2IaZqksH3R2hwKhcdo9/FgEpNqLuIQbJydu1pUfvg+Ce4831LVNDxfNwdhju
 iR7tnErAqtGd7WPmIxb9k4RqFxAI12J0qivN2FKpoNkk3KvX67sskJTQ91d59UtdXFC3HT2U35/
 J9wgPtGaj1CeWSJ6PfwSVl6WYAVPhwLj78xEsTtf
X-Received: by 2002:a7b:cd8b:0:b0:435:edb0:5d27 with SMTP id
 5b1f17b1804b1-441b0284ad4mr5657885e9.9.1745940419388; 
 Tue, 29 Apr 2025 08:26:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCZG6/YLjYd4Bephv55QRAP/a91Q/sRkvalZj8W5L7EMkz/j4GoHPZDzBa1xeVhKuUNMHypQ==
X-Received: by 2002:a7b:cd8b:0:b0:435:edb0:5d27 with SMTP id
 5b1f17b1804b1-441b0284ad4mr5657685e9.9.1745940419028; 
 Tue, 29 Apr 2025 08:26:59 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-87.web.vodafone.de. [109.42.49.87])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d2ac079sm192894405e9.18.2025.04.29.08.26.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 08:26:58 -0700 (PDT)
Message-ID: <88e2d90b-5a58-4fa9-a98c-21fc29ace779@redhat.com>
Date: Tue, 29 Apr 2025 17:26:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] include/hw/boards: cope with dev/rc versions in
 deprecation checks
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 devel@lists.libvirt.org, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20250429131526.1842130-1-berrange@redhat.com>
 <20250429131526.1842130-3-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250429131526.1842130-3-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
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

On 29/04/2025 15.15, Daniel P. Berrangé wrote:
> When VERSION is set to a development snapshot (micro >= 50), or a release
> candidate (micro >= 90) we have an off-by-1 in determining deprecation
> and deletion thresholds for versioned machine types. In such cases we need
> to use the next major/minor version in threshold checks.
> 
> This adapts the deprecation macros to do "next version" prediction when
> seeing a dev/rc version number.
> 
> This ensures users of release candidates get an accurate view of machines
> that will be deprecated/deleted in the final release.
> 
> This requires hardcoding our current release policy of 3 releases per
> year, with a major bump at the start of each year, and that dev/rc
> versions have micro >= 50.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   include/hw/boards.h | 33 ++++++++++++++++++++++++++++++++-
>   1 file changed, 32 insertions(+), 1 deletion(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


