Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 784F6E9A04F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 10:36:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt1O4-0000do-4D; Thu, 19 Feb 2026 05:36:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1NY-00088K-Iy
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:35:30 -0500
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1NV-0006QV-Nw
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:35:27 -0500
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-64aea64bf15so731717d50.2
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 02:35:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771497323; cv=none;
 d=google.com; s=arc-20240605;
 b=N1hRE/7xrWu2X9V0oJwF3k4G5RpCnI/t3YEkEBMxoBuepWN6GUP3D4R3lkq9qwk8jx
 ppt1s0yp8s6Zq02jUk916FzwXqmrybJVrb0BmtYPdMZFMfYAtFxPPF+w+wU5XYKOvcUC
 2Oe3xhZDxeSz4kkX31+QcwDvMMqjBZqkM9H9YyElOvrkhDReCHyOBlItHg3XdACbgG1f
 NhOtzyIkrMpP5DFhumcwjPS/xu4s837pthdygJ85CvaWACG/5dkZH1T5uFFT3wZyeBs1
 /ngLVuGVN9hgAsNpNdRrW0xATg7QehUD6IC1/4+pRePv/t+N0eoAOaooWDI8q0KjqNOw
 SYAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vU68ziiXPxsnXEk4bwm5u27nLf/L7Gs1k5NzZWv1sFA=;
 fh=iVCSt0Y3jDFA7mburWuRV/rVTrXOrw8RDEi7+e76MT8=;
 b=XbSGxpcDNBiSdbBMqHyRchTjhRyr3PyL99KRHEMB0n444eVQJwGrct1YqmY9+hk6Pv
 kKMszKozNMj6XqOmhPMh8e39YlF1oSaahTXJE56iWtLMk3ZBuklKWixcBdA5QGPM5b5P
 X+KZt2pMUbocOAslog+5tS1zh9YQuYqOS1Vw1CXgX3QVa0AVYQAQJujGnKN66VEut26T
 MIEDSsS/w0QPy7G/TEjk7Mzn/Q6Ofn8t03AfSF2U3UR1R4MDjriQ3rSqXXJB/kmE6Jy2
 8za5kU9fH9pU7CoO71+nKfYGNkWz9wQ9av7Et8wSda8l9xthKAKumBk60gjjOIxkDAgL
 Q0MA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771497323; x=1772102123; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vU68ziiXPxsnXEk4bwm5u27nLf/L7Gs1k5NzZWv1sFA=;
 b=gQj2fM/y7lUsPauTfJ//6Ra3P1jABkHuKxEsuzj4Y2i60C6Ykz3rSwd6qNRQWMkrZm
 cd7kykoR5GrzmlYmpetOW/ljAiRgEkZ/SLw6IAAu7fY0TyhRs1evncg5bMWsux+01kug
 ZVFlLlfWrEoFsrVDfSp/X8Z2iDJcTPPNynL8JlGKVUKourS1XTnhlLHoSWNjR3U8FxUv
 1wr8ud6TudcdhV6zZ9/2q3xk60QCYnkqw9QVTMJFe/phipMlcWPumYfPjoLNIAItwmo+
 lNybmigd4vxP0YSKzhe+YgoZGxN3aDnOtOaOioLC1W9uu2rVDqGn//BW5j6oJGJM63aa
 6Kwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771497323; x=1772102123;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vU68ziiXPxsnXEk4bwm5u27nLf/L7Gs1k5NzZWv1sFA=;
 b=lAvgeJFuzVRXtSUJ4LWgm28JCmClrJl1VG+sCmAcO0kyWTU8rqE3q2TOuMA2v+5vsD
 FhvkB2llLY1i0vY04IDZigPXU/s4Ga0Es5/uxrQjixvSe9gW6fIa3nmMKmTgw5Hl65R1
 Nk81qVWZgad+b8uxniCedJWffurM5qINVa1iNuSn/4glAuZwXeM+gBkNH6Rmk6wGQrhW
 W6SpqptoiPIHhfowIFNV9StnAgqI2xNKJXgXsGaaMeBmgPpz3R2qAVB6X85ongMTPURK
 Subf6MPfLiSfei1eKGv3WkaEGJzNxCZ3S+UB9QX9AEJr193JlsW8w7ZmU9ktpJPDrVdC
 t9rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeh1bMMO4KgyhA9a0OUvL90VlhXckAAY8DO9judxwcWEdlgMHyuL1be0/ht99xwGlbCqEdI73cNrkh@nongnu.org
X-Gm-Message-State: AOJu0YyqdNAV4We1Twi+HFoNn/+A8Gcq6K2qmsfV886S9kDBOFi4HCAk
 DKAoWIMek1RRqI1QtPf5OzLQXLghLJRlgWFFGIXbZP6lFr6Sp2EfDGTqM0uhK2FySpHUM/kcGP2
 8RtKa28Ny9PfY1+jLZO2gkdhfe0woMv8MQqG2BaBnbw==
X-Gm-Gg: AZuq6aL3YN+oxPzj4Kh/GUWMdReYyk/+x5T+4JZxpnFIexJdjk/WFy4W4fkV6Q4uTx1
 NDDSLXaMhZqNg2AP+cN1JWaie0sfoWNKh6A8Vc+FMz96Fd41+A6fFl0oVF30LGigezeE6biPVni
 qbM9NF3r3hPDDm4tzytbQQm7cvLqBe/dGvKBAdcukQ6TpORGgJOaOpu/P4FTMpL7JlK1wKABip+
 XhKF1/SRXtB9wIdhFClrmBdnZM1NoexQJEmFAGoNHfyTO9O7rGtzPNOvy6DtZPzAem+/c+XResp
 egwo7tNOgXZG24u3hyPDucXIuoWz0yfpgeaZCr/snxLUeFbQeKH5rKMGJSsYClvMS4A=
X-Received: by 2002:a05:690e:1918:b0:64a:e1ca:2d73 with SMTP id
 956f58d0204a3-64c55589dcbmr3401504d50.31.1771497323173; Thu, 19 Feb 2026
 02:35:23 -0800 (PST)
MIME-Version: 1.0
References: <20260218085945.1050788-1-kraxel@redhat.com>
In-Reply-To: <20260218085945.1050788-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Feb 2026 10:35:12 +0000
X-Gm-Features: AZwV_QhH8OmktqPodhAa_DkCcDLJHL74GHh0AHpcloXxEog4HXxUiY5G4IHOMhk
Message-ID: <CAFEAcA9kKLdK4ayKacdugd4tL6zO-08zT-FmadJUT-MzM1od_Q@mail.gmail.com>
Subject: Re: [PULL 0/2] Firmware 20260218 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@redhat.com, qemu-devel@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Kashyap Chamarthy <kchamart@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Wed, 18 Feb 2026 at 09:09, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit ece408818d27f745ef1b05fb3cc99a1e7a5bf580:
>
>   Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2026-02-13 10:30:08 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/kraxel/qemu.git tags/firmware-20260218-pull-request
>
> for you to fetch changes up to e8dcd2a0c2d663963408f2d642de864feac8ca0d:
>
>   docs/interop/firmware: Add 'uefi-vars' member for FirmwareMappingMemory (2026-02-17 16:03:06 +0100)
>
> ----------------------------------------------------------------
> - firmware json spec update
> - igvm update
>
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

