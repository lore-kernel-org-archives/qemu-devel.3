Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E2DCAC59A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 16:17:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzHJS-0002nt-8F; Thu, 18 Sep 2025 12:16:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1uzHJM-0002mr-Ig
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 12:16:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1uzHJK-0002Dm-AP
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 12:16:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758212186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P+7RDzKHBivAqcHdJuW5P+iWGjNZMGSk+E9hgSD0dBM=;
 b=NVSVYUdiRpKdNwfqAph8YtzdItuxo4gOmjflKzU681ZH8ovLpjDLIdhxLm1sUnT8J3q2ev
 VVbglVUSueerRad69zkzpNcgm6MMaY0cAEPxiqnvn8twiwbEL5HNYWIfZ9yyS/uisTZEjb
 mWclGwWxVaiGHoNXb3jyKA9GCBGpFtM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-_PUyd6v0M_-bYaMHTIMaHw-1; Thu, 18 Sep 2025 12:16:24 -0400
X-MC-Unique: _PUyd6v0M_-bYaMHTIMaHw-1
X-Mimecast-MFC-AGG-ID: _PUyd6v0M_-bYaMHTIMaHw_1758212183
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3e997eb7232so516991f8f.3
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 09:16:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758212183; x=1758816983;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P+7RDzKHBivAqcHdJuW5P+iWGjNZMGSk+E9hgSD0dBM=;
 b=TYHfP1tbjCLVtD2fMvLxzXH4sXlYtFHjoiPMptnBAjtMj87Zal2M//CPym24r+k9G3
 9D58wL9XZRKuI3jcBCQ2fWwZHVCViV6HALFsRIV7fQg6T2N7EOcQ0mT01NeEAZjKRSEF
 wiCXCVR8flsL9XkPW5fsRO6u88M3tFYK8oa605WruMIljwSjgN9+TX8pkIwtRi92KHJR
 tW75CR9a0NfZw+SKnIOZEvEezTrH+mfEs3Y2gfc1GwA5Wg5r3N5TYtJXDG0EaHIQpVwc
 si1uAM7hv1Puu8dG4t5DeL8HaMhlGB6QsbTDFBwY0NSB5o3IrJjXmMqeToFhe2miZUrg
 ZwHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6Mkq1YQK950Bev3feGn3USy00KgHQvJQCp9NCkZaFtAbZXPWU/OIeEAFg/Irz7wabDG3vlfcZbTZs@nongnu.org
X-Gm-Message-State: AOJu0YxofG1hbaeEcw/FhKGDeWLSPXBxjtzEiXrXeKMwZqcP+LAP57R9
 OYM7RZoNmgofNvy5EVvZ33Ea3SYHi1nGsITKbFqUQ3onOcdyPhdoX6FK2QGhbdyt3GjMEOnZqWm
 ao6dRXK2hurNKeRupzRJcrG/wO2oFss2gAkU43mnWgi56HapMcAcWaGvf
X-Gm-Gg: ASbGncuZlcae50lJxnCN31yrkCkfRqiAM6JH+UiuJx1vmshc6DrcxfRPNPsv8p9Y2gV
 BfZ4tB0hEShB20hHa4tUCfqML+5ZiCETQFr7d4II2IjKHqrWUiAtWJospezS3R1SCsu16UOlkQm
 mXi8LTI+z2GR5cSJDe/XcqRLYJZT8iOYNp3v9jKin46dWdkoXqxriLLkKv8OrRtE3sniAKPwLR1
 uY1Z6IAyxBVC0HVBUjRV0D/oHRkTYj/L5l0nQiB3OAQ6p/KUpFcwHxLzc2cFOeluXFnP89EkP6P
 CDif77oscsl5QqJFq21Kkl5pslveFDIFS5tSNclCC4tQ9/g/+6ffQyUgDrCVy0D52GU9S+zMKAx
 /nlWzfHkyl0Zz+w==
X-Received: by 2002:a05:6000:290a:b0:3ee:14db:701c with SMTP id
 ffacd0b85a97d-3ee14db7818mr1454268f8f.41.1758212183370; 
 Thu, 18 Sep 2025 09:16:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHObd51+7ee4U9lQAxr1XJX1IY51S8+bxKKKF6IB+xf0nihgEKYWkhELjswfuv969pU0QBCew==
X-Received: by 2002:a05:6000:290a:b0:3ee:14db:701c with SMTP id
 ffacd0b85a97d-3ee14db7818mr1454245f8f.41.1758212182889; 
 Thu, 18 Sep 2025 09:16:22 -0700 (PDT)
Received: from rh (p200300f6af131a0027bd20bfc18c447d.dip0.t-ipconnect.de.
 [2003:f6:af13:1a00:27bd:20bf:c18c:447d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee141e9cf7sm2209971f8f.12.2025.09.18.09.16.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 09:16:22 -0700 (PDT)
Date: Thu, 18 Sep 2025 18:16:20 +0200 (CEST)
From: Sebastian Ott <sebott@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 peter.maydell@linaro.org, Cornelia Huck <cohuck@redhat.com>, 
 maz@kernel.org, oliver.upton@linux.dev, gshan@redhat.com
Subject: Re: [RFC 1/3] target/arm/cpu: Add new CPU property for KVM regs to
 hide
In-Reply-To: <20250911134324.3702720-2-eric.auger@redhat.com>
Message-ID: <0f05a0ec-8b98-a9b7-6e3a-9ef73d0c34e7@redhat.com>
References: <20250911134324.3702720-1-eric.auger@redhat.com>
 <20250911134324.3702720-2-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="-1463806286-295920147-1758212182=:37575"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463806286-295920147-1758212182=:37575
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 11 Sep 2025, Eric Auger wrote:
> New kernels sometimes expose new registers in an unconditionnal
> manner.  This situation breaks backward migration as qemu notices
> there are more registers to store on guest than supported in the
> destination kerenl. This leads to a "failed to load
> cpu:cpreg_vmstate_array_len" error.
>
> A good example is the introduction of KVM_REG_ARM_VENDOR_HYP_BMAP_2
> pseudo FW register in v6.16 by commit C0000e58c74e (“KVM: arm64:
> Introduce KVM_REG_ARM_VENDOR_HYP_BMAP_2”). Trying to do backward
> migration from a host kernel which features the commit to a destination
> host that doesn't fail.
>
> Currently QEMU is not using that feature so ignoring this latter
> is not a problem. An easy way to fix the migration issue is to teach
> qemu we don't care about that register and we can simply ignore it,
> including its state migration.
>
> This patch introduces a CPU property, under the form of an array of
> reg indices which indicates which registers can be ignored.
>
> The goal then is to set this property in machine type compats such
> as:
> static GlobalProperty arm_virt_kernel_compat_10_1[] = {
>    /* KVM_REG_ARM_VENDOR_HYP_BMAP_2 */
>    { TYPE_ARM_CPU, "kvm-hidden-regs", "0x6030000000160003" },
> }

One thing worth noting - once this series lands:
https://lore.kernel.org/qemu-devel/20250801074730.28329-1-shameerkolothum@gmail.com/
we might need to add a bit more logic here. Either using the kvm
interfaces (only ignore KVM_REG_ARM_VENDOR_HYP_BMAP_2 when the register
value is 0) or qemu knowledge (only ignore KVM_REG_ARM_VENDOR_HYP_BMAP_2
when the impl-cpu property is not used).

Sebastian
---1463806286-295920147-1758212182=:37575--


