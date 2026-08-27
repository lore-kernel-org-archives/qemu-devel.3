Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AEBEC61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 12:25:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzZAb-0006Fb-IH; Thu, 27 Aug 2026 08:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wzZAZ-0006F0-Nr
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 08:25:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wzZAY-0003mO-7o
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 08:25:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787833521;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GAd7JjxuKF4O5Z9JpLPWkK2/P2bhhQECbF3uyXhTb2c=;
 b=WWZtutFEbHVPYGxkr/yNXjZJ7CgP7NRihxTkJou88rsLfxlCz65A5fZv3a3aOycJdknkhJ
 2O3U/pOB/9nWz1N2IRjx0csE5duk1t3kTXxlZHa+5vMeaerVXAJmiwJ4H2PhP5apIB91Wu
 zKPNCEr6zWjgRvzmWDwkUTI5VifJC+g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-w-H0ipc_MCKQKmxsoUdPag-1; Thu, 27 Aug 2026 08:25:18 -0400
X-MC-Unique: w-H0ipc_MCKQKmxsoUdPag-1
X-Mimecast-MFC-AGG-ID: w-H0ipc_MCKQKmxsoUdPag_1787833517
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-47f8f8fde2dso1224985f8f.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 05:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787833517; x=1788438317;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GAd7JjxuKF4O5Z9JpLPWkK2/P2bhhQECbF3uyXhTb2c=;
 b=S1cmtcW5S0060XSi2fcINiEmL+CV6smBwu4NVgYllK8Kfj3b3STRUGg2inq5NoOIkH
 78V22V7+XDf/AW71GVvAwJgmBeQcLLfwk+gD+3ctZvQGx9dR+iHO1IZdqJVLWIqsry1z
 rAkkcYfSDYOGKnw6EDoV7vuu/NRxcWa/KSVvIxKEerPv8mwgonLXrYkNVUOi5a21iT1x
 UBsWGc+M4seAS/2wZSI6KMbU8TVedT+sbAYgUB0i/VPDvjSs3DRB6TUwdDSI2HAvKghw
 YzTTYBs3JjEkYm0DXu3PLDtOoT1IiX9BFYLnn1sxUsQLKIMZwD3N7TZPx46OvgyKvTmM
 7+Sg==
X-Gm-Message-State: AFuF++nq7VxZhCmQV4NNcnSh+wn3/kKozkvEi7HqKw81vvsDWCLaBIwt
 +glY1mBoVKkBuolZR0XgTlJHAXeWNjJeatbJkKewnYZ71xWW/QXI0qbeLm6E/2drnTxQegX0sVj
 kfgZCT9QTlDZ87nF7y00lbrhIMvnLPxnRAgxu+NY79O8q+sUcA/CLxqnk
X-Gm-Gg: AR+sD13mReDWQnP+mm49JOQ1jwT4ETB0/PadRZC/fDzfDCJOzMhWS2h0fSIkrZVdJDU
 DEWJlQesUDcHQkynv2QGvItzdEkwc7egNfZbWGAnYE0+/LILpzy+NUf0Ui924t+w6R5ipVHC5M9
 6aEQ0DFS+OOQMrSvcU4QkdlxGU5ARtH4I4eI+avFesQouRCKajmO9H9sVQ9kIgEfoklgHEKkiQa
 dwOI91Qw4Gs0Wp6QuIEeBe/m8dKM8QBN6O2BCCWEjRH3VUKK+N1Re3c6/ESY/QfVn/I1fVYz4ui
 A35nVm/B5SuJEU7NwKTDuAmiZQ85JuIzxhgziDT/tmwGnUc4f43cGfEq6JJY3VH6Gu4Xs5p/w5p
 Lb13NZKs5n3q5V+c9gTU3hcPYbBMu24p740EiWnkEvWL4b0tm
X-Received: by 2002:a05:6000:4605:b0:482:e2f2:19c9 with SMTP id
 ffacd0b85a97d-482e2f21dc2mr19449654f8f.2.1787833517159; 
 Thu, 27 Aug 2026 05:25:17 -0700 (PDT)
X-Received: by 2002:a05:6000:4605:b0:482:e2f2:19c9 with SMTP id
 ffacd0b85a97d-482e2f21dc2mr19449551f8f.2.1787833516808; 
 Thu, 27 Aug 2026 05:25:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e27ab569sm8617295f8f.16.2026.08.27.05.25.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 05:25:16 -0700 (PDT)
Message-ID: <74a383fb-e124-44ea-95d7-63c6add2a53c@redhat.com>
Date: Thu, 27 Aug 2026 14:25:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 09/28] hw/arm/smmu: Add PTE NS/NSTable helpers
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162446.2806393-4-tangtao1634@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260813162446.2806393-4-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 8/13/26 6:24 PM, Tao Tang wrote:
> Add helper macros for NS and NSTable bits and group PTE attribute
> accessors for clarity. No functional change beyond the new helpers.
>
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric


> ---
>  hw/arm/smmu-internal.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/hw/arm/smmu-internal.h b/hw/arm/smmu-internal.h
> index d143d296f34..004abd58bca 100644
> --- a/hw/arm/smmu-internal.h
> +++ b/hw/arm/smmu-internal.h
> @@ -58,16 +58,27 @@
>      ((level == 3) &&                                                    \
>       ((pte & ARM_LPAE_PTE_TYPE_MASK) == ARM_LPAE_L3_PTE_TYPE_PAGE))
>  
> +/* Stage 1 attribute fields in VMSAv8-64 Block and Page descriptors */
> +/* Non-secure bit */
> +#define PTE_NS(pte) \
> +    (extract64(pte, 5, 1))
> +
>  /* access permissions */
>  
>  #define PTE_AP(pte) \
>      (extract64(pte, 6, 2))
>  
> +/* Stage 1 VMSAv8-64 Table descriptor fields */
>  #define PTE_APTABLE(pte) \
>      (extract64(pte, 61, 2))
>  
> +#define PTE_NSTABLE(pte) \
> +    (extract64(pte, 63, 1))
> +
> +/* Access flag: defined for both Block/Page and Table descriptors. */
>  #define PTE_AF(pte) \
>      (extract64(pte, 10, 1))
> +
>  /*
>   * TODO: At the moment all transactions are considered as privileged (EL1)
>   * as IOMMU translation callback does not pass user/priv attributes.


