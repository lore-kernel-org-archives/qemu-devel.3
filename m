Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61CF9F327BE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 08:07:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF68o-0000Ir-LU; Tue, 21 Apr 2026 04:07:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wF68k-0000IY-Ry
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 04:07:26 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wF68j-0001rY-Cf
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 04:07:26 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4890098abbaso26127515e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 01:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776758843; x=1777363643; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Uh090oCSC/ghzKd8Oeb92VRHvPhPypIyiYEcMvlcnUg=;
 b=GVYgkR4gfaJKq+r+ZF1pgTNN9hGZWBq/RssDE8PtmmLCYd8+Uaq1jVg0isSmHuJrn8
 NU1N7UHRKvjjCUTUwwW9p5eINBDo1ENGiSSuNvh7Cs1LjB4n0ljnQa5el/Ar5hSb21MJ
 beoVZblZyVcR8RQaId6XxTNF2lELvXIylAUUFWlDWqtuqwemDoAwFgzlR2LYW97kILYd
 ag1KPlYuYU8pC87iPJrpPGEhm2rfy/osf9DreONSWLH7VYp1FETTfiWPa2DD96Q7Keb3
 mQUUUKBBcWxBhlvkOvJXIWdzhc++Xmozb5ILSn5dKrVTHgNuzPiipv9r920MPtZHpjeL
 xNxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776758843; x=1777363643;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Uh090oCSC/ghzKd8Oeb92VRHvPhPypIyiYEcMvlcnUg=;
 b=SLwJS375vXAfzgt56vJCan5fyckddYUr/tp272DIFLTwvgJD6Lf0ygRB23PHGFjrph
 LcoREhSMFMdzvJ8OylXWR4FeR502XnjT9doxui8Gtxg3hu3VPHXmdizP7yVC8JbJapOM
 e71GEZ3KRMzi+FnM5dUxc6QpEOpsWu8faFQg3MsTng2tTWmOYPlC8rqFAAK3GZMzojnt
 dynBgqJowPePn5SEv8GlKIpbbwoTzV+QFOgFOkvFrB7PBcVHJ8SWY71nC2nnIBJV5dl7
 XHtbjmW5SO73s3K4YqHN+qw7RVn3J1zOTqBpVnDuaU+YK1YI4enedUldWxWIWNXRNQd2
 dqrg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9uRZxmhIu+B00n3fiQBGsqiLndnfdjMmJkRiExePesQPSlJmns3w4/z1Lhnw5oEqdYrJQlhMkq8a1L@nongnu.org
X-Gm-Message-State: AOJu0YxPKcP3xYl7pZwJvWZZyKAwapTTqQH7GhXXt7MM+YCM1Lb0uGYs
 V4sZbXUZZk0e/u+QV9vSr6YQndpbj4h6x2Mu1DpNvwd59gGEL0VlHVIhV5eqAXXqA7M=
X-Gm-Gg: AeBDieuA8tk94FDlUDIOo31sL5WeHhMrP8meEigVmMXitGVQs0/OJQ9PIt5uKH01tLp
 jhRhiM5qDADxaXVesEIZ+HYNfEqY15hPK1Ssbpde1Ced9ZEUnIfxpDpUmaoB/v4xTZNXqKUdYaM
 yQWh4CvmHCchocVSvGt3cQHR0kj6HdHv0U3g9boePdNg5/HEstJZcHDuEawPC4CMG4Hq07E4Q+N
 wsNPc3G+GLRU5BN/z3pztia0PWpAUkV6s6dGCaXMj4Lg61UoHSIfCidDaFGl8iGyUl+vRtivjGH
 XFj3B4iAJlBM419tcbFT58OuREV7QaKLSU6zHDstcB5CkLBa31InWpacI8hGbB1qarWPRetdpuS
 gBQsH+Wc8qQAiI3/WIPT4vhDYGiHSciBdPcV1YzRFGCwcs8U6zJrkrXuNg/4YYvMoGECnDfZOtL
 AIUAXajj0inrqA5lWgzFOrZgaQLwOQ8xlRq4t+w5F6dsRgPHsfcRJm037urMoaeLv0IPsIuVLBI
 mBO
X-Received: by 2002:a05:600c:64c7:b0:488:a2ac:a334 with SMTP id
 5b1f17b1804b1-488fb73aa3bmr257820175e9.3.1776758843291; 
 Tue, 21 Apr 2026 01:07:23 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc17f642sm320638825e9.5.2026.04.21.01.07.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2026 01:07:22 -0700 (PDT)
Message-ID: <88c59557-26e4-4da5-903a-8247d9ef2639@linaro.org>
Date: Tue, 21 Apr 2026 10:07:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/virtio/virtio-iommu: remove duplicate include
Content-Language: en-US
To: Osama Abdelkader <osama.abdelkader@gmail.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
References: <20260420163050.321668-1-osama.abdelkader@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260420163050.321668-1-osama.abdelkader@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 20/4/26 18:30, Osama Abdelkader wrote:
> qemu/reserved-region.h is included twice
> 
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
>   hw/virtio/virtio-iommu.c | 1 -
>   1 file changed, 1 deletion(-)

Patch queued, thanks.

