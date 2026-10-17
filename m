Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E08CCF2C4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 15:40:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI6WL-00056p-Ec; Sat, 17 Oct 2026 11:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xI6WF-00053b-Dv
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 11:40:23 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xI6WD-0002G9-O0
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 11:40:23 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-8b0d126f631so6627777b3.2
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2026 08:40:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792251620; cv=none;
 d=google.com; s=arc-20260327;
 b=MGDsqRqXk18TW54cKDc0v5XVDiS/z04VXMw9GLLfHdvabjn9ea81qAm3tDT3UtPgEQ
 CrWNgs7zKaYqcuh4AaxJM4x/CFhFCMQz0tGuCRP9j6kCjI8a1LT+IH/yZe74QnrtU2Wj
 lhNsjyRxergMONeXqUfMxn1536VbhD9k7fbplKj8UTqCcWUBfO2AUvxNMNlSwtky6yRg
 oDhUB9GZdcy6ZCCkSkHY1mj/2pOPV0q27ScnL5DbMk61UCodZToxO1SlNFFl3VZ7KxbO
 xFhvO3x5spc5nwWBELNjRc483mL8gdfOjeFQtAjNMg6GUon5bJEwnaXCuSawrofTN9K9
 4A2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=GTWxiZskUl0XXvZpBRWj60Fr6tzQkIOL7XZpEoquEAw=;
 fh=yKIEDAwticMq3mqvUy7ZmP7nebdPEU0OfrEgfwwE5Ds=;
 b=qEuyCosQilxkJJcxhqwxgxfg2OcxnmVftZyJHRdF3RqeWkXkqrKa4wFhKaL/zGAbVX
 Zj4/bh10CkwKq1yAmwrulIlNO9ZffTkkAKfdf2mwe0HHTxOFLQoYwzoASzuTSEHK/yq9
 SLwI/fSUAv06gBa21vXOAp0HPV82X4x2XCf5pg26zcCrTnTMU4v0tP9SvqZVf/AdnwBQ
 l5NuQY7oDy0J0k58IVqH6Kb8jMlcFNCfWK3E3F1oPTPj9pfDOYaPQgzKo3nAxsLv1hxz
 6WDnFIptkjpoWaToXwUZxFOrt6DilVHnkdjbNAKvou5cTyZUAjC462Hwqv31JCB6NfGO
 Hynw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792251620; x=1792856420; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GTWxiZskUl0XXvZpBRWj60Fr6tzQkIOL7XZpEoquEAw=;
 b=zKfyqy/3a8JoQpgr19C+GgSPrq8LoT5RlsuX7ERJm8wTnldvh/LRe81QX3E+SyMJTJ
 rUfkpTnfkzbRZhYgPt74TftjY65Ea2TkBzx/XxL8Rk3O96DpaxMNCkXsQy/NR3DDZeVU
 wiJb1xbTNaq13rwCcwl0uQu5qdYcMn+slFkpBQ4Qy/BFexs8SEOV8OJpkIl+Bijxg/BL
 Q9h8Aovtrs2D/OtsIVdK5C6IpEjQHjIVjhA+TmWTrk92zAVsfG178f/61hk+RhrfjXtG
 URUK9UE/PGQPC2dVV1czEmnT9lO/fT56PM/NODuYxMYhc5YwJ5j3NCQZeWfSy2OkPKzo
 NWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792251620; x=1792856420;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=GTWxiZskUl0XXvZpBRWj60Fr6tzQkIOL7XZpEoquEAw=;
 b=g1VehB5hOZmVjom7yueyM+et86MzW+gEimvKC4Ig7H0UbG+q9vcTYACw2Xp8D1Fk3/
 YWzBeFHLtxRNEl/34unToupCIQKiPJ5Stchmm1Ps/HxZ3iuEGvOIo6JHQqUpQKZWdt/E
 hDhOBY2hhe6uMQABCN9y5rtJ7yqEMIjKUL8TzTKZkMemFoPWwAD7WrdkeX77eaFRlu/Z
 ofDue0Z9jMhPiAx7RMpvow1zltyT9D2a39NVyNQ+YQazXPVVM3BWOAKy7sjPpqU6jLP4
 FU8pPXyennGlPyXigaunY/xz5YVumEDkTDVDO+vyurNfTc4VjOkfifRKbVi4ey10gkU5
 JdqQ==
