Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D66C3DA41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 13:54:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRuF6-0006T9-E7; Thu, 11 Jul 2024 09:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sRuF5-0006QD-Jt
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:53:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sRuF3-0003XU-T7
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:53:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720706029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BsVFyrqM6xMtC0qPFWQczYn15b+TcsSFnyWP0wMs6Pk=;
 b=d4lJejBhHK1ZxuF5fPn/a3Xw11voViXnThXpB0IyIt01D+SRdLZv62Euk3W2nBpwnERLBD
 O+Fpw9Zjpe6LbiJdH+kCk7Nxj9iHnPEfo/sc1vTWRSXht+MOVuGtFRsRn2yy31iyBsTcvC
 Ttd0FBL2WXnsqqVmol7ah0+6DrrjDMk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-mQ41sJ53MXaOagDmrNbw-A-1; Thu, 11 Jul 2024 09:53:42 -0400
X-MC-Unique: mQ41sJ53MXaOagDmrNbw-A-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-367a064472aso673155f8f.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 06:53:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720706020; x=1721310820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BsVFyrqM6xMtC0qPFWQczYn15b+TcsSFnyWP0wMs6Pk=;
 b=lUCSVmlTdNpn/OCbEajxW3mwc/uZxdCHDeYxtxO8bRCJP0czWX/o/w3ZQHQYfYvQ8C
 +juQ+kNOytqYvAgW3fWQsS0VFkos8wmvWGoE8tit305CRxaVWCl4Xfwiivmq0G24ZZxC
 7yg6xkDkNqckbOPDRFSpB5xTr/CzKuI4tSKINboP7MhD/0mqaWOaafoD8+N7G0ceJg42
 YaXsdlh3UxNzsQi3OAM4T8DgaOl0Cwz5vGEKFGMYbWt/no68gG5kES7/YtbCH26uHmfk
 v3jv2fHIVDJYdNt3IImg6EsrFzlZCDvej1WUS7zgAA1JzA+1pUuqiv/uu1a9JWChXDUN
 AA0w==
X-Gm-Message-State: AOJu0Yyfv8eDbRAwAgq31DGEuZMaY3dkvlY9ECcE0hDCVS3wivij9urp
 SOkR9rMrtXAXjfzo9N2l1YDoKPBDC/pEejJXJATwD/DuOA4Se1/HDj/jI4lrbn+i2aPWVJjpevF
 xRzNH9TPwasRJuOn6UgJxwcVy5G40IGgZhVJqdahJPLLr+xKrUAbAZGFaky/Y
X-Received: by 2002:a5d:5f46:0:b0:367:9881:7d5e with SMTP id
 ffacd0b85a97d-367cea46d84mr7625365f8f.8.1720706020668; 
 Thu, 11 Jul 2024 06:53:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGl+/7+IK1ot3XWNPHNOvqgMuA+2a4o1kffay7hjj11MlkyLw3rEfbWW04dYJDp4tz0eBf2g==
X-Received: by 2002:a5d:5f46:0:b0:367:9881:7d5e with SMTP id
 ffacd0b85a97d-367cea46d84mr7625352f8f.8.1720706020383; 
 Thu, 11 Jul 2024 06:53:40 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cdfa06absm7773138f8f.80.2024.07.11.06.53.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 06:53:40 -0700 (PDT)
Date: Thu, 11 Jul 2024 15:53:39 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>, Bin Meng
 <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, Daniel Henrique
 Barboza <dbarboza@ventanamicro.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, "Michael S . Tsirkin" <mst@redhat.com>, Ani
 Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v2 6/9] tests/qtest/bios-tables-test.c: Remove the fall
 back path
Message-ID: <20240711155339.7d8f867b@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240708114741.3499585-7-sunilvl@ventanamicro.com>
References: <20240708114741.3499585-1-sunilvl@ventanamicro.com>
 <20240708114741.3499585-7-sunilvl@ventanamicro.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon,  8 Jul 2024 17:17:38 +0530
Sunil V L <sunilvl@ventanamicro.com> wrote:

> The expected ACPI AML files are moved now under ${arch}/{machine} path.
> Hence, there is no need to search in old path which didn't have ${arch}.
> Remove the code which searches for the expected AML files under old path
> as well.
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  tests/qtest/bios-tables-test.c | 14 --------------
>  1 file changed, 14 deletions(-)
> 
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index f4c4704bab..498e0e35d9 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -267,15 +267,6 @@ static void dump_aml_files(test_data *data, bool rebuild)
>                                         data->arch, data->machine,
>                                         sdt->aml, ext);
>  
> -            /*
> -             * To keep test cases not failing before the DATA files are moved to
> -             * ${arch}/${machine} folder, add this check as well.
> -             */
> -            if (!g_file_test(aml_file, G_FILE_TEST_EXISTS)) {
> -                aml_file = g_strdup_printf("%s/%s/%.4s%s", data_dir,
> -                                           data->machine, sdt->aml, ext);
> -            }
> -
>              if (!g_file_test(aml_file, G_FILE_TEST_EXISTS) &&
>                  sdt->aml_len == exp_sdt->aml_len &&
>                  !memcmp(sdt->aml, exp_sdt->aml, sdt->aml_len)) {
> @@ -412,11 +403,6 @@ static GArray *load_expected_aml(test_data *data)
>  try_again:
>          aml_file = g_strdup_printf("%s/%s/%s/%.4s%s", data_dir, data->arch,
>                                     data->machine, sdt->aml, ext);
> -        if (!g_file_test(aml_file, G_FILE_TEST_EXISTS)) {
> -            aml_file = g_strdup_printf("%s/%s/%.4s%s", data_dir, data->machine,
> -                                       sdt->aml, ext);
> -        }
> -
>          if (verbosity_level >= 2) {
>              fprintf(stderr, "Looking for expected file '%s'\n", aml_file);
>          }


