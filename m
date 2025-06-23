Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7CCDC7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 13:48:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uThX5-0006JF-0q; Mon, 23 Jun 2025 09:48:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uThX3-0006J6-CZ
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 09:48:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uThWz-0005iF-LC
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 09:48:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750686495;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HlQjehcqdNB7xiQO3FsQcefJ7k3zoWvL3x4fwYab4dU=;
 b=Ezp+rvt5FX4LRhG4JmXAIJVBzzAv0Wr/UZP2G/Ew0vt9GCkidb3HxYTgPBPp9csY6qXLYg
 dsYx9lumPz03OHJyG9zQl7+VhNKanDf7FXkc0nDxWPl9Kc4ThUeyBuLpVbIRUCHTQUYGgW
 0aCemN6SMJgN/cpvoKbhks9Nd4Hhbcg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-iHv_z79HO8qqK_QdIZ0Ibw-1; Mon, 23 Jun 2025 09:48:13 -0400
X-MC-Unique: iHv_z79HO8qqK_QdIZ0Ibw-1
X-Mimecast-MFC-AGG-ID: iHv_z79HO8qqK_QdIZ0Ibw_1750686492
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-450d64026baso26009735e9.1
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 06:48:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750686492; x=1751291292;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HlQjehcqdNB7xiQO3FsQcefJ7k3zoWvL3x4fwYab4dU=;
 b=X0MNBD1veTnsIC00N0y1i4bjbFQd+0rmCCkDRiOqYzc2UKvxG47/D1WezO43tu07r+
 LTtcsI3fo8bTm1uI0ad0muM8gWOqMptBUYiNp1OT3Jai8p3gtMuSRTlS7ay6bl/D7X/H
 RSx4OKyt7CU0P/OKhcUueMSWmbujlEFTvbJcdnK+GOtBlQlCRynG9FGnSaBGIDfz92z9
 x7R70d0K5BGEOIw3cCKkxapXduSe+qBeKHX1q4RvMlKbNJ6TXPA2Ki638McxCCA+oca6
 ZHCiC/jKXcnsgg6VgjN8U2s4I2XeBToK+WeYAdrMo+yiKTFcfe5OuUmbSXcKTnyk0DEQ
 IZWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyPRj5noXCV4OKfWnKATLXjXODur7mmzxmX+hP+k5GGotzPjSsn2tRvDXKRUqegfsjTxU0TKfgZyjg@nongnu.org
X-Gm-Message-State: AOJu0Yzc5Mj3aN2hrmIVIysjJruhkz9Rxgmgh6od1p0Upq5H/M71Hs+8
 B2RaaMkR595yIakWEq3Ro7OkuB1pWJxsxpIDzz3T1rBovtmw33r3vjHTjLTESAc/K4JDKRsMOfj
 VAIajnASgsbf0i+469Xiw/LKUG/fQAGEFeaFmW54aM+heICZCiyUx3602
X-Gm-Gg: ASbGncsGD2rTBd0sbCCv1UPTF6eAeZMNOKyvrou22WqCZrpiHfU2u2wQVH3yPILMAH8
 rw7jGQSypIxp8xJjQt4NP4jNFtL6jmIWXtLpFpoe8u9T//TbZDJm0UcLoRZRM+WAiYdFYyZn4Jm
 opmuX3i4ICFRh2nDaBnrJwGrD+tVwNXVgUjjOIB8wAmK6kAjUrtbiQ4mSUeGj6Bazd9VMmomYpx
 ia5wT/6KNUyfJdFE5vdVVg+9PZQ1wlMCr3yeXnEOFfCGQ3i66hs48bmJ9IDdxMHCsYTskF5g5Zl
 bm8mtVhGUMF6p5FD+NYiNbJMrrzQnsco0zuqnSH5H2WNb3FNaYAlq+D5D47yktT7c+8U1g==
