Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3653CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 06:54:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBpDL-00016c-Nu; Thu, 23 Oct 2025 02:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBpDG-00015d-2r
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 02:54:18 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBpDE-0003V2-6B
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 02:54:17 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-475c696ab72so3052095e9.1
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 23:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761202455; x=1761807255; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sfBuDLoa3UoDVAu89X9Yh8HCpLmQt5sMVEpH70mm3fY=;
 b=B4TcaD+nKeYqK1B5kS3WDZ9o/9RQpXdLjQTDLdkrVMUF3gA9AemnDnCjXsot79CB28
 rv2Eu/TXCAALnV26oUIQ15U3KuG5E5Xm0BunraKQnCcgQ7bn2LGO+HTcLnKBdKvc/PsT
 7RN61yqDhXnmtimlyxInQ5Vm2vffG6YvPQJLYWA1RnNbxMk7+iXT2Z+Yxjbbc/LNJNwA
 dzmBfymtZPxwBUZLlqS1hZknq601yAnfJ9DoE6MmTLGqVHil4suDhDtITYErkLUGT/31
 nRjdGlOqQFwUmCJSI938KBpg+8+CJtOZfYFFAni/WAVFjvIgM+NygF6irFnmpwEnkf8Y
 +lZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761202455; x=1761807255;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sfBuDLoa3UoDVAu89X9Yh8HCpLmQt5sMVEpH70mm3fY=;
 b=WHxgaMH8zpc0LsYamJjeSkg1HOoa9C1ovOl0OY012i1g+bZMS2QOzmCOEvoNGVhCJB
 K/EVS5JCRzUxgMzh+Yt6ramCWJ1+qCRhKm/oAF7cyefka/eTKLRcYvT0Sxe+7zXs0b6q
 WYLLEHZ813EWeETke3tBIOLi1HQusmXpDjPUmj5lYJxEQqNq3VtX//uLfuqQgR3kaeWo
 n0I4XOZXGXMBT+5lqMHy1VboJaSfL14Zmq1i9TWUQBm9xS6m29pVZ/GF7/fsAnegrSS0
 l/0EjGcjqNpPrhgGWlYSTlTRHlsbEdHCyDAOtvslvuqaR6JG1JRL4RyS/goSfgMpteN+
 gItQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzJHHRrAZplpY6Vd2+L0wrsBXjXDjDJcfJwBWwsP5v7A4hjUZ7rqcSEwaJfeqakuIzCgxzRK3xHWsC@nongnu.org
X-Gm-Message-State: AOJu0YziiR013p0fKNavG+wW/jqhQKmUZxnNAnhjLdoAEOx0eFkHa1oe
 HRIpShdEFTh5CmnAAdPZlEf0fa9E7yR2aRNe7wZcDd1p2G0RoM+j7qK1umXY+C72L/o=
X-Gm-Gg: ASbGnctGCCzmRfFrJnwYYuMRF5fqZZJcfzoPezJwTql4SvTi4mWoGYfcfTxAVETPAjo
 b30CGe+T11dTcJu7SBsygFu9ikJeY/jVFC2tNmMYn58v7/iS2/cHq1hsNOf1M2DdZBHx5ZQS6XJ
 CIaTeurVCgRmWfvAkOO5FMr4Rb+eOIARUizeaD74j0f7a9vbqfVJD6wWufehlw6Ea1SramuVFlH
 BzMhgqwc1PhGIzNDijARPeJ0iYDGXQRR20VUnI+sSlqVVX0u7swDj1O/DWy+p9dqZB5NcPbyx12
 Ov+gyJEwDb4SFGuM6i8sO7wu99QqjVOelsbTiTPmz8sebowjgVDcaywgEPJIEBuZ2T31FQl9B0X
 sZFDm6tEd6zYIugQAIbGnnI0chNPhbaEQhVVM0ARJvUmJHTrMpWNRQdamqCRvMwJd3zd+XQggJ1
 GEbAbswewc3yXDKN4V+Sh7BE4wxIxTxGlnK6auSPMepUQ=
X-Google-Smtp-Source: AGHT+IEUwjGMWdVbQnuD8tj2U8XA4pD7A7vBICE7GkbT9rmfERN6h8gyazVlofFffr/1Lmv3XC9fSw==
X-Received: by 2002:a05:600c:3b8d:b0:46e:35a0:3587 with SMTP id
 5b1f17b1804b1-471179174cfmr172955895e9.27.1761202454017; 
 Wed, 22 Oct 2025 23:54:14 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-474949dd479sm56943485e9.0.2025.10.22.23.54.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Oct 2025 23:54:13 -0700 (PDT)
Message-ID: <63bb6500-56f7-4d4c-86ec-7aef613de6b6@linaro.org>
Date: Thu, 23 Oct 2025 08:54:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/12] hw/ppc/pegasos2: Add Pegasos I emulation
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster
 <armbru@redhat.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <cover.1761176219.git.balaton@eik.bme.hu>
 <8f5bd07553b41d83a54f9df0bb93b76b22dea5c5.1761176219.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <8f5bd07553b41d83a54f9df0bb93b76b22dea5c5.1761176219.git.balaton@eik.bme.hu>
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

On 23/10/25 02:06, BALATON Zoltan wrote:
> The Pegasos II is a redesign of the original Pegasos (later marked I)
> that replaces the north bridge and has updated firmware but otherwise
> these are very similar. The Pegasos uses the same north bridge that
> AmigaOne used which we already emulate so we can also easily emulate
> Pegasos I.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/ppc/pegasos2.c | 156 ++++++++++++++++++++++++++++++++++------------
>   1 file changed, 117 insertions(+), 39 deletions(-)


> @@ -89,6 +96,8 @@ static void pegasos2_cpu_reset(void *opaque)
>       if (pm->vof) {
>           cpu->env.gpr[1] = 2 * VOF_STACK_SIZE - 0x20;
>           cpu->env.nip = 0x100;
> +    } else if (pm->type == PEGASOS1) {
> +        cpu->env.nip = 0xfffc0100;

Preferably add a comment explaining/describing this value (think
at your future you in 3 years ;) ).


> +    case PEGASOS1:
> +    {
> +        MemoryRegion *pci_mem, *mr;
> +
> +        /* Articia S */
> +        pm->nb = DEVICE(sysbus_create_simple(TYPE_ARTICIA, 0xfe000000, NULL));
> +        pci_mem = sysbus_mmio_get_region(SYS_BUS_DEVICE(pm->nb), 1);
> +        mr = g_new(MemoryRegion, 1);
> +        memory_region_init_alias(mr, OBJECT(pm->nb), "pci-mem-low", pci_mem,
> +                                 0, 0x1000000);
> +        memory_region_add_subregion(get_system_memory(), 0xfd000000, mr);
> +        mr = g_new(MemoryRegion, 1);
> +        memory_region_init_alias(mr, OBJECT(pm->nb), "pci-mem-high", pci_mem,
> +                                 0x80000000, 0x7d000000);
> +        memory_region_add_subregion(get_system_memory(), 0x80000000, mr);

Since I don't want to delay this series any further, as a future
cleanup consider passing the host MR (get_system_memory) as a link
property, and map PCI hi/lo regions in the host bridge realize.

> +        pci_bus = PCI_BUS(qdev_get_child_bus(pm->nb, "pci.0"));
> +        break;
> +    }

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


