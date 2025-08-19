Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9226CA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 16:38:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoPMH-0005vq-U5; Tue, 19 Aug 2025 12:38:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uoPMG-0005vX-CQ
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 12:38:48 -0400
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uoPME-0004XR-Jp
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 12:38:47 -0400
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e9345697409so2465601276.1
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 09:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755621525; x=1756226325; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dD+L7RuusLlyjNxTTzEMAnCmGH2QRwAasg7h4qoqsyY=;
 b=IFsmBKkJP59EXDfUyA8lmkMLyQfEDzG69BYNeooeoDZJbiJ2LxJi/pz+QsQR8Yy9Jj
 E3TQsjdd96syaVm6nHu8SeHSPjZrEjXX8XgYLobgZpVhdskoIcQ6BtlM/PHe/WlxRga1
 l96O1zisyadsHu0KEWtEzPeKfjS3Ef+OgwwoMMgTXeYjMBW3wKtM6qFcVcWgSNW8op18
 VWdPQM5TtGCeKjEOE8j+dJPF6Ad7kpe28F9U3iHIV9fRyiyAPk0P3fRXcMbMosXhZGoC
 AEc3IZkNoeRtQAmv6jqqTBFStdovqRbNrVwbEZPiJE++pGgLKG6kGJmBMppogYYzR3Mr
 k0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755621525; x=1756226325;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dD+L7RuusLlyjNxTTzEMAnCmGH2QRwAasg7h4qoqsyY=;
 b=tIaxNj/TfasL1pq9NizbbfBQuFaenUzjGbGmDHGrL9WvJ+VZck4cvK6cwIIMxOE7mP
 0j+Wl8x6tDfkMGRhSh7HagxTiIMG6Pax4obCHrIbOeVWfusz8SYQIZCZQwtEI7jNlUiE
 gRIiODWIwOQyy7kv7Xbk7aXG1b+AD/qUtI6fu36x/Nv6RtsXizsB/1z19KhUwJ6bzgi3
 uJJO6YrEa/mwEde/DQRxR+ObZOTHoJPuZCjPVsVr5qEG0Rx+hpydqDsN0JAvd9eEqxcN
 5a5LXAabNquqy838vxCEc7K4epPFhEMcGFv4WztuHa1FcKEeC6AhROekxx8T8m3V+VCW
 f7yA==
X-Gm-Message-State: AOJu0YxHssMIHLbbimKoMdnEWsZ05knQbGVj4SQXSHtcTdQxS9wd99+5
 Tsb1z74wwp+Dz2ZawRKY2V7dLiYDjqFiTrHbQF6jtSbzrvDtRDkIQDgtW82SLHpqVuRVCw5ngGN
 7uDFqQJGL7vuS/8l37wDByQ5LWJf44Nkn6J/uu6/sNQ==
X-Gm-Gg: ASbGncsb8jPtWNOwl56ydbJ6vSj1Ullxx5AucKBnKXK3KqVg5sAkABhmznNka3wdtRj
 W8rJKLy+Bzk+y7BJdPpo2GoMIpIsLIJqI6C+qPD1uR4E4d1m1vgC+H+WEJ+xgcx5ETYhNSLdxQD
 Gpjn/489MJle2gxIyIfIwYxwVI8xDnqmZRwpnwy+uVK0uxpr0hRQTz4b6eIL2FoT7NFTHt8vpu4
 RbyUHC4
X-Google-Smtp-Source: AGHT+IFSenXst4Ro8h0COYBtGGnpD/miCaGT1PAuHn8cS1PWfhv/E/bePjhllcaKwSRO8MmP86BgMPTAETIuB23HMC0=
X-Received: by 2002:a05:6902:100d:b0:e93:19df:8da5 with SMTP id
 3f1490d57ef6-e94e6067dcfmr3140963276.7.1755621524642; Tue, 19 Aug 2025
 09:38:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250815090113.141641-1-corvin.koehne@gmail.com>
 <20250815090113.141641-3-corvin.koehne@gmail.com>
In-Reply-To: <20250815090113.141641-3-corvin.koehne@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Aug 2025 17:38:32 +0100
X-Gm-Features: Ac12FXye5LMQQ7DDmpWMfNFE8-orybdD_ANdcSBDaaQxDhqJbBt44z-cP2OAN4o
Message-ID: <CAFEAcA_==rUq3hhWmHLEmDFCgF_QhEOnMX1YRNmG5Nzsqv_WXw@mail.gmail.com>
Subject: Re: [PATCH v2 02/14] hw/timer: Make PERIPHCLK period configurable
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <corvin.koehne@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Corvin_K=C3=B6hne?= <c.koehne@beckhoff.com>, 
 qemu-arm@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, 
 =?UTF-8?Q?Yannick_Vo=C3=9Fen?= <y.vossen@beckhoff.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b32;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb32.google.com
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

On Fri, 15 Aug 2025 at 10:01, Corvin K=C3=B6hne <corvin.koehne@gmail.com> w=
rote:
>
> From: YannickV <Y.Vossen@beckhoff.com>
>
> The a9 global timer and arm mp timer rely on the PERIPHCLK
> as their clock source. The period of PERIPHCLK (denoted as N)
> must be a multiple of the core CLK period, with N being equal
> to or greater than two. However, the current implementation
> does not take the PERIPHCLK period into account, leading to
> unexpected behavior in systems where the application assumes
> PERIPHCLK is clocked differently.
>
> The property periphclk-period represents the period N, the CLK
> is devided by to get the peripheral clock PERIPHCLK. We can now
> configure clock properties for the a9 global timer and arm mp
> timer. That ensures timers can behave according to the
> applications needs.
>
> The PERIPHCLK period can also be set via the command line, for
> example for the a9 global timer:
> -global driver=3Darm.cortex-a9-global-timer,
>                property=3Dperiphclk-period,value=3D2

Why is the property for the main clock frequency a
value in Hz but the PERIPHCLK takes a period ?

thanks
-- PMM

