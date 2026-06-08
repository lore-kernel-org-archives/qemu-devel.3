Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FCCECD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 17:10:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWdU0-0004MF-3D; Mon, 08 Jun 2026 13:09:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1wWdTy-0004LM-Lb
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 13:09:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1wWdTw-0004Sl-Lo
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 13:09:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780938588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rln+lyE7QxAuRkfytTPnJzMSOKqrlsl99Cua7re43vg=;
 b=N2iWHH+1Cc/XLBoxf08LZJ449MeESz02xRmmQck3wKP/KqoXCdy9mUCCg4nqUOGQGukKvL
 fI9UegEO3wJYE3F7JnSwo1UifZ1mpj2tCwpZRVCghCde475KYhNlrJklZ4gaRNiwBwMHSI
 32OcT0HkInFRPiSm1RiHwgH1Ei4LPhM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-5DHaWGTfNJ2shLIHXmcRRw-1; Mon, 08 Jun 2026 13:09:46 -0400
X-MC-Unique: 5DHaWGTfNJ2shLIHXmcRRw-1
X-Mimecast-MFC-AGG-ID: 5DHaWGTfNJ2shLIHXmcRRw_1780938585
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490a786f987so52523695e9.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 10:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780938585; x=1781543385; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rln+lyE7QxAuRkfytTPnJzMSOKqrlsl99Cua7re43vg=;
 b=KtnlM2zxB0WTZzufliM8iHzRugnTSx2sZfzPpksP8ZnoI4ZsXvVyeNgKVrJ8PNj8mv
 yVjjhNtaSqYMA05bXXMtnpt/VzzG65pRPu0jx2NmuoAfnzXQfBvYYRXEaokfTMDYkQ38
 bfQLX5B9MFlB0fv96SB2Nlcat3yUxoYy7kjkH6cePrJL6JMckUxY8LxcXgIKuRQlDIFQ
 +rMBMuAua3UKj+U1gZo1VYz64SLWrm1oiWHX6N1rQiKvtcqfbvTtqEFIBBD4XocIKXcM
 bC4Pc8o66O0ljFu2NPuCytXe5+ce6xXRmDWWPGgm6dBeaHDH3goirGHRzLVvVZRdwZGm
 Pjiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780938585; x=1781543385;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rln+lyE7QxAuRkfytTPnJzMSOKqrlsl99Cua7re43vg=;
 b=eOhcv4STgrMFuUfP81YJ5VQPcF/rWUzXNhXrujTps7pSqqA6U6lGzZZP+mcJhLRs+D
 F7DSdqStNhZ0/RTpicq5mI/NcIA2mL1291ByaW0MQquZWBwQUQLNmCX70InAQtJFHyVH
 yGF4BMju+93LdSTtUiCmkMWFiVo8+OobvfhSLdbejm5w5z5nxXSpolrbkJZ/KHffm12z
 1iNl3EmDCOsvMyvFvTPmptQLBRJM3BzPmLFsgyC8uImsCoMV+iKcsbVz2VAL3DgSc9M0
 rf5LMgS6lFiX8Ea/hRcAje+xCKbFDwsBMXRbfn2RTXXjy/0x3fRo+CY1FE1iidouNjJd
 y61Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+cuyjlzpCEYXSH0dvqda5Xa0Cpzo2wDugENMbMNjP+iw9uA9XKuuBM6B9dwLkNRojWDig5qBu7N9Q2@nongnu.org
X-Gm-Message-State: AOJu0YxC0WzwSv8bPWoSgH68L4yY3gwlqwtLEiQSzNP24PO+PzOFWIwx
 9q+jp3oLrazvdltVxUspVQYffNDWjfojNmIRE3MXuWX7zEfDnleyMe1f3wWvzj9+abqGkVANffC
 S7w+Jego5LAfrp2XW1q+Jkt2Pa0+pgBkLU62fXsb0ftVx8Iz3/GpARS8r
