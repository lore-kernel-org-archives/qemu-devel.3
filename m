Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 483FCCD4F4A
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 17:30:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOfJq-0003hj-9V; Sun, 17 May 2026 13:30:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOfJn-0003YA-Dh
 for qemu-devel@nongnu.org; Sun, 17 May 2026 13:30:23 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOfJl-0005Rf-MI
 for qemu-devel@nongnu.org; Sun, 17 May 2026 13:30:23 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2ba4efedbeaso11275905ad.1
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 10:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779039020; x=1779643820; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ee61P8S14IFEjBLWuupcM2Z5FE+hIMT06M55bcyNbIE=;
 b=NC078TkAUlacG/9U3kSaDazKYaOv9ZS+W/fSuX5HVidciA8uOHC822Ba+IZs6X/iln
 xLRFZ+wiPpl2N8mjypfd3O9LBD13tzibmsIgrHa+kguqYIZ+NAZxyPe9c6GJxzFtN4UG
 8FaL+AhEXvhZChYWt9YmcgvgHFo/i3EyfKbXSmsMZw30csrVEZR49E7JvRfxw2bmsB3c
 o16ct1qtCDK8qA7FOL3ZOraPI6ZXLbf4Yf/n71jppA136IMQyVYBx0YGu04TOEpt8VDO
 XF54e59BuZUsiSJ1rY5t3Frw29S47d3ZJQUatzLJ3Pf0/gvIilH4n80+wYf21lFxPStR
 TZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779039020; x=1779643820;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ee61P8S14IFEjBLWuupcM2Z5FE+hIMT06M55bcyNbIE=;
 b=hVoCzAARWbSnTddk1gTxKDRsprzcpVMwsR9x7uxOjsr7bMLFCnycT/buQ7Cmj32+m/
 Ot2AijmuH0MWMR2ot3d4/kHcTmp9IKPPgqA0tuap/jCU37L5VHYV5QonkjO69pr5ZKwR
 4VioeNmYLSCX/Hfa5vZ1evXynf36t+ss1qbRZH3n7BMlVJVx+/JFPmV/P0cfTKj8+1ms
 ci2RQtw/aBRGf3cq7uPYwSsh04rY9XpnpcHH4gONw6fJhBPZN9myMfymGngvSC416jGB
 p8iH0nG8aHa6MBI/wv9DMFz2CpeYFn6JTIrN4aopIK+LOuu51ymNbV63p5RfZ4yvaVGi
 aamQ==
X-Gm-Message-State: AOJu0YxPAuUlbD7sxMc1R5wbRI8fvCZc6ydf0D/eFqRJ1gFiI46S9xC5
 YXerk6UVC6EDTdWE0+7bzHFU0IcqpsrRdgbUeifh0blZH23OQ+tYbM/hcQT65MRKnfLItfiDGWx
 EE38n
X-Gm-Gg: Acq92OENc/ipnDBl5PNmcnxmtvtehGEkW26vEm6mvDWXNZt3IBOyK7gWGl0F2GKEgbX
 9cJm4e8s1x1OpZ6nkADiN7SNBxjrqxva6Te2cHAj+O9rX4PYmCq9k1YH+vidurlx8a8ZnGY3Og2
 mQghwkH/MS3xjyvCWd37nUh1ZvsNFir3LxDJbxf0etY0j9AAgNlgH4P/6eGNnj2D3c4EtU4Z+6w
 ys/PzfWm2QNciRfHe/t3Iz+FbzpTGLZI0J6ENj+GycukPsXAlBz4UylUqQ+lhr6WLyTnKJgUYaw
 DCVMF/xzr+sGtvb4SnzIcF9pjH4GgwGAkS7YhBsg2C0S4Syrv0HIxIVK8uJ4/BOeBGLyEjRC7Fz
 e09u3r3Aesk3O+E+7VgBjMCi9zLg8AF+JubT1k3Exn6yXi4kl3DN4rJfadzWb+02R40JPAlXI1e
 P5ywqBmTxriODhJUYVilY3U98Be2k3AgABwP4p
X-Received: by 2002:a17:903:950:b0:2ba:6ca2:bca with SMTP id
 d9443c01a7336-2bd7e8c2c39mr125789405ad.26.1779039019982; 
 Sun, 17 May 2026 10:30:19 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5bd5fc47sm117528065ad.10.2026.05.17.10.30.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 May 2026 10:30:19 -0700 (PDT)
Message-ID: <d89ceb68-871f-4b0a-87eb-bba3234ec3de@linaro.org>
Date: Sun, 17 May 2026 10:30:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 20/35] target/mips: add Octeon MTM2 instruction
To: qemu-devel@nongnu.org
References: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
 <20260514-mips-octeon-missing-insns-v2-v7-20-226686be4ce1@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260514-mips-octeon-missing-insns-v2-v7-20-226686be4ce1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 5/14/26 10:37, James Hilliard wrote:
> MTM2 loads the high Octeon3 multiplier operand pair from rs/rt into
> MPL[2] and MPL[5].
> 
> This supplies the final operand pair consumed by the V3MULU multiplier
> helper.
> 
> Signed-off-by: James Hilliard<james.hilliard1@gmail.com>
> ---
> Changes v2 -> v3:
>    - Split MTM2 out of the combined Octeon arithmetic and memory
>      instruction patch.  (requested by Richard Henderson)
> 
> Changes v3 -> v4:
>    - Describe the Octeon3 rs/rt MPL[2]/MPL[5] pair handled by the shared
>      MTM translator.
> ---
>   target/mips/tcg/octeon.decode      | 1 +
>   target/mips/tcg/octeon_translate.c | 1 +
>   2 files changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

