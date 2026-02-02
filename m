Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF3DD172D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 06:17:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmnEQ-0004nC-5U; Mon, 02 Feb 2026 01:16:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vmnEM-0004me-GR
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 01:16:14 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vmnEK-0002bD-Mz
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 01:16:14 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-c635559e1c3so1705986a12.0
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 22:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770012971; x=1770617771; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ukke97Q7iEnOOeTMRAegp7HIaW/Cc50tKL41O2dip8Y=;
 b=y0hLLTZiqZxNkOKS6zYigiPCb7pREbOOZFJYB4JM/Aklc7c7epMLXmEhH/47nVhhDY
 /LWUyQ50rbCFAqdwFWfz37j5pfze1MEkFfO3wft7rOD/bQhKzDJ1PaWP+k+eDosXJSG0
 wHjX4aB4h3oZlX96Mx0ajkFSIDuBIG2bfuVRh1cckR8Flpf4HDysGL5PCpNkAO60I1lI
 onCyqmN6j3gsRZ737ShsRaAbefX7T4WUvyLRzcZBiiQZUpw9I6ungKm4dSvvPmuNk9iB
 efUzloa/wLYGwLHlvnSJ72d7kagWmPZDxzTFNJBqfWdCqWfBPGqCZbTaSfMyzap1Bi0+
 C+lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770012971; x=1770617771;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ukke97Q7iEnOOeTMRAegp7HIaW/Cc50tKL41O2dip8Y=;
 b=CangEEuJk5fIshATY+DvFMv0Hn+x8lzimyfj1Pxan3+6/Bz5Jr2lf1jyi8qGIDzLYJ
 GIKKnFvBnKq+IsxBZG3ttlCJp80UwX9w8w6Q2Svu8Yc7GMet8KhERr8MPIrUcRG+3OBZ
 ppOjZQ1Cora1wTOyI2EPqMjK/VQpoOen4HwjGb0AQIGTF3aNxp3vkwf9Ewsu/Am/3p2k
 4ZlnRjN3tM+EFF3XwY5Kolf88Kg5ffuzLrAWNGGHnzLdEej2eMbS3pyGjp9b4YtcBMTK
 vL9kjRteuOUjJaF3o3TMqsnrEkUe1gMu2qwavQ7DPihZTThDuX4M9M7tguWI0xiexj2y
 1/Rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVRHLML4BKTgn1YvacfE+jkt1UP+fbRnV2ikbX/DNnSCG+t2NjtnoTsoYtibJaiBvuvZ771J+YRY9I@nongnu.org
X-Gm-Message-State: AOJu0YzJvTKDKpKijluwP2iFzKly/2ez4ek3FN3LbAmwJaJkdcDsNIdo
 6OPVMNwvuFQ93alXPAOc7oLJqr3Bgn2g3+VTi7W+aVIpmE7gphiSbEMeDSNapi0YWuI=
X-Gm-Gg: AZuq6aJUF6rGpKiSw4BdGup/gPaG/RnyjEnBodhoWO+s1ONSWWTpfLVBDXul2jY0f2K
 1eajLfGlqd61ePb2DIjLuddqj3GQf9FCEcXQmJJDeCB28jUGTQSkU9rgX8iz6HB6aQmjdzzk9Y9
 SPpVxoBo5YDDcjoFCS5WuRTHst8r3DWeRkXW82utEM3DEJ8BDVudafpOIw1gKPY3OJE0xFHoSfC
 Ek6H9op430Ria7KlQ9mpsGHw08OBIVzURVtzd9HfjRpbiB7rqCG/CbOG33FeYTcn57fOhLtp2m/
 VLD2Xi6Kknv6apny1wPzszo5qfoAd/1dCot9zvW20Ff6UCyS5IiFkVpy79s+OQWMNhQIwJIfXH0
 BqGCh9vRkZB7rWF86ecpCz1p/XGvUzLSF3d2y7N5LYlHXS9V6UVUDvrshi+W6i40mkWn/7+KD8r
 97O9wWbk/HFuC0tpsX1wH5XLClWKyme6ruccffk5mTmVtpPH6EfJxKqq7VlY1l1YCVeHflWMF6h
 2bOllMSYVSC9WxNFRI3b9oKuaxpgqEng3L/cUDcTwjVYOmOv3vl
X-Received: by 2002:a17:903:240c:b0:2a7:aac1:7201 with SMTP id
 d9443c01a7336-2a8bd3ec033mr144469465ad.3.1770012970661; 
 Sun, 01 Feb 2026 22:16:10 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:e524:51ca:ff85:53b9?
 (bg30dj08q4s9ql12qb2z.ip6.superloop.au.
 [2401:d002:dc0f:2100:e524:51ca:ff85:53b9])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a88b3f6d77sm132585315ad.2.2026.02.01.22.16.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Feb 2026 22:16:10 -0800 (PST)
Message-ID: <a33d4d63-350e-4126-ac7c-54d1e71b4dc3@linaro.org>
Date: Mon, 2 Feb 2026 16:16:05 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] fpu: Restrict parts_round_to_int_normal to target
 precision
To: Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>
Cc: David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20260129190902.196262-1-iii@linux.ibm.com>
 <20260129190902.196262-4-iii@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260129190902.196262-4-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 1/30/26 04:57, Ilya Leoshkevich wrote:
> Currently parts_round_to_int_normal() assumes that its input has just
> been unpacked and therefore doesn't expect non-zero fraction bits past
> target precision.
> 
> The upcoming DIVIDE TO INTEGER use cases needs it to support
> calculations on intermediate values that utilize all fraction bits,
> while at the same time restricting the result's precision to frac_size.
> 
> Delete the "All integral" check, because even though really large
> values are always integer, their low fraction bits still need to be
> truncated. For the same reason, make sure rnd_mask covers at least
> fraction bits past target precision.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   fpu/softfloat-parts.c.inc | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
> index 5e0438fc0b7..93ed59626e5 100644
> --- a/fpu/softfloat-parts.c.inc
> +++ b/fpu/softfloat-parts.c.inc
> @@ -1118,11 +1118,6 @@ static bool partsN(round_to_int_normal)(FloatPartsN *a, FloatRoundMode rmode,
>           return true;
>       }
>   
> -    if (a->exp >= frac_size) {
> -        /* All integral */
> -        return false;
> -    }
> -
>       if (N > 64 && a->exp < N - 64) {
>           /*
>            * Rounding is not in the low word -- shift lsb to bit 2,
> @@ -1133,7 +1128,7 @@ static bool partsN(round_to_int_normal)(FloatPartsN *a, FloatRoundMode rmode,
>           frac_lsb = 1 << 2;
>       } else {
>           shift_adj = 0;
> -        frac_lsb = DECOMPOSED_IMPLICIT_BIT >> (a->exp & 63);
> +        frac_lsb = DECOMPOSED_IMPLICIT_BIT >> MIN(a->exp, frac_size);
>       }
>   
>       frac_lsbm1 = frac_lsb >> 1;

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

