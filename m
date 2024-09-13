Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF93BFC6168
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 17:06:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp9k3-0008FQ-9b; Fri, 13 Sep 2024 13:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sp9k0-00084g-BN
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 13:05:52 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sp9jy-0003kY-Hx
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 13:05:52 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42cbbb1727eso20972495e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 10:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726247149; x=1726851949; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZpsDIYEnfIOF+W4l33ca+KCHs1krhgQaGqeZFMe9FFc=;
 b=VHAKxgD/CszEnSV1YRR5mXIfsgGXJo1n+O8tsrD6nygEGFAy7RVRKw7rawLAtRaVp1
 1QTCEostEPXMmIxK4cxgVL2JFxwrTiJBivCYDgkL1igz9Ksg+UgGshr2rqmustD2Hqr0
 YR4tKy6WiJqKf3GODMpVPo5dN6RopRH5gD8YUMc4k8/PPm1n7i0lF4GfrSeHeJzDOknA
 z+PaqyKdbfgYM+f+/2VOgeMdlRX4PfEPB/FZWUZQAazLpeBN0Mx/j3O1jOVikE5UZrHP
 HqtoMKeV0B7sJMaENdblm4iqA4VCT33hbt8FUjuPvZ7hFmXExOtPe27koczzSuQQX5WU
 asnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726247149; x=1726851949;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZpsDIYEnfIOF+W4l33ca+KCHs1krhgQaGqeZFMe9FFc=;
 b=fiQGCKqwNhNEwuQyduar9bfbwm1nr/LjzTnCtmyvQj1zxd6OZU9geUCiTLuI3WG4Qi
 UbB1BrJ5PYdwajmij0oblshyIJqYcYZT0Yh2yNScWyJe6x4dUyA2HDAWLdo7S3AK+LAD
 VD3vK+/LE7HMAf2qxAex1BZ+2TIF0vT5jo36x260kARHV/mA7DWbSnWwy2IXXTlvJzhN
 E4EILTSBvEGhUyWXvxVhjQ5q+9ut8+I3NrxgcCYY2lgEM6sm7kPsuiyf000me0tQDmDz
 1jbaRQEY302GOor/ZNd5JAVPpN0lRI9uMtg2V+bV3pFCscY+oJZnT0LayNmqKjbzoWfu
 p3Aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX03hZbiaf6U9cBlBcBIz0Awtw1Pep7Z6UyYUv5CNfKis9QZb5j8yRzI++WAPg/yGmJrXwToB9VsyAw@nongnu.org
X-Gm-Message-State: AOJu0YxkLZdLbNkaYKrXwyyLv8iUggA/P0rxZR85io9VdNQcjEKhpETI
 fiR5QF+pbaY9T6ThcIPjoCqUWTidZUPGbD//WVDYgYsSVxqgfZGxXxF+1OdjtA4=
X-Google-Smtp-Source: AGHT+IGN27cl6FKZCT4fAQXsPqS2xUgpnmqkwBuCZWdCVKwCuY2gFDXG87WHN0yOxwx3LZBgd0zBVw==
X-Received: by 2002:a05:600c:4695:b0:42c:b750:19d8 with SMTP id
 5b1f17b1804b1-42cdb531cd5mr50425315e9.4.1726247148572; 
 Fri, 13 Sep 2024 10:05:48 -0700 (PDT)
Received: from [192.168.69.100] (uni14-h01-176-184-39-243.dsl.sta.abo.bbox.fr.
 [176.184.39.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956d365fsm17505055f8f.82.2024.09.13.10.05.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Sep 2024 10:05:48 -0700 (PDT)
Message-ID: <742f3b2c-d927-4105-a194-ac7bab415fb9@linaro.org>
Date: Fri, 13 Sep 2024 19:05:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/pci-bridge: Add a Kconfig switch for the normal PCI
 bridge
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 qemu-s390x@nongnu.org
References: <20240913144844.427899-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240913144844.427899-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 13/9/24 16:48, Thomas Huth wrote:
> The pci-bridge device is not usable on s390x, so introduce a Kconfig
> switch that allows to disable it.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/pci-bridge/Kconfig     | 5 +++++
>   hw/pci-bridge/meson.build | 2 +-
>   2 files changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


