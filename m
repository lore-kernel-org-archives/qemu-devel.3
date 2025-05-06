Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B284C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 11:06:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCG7N-000699-Tc; Tue, 06 May 2025 07:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCG6y-0005xm-BD
 for qemu-devel@nongnu.org; Tue, 06 May 2025 07:05:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCG6w-0007JR-Ah
 for qemu-devel@nongnu.org; Tue, 06 May 2025 07:05:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746529515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JWagUJEVdO7PSy41uXGS9AE0guddvEOG68XS01NfLfQ=;
 b=TNPGVcmIakJIMMCXcMgVDlD5p8Apjzmn0khjxNMJMM85Xzv61I59jVg0dxOXLKSGimhtqe
 KRM50Zg8wFWaTyOnvU4Lzkdsm92GL0ulGtxHs9DZri0Bc3tY0uurdN/zjqXkWBf4QrYecI
 HLvFkYwgJXEFMPGBToUeZzqcYk50Mqk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-RjMK3x9uNEq9v1q6ps20TQ-1; Tue, 06 May 2025 07:05:14 -0400
X-MC-Unique: RjMK3x9uNEq9v1q6ps20TQ-1
X-Mimecast-MFC-AGG-ID: RjMK3x9uNEq9v1q6ps20TQ_1746529513
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43d01024089so35733095e9.1
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 04:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746529513; x=1747134313;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JWagUJEVdO7PSy41uXGS9AE0guddvEOG68XS01NfLfQ=;
 b=NkuYhtJU8fI5AZVTAcnfs222WHQqqxlg3vYytiMA+fq2htrqgzDDV7dbwx9eujI6WA
 JqmYKtYc3p4LEmYBNsYXIwl64SO83vnB9ufaxPs+wYd5itH6fCOKMgSwpZ3omYcm441x
 EEMZsXXUgQU5VwOTF7WU+URloHLsME+jGVhfjydHwqmRV0tFsw9fRrXR2XPvsel3lkF7
 SW3/BjNea4Ngxl+qsjc0xRHlelbFqzAv/Tq4G+swwzXejxZrzUXJd0enylBGRMOJD6sm
 SztV83t0sGxP6s1bBpAkFSLcim5WZXBc4vTbeX1t5xqHmncq66dqt1CrbkQ+Wg6PrC05
 6vbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTpryZrLUJHW+AdFKeEWL5Ue4NvI576WONS+ZFXcaRF3fJDK1vH+PKt/v+w1vJIHyNTuLFATEdDU/J@nongnu.org
X-Gm-Message-State: AOJu0YzvrRC5d6q2qE+1ahHIwjT5DAUqsbHNjdJJ+C3ukqByDLKWf0jH
 scCuPMyPBiSpyK835+p11Xo+4nSvzF/LtTJE7pHDGHOUrT7JTwmNsyGaDhiKRsYTT8+OumcJMrp
 wKJ7heX56Yg4+eGumFHF4cFW3/fuOO1O+cOk+QOWeZd59EamS6TcQdDwxZWrZ
X-Gm-Gg: ASbGncsD7tJ9LRLQZNiXivUW9G/bL07nc8BUxuDdDGvBjjNXEliWi4+tPrPZjad9vM8
 sDm8KeDpsR0NRtLnyHriBTtVnu4L9366WCALL4TvHIgUYiOTRYNfymyNSy1ocBo5rgKV7o1s2hc
 F6kU25pHNiFJxSXqM+mbo/Z3vsj8L52CUJG3d7UTctxeCOci7QLLaBap9ronJ1T6835/oYPIC5r
 osDdJAfuvi2vSO50rfExhSoTVUVqofHseRTlE3US3B6UqRTbl3MKF74NqepAwDwnkfjC+bjrcot
 Hj37OCPnFZ15NBY=
X-Received: by 2002:a05:600c:3d91:b0:43d:1f1:8cd with SMTP id
 5b1f17b1804b1-441d0543095mr21303945e9.24.1746529512849; 
 Tue, 06 May 2025 04:05:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHE3gkYrM4uMvVX9Jp20+KEFRyr3eVqtJkGq2CI71oidprSzi5rzifhau7+bUBkBGsFgaraUw==
X-Received: by 2002:a05:600c:3d91:b0:43d:1f1:8cd with SMTP id
 5b1f17b1804b1-441d0543095mr21303775e9.24.1746529512527; 
 Tue, 06 May 2025 04:05:12 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.54.106])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-441b8a315d3sm166763705e9.36.2025.05.06.04.05.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 May 2025 04:05:12 -0700 (PDT)
Message-ID: <b94f0dcf-6f55-45e9-866c-ad2e59ce85a7@redhat.com>
Date: Tue, 6 May 2025 13:05:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/20] tcg/optimize: Add one's mask to TempOptInfo
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250505202751.3510517-1-richard.henderson@linaro.org>
 <20250505202751.3510517-3-richard.henderson@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250505202751.3510517-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/5/25 22:27, Richard Henderson wrote:
> +    /* Bits that are known 1 and bits that are known 0 must not overlap. */
> +    tcg_debug_assert((o_mask & ~z_mask) == 0);
> +
> +    /* All bits that are not known zero are known one is a constant. */
> +    if (z_mask == o_mask) {
> +        return tcg_opt_gen_movi(ctx, op, op->args[0], o_mask);
> +    }
> +    /* All bits known zero is zero. */
>       if (z_mask == 0) {
>           return tcg_opt_gen_movi(ctx, op, op->args[0], 0);
>       }
Just a nit, but this second check is now redundant.  z_mask == 0 implies 
that o_mask == 0 (otherwise o_mask & z_mask is not zero); therefore the 
"if (z_mask == o_mask)" must have returned from fold_masks_zos().

Really nice!

Paolo


