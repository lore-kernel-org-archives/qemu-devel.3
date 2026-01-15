Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B45ABD44C67
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 15:36:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgPNo-0001ZT-6A; Thu, 15 Jan 2026 10:35:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgPNm-0001XI-1B
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 10:35:34 -0500
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgPNk-0002oU-HV
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 10:35:33 -0500
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-7927b1620ddso15988367b3.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 07:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768491331; x=1769096131; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UpqU9cfo1pFWzDH7JoKCp5+Sd89DbW80PRV4Wz+Ueqw=;
 b=idbs4jJ9aiMsUoslYq6C/cHh1HhjHpowW4uaXEUpnvHCyPFa5Dm0xwxRABjBCLR2VF
 hcx0RX8ExNCnLNEk/94bkqmDSNSXgJih/J+QTySw6AWsdgYrotnpXu76aiHu7eW8OpFB
 swETyiWKGDdNOoqBBfojkZep7PddQ0NfcGCOzPR2go6MwofuLju+AE7KXeuKCSntGt+1
 olZ4K7AGemgJ4epuoVQ7q+23/1c4RJjkBPapyWe3rxBs+b7k8VJ6sIDlH90Lak9fL92p
 WDqgvAShIgH0Lics0ijWQ/OT4JQxxyBkkzQT8jt004oO+9SPw82cOKyPkzPipQkCOneQ
 mEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768491331; x=1769096131;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UpqU9cfo1pFWzDH7JoKCp5+Sd89DbW80PRV4Wz+Ueqw=;
 b=r1QnMeHMUIsiRYuljfh0XFUO81nrR/v5CYGDAjk4gSWtoNDgPrOh4njJn2Jfn7Z47T
 KhmyPs27DxdWxb13ivw6uOQLx5hNaey93wj4brVJMOPDuFIJSKHzi4OdQ9m5nPSTwqt8
 RO+fYig4lb38uSi/pe6W6K+edPCTL3VAC5X2iFPyFNDqZITWKfUOb5JwTZpZx67KZ2w2
 U5w9fTgZ2taHllZ0iECTS3ZTk/YVV7GcNza/uyCMT69AgnlAhLC7pyAUKC0dBhG5UMhm
 LoXk9IKjmdBVbL8YZN/XQOf3sx9E2ff4KiC2HIc5+cxhfzvK7NSCUuWa0i9Mc8BnaaMf
 pscw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWHH8iW3eaD3ocnXV/1amHNtenLtMC7Dz6o7aZhXYK92AKs+lwDfpbUp1OlyOWnhm4LKAgf61ILHoH@nongnu.org
X-Gm-Message-State: AOJu0YxLNx47WKc9K+Jz1k1zfqfAZudwysp1aAWKB+zkF3cRvrQI1lf+
 T8Q8KRFcZBEd5JY7/TQ7nGTwuCdwOhrDLkaGahyXA2mKoNz2kRA1b1oAiLEUZmIwOvVcK2P3A5y
 t+RfsZif4erlI7XQ3LCWiq0BAXmkC7Sns+6Niq9oI/Q==
X-Gm-Gg: AY/fxX6bgTFlWy+NmM0Q9RCFvaZgxk/UGcFppKrXHJ6jcLP7mCoFgcxiWVe84JVbi9z
 srTq+49ut2VaTY90wpHhenjSFbA4v/JwzgWcmxDrStsudBp+N+GGaHLPL0GI/mHoy57skRbGJ9N
 jLVU69P36v/ZCv+pUd0ew1HkUbizG+L+b5uf5GUG0o8e4jVE93IGt1yKW83gqnec7BrCEd8ArJ5
 3lKVaoWKmbZ9TypENO638k1lxSvKSj8ghLqe3yFGcszAdlzoyjRQO/Vg57p31zyJ+tKr366CSJh
 MiOeIRKWLm8rL2oocdPDxcU=
X-Received: by 2002:a05:690e:4012:b0:644:60d9:7522 with SMTP id
 956f58d0204a3-6490a66cdf0mr2252946d50.47.1768491330941; Thu, 15 Jan 2026
 07:35:30 -0800 (PST)
MIME-Version: 1.0
References: <20251231170858.254594-1-peter.maydell@linaro.org>
 <20251231170858.254594-3-peter.maydell@linaro.org>
 <87zf6ww9fg.fsf@draig.linaro.org>
 <CAFEAcA-YDPYQ7mny_zFjgjWc4W8K18kUVuBgFbQ25sNpsM4Vvw@mail.gmail.com>
 <87a4yej41k.fsf@draig.linaro.org>
In-Reply-To: <87a4yej41k.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Jan 2026 15:35:19 +0000
X-Gm-Features: AZwV_QjB4D2lbqmup96-AwVb94MUvdD4h5wBDIKv3TOqeTpUTA6fGnau-GyfEHQ
Message-ID: <CAFEAcA8bF6p0RhT3X5RUNo-BjNy1mVzUwc_gKv0L45oxZiEi3A@mail.gmail.com>
Subject: Re: [PATCH 2/4] target/arm: Correctly honour HCR.TID3 for v7A cores
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Thu, 15 Jan 2026 at 15:20, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
> > If you have suggested names that you think make more sense,
> > I'm open to them -- since I started by knowing the behaviour
> > to me the names I ended up with seem more "obvious" to me than
> > they would to somebody else, and it's the "somebody else" that
> > I'm trying to help with the naming...
>
> I think I follow now. My only real suggestion would be to make the name
> _v7a to be distinct from the v7m profile. Although HCR.TID3 seems to
> exist for v7r as well.
>
> Anyway:
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Thanks; I'll make that change and apply these to
target-arm.next.

FWIW, v7R can't have the virtualization extension, so
it doesn't have HCR.TID3. Virtualization for R-profile
only came in with v8R.

thanks
-- PMM

