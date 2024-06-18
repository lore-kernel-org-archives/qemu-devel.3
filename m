Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E1CC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 21:15:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJgAD-0001BY-F9; Tue, 18 Jun 2024 17:14:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sJgAB-0001B9-EC
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 17:14:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sJgA8-0002FZ-Hv
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 17:14:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718745282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BoSb4Gh9m4pXf7LCM3npunPqVUqqXitMGx9y++8meKU=;
 b=HZYXCp/hPXlBWJNKvwQRli/aiRpu71VRSaPwngZFxRYuqapxF3hjQuOj/Ap8JhH9Jjob7a
 6i0QX4ETH3ZcWN+nc9E+fKZvRjaZ3G93gQpxm5jgPAk918pBW4wVlXqOGgzRinQzvjrLfW
 qvyxm3KIW9y7L74cw9AwWeEWHQHm2js=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-neh4K-uiNneUvEwHuROmjA-1; Tue, 18 Jun 2024 17:14:40 -0400
X-MC-Unique: neh4K-uiNneUvEwHuROmjA-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-52c944cf9b5so4380919e87.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 14:14:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718745278; x=1719350078;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BoSb4Gh9m4pXf7LCM3npunPqVUqqXitMGx9y++8meKU=;
 b=a5MHXyl/k7JHFkCeW+NNbm3yW6WdMcLcaNSTbq8ZljB+ZVJ6rJzb3/Og59WJO3rmmd
 FM5oOET2rZX12e+HCVX13HshheTfJzpkWECgpNIAO1GPFXwZthtBeGfyQpoinDA/PFtm
 ZLPgUI8SpQzt3MAmLK+QGfml65h9q7ydqY9AMtRParzWzijEbI20TnPXLBjKrBDiiGuJ
 OxcI9ocLrLQc2x1BL0JWOxSnfAe9Q2zp7V+uveSXIn46XqlR+KEi5Fsn/X6TjrIVMnrC
 MpB0QK3ycc3qXDqZJGGF2rRJtTF0Og+q5jAwKelAJhFUhnDffWS4hd3LBQw4mqF6aQqI
 zCcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxKNh55tY9VE7ZFDZgv3z3+XDzlQL168m5Tgn+u76I9MMX9b8WF1gj6TOqpP2YIBrNJ6JoEZNVOUvI5inCd7dYx4Z/DB8=
X-Gm-Message-State: AOJu0YxInn9eejSXSzPjVDbI36xMmaXq35Wvyq41krDOIZ95QCHejU6r
 L5YAwSfL/LKfXNarJiD6GZ6AwkAVFXXiOe58U4n7a+rfmfHYRa2dUs2/hGhdH3ulC0IASVRLMvS
 y1BcglMUBLLWmWHbPedOtf0tR4PemP+lbN9Y1lC5Bfwgort6nLcHuy2Zxap9/
X-Received: by 2002:ac2:5ded:0:b0:52c:8aad:5fc6 with SMTP id
 2adb3069b0e04-52ccaa3293fmr371625e87.15.1718745278488; 
 Tue, 18 Jun 2024 14:14:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECD+q2UTX4Ho+pkWTpmFe4WAU1Xw9cUBanO6+QrgQ+wbP5mAOdPNNRGgE8aBxixV09ZxuKug==
X-Received: by 2002:ac2:5ded:0:b0:52c:8aad:5fc6 with SMTP id
 2adb3069b0e04-52ccaa3293fmr371614e87.15.1718745277685; 
 Tue, 18 Jun 2024 14:14:37 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:67bf:ebbb:9f62:dc29:2bdc])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f6320bcdsm204372055e9.35.2024.06.18.14.14.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 14:14:37 -0700 (PDT)
Date: Tue, 18 Jun 2024 17:14:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: peter.maydell@linaro.org, wangxingang5@huawei.com,
 shannon.zhaosl@gmail.com, imammedo@redhat.com, anisinha@redhat.com,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v3] hw/arm/virt-acpi-build: Fix id_count in
 build_iort_id_mapping
