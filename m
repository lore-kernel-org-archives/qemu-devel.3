Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FA29D43359
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 22:27:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTp7Z-0001cx-PB; Thu, 11 Dec 2025 17:26:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vTp7R-0001aF-B3
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 17:26:41 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vTp7P-0005A3-Nw
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 17:26:41 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7b8eff36e3bso906071b3a.2
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 14:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765491998; x=1766096798; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S/kUz+nDt/WGpNRZXQCP2s6Nm2X+/R3zJqZWJXL3Do0=;
 b=RXWcj9TCkm+FnZpwCihT+10oyFmSrUX/aCjqvJUCU2nzU+JWqSIVQYQ/jjYNPH67Wh
 TymAFGy1A7asX4MZZrVLM8vNxEyGq7+W6TxLepODxQoa4hMU3Idkueji8/I26DLd3/qX
 2WgMQNM6T+kh98LHjrfOeKlellml9/O6BDSy8sI9GJJ45blUD+Pifrja+6lWcQ3ZA5yZ
 eq1bqtpzuv/+ROg2HDbnw4nxSEIypf6IkUAYP9HReJUEVX8a0Tuq5v4QSXnZB7kyxw3D
 frHYGCvjBAyM8Biieo94gbE/Ic2mAWrO2TmNJCmGibWtRVdduVXpyKqSWU2+MZXn69zG
 /9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765491998; x=1766096798;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S/kUz+nDt/WGpNRZXQCP2s6Nm2X+/R3zJqZWJXL3Do0=;
 b=w/Kp6BBXBzW6tB2Z/aczLl5fFefLR50HLrtXzLGjvS0p3dBA8SEUkZ7dLn+QdHsSZN
 G/IynPV6/Kr/CkfKtL8TSluHMmm++lUfSMCZ30aqiMrlI19GEhIGSJuIAphHg4fYYFd8
 OIIxsugSD/Ag3z4HFiAb2MnYhOxlj9kNY1P4UDKYll6kxYRDSPQ5eHXV8xsb4skhTlu2
 8AVxrhFMnwevhuvsrPLurFMb+ZSOtzV15+Rdx0EaZahFp3e41Wt1Q47GKPhor+GYwqM2
 4pWsvruTld+C5u+yazcwagvspXSxctOjJkn01BnLnmfGo6kyDGlJV/LDaQLN2b2jXrIs
 NMpA==
X-Gm-Message-State: AOJu0YwG8SMfJ/I/ceOq1/pOkQHjO7cF0CdqVSt12IQeAQc1wjcnXgHI
 lyqS4hrNO4g669DkplUR+GFHZUhrvUsXzh9pkAHd7nVqwjUaj71IleidftO6Lq0aRew=
X-Gm-Gg: AY/fxX7HuR4+2Cn7004ffrVGTXDd7SrYzoyOeoGEorF56KJgNmnrKX9qUfiEhAmy9zp
 +CbHEqZAuGbDv6TJNOure/UhrVanax1fIbwQ+wVRg/dv6WYgS18uiQXzmSwKv9uAPWGWlA0IC+V
 FTr5S1bxuxcgqhAFcF1xrfrUW3hlZ/yQF0kJbmlJy6HtA7HBFYRBlqoNFaVboB4aNowUX8YgQ+U
 Et+jvcxcY0aeBdHyMEMwgqRcaKe9nRCzTz0iEsdQQmL9nIskTq51f3tKxWQEntuuZ8tXpcI6xH+
 CjuX49c6+JbHGgGE2CkGmXcOLBfsKSrUsskgv3/wtdHBfkxj4+x+HNIEvxuqyxSKsgsfS2fjtFo
 SKXWxkUU2paQK0GO/AAoXa4da1gj151NofVAInCpixAAAzGGBbD2Wo3DL3k6oXY4qNyyXeZXUdH
 9U+MRPkrsDO+QSM/ma+AfuOf6jbvpm29i81RaV6WfEIxzauqE1ZdSu/u9v7gBTJcaSWg==
