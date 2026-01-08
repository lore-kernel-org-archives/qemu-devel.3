Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F9F3D185D5
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 10:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdniu-0003rq-2K; Thu, 08 Jan 2026 05:58:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdnin-0003kq-QG
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 05:58:29 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdnil-0007oq-JZ
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 05:58:28 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-43277900fb4so789772f8f.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 02:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767869906; x=1768474706; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=43m4t4DwfMUg2vdVTMu9rnuHYQKnOxaB4pb7pw//f6g=;
 b=jMNDvEz+o+RIBgy//mXEhixlB6g/12xNXOHU5xsI6PDrEc2CkCvbcXbeW4HqDmmrFJ
 XBCB48W0lkRxoCcRVgi8V7QpvRlBd1cgpnxgLzFWb2hDoi1K23TGyrXY2qquFEUS2n3a
 mgrkmmLE+YGRNmDRBK67InB2UV9LLAxinEGr+Ci+jrVXjP97xc1Fy7QBiDEngkJBZIUl
 PPFw4C2vZphWPRpIvoRdRlvusGREwiPkMtv/LACfdIAh+W0Q3l0hbi4Kg0/vWMgA4IoZ
 J/h00KEbcoPLF/89r6pd20BANWqXDcB6mSwygKeY05gZHufsunQEVscuEBN5HZNTckr3
 6Afw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767869906; x=1768474706;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=43m4t4DwfMUg2vdVTMu9rnuHYQKnOxaB4pb7pw//f6g=;
 b=WpvUGWGiodAGrmueZCq6RDlIHm9xdRKAa87R4SQ3e08tJl/qxKEdJay4Ye9uyRZ8qo
 nnNPbl7LIWn5MbBN7mV9dRf5gDrncSEH+bmKBUOktMuewlznv0d721iSeQirtWQE8coR
 Lnot6FjSFm3KKTXz12Y3wUhqRTuJJVEkpoS7Dr293PYt1VwaJgzBnn2Ui1AMZgZ6ExjE
 W078VqauWn1nfzWBPpNG/vbVEmph7IAAm3PipO4VZgRJd0ki0jEiXb6IshmV9vem+054
 gYYmAb8YTNqLdpsLi4VsTelioSUemPrp9ZTL+aKWXmbnMISRGdpPyfxZ7n5ZLrsY2eaD
 qHXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUldLDZ40JG1j2PUHkomq4MuQQyQjZ+UbowgRwwItgarasGEzf/JWqZ3LG7xI5Qg09pfIlbf4nBDImz@nongnu.org
X-Gm-Message-State: AOJu0YxX4criHMp8kmlWPoApZulf4iZYBh/4K43nMF5/xz6Ut09EyxsH
 +BpfWuBQVORAng911daQMdKXt5RizA/2+aylaFRp7XbDS3lgQkZl44HonsDl78fBdVIHSCRExko
 cvj+UR5w=
X-Gm-Gg: AY/fxX6x3ZqsAP+bI7wooKQHpz+vtvWcfjTZ6/eqCS1/vZtGCX6IFoEQ5SJIzdGdGV+
 rGf/Sn/6WgtBnZwib9YuCQQeSBe0TPaYq7SXK+BSNtj7sBkhUZRBiMXYTJNV3TdgYiVboPXLsNv
 D5tCvYWAmyS79T9rWMYgvMyA1KQXO+RluzYfJNf44Ykq7MgtbKdDsGfhzd5ZD27Rabri0Bzk+uz
 yJ6HHrfEvnvfIQLM8dOnmkZu/DprAdFb1ceEmdRYshi4jKzVmRMJbEz6cBK5JeOEpCLhPAP+FTR
 QQx/RPKrnM85ldXRMCbMx/aWbwyZgozwT2nbu403rKScERofwzbOikHeKT23AcUc2OUptHL3qxE
 X947O1TjtN7m9xfmo35z8KE5SX2uT/Ws+sYDhPR6D6XoYcqdhAcBnM0T/oypYUQWadZEBG+V4xB
 6vUX/frf/2HZFy+/j1d1eDIHbteryWxomqJ9NCa6sQ694FanFSAHcg2w==
X-Google-Smtp-Source: AGHT+IGRKPGXRJ4a3xcHbzOBCybX/eivKYl/EjOBa5tswpa8ZOR8SJNfkpPcVmHMX8QQtBYw+NWElA==
X-Received: by 2002:a05:6000:1ac8:b0:432:88c4:e180 with SMTP id
 ffacd0b85a97d-432bcfd3d4bmr13124697f8f.15.1767869906061; 
 Thu, 08 Jan 2026 02:58:26 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df8besm15062550f8f.26.2026.01.08.02.58.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 02:58:25 -0800 (PST)
Message-ID: <52ebe0e9-338f-4b96-9a26-6dda66db8f41@linaro.org>
Date: Thu, 8 Jan 2026 11:58:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/50] tcg/x86_64: Rename from i386
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-12-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260108053018.626690-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 8/1/26 06:29, Richard Henderson wrote:
> Emphasize that we're generating 64-bit code.
> Drop the explicit rename from meson's cpu.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/{i386 => x86_64}/tcg-target-con-set.h  | 0
>   tcg/{i386 => x86_64}/tcg-target-con-str.h  | 0
>   tcg/{i386 => x86_64}/tcg-target-has.h      | 0
>   tcg/{i386 => x86_64}/tcg-target-mo.h       | 0
>   tcg/{i386 => x86_64}/tcg-target-reg-bits.h | 0
>   tcg/{i386 => x86_64}/tcg-target.h          | 0
>   MAINTAINERS                                | 4 ++--
>   meson.build                                | 2 --
>   tcg/{i386 => x86_64}/tcg-target-opc.h.inc  | 0
>   tcg/{i386 => x86_64}/tcg-target.c.inc      | 0
>   10 files changed, 2 insertions(+), 4 deletions(-)
>   rename tcg/{i386 => x86_64}/tcg-target-con-set.h (100%)
>   rename tcg/{i386 => x86_64}/tcg-target-con-str.h (100%)
>   rename tcg/{i386 => x86_64}/tcg-target-has.h (100%)
>   rename tcg/{i386 => x86_64}/tcg-target-mo.h (100%)
>   rename tcg/{i386 => x86_64}/tcg-target-reg-bits.h (100%)
>   rename tcg/{i386 => x86_64}/tcg-target.h (100%)
>   rename tcg/{i386 => x86_64}/tcg-target-opc.h.inc (100%)
>   rename tcg/{i386 => x86_64}/tcg-target.c.inc (100%)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