X-Gm-Message-State: AFq9FYJ2Fti670Ehy69gGeDF2wrHxRjGMwVy6jbEzj8luE3MXS3/4QRu
 FMv0whLBksbnTjMEV4S8JEofkjZSObRP5pf5n+AV1Dphyxkj4xCP4lu9m9tx2iREeiUA7QEYhTV
 n8eLdIP/oqXFcerQMnFakDWuRdWvT47V6du7vBgK0ig==
X-Gm-Gg: AYBFou0mwxezmtKygsVvcJqJ3kKAs35IbxUaCeBa4k9+6yTEUgkei7HnaKhjoG1EnEV
 xR3LAGxh8/K/NLCsq/Qe5gsWSU+Qdv2L3Cn5j9/ULtTeWq3gShBkg3W/tqNuYR6lcqJeWTCBT6q
 NoCmzcWW5CF1985mnGljKE7NeteszCEUQz4d8sIf3qKQPtb1zguoL6TD3bl20Z+dpR4mfi07mDs
 /ZiF6BrEb2iGzSjKMpBhPPk5MEy/6idiRx6E6mwcb5Wt09HAfT5poHM8lmJZtV2F+M3YuqMC0ug
 RZgNrlg45d0FtAHktD3GU2HPzEg2pshb+V4qpE47Hu0pq1kYAwbH4WpPgZLyQ8+NIJHoUf1xI3K
 9NCtwgomwjbkIlru7hwXKhNLo/LWEsmQyGOwAz3Q=
X-Received: by 2002:a05:690c:e3c2:b0:8ae:58b9:f3f4 with SMTP id
 00721157ae682-8b0f2183607mr11625197b3.31.1792251620406; Sat, 17 Oct 2026
 08:40:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA85iTUU=Pf8h-Ojc3jiBbW44V-1XRheVW=JqN-4xNLc=Q@mail.gmail.com>
 <CAGaQodL0CNKahvtmSj3ssbZpVdXZEEZ_oR=Pcbr=Gnh-jUmaWw@mail.gmail.com>
In-Reply-To: <CAGaQodL0CNKahvtmSj3ssbZpVdXZEEZ_oR=Pcbr=Gnh-jUmaWw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 17 Oct 2026 16:40:09 +0100
X-Gm-Features: AclHuK_xyOI897XYOdft3bXhz3GWO8j8TG5gBl_bdcl1qCnGHQ5ewaDpCiXuRl8
Message-ID: <CAFEAcA_vL+z3pxHV1PViyVwraTUTT_H45QtWBsJ6d0tbD7-Okg@mail.gmail.com>
Subject: Re: Re: Re: [PATCH v3 15/16] docs/system/arm/raspi: move PCIe/GENET
 from missing to implemented
To: Marcelo Manzo <marcelomanzo@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, philmd@oss.qualcomm.com, 
 pierrick.bouvier@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Sat, 17 Oct 2026 at 16:16, Marcelo Manzo <marcelomanzo@gmail.com> wrote:
>
> On 17 Oct 2026, Peter Maydell wrote:
> >
> > Does the system end up with the "msi_nonbroken" global set to
> > "false" or "true" ?
>
> It ends up true. aspeed_pcie_rc_class_init() sets msi_nonbroken, and
> class_init runs for every class at startup, so any qemu-system-aarch64
> has it set whichever machine is selected. That's why qemu-xhci ends up
> with MSI-X enabled and needs msix=off.

Whoops, that's a bug. It should be doing it on realize. I'll
follow that up with the aspeed maintainer.

-- PMM

