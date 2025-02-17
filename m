Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF09FC021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 07:32:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjvbj-0007pV-BX; Mon, 17 Feb 2025 02:31:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjvbi-0007mX-5O
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 02:31:58 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjvbg-0004T6-8E
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 02:31:57 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43971025798so7562835e9.1
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 23:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739777514; x=1740382314; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oWtO0tCA7Cjri5BY0+EOuoEkHHmD6A5uSTSzVNfGZzo=;
 b=jG7gt2Wodoq7dpgUOZpaKPWm/nuGWwCgmbhLnuhcJtU60RW+XBHRhdABeNsVBtiX9A
 sVWXTdYClAR2VXxly7kxgBpQT7fIsLQlvYzCAtusoHvvcUS65cPemNcgNeAQjC2S7twJ
 Ody8CT4CoIEYJLJIHRzekAZF9toSTzs857sEL1g8txrUQNNW+tBmEAL/GZ6Xfe0Sfq65
 u4iUe3NBHNIMyzpUK/2X/UyBwdx7eXLxr1gAkl9snGjz8T174+WvLZ56jkqMPoRYEGHU
 pFq0VItVWu/dlbaLalwo7QccdGYTRBTtYKQ4H4VHoo73nDE6XHLVrWB3X3eoG5P6QHUT
 WCpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739777514; x=1740382314;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oWtO0tCA7Cjri5BY0+EOuoEkHHmD6A5uSTSzVNfGZzo=;
 b=c7TQp/5e3nrqdwFnSdGtafek/ec1gax7proT+9y9NAVxChFwk4q/6MQ3h/bKJeCaAn
 Y3jrwZ+qZeAucEgrjeQiQjtrDorPFqLnf9ThN3Yl1Bvt0CNsYmWdgJvauXtodYwKz8/e
 oEXBYzFyolmevSXcSOFgbfnnMcM2JF1XWCBEoWLGjPFsrqCV7LZ0wEOOgbJsEVdylTLW
 PdFAMB8y6LklFB9fgt3RVJYC74gyQTfGH6KbDcMTXr+p4whimDaONpmAZ+dMb7g0ZDzU
 SjtBF3BFTlSi9EOwpI+AKGoQBgr8cKa6qnXPf6Ap3kjIX2RH7XjYeXqsJQLy2myKWdxK
 J1uA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGp+llfTEO4Ncqj/0n1Lrz9WVRRQDvtXiERiKMr5KeIlrq18/SEmaKEAPEgVVrhf4VaVgbzAcl4eSn@nongnu.org
X-Gm-Message-State: AOJu0YwqXO93esiIuvAPI6HWc9AZPThISQ08HIUwf5I3Md8H1SA+Ped+
 YRK93eoCwTNZ5qq0GGZGDC4ZDmRT7D18/cRVLgFi7pLR+oHDQlA1RPD/D3cI+qI=
X-Gm-Gg: ASbGncvcBSiEj553/DH8affI1hZj0AAOIsgCyjQtnKkHIp6M2/RJP8R28q2nb28V7Ms
 V7Wmt8G9NbHOZu3h2dDV5S5FoGiJYP7rCUMQGIm45g2zyRuw2Z/kabC0jh2oD/S2xY4RrqyId/3
 tJ9SUUcTDjB7OHWl52zaXV55s/B+QVjzlBfB770MgDiIcnv92Fb3Kqwe/Y0uzWfJgZ6OnR1YVdM
 Df8I/H/Sgn9UFn9ZtjCaQ32qNYzsCssRKbZtiLhuogEMcwGq6ZeYPtAKgyQq0iOmI97fJFvIPWZ
 aevd6ZJhl5OJPPOtB9JScbNUkaSRCi+zgjw=
