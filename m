Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB6E3CD5BAF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 00:59:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQEDi-0000aU-CA; Thu, 21 May 2026 20:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQEDh-0000aM-78
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:58:33 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQEDf-00024k-IE
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:58:32 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-670ab084a39so13429683a12.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 17:58:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779411510; cv=none;
 d=google.com; s=arc-20240605;
 b=Pyx5yo696B0fzBTPytTn74LS+5JAGk42R6U859mjRLMtEKTpoUPUKIFHTfkjRP4Wom
 XZHkw4PJkH38WZaIIzFaemiZa/Z+jIuM16deD+FusdRPAcs5qhryR2zaZ/b1lGHyR+xr
 wiCWibWfeHlyBZNZqxE4tbwpr5yivt1kp42rms/KDuE7JeW5tBdEXRgTXWAvwi+bxFZZ
 sHRsZu6BMSKhcl5lZrzMJpNQSmNnwBR5uIYG82ejc4Jg+Ytu3XRi20jVzG6M8xu3K6AM
 AZhccPTgEQ/VkaEVNFvd6BroD06MBDTPAKq2oAQguBThg0jVEGechw8zsD7Y83PXrB0m
 dCIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dOxYzCri1hKmAhQ0pT49sg4gJbojycDZgjmNPKm6rAs=;
 fh=Ofc/7yYflL5fzGU4DVTgtdXtCN7XZwZQ8r7NIaePuJA=;
 b=fTBBlaJdkXSD4BUUPzxFMFS/W5j3rSn6pPPjuuEPbWLhNwVsreASy+H5v2tcaNUPiP
 yygwHcMnZWMKMUw/Xk8LslFEr56mwSZzGSPZvGxO9tev8juNahemRFAYrDSztHBew/hH
 2TkOyiiShAajuSmHmHxT3jB5pMALLxbceZY+4TdDHxEmf/OIpVAiIpwjJZZestNOSZGn
 /md1h+7THVJnMw/zYDRtctzRH5VgHzy/4P7QCXWi6rycr8AKS9AW+TnvnkfJK0Q90m+V
 uSzDZhTZqf1+kcsrEOCv5clD+t9pl8u+c2WX6KEAV7yNLTt+V3AnRc+DPOqHC757losC
 TqHA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779411510; x=1780016310; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dOxYzCri1hKmAhQ0pT49sg4gJbojycDZgjmNPKm6rAs=;
 b=PmUVfZ6K9YEjHw/HmYLyc8/EF5IU41YaJR5+sWWzCoEH1cp01ZumE461b+eRTHJe06
 jY84YuAJ8xgGtsEo0bnzDmbC18AY9gXAR/EViGk9h853vfMchWSWT4Oo6hz+f2m8xohp
 cj+Ha6nQZ+4qNfTdbvfSIynyCjpKOyT7uMhnkddMpedSRfaPfVvo2cYGQQxiofAZKJrl
 +HI4F3T+FGUEUdpm/wNcFtrinCMtTQ0ai3yHHIyeW6NyFQiyjYStDTef65X41ueTcoOR
 1KbyqeDisGJCMSrUoRucXV/mpTVvp7lvic1kgqYHfPIKxgyC5Ck3csJQKQHn83cJKfeK
 Atxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779411510; x=1780016310;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dOxYzCri1hKmAhQ0pT49sg4gJbojycDZgjmNPKm6rAs=;
 b=Nq3JMXkgxjswALa83Eqb5VhdjlCvWiBAV+hFo8LixIMfDOGFemoYFGg+v22MK7un7F
 TgJE5ferMxUha4psBipzos3ZXYb94XTrGJdh4IUtaV0xc0IUj+1nhmAWlcx5hUlb800c
 F3wdcv95SnLA6AIvm92bIdE1F4tYHaL+9Gyp2kauPOI3N2modmS4sM5yqnCEz98vA2Ec
 ot6TywuG1hhDXQF5Lmqw1HWSkiQtAUXbZauQv4xYXu31XaOjYCPEpbJ5gX2xNIaQYGHL
 Sy4MPwHVdTq0pobQOwH4vn637s5l5C19DRbap9NwGvr3yXUh+DI6pU6p1yKv31AGS5EW
 5HRw==
