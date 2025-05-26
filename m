Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07FEAC54FC6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 05:41:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJQZr-0002Du-1N; Mon, 26 May 2025 01:40:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uJQZk-0002DJ-LD
 for qemu-devel@nongnu.org; Mon, 26 May 2025 01:40:42 -0400
Received: from mail-vk1-xa43.google.com ([2607:f8b0:4864:20::a43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uJQZi-0003KY-Cv
 for qemu-devel@nongnu.org; Mon, 26 May 2025 01:40:40 -0400
Received: by mail-vk1-xa43.google.com with SMTP id
 71dfb90a1353d-52d9a275c27so1196620e0c.0
 for <qemu-devel@nongnu.org>; Sun, 25 May 2025 22:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748238036; x=1748842836; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eX7rKwEVeBoFbfBoHpfuEgu5R7z1fok8+2Ur3zkfZLs=;
 b=QlGkwdRbAJmwyVfbvhaQPEzlan1C2azC6nsURdrYIMg/UpEeTItt2ers3NHV5PEaOJ
 NHSxFoRHIPqjwsyX1qP+qa/oji1A10gegJUj0TvAbSdw/OJ8zpQGcfZYCDwJNeoYj6D1
 dR+xEfoo3r/s3NJvn/UfULaVXxJrM6QsJEDHZcBXEN4eOeVYmfyyAquHerhV7BhqL0ww
 HrplChZYV5BUXhNAe0lVICCNsGwTADaqaVJCH2JrnaOJRdKlL2xIiv/xsHjbXKX9rdsg
 WAJA3PBXR3MJ1OFko6Ev64HESja4A94FDVdVvTN+CmUMr5wS27Ee5SQUe5NUf8BKrz5k
 hZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748238036; x=1748842836;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eX7rKwEVeBoFbfBoHpfuEgu5R7z1fok8+2Ur3zkfZLs=;
 b=CoGyxroI4JzQhdLFkfqz2d7ZSQ6rd1KoF0IUUn+DYRMz7HJ6Z36Ny7/FWuyRLuEUFq
 E9lgrsEUtKOKjXYN7U6bjLefCrenWcmiOt5NoMjnhMLN3L+ixMyftDbi9IZwawmZCsR9
 WOvTAagzebpOflfTAdbycjJqcZpbGMGcX4p04e9yDx8+B+XhPCiai5G625gofgAgYmXq
 QtdrLBBZKNteCYHoRcUAOXcC24dlO7RLJwarrR/rb3g1sdy67wXkcRkZkO/fqLc7TK1y
 zlvWCMcVemeRaa72BLI7ERaVkUCWTZgO0bP9kxrlsqXCoX4TX+iSXuUAdQuluhS3pfeg
 j0Rw==
X-Gm-Message-State: AOJu0YxzZ3qHK3hQ6mGT7vTe+dlNj+qCPBn6M8m+G1djdx5EnVLDc+P5
 CC/J5ouTsZjR0uCaYt1litMIhcKRWKhm5REWF+coCv6dELXeaT9hgb+lwSdxnt6jYu1NgjDuqFy
 jwbuMLFr3gQ==
X-Gm-Gg: ASbGncsHZMg0psdex8nb48FPEYH9EyQnFe+OYdOwgHIsc5tFuxbvaSnNbkYsf44uth9
 SATFMmO7AQIpfjtCxmOYs2t2euLLRVgPcXTZAXsYSpI6g2uRapjINN2lw0wH/2SojEIUzffSiMp
 gBEyDH3D9dMvDhbjjVIjJOIMEnA8CfTYii3Ki+PxEVNOFBbHXNtVR2HR9lb64q8v7SRZ8iGJkwV
 Mij/XqmiTK8BOaLgFBdoLJRIuS8vTjXz2eyVnbD5hScMrX9DBrFDLYMIHYiygstdZPV3gW1szyW
 hJ79E9qd9vVDs/ABbxgqZIIXrh71Gt+G3Cc3cGGCVlAjdRnGK38pcG/ev8X5x9y3yMCGu4mAIgu
 dGw4AFb95OKykkaJYOFs4t1Lz1e8dug==
X-Google-Smtp-Source: AGHT+IFAkofzZafmpvZGZDjLLsmro+pk3TmxyHtqUuBdMjEpKrM5lKOrdfAyS4CzV2sfYSuNQVkFCA==
X-Received: by 2002:a05:6122:81c4:b0:52f:4776:f6a7 with SMTP id
 71dfb90a1353d-52f4776fcb5mr305127e0c.0.1748238036659; 
 Sun, 25 May 2025 22:40:36 -0700 (PDT)
Received: from ?IPV6:2804:7f0:b402:6ba2:d081:510e:25da:56a5?
 ([2804:7f0:b402:6ba2:d081:510e:25da:56a5])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-52dbab6c0c2sm17171111e0c.42.2025.05.25.22.40.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 May 2025 22:40:36 -0700 (PDT)
Message-ID: <160e3fea-3582-4f9f-b4e7-1dd628e08be3@linaro.org>
Date: Mon, 26 May 2025 02:39:36 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: New test in bios-tables-test.c for the ACPI PCI hotplug on ARM
 series
From: Gustavo Romero <gustavo.romero@linaro.org>
To: Eric Auger <eric.auger@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <e376b3f5-81e9-4b67-ba8c-048ca713d894@linaro.org>
Content-Language: en-US
In-Reply-To: <e376b3f5-81e9-4b67-ba8c-048ca713d894@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a43;
 envelope-from=gustavo.romero@linaro.org; helo=mail-vk1-xa43.google.com
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

Hi Eric,

On 5/22/25 22:13, Gustavo Romero wrote:
> Hi Eric,
> 
> While we go through the ACPI PCI Hotplug series [0] and review it, I'm
> starting to take a look at tests/qtest/bios-tables-test.c.
> 
> You mentioned testing the combinations of "acpi-root-pci-hotplug"
> and "acpi-pci-hotplug-with-bridge-support" flags [1], but taking a
> look now I see that "acpi-root-pci-hotplug" is only used in a PCI
> context (not in PCIE, so not meaningful in GPEX), hence
> "acpi-pci-hotplug-with-bridge-support" would be the interesting
> flag for testing the ACPI PCI HP series for ARM. Since this maps to
> 'use_acpi_hotplug_bridge' variable in i386 (e.g., in ICH9 controller)
> and this variable is being controlled by machine flag "acpi_pcihp"
> in the series, I understand it's only a matter of testing the ACPI for
> acpi_pcihp=off and acpi_pcihp=on. What do you think?

I've posted v1:

https://mail.gnu.org/archive/html/qemu-devel/2025-05/msg05824.html


Cheers,
Gustavo

