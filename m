Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE6FC3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 14:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0LBr-0001Lr-GF; Thu, 03 Apr 2025 10:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u0LBp-0001L0-F7
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 10:05:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u0LBn-0001LT-LQ
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 10:05:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743689100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XLXdAS4trprj29nGaRI5aZfZ+sIl3J+uLzGKL5gCqOo=;
 b=M95kQ4PhJFZrBq4e0RTTxKUqhfAQRiPJFtpA1bGNSj8RTMopgZcyGNeyQ4axp4VDIT7nb8
 fP0MUnf2aFQsFbdEnrZNjlGloofGfiGvFmSA2cusZdEAlT6FqaCXy1wnEbohQH4NvzrD52
 7mPSs0870efta/8eBJxnA82R3lYpip8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-elD0HpeKP9uRHxL2SrzWMQ-1; Thu, 03 Apr 2025 10:04:57 -0400
X-MC-Unique: elD0HpeKP9uRHxL2SrzWMQ-1
X-Mimecast-MFC-AGG-ID: elD0HpeKP9uRHxL2SrzWMQ_1743689096
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43d6c65dc52so8144755e9.1
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 07:04:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743689096; x=1744293896;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XLXdAS4trprj29nGaRI5aZfZ+sIl3J+uLzGKL5gCqOo=;
 b=ZhLBiWmEjeTvpAz67VDZSzlFfGrPgrmIDJxN8CgHR9qSpdj+g5/NynFJAI/tHAysYx
 XKOekIfoTpCe/KkSk99P93VLvlb6MakIywrxxWjdRZSip9dzh6WHchVzMiStrN6qAZzJ
 zruQ3vmKmrufWzlGz4hhQfmEZZQMzWikg0nWRTPhvEu1jBh4Ho+ttJDV3Y5mvpdZihKe
 vKdGqaFYGm8FGyZmOY45gEYUCVWLHf46NMfeWthh6Az2wdwsLQGfJvsihm8KxgvvR9UB
 QzGPJlAY10EmXqUd2VxfN+p6onSlBvNfbbitBntYDs62W4GgeUCVBWuCjZBo6WdR5rLP
 zmMg==
X-Gm-Message-State: AOJu0YzQUd1FlFZViKEyrDTFKTof/Ql2TshYz7MI7Qixb6r54+NHdV5K
 VDhqNYLMUtTX4MqZCDSomKnvIdhGINGBQnFzkN3JkvDj+20dl93dLCNvoHXWOsVDo3eDBYYbdd7
 mam3d4IMu6aKxAMeovaaAojKxDhcjYJTmmB/FBozz3yI1DwzYCtjn
X-Gm-Gg: ASbGncvYQc1Jex5I5+G/gbU2nvR/nZoHsi/iQn4vsOSsXfVXUG8uVefBeK9IYApy+VO
 W3NbaB0M34u66XypwlNQVlT96W6ba34f+shc3CUcEHZJHIu9aPbasfOlno/J0dgwT+IdpEShL7K
 JxPMoWKAnRlzu8FfgwPUqU2/zZMtVDZhFSN5E4VK9dwLoJahg/QIgPiE3xj8nWOFiy7anJuhvyM
 SUDTjn1JfBY+Fb5lEUCdCOZa86UV/Z7Ll5pZd6llJSgywnIVmd2N+RsXnxQlV6wVvuI7qJtk3ZW
 9a3g2DAYIQ==
X-Received: by 2002:a05:600c:4e56:b0:43c:fa24:873e with SMTP id
 5b1f17b1804b1-43eb5c20fdemr78918115e9.13.1743689095990; 
 Thu, 03 Apr 2025 07:04:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBm6IjOOJ0eeaG2lCMlWhltHQtL/7V5RchboCq/SVw34zUxkQ6s33c1iEqwpq25dWQxCKsUg==
X-Received: by 2002:a05:600c:4e56:b0:43c:fa24:873e with SMTP id
 5b1f17b1804b1-43eb5c20fdemr78917605e9.13.1743689095667; 
 Thu, 03 Apr 2025 07:04:55 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec364d071sm19166145e9.32.2025.04.03.07.04.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 07:04:54 -0700 (PDT)
Date: Thu, 3 Apr 2025 10:04:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Udo Steinberg <udo@hypervisor.org>,
 qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH-for-10.0 0/5] hw/arm/virt-acpi: Do not advertise disabled
 GIC ITS in MADT table
Message-ID: <20250403100406-mutt-send-email-mst@kernel.org>
References: <20250331221239.87150-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250331221239.87150-1-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.649,
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

On Tue, Apr 01, 2025 at 12:12:34AM +0200, Philippe Mathieu-Daudé wrote:
> GIC ITS can be disabled using '-M its=off'.
> When that occurs, it shouldn't be advertised in ACPI tables.

I doubt this is 10.0 material. How common is its=off that we
urgently need to fix it?

> Philippe Mathieu-Daudé (5):
>   qtest/bios-tables-test: Add test for -M virt,its=off
>   qtest/bios-tables-test: Whitelist aarch64/virt/APIC.its_off blob
>   hw/arm/virt-acpi: Factor its_enabled() helper out
>   hw/arm/virt-acpi: Do not advertise disabled GIC ITS
>   qtest/bios-tables-test: Update aarch64/virt/APIC.its_off blob
> 
>  hw/arm/virt-acpi-build.c                  |  12 +++++++++---
>  tests/qtest/bios-tables-test.c            |  22 ++++++++++++++++++++++
>  tests/data/acpi/aarch64/virt/APIC.its_off | Bin 0 -> 164 bytes
>  tests/data/acpi/aarch64/virt/FACP.its_off | Bin 0 -> 276 bytes
>  tests/data/acpi/aarch64/virt/IORT.its_off | Bin 0 -> 236 bytes
>  5 files changed, 31 insertions(+), 3 deletions(-)
>  create mode 100644 tests/data/acpi/aarch64/virt/APIC.its_off
>  create mode 100644 tests/data/acpi/aarch64/virt/FACP.its_off
>  create mode 100644 tests/data/acpi/aarch64/virt/IORT.its_off
> 
> -- 
> 2.47.1


