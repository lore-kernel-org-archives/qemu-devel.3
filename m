Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82DA2C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 14:08:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYQXU-0008AA-9X; Thu, 16 Jan 2025 09:08:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1tYQXS-00089Z-HD
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 09:08:02 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1tYQXQ-0001lD-TP
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 09:08:02 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43618283d48so6126725e9.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 06:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737036479; x=1737641279; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=W5oqtnXen1TYkPVVp4JoSN4fm4pTzZF5cMBFL9515po=;
 b=ewLEfs6MPxw2jtAsW5mU4cPsRIuQ+7rmlw8bZmEae3vrp3pAJXnrpJqZSBTG42VsWh
 MAIwprXaAmzi3ViWkEBPv/C8TsotdRUs+mHCVy4ZmZvw+inqitURUNwsosha02pADPCe
 ek+tmoVwQESm6Ga1Jx/g2DRjrw6mc0bH4BRBKupmUrk6PMbEMKY/OeGhjoznWImlsLC5
 +OePqVFm9jMFb7ZVOmrXe7X4o3/o08PT3kzGA2Gg60Er5CsrO4C0Bq6vW9VaRRYY+4YP
 83AOiFeAXRZlv83e8ESkiUPldEsZGt+jZH1C1HpWXbFJkTjWQORWaGYrkBbz0+y7d978
 0ncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737036479; x=1737641279;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W5oqtnXen1TYkPVVp4JoSN4fm4pTzZF5cMBFL9515po=;
 b=VxiqPHY0eyYW2dFKglexOrMtvzYeOh4NIAqOPyHCX/dN7GURYqYq4ZY2gAIC8S1fpY
 +mf4UVSPcIPXBzQoDR089QboeUr9BseV5OBDAQJDflmiY9gdxd82sPfAPgm8zruuNiB2
 9uENmxidSXaZVnk5NnFCR/UFmR73HgY+pzWgFYSwL1/6G3thqZbxpPkso20G5e7AFKMf
 kgo/zwO2LIpUOsuK+mz3KOB+pX/XL95R/oNDcYe64Dmu4QRGibvcex10HUgPegT81H0Y
 lbjDf/bE0vhtV6SXgcSqqHsTQ3YG6wN0DdF2YRbn9z4/kdTInZ4BkmCl5vlt1BB8lyUJ
 VSUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7J4NQg8h9pU9wHC/tYMByEaTFz2XRYuopvDWFepFMnZwDI5qS05sihjnB9m3uJnf0iwBYk87Fcm7Q@nongnu.org
X-Gm-Message-State: AOJu0YzStbLgyzvJDZciammK+9bGvK5fgGO0iQUULOt453R5FR81ePCV
 o0RO9oGbXSPaG7q+AZ5+cjcWBiPw3F86kKBq5HbTNPEjdDtiHEZ/
X-Gm-Gg: ASbGncvvkrfRHUI67iNuDYeB9oqpJhkyDTbM27bMkhcQT7zaMB/cxIOXcIzZO3/T9eB
 Sn8nkw5YwSJqEJIrF8Q3pstox+ZnRL46V16vkYeW8oV/25vfw6HNFwXUOxSFlMHy/pO+HkNaxkF
 r2UnAnfWuZ1sW53Ooo3d/s23Xpokvpkv7O1EdmPLyJ5UcFMtCP+TT1JGg08lpl6c7V/Kpf31tRo
 mTHajq2o7ZyBSdV+pFeUi7W68/Yc5CHWOCFPurA1AB2sBVsmBsL+taG4Kxh
X-Google-Smtp-Source: AGHT+IEU4GT3UwX8VT8Oq6BbxcNMCbdlRZztxUi9aCfrxjGoxolTnvmO2GHI7vcYjXosXu2K4PXzJQ==
X-Received: by 2002:a05:6000:1a85:b0:385:e0d6:fb48 with SMTP id
 ffacd0b85a97d-38a872f6f22mr27114760f8f.7.1737036476985; 
 Thu, 16 Jan 2025 06:07:56 -0800 (PST)
Received: from [192.168.16.41] ([54.239.6.184])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c7499884sm62196055e9.5.2025.01.16.06.07.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 06:07:56 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <b486bc8d-af20-46f3-b6f5-b32cc0a54fa5@xen.org>
Date: Thu, 16 Jan 2025 15:07:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] linux-headers: Update to Linux 6.13-rc7
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Cornelia Huck <cohuck@redhat.com>,
 Peter Hilber <quic_philber@quicinc.com>,
 "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>,
 David Woodhouse <dwmw@amazon.co.uk>
References: <20250116140315.2455143-1-dwmw2@infradead.org>
 <20250116140315.2455143-3-dwmw2@infradead.org>
Content-Language: en-US
Organization: Xen Project
In-Reply-To: <20250116140315.2455143-3-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Reply-To: paul@xen.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 16/01/2025 14:59, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   include/standard-headers/linux/vmclock-abi.h | 182 +++++++++++++++++++
>   linux-headers/linux/iommufd.h                |  31 ++--
>   linux-headers/linux/stddef.h                 |  13 +-
>   3 files changed, 212 insertions(+), 14 deletions(-)
>   create mode 100644 include/standard-headers/linux/vmclock-abi.h
> 

No functional change?

