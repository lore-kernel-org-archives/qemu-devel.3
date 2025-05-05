Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3837EC369C2
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 05:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBnzN-0006GR-TP; Mon, 05 May 2025 01:03:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uBnzM-0006FX-A9
 for qemu-devel@nongnu.org; Mon, 05 May 2025 01:03:36 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uBnzK-0005Zi-DI
 for qemu-devel@nongnu.org; Mon, 05 May 2025 01:03:36 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-30a5094df42so3338013a91.0
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 22:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1746421412; x=1747026212;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uFw1b14NScRQs5mMH0gaIronaorVdtlMXxu1OAs/Xko=;
 b=wgR5a/zw54uApCLavdllxitbw1qwcxgd0Y9OeGVWgQ6AQtj4U9JjP6t6nAv00j/AeI
 zsvh1gd+9v6/W6x7vaL9+ouUggZz4MvDIOJOBVLwbxcezSFCZpX542r00ItSWBdcnmRC
 WSCHexVvrX6rmyDusRW1FRJkheCnHHMepSipQrEr+DzIwMv6Oi8I8ovX8pB4YNeAqYzv
 9sRo6D/k3rYPOzv7Lw2bdmiSeo0blUFQw28Hk0ogL211Akd3frdy9JgSanPbkdOOS1v2
 OKWY0d/UOdWwM8ALVMihJMTZX6afbsZi46Gl0l4o1LZWBRUIdF+xV+x+MJOjoLL20Jl1
 xJlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746421412; x=1747026212;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uFw1b14NScRQs5mMH0gaIronaorVdtlMXxu1OAs/Xko=;
 b=UdvJZLv5Pycl2AplRkr38oLVxUA2EkGlBIqHJVsccytoWlzpE1Or5rfYUWeBVoX0aW
 3a1fHWGQidIxZRDqUC0940wOYnYtj6mqnCDWf5vx5FVEY3Pfjc3odikdYxTcqf5gVY8X
 GdJ4fPwcDwaqPDRfgXKnWeuJPC+hkSQXV0pB8+KEpbKapGlL595VPViuKMv/ia4/3dE3
 x2SnAppaQUaJHI2EpIDiSFUoap1d0I/awWMKNKahDul5h8k4s4pJ7ScvzM2FVSMJ8qmD
 d4NiWsFSAKB3zNg/G8ElXS4t8LH824+KvwJIfB4RfpO0NEvX/VmUxewVD15MYr5ATYvP
 d5bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZHO2iWnRwWAVWPg3DPz+SB+yz+vecveoUO3/lZwLuzz4LiR/ZBKVqIjJ2veEWXmMlB6cSI9ecfkR5@nongnu.org
X-Gm-Message-State: AOJu0Ywsu7tawRl77hpNaHdGt1zcR6zhStH9NBzznDAxwFQ3uZBzirMx
 xzWYsSwDNqJhpseva0ReSjeTg9dJZtUfjK+9PLDK0B/4LFEfdMOmnKtyqq3QQPU=
X-Gm-Gg: ASbGncsmxZaTEDHipJPIM9iMpG7blMGeYaINL+sfoqzl9DfXcvPEZVIKsd8yW2VYVdN
 HmYC3M+WkPvwDz7qmPMVcYHCnMst6DB/a3gte+8PAN3IwmoTPpeo+Tu65hjXEFl42ZfMruao+vh
 xCuOFK7CAeF9to+qPrgSgyxwQyQ0QwTBpyBefoUZSkx2icN0dSE1z8keqEnv6RQycTDM7cE+12F
 KienKDkBV5rBPd6/RYYwkZH+IKBnbQjs07cVb0+M97fIPUym1WpZHZJRPYPXtpuRwIL153aNxhZ
 2YTrH3hUe4BCYv4n85IqZHy/nUPiPX2dHhvSJYKfnY6asiwACMw=
X-Google-Smtp-Source: AGHT+IFbopmJsSuBNwHyHvqhGv8ZjYaakUM48WJwtSVqGcq4o9XNP72eFrE2RtKcufiiHAtCMSAZuw==
X-Received: by 2002:a17:90b:586e:b0:2f4:4003:f3ea with SMTP id
 98e67ed59e1d1-30a61a44ca3mr10631622a91.33.1746421412443; 
 Sun, 04 May 2025 22:03:32 -0700 (PDT)
