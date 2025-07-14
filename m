Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E62C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 14:45:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubKQj-0003v7-ME; Mon, 14 Jul 2025 10:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubIvt-0004ex-Ej
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:09:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubIvq-0005WH-E7
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:09:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752498557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d9N0wITcK5nFg/kSgon6hwyI1m1FIJrWlz9I+YSu+kE=;
 b=PXIiL3xHw4kAfdhNhXB/CbXkoPypLlU78sarMsyTNDdTpc0QCTD+/6bQ41i9fdENnjTSRm
 QVg9noOcsqhUtVKem1XhDe7MyT2L9Xa6XhAhu8lNCQIN/jje8Jro6iUZZmyY4UNdYHEPDK
 6iHEN4MmbgD26uODK+EiMgJ2GnHvnkQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-uxumEz_iPyO7L4SfG_E39w-1; Mon, 14 Jul 2025 09:09:15 -0400
X-MC-Unique: uxumEz_iPyO7L4SfG_E39w-1
X-Mimecast-MFC-AGG-ID: uxumEz_iPyO7L4SfG_E39w_1752498555
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a52bfda108so2163966f8f.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 06:09:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752498554; x=1753103354;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d9N0wITcK5nFg/kSgon6hwyI1m1FIJrWlz9I+YSu+kE=;
 b=syEtA0JEoMPd8LcPN52dQdz3XVKrQWc3uTvqZDlt+FwH264JeEuh6tqm4zO6fVP8Kr
 z2jRfOaKWVnFtmx+AZquQq4j85a2zhtpUg+7YvLWV3Ll0qRMWwUzva4+v/WCkbe+Ccsl
 RRMznyAVZ/lj5v99q68t++GBYXNeiicyTd3pWePdAjdu940bKmrov9jC2TndJWA2QVJS
 WcUSjwxaPADQPI5P3iOn2W4YOwSku12Ut/suifRXTj8N2dwjmc+46BeQa+bbmWzbu1G4
 KWs3gFTMcD1rvTnwjUgJXjir5nZRY5wJog/ABj5XyG62lTZbkrzK6zUFHF1kbfAWsjJW
 9nvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXq25ZWHwNJ+2Uct3BdQXAwuPWKoOnw3r7+020JFjWxRKPFU02XlVOs5oQPf2jF35omVPuq1JBCaA0j@nongnu.org
X-Gm-Message-State: AOJu0Yy2SwPMfXBBoANdrSQuoA0kkJ9gsPny9AAiQimvaaWsgLdAsIxG
 Qe5SsQ32d5ko8WFBZXDPgsGQhGcT8ucgQVQPy5lL6HjbdABUNlxis0nXJNhG0g0K2yq4soFxcVC
 F4KuUmKFgB7YyiRfqcJAHGB4jrfGYAQCSc0M3+9O4BLQtvo7E1xk3dh7N
X-Gm-Gg: ASbGncv7cR+RHKdBCi32z9SfTuBS9ICLAdIuphFwfsb/FH5Ebpxxra2sXajQfHgSySV
 ZWpLKHv9tH7tLB4byUj4zMc6utReoqhj1db5YoYcaqSo0hBTTz5IaUQIp4jQWzFXsdS663Gvwoh
 5WR/CpMOXLUjhxqRrptWGwQqEvYCskeehJzOzC+bLozeC4dq0lDzSD2YvkoVQ9ohNh0WWUlqc8F
 iUnfbwC16lS7twXftxp7SqbWcDsjyySz39zgRfuOubdTLiCmyMzpNhjtOSGJ9CdLrGvio2/BUIN
 1DbM2xWwC1uGYUO0uHEbnZqLrCGuK1+1
X-Received: by 2002:a05:6000:144b:b0:3b2:ef53:5818 with SMTP id
 ffacd0b85a97d-3b5f351e561mr10086504f8f.5.1752498554359; 
 Mon, 14 Jul 2025 06:09:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoQD9Ho3k1I73zw5t5mB19KW2sR6IMwILqGPakeR1nAQlcLLjYOj1XSNqX+jCnF2w/W+FRLQ==
X-Received: by 2002:a05:6000:144b:b0:3b2:ef53:5818 with SMTP id
 ffacd0b85a97d-3b5f351e561mr10086480f8f.5.1752498553876; 
 Mon, 14 Jul 2025 06:09:13 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45624651a09sm1472665e9.12.2025.07.14.06.09.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 06:09:13 -0700 (PDT)
Date: Mon, 14 Jul 2025 09:09:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: anisinha@redhat.com, imammedo@redhat.com, jonathan.cameron@huawei.com,
 linuxarm@huawei.com, peter.maydell@linaro.org,
 prime.zeng@hisilicon.com, qemu-devel@nongnu.org,
 shameerali.kolothum.thodi@huawei.com, wangyanan55@huawei.com,
 yangyicong@hisilicon.com, maobibo@loongson.cn, gaosong@loongson.cn,
 jiaxun.yang@flygoat.com
Subject: Re: [PATCH v6 3/4] hw/acpi/aml-build: Build a root node in the PPTT
 table
Message-ID: <20250714090807-mutt-send-email-mst@kernel.org>
References: <20250604115233.1234-1-alireza.sanaee@huawei.com>
 <20250604115233.1234-4-alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604115233.1234-4-alireza.sanaee@huawei.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Jun 04, 2025 at 12:52:32PM +0100, Alireza Sanaee wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> Currently we build the PPTT starting from the socket node and each
> socket will be a separate tree. For a multi-socket system it'll
> be hard for the OS to know the whole system is homogeneous or not
> (actually we're in the current implementation) since no parent node
> to telling the identical implementation informentation. Add a
> root node for indicating this.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> ---
>  hw/acpi/aml-build.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index 560cee12a2..76a4157a18 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -2153,12 +2153,25 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
>      int64_t socket_id = -1, cluster_id = -1, core_id = -1;
>      uint32_t socket_offset = 0, cluster_offset = 0, core_offset = 0;
>      uint32_t pptt_start = table_data->len;
> +    uint32_t root_offset;
>      int n;
>      AcpiTable table = { .sig = "PPTT", .rev = 2,
>                          .oem_id = oem_id, .oem_table_id = oem_table_id };
>  
>      acpi_table_begin(&table, table_data);
>  
> +    /*
> +     * Build a root node for all the processor nodes. Otherwise when
> +     * building a multi-socket system each socket tree is separated
> +     * and will be hard for the OS like Linux to know whether the
> +     * system is homogeneous.
> +     */
> +    root_offset = table_data->len - pptt_start;
> +    build_processor_hierarchy_node(table_data,
> +        (1 << 0) | /* Physical package */
> +        (1 << 4), /* Identical Implementation */
> +        0, 0, NULL, 0);
> +
>      /*
>       * This works with the assumption that cpus[n].props.*_id has been
>       * sorted from top to down levels in mc->possible_cpu_arch_ids().
> @@ -2175,7 +2188,7 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
>              build_processor_hierarchy_node(table_data,
>                  (1 << 0) | /* Physical package */
>                  (1 << 4), /* Identical Implementation */
> -                0, socket_id, NULL, 0);
> +                root_offset, socket_id, NULL, 0);
>          }
>  
>          if (mc->smp_props.clusters_supported && mc->smp_props.has_clusters) {


This function is also used by loongarch64, but you do not update the
loongarch64 expected files:
https://gitlab.com/mstredhat/qemu/-/jobs/10672661860

> -- 
> 2.43.0


