Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17BC2D74EEC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 15:58:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjJYA-0004U5-Qs; Fri, 23 Jan 2026 10:58:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjJY7-0004Sv-En
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:58:15 -0500
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjJY4-0005Gx-NC
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:58:14 -0500
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-79405b3485eso21461747b3.3
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 07:58:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769183891; cv=none;
 d=google.com; s=arc-20240605;
 b=fTiLfjru1253iG+VRer4B+1yaWHcudOmbHP5V4/wzsScGPE28yZW0RRewiMI3fh3wn
 D5rt8Yb6HfMtwEd5lrZBHx6heUll88wPeNufgXUZ54Raw/U78/IFyAnULdWhACWFjJ/E
 NPLbCn01x8WIn7flq9+huqH1SKba+TPIlmBLTYt6FI6g0TDfiV2y8R1a0zV6PE1btQ/1
 nLZeSNXUdUNK8MIIRPJStdJcUwzfP5fX7halKttT2vfCiU/Ap1Oe371y4+zirnsgq44B
 nWhkfrslkl/eKUpLoYli5DFZE7/L94O06F3ynpKXH7mNV2LWWKlSrhsxzv1hqUtFmco3
 2+aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qnyhCKvAmnwzyuAmyZlh7bkSr7R1henZTvKput1kHXg=;
 fh=B4e3tcZ5gdbO2ZJ05WGxBjUuJocrDIHmOJGzFuIS0nc=;
 b=H7nXkbr3hR2JnUchoMDVOlxUUSE8YuaNXp1oQj8q0uNabvq7P5ZgQ495PToq6HuAOT
 qQAxBi8joY2HZowAXI/eaN8CbWkxoRiu3GDYJt+es42UsHWkO7JxkJPaabzrxM8FMa+A
 RRA6DiAhtrL0guSZAt+wn7NgijbSMM5wxvj4i65gspfK7IdmMp4wTRk8v8GJhOkPP/Xx
 guyzOBI1yaQUZWRXQgqTOrfUl8/cyhjJ3dqL1FdE27gA1vD0TYLSSNC8Txkm7LYCRJFm
 ZSlcBTSFQPDUKTkM0gTAiZTv2U9Zvel/qJu8wajasEJP5+GASdX2A2vj3FNIGJh0ncbo
 DCSw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769183891; x=1769788691; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qnyhCKvAmnwzyuAmyZlh7bkSr7R1henZTvKput1kHXg=;
 b=xUGXC9El/Quv7SkoVM06FUD/v0eFdSRpfxorAtrPUOpuCOtutpiaZwPVwoIX+9eTnV
 v4JWkEWSdp4mVk9cMspiVh04NN0FOlflsvipFxSVP5ZOrcuGzRlQez/6yvWYqxdxBWg7
 jEQT30ZoaSs6Y+tGyrbJ1fcmyPgAawCJoxDz6tc6Vn1OX/LsmFSe1ApECOI8CLKh4410
 Jenvc7+YuO8q95u0KyMLEZjzzREk9Fa4I2aS/O8/M8mSrxZaH0REwQk2IN48T0WaUaa1
 Pirsp+9XgVUFfGB6/0Ux7k5Z2Wiga1r/FMRicxnZUZuEIcpNNAdxV9Sh3S+4M2pTI9U/
 YAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769183891; x=1769788691;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qnyhCKvAmnwzyuAmyZlh7bkSr7R1henZTvKput1kHXg=;
 b=pZlNqVCpnMBsQSLI+0HGz9+ASj3OYeXIviGsk14C5zw+flXJOB5xXi4QEQor3JKs5e
 bv0OpBwIFB5r4t17o4JlOdttlefa0hVeexkjhWV7jHGSGm46oVufS86ZCzk8QHud0r4+
 rycq3GnZZHvrOcpLkgHtK0q12GcrgpUSbG9riMsSZaRAMl3uXM1xAKV3+X9u6WUGwVJD
 0Hb4Hmzj18E204kZHQBghjqvy9mq4xtEalLiTn75NEtvJK8nHg5mvdMTxRH3DXNIhRXz
 kJbLtdgDt0GcqzuJERGrGj2MUCa8R9uvo7seqcr+oqSjtgxKUJu811eVG0wzKHL8LOMx
 S3mA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOL2SMVFw3S54Y7DrJ6teaVyWM6OKXQUM4qEEvZ4RSmHWKWbIGThz/5r2qkhd4VboBVbIxmUUT6bV1@nongnu.org
X-Gm-Message-State: AOJu0YxQqJ7eHOFbipHM0Ji7A1cpQHky6Iqvyuu5j2GEg46nxO77HdMc
 dOPLakPFepKm5ZDNRRv1DKd1V9NKgi/4jfbXWH0ES/LUISL0Acj6ZfRVVIXXnjBIhIko9PQddO2
 5V+CZNGKP16/AsNLBHA7V16uMkhW9Gus2HPrvx+OnMw==
X-Gm-Gg: AZuq6aLmBC5kSenR6MHAJN/UDmFgJQyZXGinEvV+qSxzf7lFTwcdTxDetqb/w1KHUeS
 c2MIsStH3n9KvjXD5SDbncDJsblZPVMm/6XWbvfU/H5lCL8l3lLRA/cSS0IMRjSaDiOwGrmit42
 uzihrSo2vtqXPrS+efTR2n0H4eGN6YNh3GzJxI5yL5QxB5vP1WVGbMxao7RWtoqyfXw89f3f15e
 StvqFi+WqUxn/KD1EkfTl2fs3Rcs33YkU3gphR9pV9zWo4GC5/o4afN/uP6bHiYMVBa0g==
X-Received: by 2002:a05:690c:81:b0:78c:5c75:c47b with SMTP id
 00721157ae682-794398f8426mr31038477b3.1.1769183891214; Fri, 23 Jan 2026
 07:58:11 -0800 (PST)
MIME-Version: 1.0
References: <20260123150921.17891-1-deller@kernel.org>
 <20260123150921.17891-4-deller@kernel.org>
In-Reply-To: <20260123150921.17891-4-deller@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Jan 2026 15:57:59 +0000
X-Gm-Features: AZwV_Qg3mR-q7mHC9LULp81YfTCFqrHTTRj-a7Z5Edy1jKy3gJBDy2nGdyF2NP4
Message-ID: <CAFEAcA8X7NObV60MV_uKaRzo33iXUkRMty68iwftrfhcyWJ_sA@mail.gmail.com>
Subject: Re: [PATCH 3/3] linux-user: Fix MADV_XXX constants on hppa target
To: deller@kernel.org
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Fri, 23 Jan 2026 at 15:11, <deller@kernel.org> wrote:
>
> From: Helge Deller <deller@gmx.de>
>
> Older hppa binaries may still use the old MADV_XXX constants for the
> madivise() syscall. Fix it up in the same manner as it's done in the
> Linux kernel in the parisc_madvise() function.

"Remove this wrapper in year 2025" it says :-)

> Signed-off-by: Helge Deller <deller@gmx.de>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

