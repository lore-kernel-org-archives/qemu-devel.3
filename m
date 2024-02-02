Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71AE9C48291
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 16:48:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVwhQ-0006WW-7f; Fri, 02 Feb 2024 11:47:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVwhO-0006W8-Sy
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 11:47:30 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVwhN-0000By-AX
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 11:47:30 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-55f0b2c79cdso2964984a12.3
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 08:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706892447; x=1707497247; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EcUXBbTtMchfawxPaITGM7DwfiSqeenaYcEERiay7iM=;
 b=T4YbU+if8wgkrRLQzEIs6nFgHR2PKmRI9IoptesbgHpnmYWj4mevy7mqkgi7nYavzp
 QY4qUrPOrI9xlL4NjbO5ICT/VoH/uuFoLVL4zYeoJKa200hJ1RO1ufH/Px//Cp5bYCEp
 /7pCi68U8vCCEBkazceEJEBoQs8HGEiKM1BoEPuavHmzZdPEm/tI0nSffeVBazd+IuEl
 YkdqrftKm4Jn7oB4dHiJdErzbUyNj56l7STmXElEFntXMcx3Wb1KhJbblnmDgz1bfAM9
 8Kb04As/DIJAqyZ9Oz3SvqQ3MNdDaiSaQC+OcNoOlxSLz+TnoPlSwxM3dB/7glIpeTVz
 Il/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706892447; x=1707497247;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EcUXBbTtMchfawxPaITGM7DwfiSqeenaYcEERiay7iM=;
 b=cAxZA9tjSjdmZnnXZIt3LXsUF+iBfYPgwftqxa83iteReP7fr2yAIJyIAyJvMEdU9I
 f4Q/dacKidMSLHR7y0EgbZ7dm58by4RDaTmZ3ulcvPnB5XBYrqIGP7qqQFkbcK7fY+2V
 +VVsyT7Ls46ZepRkJSr675zc5Ibs6hm8iGnVHq3q6NyZNMeaMPaiOvjE/HIGdqX6XC0l
 affKw9eVqN1Ecg1+OFCbc8UzVoplKUfqf0mNF8PbEmehE/aUN9IU1FDUkWehrz/PE1G4
 JkiJ0HlCEjR1JG2v2XAqOjmA5NqWCGE5H7X87ezlMImzRe8dNQfqKuaBRfaAftEuUDHZ
 uw1Q==
X-Gm-Message-State: AOJu0YzPzcBrBIDkWzgXA3Hjg0mAXphoTAgBbxHSBX4E5Eb70zteXB4/
 XThgjysi7hKn3mTn9jGgUh3MQtlwBlmi0FKTqr0RQUXDBpoNIu1+/NLhzAsRPKGv5OW6Ih2ZDSK
 KMu/X9TsqyLqncC+XjpYufDuAnJ473ReGbJ48OA==
X-Google-Smtp-Source: AGHT+IGds9BKFLmIIzbx7i+wit5PzRbeY+upV2xwIXboi27QGA484SSe7DdmtbZ/Q+u3yFf9W3Vgu75re9py9kQtqI0=
X-Received: by 2002:aa7:df0e:0:b0:55f:95ac:d698 with SMTP id
 c14-20020aa7df0e000000b0055f95acd698mr146907edy.32.1706892447100; Fri, 02 Feb
 2024 08:47:27 -0800 (PST)
MIME-Version: 1.0
References: <20240202055036.684176-1-richard.henderson@linaro.org>
In-Reply-To: <20240202055036.684176-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Feb 2024 16:47:16 +0000
Message-ID: <CAFEAcA_5Pa=_C2FRbeo=G=rhyzo9FUMao-RMHa2UibzNmdw5wA@mail.gmail.com>
Subject: Re: [PULL 00/57] tcg patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, 2 Feb 2024 at 05:52, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit 14639717bf379480e937716fcaf1e72b47fd4c5f:
>
>   Merge tag 'pull-trivial-patches' of https://gitlab.com/mjt0k/qemu into staging (2024-01-31 19:53:45 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20240202
>
> for you to fetch changes up to 73e095fc71dfeb8f5f767d9ac71078e562d935b0:
>
>   target/sparc: Remove FSR_FTT_NMASK, FSR_FTT_CEXC_NMASK (2024-02-02 14:40:06 +1000)
>
> ----------------------------------------------------------------
> tests/tcg: Fix multiarch/gdbstub/prot-none.py
> hw/core: Convert cpu_mmu_index to a CPUClass hook
> tcg/loongarch64: Set vector registers call clobbered
> target/sparc: floating-point cleanup
>

Hi; I'm afraid this seems to have collided with the loongarch
pullreq that went in yesterday. It had a merge conflict, which
I tried making a resolution to, but that failed to build.
(I think the problem is some code which your pullreq wants
to modify was moved from one file to another.)

Could you rebase and resend, please?

thanks
-- PMM

