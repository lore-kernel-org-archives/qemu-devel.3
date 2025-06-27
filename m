Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE2DC7EE31
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 13:59:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV9aP-0005EV-9d; Fri, 27 Jun 2025 09:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uV9aN-0005EC-C0
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 09:57:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uV9aL-0004Iw-DP
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 09:57:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751032662;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SVxajDd+Fe0j47/wXGGNaINiJU8SnVsrI0xkdeEuuEA=;
 b=dcKALcNLsBoFkxj/KwlweS9Yga+XQN/gZgQiW+63CmndPxKuo/jkcAMd/J9OgjxhzJqG9i
 OhFOqXP/x6E0mK+TPdEZYdLICkD1FVT6Mw5wkB/igRQbASOwoaIGqXayVgiM/Wn03FhwTd
 lUoBH9Uuiubv+s3UNIIOCmQPaO1NXWk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-cyZUnDkBOH2xGII1mwvDHg-1; Fri, 27 Jun 2025 09:57:41 -0400
X-MC-Unique: cyZUnDkBOH2xGII1mwvDHg-1
X-Mimecast-MFC-AGG-ID: cyZUnDkBOH2xGII1mwvDHg_1751032660
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a52bfda108so1086251f8f.3
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 06:57:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751032660; x=1751637460;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SVxajDd+Fe0j47/wXGGNaINiJU8SnVsrI0xkdeEuuEA=;
 b=mXR4928IniIHqVCoqGYSSX/vlDpI6xHkCP25YWwzo2uotK91NObHZr46wS5zd8aipG
 0kTU6j/fr5REQWYILw6b44/FF3wOftFdeU/2fv1u4zvTv58SB3VzGu1SyNj3TMRYANOG
 E6JDtF4i9Pm6Xa/0P9inM0fYBZMo3g1qTpx7hs84tG3nN1OjGH4gCWdhWMGWSHoiMX+j
 uwqanwVExZkldehXOoQGHO2zUth+AAaKEwjgZBRnspmR78qcwm8nyS4kDQ79gJ/wbpmR
 rAjTk6TK01sF0Yw+fvC92PkPxJVraL87bkJlWt2l7zlThJA12DMTkUUAd2Gz2RP6yqYl
 n+mA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWM40nbczIGfP2XbYRbDClC3V0hCUGclexmtZKJALtxH8sA2i3LTaTi/3t90zsgexjqLSQ1I7hg5bfh@nongnu.org
X-Gm-Message-State: AOJu0YyRhzBpOi4LgL7wT6qJ/qKagm1A8/tKIKfALViywsnpDV62LWG8
 6RIeMHaGsF2T5zVUmdmwagEIWGyO/2AO5xUKUAwgoyTUL1rMzOQJnMeTUE6q/njBnmVyAej3mia
 EZ3qFqepS8RV/EkznKtbMmHXzn8o1ZfUNOwNiyL3nx8kNcG9uU7claeBX
X-Gm-Gg: ASbGncvq6dWyQFmGNZEvL7ukJMNvRVkY+e/vpwugQV3vJsIAmJIEbpuG7FlVpKi6kjd
 5wEQjkwMAfUEXkMq1XhHBMKBysZnfJjGD+p/SEPxad7O/gVvg69k24KWqkKlVd1GDyELvqO+RRw
 0RyhWLrCq0n9VV3Ac/gG3eK+4w0ubrfvZhtJ4eQjmQHQch/Tzem9ivOmolUpb5c4JBeDRcvEqQ3
 YWJTM9Go96snk/HGCafGo9Id20xfqdluZR1CTPcn+DKRlZJ4WPtFF+y4qCEWgAPJ2szghfXN6zO
 /4peooRkY24ABhbjnYnDQlSEe98lR7B97NXooEpDKOXqtAyX16h5ndAegSvxVi9eU8qs1A==
X-Received: by 2002:a5d:5f49:0:b0:3a3:7ba5:9618 with SMTP id
 ffacd0b85a97d-3a8ffccac13mr3260995f8f.29.1751032659733; 
 Fri, 27 Jun 2025 06:57:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTq1rqDBj90i5LDKMwj91izDc8lGYTYbrczPkoI4bqzIS7PBC/bbzi28Njv7RE4dIcJx3Wjg==
