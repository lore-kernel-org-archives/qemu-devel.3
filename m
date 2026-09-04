Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CEF5C61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TVb-0004mx-FO; Fri, 04 Sep 2026 08:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x2TVa-0004mg-NN
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:59:06 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x2TVZ-0001w6-1U
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:59:06 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-81f3b227a4aso13060427b3.1
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:59:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788526743; cv=none;
 d=google.com; s=arc-20260327;
 b=UOwqy0mL1iAlW8/AGwdzuQ2FtbTvBlNJQpTmyHf+sH0BIlQuhkOTduu+BZ07frauv5
 /+ifYR3IsXEIoGPS7hf08h2dVxwblxKnneZqwvEhA16LmbIZbRimhKsjK7KmeoJwtBrX
 cKE1xNz5OZc3Y+E73g/F5XTtRZ7K3Jy84mMjcO6fW3vbJP28QoGYCzCeSg57XWFuqFOu
 jUrP4DHO0H2aZoP7Orxv8DJYGELJ+u05CQqTMx6oXqqPK0oLjF/jAasVyP2OuBbc80G0
 EbKb4u6fIeINDDFfjyOyjqVLAicUaqSe/AgknX0PHfybWOufXfTLpfHHQfuQuFFXFg7V
 cEkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=K3pIkamcPCInrlCdwDCuGNjyofNOBniT7x0FL8zmMEc=;
 fh=VrRgAIANS83fUzBVGHginIrjoV8M5NAm1xDFXlHW/Bc=;
 b=KG+e3IwoA7Lne+IZ7sbBCdvAv39kD72I6LvRMtsGXoozVtq0KwF+sZKqve9Z59kYKu
 jHPMq/rsM0+xqw20xufGeYKYOHda6/BxBTYlasExlz1MLexVEpSM0mHpavF9FFH1hT/H
 zxakikw4M89xdPXt/BsIun7w/8xWDDttzkE5KmSnEKxFstUddsjtN115dL0uofd+C3TZ
 uvhH9giWD2JPimQDXwKSgFZjl3LsZFS/icUNXFXUmxUBH+sYQOqgcfPKcCYA+xuE5tEj
 JaJ3t6ZzvL1/pF44Zh+5gOkeDW0O/DzoiJ+xeRtDelwznv27l7nDRU6SsmITtLTzGdYk
 lNsA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788526743; x=1789131543; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=K3pIkamcPCInrlCdwDCuGNjyofNOBniT7x0FL8zmMEc=;
 b=UyrWeMTOgp7aRPV4Siq5BQC+UCqZVIWliXq7M6nPZSL+RW4+zxNcik4fzLHLBydcA8
 5ygNaEHb7/1EFnR6KE2JOiAaIHdg6aLtGXA5TAAj3zbu1Trh2Uz9LP6ZMakQmStdHstL
 bpCqAtmS8YLTvvp7ZpjX+jFG6CgoGxhkgK01skGTL6wREdq7Crnboei80mQL39UvVdAf
 44ep2f5iuQETkSZy4CDX621splOJDrDswD/V3JJ2N1XNzP30se/Waqaf2bqa4bNfdUZm
 ZWITGrkuOlXnTHuUAmd58BYPXfslRUbPYhQZEoNDyI5kMRaV1/N6Zto4OzcQFWUsPSV1
 /v3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788526743; x=1789131543;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=K3pIkamcPCInrlCdwDCuGNjyofNOBniT7x0FL8zmMEc=;
 b=bP7A6IWBAk3Ana4GWIpeAUjscKrrhqyBPotKnX4eH38vT8WZPqIoOltyIgiQjMGXhm
 Y6dlTTLHAaS7dp7U2W+S8ib23j9cJvEmTYM0cXaujtyYeVdBA/vqbzrXRkJlKF3jXU37
 b1LhC2kOaiGuVsmNizSuOYU8cesQslaYcUL8HzvhBs0YOjAGdcwfHdcFFJLoDWEkVtEm
 zE/wsdaVhc5ZLZPpahMY/U7B1NNgBxgrZ/sTpz02O++I3rpmHCyYinG42cSdaiswm+r9
 0xbxM22t0wXAvN0CPNq/5c9/F+tMjNahfoXHRvHQsRngI10sZhiADom3Q85tETN3QW1e
 IlNw==
