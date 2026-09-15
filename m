Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D334DC88E7F
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6V1q-0006m2-AY; Tue, 15 Sep 2026 11:25:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6V1n-0006lL-R5
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 11:24:59 -0400
Received: from mail-yx2-x11.google.com ([2607:f8b0:4864:41::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6V1l-0004Lz-LE
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 11:24:59 -0400
Received: by mail-yx2-x11.google.com with SMTP id
 956f58d0204a3-66e56a1fe3fso3320075d50.3
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 08:24:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789485896; cv=none;
 d=google.com; s=arc-20260327;
 b=bDO7mXAHlli9di4jbmgNIdHoMVjz2VsRpLU9X98WjIc2OW5VhMgRQgpu3WVuRMLZ9G
 OozDY2/RiMZU4zrG4gENCsNnKQNH+Bb9N8/xr0+vQ/DHlCZngHlfCRO2+QOvD6JwN0Fr
 YTqVtM+KlifYsWo1HAfBawNDrxHndKvh5mXsw97AFgE4Duh5nVFaE3pTlEd4GqFlCwzc
 Ag382n7BxjVeTldfLAuzJydYvyJdQlsIGjf+7SI0WQ5NnnHLVWvnQGVRyiHPrACIppl9
 JmWlu+S+wsUui7j3tISkNwzBYHTQRLivV/K0B5E2QUSMBX1EDgMKkVMmd39+5fxLIsg+
 wmLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=f39LRX6t5miX88Vb9pSej9Bo7WXHts2Zw12vmv6/pc8=;
 fh=gicmf1zLCz5mLo37/slHRwiGNwG9FuwwhzHTeCt9t94=;
 b=Umf7UzwO9Q4cZi3FSSsUcOQL0wL7gywa3LUsFNC1EFai76PcnVxp/FyJpCPiVmR3mp
 BJa4CUji96LPkUyiqZIVaiWqQs/T1g6ksbLw8wklXjw8BZLFyDKpNLBXczpt01AveYq+
 zZvzllUb6se2Z3TME5yjMP4OohewOXWnskqps05H1tsKkVsV8WI9pXU7PI8dthXSmgcb
 yyFZehhiPNxGUQL1HB4cRRkuIaKuXsC8gwP9u4pqmz5b7yCDQI1BjH0ivIVtbpy+vEeP
 6842as0YJ3MpbMGoFWV3rMrRvMCqC4O9tQ6j7jwq9BxFpNlOslY8rm777ENB/g+N8ySd
 Mu8A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789485896; x=1790090696; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=f39LRX6t5miX88Vb9pSej9Bo7WXHts2Zw12vmv6/pc8=;
 b=nL7SRXFf8xH054AUbqjlceI37FymKw4npt+Ek0aP80AbLKEm9QIaWmF4Alg0MKyqFS
 mvMmJrMoWp6MHtlN6NJj1n1RtXWb+MGZZ+8LM/Gts9OvTqRL2f6ZWwuDj73GyjbcZkte
 RptnjPudGusib95EIxASI/8anxslRrm5HAvtvq/lLGAl8CuAYI4z7fQ7gdBSx3x26M4j
 1jrf7FsB40hka/MxegmMoEsZBshwxXIHcVI8MFmxwarVYQsosnSG1wicmXQ4BMKnt546
 fx7TfuEPUv9OFJIzOUlDPz84uZbCg6NPb1jDm+Te1D6JJDmfCdhew3Q+Lg2+bOuKqAHe
 v5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789485896; x=1790090696;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=f39LRX6t5miX88Vb9pSej9Bo7WXHts2Zw12vmv6/pc8=;
 b=adcMKTxo732vZM8IIRPAPAaQHDbp2KUER3Eke0/I4nGYJryw2mHQLG9vLHt0orINww
 Znp2ch2jjnl5paBpZOs2EV3w/WKVIcnHv9PEEhMnVMMUSbdovORpAXpXNlziQ4+vYrSy
 SkNAg/Uuyy1E3pJgju3wAle0OWHD93ZrcpTazBwI4B4tPNECP4fxA7r0nAOfDSme1BeK
 ojIJX+3vyla0jhwi1hHlpQVTsMxEpdWoYQHnx21GuuwafxgTnmqbBhJyTNeSkWNVPS8p
 zFvULtvVAo57TwriYCJ8ByIsPCgHLyPES67gWAJa/FmTWTot53/WyoHU2NB0Xg9ukJLQ
 8tDg==
X-Gm-Message-State: AFuF++lrcTWdLGWljlZcQyCj4A8JGheRQMOkwHDRxFbFhWsuEAbGJl0P
 AzAhI+X7PVrkDFQYlYJ0pD1XxHVBJSI4euy9uodQMf/F+9GGFAkQ7+bZcbRW0BTNEISLZxaFhgq
 ExntfBYcH7erafHKLRzrZd0wDCAbwcYRy65a9WcT+wg==
X-Gm-Gg: AYBFou3959gCDIt6xo6S626f1zkeqkHHU126ARVYihoIsnQmzH42x0hmHZCIlwXpx48
 wKJdLRP8FEqCi91v8jo5b+WaaU6cNAgxchY4+CbPYkPRqGxUsb10JufXpkpyVfnPErg/DnpzIO0
 8BmgssjZZj4pU/e1aB4eblIno6NJef/T+QPzeKkB2GO0LKDjmmJaYkR74+Ta60bSSxjkNZzo0B2
 sheH8hKewFJDn73ZezpxHxea/fsz3VoR2acXm07N/+LeRIlufIrtr/z2C2BW/eKgrDelcmF3hLI
 93yYmuIc5L/syh4EH5aiZen0qdY1jbPLY8Nvi6zV7/9KTdZZgmPOcjN1HDXjHSUpp3dtHom+cG+
 u7d6ASNbdzBe4CV9fcFoD2kgc
X-Received: by 2002:a53:ac87:0:b0:66f:c8e4:f013 with SMTP id
 956f58d0204a3-6714e060f40mr2664831d50.50.1789485896076; Tue, 15 Sep 2026
 08:24:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260913-allwinner-gpio-v3-0-a9affa474b3b@gmail.com>
 <20260913-allwinner-gpio-v3-1-a9affa474b3b@gmail.com>
In-Reply-To: <20260913-allwinner-gpio-v3-1-a9affa474b3b@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 Sep 2026 16:24:43 +0100
X-Gm-Features: AcwNN1WP3f-o7iYou4z1A14ofObFQq9Hfo6kxvOpKfuHL4OkdG-PTuKJ64_fHFs
Message-ID: <CAFEAcA-TOjsMHDpThkBP_Mjbt+gA23SoXabOpAUVMdoFbRGjow@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] hw/gpio: Allwinner A10 GPIO emulation
To: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Jack wang <163wangjack@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:41::11;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sun, 13 Sept 2026 at 19:17, Strahinja Jankovic
<strahinja.p.jankovic@gmail.com> wrote:
>
> This patch implements Allwinner A10 GPIO peripheral emulation.
>
> The emulation focuses on input/output and interrupt functionality,
> whereas the drive and pull up/down functionality is not emulated.
>
> Signed-off-by: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>

> +static inline void allwinner_gpio_update_all_output_lines(AWGPIOState *s)
> +{
> +    for (int port = 0; port < AW_GPIO_PORTS_NUM; port++) {
> +        port_update_output_lines(s, port);
> +    }
> +}

This doesn't compile on clang because this function has no callers:

../../hw/gpio/allwinner-gpio.c:257:20: error: unused function
'allwinner_gpio_update_all_output_lines' [-Werror,-Wunused-function]
  257 | static inline void
allwinner_gpio_update_all_output_lines(AWGPIOState *s)
      |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1 error generated.

Should it be being called somewhere, or is it just a leftover
from an earlier revision of the series?

thanks
-- PMM