Message-ID: <20240618171311-mutt-send-email-mst@kernel.org>
References: <20240618211110.922809-1-nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618211110.922809-1-nicolinc@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, Jun 18, 2024 at 02:11:10PM -0700, Nicolin Chen wrote:
> It's observed that Linux kernel booting with the VM reports a "conflicting
> mapping for input ID" FW_BUG.
> 
> The IORT doc defines "Number of IDs" to be "the number of IDs in the range
> minus one", while virt-acpi-build.c simply stores the number of IDs in the
> id_count without the "minus one". Meanwhile, some of the callers pass in a
> 0xFFFF following the spec. So, this is a mismatch between the function and
> its callers.
> 
> Fix build_iort_id_mapping() by internally subtracting one from the pass-in
> @id_count. Accordingly make sure that all existing callers pass in a value
> without the "minus one", i.e. change all 0xFFFFs to 0x10000s.
> 
> Also, add a few lines of comments to highlight this change along with the
> referencing document for this build_iort_id_mapping().
> 
> Fixes: 42e0f050e3a5 ("hw/arm/virt-acpi-build: Add IORT support to bypass SMMUv3")
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
> Changelog
> v3:
>  * Added "-1" internally in build_iort_id_mapping() instead
>  * Added comments to highlight this and referencing doc
> v2:
>  https://lore.kernel.org/all/20240617223945.906996-1-nicolinc@nvidia.com/
>  * Moved "-1" to the same line of id_count calculation
>  * Added "+1" to the next_range.input_base calculation
> v1:
>  https://lore.kernel.org/all/20240613234802.828265-1-nicolinc@nvidia.com/
> 
>  hw/arm/virt-acpi-build.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index c3ccfef026..ee6f56b410 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -209,12 +209,20 @@ static void acpi_dsdt_add_tpm(Aml *scope, VirtMachineState *vms)
>  #define ROOT_COMPLEX_ENTRY_SIZE 36
>  #define IORT_NODE_OFFSET 48
>  
> +/*
> + * Input Output Remapping Table (IORT) -- Table 4 ID mapping format
> + * Conforms to "IO Remapping Table System Software on ARM Platforms",
> + * Document number: ARM DEN 0049E.b, Feb 2021
> + *
> + * Note that @id_count will be internally subtracted by one, following
> + * the IORT spec.
> + */
>  static void build_iort_id_mapping(GArray *table_data, uint32_t input_base,
>                                    uint32_t id_count, uint32_t out_ref)
>  {
> -    /* Table 4 ID mapping format */
>      build_append_int_noprefix(table_data, input_base, 4); /* Input base */
> -    build_append_int_noprefix(table_data, id_count, 4); /* Number of IDs */
> +    /* Number of IDs - The number of IDs in the range minus one */
> +    build_append_int_noprefix(table_data, id_count - 1, 4);
>      build_append_int_noprefix(table_data, input_base, 4); /* Output base */
>      build_append_int_noprefix(table_data, out_ref, 4); /* Output Reference */
>      /* Flags */
> @@ -306,8 +314,8 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>          }
>  
>          /* Append the last RC -> ITS ID mapping */
> -        if (next_range.input_base < 0xFFFF) {
> -            next_range.id_count = 0xFFFF - next_range.input_base;
> +        if (next_range.input_base < 0x10000) {
> +            next_range.id_count = 0x10000 - next_range.input_base;
>              g_array_append_val(its_idmaps, next_range);
>          }

A change of logic here - I think the new one is right and old
one was wrong, actually. Right?

>  
> @@ -366,7 +374,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>          build_append_int_noprefix(table_data, 0, 4);
>  
>          /* output IORT node is the ITS group node (the first node) */
> -        build_iort_id_mapping(table_data, 0, 0xFFFF, IORT_NODE_OFFSET);
> +        build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET);
>      }
>  
>      /* Table 17 Root Complex Node */
> @@ -419,7 +427,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>          }
>      } else {
>          /* output IORT node is the ITS group node (the first node) */
> -        build_iort_id_mapping(table_data, 0, 0xFFFF, IORT_NODE_OFFSET);
> +        build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET);
>      }
>  
>      acpi_table_end(linker, &table);
> -- 
> 2.43.0


