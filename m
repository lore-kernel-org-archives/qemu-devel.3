Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E2A3C28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 08:09:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trufg-0006qm-Ar; Tue, 11 Mar 2025 04:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1trufP-0006nx-Fr
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 04:08:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1trufJ-0006ou-Vk
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 04:08:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741680517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tJchAcU1gYXxaxP6//UXsS/rASFLmJLjaLSCeFmqR4g=;
 b=UwysNYCcumBaDUFPxRT63MTlT18KOzn5h/dGs4vUxRFssAyyv/scKiv6tOvaRVReoTjfiz
 bP7aX2MY7Fs2swAMR0gB8YOI9vu+InDZsYfY3RVFMjdgmS7pnh/raNfVbGx9pjQ6YO1v3r
 XhJ33CaNehKmP3kp21LCL5PESDXq8W4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-CfzuyoM_NxKnlBZPkk0VFg-1; Tue, 11 Mar 2025 04:08:35 -0400
X-MC-Unique: CfzuyoM_NxKnlBZPkk0VFg-1
X-Mimecast-MFC-AGG-ID: CfzuyoM_NxKnlBZPkk0VFg_1741680515
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7c53e316734so658427485a.2
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 01:08:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741680515; x=1742285315;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tJchAcU1gYXxaxP6//UXsS/rASFLmJLjaLSCeFmqR4g=;
 b=VV5YEWN55LrvaGZVzUEt1TTNNqMHu6xgsSXuq/XMA4uYZxlFff+ugkrw81Smh1xIDx
 7tWz+h37PjmSBurLgq2O/yu8uWDIQkIOAmhc9caps1j7XqUboBcOoErLnIqSLTuqONOZ
 k377pT+C/MyDYwz61uIFCiSuSXczfh1yPV9YCWTfO0qPMVmmNerwn+VoPOytHt+5xBfb
 bJGCl3XBxPQ3GWIUsLH5JasxpYOYctxWTLdiHdHjikCQ5hyIBd5/ldFozIpsXc8CBQxK
 aWFLolV/KLWF4kSvZCcJsV8y5eNZ5Q0pSBc8BwGwQ8DyvNEtfN5zCmleXMRBc/Zth8B+
 dUvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLRu0pNCM/7Sq5ETNDsqtg3bzQ4rH+ESp1suQHNqxoDvS8orvfZ9UuSIVytop1V7NwYTxknG4B8/WD@nongnu.org
X-Gm-Message-State: AOJu0Yz4EUph6ghjVpF7GeVBc1tAQNVLb4yVkxymTf2MmGMURhIIw68Y
 t2oWphRgIESF8eEBRc9pkcr123UUfRyX+U89d3fjLdGo2HB/vlonf7rDl/aIEbpDCKjKjgwfnpL
 YDXPWuUvB84w/Z8a32jgJmtbpw+/9SgyO+VJ+TMG6BbWOLKROqQhi
X-Gm-Gg: ASbGncuLzhlIsgRxJ72PafbcjLI4IGSfroS8cS1nprfJDAgsMMaKe6eI//012z7aeRn
 KiWDzyEGBH3UUD3WwOIofL0FvP61uGGJJRSPIwdMW7NlvNzqTil3HQUuj13wrIAXkU/7JxZBp2z
 nRA4bpViK5tj6NzYVcX1SFRnt8Y20ZGk5ktHE3P8mcBk3s0CgjG6hxWRO0Bnn9wt+KtIgpxEvpH
 w+aGQKIU2zmEk7H4p+E25in8sYDu1bblw6xheCu71uVKc4Z+xzL9XWHph7R/teKBfla5jhVHEpa
 Rg0aJSqgH1Qxxym7Uls9tR1lQ0Zjgh87efYP+G7rmhK6Se6xGRpmCg==
X-Received: by 2002:a05:620a:4d88:b0:7c5:53ab:a745 with SMTP id
 af79cd13be357-7c553aba8b3mr885972285a.36.1741680514898; 
 Tue, 11 Mar 2025 01:08:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGoNfPhKAn/2gWJ4E1pUGJ1C1HXp+qrHBNeOVO3i/YhjT8gn54rIw4q5j/YmMqMNkvU+kZJw==
