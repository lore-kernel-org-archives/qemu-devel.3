Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B5D2CFD376
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 12:59:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOy46-0003OE-08; Fri, 28 Nov 2025 07:59:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOy42-0003N1-JA
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 07:59:06 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOy40-0005Wr-8T
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 07:59:05 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-429ce7e79f8so1222823f8f.0
 for <qemu-devel@nongnu.org>; Fri, 28 Nov 2025 04:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764334743; x=1764939543; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MuTKezzHjxSk7oohEchM/aHVnU6HmHyLwzueORdHAeU=;
 b=c8NFklQplyUNMu8epmLSpQeUxLcqm5WB8FCBB0S5qjrPyZc6aCnfBhBY6CW67vl9t0
 dHKlkrLHq0Wp3YRgmzk8e6+isfOgw9sM+i/MqBQBP+vHvpN7gXivUIUp9MwaZRdMe/QU
 4ZAvkD+JqthG69KzKPW9WhWX7GXmfe/MUKLRjQhLiMze692FmP8kl8IlC+t1CepAssyq
 5mAvC8bjRr/Wao6KZQjchfDJ9af8FmJlIAbh9QLEi9CY7CKoCWQHxUeMsfU4F9cJ83iA
 +wBfh+KMbZAjcxiBcOm1icQwBxxzM/Rt3rprB93NwGPIWK2e/TSZfMk7g5Fbkwybz4JP
 h7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764334743; x=1764939543;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MuTKezzHjxSk7oohEchM/aHVnU6HmHyLwzueORdHAeU=;
 b=oWRx2NSayO4it95MCftJLg/BQ9kM9fdaf/PqlcCzj68+FQUG0upvwEj1+wolJRprlZ
 KEfBUbdexFjFul1n9mAXcctNWBt1d445YbOfEMpp5LJsD3J41LeyDZAbO/gWmITd2DOf
 Zzfcm5fHAPou4KSBCiGTxO+BrvBAuH5Fdk2bwITYM9Fs+LiLaikvOP9Rh/GJl1abi+ab
 jyVN+C8VI8A5keM44q0+QXcqVFi0d/oxmSkQrxMQIIaP0Vn5TRuSDiPkLvAslrkTgQWG
 Cb1SCrTImNBdJryjeL1zwvMlAygiMD1fDzvfCLwLldReTt0TGDMnKirli88WDn7IASBc
 RnjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsk3fh31X/2caNXTZCPF462kb0/9wuJhRRtip3E8kr6mYur79okUgHrSNUqHRuwvJgPBEi/hvVonWt@nongnu.org
X-Gm-Message-State: AOJu0YzRUrKDdBDefLN6LYlroZOzaLMLJRORTfsBqz6Ilap+89NF/Bxf
 duVduFJLtUR/oCaR8rnc0CiY6pnyaNetjtzFylpFFBxoRDVhAtI0kwlyfxzVtPtUDPhL2CyV2XT
 ImJOViSGklg==
X-Gm-Gg: ASbGncvKYxzl9FbdYZPGbTuU+gVXLT0+4bVSk6NpP9LRql3Lch8HzDMQgeQF9NsYnnR
 gGl1Dx+BAbR2wSrFQ2z/a2jh+GoVJZAKpSf7rzagUjY8EV06dQR+DnJ8EgajtZTQFVrDow6XI8h
 Lr0OH5YM0cTV0LahpOpukHPxDcm7EF+nfMjjIOcNBMJXpKl+dcIAoPk8mqvZnJob9U2M49F7JRt
 hBiHEbfKaytwLrWD2VFrXTkEItYxGx5S9sC8wuI4G3Fu7PcT+7uWnRw0/YPYFOmtcphpJPpd5aY
 mmMS2GNrttnDgfBivTyoI2s/iXTaGewKqhoageIaXG10RyP7gu1WjN9T8VHyF9G1U7dvTi13n0Y
 O7BRtyPW5N3vvLTk0MRYHVYTBi8NIfoMTEqBYCjjoaqisu4qTy7V//e7TZPEK6D90DV0Bf0PUKV
 lj1P2WC8BGQrON9MjRBwTcYr1/teV2nPT67JwVN+cgej5eiHp3RqfpNg==
X-Google-Smtp-Source: AGHT+IEPInx34OZ8jBuX7Of8Wmk8bMqjxciu8Zxd18D1XH8COkQv0TBO0ssMNCgcZlRLvHLEntcmiA==
X-Received: by 2002:a05:6000:1789:b0:42b:3ccc:91ec with SMTP id
 ffacd0b85a97d-42e0f2047b3mr15370113f8f.22.1764334742644; 
 Fri, 28 Nov 2025 04:59:02 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1c5c3c8csm11918426f8f.2.2025.11.28.04.59.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Nov 2025 04:59:01 -0800 (PST)
Message-ID: <a2567dda-9484-44ea-94f5-7bc6d969ae57@linaro.org>
Date: Fri, 28 Nov 2025 13:59:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] edk2: drop 32-bit build config (ia32 and arm),
 update aarch64 vars
Content-Language: en-US
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
References: <20251128084524.363989-1-kraxel@redhat.com>
 <20251128084524.363989-5-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251128084524.363989-5-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 28/11/25 09:45, Gerd Hoffmann wrote:
> Upstream edk2 has dropped support for 32-bit architectures.  Remove the
> build config for these builds, update aarch64 (which used to share the
> 'vars' image with arm).
> 
> Drop references to the 32-bit builds in a number of places.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   tests/qtest/bios-tables-test.c               | 28 ++++++-------
>   pc-bios/descriptors/50-edk2-i386-secure.json | 34 ---------------
>   pc-bios/descriptors/60-edk2-aarch64.json     |  2 +-
>   pc-bios/descriptors/60-edk2-arm.json         | 31 --------------
>   pc-bios/descriptors/60-edk2-i386.json        | 33 ---------------
>   pc-bios/descriptors/meson.build              |  3 --
>   pc-bios/meson.build                          |  6 +--
>   roms/edk2-build.config                       | 44 ++------------------
>   8 files changed, 19 insertions(+), 162 deletions(-)
>   delete mode 100644 pc-bios/descriptors/50-edk2-i386-secure.json
>   delete mode 100644 pc-bios/descriptors/60-edk2-arm.json
>   delete mode 100644 pc-bios/descriptors/60-edk2-i386.json

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


