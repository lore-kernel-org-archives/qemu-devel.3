Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE987C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 16:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uht5K-0005QL-De; Fri, 01 Aug 2025 12:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhrip-0008KU-A1
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:31:11 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhrin-0005x6-S3
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:31:03 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-7183d264e55so24503227b3.2
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 08:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754062260; x=1754667060; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pJulOTTrjJtwU2BrgU4KwZ2q5m1EXrSLjfLkOcvGvJI=;
 b=Fv8QrT1HAq8jjCJbKEDYa21KH7jp2ouCMEe/dnwKJAPAe2y4U51mf+ZwUJr2/hWjQa
 7bQifkJbxTZs9okL/nquK3oZkBXBgOD4+ZaZjifimZA2IYsz7QeHwVBv63F+pVAbK8Db
 Uq6ECtxZqEztJF89gMgoD0gC1dzjySjz3EvrXOHBDXCFhYZmh7Cc8Y6n3bjpa6UqK8zi
 tqLKqo6lxz8zUV3RLVL/FzxfU5zVDTwrzbrhRz6E2aLDXw3SKgD6agHZSTUVrNKWG8Wt
 zPld+gECKYHSS/oPsRblTbaJ007PEsuzOfd67VCeN07ozy5kfBHnOlU3C1YbGBHz7NfJ
 yxtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754062260; x=1754667060;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pJulOTTrjJtwU2BrgU4KwZ2q5m1EXrSLjfLkOcvGvJI=;
 b=jmf5MR/DgUPaStSwgpLyieuwFA9aRpZSeWxCsoLDKaWQwGEBnBmizh7Qg3YMX4y9s5
 IWFaB8LNjVoiYYxXFaHrgbHWNRCJKsYm4t4PILWLfFtKeO2qZueYqdQGmWo+Jafq5G2G
 LCFK19EfZCQ2RY2VprgX1z5849QlM86+yvptB0oAo1739CjmuT/ec4Iz9o81r3aeAqvh
 cPXEnt2L/Cz5a0toghsm2AmQNa+fU2D2do8h//NOYon3gPfKRUrBp960raMB76fKALpR
 wC4VpALkt9uecLyjfrBFSViB7lsgIsXUuiCtyy8pEkKc8ZvMFCL2tmiJbb4UWVeCNpxe
 p6Wg==
X-Gm-Message-State: AOJu0YyJZ80p/m+eguFUAbxZxM0jE4H1a5dNdvTCdwjlqlH55qdX36iV
 7EnJAyK/CZUgISqvqtXdhNa7fH+Jcx8MGAj7rPB99rx742aej3Sc4Clh2bpvoIupiQvGoG42Ihw
 qrWCkkCpiJxYDky+TxknwMUvhqJp3/vG5KiwnasGVuA==
X-Gm-Gg: ASbGncvEYYJ4pzP59ot5FR/HbjA3NGcs6nJMLX9PzeT/dCdTqadojXKoTYyT28sUdvz
 yqedriGAxuxA8fULE88Ex6TXc8GmdvzhVsj59tsJvyhrv46dxXogLRE7MKbb2MlxqXyH3rS6yj6
 4yXcY3sr4/hDXHBkOv8RrLhtzyIQ65iLC3c0FKEmUL41QtfHOPCar7b8G5M31GzMDlgmUmebEnp
 UfcEP9w
X-Google-Smtp-Source: AGHT+IEcO+F+sv3/l/MTu1A6Q5k7NwAp3faxmwnEEB2okLLHhXKP5y2uAXbgH9+cS++tV7+ZMfKH/uyPtc3QCPPtVhI=
X-Received: by 2002:a05:690c:d:b0:71a:195b:707e with SMTP id
 00721157ae682-71b7ed16ca9mr1030677b3.1.1754062260310; Fri, 01 Aug 2025
 08:31:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-17-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-17-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 16:30:48 +0100
X-Gm-Features: Ac12FXxozTXNAOMbC4iBtrTj2MKpcBKXZYyhCrM_fku15GbJ0eJUC_ZB3wv5TGU
Message-ID: <CAFEAcA8zPxc4EhRfgYp4k94QjiUB8TO00h4x_GRX=pV2dnmR=g@mail.gmail.com>
Subject: Re: [PATCH 16/89] linux-user/loongarch64: Create get_elf_platform
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Wed, 30 Jul 2025 at 01:35, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Move the string literal to a new function.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

