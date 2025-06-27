Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C378C77B7F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 12:15:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV7yB-00021d-NH; Fri, 27 Jun 2025 08:14:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uV7yA-00021L-PW
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 08:14:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uV7y8-0006YE-CR
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 08:14:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751026450;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Py3TPV5zuZPrpF/KGzIXmqU+JkJO3G52AmeeZCrSa9c=;
 b=i/BBrTr4C5lIVc7eeGIA/R3NO+CVWxNcvyEvh0av5BxoAU4+txab4u3yu7O8xMs2VN/p7/
 blKvs19DpwrGZdWbK7Gdwan48MzNPDb1TF2WiL2b9RKl5fWxm1w+um9hQNNQpS4HWJqxoZ
 1zKEtJQE/B8gyJ6pqC+BmGNIp35i9uY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-wGI4ZjddPrmwOvtUgaI4rA-1; Fri, 27 Jun 2025 08:14:08 -0400
X-MC-Unique: wGI4ZjddPrmwOvtUgaI4rA-1
X-Mimecast-MFC-AGG-ID: wGI4ZjddPrmwOvtUgaI4rA_1751026447
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a4f8fd1847so850370f8f.1
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 05:14:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751026447; x=1751631247;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Py3TPV5zuZPrpF/KGzIXmqU+JkJO3G52AmeeZCrSa9c=;
 b=jQTqYu+0FTpTtywYqk1tGhLYMPShidYz61QAWpIbOph4wZd4H00hvZyJK173Xel66C
 NGDCQATzMRyENazqxjPmjev5XhMMXDN20ujSNXaKZ7hhVt1Tt74WAJD4f5NpeIOS8wGQ
 kWCKZDxp5qrQh4x1lZn9fUoJAlwpAMBGCpRPt1nUxwocunKdLDtWDuWTo/bzMHCL/Shg
 xNG5U+MO/zHfnkU4TNfH4HiF1OJiaeRPFEOSCx5cjU6s61DBU6HJh3/0YwFI/dmRLf5+
 YB9+2FIScJKiLq0pyBC5kSNqM15uG8G7AV6XWv/fo4TsRubN6IEDRR3kDbc3cj5XNnQd
 mrig==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFvLCGCHuqnpPl98NV7bFvAtoFnVm8vocbECRoKsa3EEp71wDxDzxEbyTMdXJauW+mjfTSbc34JhN8@nongnu.org
X-Gm-Message-State: AOJu0YxI/Cr1R6c/fyVlHVbAGkMrekTA+edyBJnTGxLvlOgYQKZU/Ynb
 3guQfoiDJ7S/EnCrjkhKMc7YTCG8snBXBxOuCLMrEIitRGr/BnSF6t8jW2ke2Zpr4n23F2DYV39
 bpFRoWrq9hI2DjGDtzoX4dYS4JcV/0ulue+Zz+O7YXDPXhrBd5GYQ7yVC
X-Gm-Gg: ASbGncvgOjRdLYU4G8NXa4eEf/nUV6Lzjt5OPnBtTpqjm5tnQ+vsBToY1Zi2t03MeUO
 YxtVa4edIZ5V/SZyHHlKCXduHRtUDAlDngdLyXSIwCttjnnO9qar6xczcvS9O+GcsMMcNU8Eyrn
 FApoK+LN03ZpYXeFBWSD9uD6LsuSDurTWYPOJyumhGdIwMY6yMlyoonEx7e6GZR7riXHg9JWLU9
 +EnVq0CSBG1sDSbOytBDlv2vsL9Gz4lYtSFsudL+zX4V5RshO16ouvhVpphPCWJ/jIyveFgPKm7
 hNe2bSE5Y65pYna2TL2LJAg0bEH4htEXEVKFwaUqCLrD4h/v2PiGsx7idMWlWvYEOknqgA==
X-Received: by 2002:a05:6000:645:b0:3a4:d53d:be20 with SMTP id
 ffacd0b85a97d-3a8fdff4832mr2372076f8f.18.1751026447358; 
 Fri, 27 Jun 2025 05:14:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG26xoMo4Id1l9yv7RPKNHXgIuZFr08ET1/hmMypqGLNQxNAbFiDZCDk1R51c7y88PQLpKZ1w==
X-Received: by 2002:a05:6000:645:b0:3a4:d53d:be20 with SMTP id
 ffacd0b85a97d-3a8fdff4832mr2372048f8f.18.1751026446855; 
 Fri, 27 Jun 2025 05:14:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538a406ab6sm49594285e9.30.2025.06.27.05.14.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Jun 2025 05:14:06 -0700 (PDT)
Message-ID: <6a3c2ebf-ac62-474f-b2b7-a1d017f6c2bb@redhat.com>
Date: Fri, 27 Jun 2025 14:14:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/11] bios-tables-test: Allow for smmuv3 test data.
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, imammedo@redhat.com,
 nathanc@nvidia.com, mochs@nvidia.com, smostafa@google.com,
 gustavo.romero@linaro.org, linuxarm@huawei.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250623094230.76084-1-shameerali.kolothum.thodi@huawei.com>
 <20250623094230.76084-10-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250623094230.76084-10-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Shameer,

On 6/23/25 11:42 AM, Shameer Kolothum wrote:
> The tests to be added exercises both legacy(iommu=smmuv3) and new
Suggesting: exercice.  legacy (

Besides:
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> -device arm-smmuv3,.. cases.
>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev    | 0
>  tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy | 0
>  tests/data/acpi/aarch64/virt/IORT.smmuv3-dev    | 0
>  tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy | 0
>  tests/qtest/bios-tables-test-allowed-diff.h     | 4 ++++
>  5 files changed, 4 insertions(+)
>  create mode 100644 tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev
>  create mode 100644 tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy
>  create mode 100644 tests/data/acpi/aarch64/virt/IORT.smmuv3-dev
>  create mode 100644 tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy
>
> diff --git a/tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev b/tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy b/tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/tests/data/acpi/aarch64/virt/IORT.smmuv3-dev b/tests/data/acpi/aarch64/virt/IORT.smmuv3-dev
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy b/tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index dfb8523c8b..2e3e3ccdce 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,5 @@
>  /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy",
> +"tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev",
> +"tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy",
> +"tests/data/acpi/aarch64/virt/IORT.smmuv3-dev",