X-Google-Smtp-Source: AGHT+IHYCpBBriMfZUJDyn1sptct6fkolXdbKkDJyJeZfqNaJmd6DUxbfmiu/bHZy3ck7ZnrrcwGiA==
X-Received: by 2002:a05:6a20:6a11:b0:34f:1623:2354 with SMTP id
 adf61e73a8af0-369af813597mr24831637.42.1765491997834; 
 Thu, 11 Dec 2025 14:26:37 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7f4c4aa718asm3405729b3a.35.2025.12.11.14.26.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Dec 2025 14:26:37 -0800 (PST)
Message-ID: <ea6a119a-49fb-490f-9532-6de60e9f049a@linaro.org>
Date: Thu, 11 Dec 2025 14:26:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/1] hw/pci: Add sec-sid property to PCIDevice
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Chen Baozi <chenbaozi@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>
References: <20251211102729.227376-1-tangtao1634@phytium.com.cn>
 <20251211102729.227376-2-tangtao1634@phytium.com.cn>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251211102729.227376-2-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

Hi Tao,

On 12/11/25 2:27 AM, Tao Tang wrote:
> Arm SMMUv3 uses SEC_SID to control how it interprets the security
> state of incoming DMA requests. When SEC_SID=Secure, the SMMU
> examines additional signals to distinguish Secure vs Non-secure
> streams; when SEC_SID=Non-secure, all requests are treated as
> Non-secure streams regardless of other signals.
> 
> The SMMU spec states that SEC_SID is a system-defined property.
> And devices capable of SEC_SID=Secure should be statically marked
> by the system.
> 
> This adds a uint8_t sec_sid field and "sec-sid" QOM property to
> PCIDevice, allowing boards to configure this attribute. Values are
> 0 (Non-secure, default) and 1 (Secure).
> 
> Note: This is not a PCIe architectural feature. It is purely an
> SMMU integration mechanism and does not affect PCIe transactions.
> 
> Future RME-DA/TDISP work will use the PCIe TDISP/DTI protocol to model
> Realm and Non-secure streams, instead of extending this static field.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>   hw/pci/pci.c                | 7 +++++++
>   include/hw/pci/pci_device.h | 3 +++
>   2 files changed, 10 insertions(+)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index b1eba348e0..1f944d0e39 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -98,6 +98,13 @@ static const Property pci_props[] = {
>       DEFINE_PROP_STRING("sriov-pf", PCIDevice, sriov_pf),
>       DEFINE_PROP_BIT("x-pcie-ext-tag", PCIDevice, cap_present,
>                       QEMU_PCIE_EXT_TAG_BITNR, true),
> +
> +    /*
> +     * System-defined, statically configured SEC_SID for this PCI device, used
> +     * by Arm SMMU. Currently only support Non-secure (0) and Secure (1)
> +     * security states.
> +     */
> +    DEFINE_PROP_UINT8("sec-sid", PCIDevice, sec_sid, 0),
>       { .name = "busnr", .info = &prop_pci_busnr },
>   };
>   
> diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
> index 88ccea5011..16364731da 100644
> --- a/include/hw/pci/pci_device.h
> +++ b/include/hw/pci/pci_device.h
> @@ -184,6 +184,9 @@ struct PCIDevice {
>       uint32_t max_bounce_buffer_size;
>   
>       char *sriov_pf;
> +
> +    /* Arm SMMU SEC_SID */
> +    uint8_t sec_sid;
>   };
>   
>   static inline int pci_intx(PCIDevice *pci_dev)

this is an excellent addition, and something we definitely need for 
Secure support in SMMU.

May I suggest we have a string value instead of a uint8_t?

This way, it would be explicit to have:
sec-sid=non-secure (default)
sec-sid=secure
It can be backed by a proper SMMUSecSID variable, so once command line 
is parsed, we don't deal with string anymore, but with a proper enum 
instead.

Thanks,
Pierrick