X-Gm-Message-State: AFuF++nR2eZjoezmaSo17BbI6PiqtSrb1sFBdJ8GoQXmXKKyhl72zqGA
 WNa1D/nyfI6FyazdKr6KTyoo3YmyDiGfbkvkN4DCYbX1/RYIptcsZgRC1q1vWzSFzbh8chsbW5m
 Fe48tMoJOxPXN4drrdEjX5Vz4HyUl0Vn/xv83D9vJgA==
X-Gm-Gg: AYBFou0IneA4NoSl42PsUCQo5m/aPO5ixvQDCc4lsHzFr6Y1VvoNWItqXFsQD1HFX9f
 B0sRADKloAcjXHBhe7MW1yI9YHVDb3flcmJulRbnUvNQR6KoJ1reT8LFaq3vemSXXnWN/uAXPaL
 kJhJumJ+0Z7j94twtqICh+FeOvDhf1uRrPqso1KGUx1s5irCrvk9yQaA9s39+w03c0lc+P5mKsV
 Um3x1CEOdFWjY6Z0cBvHtKXZDbmyEVAtqXQgcW5/r9S6jrSpyWi4U5lag2hUKNTVdoHyRFBocRn
 lDFCWjEOI+Yypgu9yEqzviHjuFbkjs0LfY3OvIWJXOMQBf63XeQuyE0ktFsb1v/BR0zGP4pngCg
 C01BWXILaH57QPxf3keBD5iZKZH6p
X-Received: by 2002:a05:690c:f15:b0:7dc:f7b3:8e08 with SMTP id
 00721157ae682-8712784879bmr30072567b3.23.1788526742819; Fri, 04 Sep 2026
 05:59:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260904051943.799041-1-alistair.francis@wdc.com>
In-Reply-To: <20260904051943.799041-1-alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Sep 2026 13:58:51 +0100
X-Gm-Features: AcwNN1XY90hOpp7paN-Toqmo-V_h8_DnUc7_qa8Lym4pfxxqXoDOuaJw-8tqFow
Message-ID: <CAFEAcA8fSpOAp4Q=o1YK_guvRxyXWe6i=1k1UwQr1GC-j40u9A@mail.gmail.com>
Subject: Re: [PULL 00/47] riscv-to-apply queue
To: alistair23@gmail.com
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Fri, 4 Sept 2026 at 06:20, <alistair23@gmail.com> wrote:
>
> From: Alistair Francis <alistair.francis@wdc.com>
>
> The following changes since commit 99e54ab5e7a6efc945af6d5661842155d1f3fc7a:
>
>   Merge tag 'hw-misc-20260903' of https://github.com/philmd/qemu into staging (2026-09-03 16:43:24 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20260904
>
> for you to fetch changes up to b23a62773a7856299cbb3782e64968b6a92c792f:
>
>   hw/riscv/atlantis: Map the SoC through a memory container (2026-09-04 10:30:14 +1000)
>
> ----------------------------------------------------------------
> RISC-V PR for 11.2
>
> * Add initial sdext support
> * Make RISCVBootInfo const where possible
> * Use hwaddr for virt IMSIC device tree address
> * Avoid unnecessary removal of test scratch files
> * Document Atlantis QEMU-only I2C device tree nodes
> * Make s-mode IMSIC stride explicit
> * Correct dasm for cbo and lq
> * Add tests for rv128 [ms]status
> * Code duplication work in preperation for riscv-server-ref
> * Fix user option hash table leaks
> * Preserve vl on element-zero fault
> * Prevent abrupt abortion on unassigned value write to tdata
> * Socify Atlantis
>
> ----------------------------------------------------------------




Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.2
for any user-visible changes.

-- PMM

