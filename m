Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A56EC369BD
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Apr 2025 08:38:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u63hn-0007aX-6e; Sat, 19 Apr 2025 04:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u63hj-0007X2-6O
 for qemu-devel@nongnu.org; Sat, 19 Apr 2025 04:37:39 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u63hf-0004pm-FX
 for qemu-devel@nongnu.org; Sat, 19 Apr 2025 04:37:37 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22438c356c8so29363775ad.1
 for <qemu-devel@nongnu.org>; Sat, 19 Apr 2025 01:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1745051853; x=1745656653;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ElfWEPl1gEk9jxrPfW1VN/6UVK4tyvmmvYEyea4YYKM=;
 b=ASORMvqG2S3x5reYTsFhKTnmqAarjy/p2ZZsrzMVyEiuptUHGPDLWBiup9+cZQOps3
 J9r9XtFbGMFEewFGkukO6jBJNtYuFLNHExG8nrvqQqi5a1WtVQ6b1pzqskLrOL110NUY
 6Jo9eDjHg5XjNxW5avhUTdoebkwozIEHQEBMCuXMDrsqM/adfweBIhJxOawTduBVE3T8
 z+6Zd9QYeye9K+hutS2/6ZtbQfSXTWUEx9BKb1vSnZmAL1nABtXpAhqcLud/LPcs6n/J
 5vGlpl1KE8sH/0pkUDsX28bFNg/tIVd8B5+gUt2p4ApshkEvbnKBLZKsgPruSnlfk+iK
 Dzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745051853; x=1745656653;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ElfWEPl1gEk9jxrPfW1VN/6UVK4tyvmmvYEyea4YYKM=;
 b=di0Eqx7ZRUNDATBzxJ/G4aBZhwMQ9kPu22MJ07Fp8sGVZYxkP22n9j8hnWcG1Oi3el
 JU5Sp7xkm5l32vryN3HB+rhT6asuCyfcqpZzM4LpyiaUzmcHLCmtdRYsKIQd0RY9cYjr
 crXWHvoui4oHuOXGNqOdn7lh2zgQEjwaKUhHzx2xtkdsjqfShaBglFG8/nJzwVPU0xi0
 i6gDHVaWEYECBsv5x+/hMJtQzrxcEYbJoX7Wrloyf+NwN/Ovb674cI4SHlcftrNnUh5N
 I/NDve9ZVmHelJ5+SC6GdIS14KXYSE9YjseVc241q+C1485cKhMzGinNjcJ2dmeyZeGY
 UHRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJkP81l0BVaYdMptkcuxqRIxXhkuvR9sN+dGPxnPvLq8BOMq05w5iRZcxVgQlM87TkFB//NDKe7ANB@nongnu.org
X-Gm-Message-State: AOJu0YzOAbZurJ57p9Jfuyfd066PotnNProBz6b+sKdccxjatxubdSv+
 S7C0a/ybcpctyEejMJyWtAZ6cdgy6tceNsnpXbmeHx8zrjaHkTOatR9mtH7AC8c=
X-Gm-Gg: ASbGnctvGvCfmm7c1IB4lHVVFgz12esqrTdZsAHd1tdFM9joroS+CydlYXeZdw3A29Y
 DrB8xcT7vNb+5u7oteeNnxXb4kSdwUhtIk+hMPtB3ugdtAnt7RB/+FHswbobCZJX4B4i+rDrWHz
 yhbF1K6wsQc6SnRdXbqpFPQbmwOl5OZBtQKnwkZSXHwZjAOjBFSVBLh5SvMlg+YAXcIdbzAJ/cK
 Gjq6cs3iav4y8NHRBnlnbzBJhbZdtj2ukqL0i0vvAZ6SVJpM/1BfVZqZqJwlHXAmngZZKQivaAd
 UeIyakon66TIRZwS1h/gQAJeERG1OSFAcFJGyQQeYnpwQn44oH6MxNBSRfYiW/G9KsB/i+zCeJi
 VgOdIhaQWI13d9RdqBRA=
X-Google-Smtp-Source: AGHT+IF2aJ8n4JG4rs7pg1jsSlklvJ9WV6KKoA8W4vo09t6NubS2lv13p46OP2masL8O2yqxohevvQ==
X-Received: by 2002:a17:902:d488:b0:223:fbc7:25f4 with SMTP id
 d9443c01a7336-22c53596a3cmr70698925ad.14.1745051853431; 
 Sat, 19 Apr 2025 01:37:33 -0700 (PDT)
Received: from ?IPV6:2400:4050:b783:b00:9e36:5f4c:928c:4ec2?
 ([2400:4050:b783:b00:9e36:5f4c:928c:4ec2])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bf5549sm29230105ad.94.2025.04.19.01.37.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 19 Apr 2025 01:37:33 -0700 (PDT)
Message-ID: <e1b6adb7-c95c-4946-90d5-4fb9d25f7e4e@daynix.com>
Date: Sat, 19 Apr 2025 17:37:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] tests/qtest/ahci: don't unmap pci bar if it wasn't
 mapped
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, John Snow <jsnow@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org
References: <20250411044130.201724-1-npiggin@gmail.com>
 <20250411044130.201724-3-npiggin@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250411044130.201724-3-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2025/04/11 13:41, Nicholas Piggin wrote:
