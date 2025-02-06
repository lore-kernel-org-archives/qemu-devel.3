Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBAFAC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 21:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg9tX-0001u8-TX; Thu, 06 Feb 2025 16:58:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tg9tU-0001sh-FA; Thu, 06 Feb 2025 16:58:44 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tg9tR-0005bs-LI; Thu, 06 Feb 2025 16:58:43 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43675b1155bso15581145e9.2; 
 Thu, 06 Feb 2025 13:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738879119; x=1739483919; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X2Skdp5mZeofOm3hGlZb3ZjlKwAN+fYGqXKmxjqSURU=;
 b=aFNSFDft+mM2K49Lbk/povlXgvUIdijxwzqeE7Tk2hrSt44u+FawOOfhUKxKVDY57F
 eRhmUSx+XxqtXZiUmpHj+CwjMRTL16f0tyn7y52ci/AXICt4cbisBG/TxAxRjZETHool
 EZdL2ECPsrDSj+a/cAydGjABejYd22HuEl9bGfqfhuBoHjpf+yai503ox1hRf15Wya4A
 WRcCA2tat7EpZDZMGCSD5Lc01+hf8+yrn7L3xIxxdkpjOPUrNJr4HVMdo7At08ExzTWM
 jAywZGyef9rGpJXwpr1APXKJkIJrmpGckSqdw2UhxrxedNLkK9T9mdVRXdct7afoyp8y
 FBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738879119; x=1739483919;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X2Skdp5mZeofOm3hGlZb3ZjlKwAN+fYGqXKmxjqSURU=;
 b=XVYxpn0SijntLIVZveMkViqU020/9ebstVUxEL0zWFnoImrZAcaBxpoCYD69WVMmdn
 SGqfY8mSUSK8RtUvUnobp1A12LaN8NpfuBFO2/rMU3hHupHWDRanbgM+3nqLE7nlm7ZF
 b7ipnt+nKyqIi4VsDSCMcbku3FIvGWdIxj+asd+aLv/8tL7CXcz+BfVwsUcni78gTMZc
 KFmJqQJT6kl4VKWoJHb0LuH93dNQaLdga9X0G3vs8NfQZ6okuTkL43GkayamiW4YZzqa
 EN2z5s4ZfrvCz00vXceGYWaPPFp5IwQpHdUBgphMCbhsFmpzgwAAzYhxZsI+PzyRpfsN
 TBHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXz0HmJIDa3y7COc3JvEPGBdcVw9e8+3LlApp5HrWPg/5TsqFv341IXodl3FNNKYqnnqT9wAM0oMA==@nongnu.org
X-Gm-Message-State: AOJu0Yx2Zimm7R8tXQTntS9nxiVmCVNB20KIhKg4IZGAB1OUl9lLbn5x
 Vg2EUyRXZyNfYx4Dq44Pbv4YWDbweEAUG8Tcv93A5zchMpwDO5da
X-Gm-Gg: ASbGnctclcvhw7Bgn53RU/L3sPu6iJXvGnVxKphLAGzH7BpRxe0iKkJGNim5KdPJLjh
 tGQONutMdIIcLdgl//KhA7iocBW8q7M+bUsvdJXEGwGCy5plmk90relD9OxhkA7tRuCQAF0uOOd
 V2bU9nIP513R+F1z6V8N8p+eBmFyo/Twv4DnslQFJTEZ1rgE37mXRTTJsD1EO5jOmqPLDfeCnWD
 tV5UjqypJdoTwN1CnAhtJqhxxG4XQwC/emRY9OGtH/HKt/hAYjUmkyiaaXm3KTyVKAxA/E5dmxD
 1J75Ld5g5ucHfkb4U76cLb7aBE7t9qaGU0WRAfMMpO+XL09AsqrSYseFdDaL/LbH2VpJX/6zr64
 =
X-Google-Smtp-Source: AGHT+IFHblDwg3I+uAEl2cOTrhdgEhqmeb8V4/12DC4tebtsOYxwbA60SsZVEfXyQ2dDMVWeJRuDUA==
X-Received: by 2002:a05:600c:3556:b0:434:f586:753c with SMTP id
 5b1f17b1804b1-43924988001mr9169945e9.7.1738879118631; 
 Thu, 06 Feb 2025 13:58:38 -0800 (PST)
Received: from ?IPv6:::1?
 (p200300faaf004300ecd7bea232a7e2ce.dip0.t-ipconnect.de.
 [2003:fa:af00:4300:ecd7:bea2:32a7:e2ce])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbdd55656sm2772248f8f.50.2025.02.06.13.58.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 13:58:38 -0800 (PST)
Date: Thu, 06 Feb 2025 21:58:36 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 18/18] hw/rtc: Add Ricoh RS5C372 RTC emulation
In-Reply-To: <CAFEAcA_gxGWivT7byZh9gYc2QHfsTqbJ8vtxPDToOxLMdMvwQg@mail.gmail.com>
References: <20250204092112.26957-1-shentey@gmail.com>
 <20250204092112.26957-19-shentey@gmail.com>
 <CAFEAcA_gxGWivT7byZh9gYc2QHfsTqbJ8vtxPDToOxLMdMvwQg@mail.gmail.com>
Message-ID: <F8650CD9-AA03-4462-A74E-7A068820F1A2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x333.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



Am 6=2E Februar 2025 17:32:31 UTC schrieb Peter Maydell <peter=2Emaydell@l=
inaro=2Eorg>:
>On Tue, 4 Feb 2025 at 09:21, Bernhard Beschow <shentey@gmail=2Ecom> wrote=
:
>>
>> The implementation just allows Linux to determine date and time=2E
>>
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>>  MAINTAINERS         |   1 +
>>  hw/rtc/rs5c372=2Ec    | 227 ++++++++++++++++++++++++++++++++++++++++++=
++
>>  hw/rtc/Kconfig      |   5 +
>>  hw/rtc/meson=2Ebuild  |   1 +
>>  hw/rtc/trace-events |   4 +
>>  5 files changed, 238 insertions(+)
>>  create mode 100644 hw/rtc/rs5c372=2Ec
>
>Should there be a patch after this one that adds this device
>to your board ?

As per Kconfig the board selects I2C_DEVICES and this device is "default y=
 if I2C_DEVICES"=2E I've deliberately not hardcoded this device to the boar=
d to make it emulate a plain i=2EMX 8M Plus SoC (see also board documentati=
on)=2E

Best regards,
Bernhard
=20
>
>thanks
>-- PMM