X-Received: by 2002:a05:620a:4d88:b0:7c5:53ab:a745 with SMTP id
 af79cd13be357-7c553aba8b3mr885968085a.36.1741680514636; 
 Tue, 11 Mar 2025 01:08:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-47681fee8bbsm31242001cf.26.2025.03.11.01.08.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 01:08:34 -0700 (PDT)
Message-ID: <cf736f7a-bf35-498d-aa7c-ed98d9468415@redhat.com>
Date: Tue, 11 Mar 2025 09:08:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/21] hw/vfio: Build various objects once
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Tomita Moeko
 <tomitamoeko@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eric Farman <farman@linux.ibm.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-s390x@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250308230917.18907-1-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250308230917.18907-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 3/9/25 00:08, Philippe Mathieu-Daudé wrote:
> By doing the following changes:
> - Clean some headers up
> - Replace compile-time CONFIG_KVM check by kvm_enabled()
> - Replace compile-time CONFIG_IOMMUFD check by iommufd_builtin()
> we can build less vfio objects.
> 
> Since v1:
> - Added R-b tags
> - Introduce type_is_registered()
> - Split builtin check VS meson changes (rth)
> - Consider IGD
> 
> Philippe Mathieu-Daudé (21):
>    hw/vfio/common: Include missing 'system/tcg.h' header
>    hw/vfio/spapr: Do not include <linux/kvm.h>
>    hw/vfio: Compile some common objects once
>    hw/vfio: Compile more objects once
>    hw/vfio: Compile iommufd.c once
>    system: Declare qemu_[min/max]rampagesize() in 'system/hostmem.h'
>    hw/vfio: Compile display.c once
>    system/kvm: Expose kvm_irqchip_[add,remove]_change_notifier()
>    hw/vfio/pci: Convert CONFIG_KVM check to runtime one
>    qom: Introduce type_is_registered()
>    hw/vfio/igd: Define TYPE_VFIO_PCI_IGD_LPC_BRIDGE
>    hw/vfio/igd: Check CONFIG_VFIO_IGD at runtime using vfio_igd_builtin()
>    hw/vfio/igd: Compile once
>    system/iommufd: Introduce iommufd_builtin() helper
>    hw/vfio/pci: Check CONFIG_IOMMUFD at runtime using iommufd_builtin()
>    hw/vfio/pci: Compile once
>    hw/vfio/ap: Check CONFIG_IOMMUFD at runtime using iommufd_builtin()
>    hw/vfio/ccw: Check CONFIG_IOMMUFD at runtime using iommufd_builtin()
>    hw/vfio/s390x: Compile AP and CCW once
>    hw/vfio/platform: Check CONFIG_IOMMUFD at runtime using
>      iommufd_builtin
>    hw/vfio/platform: Compile once
> 
>   docs/devel/vfio-iommufd.rst  |  2 +-
>   hw/vfio/pci-quirks.h         |  8 +++++
>   include/exec/ram_addr.h      |  3 --
>   include/qom/object.h         |  8 +++++
>   include/system/hostmem.h     |  3 ++
>   include/system/iommufd.h     |  6 ++++
>   include/system/kvm.h         |  8 ++---
>   target/s390x/kvm/kvm_s390x.h |  2 +-
>   hw/ppc/spapr_caps.c          |  1 +
>   hw/s390x/s390-virtio-ccw.c   |  1 +
>   hw/vfio/ap.c                 | 27 ++++++++---------
>   hw/vfio/ccw.c                | 27 ++++++++---------
>   hw/vfio/common.c             |  1 +
>   hw/vfio/igd-stubs.c          | 20 +++++++++++++
>   hw/vfio/igd.c                |  4 +--
>   hw/vfio/iommufd.c            |  1 -
>   hw/vfio/migration.c          |  1 -
>   hw/vfio/pci-quirks.c         |  9 +++---
>   hw/vfio/pci.c                | 57 +++++++++++++++++-------------------
>   hw/vfio/platform.c           | 25 ++++++++--------
>   hw/vfio/spapr.c              |  4 +--
>   qom/object.c                 |  5 ++++
>   hw/vfio/meson.build          | 35 +++++++++++++---------
>   23 files changed, 152 insertions(+), 106 deletions(-)
>   create mode 100644 hw/vfio/igd-stubs.c
> 

Applied 1-9 to vfio-next.

Thanks,

C.





