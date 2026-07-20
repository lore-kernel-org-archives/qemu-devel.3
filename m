Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F89C44520
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 11:43:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlmMx-0002ha-7w; Mon, 20 Jul 2026 07:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wlmMv-0002h6-Pu
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 07:41:09 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wlmMu-0001Po-Dt
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 07:41:09 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-80e24970f1dso49677157b3.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 04:41:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784547667; cv=none;
 d=google.com; s=arc-20260327;
 b=EbGvUMjdnYP/DFCjGZEt6mX3DEvZJiPldE5/cvKLJcatNAswP7HQduiIbkLNRAsfOM
 u+2f8Go4Mlz7zeXvJL6TD6Q16LA4hHv7rwPKgEgoi6WIGmZmqcPwoq8VsZixCEWYCbeb
 Erp2S+5ACdB1ljUseEliYdvu6vW2Y290bAKDKLUYlM7+Che+6BsldtOJmY3LBBGYGVNg
 b4op4jT1p6uUCagVX8nkcF5+ZuHPGCTQgQhcbtjD0xymsnjBEHarPLTaHv4XpQoNdIB9
 bvlsEl0sj0Xq23nbXFJGbX+3kJXZPl4KCTwzUPPKqoNTZioWzO7jzwaeXleidTK7X+U7
 j34A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QSUqbf52NBBuCC7IJl6m184vPqck3DyrBNqgII0nbsU=;
 fh=vWmEuRD+mf4wwxpF6BEmjY/L0Zb0w6Ufn7Jm0dWwipA=;
 b=Upde0kP1Q4X7nOICCSNjTKo2vDDcuCnoGLaHBrE2FRFDhbYnvdHnk26xmOVQb+5RYD
 195Oc4FsfNNtDOjuZylzYiGQOxyTtdYm9JdmQYGfzfisGDd2V0sw8+h4/jVAhbDJYEZL
 F38i2X9ETkUBqVj+c1hm5MHwn/HIhqtXZ/Vc5KI/+L72vsTWP9TNri1ErJcOYSlw7WWw
 SGLHwwDnBKy7H1DVurJ6tvPiDmlg/lQwYnlgwBLYmbyV7wJXYEEUuybGgl2sQDtBR0AI
 qqK2EvARB8tqkT12oeLipTvqoXwMK8EsVsDq670bTauT98YxTDeGvj6fiJDiQBUEOSUN
 UZ+A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784547667; x=1785152467; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QSUqbf52NBBuCC7IJl6m184vPqck3DyrBNqgII0nbsU=;
 b=bytO50q+coyuOQQSm//khFu5SL77Uwn3jnDLvsQpSBVicWDIGCQQv6cDr6oUMnZ01c
 Jz0FFOs1YbI70WoeQmsTj1fGKKrQOvdNQ94s7wUQeLVvlsYbNafXVytdpsGSMAQ76wqe
 rGe4T9koP2CwN3mesLyVv/LU81yyeZorkwiW65faz5X3fEx/vaT2LoVRJktwFP9vSZwQ
 yaYl3kp4XkclVEVFsYa6Nu3TKZRZhydYqhqpnpZ6xgXn3YP19YNJkI+yd8vMBbT1IOIV
 M+BOxCrEnGl94hu0CyZUSyzboqxrgqoqCvJCARX89/qjL53r4+JlIhjg7FbOOyrQ1DaJ
 9o7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784547667; x=1785152467;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QSUqbf52NBBuCC7IJl6m184vPqck3DyrBNqgII0nbsU=;
 b=gyjyT1J4xw/JsHLBJENhbLUAu03IcC4P6vl2yAuOdHGtvpXSTLWp0rD/7t8JRY1z2V
 Z+C7vArTstkVueteJaGu+KwhbpuP/Urz7mRQHY6F4xhwd8yaztoMli0KR86yrbUHxPTc
 5c9RtVuvDip2T0KfCJNH9hcEeQAkp8ksO05VzaJJgMJjFlB/Q/hKHstOsZnmD0Xd+tqI
 KR4eA8fDH0MXSBXBiXsa5UpWgiumWJhZ4xi0b//Ck9L7GJrKzFzPpvBfuH6CQOlXHmRI
 2Jk0mzhC6QIaJP27yzzHz8JGRGvmxM4lfyUoyIRVrtXRy/KyBR8mMlnuT7X5xEbR0Jmb
 Orow==
X-Gm-Message-State: AOJu0YwpXt/hOVW3Y1/bDT1qYruamR0jKimYCR9+c+Z+jsdDfCJ1SCk8
 MKjZ1uoQEuFQOWLTr31V5h1EM0OubPMJ6DY/SpdFVbqW/P0+pKv0F+UkbIZJyaK5e2w1csOSVJU
 QFAIBIhst7bcDUH3xDrNqErspYvH5BRs=
X-Gm-Gg: AR+sD13hB3DRXq6zSAOPZXLgvArnm6VGDS3UP1hJSMTJmb6ycYisj0d1MrPPSxgkvr2
 oqqu1g8ypXz9nmQPBpfh6+tRTiSFM6VEYtNZQKqt3CAmH2MPSGr7s57O9o/PbikP9TCt8ADXnfs
 3hcqsKMko2HhD3q1ZyCY6i+gTmniSm/DosxGrXP1+86jIG1ZgfEn3cXEEfpHDX58+8qX/bWoofI
 rFMiQn/7fJdZdFatcKJ83flr3aFMv6AAFw9f2tv78gIlFKutjRF3nXKV6Fb
X-Received: by 2002:a05:690c:4d83:b0:803:6bb9:1753 with SMTP id
 00721157ae682-81ef23e80demr37477017b3.21.1784547667038; Mon, 20 Jul 2026
 04:41:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260719211923.1079282-1-shentey@gmail.com>
 <20260719211923.1079282-2-shentey@gmail.com>
In-Reply-To: <20260719211923.1079282-2-shentey@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 20 Jul 2026 19:40:55 +0800
X-Gm-Features: AUfX_mxaZC2NG-tWCA1SdXr6eMCNpKsedT-9ffVEc1SX34vUNNYirPPWrS3k2mA
Message-ID: <CAEUhbmVe8+VdRq2QQF7eRTv7op+5TwO7ZpkOOnjJ00okgyUY1Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/sd/sd: Fix error case for CMD18
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 qemu-block@nongnu.org, Christian Speich <c.speich@avm.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yw1-x1129.google.com
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

On Mon, Jul 20, 2026 at 5:19=E2=80=AFAM Bernhard Beschow <shentey@gmail.com=
> wrote:
>
> In commit 468fa450a7e0 ("hw/sd: Switch read/write primitive to
> buf+len"), `sd_read_byte()` changed its contract to return the read size
> rather than the read value (and was renamed to `sd_read_data()`
> accordingly). In an error case, however, `sd_read_data()` returns 0 by
> means of `dummy_byte` which is the code for the old contract. Moreover,
> `sdbus_read_data()` asserts the virtual method `read_data()` (and thus
> `sd_read_data()`) to return a non-zero size, i.e. to make progress and
> not loop forever. Fix the code to behave like the "DAT read illegal for
> command" case.
>
> Fixes: 468fa450a7e0 ("hw/sd: Switch read/write primitive to buf+len")

Missing SoB ...

>
> ---
> cc: Christian Speich <c.speich@avm.de>
> ---
>  hw/sd/sd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>

Other than that,
Reviewed-by: Bin Meng <bin.meng@processmission.com>

