Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB12CCF34A9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 14:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swN6d-0004bD-HX; Thu, 03 Oct 2024 10:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1swN6P-0004aF-BN
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 10:46:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1swN6M-0002x1-Qu
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 10:46:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727966805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ecke0VAUjbY2qs/OU5TI2Vftyi8DYGdyyeDK1FIBoPU=;
 b=Jhr/FkE0slFwAl/RwMkhab6h3Zpq2Jk/7XRf6gdWuUdgmzKO9auw+SzAUQ1DW3euG1a3Ib
 WA+qKYWI3O5aWEk1FgiX7qkIV9o2X75RVqCREcNraEJ8WtUBx8fUW7GjAlEp4Azoga0xzt
 ZpIPGP68p0FQiK8PnAD96dYGBM8yQ64=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-Actu20jIN_mUJxFvPYZ5Qg-1; Thu, 03 Oct 2024 10:46:44 -0400
X-MC-Unique: Actu20jIN_mUJxFvPYZ5Qg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37ce14d621aso559256f8f.3
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 07:46:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727966803; x=1728571603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ecke0VAUjbY2qs/OU5TI2Vftyi8DYGdyyeDK1FIBoPU=;
 b=CJyQiDQwGCqpwkDc0SSZwF4uZwNdq7pcuTer4kAahMGLtFRuC4ARXcxqhEc5A6ILF0
 6fiZk0f0GHst5c+LVHkcchJJ1Gt8du8j56kn6WS3oLDU5sQ+jiAvOzp0fqs2m5bTt8RJ
 LYTQ0QBtCjWHrxIIy60dhUKSIeOL20EiNptUM/gKI6+dygdjsYLTEeYpT6MFhzJld2JT
 QdXsicjq52X760HejMa4PsnkbIPt7eletCSiuKLxzvELJnDg/L7q89DGcI/gsf4F4ZGK
 6U7O/Hxlg/MqOP14eaQkWM5ROlIe+vIJJuA4+yvmtKcObxrMZdOy1iyN8X2I2Mvwz4yq
 p9Eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWT5Rmqak4eLZhJFi1M/n+OJAbasH0suBe+R7nX1C96IAvzS2wSmxcYxoSNxS5tWfmlZdn06JoDE4ax@nongnu.org
X-Gm-Message-State: AOJu0YzR/nbxSavUY8G3ud/7bWhNIC7+GcOpFyVhvMOFMFCC+mb1dhkh
 yi/GPGNUUYpOyUOL6acjRnsdSR15Bh1wF9g/buH7tRzd4drY+tho5HFXio78Ai7R77Wz2/8xl5m
 HL4e8uKuxF5gPq0wUeZzAygAY3WJcWBpAFi+BVkxmwmsRFY1+OOw/
X-Received: by 2002:adf:f34f:0:b0:37c:d200:4fea with SMTP id
 ffacd0b85a97d-37cfb9d1efdmr4040751f8f.34.1727966803418; 
 Thu, 03 Oct 2024 07:46:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEb8ArqDAhHc3fjm09LTdhgfEQWhxfi2zK/99j6Ugl5pfcjb3RFuJs9QcFnDuRgQPhv30R5Aw==
X-Received: by 2002:adf:f34f:0:b0:37c:d200:4fea with SMTP id
 ffacd0b85a97d-37cfb9d1efdmr4040738f8f.34.1727966802988; 
 Thu, 03 Oct 2024 07:46:42 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d0823ed00sm1414702f8f.49.2024.10.03.07.46.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 07:46:42 -0700 (PDT)
Date: Thu, 3 Oct 2024 16:46:41 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Shannon
 Zhao <shannon.zhaosl@gmail.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH RFC 5/5] arm/virt-acpi-build: Properly handle virt-9.1
Message-ID: <20241003164641.76e5bffe@imammedo.users.ipa.redhat.com>
In-Reply-To: <2b5b4e57eb5332c83789d4bd0f01214861cc7f0a.1727782588.git.mchehab+huawei@kernel.org>
References: <cover.1727782588.git.mchehab+huawei@kernel.org>
 <2b5b4e57eb5332c83789d4bd0f01214861cc7f0a.1727782588.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue,  1 Oct 2024 13:42:50 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> A virt-9.1 machine can have only one source ID.

and here it is.
I'd just merge this into previous patch

> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/arm/virt-acpi-build.c | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 476c365851c4..8036eb5953d0 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -894,6 +894,10 @@ static const AcpiNotificationSourceId hest_ghes_notify[] = {
>      {ACPI_HEST_SRC_ID_SYNC, ACPI_GHES_NOTIFY_SEA},
>  };
>  
> +static const AcpiNotificationSourceId hest_ghes_notify_9_1[] = {
> +    {ACPI_HEST_SRC_ID_QMP, ACPI_GHES_NOTIFY_GPIO},
> +};
> +
>  static
>  void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>  {
> @@ -947,10 +951,28 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>      build_dbg2(tables_blob, tables->linker, vms);
>  
>      if (vms->ras) {
> -        acpi_add_table(table_offsets, tables_blob);
> -        acpi_build_hest(tables_blob, tables->hardware_errors, tables->linker,
> -                        hest_ghes_notify, ARRAY_SIZE(hest_ghes_notify),
> -                        vms->oem_id, vms->oem_table_id);
> +        AcpiGhesState *ags;
> +        AcpiGedState *acpi_ged_state;
> +
> +        acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
> +                                                       NULL));
> +        if (acpi_ged_state) {
> +            ags = &acpi_ged_state->ghes_state;
> +
> +            acpi_add_table(table_offsets, tables_blob);
> +
> +            if (!ags->hest_lookup) {
> +                acpi_build_hest(tables_blob, tables->hardware_errors,
> +                                tables->linker, hest_ghes_notify_9_1,
> +                                ARRAY_SIZE(hest_ghes_notify_9_1),
> +                                vms->oem_id, vms->oem_table_id);
> +            } else {
> +                acpi_build_hest(tables_blob, tables->hardware_errors,
> +                                tables->linker, hest_ghes_notify,
> +                                ARRAY_SIZE(hest_ghes_notify),
> +                                vms->oem_id, vms->oem_table_id);
> +            }
> +        }
>      }
>  
>      if (ms->numa_state->num_nodes > 0) {


