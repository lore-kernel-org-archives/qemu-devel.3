Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42689E7E35D
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 09:40:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8b0I-0004oM-QX; Fri, 03 Apr 2026 05:39:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w8b0G-0004oA-Q1
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 05:39:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w8b0F-0001ZO-EV
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 05:39:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775209186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pmuUaCxi7IXvPJkWzlVFo5/l0YEhnQzMvM4An0iU4xM=;
 b=jRB0NcLheZE7aP8m8jhOZfeO88qFBHpIrD7F3SU2cd5GphQrfD507Gz5eDdbbchKoDcP50
 DGio9oJc04TltspfFyfPq8/zil+GbWj3M7S1roFdVdDru2x249fc4hHWsBIzwTiGfYQsne
 wftvRkKfU9HAvaLDPkcSTCiyrsIm6JM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-09NElqNWO9CYNuZZX1QEqQ-1; Fri, 03 Apr 2026 05:39:45 -0400
X-MC-Unique: 09NElqNWO9CYNuZZX1QEqQ-1
X-Mimecast-MFC-AGG-ID: 09NElqNWO9CYNuZZX1QEqQ_1775209184
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-486fb142205so17868325e9.1
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2026 02:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775209184; x=1775813984; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=pmuUaCxi7IXvPJkWzlVFo5/l0YEhnQzMvM4An0iU4xM=;
 b=GzGl4O6g74HSd35er1m++JCvGOvlJ+ML29EIFkH4oxc4gI0dqmWAMcLlzN9hy20K0E
 3RvAvQgLJK31VF3Kroew9H6cMBTZLVFfaTlB7LjkcE0MgNI+QwL52mnWetOmSnIIJCDc
 ooNiS13EkDVI7YZo0gY0q7lNYnDoAtWVHJE0LHZTSbYeJ7ileRXfUk/TD+UZB6ZoZxYp
 K2eXBUPfRI0N8LNNwy9em6iFO6CHMCCtUw1AxMHUVd344mOfnmWSXQS70efCLBjG0OxU
 SnJ9zRWpQqpiS5Mh5YMAsjcpovG3tXogG0ZYUUUt57Jv+HYElmN04xhNeOYBlHBeV9s3
 f2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775209184; x=1775813984;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pmuUaCxi7IXvPJkWzlVFo5/l0YEhnQzMvM4An0iU4xM=;
 b=IzyNXHtyPCzijc8zZln1d2TEex5F1n4/JhNdOyFtF20Sbq0+BZemb92oyFBoD3kmZZ
 zyqjFw5yr0xh4XKKtLaCJOeNaiUGKcWiR9yZzLHKSCD6hSkTBqG+qFf/iP+i04q3MBka
 0XEUyYgfvzNInc+KtDUNfGU7oa3Qm5syCZ81mlsS1V3fjLzNmQiW5NKNS1/xmXPbI67b
 mDG/BrsUPkC1ADsAX7TZ9zDs2+pI/C6i8rGQEbmgpLdyeR+ausFkspysgYlQ58Kkxkh/
 2DC/Bua6dGE9NvmiOKQTVZh2LP0SVKDkOxdMQ3/um82TGseCCKCHVUnuezMXthqxBCI+
 P4WA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV01X0f5TOdxTWlxRKRdsbUN75QWtjBtkML/U4pStExYPO8SBDvkHEVsAiWh14EGJZqmIpd6lNp40ZY@nongnu.org
X-Gm-Message-State: AOJu0Yy4yMtW4wre37eLb3sxE8hbHUsdSaAbM00/9Um/FqQIvSszUQ5T
 Dy7Ju6Dr/YdgvGPJgWHhPMT3zpgEvUP4gBYC3YTaUPwB5tbLhzAsyFW/C9b8F0HX0zKhVdJ5ffq
 o5oGgOkkJZ63uNqJ9jbQuAg6qwxe/5+cWTNiaOCQZbuEpGlyVPj5Mw6Ux
X-Gm-Gg: ATEYQzwXcN+QLTDpEkAOBc0t68Ap7rVz7B/9xTe/sY2mgARzZKj/Bw3TPgc5B6TRyAA
 /gGQybItCVt3Ds2GyDHrUtCp/rn9NEayBAIEKLFFNbZJq3XesW+tU2Ntfr9RoiFr9Y9ktJpxoGJ
 9rMtifNeZt/uyADr4l0Ap8EZJvrzZjpEy9gn4yjhSN7yNWLIkTRZFVeXsYe/Nt/jKkwvuG4CPoa
 lPBGkjaob/oyjLEVFS10Gmh5G9psG1XtUerOxVc1Jy0hlAZkHWRAmDUPhQCn3Vo7LMxMpJ250NT
 cNntRmWTBSJwWSZSj6mbMCAQALpWwAcZ4Wmx8BNk7HU3s/eniGUjYmclAwkEP5AGjNhj9aqrx3D
 6DCfm0+d5b5XyTzDRZUpYa8JYCesqkKLIHeObAkHywpvpeQ0X2jXdARHW09lZ
X-Received: by 2002:a05:600c:4e0e:b0:488:8577:d9c2 with SMTP id
 5b1f17b1804b1-488997bd8f7mr35813965e9.22.1775209183866; 
 Fri, 03 Apr 2026 02:39:43 -0700 (PDT)
X-Received: by 2002:a05:600c:4e0e:b0:488:8577:d9c2 with SMTP id
 5b1f17b1804b1-488997bd8f7mr35813675e9.22.1775209183411; 
 Fri, 03 Apr 2026 02:39:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48899ed9cb3sm15386405e9.36.2026.04.03.02.39.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Apr 2026 02:39:42 -0700 (PDT)
Message-ID: <4567f32a-2a4f-43a4-aa09-fb669cd9e78e@redhat.com>
Date: Fri, 3 Apr 2026 11:39:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/14] intel_iommu: Expose flag
 VIOMMU_FLAG_PASID_SUPPORTED when configured
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex@shazbot.org, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com
References: <20260403035541.18355-1-zhenzhong.duan@intel.com>
 <20260403035541.18355-15-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260403035541.18355-15-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.542,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 4/3/26 05:55, Zhenzhong Duan wrote:
> VFIO device will check flag VIOMMU_FLAG_PASID_SUPPORTED and expose PASID
> capability, or else guest could not enable PASID of this device even if
> vIOMMU's pasid is configured.
> 
> This is the final knob to enable PASID.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Tested-by: Xudong Hao <xudong.hao@intel.com>
> ---
>   hw/i386/intel_iommu.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index abcb0df5d9..3cb8a547c7 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -4794,6 +4794,7 @@ static uint64_t vtd_get_viommu_flags(void *opaque)
>       uint64_t flags;
>   
>       flags = s->fsts ? VIOMMU_FLAG_WANT_NESTING_PARENT : 0;
> +    flags |= s->pasid ? VIOMMU_FLAG_PASID_SUPPORTED : 0;

The '|=' operator is unexpected. Anyhow, the code has changed since.
Needs a rebase.

Thanks,

C.


>   
>       return flags;
>   }


