Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDEBBC36010
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 19:48:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2EvX-0004rr-Et; Tue, 08 Apr 2025 15:48:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1u2EvS-0004rA-4E
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 15:48:02 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1u2EvL-0002NE-TQ
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 15:47:58 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5e5e1a38c1aso8030224a12.2
 for <qemu-devel@nongnu.org>; Tue, 08 Apr 2025 12:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744141674; x=1744746474; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cl3hCnb/MBdDHoNMjn8hPamL6iM+3kaXVMFRX39xnJI=;
 b=XtQmt0TrtQooqJG3b9qWe21AwehXZUiEn8qOE0WJDKZumrb3DZb8Uj3RxFJHenb++a
 B+LA07z0yJDJp70k684W/7ilNY9GZsAeX59/7PJJOkI1dHWQ4bEggQjMGy7a7RftmquO
 jARduhrvlpS9lxg6EERzjv5HDmX+2NqH+sQ8ofZohZlabLy0ME2yu6jUhW1EPLVmMI1z
 dUKKap7IubbN3Dm4uuTbpfrRkGjZKNQigmesJahKMNtz9kSnTUcQr+VLW5HGUZOyvH1f
 V+FelLdpALm0smhBKxZmy9haUk71l5SYe9C6H01+3T/ApvEtppVgtOJUYC7srdzIcpqg
 dt9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744141674; x=1744746474;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cl3hCnb/MBdDHoNMjn8hPamL6iM+3kaXVMFRX39xnJI=;
 b=nQMFreILEhgy/HN/aJ0lNxVDRMdphl6DzPsVmX/jkmZIWwrdZyHrqlG9S1E3ehY42H
 IbXpleY70kV/6zrRtq4v6mL3gdc+7sAAb4k8MyZ2qhZJnrx0Js0CDYiW+UCnL457xiqc
 lcZvZ2du5XOegd/8BkMydc49cgRlvTjN5lmtEq6SJtt4P+d7O2/DT4ymTN94ixGB94DG
 gGFA2FpNAks5Vq7hWzvKtMmGbpQdHQ3Ns0ykQsJZXmWaforIr1KpXu2qaWH7af505NKk
 2LvgnipgsZIhGJVJ1dKg/Vs82vTNlvcjqEzKhANOpKvJcBvvwRwjPU8yaWdjqDSTn2Fj
 EJ7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCViDKVBypoOlnZ1Ge8fX70OpD6/f2i/CrFpyGSMXp5J5yKqPO637bzH+DkOrITN0tXr2KPRsBErSr1F@nongnu.org
X-Gm-Message-State: AOJu0YyLu4b1kVXz8JPt6T0UOtxtd0ZlHH8V1nsOPmvpO23o7Pd+fb/v
 E0wIFiSSY8iJHWrNZQkonLXqVm5Bu1Ka68seuxgbvVYNDyFoFOth
X-Gm-Gg: ASbGncszDvh8gk+0DoYKUl1U+2uxEcSs9LOzABjBjfLDV5W4Onq4FqSm+NY2xn+e552
 yFVfYFGhGSBKPSqjOwr9aubAu56oRytqvqY5bnBOaXQ27EKvYbr+tLGeNRFsKaM+GaRZM2c7zRs
 nbprT1Pk0BiF6kvtOqo6NEGdbGOqt8JxTOgJPNFAgvu7juUdnaiXiavx9ZUbzlNzjW/WE45jmDl
 xj+35l7wjkQ476lX54aTzbe/JBXjVOZ9DZqgDNR3nAAqdgLdY7NbTkpnIokO0bHuroJ3XlZ5WQ4
 zxvZlv9L0KzGVUfmJRcXJr7SfYsxJaENlnFS+iQ0Ni/zUhufGlO0QwXeei3+0dSg1RzIIY9gSc9
 mxMF9HJ4P3tK9lFztEItEW6HxhYnCkEfVcFUUb/WmaYq8gNnMKPgn
X-Google-Smtp-Source: AGHT+IF14tyBStCeERY8VSgkrxzGdAieOQKmS6Tv87cRcF2CixZg6BCcAeRKD84zrnCL5sj5T9mBHg==
X-Received: by 2002:a05:6402:2746:b0:5e4:92ca:34d0 with SMTP id
 4fb4d7f45d1cf-5f2f76e4f84mr216581a12.20.1744141673554; 
 Tue, 08 Apr 2025 12:47:53 -0700 (PDT)
Received: from ?IPv6:::1?
 (dynamic-2a02-3100-291c-6e00-b87f-49d2-cee7-5562.310.pool.telefonica.de.
 [2a02:3100:291c:6e00:b87f:49d2:cee7:5562])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f087714e1csm8356440a12.7.2025.04.08.12.47.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Apr 2025 12:47:53 -0700 (PDT)
Date: Tue, 08 Apr 2025 19:47:49 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>, qemu-devel@nongnu.org
CC: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_0/2=5D_Add_property_to_supp?=
 =?US-ASCII?Q?ort_writing_ERSTBA_in_high-low_order?=
In-Reply-To: <20250405140002.3537411-1-linux@roeck-us.net>
References: <20250405140002.3537411-1-linux@roeck-us.net>
Message-ID: <975E8214-89EF-4D8C-8749-7C3FBEA253D7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52d.google.com
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



Am 5=2E April 2025 14:00:00 UTC schrieb Guenter Roeck <linux@roeck-us=2Ene=
t>:
>This series is needed to support the USB interface on imx8mp-evk when
>booting the Linux kernel=2E
>
>According to the XHCI specification, ERSTBA should be written in Low-High
>order=2E The Linux kernel writes the high word first=2E This results in a=
n
>initialization failure=2E
>
>The following information is found in the Linux kernel commit log=2E
>
>[Synopsys]- The host controller was design to support ERST setting
>during the RUN state=2E But since there is a limitation in controller
>in supporting separate ERSTBA_HI and ERSTBA_LO programming,
>It is supported when the ERSTBA is programmed in 64bit,
>or in 32 bit mode ERSTBA_HI before ERSTBA_LO
>
>[Synopsys]- The internal initialization of event ring fetches
>the "Event Ring Segment Table Entry" based on the indication of
>ERSTBA_LO written=2E
>
>Add property to support writing the high word first=2E Enable it
>for dwc3=2E
>
>----------------------------------------------------------------
>Guenter Roeck (2):
>      hw: usb: xhci: Add property to support writing ERSTBA in high-low o=
rder
>      hw/usb/hcd-dwc3: Set erstba-hi-lo property
>
> hw/usb/hcd-dwc3=2Ec | 1 +
> hw/usb/hcd-xhci=2Ec | 8 +++++++-
> hw/usb/hcd-xhci=2Eh | 1 +
> 3 files changed, 9 insertions(+), 1 deletion(-)

Series:
Tested-by: Bernhard Beschow <shentey@gmail=2Ecom>

=2E=2E=2E on imx8mp-evk board with 6=2E14 defconfig kernel=2E It indeed he=
lps to get USB working with this kernel=2E

Best regards,
Bernhard

