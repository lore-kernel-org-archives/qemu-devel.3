Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24ED0C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 15:12:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNCGE-0006A2-O9; Thu, 05 Jun 2025 11:12:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNCGD-00069p-F4
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 11:12:05 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNCGB-0005lA-MV
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 11:12:05 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-442e9c00bf4so9136345e9.3
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 08:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749136320; x=1749741120; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F4lmBOAJUItt5Td82VTXkL9s4PzaCBN/XfnajooWilQ=;
 b=oplzH6SL42hv6Q59SCPMCSKK+UDMIjjbIy3REBnK2Q4+qlAPvjremNBVwXKLc8zHqI
 OABNezV0LqV2KGeJ7bwBLC7WNTV7Fs+SKpyRI7LVvF0g5FMCgG+WBm/aUY3gcnNoiPzV
 if+tr7DNcwbO4yD+EiAxoiq6Rt30dC1Vy0HEIF8C83nN8iGtP5h0d+cV/p7slXVK2Cmx
 rWPsUqGvArSQOsDdCqh8gjYnVXzWjLgv5jHP45YkjTUp97xThj9WoQnD7jZvfeg12Cyx
 8H11/+/6aEhLrTmtbpQ1fxTQ6xvDJGgeLd9hk3SCv0mzT6Of1gT+n9l0mHpHmvCTRXDC
 8xbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749136320; x=1749741120;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F4lmBOAJUItt5Td82VTXkL9s4PzaCBN/XfnajooWilQ=;
 b=g8LaWCS0D1HZfKjMORU+QEwlxZ6IJfHW9KpFPcO7KQdLrDEr+Y/QrWTZs5PZE/Sbj7
 VBh44XvdQAEUO4u+JEwuyEAaLlmoAKUR5yVR8kt5DxLG6Qaf+DT1jtk6HOS2Z80/pyVN
 sNizpd6CtpAFsPtbUp622xtn0sy2odW4UcBafJxz87OXf+2bbdKnp5sltPE9O2aMqc73
 xc3Pw/7Gu15oI6aX07iLSrzDrPmn4snFI4S07PFfOotLX3RiT54hiLrWt30i+Stjpyko
 y78NOOnYIVCOyjJPt3q+F3z2gjIMgbFtBYkI4EpIHKXyWI8XmDKJJYeHq6tBpZSMFXXG
 kzfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVa5HgTfqYwRzIQhWouOB7NBAP9jr+KPiNQhDaU3TkBOVmEAoZc1hFLrBTkD4EaVIF9Df/ymy3ezjrz@nongnu.org
X-Gm-Message-State: AOJu0YwIS2GtnJWOoti0y7MHploiRzjNJJy+OR//Whzom3w/JdwxBKoY
 6o9cmJ4FlTRGqb1OY6AKPrQKu9cD7t8oQl5K416s5iW2fnSE+aa3lnLpxrvrIKz8TSg=
X-Gm-Gg: ASbGncvDje43b47PF5ynyFlDYIdJzkQ6+xl5jVw+XiFk87p92RaDn5aQW6LiYEIdKqv
 43+7jZI/XvTujl6lZx0fHiO05Xr8dqONAVP6pMSkn+6W+Z2gdglgjVlWg7cDYXz6+fSWmKw3HgG
 NMX6SnLyotdJZoLWE7psczWLO7dIThLcSJmB3cfLOn8vuZI/rwydRMROQCrPOhnm75f/W74uMP3
 ks4Eq4T0b17Y5ck4gKxEx2qMPUbdf5hmMdBEuuS0DEpPc8wocVjr2R4pgPV11KiCasPjkWmH4fi
 ZvmgZO+32gqdzJ1kCZ0wujdmA+mEVZ7H+DHQ3zmZEfuXh9r7TvkBsEGgUJ6QHuNGXyuzHtgjz0w
 s+b2oaUTxD9xRGJpxrGc=
X-Google-Smtp-Source: AGHT+IEOOjbZWGAPQ4+Vu1Dig2UTFqsbatfkOXxP5HbXc0dJGCCYMi+FLk4G6krvewF/9nbIz85oPQ==
X-Received: by 2002:a05:600c:5403:b0:43d:b3:fb1 with SMTP id
 5b1f17b1804b1-451f0b2879emr68369245e9.27.1749136320232; 
 Thu, 05 Jun 2025 08:12:00 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-451fb2082cesm21310265e9.19.2025.06.05.08.11.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Jun 2025 08:11:59 -0700 (PDT)
Message-ID: <68f4f244-db07-4f65-9ca5-3cb9b70c9e61@linaro.org>
Date: Thu, 5 Jun 2025 17:11:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ramfb: Add property to control if load the romfile
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Shaoqin Huang <shahuang@redhat.com>, qemu-arm@nongnu.org,
 Eric Auger <eauger@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
References: <20250605030351.2056571-1-shahuang@redhat.com>
 <746b078e-bd06-4361-aec7-2301412abb18@linaro.org>
 <kep5frpl24d74evoyf367pqkyoj6xez2pirk7xlzcoompyzq4c@ouxab77sdm55>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <kep5frpl24d74evoyf367pqkyoj6xez2pirk7xlzcoompyzq4c@ouxab77sdm55>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 5/6/25 14:21, Gerd Hoffmann wrote:
>    Hi,
> 
>>> Now the ramfb will load the vgabios-ramfb.bin unconditionally, but only
>>> the x86 need the vgabios-ramfb.bin, this can cause that when use the
>>> release package on arm64 it can't find the vgabios-ramfb.bin.
> 
>> Simpler to directly pass the ROM path instead of using a boolean,
>> so board (or CLI) could pass path to non-x86 rom.
> 
> The rom is loaded into a fw_cfg file which only seabios will look at.
> So this rom logic is x86-specific.
> 
> edk2 ships an EFI driver for ramfb, that is how ramfb is used on !x86
> platforms today, and I don't expect that to change.
> 
> IMHO a bool is perfectly fine here, I don't think we will ever need the
> flexibility to specify some other rom here.

Understood, better then! Maybe name the boolean "use_legacy_x86_rom" and
add a comment explaining EFI driver is expected on !x86?

Regards,

Phil.

