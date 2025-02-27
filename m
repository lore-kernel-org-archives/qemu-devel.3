Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6054C021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 09:06:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnZqD-0002rd-7S; Thu, 27 Feb 2025 04:06:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tnZqB-0002q9-E4; Thu, 27 Feb 2025 04:05:59 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tnZq9-0003ef-AE; Thu, 27 Feb 2025 04:05:58 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-222e8d07dc6so12996115ad.1; 
 Thu, 27 Feb 2025 01:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740647155; x=1741251955; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=slr5296pAwmBhN3tg/QOzri5Mj4gGwe8gpY/aU71B30=;
 b=ct5Q51A/pCFdjxTms3zqj/IsRcAqyftYgKuvU/2mn76MwjRTGt4t30IArCdHBhrp4W
 vt95nTqkvkqEhIw/Fsuxuxgmq/nMGsgqinDWAgRBHUCegL54d+9ESBdpSQt71kKfsX3g
 S9TzStg1DhDgtYcdoVFRAgJWwkNjVtWqYfAFzC2lOVCpKtw24hUu42ttH0ZJX2MjqBe8
 BVztrUa/OfDKxka+FmLLDmKSfs+Xd042HMwb5soEgT2CMCnPRIR/2ZCZmtRKqRTqxdl6
 eM1Xmawg7owC5OYQPOfk1dv6G5+E92bEI01aFQk5/LGCtIk7lSIB+vFG9AaVxVdWZI3g
 SKNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740647155; x=1741251955;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=slr5296pAwmBhN3tg/QOzri5Mj4gGwe8gpY/aU71B30=;
 b=SAKvdS2gp0HmSFqBjGNZgU9jTGDIBMVVSslXUrSOyY6wEj2PUqD2BGxVE3SOIgA55x
 FkyOXXlbeSzbUQEB8nBaX6J1BTfTop91CoYS6XXHoSu2Cj+5jUg2SoxxNhG9FohT0iHG
 rHTslq+hAvzFvo5MmIVIQsqb7Z4HRMl2FZ6KYx1K3t1XjgmenMuk5yoyqzAloh4PxMx3
 qvWIestofgzEgvYvRfFcz3WZ2hPrLnag/WEBHZhBa2oDLOc9cNmq/T86K3MJ+k+GLWlx
 VKCHQRW5fJ5K2zvy8gFQeUrKC252gQjvlgiq/w3e7WKb2qfDcDntyIsexYaMkBk//Oin
 Xnzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW02glvBbAZd9LwCfb2QV0T790BMzJVYrOqaRGdV9rp8Jnwqh5MXcUefN+6VrrZcrD5HpPvqi6eSo6b@nongnu.org,
 AJvYcCX6d+Bg6Q+JxFAyVe0Z6XlIiLIQLyRb0A4gtB3lEOIadrgPU38suQB5uJL2WX/U/8gnEIXEeYXPano=@nongnu.org
X-Gm-Message-State: AOJu0YxnGN5kqN1GS2GPQjW6WJ+8BeteA3srhjq/M6j+Ga1r7f98xEZj
 It3OMmvm4Yu/Vl71JhawkOoL0ctIW0N5GCtd3Rn1FbQsfsaH2V+o
X-Gm-Gg: ASbGncsKXK6KIt/gtRVo+5L2EFAuLM69L3uJQHmkPfnSFpi8lGNJSmxQuCoUPM9KJ4w
 cfkvX8R+J2CBotISR2kjHxmtNQQqlaTcXn8pUiGgC2DEKcVEbZQAEUI7qRNxnzRaoM3irY/AfSP
 D1E5Ldcw5/wkiBgiC9rJgZbs0Mz7tDKIFXhIKXTDGVIKNHt62VEDyIbkSuap6nNvKIYQ9BRyfoh
 rQlGJ8jNX6zQnGoOu1w54rQgWycIv4Z4RoVFesvzrLQ+maw5pg0a1tLA2ilzSkQO7QAaL3hdrwe
 QDK5F5LoOhzBZeQPNw==
X-Google-Smtp-Source: AGHT+IGQ8bgCTryv0BfmdFRV/A5BGBcqEQSfAZsJQ8lfN2G4/wb6xvq8ibIPz+xlgp/ARcGsHoIomA==
X-Received: by 2002:a17:903:1984:b0:221:751f:cfbe with SMTP id
 d9443c01a7336-2234ad4e189mr47983315ad.19.1740647155429; 
 Thu, 27 Feb 2025 01:05:55 -0800 (PST)
Received: from localhost ([1.146.124.39]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9d63sm9559775ad.78.2025.02.27.01.05.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2025 01:05:54 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Feb 2025 19:05:47 +1000
Message-Id: <D833X0DADOYN.29O3TB1R6KTUI@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>, "Igor Mammedov"
 <imammedo@redhat.com>, "Helge Deller" <deller@gmx.de>, "Paolo Bonzini"
 <pbonzini@redhat.com>, <qemu-ppc@nongnu.org>, "Zhao Liu"
 <zhao1.liu@intel.com>
Subject: Re: [PATCH 2/4] target/hppa: defer hppa_ptlbe until CPU starts running
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Richard Henderson" <richard.henderson@linaro.org>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 <qemu-devel@nongnu.org>
X-Mailer: aerc 0.19.0
References: <20250225184628.3590671-1-alex.bennee@linaro.org>
 <20250225184628.3590671-3-alex.bennee@linaro.org>
 <ecce2fe8-f2c0-48fb-a3dd-99a1c4720dd5@linaro.org>
 <c2e62cce-65f4-417e-bd57-85b64e78102c@linaro.org>
In-Reply-To: <c2e62cce-65f4-417e-bd57-85b64e78102c@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62c.google.com
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

On Wed Feb 26, 2025 at 5:38 AM AEST, Richard Henderson wrote:
> On 2/25/25 11:33, Richard Henderson wrote:
>> On 2/25/25 10:46, Alex Benn=C3=A9e wrote:
>>> @@ -191,7 +199,7 @@ static void hppa_cpu_realizefn(DeviceState *dev, Er=
ror **errp)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu->alarm_timer=
 =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 hppa_cpu_alarm_timer, cpu);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hppa_ptlbe(&cpu->env);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 async_run_on_cpu(cs, hppa_c=
lear_ptlbe, RUN_ON_CPU_HOST_PTR(&cpu->env));
>>=20
>> Nack, this is emulation of hardware, not softmmu.
>
> Hmm.  I see what you're thinking about though: this function, after reset=
ting the data=20
> structures associated with the hardware emulation, also calls the softmmu=
 flush.
>
> If we absolutely need to do so, I suppose delaying the hardware emulation=
 flush to the=20
> work queue isn't the worst solution.  This is where the hppa patch is mor=
e correct than=20
> the ppc patch which completely eliminated the hardware emulation flush.

Could we expose a function that performs the hardware state reset,
and leave the TCG flushing to the TCG CPU reset?

Thanks,
Nick

