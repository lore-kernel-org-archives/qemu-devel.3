Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 065D5CCF9EB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 17:00:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDQZs-0005zC-1a; Mon, 27 Oct 2025 13:00:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDQZm-0005yu-N4
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 13:00:10 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDQZc-0001a6-FM
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 13:00:10 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-427007b1fe5so4204577f8f.1
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 09:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761584396; x=1762189196; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6Hhbqbl2JFn13SNwt+EdjfCvEeWKXegJVpttQ41Ra/w=;
 b=fVxBsAdBvmm+ii0trzpIFrfPOJ9Zdwe7fY6DHQrER9umohwo/wDUydbvr03uuFx9lB
 mtZWoiwQ3zMkzh8r3HZR8yBSQzQktzI2KoNik+v2rDjzUrrPPQBitSx/n152or9Q50hr
 xB42vCutrB/SEiN93OTt7drqeWgzjQMocuXx+AS16GAYy1eaiCB6+yr2/+vDz/ceMx/f
 oDXLumPA1Lbf41siwMGizWn3O4z7OILQae1/UNOaNfkRtIu+noTj2fMmrH5IvCzcBfuV
 R5fwvyrGsX4zEfLb3WM3tTtEtSawsmGguwgPAYgNWolY1/1LWjl7EKmlRhOfYuTlc0md
 fFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761584396; x=1762189196;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6Hhbqbl2JFn13SNwt+EdjfCvEeWKXegJVpttQ41Ra/w=;
 b=vxSiYeXo7hySU3gpfonGY2nbhhqKrrfZFRVt97m8gKix4n5Ne1l3odwIHVlbsMo6tq
 wbAUnrQqLM4LA616YEyhPmqo1V09N+KmzpK8qaG72uDlkyIi6gakXhFucMHdeJWZn2pb
 DnADeWCN6I/DT5kY/lVtPIQY6gpm/6l88nkXnHR5TeoGMiL6gj13NikQ9u7qfZqya8NF
 BlWILfqRwc5KQyYRIFI6CSIEe+5xwyzOaUyJO0UmI0qWtUokJpCUyKHDgZ+V6hlp2Hu2
 lH600emq97u1Y2qgI/8ZMxjpv9JnyK1UvImdt8iqrCMwpfEY//BF6RZr5PbJJ5p2jYAa
 52pQ==
X-Gm-Message-State: AOJu0Yzh3ScY7OZJlLta3U9AnVrfJHGVy/8n+G5lZczOXP1wBZPfJNBn
 R63GOirWu172Cio8AVhwfTT1dkaQrcq2pCElZytFnpTIw6cuXGxpZVNBnXcGMlgOHy8GRMWrB5E
 CI0FlnPs=
X-Gm-Gg: ASbGncuXtOSk68jFYbuvbXmLtcHczqJuaUxHl2FrwUlrFiOraEK4AHdC0pNgF7beyhC
 pyVDKzGEaQ2Buh+594H4TPKk2b7EhFZ0AkoMFcIP0jTyE3kmhb/Ef/FvXtf0yhjDFXA1Vv+r58p
 2ZZdJJ+KSquRzeAmy5mo4/n8b6KN1muyvjGvnyjWtw3RqBdyPm9+aq8bI/l9z+ITxqV3RFeGYzD
 EHCNYt3OLnhC5S3NCPZaXa+IKIIY1RJkhdSsSLlVu7BKHWkbGE3JRzR/pot8dtxzvLLAHEbjB7O
 u0t43U7qc5SOkS+toUpybWzysD2rqNw9Y/Zn54lESDW3pMLObaMbW7kpc89lVxkVRofyd0BkT9+
 QUXE/qNdNx8tQ59hwnQLfxrBO8w86k9g+TZnfQ5bb+1n8sEBzVhRC6kvk6uEHGp1iL+iNWuHE1J
 xKK70MtzcTAOq04BTLk1OxALxdqSIrryiDYB9B4OskokkiEYM7zN+9VA==
X-Google-Smtp-Source: AGHT+IEJ1Cv/AmpNtQu+FliggCE3O2OmtaL3NmKkUDwGaRoplk5JCAE5tZZawOLYVxt9G/O93um9Rw==
X-Received: by 2002:a05:6000:24c5:b0:429:8bfe:d842 with SMTP id
 ffacd0b85a97d-429a7e52c88mr343049f8f.4.1761584395933; 
 Mon, 27 Oct 2025 09:59:55 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952e3201sm15349398f8f.47.2025.10.27.09.59.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Oct 2025 09:59:55 -0700 (PDT)
Message-ID: <6e24181a-5deb-4eb2-9882-72d28e6005a8@linaro.org>
Date: Mon, 27 Oct 2025 17:59:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] hw/pci-host/typhoon: Re-use generic
 pci_host_data_le_ops MemoryRegionOps
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Helge Deller <deller@gmx.de>
References: <20251027165304.98296-1-philmd@linaro.org>
 <20251027165304.98296-8-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251027165304.98296-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 27/10/25 17:53, Philippe Mathieu-Daudé wrote:
> Avoid duplicating code, re-use the generic generic
> pci_host_data_le_ops MemoryRegionOps.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/alpha/alpha_sys.h |  1 -
>   hw/alpha/pci.c       | 26 --------------------------
>   hw/alpha/typhoon.c   |  4 ++--
>   3 files changed, 2 insertions(+), 29 deletions(-)
> 
> diff --git a/hw/alpha/alpha_sys.h b/hw/alpha/alpha_sys.h
> index a303c584383..c193f0a9b56 100644
> --- a/hw/alpha/alpha_sys.h
> +++ b/hw/alpha/alpha_sys.h
> @@ -14,7 +14,6 @@ PCIBus *typhoon_init(MemoryRegion *, qemu_irq *, qemu_irq *, AlphaCPU *[4],
>   
>   /* alpha_pci.c.  */
>   extern const MemoryRegionOps alpha_pci_ignore_ops;
> -extern const MemoryRegionOps alpha_pci_conf1_ops;
>   extern const MemoryRegionOps alpha_pci_iack_ops;
>   
>   #endif
> diff --git a/hw/alpha/pci.c b/hw/alpha/pci.c
> index 7c18297177b..d44cee570bf 100644
> --- a/hw/alpha/pci.c
> +++ b/hw/alpha/pci.c
> @@ -38,32 +38,6 @@ const MemoryRegionOps alpha_pci_ignore_ops = {
>       },
>   };
>   
> -
> -/* PCI config space reads/writes, to byte-word addressable memory.  */
> -static uint64_t bw_conf1_read(void *opaque, hwaddr addr,
> -                              unsigned size)
> -{
> -    PCIBus *b = opaque;
> -    return pci_data_read(b, addr, size);
> -}
> -
> -static void bw_conf1_write(void *opaque, hwaddr addr,
> -                           uint64_t val, unsigned size)
> -{
> -    PCIBus *b = opaque;
> -    pci_data_write(b, addr, val, size);

Hmm, likely incorrect, better ignore.

> -}

