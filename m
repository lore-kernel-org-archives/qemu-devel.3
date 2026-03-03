Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F371EC1430
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 11:36:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxO2p-0002Lj-Dr; Tue, 03 Mar 2026 06:36:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxO2i-0002LJ-EM
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:36:00 -0500
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxO2e-0000RE-VZ
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:36:00 -0500
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-64c9cabfe5dso6723246d50.0
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 03:35:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772537756; cv=none;
 d=google.com; s=arc-20240605;
 b=AxiJxSUJmd1sGRKUXutXXJ/Dz1SnEqZR5FtM9/9NxrpMnwZdmxtAkVCXzxk47+IKRY
 3Prjrd0IJyM3WotADhrngMmjY13C0B118uRTQd5WN6MHZM/tl4ztovyOTJwNQgwf7FDE
 q2Nfu9BGst+deG0PYHVRx7CU5+b8MCVERH2ZXOIooXM7zsm6QHlxZ5KAfqeXi4xaXwjC
 ZBc8qwyILwVC9nHaogVkAIiD52GqOQul2aUxVmctUB69YqpfvssEiHZOnhLW7EkPGzKT
 h91RVM+tWkP6CdCTuYAskFOwRSLlQrjfQXi03AgkrTYZeqWrhoOIzfmwH6XazR9u2oBe
 AYOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jNYUG423/WJwFfBAvxtbOTUONG2D9Kt6+fOOWN5TPU8=;
 fh=e8lPG31nRq0pa29+ILZPVpv23pShvDc8zQNyomzI6HQ=;
 b=cCyaN1qblE2pJ76NGyZwDkGRadW9eAGB6K5NqsctZznEsIICr2lKtPxTCARDPFylVG
 bOxR+4XjekyYQMvfdJANtHRTjaYYmpxJ6ySTYGDD1Ey8Zo7ZYSyCPMtL53EoMPsEwbIN
 CX6Ksh/8GWa1IkZRGI0d6zvwxsKp2OggfcC7iDWnb3vwFv/gu8eWcFrTsJD2Y2rpcq96
 X5/BNWCwbuHKlqnxdtFvDyusKx1wRDpp9rvGWrCoH2XB7qZyRYQQbXBHEG1bjVgMTW7n
 m2Xb/4ZzigF0zSnhweu7iHDOLjat9qvbhHAzOc8Nojtpr4dqOK8UNMy2zRUsLUJy0IzH
 8ZnQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772537756; x=1773142556; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jNYUG423/WJwFfBAvxtbOTUONG2D9Kt6+fOOWN5TPU8=;
 b=oNjCIEJw/kWLMAkQPoG2UYcOw6vcTSBtBFznPc4eq68HfdWqlziQeauEkFnqj9S5+S
 mQE1YGj4684Fccvo8qP66oZMe6mTC8GupdQUitKLDYQ/w/daSsZQLugXnriqY9YRrj9G
 71JUZz7PeOe81NkhyJRv6Z9VwznjnW14BowkEJAjUmwAElDojNUAdHAalj7BarlAWYo6
 2b2mUukcaIU7XuqR+d5N4vAxTxGonvsN/kAM5KSuTd53bJUNfjG8fr/6vK6iZPDMzW5P
 KbSRs/ivnmtbAdV0A6jNxXNGHPSGJue/KnEfGZC0EnuT21i7FHKxJqgLPPf1wVOZPczR
 T6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772537756; x=1773142556;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jNYUG423/WJwFfBAvxtbOTUONG2D9Kt6+fOOWN5TPU8=;
 b=f1Mk2HD8XqqpFt5TwxgYGouaaIPeV9mF//GpLEASmLCB2TnTy0Q7i/yLrwbsMKAEl5
 b1V9GPPqJaLQl6Y3FZLcdbdbPScLFDnDLfq8IGO90fe2zDfS1TuriFIDaBHthXV1RzGE
 oaawRODOqNfzzPv/SZz8So29SmKhSOo8vyJcveDinqcPQ1SuVtS0Hrk/AF2pvMSplGjN
 6qYlYomGkPAQRmTT7JcHE3+OGNrzrdH95Q+0mwHSC0wLp3a2FUuNkZb39KdUPUjhSyll
 vpEOCFvS3mXvl9qEJTiRLEkMvPkSfhb/yxeax955XrvUc6baCkgT6qxpeKVxwAW4XylV
 AASw==
X-Gm-Message-State: AOJu0Yy5g93bGbz0glv/+OUaCnxqaLK/c2Y8+JijxOFMhX1BYEQXfarp
 GknREjFLF0RZTyqZO+q8pOx2X9nbFgbRPcA6pTJWGz/2k8bPVDaclucIxA6rq76MkDUC30AONU2
 pfzjqPzVBBxt6bscT3yqNdHtzKAublppAiADmcdsRmw==
X-Gm-Gg: ATEYQzw4ujsNrDIuw66xC1MvLAN0hzYQbTrVIjiXtHLkAdlY2VFXkX/0dKzrtoRIUPS
 Ct4y5R4LY6fTaeoWaqgIN1e26wB8orudkUavFz3kMs/rchwlDnyTwmhimGrnSFOHOzLiovD0++t
 ti5Ph1uB3QZIwMno7pDsdPb5u+V5z6l/cfT9uR/vhpxxh5dwEsu75PFVRkXGJEUDXf1i3RQ70Y6
 5h8Zpqo/wQQxl0c3NeTkpf6hZOm4BZVCNZ8DgkbAF3L0RtCymEzGY7/e+1EEh8Gg58n/MTsRczj
 rVL6PVWiIH8IigMY59jpW6w9mdJvv4p7reimLsJwrdcPSLZ85CI6crxbsx+NJ8uB0WQ=
X-Received: by 2002:a05:690e:130d:b0:63f:b6c0:23f8 with SMTP id
 956f58d0204a3-64cedce4f47mr1044985d50.33.1772537755702; Tue, 03 Mar 2026
 03:35:55 -0800 (PST)
MIME-Version: 1.0
References: <20260302220254.1166849-1-shentey@gmail.com>
 <20260302220254.1166849-11-shentey@gmail.com>
In-Reply-To: <20260302220254.1166849-11-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Mar 2026 11:35:44 +0000
X-Gm-Features: AaiRm53MAL6nwdFOQhIgqc9wlQyCd_q1TMPWryaEYM-utEPDBCxRiSBj8YrVuJY
Message-ID: <CAFEAcA9beXAZHHnU-E9w3Ze1yA-8=Eq+nmjpqL3iuFHVwGk8yQ@mail.gmail.com>
Subject: Re: [PATCH 10/12] hw/arm/aspeed_ast27x0-{ssp,tsp}: Do not access
 SerialMM internals directly
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-arm@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Helge Deller <deller@gmx.de>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Troy Lee <leetroy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 2 Mar 2026 at 22:03, Bernhard Beschow <shentey@gmail.com> wrote:
>
> SerialMM inherits from SysBusDevice and exposes the memory region by
> means of sysbus_mmio_get_region(). Use that in order to avoid accessing
> implementation details of SerialMM.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