X-Received: by 2002:a05:600c:1d14:b0:43c:e7ae:4bcf with SMTP id
 5b1f17b1804b1-4536b4be314mr81279965e9.0.1750686491980; 
 Mon, 23 Jun 2025 06:48:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGdhGYuPOCUU3FW8uE1XjdPKXh1yRWyJvkiaVlnwRTg34N7PD5EMfvNpMZp9k+Z+edo9ltTA==
X-Received: by 2002:a05:600c:1d14:b0:43c:e7ae:4bcf with SMTP id
 5b1f17b1804b1-4536b4be314mr81279705e9.0.1750686491532; 
 Mon, 23 Jun 2025 06:48:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535ef6edbesm143471385e9.20.2025.06.23.06.48.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jun 2025 06:48:10 -0700 (PDT)
Message-ID: <c15a7312-09e4-4026-b27b-55d19612bf23@redhat.com>
Date: Mon, 23 Jun 2025 15:48:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/19] intel_iommu: Refresh pasid bind when either SRTP
 or TE bit is changed
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20250620071813.55571-1-zhenzhong.duan@intel.com>
 <20250620071813.55571-18-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250620071813.55571-18-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
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

Hi Zhenzhong,

On 6/20/25 9:18 AM, Zhenzhong Duan wrote:
> From: Yi Liu <yi.l.liu@intel.com>
>
> When either 'Set Root Table Pointer' or 'Translation Enable' bit is changed,
> the pasid bindings on host side become stale and need to be updated.
>
> Introduce a helper function vtd_refresh_pasid_bind() for that purpose.
nit I would avoid introducing yet another terminology, ie. refresh. If
it is a replay let's keep replay and precisely explain what the replay does.
vtd_replay_pasid_bindings?


>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/i386/intel_iommu.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index d1fa395274..0b322078cc 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -90,6 +90,7 @@ struct vtd_iotlb_key {
>  
>  static void vtd_address_space_refresh_all(IntelIOMMUState *s);
>  static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n);
> +static void vtd_refresh_pasid_bind(IntelIOMMUState *s);
>  
>  static void vtd_pasid_cache_reset_locked(IntelIOMMUState *s);
>  static void vtd_pasid_cache_sync(IntelIOMMUState *s,
> @@ -3066,6 +3067,7 @@ static void vtd_handle_gcmd_srtp(IntelIOMMUState *s)
>      vtd_set_clear_mask_long(s, DMAR_GSTS_REG, 0, VTD_GSTS_RTPS);
>      vtd_reset_caches(s);
>      vtd_address_space_refresh_all(s);
> +    vtd_refresh_pasid_bind(s);
>  }
>  
>  /* Set Interrupt Remap Table Pointer */
> @@ -3100,6 +3102,7 @@ static void vtd_handle_gcmd_te(IntelIOMMUState *s, bool en)
>  
>      vtd_reset_caches(s);
>      vtd_address_space_refresh_all(s);
> +    vtd_refresh_pasid_bind(s);
>  }
>  
>  /* Handle Interrupt Remap Enable/Disable */
> @@ -3813,6 +3816,26 @@ static void vtd_replay_guest_pasid_bindings(IntelIOMMUState *s,
>      }
>  }
>  
> +static void vtd_refresh_pasid_bind(IntelIOMMUState *s)
> +{
> +    VTDPASIDCacheInfo pc_info = { .error_happened = false,
> +                                  .type = VTD_PASID_CACHE_GLOBAL_INV };
> +
> +    /*
> +     * Only when dmar is enabled, should pasid bindings replayed,
> +     * otherwise no need to replay.
> +     */
I am not sure the above comment is necessary.
> +    if (!s->dmar_enabled) {
> +        return;
> +    }
> +
> +    if (!s->flts || !s->root_scalable) {
> +        return;
> +    }
> +
> +    vtd_replay_guest_pasid_bindings(s, &pc_info);
> +}
> +
>  /*
>   * This function syncs the pasid bindings between guest and host.
>   * It includes updating the pasid cache in vIOMMU and updating the
Thanks

Eric


