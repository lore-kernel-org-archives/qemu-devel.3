Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B88C369C2
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 05:26:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBoKV-0002tH-Mp; Mon, 05 May 2025 01:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uBoKR-0002sG-Uy
 for qemu-devel@nongnu.org; Mon, 05 May 2025 01:25:23 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uBoKP-0007c7-KA
 for qemu-devel@nongnu.org; Mon, 05 May 2025 01:25:23 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7fd35b301bdso4843822a12.2
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 22:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1746422720; x=1747027520;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7Icb106pO7p9hsD0bUB1jArCgCoupBUnXOdnF6Wu4Hg=;
 b=zpkeFb2Fz0ZSuRAoOkrfly0yBlvIswluyQsestXM9Qy1mZCYXgyIWu1OgZMMw1tMGj
 sfLetz+ATKtVew5hjGqT3NrSowj3LbgBs7YMzyteSpWvxVd8rn90B2ohdZ3jn+VJNGpy
 vF94XBRt3Nx29XJPeURBIt1oughBEBGW/aNCDt0dpkBBolcuxmgDpmNn/XRskMoTpdM+
 3aXsAZ4GfjcHMw/+Qi9DWh+Wd7wed2ACcWUywhKLGZFP7xWQqXUuWq3UWkPYnZNGctAC
 1P6ncldlYIhwmcrhPW6MfmVeKldFVmMUkOZvhw97YRM8Arpg6sq+Gjt/2ih+ElSE5uNp
 Hrvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746422720; x=1747027520;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7Icb106pO7p9hsD0bUB1jArCgCoupBUnXOdnF6Wu4Hg=;
 b=ptMhLPidMP7k65r/XvKmlpPovN/7rftMY9c5yPFPVrnxzL4QAliy1cFAu/wateXFyL
 x4PZQ1E4Wmrz+ohocAbyW3j2GSa/pyLdgH+J0pjOKj5usDFH00ayup4yYbEROxG4d8Ab
 ujBVueRksVUY1FvfWbF1caV+dGqYCjuhX47OlyAHdWHO3PO2/b15MvCQXQjEDNacEFrx
 hGIQbyWqKcSenXtfFKO7+vHp3oJCy2HFwKU60gWnNQLYFCYSFMKKKBC8LDZjrzV6rBPd
 KwOHjYXA9v9jxej26jp4bYxSjYwUsp3aRSPqsJppSMxyrT6SIGEGZCO/cFBLD2L/V0i5
 cFGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwbMkR1x5OW6P/YJm6juvdrxMXUwn4sx+Pt5b5f3rDY8i6xTdRTyDEAXiDOgRVcEaJkoJuhbKGe1Wh@nongnu.org
X-Gm-Message-State: AOJu0YzSQ7mZqIBa8I7Awml9vG8mgzA5yW0fbbEm1Mx/GiZa55aO7kA3
 wK/hkZ8gxRW8B/YKGBEL27Mjx50Iu5vk0GCodx9zClKbMGqg6OztpPv8S/UO87c=
X-Gm-Gg: ASbGncuo0Bq9SV2boMhweB81DSdfIzfYM8bGDv2ar6vGnvlhW9Z8xNDw4Auz4Bmx8B9
 KuNPMCX7xjeOzlVwzoCdPWpHkEmjp3aGTj/tVxc2j2phP9JsQnufVtrPKeKrJ+5Lc22sLILjmA1
 /zfSCqo7DNZlSfkTdWxvp2lU1wW6A/xZph3/Q9f42pTjSzzuN2h59QGNRlfSJnntyLMi/9IhvoP
 yLh5JK+Ui84b4qT9VDGPJnzXTWjyGQQcU6XXoQGShRi5ke+slUrXOc/rV/Gj5mSOcTCrlux/Re5
 5xaHdhZ0Rx6B/9S6c//CxtDWvwE8zH/nSAAvVJjt42USnB1dLRg=
X-Google-Smtp-Source: AGHT+IGUo4awLCN2gvufVwjPURGXck4ZXbzdO/ZL6HFRz7C3GVeTGY3svdeshijSqh2OPYQm2DwHNw==
X-Received: by 2002:a17:90b:5287:b0:2fe:a515:4a98 with SMTP id
 98e67ed59e1d1-30a61a42177mr7169475a91.31.1746422719537; 
 Sun, 04 May 2025 22:25:19 -0700 (PDT)
