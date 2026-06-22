Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E4A9CDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 13:02:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbeHT-0007pZ-JK; Mon, 22 Jun 2026 09:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wbeGv-0007mf-T0
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 09:01:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wbeGu-0001Ic-5C
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 09:01:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782133262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vrodGwszTIG7C0jgGIqkaadsCmlRkre1k5aFJ48rOPI=;
 b=XDCGprhRIkb7w8VMncpVV9p4EPeCqq67FYVjHvWO/Agkqe6Ey9VcfNPdZnbepe6KflCSTc
 sxzTI9OR5/Mnu8f18EqWmNSO/K8ZHrZIPaoR5G+gkPYRaN6VAehZQrGbYoY9gkfUdjwa8I
 Zg/kW0OqJcW7M3mJyvAtsT5oyzBcAG4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-ymaP5gNnPRyJWuixT3PPVg-1; Mon, 22 Jun 2026 09:01:01 -0400
X-MC-Unique: ymaP5gNnPRyJWuixT3PPVg-1
X-Mimecast-MFC-AGG-ID: ymaP5gNnPRyJWuixT3PPVg_1782133260
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-69763fd5cbcso3490283a12.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 06:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782133260; x=1782738060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vrodGwszTIG7C0jgGIqkaadsCmlRkre1k5aFJ48rOPI=;
 b=WDJOc0xWIyN/FsI/5O3Gbr2mTsIlCcFGvlon0U62LWQQpbAc84YqdRDVlgui4aA01x
 v64GCLP1HGHL6qJD8yMU/xKf3GL+xW7bqz4XgGZkqlSL0oCLshKSHCWcEI70QjE46SkT
 iPTGzLdnjYWkV2hHDA/ZoLzpHVF++VflBlGOvDMNyi2jsv50d2CpsS3THJAt0VvlLSEC
 AZOZootvzi6MaSmRFJaqZ6tSIG6kyxpMQHWeXRJQ+GxVXLRI6K/ShexPdIBkp0xHAJF7
 E34Sf0oZVhwOLXNxpn4Na+0cBlUgwdeSNTE3YFyX4XGXx7BxJnhm9g/zrPJyFZplDIRT
 R0Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782133260; x=1782738060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vrodGwszTIG7C0jgGIqkaadsCmlRkre1k5aFJ48rOPI=;
 b=fUpa+Y80r5jpcNNZjQKqzyY7IcH1dIc5jJ2ZFyBvJx9IRDVB7PCa/DkjgHUnNhIvxv
 brcx5dyMUZlHRI5BcnNYcY4sQCa2QOi7Q0einVM3QaRIA+NFhNwM59SAGXIxIzFUO4zk
 nBraY4HDQM06SGpiPRKt0I1WugNoG1mQfciPv486sNkYao3Izqvuy36d8W6I8+1saXjS
 egUxJ+altE6bL+fu9CQtrzdg3mGeLB6+gOKULkf55HxUps/srJoQthKu583jC1HkFXDY
 lCx7ETDqyGzxwfwMbLVM9lbYfKphNQl1PiOrJZvbjsPPZLCjqR4i6z8vMeGLEcv45Amd
 akIA==
X-Gm-Message-State: AOJu0YwOsf3HoCXnyaQCQ8SgIJd4yYiY0YBChJzHr1QUfb/opOeCuIx4
 741rNddwtIoqzUK/Z9sXJsHjeKjOqWnToBByNSo7R5rqcnWDJcHSF1Uqsbwzz1gzIYLZPeJc1z2
 GhH7bOe1AkY5RvTSxCwkiU/V0Md9NINrwtGZoi7kD/hhMkzd3G+nNxOapNEEfNgVv
X-Gm-Gg: AfdE7cl/n2yUp9Rm6wudOBv2q1bW7jPN6wJGtHWhEMXsbdmLEAxLlCKHZqoXmbbFVB6
 uo+TOUdIe5LeypxuMCMO+F+2FJYFb44UrZZXlotL3GpLZOWzwETT1BdKc7+E2SDA84CLCsyOcO6
 BIEeTS8TgyFEryRSzpM3K4S2nX4YxXJHK4XvXBTPaq8pyTUHjhjf7XEWr8Gga+f1JPtDicM6Ofp
 mj9fvK4D9NHiJsU1mziquXBeuu/khLL4set8YGJfdrZohQv5yOoVG0cnlwfjgg63U3sHTXxJBB2
 CeiF5/420ChylgDFM02d1rVgkgKoIMxagwlOXQSn38fLXczzBVyxtkwT116mn1aGkqgYr9E=