X-Google-Smtp-Source: AGHT+IEQktbSavh5BkGVkbD6ZXILO8e7ks9o9XSVox1cUJW7W/Crwv1c/2sTxfniV3DSmp6GPq7qew==
X-Received: by 2002:a05:600c:5247:b0:439:4589:1a9f with SMTP id
 5b1f17b1804b1-4396e6ec028mr73935575e9.14.1739777513402; 
 Sun, 16 Feb 2025 23:31:53 -0800 (PST)
Received: from [192.168.1.121] ([176.167.144.216])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a1b8443sm144722165e9.35.2025.02.16.23.31.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Feb 2025 23:31:52 -0800 (PST)
Message-ID: <b13a02f2-c41f-4d51-8f60-5c97cd96c488@linaro.org>
Date: Mon, 17 Feb 2025 08:31:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/3] tpm/tpm_tis_spi: Support TPM for SPI (Serial
 Peripheral Interface)
To: dan tan <dantan@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, stefanb@linux.vnet.ibm.com, pbonzini@redhat.com,
 farosas@suse.de, lvivier@redhat.com, dantan@linux.ibm.com
References: <20250216221155.30013-1-dantan@linux.vnet.ibm.com>
 <20250216221155.30013-2-dantan@linux.vnet.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250216221155.30013-2-dantan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Hi,

On 16/2/25 23:11, dan tan wrote:
> Implement support for TPM via SPI interface. The SPI bus master
> is provided by PowerNV SPI device which is an SSI peripheral.
> It can uses the tpm_emulator driver backend with the external
> swtpm.
> 
> Signed-off-by: dan tan <dantan@linux.ibm.com>
> ---
> 
> v3:
> - moved variable tis_addr from TPMStateSPI struct to local
> - added the VM suspend/resume support:
>    - added vmstate_tpm_tis_spi declaration
>    - added tpm_tis_spi_pre_save() function
> - fixed trace formatting string
> 
> v4:
> - git commit amend only
> 
> v5:
> - removed DEFINE_PROP_UINT32("irq", TPMStateSPI, tpm_state.irq_num, 0)
>    from tpm_tis_spi_properties
> - In tpm.rst document, under section 'The QEMU TPM emulator device',
>    moved the 'PowerNV machine' section to immeidately below 'pSeriese
>    machine'.
> 
> v6:
> - amend commit description
> - amend hw/tpm/tpm_tis_spi.c prolog to reflect the generic nature
>    of the implementation
> - remove irrelevant define of IBM_PONQ
> - correct the function names to comply with the convention of
>    beginning with tpm_tis_spi_xxxx()
> 
> v7:
> - Reduce SPI wait states to improve performace.
>    Although the real SPI buses have four wait states to accomodate
>    the timing of various slave devices, there is no need to emulate
>    that for this behavior model.
> 
> v8:
> - re-package the email to comply with the convention.
> 
> v9:
> - conform with the latest device property definition after rebase
> 
> ---
>   docs/specs/tpm.rst   |  15 ++
>   include/system/tpm.h |   3 +
>   hw/tpm/tpm_tis_spi.c | 358 +++++++++++++++++++++++++++++++++++++++++++
>   hw/tpm/Kconfig       |   6 +
>   hw/tpm/meson.build   |   1 +
>   hw/tpm/trace-events  |   7 +
>   6 files changed, 390 insertions(+)
>   create mode 100644 hw/tpm/tpm_tis_spi.c


> diff --git a/hw/tpm/Kconfig b/hw/tpm/Kconfig
> index a46663288c..5951c225cc 100644
> --- a/hw/tpm/Kconfig
> +++ b/hw/tpm/Kconfig
> @@ -5,6 +5,12 @@ config TPM_TIS_I2C
>       select I2C
>       select TPM_TIS
>   
> +config TPM_TIS_SPI
> +    bool
> +    depends on TPM
> +    select TPM_BACKEND
> +    select TPM_TIS

        depends on SSI?

>   config TPM_TIS_ISA
>       bool
>       depends on TPM && ISA_BUS


