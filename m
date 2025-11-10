Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C86CCFA13
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 15:01:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vITOA-00072m-8r; Mon, 10 Nov 2025 10:01:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vITNz-0006oU-7i
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:00:55 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vITNx-0001YQ-La
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:00:50 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4775ae77516so37262565e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 07:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762786848; x=1763391648; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fURalBMs/Zxl2UsFinIcNx6cVX5UTn93KQJXoMaANJ8=;
 b=IV2Fovsi6734Xyb22WGzFKI16Rp/t4Li/zIWGW4mQecmyXC+miZYwumLOXztWPjF+0
 n5pjjdqgpkn7vr/WG/1LfvFvTxs0ysKNa3lmy4b17CzIxi+cZqQozkY1jR5tRQOEUdTJ
 dLn7xgePSStV5IsNPL2+296kr8Mitf/AbeJQ0+rd/7rki4oG0MZYfxsI872kd+B38V3l
 PiQqX3dOuK0kmy5rbEcu/uVc4kFUxvqAeGkoYJuBjkg8jQCwTGgXhpcfaKwdG/PeSpZp
 7CKDvuSqQqfU2QGcwg3vxNrIYMs8zAQE2FgRZfVXfSTiwJSY/8urcj0+f0az1YfLP0fb
 CTaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762786848; x=1763391648;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fURalBMs/Zxl2UsFinIcNx6cVX5UTn93KQJXoMaANJ8=;
 b=GX58utZWZyo1u9Nk47/AsgSBJrjyA4HHVIw7cjyRbeywATsuJ/hM3ZvktOWlr5As2P
 Xay4ennhMg+e5LLlA32RcZ9e7Xt0dG2ltIU6AGTr00wCWjpgRDro/a2O3QSbXL7ISGY/
 JIz9lwZtPeUF7IpGOY5z6+aBzDeKKkn8v1kCckAVD+OactpAKTNnBJxE822NAzQXBndV
 lGKaUeW1xR2XJ/L4GAa3awu6gvxCbDsbQ1PYFNWtYCPyYgBlfoJWH2ZNeOcn4VwSgK15
 D/MZDLH7JCO4EWjcf1X+UcmahMDnCe4dGiMnCo3kYe7HPYE1H/u2wt6/3eeWjjD5pd6s
 Xknw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZmmBkL5Z5umWyDrco1iI+Kvg+RZFwgKbvK0mioYysD20BL1IE4uT0+93RCHPK7hkNN0/NJX+dKncf@nongnu.org
X-Gm-Message-State: AOJu0YwzDeAHl++duyF17b4saxMFlnx+FCxL6FCoCk6rypMPEKlAE0ll
 DTluwGSQTW2ptWuXAdwq3LKKnFAFI44CJls/WyAkG0wwQOWatYvhfVoH8DH0zf2Nea8=
X-Gm-Gg: ASbGncsquqSeOVHdl4wY50rYWi3Fpqy5WnzyyUoIrLd31mHoaprgXlY22S287XRmTHu
 2XroNojCsGRkyhIpXmt4eJxQppRoouMvJ95otH0LEFGlxoMSbV7Es8V8TORMlcMcNU06V9Tsfgv
 UdRtNJHLgD0rLjCKyPuuJh8sY7H/SQp26h8bYVAbr0mPmtYI52mnXzSVEOUR52nHCADv+gWlufI
 zQq83Ijpv1CC5p+w48LsmaqRCsRNJ43ix6g8pJYkPhvXsUqZV4OodmulHDfAGShEQaamdWD411z
 7uuYpZ9dZnGWag3JeMReGpk0NqgG/2Rad53MinBx2Or3ADY6sawZFowIt+itQhNMMKYXfl3sjfF
 4GGoVNTCmf3VegoYftSdx3d0FVXCNTItrbrp2SQVzJXdT3EQktVAxYLgbiXH4hu/KMjTLiYMj/r
 cK/qT2BYuBhUW/KBxKZHN5nTJKVnDTFe/PngInnkMynUf9q6K8IOJadMMmGa2iwoksRyK+/Gg=
X-Google-Smtp-Source: AGHT+IGgDwIGjGucayseLXZooAlntzUNGAwRAsKOusPksuZjYH+dinuEh+QhsnSTRW+rAvGbp1ZHaA==
X-Received: by 2002:a05:6000:2107:b0:427:809:eff5 with SMTP id
 ffacd0b85a97d-42b2dc9f514mr6464234f8f.53.1762786844917; 
 Mon, 10 Nov 2025 07:00:44 -0800 (PST)
Received: from [192.168.68.117] (anancy-654-1-85-43.w90-26.abo.wanadoo.fr.
 [90.26.70.43]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42ac67920fcsm22501388f8f.39.2025.11.10.07.00.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Nov 2025 07:00:44 -0800 (PST)
Message-ID: <3156665b-eff2-4d60-b1eb-c78f01e7608c@linaro.org>
Date: Mon, 10 Nov 2025 16:00:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/13] hw/arm/fsl-imx8mm: Add PCIe support
Content-Language: en-US
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org
References: <20251110112257.184578-1-gaurav.sharma_7@nxp.com>
 <20251110112257.184578-6-gaurav.sharma_7@nxp.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251110112257.184578-6-gaurav.sharma_7@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 10/11/25 12:22, Gaurav Sharma wrote:
> This enables support for Designware PCI Express Controller emulation
> It provides a controlled environment to debug the linux pci subsystem
> 
> Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> ---
>   docs/system/arm/imx8mm-evk.rst |  1 +
>   hw/arm/Kconfig                 |  3 +++
>   hw/arm/fsl-imx8mm.c            | 30 ++++++++++++++++++++++++++++++
>   include/hw/arm/fsl-imx8mm.h    | 10 ++++++++++
>   4 files changed, 44 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