> ahci-test has a bunch of tests where the pci bar was not mapped. Avoid
> unmapping it in these cases, to keep iomaps balanced.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>

My address is duplicated.

> Cc: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   tests/qtest/ahci-test.c | 35 ++++++++++++++++++++++++-----------
>   1 file changed, 24 insertions(+), 11 deletions(-)
> 
> diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
> index 7cae6b58e0c..02c9d54f898 100644
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
> @@ -193,18 +195,28 @@ static AHCIQState *ahci_boot(const char *cli, ...)
>   
>   /**
>    * Clean up the PCI device, then terminate the QEMU instance.
> + * Should be called if ahci_pci_enable (or ahci_boot_and_enable)
> + * was not used, or device/pci was disabled later.
>    */
> -static void ahci_shutdown(AHCIQState *ahci)
> +static void ahci_shutdown_pci_disabled(AHCIQState *ahci)
>   {
>       QOSState *qs = ahci->parent;
>   
> -    ahci_pci_disable(ahci);
>       ahci_clean_mem(ahci);
>       free_ahci_device(ahci->dev);
>       g_free(ahci);
>       qtest_shutdown(qs);
>   }
>   
> +/**
> + * Clean up the PCI device, then terminate the QEMU instance.
> + */
> +static void ahci_shutdown(AHCIQState *ahci)
> +{
> +    ahci_pci_disable(ahci);
> +    ahci_shutdown_pci_disabled(ahci);
> +}
> +

I rather want to keep one unified function that performs all cleanup 
operations since it's error-prone to choose an appropriate cleanup 
function. ahci_shutdown() also calls ahci_clean_mem(), which checks if 
its cleanup operation is necessary before actually performing it so we 
can do the same for the BAR unmapping for consistency.



>   /**
>    * Boot and fully enable the HBA device.
>    * @see ahci_boot, ahci_pci_enable and ahci_hba_enable.
> @@ -945,7 +957,7 @@ static void test_sanity(void)
>   {
>       AHCIQState *ahci;
>       ahci = ahci_boot(NULL);
> -    ahci_shutdown(ahci);
> +    ahci_shutdown_pci_disabled(ahci);
>   }
>   
>   /**
> @@ -957,7 +969,7 @@ static void test_pci_spec(void)
>       AHCIQState *ahci;
>       ahci = ahci_boot(NULL);
>       ahci_test_pci_spec(ahci);
> -    ahci_shutdown(ahci);
> +    ahci_shutdown_pci_disabled(ahci);
>   }
>   
>   /**
> @@ -1143,8 +1155,8 @@ static void test_migrate_sanity(void)
>   
>       ahci_migrate(src, dst, uri);
>   
> -    ahci_shutdown(src);
> -    ahci_shutdown(dst);
> +    ahci_shutdown_pci_disabled(src);
> +    ahci_shutdown_pci_disabled(dst);
>       g_free(uri);
>   }
>   
> @@ -1182,7 +1194,7 @@ static void ahci_migrate_simple(uint8_t cmd_read, uint8_t cmd_write)
>       /* Verify pattern */
>       g_assert_cmphex(memcmp(tx, rx, bufsize), ==, 0);
>   
> -    ahci_shutdown(src);
> +    ahci_shutdown_pci_disabled(src);
>       ahci_shutdown(dst);
>       g_free(rx);
>       g_free(tx);
> @@ -1324,7 +1336,7 @@ static void ahci_migrate_halted_io(uint8_t cmd_read, uint8_t cmd_write)
>       g_assert_cmphex(memcmp(tx, rx, bufsize), ==, 0);
>   
>       /* Cleanup and go home. */
> -    ahci_shutdown(src);
> +    ahci_shutdown_pci_disabled(src);
>       ahci_shutdown(dst);
>       g_free(rx);
>       g_free(tx);
> @@ -1388,8 +1400,8 @@ static void test_flush_migrate(void)
>       ahci_command_verify(dst, cmd);
>   
>       ahci_command_free(cmd);
> -    ahci_shutdown(src);
> -    ahci_shutdown(dst);
> +    ahci_shutdown_pci_disabled(src);
> +    ahci_shutdown_pci_disabled(dst);
>       g_free(uri);
>   }
>   
> @@ -1421,6 +1433,7 @@ static void test_reset(void)
>           ahci_set(ahci, AHCI_GHC, AHCI_GHC_HR);
>           stop_ahci_device(ahci);
>           ahci_clean_mem(ahci);
> +        start_ahci_device(ahci);
>       }
>   
>       ahci_shutdown(ahci);
> @@ -1508,7 +1521,7 @@ static void test_reset_pending_callback(void)
>       stop_ahci_device(ahci);
>       ahci_clean_mem(ahci);
>   
> -    ahci_shutdown(ahci);
> +    ahci_shutdown_pci_disabled(ahci);
>   }
>   
>   static void test_ncq_simple(void)