Received: from [157.82.207.61] ([157.82.207.61])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a3480ef8dsm10618681a91.31.2025.05.04.22.25.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 May 2025 22:25:19 -0700 (PDT)
Message-ID: <20b79b43-71ab-438c-9617-ff95bbf5eef1@daynix.com>
Date: Mon, 5 May 2025 14:25:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/11] tests/qtest/ahci: don't unmap pci bar if it
 wasn't mapped
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, John Snow <jsnow@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org
References: <20250502030446.88310-1-npiggin@gmail.com>
 <20250502030446.88310-7-npiggin@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250502030446.88310-7-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/05/02 12:04, Nicholas Piggin wrote:
> ahci-test has a bunch of tests where the pci bar was not mapped. Avoid
> unmapping it in these cases, to keep iomaps balanced.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
> Cc: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   tests/qtest/libqos/ahci.h | 1 +
>   tests/qtest/ahci-test.c   | 7 ++++++-
>   tests/qtest/libqos/ahci.c | 9 +++++++++
>   3 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/libqos/ahci.h b/tests/qtest/libqos/ahci.h
> index f610bd32a5f..d639692aac4 100644
> --- a/tests/qtest/libqos/ahci.h
> +++ b/tests/qtest/libqos/ahci.h
> @@ -342,6 +342,7 @@ typedef struct AHCIQState {
>       uint32_t cap;
>       uint32_t cap2;
>       AHCIPortQState port[32];
> +    bool pci_enabled;

The following patch also adds a similar variable for virtio and has a 
slightly different semantics; qvirtio_pci_device_disable() is no-op but 
ahci_pci_disable() aborts when no-op.

A bool flag can be added to QPCIBar instead so that we can enforce the 
"no-op if not mapped" semantics everywhere consistently with less code.

>       bool enabled;
>   } AHCIQState;
>   
> diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
> index 36caa7b2999..7d5f73ac40b 100644
> --- a/tests/qtest/ahci-test.c
> +++ b/tests/qtest/ahci-test.c
> @@ -85,6 +85,8 @@ static void verify_state(AHCIQState *ahci, uint64_t hba_old)
>       uint64_t hba_base;
>       AHCICommandHeader cmd;
>   
> +    g_assert_cmphex(ahci->hba_bar.addr, ==, hba_old);
> +
>       ahci_fingerprint = qpci_config_readl(ahci->dev, PCI_VENDOR_ID);
>       g_assert_cmphex(ahci_fingerprint, ==, ahci->fingerprint);
>   
> @@ -198,7 +200,9 @@ static void ahci_shutdown(AHCIQState *ahci)
>   {
>       QOSState *qs = ahci->parent;
>   
> -    ahci_pci_disable(ahci);
> +    if (ahci->pci_enabled) {
> +        ahci_pci_disable(ahci);
> +    }
>       ahci_clean_mem(ahci);
>       free_ahci_device(ahci->dev);
>       g_free(ahci);
> @@ -1421,6 +1425,7 @@ static void test_reset(void)
>           ahci_set(ahci, AHCI_GHC, AHCI_GHC_HR);
>           stop_ahci_device(ahci);
>           ahci_clean_mem(ahci);
> +        start_ahci_device(ahci);
>       }
>   
>       ahci_shutdown(ahci);
> diff --git a/tests/qtest/libqos/ahci.c b/tests/qtest/libqos/ahci.c
> index bd1994a9208..cc4f5b7b534 100644
> --- a/tests/qtest/libqos/ahci.c
> +++ b/tests/qtest/libqos/ahci.c
> @@ -215,17 +215,25 @@ void ahci_pci_disable(AHCIQState *ahci)
>    */
>   void start_ahci_device(AHCIQState *ahci)
>   {
> +    g_assert(!ahci->pci_enabled);
> +
>       /* Map AHCI's ABAR (BAR5) */
>       ahci->hba_bar = qpci_iomap(ahci->dev, 5, &ahci->barsize);
>   
>       /* turns on pci.cmd.iose, pci.cmd.mse and pci.cmd.bme */
>       qpci_device_enable(ahci->dev);
> +
> +    ahci->pci_enabled = true;
>   }
>   
>   void stop_ahci_device(AHCIQState *ahci)
>   {
> +    g_assert(ahci->pci_enabled);
> +
>       /* Unmap AHCI's ABAR */
>       qpci_iounmap(ahci->dev, ahci->hba_bar);
> +
> +    ahci->pci_enabled = false;
>   }
>   
>   /**
> @@ -249,6 +257,7 @@ void ahci_hba_enable(AHCIQState *ahci)
>       uint8_t num_cmd_slots;
>   
>       g_assert(ahci != NULL);
> +    g_assert(ahci->pci_enabled);
>   
>       /* Set GHC.AE to 1 */
>       ahci_set(ahci, AHCI_GHC, AHCI_GHC_AE);


