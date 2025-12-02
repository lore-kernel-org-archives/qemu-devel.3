Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D419D1170E
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 16:36:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQTMV-0006pE-7d; Tue, 02 Dec 2025 11:36:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vQTMT-0006op-SD
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 11:36:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vQTMR-0007VT-AT
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 11:36:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764693377;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iWFCPVK34q9qvoDCrpvi/7OctcBRYtz25HrbFC+7+j8=;
 b=jR9f2sl66hPnfw5L+rTXQTRNGNozyNKH+5s5Ibn3zLWaYpWt0x+83PvDjnWiDvhYS7RLQa
 nYVcJUMreOeaLHm7EX41BR7asHd5WoG+I9GlZhglx5ON+PxxasN1ykEly4RKEiy6KrWBAJ
 Qrrt0sBLQLErNqdnpZUEn+yldl+HeO4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-WuunpFP8OzOUV0-trbWnHg-1; Tue, 02 Dec 2025 11:36:16 -0500
X-MC-Unique: WuunpFP8OzOUV0-trbWnHg-1
X-Mimecast-MFC-AGG-ID: WuunpFP8OzOUV0-trbWnHg_1764693375
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-882381f2092so179372496d6.1
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 08:36:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764693375; x=1765298175;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iWFCPVK34q9qvoDCrpvi/7OctcBRYtz25HrbFC+7+j8=;
 b=g2SZqRaZWT3p+vOqcVFwQxNqOQ6ufC4J62l2+AowzatZEt2npB0qKrRZkPEpmmCvRY
 /fddVroKLC0Qv1S6bh0WOPWWWD3vT4cS2eL77oaUDUcpyqqo82qQcBRPIZcN8HavHZKR
 NYlw/hGOHLAFzRmdRF8pE1zoI28cmIycHrc4MgfNqj74fEgGFOrk8smBufgBd8sUdKCo
 J3rS8XZ8YB4cwzNM+aRjpdj32SxE8s67fdhoo2Wk2t5DAze4pabHqjuts+HGS8N4P1se
 deqvwLdLvRkLKAmIu+nNOnyxkmzhttKPXEY0Wswkc9xj7GsDXrF9d5wHGiAHUjKtqTDO
 yZRg==
X-Gm-Message-State: AOJu0YwLR2UXvdOREkK8Kfi+hNJgFwiJOhX1wwrcuCTXVgAkX8hgF9eG
 bMIClW4O829rZWmXFqYSGk8KJLP0yrX/rT4ObQrIZYHDN37RNLl/Reh21rvtsVfwVTBhzaqacS3
 bi6pUpGK1CiE2G1jjZfrz9SeRbf6enWSbcYPlfjIOYX2UZFDi2ElwPCUp
X-Gm-Gg: ASbGncsg5i6WBDD3Nf+69O9MWmj9GfZ1XlJgiz8YmUXzx2ze+ITwHCNw3s47p/KRSfD
 FWOVM6myIwnABhhw2s7FFgRgJO8O+QNQojwonl468kNbUunyPXKNT6tB9XSWG3O5Yen24pQHgVe
 HHbFxOXZYkuZBvxj5Oby3xPZ6JieHpNYzGYKmN2y2jyGxugmkFlbxbwJC/mfDEcRqDk3fcNkdrI
 soKZGWec9XGA4mIrA/w/Nektfuq9O+aGr0RPvT0IW2UF2iCO9Bic/sEdFzrYQ8t/mkLkEYuwg7Z
 aBN7bNv3/47kbbYDf8uFqEFBTyGrp1CTKUouD8uoOatYuevTLyfT+OD7F1jr6ap1+Va4RFhy5xN
 zxjuP8YbhvBlIBgb7IPSTI9g8jtow9TIDOnOWKAITqrJ635S+2VUUNRQ8yA==
X-Received: by 2002:a05:6214:e6c:b0:880:4c2f:5075 with SMTP id
 6a1803df08f44-8847c5365e7mr686073486d6.56.1764693375404; 
 Tue, 02 Dec 2025 08:36:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE//GRtdwiqihoAZ0nOj6FQDYAgxNEU0uDbno4BsJ1nxfqYyCQV/nmuYLrnlEnLCKAvJyz1wg==
X-Received: by 2002:a05:6214:e6c:b0:880:4c2f:5075 with SMTP id
 6a1803df08f44-8847c5365e7mr686072926d6.56.1764693374985; 
 Tue, 02 Dec 2025 08:36:14 -0800 (PST)
Received: from ?IPV6:2a01:e0a:fa3:e4b0:95dc:ab11:92db:6f9e?
 ([2a01:e0a:fa3:e4b0:95dc:ab11:92db:6f9e])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88652b493f3sm106872176d6.31.2025.12.02.08.36.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Dec 2025 08:36:14 -0800 (PST)
Message-ID: <a63b3689-ef46-48b1-ae28-34976ab34d0b@redhat.com>
Date: Tue, 2 Dec 2025 17:36:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 20/21] hw/arm/smmuv3: Initialize the secure register bank
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>
References: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
 <20251012151542.4131398-1-tangtao1634@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251012151542.4131398-1-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Tao,

On 10/12/25 5:15 PM, Tao Tang wrote:
> Initialize the secure register bank (SMMU_SEC_SID_S) with sane default
> values during the SMMU's reset sequence.
>
> This change ensures that key fields, such as the secure ID registers,
> GBPA reset value, and queue entry sizes, are set to a known-good state.
> The SECURE_IMPL attribute of the S_IDR1 register will be introduced
> later via device properties.
>
> This is a necessary step to prevent undefined behavior when secure SMMU
> features are subsequently enabled and used by software.
>
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>  hw/arm/smmuv3.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index b44859540f..0b366895ec 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -331,6 +331,15 @@ static void smmuv3_init_regs(SMMUv3State *s)
>      bk->gerrorn = 0;
>      s->statusr = 0;
>      bk->gbpa = SMMU_GBPA_RESET_VAL;
> +
> +    /* Initialize Secure bank */
> +    SMMUv3RegBank *sbk = &s->bank[SMMU_SEC_SID_S];
> +
> +    memset(sbk->idr, 0, sizeof(sbk->idr));
> +    sbk->idr[1] = FIELD_DP32(sbk->idr[1], S_IDR1, S_SIDSIZE, SMMU_IDR1_SIDSIZE);
> +    sbk->gbpa = SMMU_GBPA_RESET_VAL;
> +    sbk->cmdq.entry_size = sizeof(struct Cmd);
> +    sbk->eventq.entry_size = sizeof(struct Evt);
what about prod, cons, base? Don't they need to initialized as for NS.

Also I am surprised only one IDR field is set. No need for some others?

Eric
>  }
>  
>  static int smmu_get_ste(SMMUv3State *s, dma_addr_t addr, STE *buf,