X-Received: by 2002:a05:6402:27c6:b0:697:973f:cf01 with SMTP id
 4fb4d7f45d1cf-697973fd036mr2605939a12.20.1782133255293; 
 Mon, 22 Jun 2026 06:00:55 -0700 (PDT)
X-Received: by 2002:a05:6402:27c6:b0:697:973f:cf01 with SMTP id
 4fb4d7f45d1cf-697973fd036mr2605631a12.20.1782133249945; 
 Mon, 22 Jun 2026 06:00:49 -0700 (PDT)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6977b86f480sm3303399a12.13.2026.06.22.06.00.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 06:00:49 -0700 (PDT)
Date: Mon, 22 Jun 2026 15:00:48 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: fanhuang <FangSheng.Huang@amd.com>
Cc: <qemu-devel@nongnu.org>, <david@kernel.org>, <mst@redhat.com>,
 <gourry@gourry.net>, <philmd@mailo.com>, <peterx@redhat.com>,
 <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>
Subject: Re: [PATCH v13 07/10] tests/acpi: add bios-tables-test case for sp-mem
Message-ID: <20260622150048.358b9b00@imammedo>
In-Reply-To: <20260619111136.3481329-8-FangSheng.Huang@amd.com>
References: <20260619111136.3481329-1-FangSheng.Huang@amd.com>
 <20260619111136.3481329-8-FangSheng.Huang@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
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

On Fri, 19 Jun 2026 19:11:33 +0800
fanhuang <FangSheng.Huang@amd.com> wrote:

> Add a q35 bios-tables-test case that boots two sp-mem devices on
> distinct NUMA nodes within the device_memory window, exercising the
> per-kind SRAT partition (per-device ENABLED entries plus HOTPLUGGABLE
> placeholders for the remaining sub-ranges).
> 
> Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  tests/qtest/bios-tables-test.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index af6d9b5136..45abd8bd8c 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -1416,6 +1416,26 @@ static void test_acpi_q35_tcg_numamem(void)
>      free_test_data(&data);
>  }
>  
> +static void test_acpi_q35_tcg_sp_mem(void)
> +{
> +    test_data data = {};
> +
> +    data.machine = MACHINE_Q35;
> +    data.arch    = "x86",
> +    data.variant = ".spmem";
> +    test_acpi_one(" -m 128M,slots=4,maxmem=1G"
> +                  " -object memory-backend-ram,id=ram0,size=128M"
> +                  " -numa node,nodeid=0,memdev=ram0"
> +                  " -numa node,nodeid=1"
> +                  " -numa node,nodeid=2"
> +                  " -object memory-backend-ram,id=spm0,size=128M"
> +                  " -object memory-backend-ram,id=spm1,size=128M"
> +                  " -device sp-mem,id=sp0,memdev=spm0,node=1"
> +                  " -device sp-mem,id=sp1,memdev=spm1,node=2",
> +                  &data);
> +    free_test_data(&data);
> +}
> +
>  static void test_acpi_q35_kvm_xapic(void)
>  {
>      test_data data = {};
> @@ -2807,6 +2827,7 @@ int main(int argc, char *argv[])
>              if (strcmp(arch, "i386")) {
>                  qtest_add_func("acpi/q35/memhp", test_acpi_q35_tcg_memhp);
>                  qtest_add_func("acpi/q35/dimmpxm", test_acpi_q35_tcg_dimm_pxm);
> +                qtest_add_func("acpi/q35/sp-mem", test_acpi_q35_tcg_sp_mem);
>                  qtest_add_func("acpi/q35/acpihmat",
>                                 test_acpi_q35_tcg_acpi_hmat);
>                  qtest_add_func("acpi/q35/mmio64", test_acpi_q35_tcg_mmio64);


