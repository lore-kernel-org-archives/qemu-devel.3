Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C2DCCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 19:10:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBeE4-0006Hb-QR; Wed, 22 Oct 2025 15:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vBeE1-0006H5-TE
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 15:10:21 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vBeDz-0007jy-He
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 15:10:21 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7b4f7a855baso7448a34.3
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 12:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761160218; x=1761765018; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rhxl521kQPT0vbS2vdF8H+QZj0yDHPTg5s1ROOPzNYQ=;
 b=vbv81rX3TQJMT4hC1V7WenkJOk2YuT/AB+KRpLcpfscHSVxUallseAHyT/UcLQ+ogY
 Cdta7wkICoUelzSV4f7EcMZX/ZrtRkHjT6bD1GdoPfToMrBobF0Xnm8aJ12fPYhoojHB
 frtRA/eVeqZ6WRJTgG4DY7c5HBYrCqxe6gcFyLNRd12IUjomAPWIneW6LhQW8LRqNsc3
 LFaWl0QTai7w6j81GilICxy82CVcg7Tegx38p2qvVEexN+PLJH36oa8YHZbhN9UBl7pD
 TmFS5lepfjMkb93F2ySppKO9QtvV5eRjDNFV70kxkvnLBzVBr6OxyejLUM5P0UYFSm5B
 WW4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761160218; x=1761765018;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rhxl521kQPT0vbS2vdF8H+QZj0yDHPTg5s1ROOPzNYQ=;
 b=Ms9VHev/6E/UKIgEztN/GrJrC4y815ZS8LkYmfhTdx2SY+y6uDe4NHnLsAFgwBdSXu
 PRd1UQAzPY8D/6Ik9R5z6jIiNt1Y/zu+ZUZLOhHk/TVe3UMrQDex+9UaKk7wHdH2mToV
 dqnOVUlD7sT1s8wOeGVf60E9U2flNqU/ZDoFB85b0q/Rnf9FbBnvf7wAsQMGJOZESliG
 5tz7fppNqAQeh0rmZvDGjg6k3zRDadg0EItnoTjY30ZC4CUSmSxroPxmgHhoAmqpMbQp
 a9LWwpvSGtJUaPgxpxq78+cAN+v+TwovVNHB0vcoZvmy3bBjiiPjvII+AKlZfMGnsP9V
 nAvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUv6w4AOnexH+TLs5FshsZNEnyNvZbc6Vio8s4ca/7K01tCqIAF2K3wCL1I0taMFVZLfXX+vHFAcv5D@nongnu.org
X-Gm-Message-State: AOJu0YzwNvrOhfvK2Z+Of+qmjofV4zIa89UlzWBKAAVPyBTcunI46gU3
 IjPETKHcV2neDc9aQdFDcjDAgkRr8bb43JZRXQ1yvyDGSwMb8ahmh7F50i87FJD0ytg=
X-Gm-Gg: ASbGncv1M7U7mcNX7/MHjD4vRSKvrxcmGeWlHQJghTVj1iHOTyYwRARS91pEsimI/dC
 UIX8TY1Q4Wd7IEEY2FlDIkDHZKn3h/9K8q9vwmwlaiSg2YtLWvfn0aN5B1kFmUWlbGk/22sIR8e
 MWshTQ2lgD8yACtizqLZrOYAXre9yDvRje6x9ez7izv+t/5aKHsVGE0XM48P36Ww3GeYT/+d2yO
 VvL7DL4JniyxgD+KNYOTU0tVd9IRkXw/nD/+l0x2CVdUCQi71TdRMW+YHgwjgTP/5NU0LpbsZ1O
 TUdIVSfDafmEURUVL7O4ZWx5U5kwdzhETHuDEKKcTX9GAH067A6JfZrDVJ+kUXOcHzEx81956us
 Fo76WMWYr1GRa23i6oyoNIIG8zV61Pg69I+RdJ2LcGX6B10U25vUMvw/LHtpp1RjIIPrMhcx4nY
 GB11YhrOMd+EqFZbL54Qa0leHYBrtCuxc0f/Zxc1YATN1gCDjEV5XcDOFO5tip
X-Google-Smtp-Source: AGHT+IFl0i3mLty5ScM9F1h0Ifrsre8sYoh175ophQwoIhiiyF02u/yT/Rx917UHv0hZbdoZbjbnmQ==
X-Received: by 2002:a05:6830:6d0e:b0:79f:19f:809 with SMTP id
 46e09a7af769-7c27c5449c4mr10821105a34.0.1761160218154; 
 Wed, 22 Oct 2025 12:10:18 -0700 (PDT)
Received: from ?IPV6:2607:fb90:5ec2:421a:7b72:4f29:1f36:27f3?
 ([2607:fb90:5ec2:421a:7b72:4f29:1f36:27f3])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c288932dc5sm4813719a34.31.2025.10.22.12.10.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Oct 2025 12:10:17 -0700 (PDT)
Message-ID: <b250c6ff-d687-46b7-b540-61b67eba8903@linaro.org>
Date: Wed, 22 Oct 2025 14:10:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] hw/hppa: Add 715 machine type including NCR710 SCSI
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
References: <20251017200653.23337-1-deller@kernel.org>
 <20251017200653.23337-11-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251017200653.23337-11-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x331.google.com
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

On 10/17/25 15:06, deller@kernel.org wrote:
> @@ -363,8 +365,20 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
>   
>       /* SCSI disk setup. */
>       if (drive_get_max_bus(IF_SCSI) >= 0) {
> -        dev = DEVICE(pci_create_simple(pci_bus, -1, "lsi53c895a"));
> -        lsi53c8xx_handle_legacy_cmdline(dev);
> +        if (pci_bus) {
> +            dev = DEVICE(pci_create_simple(pci_bus, -1, "lsi53c895a"));
> +            lsi53c8xx_handle_legacy_cmdline(dev);
> +        } else {
> +            dev = lasi_ncr710_init(addr_space,
> +                       translate(NULL, LASI_HPA_715 + 0x6000),
> +                       qdev_get_gpio_in(lasi_dev, LASI_IRQ_SCSI_HPA));

Indentation past (.

> +            if (dev) {
> +                lasi_ncr710_handle_legacy_cmdline(dev);
> +            } else {
> +                qemu_log("HPPA Machine: Warning - "
> +                         "Failed to create LASI NCR710 controller\n");

When can the init fail?
Should you be passing down an Error pointer?
Would an assert be sufficient?

> +    /* Create ISA bus, needed for PS/2 kbd/mouse port emulation */
> +    isa_bus = hppa_isa_bus(translate(NULL, IDE_HPA));
> +    assert(isa_bus);

... like here.

As an aside, we could usefully mark such functions returns_nonnull.
Or even __attribute__((malloc, returns_nonnull)) to indicate a new object.
That's obviously separate from adding the 715 machine, but it's something that we should 
think about rolling out tree-wide.


r~

