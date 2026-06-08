Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E2D8CD6E79
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 17:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWdTM-0003Ga-Ij; Mon, 08 Jun 2026 13:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1wWdTI-0003B7-LY
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 13:09:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1wWdTH-0004Hr-5G
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 13:09:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780938546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TfvPPhM7xeDBVVNCqKRfP7HyRd6IRZn7Td/OA6zUdKA=;
 b=Ifiz3TvQYg7afJNLtOiPiEpQ7nmnHIxhHjO1eCGoRIKv0nsydQfqxwFpppuW/xCJR3NYny
 2DpXjZZj0qKjnf6SbK9q2dMoDgZy+iXkeu/HhX+XWDnsLMeDfgYC3GOV+JvqAqOM3c9ozh
 Mv85ElKXPPCBZazVozU02GCrWdrDxr4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-VAXfIiWYMkaYOragh5lbsw-1; Mon, 08 Jun 2026 13:08:55 -0400
X-MC-Unique: VAXfIiWYMkaYOragh5lbsw-1
X-Mimecast-MFC-AGG-ID: VAXfIiWYMkaYOragh5lbsw_1780938534
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490ae461f8dso33995525e9.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 10:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780938534; x=1781543334; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TfvPPhM7xeDBVVNCqKRfP7HyRd6IRZn7Td/OA6zUdKA=;
 b=R5mZnTO5ghROONuZ4gG2otWLJh968r3VTvNpYpBS/yidmYI7BUQIiaP/vtPh/Trt79
 xjY3/bG6zyzq059nKTrML9xSR6CBDsU/Fbb0ZkaHRXrsR5gcmz8j7GyvYOC5oHWqf66e
 F+llVrUS8sNILPbzj8Wovp5BMxCUoAiaMflK8GgYF5KVSuamDbvNAkz47ILNJlAGf9kZ
 EJJZyP26hGEFCtUDCPco9wewp2RFpuMuUWmqd/WWGTypoXbwVmHCHz4k7VB6CZtWCFks
 TZTUgeahBgleSuDvxLm1V9Y+CpqVlHLJr7z3U6IcnGnfUl+NSdlspVjnd9qeKGQRSXRz
 Wdlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780938534; x=1781543334;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TfvPPhM7xeDBVVNCqKRfP7HyRd6IRZn7Td/OA6zUdKA=;
 b=mB7hezMMl/c2GpZ9O79/Hw4NVq4YF4k1NJHAuC9mgRATiuIUTk6OD5sSVpBBS4faDB
 qBnOuDCyP4CHiBSTlVn1A9G7L3LuP+gbgPJP1o8FwoqU0ngzPmSKoj95pSVi6eO3PHEA
 qlXJ/fwd4w7ahzRjTVgH5lCA2A9jpXx2SKVcipRDsR9HUgM95rPv7Y7r5H/qMmhsbgZb
 LGi5XOZ1pXhYcR3ZynHsFID7EE8+FeBHSFIc4lN8EPRwpRGuhifHtVlD7TMUfzXY2rC3
 uK+UM9PkJsVlPTldXPk7F6stCFZ2yLaY8cP/OEtwBln6QsN44OT0o1hDnVw4otKulG6c
 3auw==
X-Forwarded-Encrypted: i=1;
 AFNElJ89+EQCWFlHZqDKWXtaWFR92BK/TMHE9Tfnis5klKOUu/l3V0GcA3Clw6PXBnDugCAy7BcCnkWpWkMj@nongnu.org
X-Gm-Message-State: AOJu0YzDyebXFQKYSU+7Krbm5gE2h/M0WQ9Dbq0jOGP0i7kDYXRHnE8F
 0CmK1qCYDxw3kcMKUlTW9IYqX3tgHyD8ctfQHBEe/vL+GgfB4/GG2dntQ5rykvfiacnuTonDhA/
 9hb49YdhlcensB/TFWRgRz1Y0gO6rz+IX91tiZcT8Gn1GcHbAa4pLPdj8
