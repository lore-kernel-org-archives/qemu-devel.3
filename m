Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E214C83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:48:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublcq-0006e0-4W; Tue, 15 Jul 2025 15:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ublHv-0006uE-27
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:26:20 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ublHr-0007RF-TU
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:26:01 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-45618ddd62fso26800865e9.3
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 12:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752607557; x=1753212357; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZKhCPr5YjI/Ci5CHnyjBRTjG0SEjgGthCbWh+QDUAuw=;
 b=WYAMtr0wWYwYtkEV//EosIv4+2v+9xfcx8Va3lzldXOBs815QdyK4OKU/0Ln+UBnA9
 NEDmwZ1hwHp0GuGt9CYJucMllSwnmuPCJtFnQ/kYhfyCR33GtyAvF/sLgOEDZic6TXdq
 iKNI1PWI6mWH9bf/Qlc7tuSPSz7/j5Z0+dspW94qsy5MpZi5HLtT5lMO9TE2QSK+x/XR
 2o6Bl9z1kbU/9OyUsAVRZTLHABGNipXsRJKNKDOrwvxGvJXe8E+S4cHSk6Xdchnr/mpF
 RBHTiI5vly4SX4FkPUWeevFTmjoUTlSjXqXD+M+a5I6ys7qo9Ozw5fX03z2V0HP1fT/R
 AZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752607557; x=1753212357;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZKhCPr5YjI/Ci5CHnyjBRTjG0SEjgGthCbWh+QDUAuw=;
 b=n0pqTHhFQq7YHBEd1bt/jAHVVEk8sdR/fmc2QdQE/qW4DvnGDdG2gSAkNeKYWr3AEA
 bZNp8PHjqhQ85JYvVef1+WzkS5tOl4ytCO2eoCvV16rpRIRXVh8lTB6xWMuwhw8lyQ64
 ih35wu+WPABl73nlzAmBRTy64fZLj4MbPyxFrJmL5Bz5+EcT98A62y1tQIYub9V6pSu3
 z9YAayUGyJW3cghUslIFxKWDLWmiyCGWBy9DucxutyC24W8QsH4VBznLUjPXO3M29HNv
 iP46UXcxYRCTwrV+nTThpw9K2KE6v7cuNJ4ovBxQqDEpzxyu2rh34eEj+X6pvxG7nLV4
 faPw==
X-Gm-Message-State: AOJu0YwE9BhYU0UtDhROWpIOTbUfA3Xe2170oeXdovTxFlSfxQAUg+w7
 p518x4R3KAmoF3gt116mL+6dUJ/+K6OYqywsSji9kssv1RQCgitq3kqTXoX9u5IHWKjL0QONBgP
 SsIEe
X-Gm-Gg: ASbGnctDPOF2rG/8Adb8QnwCwDG97UsCPhsBv93h9vNPcyZ1UIDpS0Ut8db4PwQjhJI
 f1oc9eRIbsi7t2pldtRk7IntJSh3l/q9G5qSnWgGRc9rovZxgeQvpEzIaHefV87cp/d5g1+FLsk
 iahYQtBud2phWRJxYHDAw/093XQAwm2p35ODOvEKRANr+LSBcmgQT2r2PZ4C+Gf4FXJSIlAKzTD
 vpYIo3+vx3LR5AOjieDuFZAhutlbFZqZElLQ41/Z/WLDcrjm/7N+/CizLhKG5masNpqjqjlVRLW
 iFOgO3u1HSfyqDLDzevaEx8w1LRuyC9H+Aff9u+Z3q6A3A1tp6mBPLuIM2rJVMWcNXEFAdG1nXV
 Lik++p/zSbMOg6tpP55qeL3zvVA4tnrAZR5Rw200ulbrW1pnD7IT1q+IHtjJxOdvAbzCYg+M=
X-Google-Smtp-Source: AGHT+IGv53aFY/smpgFXW/oCSTDYePapi7m1QyfIY3Vehuu2Sb23CG8TNHwz9smozWCA7Gl/gnLoeQ==
X-Received: by 2002:a05:600c:3b94:b0:456:1611:cea5 with SMTP id
 5b1f17b1804b1-4562e3b9a23mr134365e9.18.1752607557447; 
 Tue, 15 Jul 2025 12:25:57 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4560d019f1esm106171085e9.10.2025.07.15.12.25.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 12:25:56 -0700 (PDT)
Message-ID: <d384b96e-c705-41c1-9990-81755d2f850f@linaro.org>
Date: Tue, 15 Jul 2025 21:25:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/arm/xen-pvh: Remove unnecessary 'hw/xen/arch_hvm.h'
 header
To: qemu-devel@nongnu.org
Cc: Anthony PERARD <anthony@xenproject.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Woodhouse <dwmw@amazon.co.uk>, Peter Maydell
 <peter.maydell@linaro.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>,
 Xiaoyao Li <xiaoyao.li@intel.com>
References: <20250715071528.46196-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250715071528.46196-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 15/7/25 09:15, Philippe Mathieu-Daudé wrote:
> "hw/xen/arch_hvm.h" only declares the arch_handle_ioreq() and
> arch_xen_set_memory() prototypes, which are not used by xen-pvh.c.
> Remove the unnecessary header inclusion.
> 
> Cc: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Based-on: <20250513171737.74386-1-philmd@linaro.org>
> ---
>   hw/arm/xen-pvh.c | 1 -
>   1 file changed, 1 deletion(-)

Queued, thanks.