X-Received: by 2002:a5d:5f49:0:b0:3a3:7ba5:9618 with SMTP id
 ffacd0b85a97d-3a8ffccac13mr3260974f8f.29.1751032659283; 
 Fri, 27 Jun 2025 06:57:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a87e947431sm2812108f8f.0.2025.06.27.06.57.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Jun 2025 06:57:38 -0700 (PDT)
Message-ID: <adf5e6e5-e0e3-44f9-949c-620aea3edfa0@redhat.com>
Date: Fri, 27 Jun 2025 15:57:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/9] hw/arm/virt-acpi-build: Improve comment in
 build_iort
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 philmd@linaro.org, mst@redhat.com
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, udo@hypervisor.org,
 ajones@ventanamicro.com, peter.maydell@linaro.org, imammedo@redhat.com,
 anisinha@redhat.com
References: <20250623135749.691137-1-gustavo.romero@linaro.org>
 <20250623135749.691137-5-gustavo.romero@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250623135749.691137-5-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Gustavo,

On 6/23/25 3:57 PM, Gustavo Romero wrote:
> When building the Root Complex table, the comment about the code that
s/table/node? or do you refer to the IORT table?
> maps the RC node to SMMU node is misleading because it reads
> "RC -> SMMUv3 -> ITS", but the code is only mapping the RCs IDs to the
> SMMUv3 node. The step of mapping from the SMMUv3 IDs to the ITS Group
> node is actually defined in another table (in the SMMUv3 node). So
> change the comment to read "RC -> SMMUv3" instead.
>
> Signed-off-by Gustavo Romero <gustavo.romero@linaro.org>
> ---
>  hw/arm/virt-acpi-build.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
>
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 9eee284c80..e9cd3fb351 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -370,7 +370,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>          /* DeviceID mapping index (ignored since interrupts are GSIV based) */
>          build_append_int_noprefix(table_data, 0, 4);
>  
> -        /* output IORT node is the ITS group node (the first node) */
> +        /* Output IORT node is the ITS Group node (the first node) */
>          build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET);
>      }
>  
> @@ -407,23 +407,36 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      if (vms->iommu == VIRT_IOMMU_SMMUV3) {
>          AcpiIortIdMapping *range;
>  
> -        /* translated RIDs connect to SMMUv3 node: RC -> SMMUv3 -> ITS */
> +        /*
> +         * Map RIDs (input) from RC to SMMUv3 nodes: RC -> SMMUv3.
> +         *
> +         * N.B.: The mapping from SMMUv3 to ITS Group node (SMMUv3 -> ITS) is
> +         * defined in the SMMUv3 table, where all SMMUv3 IDs are mapped to the
s/table/node
> +         * ITS Group node.
> +         */
>          for (i = 0; i < smmu_idmaps->len; i++) {
>              range = &g_array_index(smmu_idmaps, AcpiIortIdMapping, i);
> -            /* output IORT node is the smmuv3 node */
> +            /* Output IORT node is the SMMUv3 node. */
>              build_iort_id_mapping(table_data, range->input_base,
>                                    range->id_count, smmu_offset);
>          }
>  
> -        /* bypassed RIDs connect to ITS group node directly: RC -> ITS */
> +        /*
> +         * Map bypassed (don't go throught the SMMU) RIDs (input) to ITS Group
> +         * node directly: RC -> ITS.
> +         */
>          for (i = 0; i < its_idmaps->len; i++) {
>              range = &g_array_index(its_idmaps, AcpiIortIdMapping, i);
> -            /* output IORT node is the ITS group node (the first node) */
> +            /* Output IORT node is the ITS Group node (the first node). */
>              build_iort_id_mapping(table_data, range->input_base,
>                                    range->id_count, IORT_NODE_OFFSET);
>          }
>      } else {
> -        /* output IORT node is the ITS group node (the first node) */
> +        /*
> +         * Map all RIDs (input) to ITS Group node directly, since there is no
> +         * SMMU: RC -> ITS.
> +         * Output IORT node is the ITS Group node (the first node).
> +         */
>          build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET);
>      }
>  
Besides:
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Eric