X-Gm-Gg: Acq92OH2jkGTugc+BYDdhhzLDn0+W6Dc1kAfphv5gZP9pfyCKH1O/vz+BiSGOjc12Jo
 2AojHCu6o9glaJVd6/DBFArOAGnXUuM9mf5GDrOxoZZBpC7K0ZDvSv35GfEcuEjU+zyL8anf4/o
 iH6dOh4Qo/zsfJUN4KoyCznuypR9WxHnGQtpxH3gKTCBZmAl7ApyRifvSdnAhal8OF/GZRON6XX
 fC8t8WtAKi1unblKhAL/QUb4jlpFFhwZWvlDvhptbKphei1xDRIyDEpIN2Nxp9EQtRSsOVP0inW
 cA272x/yV6cA7sh7cUvI6K0JpIGdD5GPqg3aP34PeSr7KlIsyqbsf84FtxxsiAI0LOpU9sKKK4m
 K2FmP6A/au3VoWr5OW0GeXRQp3WVcWIjSO8VzSzIb0SKc+TAfbUux5aiQjh4TZlTClAYj11RPyk
 s=
X-Received: by 2002:a05:600c:3f0e:b0:490:bb45:79ef with SMTP id
 5b1f17b1804b1-490c2508a5emr303965925e9.0.1780938533738; 
 Mon, 08 Jun 2026 10:08:53 -0700 (PDT)
X-Received: by 2002:a05:600c:3f0e:b0:490:bb45:79ef with SMTP id
 5b1f17b1804b1-490c2508a5emr303965245e9.0.1780938533380; 
 Mon, 08 Jun 2026 10:08:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc39def5sm399510095e9.5.2026.06.08.10.08.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 10:08:52 -0700 (PDT)
Message-ID: <6ebe750b-3451-44a1-b45f-c749f3ad1488@redhat.com>
Date: Mon, 8 Jun 2026 19:08:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/21] tests: acpi: arm/virt: add WDAT table test case
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, anisinha@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, shannon.zhaosl@gmail.com, philmd@linaro.org,
 zhao1.liu@intel.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com,
 qemu-arm@nongnu.org
References: <20260303092532.2410177-1-imammedo@redhat.com>
 <20260303092532.2410177-14-imammedo@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20260303092532.2410177-14-imammedo@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 3/3/26 10:25 AM, Igor Mammedov wrote:
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  tests/qtest/bios-tables-test.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index 5b01a657e5..5082866184 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -2271,6 +2271,25 @@ static void test_acpi_aarch64_virt_tcg_msi_gicv2m(void)
>      free_test_data(&data);
>  }
>  
> +static void test_acpi_aarch64_virt_tcg_wdat(void)
> +{
> +    test_data data = {
> +        .machine = "virt",
> +        .arch = "aarch64",
> +        .variant = ".wdat",
> +        .tcg_only = true,
> +        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
> +        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
> +        .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
> +        .ram_start = 0x40000000ULL,
> +        .scan_len = 128ULL * MiB,
> +    };
> +
> +    test_acpi_one("-cpu cortex-a57 "
> +                  "-device sbsa_gwdt,wdat=on", &data);
> +    free_test_data(&data);
> +}
> +
>  static void test_acpi_q35_viot(void)
>  {
>      test_data data = {
> @@ -2889,6 +2908,8 @@ int main(int argc, char *argv[])
>                  qtest_add_func("acpi/virt/smmuv3-dev",
>                                 test_acpi_aarch64_virt_smmuv3_dev);
>              }
> +            qtest_add_func("acpi/virt/acpi-watchdog",
> +                           test_acpi_aarch64_virt_tcg_wdat);
>          }
>      } else if (strcmp(arch, "riscv64") == 0) {
>          if (has_tcg && qtest_has_device("virtio-blk-pci")) {