Received: from [157.82.207.61] ([157.82.207.61])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a4764226csm8650669a91.43.2025.05.04.22.03.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 May 2025 22:03:32 -0700 (PDT)
Message-ID: <6abde928-6d52-4100-ad48-3541257c6542@daynix.com>
Date: Mon, 5 May 2025 14:03:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/11] tests/qtest/ahci: unmap pci bar before reusing
 device
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, John Snow <jsnow@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org
References: <20250502030446.88310-1-npiggin@gmail.com>
 <20250502030446.88310-6-npiggin@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250502030446.88310-6-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102f.google.com
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
> ahci-test double-maps the hba bar in the pending_callback test.
> Unmap it first, to keep iomaps balanced.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   tests/qtest/libqos/ahci.h |  2 ++
>   tests/qtest/ahci-test.c   |  4 ++++
>   tests/qtest/libqos/ahci.c | 11 +++++++++++
>   3 files changed, 17 insertions(+)
> 
> diff --git a/tests/qtest/libqos/ahci.h b/tests/qtest/libqos/ahci.h
> index a0487a1557d..f610bd32a5f 100644
> --- a/tests/qtest/libqos/ahci.h
> +++ b/tests/qtest/libqos/ahci.h
> @@ -574,7 +574,9 @@ void ahci_clean_mem(AHCIQState *ahci);
>   QPCIDevice *get_ahci_device(QTestState *qts, uint32_t *fingerprint);
>   void free_ahci_device(QPCIDevice *dev);
>   void ahci_pci_enable(AHCIQState *ahci);
> +void ahci_pci_disable(AHCIQState *ahci);
>   void start_ahci_device(AHCIQState *ahci);
> +void stop_ahci_device(AHCIQState *ahci);
>   void ahci_hba_enable(AHCIQState *ahci);
>   
>   /* Port Management */
> diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
> index e8aabfc13f5..36caa7b2999 100644
> --- a/tests/qtest/ahci-test.c
> +++ b/tests/qtest/ahci-test.c
> @@ -198,6 +198,7 @@ static void ahci_shutdown(AHCIQState *ahci)
>   {
>       QOSState *qs = ahci->parent;
>   
> +    ahci_pci_disable(ahci);
>       ahci_clean_mem(ahci);
>       free_ahci_device(ahci->dev);
>       g_free(ahci);
> @@ -1418,6 +1419,7 @@ static void test_reset(void)
>                                  CMD_READ_DMA_EXT,
>                                  CMD_WRITE_DMA_EXT);
>           ahci_set(ahci, AHCI_GHC, AHCI_GHC_HR);
> +        stop_ahci_device(ahci);
>           ahci_clean_mem(ahci);
>       }
>   
> @@ -1484,6 +1486,7 @@ static void test_reset_pending_callback(void)
>       sleep(1);
>   
>       /* Start again. */
> +    stop_ahci_device(ahci);
>       ahci_clean_mem(ahci);
>       ahci_pci_enable(ahci);
>       ahci_hba_enable(ahci);
> @@ -1502,6 +1505,7 @@ static void test_reset_pending_callback(void)
>       ahci_free(ahci, ptr1);
>       ahci_free(ahci, ptr2);
>   
> +    stop_ahci_device(ahci);

This stop_ahci_device() call is unnecessary since ahci_shutdown() follows.

>       ahci_clean_mem(ahci);
>   
>       ahci_shutdown(ahci);
> diff --git a/tests/qtest/libqos/ahci.c b/tests/qtest/libqos/ahci.c
> index 34a75b7f43b..bd1994a9208 100644
> --- a/tests/qtest/libqos/ahci.c
> +++ b/tests/qtest/libqos/ahci.c
> @@ -205,6 +205,11 @@ void ahci_pci_enable(AHCIQState *ahci)
>   
>   }
>   
> +void ahci_pci_disable(AHCIQState *ahci)
> +{
> +    stop_ahci_device(ahci);
> +}
> +
>   /**
>    * Map BAR5/ABAR, and engage the PCI device.
>    */
> @@ -217,6 +222,12 @@ void start_ahci_device(AHCIQState *ahci)
>       qpci_device_enable(ahci->dev);
>   }
>   
> +void stop_ahci_device(AHCIQState *ahci)
> +{
> +    /* Unmap AHCI's ABAR */
> +    qpci_iounmap(ahci->dev, ahci->hba_bar);
> +}
> +
>   /**
>    * Test and initialize the AHCI's HBA memory areas.
>    * Initialize and start any ports with devices attached.


