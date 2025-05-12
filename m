Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CFBEC3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 14:16:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uETwt-00084S-2C; Mon, 12 May 2025 10:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uETwm-00083F-TU
 for qemu-devel@nongnu.org; Mon, 12 May 2025 10:16:03 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uETwj-0005cI-Ks
 for qemu-devel@nongnu.org; Mon, 12 May 2025 10:15:59 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43cfebc343dso30315115e9.2
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 07:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747059354; x=1747664154; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aTAGveobMVXL/UqyzsFhZ1pybaTAQ1fC0YSWIiTwOb4=;
 b=ellKcAYJhidG9ZpphaOFEd0JSaKYDHC6Fe+rNHnx6FkGBsFTpaLlvle2HcQdD30Sna
 P098t3QkrTPaOBGu3jobd/gdVCVzAVQFK4mHVugR/NwAFcAo7Rycim4xbj/b/ThUSgXW
 InECpn6k7noYXNxjjiXEvonZsh94vt6N+S0Q7W7ECmFn6LDqbGW2cPG+PYKyvsmMwHV+
 8S+L9cd/YxpVSa2CwoPOPuX6nbjmMhiNArf2cRkzCWQww+iDI7MmCeL6sQ6nbXXFEo9+
 KoMVLADG8hBy137mKZ/uAkos2wyVT6qwUeN7K0C9MW/t6z3D5WBO6KQm8T/js36QEUpX
 PZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747059354; x=1747664154;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aTAGveobMVXL/UqyzsFhZ1pybaTAQ1fC0YSWIiTwOb4=;
 b=XkcsDsZqfrTpIkDJZgtLJWiBK8tMfrLwqA0ImoxNLuLlOptvNKGoq1HVPg1Nl0zNYC
 +qToh0CaDxFEokzKnA6+xIpE0qO+6rkNiiZtmc0Ero2lP8YAQxlz2lyIhekFkvmpWL2K
 FfnxpGSUnyDKuZBg5ylXY6SEu8swnyLursoGRtrJhzpDRfzJxsoY4mjEsY9Y6X2QJipB
 aPphoM4/BK9J10/zoRt/D7DJU4ZbpfvSXM7+OLa0pX9zfHaHDfPXQ96PKKFG7T1X4KVq
 vsxoqxgv4vKem+RZ6PVxih94D3Mls+7ld9Y+/LR9Z7YYynBMLBnJqG3XXKD3yQ8iIoyF
 SO5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXye/Bq//csBDYJeGSV09OdkSzKrH3xqt99uO3Aoqz2IFrNHbkXqqtQP+PpJq/edCEd8D39hH5UBAPR@nongnu.org
X-Gm-Message-State: AOJu0Yy7qSVFuKdtR9KpcnI1xcPu6JOmoko5oRSqFjT5Gt5u6Hjs8RK4
 uVObIjzTT0aMPGbaV1YPvA+oeXgQce3ioBJiB6uTS78CCrJVwtrXo0MVZuxRzY4=
X-Gm-Gg: ASbGncu4stXcXRm2SMzm6Hm8gUPemWKH5Brh8XKO15T6P124gIeNKHAX6HVToAjE+5s
 6cbJ8tp8h5jMSVRW7E6tann5UQdN1QV003Jm4mEiivreLDOFcQEU/5yweSFiOpkB9eY2CiyDCpN
 24UggHiLo9Quu+CaejUcyNv6qqdj+ZGtvQoLvnV4nZxnWDOB/cteAvevgXzJJ3uke9XhMTMYQZ+
 7ArzJ0JPzuTrj+KGQvbTG0qtLRC4mSSlKeYqYTsKfCp4GnX1CnDuqfGvLOzQbwUke1XDYgxHv7o
 fmYzQvNJIWBkScYm7hNNbBMKC7mOkFIkfjiINvYYCTgu1FsFl3OhQ6eE/+VnXbOCP/dZFfrl+nN
 R2vbn9nghbFTsMlYzGjjnu0hcopLF
X-Google-Smtp-Source: AGHT+IHLD+KR4eQadi3Gx4ZKSctbLcnOfa7f1NEAB/FxoDfcH+1qT9P3NQQULJv+WfRW14vaCSaNDA==
X-Received: by 2002:a05:600c:528e:b0:43d:7413:cb3e with SMTP id
 5b1f17b1804b1-442d6d17f7cmr97859585e9.1.1747059353924; 
 Mon, 12 May 2025 07:15:53 -0700 (PDT)
Received: from [172.19.170.213] (90.red-88-28-30.dynamicip.rima-tde.net.
 [88.28.30.90]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442d67d5c2asm127762345e9.1.2025.05.12.07.15.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 May 2025 07:15:53 -0700 (PDT)
Message-ID: <3b7f61dc-8708-459c-b48b-db955ad462bf@linaro.org>
Date: Mon, 12 May 2025 16:15:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/functional: Add PCI hotplug test for aarch64
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 thuth@redhat.com
Cc: eric.auger@redhat.com, alex.bennee@linaro.org, peter.maydell@linaro.org
References: <20250512123646.157447-1-gustavo.romero@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250512123646.157447-1-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 12/5/25 14:36, Gustavo Romero wrote:
> Add a functional test, aarch64_hotplug_pci, to exercise PCI hotplug and
> hot-unplug on arm64. Currently, the aarch64 'virt' machine uses the PCIe
> native controller and does not support ACPI-based hotplugging. However,
> since support is planned, this test sets 'acpi=force' and specifies an
> EDK2 firmware image in advance. This is harmless and prepares for future
> ACPI support.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>   MAINTAINERS                                  |  5 ++
>   tests/functional/meson.build                 |  1 +
>   tests/functional/test_aarch64_hotplug_pci.py | 73 ++++++++++++++++++++
>   3 files changed, 79 insertions(+)
>   create mode 100755 tests/functional/test_aarch64_hotplug_pci.py
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 23174b4ca7..9ebb768214 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2065,6 +2065,11 @@ S: Supported
>   F: include/hw/pci/pcie_doe.h
>   F: hw/pci/pcie_doe.c
>   
> +ARM PCI Hotplug
> +M: Gustavo Romero <gustavo.romero@linaro.org>

Cc: qemu-arm@?

> +S: Supported
> +F: tests/functional/test_aarch64_hotplug_pci.py
> +
>   ACPI/SMBIOS
>   M: Michael S. Tsirkin <mst@redhat.com>
>   M: Igor Mammedov <imammedo@redhat.com>

