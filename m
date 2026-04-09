Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB05BE98FDC
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 09:41:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAlt0-0001g6-LY; Thu, 09 Apr 2026 05:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAlsz-0001el-Ka
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 05:41:17 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAlsw-0001f7-Sm
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 05:41:17 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-43b983bb07eso385060f8f.0
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 02:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775727673; x=1776332473; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QuEfrMB8X2NYCGa87nRDqb5/b5gZeQwSQYbvucD8KnU=;
 b=Tgi4tN4OR0IpcfM7zu+3Cc45TJG0Dtq3AGTqKJCqBu6taf3YZ3JOvjaa8kfRpFGQ1z
 0KBdhZySAWi5fgEc49FYAvguJ8ZleyxjzvMGaa1vIOJc5AtO5fp3QCZW446M4rCVpxew
 AM4QPF+n9QY0mu1Dm8lTKlIwfuxC22Vk25qxchDIswUnZWtGDytRUh0vwO7epTuctaKS
 jCyRweRlgaje8Ry74ZGyo596FqwKm0KucNQG/KVzg5vRDleGvTJyUVkGA00FDrzFNOJh
 jl9JIkDirY7yVOZ6TkvZAj1z8S5hkXvCGNedTVzlIZUGkVKnrNKXq+jww1WLo0yzDgr2
 m7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775727673; x=1776332473;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QuEfrMB8X2NYCGa87nRDqb5/b5gZeQwSQYbvucD8KnU=;
 b=QJixpH+D0bGF0AEO4hVYMPl1hGVyeG4Ft1LvU0pcYgy/Dg3ym52/fPxqnWsAv97VHN
 GOgIbZcKr2xcpPMkbXLubrJBvAs26Y3dPXwjxIQVooikrt+gZdPMFdPOMcF/6sDkl4ch
 YO/5M6THduqR6V6nFyMYni8FEKLH5RYfi3V3Ytc1eWrrz4q1kI5viJDM1KqDVtKDKQGw
 7OQ26JLZX+8g+/HH5OCVK/X1lt57DHq55cs+gPnI1eM4WNP+Yk0yQkk4nLCph2vSryOk
 s1koqHE7A8qCY3ejJ50oFrGwSTK6bnl4ckuJMIPW7HQWjsg56aZrLD4axI6+mosGoOOy
 o06g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhbUs528JVagrc4OCeKFOKdMgs/I099gpYlf2yhVfZnViJD+x8S7zsZyRCtMk79m7EESGIW+VkPJBT@nongnu.org
X-Gm-Message-State: AOJu0YyDItp/iofMeHi2GZ14lSm1zDKXkn6gv2ZDqqlTe5Pkp4RMuQZ0
 wBf1fM8SPCVvkfgjbxw1k+kaw9oZF9H/dFOSIjlIe66DVH3FpPeABHxCFX62N6KQVAU=
X-Gm-Gg: AeBDievZob/0W2k8o5W9N17Xe8UYMAfKPtnmaoGwLMvMB0jOLDjFe3IS+NtdbQTmcOX
 Dkck3ddIq35ciLN0/mu7lEqUSB2ReScloB2PfcJuRa0VAznL8kyqYrH2+HzbuDa2KTUkn2Icv0L
 6DECDvbIVdEDHyAkadA6JfYZXhYiUaMasyTLuUs0P5+YmIDLsHbtqCV4z+ixC/OtZg5AW5CIGZD
 MpfnIU/xYjMHUik8i0QcACh4lTL12utEzSs1ANK7qALAD2tMeX6SF0zl2en6rpDE8UlZYetukBO
 KW86Wjo1JGu0cf2o+VoMf2tS2Ea0r35WJbETiT+XHs1xRWPkTtpuxTgdpU2azaxv8UmjhvWhUl5
 BdxNG2whAEzH/lau6k2OolufFToXimx2KaXu1SwVCtMpEAT7kBO1G4C5q9wB9jcepp2FNcEjwm5
 z4OmPYTFrogZqDCeFCB1EMIgt2Ke1RFqALT9LJB1QwVGeHPqZxd5CHBX4OLFphiD8wCQ==
X-Received: by 2002:a05:6000:40d9:b0:43c:d665:383a with SMTP id
 ffacd0b85a97d-43d292e3e51mr34238318f8f.27.1775727673170; 
 Thu, 09 Apr 2026 02:41:13 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e2c54bdsm66608048f8f.16.2026.04.09.02.41.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Apr 2026 02:41:12 -0700 (PDT)
Message-ID: <b05567a9-be2d-40d3-b7e8-438b1c675f2a@linaro.org>
Date: Thu, 9 Apr 2026 11:41:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] hw/or1k: Use hex unit addresses in FDT CPU nodes
Content-Language: en-US
To: Vivian Wang <wangruikang@iscas.ac.cn>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>, qemu-arm@nongnu.org,
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paul Burton <paulburton@kernel.org>,
 Aleksandar Rikalo <arikalo@gmail.com>, Jia Liu <proljc@gmail.com>,
 Stafford Horne <shorne@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-riscv@nongnu.org
References: <20260409-fix-unit-address-v1-0-946840930af2@iscas.ac.cn>
 <20260409-fix-unit-address-v1-4-946840930af2@iscas.ac.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260409-fix-unit-address-v1-4-946840930af2@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 9/4/26 08:40, Vivian Wang wrote:
> These unit addresses should have been in hex, not decimal, as per de
> facto convention [1]. Fix them.
> 
> Link: https://lore.kernel.org/devicetree-spec/CAL_JsqJFv3+UJ-bjLGk0i7Wc+spsowCrqQZ_s3P4gN8r1W-Q-w@mail.gmail.com/ # [1]
> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
> ---
>   hw/or1k/or1k-sim.c | 2 +-
>   hw/or1k/virt.c     | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/or1k/or1k-sim.c b/hw/or1k/or1k-sim.c
> index f1b1f63274..b851e48c16 100644
> --- a/hw/or1k/or1k-sim.c
> +++ b/hw/or1k/or1k-sim.c
> @@ -138,7 +138,7 @@ static void openrisc_create_fdt(Or1ksimState *state,
>       qemu_fdt_setprop_cell(fdt, "/cpus", "#address-cells", 0x1);
>   
>       for (cpu = 0; cpu < num_cpus; cpu++) {
> -        nodename = g_strdup_printf("/cpus/cpu@%d", cpu);
> +        nodename = g_strdup_printf("/cpus/cpu@%x", (unsigned)cpu);

No need to cast to unsigned explicitly, otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

