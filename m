Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 561BACCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 19:00:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBe46-00019w-1q; Wed, 22 Oct 2025 15:00:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vBe44-00018s-IN
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 15:00:04 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vBe42-0005oC-6V
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 15:00:04 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-780fe73e337so92256027b3.1
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 12:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761159600; x=1761764400; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3fNlJAIklGKmaXoZxWGY7d66z0UmEXF7YUPvyRdrvMY=;
 b=UZqh77H2ds8eVbTAx8+eJG1DUQ4CiCcK9YC7MiQb6pH6o2f34Y3vXDYPP+10cQfnXq
 LasQhiVjRSEQS+Yo4Rf1g/45rl13mvqZslUzcI130PFsxvXcuNWTypZUN0tyqle+ZfM7
 YsLTUCWf4egzBsnJaF5o7CXdm5snzKGREEVPib6M+fVMAFRLU3o2Exc+k1SXSBJkJeMJ
 hPuGNzXO7IA3/tVR0oLFy+rgSkN8blKEHmy0uFNSq3CAmchYsiwsFr8AVQFK6MVTnjUk
 HY47gCkZxwrQXt8BVHPM9BJ6bYpMpiLwTBbtjtfvhyVIx49Be2ZTSvinTMRdozyBnp4h
 wEFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761159600; x=1761764400;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3fNlJAIklGKmaXoZxWGY7d66z0UmEXF7YUPvyRdrvMY=;
 b=sweV5DM56kiiuIx0BM2Hs1wNpndnBt3LRk4Ve1lyDajH3ZpsSkTk3auAJLggUY6Vgc
 7vcqmKkiYLHIbMRo260oBSAzSns00R2/pQldrw3iamWFjDE26zigX0rOJpIJUF8lFbai
 ENhYbwj6dCUR6RbwNP2TsVVTXFWN1lV8dkADJc8XpUVdZR6MAGRuaoYDORBTNzX+67yp
 4dTbUd2rJ7naiv77Yt+WhV5AdlgGXOy2Rg9bb8eHZXExmJq2jEXI63jTNyN+LTlqv3ha
 CbPnjPksHWY7+XKnAdwBY44G4qrfZqBxJ9ju6nUVIGc40/Vqi870y9XhjUjN9Ob2+Os5
 6rCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVA5cigP7reFhmRv39IqiJ1qjuWPtjYbT8QNdI72INvHBjW8IxhrypT3CVFvbSK8yHnkeREYgv9OZn4@nongnu.org
X-Gm-Message-State: AOJu0YzVKVd2WgA6d3BDYZ2vufEBKWv3N/f8EDsoOl6xTBRgzdjIypIn
 uzUP4vTa08TnFBiUo0RLyq0RaFbmSdRZzEH5HgzO7mrZQZ9gUPfBAswf4Oo/dkSGTo4=
X-Gm-Gg: ASbGncuD1BaKW9zaI7PrIWzO9vs3g07/fJcn5/5A15iw3WPbPrOddIBVsu4TgndSiwn
 WvJC1TFGEXvNbTV2K+xdSF9Y/zlKqFaqrrVUnadJ4uPps+RQmTM/nVbTqv4rgrUIqIs82m1rnSR
 XwDHq7wJjVIu765yVuwLU4yWPW5JMJadCw+uoCxXxrkfWW0oyly6HOIB9DKDD1EKSeIkk+uPVbv
 npGfaBH5jspiJYqO9bBN9KrZtE4MFDlGWG5ZUGYfpG9k/0ofxERWD3ynBGfYi1rQEgajlH5N/82
 ey6kAuLJZy73rHdWc7edHCHvk5IomP149URrkKvWEeXinjzYkQY95zObdyxobPZIgTXp9jQ06Ml
 nU/sCc4x5pkGVAnLc7i7Am2S7wfE+4934B+DsEWxS0pXlCGtNx/Jagx9q6pw4dhyFVUvJKl4sRJ
 f9SD3XDELKHuIFCvEmmDtManOZuoazovf+oDGA/K/qUkHb/BMhx+xcK8beF/PBQ7bkoxY/taM=
X-Google-Smtp-Source: AGHT+IHBMoBwRn3qxrUOFuLH/BUwXNz5fl8W8J2u1GN69iUmSITjdF+MW5QmFcF7KROEGpe9Ac6pPg==
X-Received: by 2002:a05:690c:3690:b0:785:bfd8:c4b5 with SMTP id
 00721157ae682-785bfd8d398mr32042557b3.42.1761159599731; 
 Wed, 22 Oct 2025 11:59:59 -0700 (PDT)
Received: from ?IPV6:2607:fb90:5ec2:421a:7b72:4f29:1f36:27f3?
 ([2607:fb90:5ec2:421a:7b72:4f29:1f36:27f3])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-785cd5df1a3sm129517b3.17.2025.10.22.11.59.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Oct 2025 11:59:59 -0700 (PDT)
Message-ID: <c572407c-0c9f-4ce7-b8ed-e7f8929d957d@linaro.org>
Date: Wed, 22 Oct 2025 13:59:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] hw/hppa: PCI devices depend on availability of PCI
 bus
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
References: <20251017200653.23337-1-deller@kernel.org>
 <20251017200653.23337-9-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251017200653.23337-9-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x1131.google.com
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
> From: Helge Deller <deller@gmx.de>
> 
> Only create the PCI serial ports (DIVA) and PCI network cards when there is
> actually a PCI bus. The shortly added 715 machine will not have a PCI bus, so
> avoid creating further PCI devices.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   hw/hppa/machine.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> index bec5a86f24..b6cdbc74ba 100644
> --- a/hw/hppa/machine.c
> +++ b/hw/hppa/machine.c
> @@ -387,11 +387,13 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
>                           enable_lasi_lan());
>       }
>   
> -    pci_init_nic_devices(pci_bus, mc->default_nic);
> +    if (pci_bus) {
> +        pci_init_nic_devices(pci_bus, mc->default_nic);
> +    }
>   
>       /* BMC board: HP Diva GSP */
> -    dev = qdev_new("diva-gsp");
> -    if (!object_property_get_bool(OBJECT(dev), "disable", NULL)) {
> +    dev = pci_bus ? qdev_new("diva-gsp") : NULL;
> +    if (dev && !object_property_get_bool(OBJECT(dev), "disable", NULL)) {

Sequential testing of NULL pointers isn't ideal.

Better as

     if (pci_bus) {
	pci_init_nic_devices(pci_bus, mc->default_nic);

	/* BMC board: HP Diva GSP */
	dev = qdev_new("diva-gsp");
	if (!object_property_get_bool(OBJECT(dev), "disable", NULL)) {
	    PCIDevice *pci_dev = pci_new_multifunction(...);
	}
     }


r~