X-Gm-Gg: Acq92OHzuPur47IUcU6qJpcabGBY+5lINOvcL/O/1NVTzxeul5Y/U7NzFMg+J3RaT7e
 uu3TmkFqn7zIS0Wg5JHsuv28lEOBr2XgN5lZwPshztLC+Op1S+zTmJ3mHX77C/V/dB4KMHQnClo
 O0bvGN/4P9gMCvXSUqfoazzdW6TBl8/hMsBXb/djTY+R8SqAMbPW9lAu1MpfuMHhIjVi/8g/317
 d7BD+kg5GaKRqKxnyq6WoHVRH6FVkO0jUKXo+1zns87zBy2ykLjvmnd5BLDFqgPbXnifu0scSAB
 g8rz0+WVDrGHE6VZZrt8p3PDJJ9AQ0v/Wc/22sS4lTA3jQADqPRAzfqiGpE/8U1uJs/f4Ht5weq
 vmASCQ7HpW3T7DG/yFLgpn+qgY6p2lq4l6IglYGlR2BL9QL1hIwcAqc8ntyJ8R6g+gWOpUix3+A
 g=
X-Received: by 2002:a05:600d:640f:10b0:490:b7e6:bd1d with SMTP id
 5b1f17b1804b1-490c25e30a2mr186383765e9.16.1780938585590; 
 Mon, 08 Jun 2026 10:09:45 -0700 (PDT)
X-Received: by 2002:a05:600d:640f:10b0:490:b7e6:bd1d with SMTP id
 5b1f17b1804b1-490c25e30a2mr186383445e9.16.1780938585297; 
 Mon, 08 Jun 2026 10:09:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2f2710sm42516285f8f.14.2026.06.08.10.09.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 10:09:44 -0700 (PDT)
Message-ID: <36dc66d1-94ca-4ffb-9617-acf49115c77b@redhat.com>
Date: Mon, 8 Jun 2026 19:09:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/21] tests: acpi: arm/virt: add GTDT watchdog table
 test case
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, anisinha@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, shannon.zhaosl@gmail.com, philmd@linaro.org,
 zhao1.liu@intel.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com,
 qemu-arm@nongnu.org
References: <20260303092532.2410177-1-imammedo@redhat.com>
 <20260303092532.2410177-17-imammedo@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20260303092532.2410177-17-imammedo@redhat.com>
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



On 3/3/26 10:25 AM, Igor Mammedov wrote:
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  tests/qtest/bios-tables-test.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index 5082866184..11c6854af8 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -2290,6 +2290,24 @@ static void test_acpi_aarch64_virt_tcg_wdat(void)
>      free_test_data(&data);
>  }
>  
> +static void test_acpi_aarch64_virt_tcg_gtdt_wd(void)
> +{
> +    test_data data = {
> +        .machine = "virt",
> +        .arch = "aarch64",
> +        .variant = ".gwdt",
> +        .tcg_only = true,
> +        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
> +        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
> +        .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
> +        .ram_start = 0x40000000ULL,
> +        .scan_len = 128ULL * MiB,
> +    };
> +
> +    test_acpi_one("-cpu cortex-a57 " "-device sbsa_gwdt", &data);
> +    free_test_data(&data);
> +}
> +
>  static void test_acpi_q35_viot(void)
>  {
>      test_data data = {
> @@ -2910,6 +2928,8 @@ int main(int argc, char *argv[])
>              }
>              qtest_add_func("acpi/virt/acpi-watchdog",
>                             test_acpi_aarch64_virt_tcg_wdat);
> +            qtest_add_func("acpi/virt/gwdt-watchdog",
> +                           test_acpi_aarch64_virt_tcg_gtdt_wd);
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric

>          }
>      } else if (strcmp(arch, "riscv64") == 0) {
>          if (has_tcg && qtest_has_device("virtio-blk-pci")) {


