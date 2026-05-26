Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EEBACD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:44:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRt1A-0005sc-F1; Tue, 26 May 2026 10:44:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1wRt0z-0005qN-VH
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:44:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1wRt0y-00087f-BE
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:44:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779806653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LKfZEEQdTt++se/+kXecI2+IIX+I9AD5xJpi8dFnHgo=;
 b=VHcxZ+/VZtUDqvI5/4fhH4MiJw8OuRK3SzMAAe3TauVisPeNXfmT+CSXqIC2FS1rlrfbDW
 0I1A3yycZovzNhNK2iDFzwr1hLU3kd99HtZKINUTswDJYLOVEiessMo+YZRYJ3pI3yjS/n
 T8gNM6oUnvprBmDaT0/gAG+lZS6y96o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-dGkmOonjOQSTlEGCPCDLfg-1; Tue, 26 May 2026 10:44:12 -0400
X-MC-Unique: dGkmOonjOQSTlEGCPCDLfg-1
X-Mimecast-MFC-AGG-ID: dGkmOonjOQSTlEGCPCDLfg_1779806651
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-44dad1b938fso6344844f8f.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779806651; x=1780411451; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LKfZEEQdTt++se/+kXecI2+IIX+I9AD5xJpi8dFnHgo=;
 b=Mw2iUEAi5pqfa1mbF3DAz2SNo1EsQMHsyxn2JbncLWurmEzXggegxvxqgnEQshmQU5
 Wf5LclGbHkQDSfouhCigKmZBbEfrSXO7ecve2ef3i1usHISdh9PMz/OO3MrMG34+ynel
 eei+X725VgomH6vj+PXaP3bnxxwNKfLJxf/glL9UD3ylQBxolHJBrwv2zA5eZEKqH+Ps
 cMAjuu5nV0OFOWTLo31F9AF2uXcZAc/AvRnmaqFFtdo3TiQ5FA7bX3/XEDkKmL9Ex0KF
 1B1BwuED7FSNRRLzq4dTDSdZbX2GRxRlFB9n85j/nP6PvEf3EnFqSLdbEtTVQlXYHatK
 Zgcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779806651; x=1780411451;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LKfZEEQdTt++se/+kXecI2+IIX+I9AD5xJpi8dFnHgo=;
 b=i81w1HvhD1WNqoBmHOCNmnjx/r0TffX58Q5jlALf5/Vx0cm6bmlsgNXcjdto3yi/1t
 I+8oqK/Y12QIFzGWNcc2wxu35+hNCuqRkSIKJxu3fOR1KlVb0w++auLU7cHgDWdcR6bq
 s1VpoFUheqwNXKDJV3yBcbQVlEeouvm2WnnFZM7qe2iatbHlBX/pltrQ/kVKR6B184mP
 a2sE2VvOcJiuULtbGzxmJp4RG3btOug1pVTqlVxScaJ4u10onGlxGrrj5RanyvMsSslM
 GG8uwmkup+FXphVv/Qk7uN1zrtmjVSbn/mE+GdGtnGJ26Sm3PKICHwndEsSz3gN6SvVT
 exqg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Piv5xKx9A20YR/3EIJbZOClu7HSs5VJxn1jZ1RFS4HT+MqErM/wvQ6G7uX/Z1Rl0fgjoMfTCwuwKu@nongnu.org
X-Gm-Message-State: AOJu0YwLTKiDi4KCvZ8EWd9iMHMy/FR1Iy2+HI8Mg1xb25wTKfg/Pv7k
 L5XVSCjf/8ntTyMlHBX4RaZR9/sCa1XSt+Q9qk+B01f0rP5+hJHcIdBoDsKbpxHxWo+r+x/G7a4
 0IFHycWHh11OV0Etba6XnYid7VK+45v2xXFoe5cU1J72XOoaEQ6kS7D8x
X-Gm-Gg: Acq92OHMitS4CKFwsNlYzSqESKUX96TK7iX9nqO/4nTJv1p/qjxo9la9oY3hbSLkLBL
 oGGaqVPqmstvCSsQJji1haWxFEAoeYTvqNG046xqJcGqKBP8tJfB/KXYOAOD6zjt4OaroTZLIEp
 hhLt8KmGQ3nGxFphl+hef4JP4lRCPXhCUpt1MgH+xPcuPoLYvxu/pf910e0CxcFZukJk3lXppJj
 ADuLM4GN9ghhBvMBPtAbAnJ+kDen8V0hkFrr4WUL/PXIzQ4PGrwg55oxIeCp4oU2I+beil6ocKQ
 +PIjLlLiSnZbxpOfhsQqR5CLxa5AP58JlCysZSQc/BsgbuY/eE0+V00ZFhFXjGZ15Tgh+pdTgSy
 CIsYmmpChaikIpzXczpR4W3CNZUQ2n9mZjn/Yaopczuc7B0tGQzK1jP84cKRJhPaa
X-Received: by 2002:a5d:5f4f:0:b0:45e:73b4:e731 with SMTP id
 ffacd0b85a97d-45eb38a1ff1mr32786990f8f.14.1779806650730; 
 Tue, 26 May 2026 07:44:10 -0700 (PDT)
X-Received: by 2002:a5d:5f4f:0:b0:45e:73b4:e731 with SMTP id
 ffacd0b85a97d-45eb38a1ff1mr32786939f8f.14.1779806650200; 
 Tue, 26 May 2026 07:44:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6c9f6ffsm36326873f8f.1.2026.05.26.07.44.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 07:44:09 -0700 (PDT)
Message-ID: <cba87a73-0458-445e-8c12-683ca639f2de@redhat.com>
Date: Tue, 26 May 2026 16:44:08 +0200
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
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
depends on the instantiation strategy, ie. whether Peter is OK with
dynamic sysbus instantiation

Thanks

Eric
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
>          }
>      } else if (strcmp(arch, "riscv64") == 0) {
>          if (has_tcg && qtest_has_device("virtio-blk-pci")) {