X-Gm-Message-State: AOJu0YxdDLLne7203K2fbWd5p9T+1GNsXzje6gsRZT+UDvLYB2HFyKxO
 dJffyXH7TwJORxg3tYn6XkIw3ff0k3ipAE+Z1wKqC1p0uucsyzv0iU2sxOhMRS+iOQEfyirBf4l
 M3hwygohWksg3uNyP8QWZ31jB0DhuvPQ=
X-Gm-Gg: Acq92OEBnDXR84zjynKvGzPnklEdwJs+KmO3npThUHgLKBkC0lOUzEZXV87+2r0xjPe
 5gum1C2ZLXAFMZXoHsfiBMybxe9C+W/8wd+LbXWWaShqQLdlksT45nsHCznYcbe8f0e6dDsB2NR
 sjFJCVacct0el58KPnyYPlLem+R5XGeM0+2JVM60Y7xOVe88cHVsXy2/SmE334DJLDnRBbbIdKX
 bGED5TFocyFm4HT6wUGR5AJ9861CmJjuRAmObvFE94CyMpBUdbhKUNsw2K852FWWvl12QX2aIg/
 51F78w3GR+d4mYlhpaZaxWa7rMbR7qvq+PnipQ==
X-Received: by 2002:a17:907:a68a:b0:bd3:413d:c51a with SMTP id
 a640c23a62f3a-bdd236fb18cmr92067466b.17.1779411509376; Thu, 21 May 2026
 17:58:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260515180437.23620-1-anjo@rev.ng>
 <CAKmqyKMZWH0cBp4gNoVpM-emEb4-BEvUb5BdBAFpc+XRB3kF+Q@mail.gmail.com>
 <agyQqYrIfNDPFxq4@hive.localdomain>
In-Reply-To: <agyQqYrIfNDPFxq4@hive.localdomain>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 22 May 2026 10:58:02 +1000
X-Gm-Features: AVHnY4JhDWNAvu4a2DS7Bn0B-noevVnRHCA_MGvYYabYAwC5U8PLG-bgJQSJ6ik
Message-ID: <CAKmqyKNRF4yT6JKve-=1tB_vPTciYt1Na3M5iD_GoLVpADHitg@mail.gmail.com>
Subject: Re: [PATCH v6 00/27] single-binary: Make riscv cpu.h target
 independent
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org, 
 alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x534.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, May 20, 2026 at 2:41=E2=80=AFAM Anton Johansson <anjo@rev.ng> wrote=
:
>
> On 18/05/26, Alistair Francis wrote:
> > On Sat, May 16, 2026 at 4:02=E2=80=AFAM Anton Johansson via qemu develo=
pment
> > <qemu-devel@nongnu.org> wrote:
> > >
> > > Hi,
> > >
> > > this is a first patchset moving towards single-binary support for ris=
cv.
> > > Additional patchsets for hw/ and target/ are based on this one so it'=
s
> > > best to make sure the approach taken is ok.  Most patches in this set
> > > concern fields in CPUArchState which are either widened (usually to
> > > uint64_t) or fixed to a smaller size which handles all use cases.
> > >
> > > General purpose registers and fields mapped to TCG are dealt with by
> > > widening the type and applying an offset to tcg_global_mem_new() to
> > > correctly handle 32-bit targets on big endian hosts.
> > >
> > > Quick question to correct my understanding. AFAICT riscv64-softmmu is=
 a
> > > superset of riscv32-softmmu which handles 32-, 64, and 128-bit ISAs, =
so
> > > concerning single-binary do we for the time being only need to suppor=
t
> > > riscv64-softmmu?
> >
> > That's mostly right.
> >
> > In an ideal world there would be no riscv32-softmmu, just a
> > riscv64-softmmu which could handle all bit lengths.
> >
> > There are currently corner cases where riscv64-softmmu doesn't work as
> > well for 32-bit bit (I heard GDB debugging a 32-bit guest either
> > doesn't work or has problems).
> >
> > But focusing on riscv64-softmmu with the goal of dropping
> > riscv32-softmmu in the future is fine with me
> >
> > Alistair
>
> Thanks for the clarification! Do you know if there's any performance
> regression to running 32-bit code under riscv64-softmmu? I assume
> there's more extensions/truncations?

That's a good question. I hadn't thought of that.

I'm not sure. I suspect you might be right, but it's possibly only
small and insignificant. RV32 isn't used anywhere near as much as R64

Alistair

>
> --
> Anton Johansson
> rev.ng Labs Srl.

