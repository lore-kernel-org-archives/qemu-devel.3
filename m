Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4162CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:50:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgEs-0000L0-2W; Thu, 28 Aug 2025 13:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1urc6Y-0001DG-SU
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:51:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1urc6X-00080m-C1
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:51:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756385507;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4S1oH5XEC1cWvETWWJ5LtYxybZWNTrEDO/B1jMqo/B0=;
 b=X6POX8LR7yjWEfdL5i4AsYtFll+YnFOjs7hg5B9Xyb2lWeGZBNTHTxitAIDJsFYmoU3DVg
 Br5SRPDgi44TAU/z4AkOFXqOGORhcDGRQteexh+YaISwqbpmZlxi9V+Rg66DpWmI4ZSELP
 3p/9Y129k9MWFrTFkEBLq4TWtiBFX+I=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-xxKpqB6DNk6PlFGRw8ozKQ-1; Thu, 28 Aug 2025 08:51:45 -0400
X-MC-Unique: xxKpqB6DNk6PlFGRw8ozKQ-1
X-Mimecast-MFC-AGG-ID: xxKpqB6DNk6PlFGRw8ozKQ_1756385505
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4b29a0b8a6aso23485461cf.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:51:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756385505; x=1756990305;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4S1oH5XEC1cWvETWWJ5LtYxybZWNTrEDO/B1jMqo/B0=;
 b=L78zuXpXiwZ46l6S5EdrirOEN0wqTh6XcYmfPyTVkvjJgAfY2/qHcNwQdx7r7lQwS/
 07Ehn2w5kJIJhcXaOs12+FZdRIcwFOXVqz64l7ZSmGmNCqH6WD1zg3SkN61I5JOEcQzi
 T0IWMFyjOsvxTpO9QQbIIUR0nLK/DnWzAZAGd7BXTO48PlXptaqp9uabZdVdKRYcTr7u
 mdvqA0UdcwsHSJPxGXcKp6i/fMQvoUV903vgsVjkC1aCtyu6oheKAaiGFz41DL7X2jr2
 1OGpG6QjSdMwto/vGX9oSreWdmcSgh2xhtsG7xv4Wk0cFELaJnzR8mx4bY7iuEER3OPx
 zwXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsaAdzWTMFA4vR8jVIn6cZmoiCHvIWYxvxw8cUX+aEqcfbOkfqRNEvHn/32oAhr+rpvXOoVwnjlKtb@nongnu.org
X-Gm-Message-State: AOJu0YybpM+Yn0dwx+F2KKrDKRy7jg61k3XwAg7nFhyIqMZoNzxFV74w
 uWywyjFD7N6rh21ii+dAXvXVFc7oFfdBAF47Vca+4YVxnFtV+hVzpCMBYLE6/mFdEM6QZxRuwJJ
 ZGuUssdrLwxgXBGYl+KncuKI4xdCrOvtXATghhzRkoYmgNQ0L34wDV+0q
X-Gm-Gg: ASbGncv+q46GGeWWWxTrF0ufGIaMwe/5gjg6QzfEU0riMabjwxLUzYfPaxQJWSf4Rg1
 pvLDj9ECGk13o/CXdwBFhEPG/0svt8vN0p6sDQgrrP9HL//yubZvv0QzqfhNZPg+yIkYWQR09Ke
 loNsUQk9Jbuw/l4kG1doy69YPPaxuoDzzbJ48R/R6p4A2cY4MrA3TxBbqGGAQsP83r6mKJ/VgOi
 vB43E4/+X5jC+xrwmCUqEp7sSvh0gVwKgvBQSnjOfhuAbGnoOikJ+NUsf5hocxPgcKfVOiDq7kV
 8PWO3Lg6SQTV0rXXSTA2Q+wCFLdYAAlgCjS7y9RoaQ2f+Z1tvmMClpiBcfg8gWlvRocQHRHqirn
 BYQVMo656m5g=
X-Received: by 2002:a05:622a:1b07:b0:4b0:6b76:723d with SMTP id
 d75a77b69052e-4b2aaa19110mr247336361cf.7.1756385505101; 
 Thu, 28 Aug 2025 05:51:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBVshJyhFBFAB/RLWyIDgXwfy304reW63zfnIowrhs80Bmtf9x3ZWIt8DtAeWkJP8alm+zBA==
X-Received: by 2002:a05:622a:1b07:b0:4b0:6b76:723d with SMTP id
 d75a77b69052e-4b2aaa19110mr247336031cf.7.1756385504682; 
 Thu, 28 Aug 2025 05:51:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7f07c87a894sm846114585a.25.2025.08.28.05.51.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Aug 2025 05:51:43 -0700 (PDT)
Message-ID: <eed9d8f2-ad13-4125-851e-353db20a0d5f@redhat.com>
Date: Thu, 28 Aug 2025 14:51:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 21/21] intel_iommu: Enable host device when x-flts=on
 in scalable mode
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-22-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250822064101.123526-22-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 8/22/25 8:40 AM, Zhenzhong Duan wrote:
> Now that all infrastructures of supporting passthrough device running
> with stage-1 translation are there, enable it now.
>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/i386/intel_iommu.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index f9cb13e945..04a412d460 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -5222,6 +5222,8 @@ static bool vtd_check_hiod(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
>                     "when x-flts=on");
>          return false;
>      }
> +
> +    return true;
The easiest one ;-)

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
>  #endif
>  
>      error_setg(errp, "host IOMMU is incompatible with stage-1 translation");


