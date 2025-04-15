Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06994C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 10:41:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4diQ-0004HO-SU; Tue, 15 Apr 2025 06:40:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4diM-0004Ev-D2
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 06:40:27 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4diH-00033n-1d
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 06:40:25 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43cf034d4abso58606995e9.3
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 03:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744713615; x=1745318415; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DnnROgj6spAOLlTsGSRHQmwrVc1kPpOKozjbCfpmSr4=;
 b=B4I0SX4m5rf2qc3qs7MOBF6B4Mg4obg6vgbx6T0+Mlu57FRAivuznJ/Qr9MHMkRtQb
 vGLRlnPc02/NLTzMsYQiOwQWVpnmnQHPU2omZvmECp9TGcqZdorDpI2TAuTeH3avj0FR
 WostfviYGXMDHbMiRbvQc+CCMgMH2GYfAcQ2f0n+/8jFwKXxSKVGmur7bYlDWkkAEmMV
 q21WKZw/2UYaZLz1j2Fnhi56dKS+CmKZcDhbQDqpagI+GWMM8oPjr4nKyt+p8zcYvVQq
 Fw1+cTdhb1Xj2Nl2peL0Vy0xdzqHpjC7EWinkPNuN1Z+b+KF3ahjSv2AgilohAwpG/rS
 Rv2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744713615; x=1745318415;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DnnROgj6spAOLlTsGSRHQmwrVc1kPpOKozjbCfpmSr4=;
 b=PsLYjum4inStgP69sf+fb1ebeVedcz6orypTVDykj0EMRFb1fAt1Y2OU/NhmO4b006
 ke5obf0h939+AC77Iay88OTFZ/duh7uZpkG3Ke6hNgeADlrd6bmC6/WhfTd75i/ksNjf
 L2wEhyJZCHlUR+00vR+6fPmo/JXy2ZI5DGa8PaC376DqZEeMbCuO0Q7e1kaL9EAbxDgE
 A3HXhYnfYBL1cS0x1/6eJRIwsEMVKF+1Ab69CklQjUqHGXcjB0Ejx0bOT+DQuUcQ9alo
 vAV2+TC1+gQPqrfncsLh0LmZYUjtLbFnFpytrvDi1pfj+VrPlBshR0zzlkkxuGFuN4/Y
 Ro1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXi+ANXn7p8A0mpqPPx7B5ilMCg/oOm4LXiZU4Hdi56iKHP5dtf2Fkl7V17pkkD6xjEcx1ZfdaJMO4j@nongnu.org
X-Gm-Message-State: AOJu0Yx45mvr+18TGxurxboy3kq7HYF2V4AKl8flCsS02NNDlQtF7RXl
 tE3yS4zVJhiCrmMAsnMoLYm775SCbHV0lVmnxmwjtwROafHYWHUu101v0YZlgCk=
X-Gm-Gg: ASbGncu2jwDibtNFBKbKicbBdWw5bqOYp2LUeYmJFYAtJrBVKGLITg7KppBbZhzPi6F
 Ys+pu0W0ATwXtrhJdN/Bvu8isCdIb/YcfkPnCZ+I4KnRO1uYJywsOsaR9ocXkQw0QYQ3ncU4uUQ
 rIHPrQZQJHpi5x+E//N0n5XU2nsvserwKCZfVuiULDaqbXm8OVSHlnGWGULv0UXdp8ulOGMPPlS
 TvgULW0vrCLFho1nko1ByBmFiQSFnP/uNkqXjlsR5GF+Y/s0z7kcEOMu6LjJiJ+ADnXJZb/FFcj
 ORTtoeSXrH72OIkBVKxSUwGNBxy8QqcaJTUSiIbyh+AvdOQkvs/FTEtGZqK1GVLI66HkcvXTRYe
 Rj26IY+Cg
X-Google-Smtp-Source: AGHT+IG6h4i9uO3jaWZsBsOoHaxR6UYY8s9Z/VRnuAA6dAJB7cLzRQkY0fFVPxto5CX0ETakuZ8m7A==
X-Received: by 2002:a05:600c:83c6:b0:43b:c284:5bc2 with SMTP id
 5b1f17b1804b1-43f3a7d7e5emr162139725e9.0.1744713615398; 
 Tue, 15 Apr 2025 03:40:15 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae9780a0sm13938546f8f.50.2025.04.15.03.40.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 03:40:14 -0700 (PDT)
Message-ID: <271cceda-183e-4b7d-aabb-1cc84cd6d904@linaro.org>
Date: Tue, 15 Apr 2025 12:40:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] virtio-gpu: refactor async blob unmapping
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20250410122643.1747913-1-manos.pitsidianakis@linaro.org>
 <20250410122643.1747913-4-manos.pitsidianakis@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250410122643.1747913-4-manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 10/4/25 14:26, Manos Pitsidianakis wrote:
> From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> 
> Change the 3 part async cleanup of a blob memory mapping to check if the
> unmapping has finished already after deleting the subregion; this
> condition allows us to skip suspending the command and responding to the
> guest right away.
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>   hw/display/virtio-gpu-virgl.c | 35 +++++++++++++++++++++++++----------
>   1 file changed, 25 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


